# frozen_string_literal: true

# O único ponto de entrada de todas as customizações e extenções que precisar para a aplicação
class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class
end
