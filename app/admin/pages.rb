ActiveAdmin.register Page do
  config.filters = false
  permit_params :title, :slug, :content

  form do |f|
    f.inputs do
      f.input :title
      f.input :slug, hint: "Use 'about' or 'contact'"
      f.rich_text_area :content
    end
    f.actions
  end

  show do
    attributes_table do
      row :title
      row :slug
      row :content do |page|
        raw page.content.body.to_s
      end
    end
  end
end
