# Sistema de Cadastro dos Bixes

Esse é o sistema de cadastro de bixes usado na semana de recepção do IME USP. Esse sistema é usado para cadastrar os bixes e definir um time para cada bixe.

Os dados dos bixes são: Nome, Email, Telefone, Curso, Contatos de Emergencia e Sensibilidades (como alegias, por exemplo).

# Para usar

Para rodar o sistema, siga os passos abaixo:

1. Clone este repositório usando o comando `git clone https://github.com/usuario/cadastro-bixes.git`.
2. Entre no diretório do projeto usando o comando `cd cadastro-bixes`.
3. Copie o arquivo `.env.example` para `.env` e configure as variáveis de ambiente necessárias.
4. Use docker-compose para executar o sistema com um simples `docker-compose up`.

# Recomendações para produção

Se deseja colocar o sistema de cadastro no ar para a sua semana de recepção, aqui há algumas recomendações:
- Atualize as páginas `app/models/confirmacao.rb` e `app/assets/stylesheets/application.scss` para atualizar os times e suas cores.
- Use a lista do caça (a lista dos que passaram na FUVEST e ENEM USP, por exemplo) para popular a lista base de nome dos bixes.
