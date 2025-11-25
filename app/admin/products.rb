ActiveAdmin.register Product do
  # Avoid Ransack issues with ActiveStorage
  config.filters = false

  permit_params :name, :description, :price, :category_id, images: []

  form do |f|
    f.inputs do
      f.input :name
      f.input :description
      f.input :price
      f.input :category

      # ActiveStorage-safe multiple upload
      f.input :images, as: :file,
                       input_html: {
                         multiple: true,
                         name: "product[images][]"
                       },
                       required: false
    end

    f.actions
  end

  show do
    attributes_table do
      row :name
      row :price
      row :description
      row :category

      row :images do |product|
        product.images.each do |img|
          div do
            if img.variable?
              image_tag img.variant(resize_to_limit: [200, 200])
            else
              image_tag url_for(img)
            end
          end
        end
      end
    end
  end
end
