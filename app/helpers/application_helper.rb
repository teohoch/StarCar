module ApplicationHelper
  def flash_message(type, text)
    flash[type] ||= []
    flash[type] << text
  end

  def render_flash
    rendered = []
    flash.each do |type, messages|
      if messages.is_a? Array
        messages.each do |m|
          rendered << render(:partial => 'layouts/flash_message', :locals => {:type => type, :message => m}) unless m.blank?
        end
      else
        rendered << render(:partial => 'layouts/flash_message', :locals => {:type => type, :message => messages}) unless messages.blank?
      end
    end
    html = rendered.join.squish
    html.html_safe
  end

  def bootstrap_class_for(flash_type)
    {success: 'alert-success', error: 'alert-danger', warning: 'alert-warning', notice: 'alert-info', alert: 'alert-danger'}[flash_type.to_sym]
  end

  def action_button(object, action: :show, text: nil, button_class: nil, data: {}, verb: :get, path: nil, field: 'id')
    case action
      when :show
        css_class= button_class.nil? ? 'btn btn-info' : button_class
        text = (text.nil? ? t('decorator.show') : text )
        path = (path.nil? ? object : path)
      when :edit
        css_class= button_class.nil? ? 'btn btn-warning' : button_class
        text = (text.nil? ? t('decorator.edit') : text)
        path = [:edit, object ]
      when :delete, :destroy
        css_class= button_class.nil? ? 'btn btn-danger' : button_class
        text = (text.nil? ? t('decorator.delete') : text)
        path = object
        verb = :delete
        unless data.has_key?('confirm')
          data['confirm'] = tp("are_you_sure.delete", object.class.human_attribute_name("pronoun"), klass: object.class.model_name.human)
        end
        unless data.has_key?('title')
          data['title'] = t('are_you_sure.base')
        end
      when  :create
        css_class= button_class.nil? ? 'btn btn-primary' : button_class
        text = (text.nil? ? t('decorator.create') : text)
        path = [:create, object ]
      else
        css_class= button_class.nil? ? 'btn btn-default' : button_class
        path = path.nil? ? [action, object] : path
    end

    case verb
      when :post
        render partial: 'button_form', locals: {object: object, path: path, text: text, field: field, css_class: css_class, data: data, verb: verb}
      when :put, :patch
        raise ArgumentError 'This function should NEVER be used with put or patch. Only use it for simple actions.'
      when :get, :delete
        link_to text, path, class: css_class, method: verb, data: data
      else
        raise NotImplementedError
    end
  end

  def translation_pronoun(phrase, pronoun, *args, &block)
    if I18n.exists?([phrase,pronoun].join('.'))
      arg.insert(0,[phrase,pronoun].join('.'))
    else
      args.insert(0,phrase)
    end
    t(*args, &block)
  end
  alias_method :tp, :translation_pronoun


  def datatable_language
    if I18n.exists?('table_text.sInfoFiltered')
      {
          :sProcessing => t('table_text.sProcessing'),
          :sLengthMenu => t('table_text.sLengthMenu'),
          :sZeroRecords => t('table_text.sZeroRecords'),
          :sEmptyTable => t('table_text.sEmptyTable'),
          :sInfo => t('table_text.sInfo'),
          :sInfoEmpty => t('table_text.sInfoEmpty'),
          :sInfoFiltered => t('table_text.sInfoFiltered'),
          :sInfoPostFix => t('table_text.sInfoPostFix'),
          :sSearch => t('table_text.sSearch'),
          :sUrl => t('table_text.sUrl'),
          :sInfoThousands => t('table_text.sInfoThousands'),
          :sLoadingRecords => t('table_text.sLoadingRecords'),
          :oPaginate => {
              :sFirst => t('table_text.sFirst'),
              :sLast => t('table_text.sLast'),
              :sNext => t('table_text.sNext'),
              :sPrevious => t('table_text.sPrevious')
          },
          :oAria => {
              :sSortAscending => t('table_text.sSortAscending'),
              :sSortDescending => t('table_text.sSortDescending')
          }
      }.to_json.html_safe
    else
      nil
    end
  end

end
