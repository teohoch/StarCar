ActiveAdmin.register Repair do
  belongs_to :car

  actions :all, except: [:create, :new]

  controller do
    def destroy
      destroy! do |success, failure|
        failure.html do
          flash[:error] = resource.errors.full_messages.to_sentence
          render action: :show
        end
      end
    end
  end

end
