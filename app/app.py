import json, os, pika
from dotenv import load_dotenv

load_dotenv()

email       = os.getenv("EMAIL")
token       = os.getenv("TOKEN")
accountid   = os.getenv("ACCOUNTID")

def callback(ch, method, properties, body):
  
    message = json.loads(body)

    sys                     = message['domain'].split(".")[0]
    cloudflare_forward_mail = "admin@" + message['domain']
    cloudflare_worker_rote  = "*." + message['domain']
    cloudflare_worker_url   = sys + ".igor-alcantara.workers.dev"
    
    # Criar o arquivo de variáveis do Terraform
    with open("terraform.tfvars", "w") as f:
        f.write(f"cloudflare_email=\"{email}\"\n")
        f.write(f"cloudflare_token=\"{token}\"\n")
        f.write(f"cloudflare_account_id=\"{accountid}\"\n")
        #f.write("}\n")
        f.write(f"cloudflare_forward_mail=\"{cloudflare_forward_mail}\"\n")
        f.write(f"cloudflare_sys=\"{sys}\"\n")
        f.write(f"cloudflare_zone=\"{message['domain']}\"\n")
        f.write(f"cloudflare_worker_rote=\"{cloudflare_worker_rote}\"\n")
        f.write(f"cloudflare_worker_url=\"{cloudflare_worker_url}\"\n")

    if message['tf'] == "apply":
        # Executar o Terraform
        output = os.system("./terraform  init -upgrade")
        output = os.system("./terraform apply -auto-approve")

   
    if message['tf'] == "destroy":
        # Executar o Terraform
        output = os.system("./terraform  init -upgrade")
        output = os.system("./terraform destroy -auto-approve")

# Conectar-se ao RabbitMQ
credentials = pika.PlainCredentials(os.getenv("RABBITMQ_USER"), os.getenv("RABBITMQ_PASSWORD"))
parameters = pika.ConnectionParameters('rabbitmq', 5672, 'default', credentials)
connection = pika.BlockingConnection(parameters)
channel = connection.channel()

# Declarar a fila
#channel.queue_declare(queue='aalc_init')

# Registrar a função de retorno de chamada
channel.basic_consume(queue=os.getenv("RABBITMQ_QUEUE"), on_message_callback=callback, auto_ack=True)

# Começar a consumir mensagens
print(' [*] Aguardando mensagens.')
channel.start_consuming()