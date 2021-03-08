class AddCodeEvalVersionToLanguage < ActiveRecord::Migration[5.2]
  def change
    add_column :languages, :code_eval_version, :integer
  end
end
