# README

### Projeto Leituras

Objetivo: A ideia desse projeto é construir um sistema para organização de Leituras

___
### Etapa 1:
Cadastro de Livros simples: *Nome*, *autor* e *quantidade de páginas*
Tela básica padrão Rails com formulário contendo esses 3 campos.

**Resultado inicial:**

  1. Página de Listagem dos Livros:

  ![books](readme_images/first_step/books.png)

  2. Página de Criação do Livro:

  ![new_book](readme_images/first_step/new_book.png)

___
### Etapa 2:
Estudo das Páginas com Tailwind.

**Resultado inicial:**

  1. Página Inicial:

  [Página Inicial](https://play.tailwindcss.com/w4ZhfAZFoP)
  ![pagina_inicial](readme_images/second_step/first_page.png)

  2. Página de Login:

  [Página Login](https://play.tailwindcss.com/MMwQGl7zY5)
  ![pagina_login](readme_images/second_step/login_page.png)

  3. Página de Listagem:

  [Página Listagem](https://play.tailwindcss.com/D9GU9GhrLd)
  ![pagina_listagem](readme_images/second_step/list_page.png)

  3. Página do Livro:

  [Página do Livro](https://play.tailwindcss.com/3WFYKMOTPq)
  ![pagina_livro](readme_images/second_step/book_page.png)


___
### Etapa 3:
1. Configuração do Tailwind.

[Adicionando Tailwind em um projeto com Rails 7](https://dev.to/dnovais/adicionando-tailwind-em-um-projeto-com-rails-7-1hjo)

```ruby
bundle add tailwindcss-rails

rails tailwindcss:install
```

2. Alteração do Layout da Página de Listagem do Livro
