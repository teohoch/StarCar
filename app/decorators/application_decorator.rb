class ApplicationDecorator < Draper::Decorator
  def attributes
    model.attributes
  end

  def condensed_attributes
    attributes
  end

  def pretty_show(table_class: 'display table table-condensed table-responsive', title: '', extra_values: [])
    show_attributes = extra_values.concat attributes
    h.render partial: 'general_show',
             locals: { object: show_attributes, title: title, table_class: table_class, klass: model.class }
  end

  def condensed_show(table_class: 'display table table-condensed table-responsive', title: '', extra_values: [])
    show_attributes = extra_values.concat condensed_attributes
    h.render partial: 'general_show',
             locals: { object: show_attributes, title: title, table_class: table_class, klass: model.class }
  end
end

class ApplicationCollectionDecorator < Draper::CollectionDecorator
  def show_all
    h.render partial: 'index_table',
             locals: { collection: object, attributes: presentable_attributes, klass: object.model }
  end

  def presentable_attributes
    []
  end
end
