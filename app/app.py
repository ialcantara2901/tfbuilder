import json, os, pika
from dotenv import load_dotenv

load_dotenv()

email       = os.getenv("EMAIL")
token       = os.getenv("TOKEN")
accountid   = os.getenv("ACCOUNTID")

# RabbitMQ Queue
rabbitmq_queue = os.getenv('RABBITMQ_QUEUE')

# Conectar-se ao RabbitMQ
credentials = pika.PlainCredentials(os.getenv("RABBITMQ_USER"), os.getenv("RABBITMQ_PASSWORD"))
parameters = pika.ConnectionParameters('rabbitmq', 5672, 'default', credentials)
connection = pika.BlockingConnection(parameters)
channel = connection.channel()

# Declarar a fila
channel.queue_declare(queue='aalc_init')
channel.queue_declare(queue='aalc_init_out')

def callback(body):

    message = json.loads(body)
    #app                     = message.app
    #if app != "" :
    #    print(app)

    domain                  = message.domain
    sys                     = domain.split(".")[0]
    cloudflare_forward_mail = "admin@" + domain
    cloudflare_worker_rote  = "*." + domain
    cloudflare_worker_url   = sys + ".igor-alcantara.workers.dev"
    
    # Criar o arquivo de variáveis do Terraform
    with open("terraform.tfvars", "w") as f:
        f.write(f"cloudflare_email=\"{email}\"\n")
        f.write(f"cloudflare_token=\"{token}\"\n")
        f.write(f"cloudflare_account_id=\"{accountid}\"\n")
        #f.write("}\n")
        f.write(f"cloudflare_forward_mail=\"{cloudflare_forward_mail}\"\n")
        f.write(f"cloudflare_sys=\"{sys}\"\n")
        f.write(f"cloudflare_zone=\"{domain}\"\n") 
        f.write(f"cloudflare_worker_rote=\"{cloudflare_worker_rote}\"\n")
        f.write(f"cloudflare_worker_url=\"{cloudflare_worker_url}\"\n")

    if message['tf'] == "apply":
        # Executar o Terraform
        os.system("./terraform init -upgrade")
        os.system("./terraform plan")
        os.system("./terraform apply -auto-approve")
        output = os.system("./terraform output module.zone.name_servers")

        # Criar a mensagem de saída
        output_message = {
            "domain": message.domain,
            "output": output
        }   

    if message['tf'] == "destroy":
        # Executar o Terraform
        os.system("./terraform  init -upgrade")
        os.system("./terraform plan")
        os.system("./terraform destroy -auto-approve")

        # Criar a mensagem de saída
        output_message = {
            "domain": domain
        }
    
    # Enviar a mensagem de saída para a fila "aalc_init_out"
    channel.basic_publish(
        exchange='',
        routing_key='aalc_init_out',
        body=json.dumps(output_message)
    )

# Declarar a fila
channel.queue_declare(queue=rabbitmq_queue, durable=True)

# Registrar a função de retorno de chamada
channel.basic_consume(queue=rabbitmq_queue, on_message_callback=callback, auto_ack=True)

# Começar a consumir mensagens
print(' [*] Aguardando mensagens.')
channel.start_consuming()