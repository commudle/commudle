class AddSlugToTables < ActiveRecord::Migration[5.1]
  def change

    add_column :data_form_entities, :slug, :string, unique: true
    add_column :data_forms, :slug, :string, unique: true
    add_column :events, :slug, :string, unique: true
    add_column :kommunities, :slug, :string, unique: true


    DataForm.all.each do |df|

      df.update(slug: df.name.parameterize)
      df.save

    end

    DataFormEntity.all.each do |df|

      df.update(slug: df.data_form.name.parameterize)
      df.save

    end

    Event.all.each do |df|

      df.update(slug: df.name.parameterize)
      df.save

    end

    Kommunity.all.each do |df|

      df.update(slug: df.name.parameterize)
      df.save

    end

  end
end
