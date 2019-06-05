class PopulateCarProviders < ActiveRecord::Migration[5.1]
  DEFAULT_PROVIDERS = ['Aste Peugeot Viña', 'Aste Peugeot Valpo', 'H. Motores S.A. Viña', 'H. Motores S.A. Valpo',
                       'H. Motores S.A. Belloto', 'H. Motores S.A. Quillota', 'Aspillaga y Hornauer Viña',
                       'Aspillaga y Hornauer Quillota', 'Kaufmann Viña', 'Kaufmann Placilla', 'Fronza Valpo',
                       'Fronza Quillota', 'Kovacks', 'Clientes', 'Otros'].freeze
  def change
    DEFAULT_PROVIDERS.each do |provider|
      CarProvider.create!(name: provider)
    end
  end
end
