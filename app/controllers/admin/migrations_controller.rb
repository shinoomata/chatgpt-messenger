class Admin::MigrationsController < ApplicationController
    def index
        if Rails.env.production?
          ActiveRecord::Base.connection.migration_context.migrate
          render plain: "Migrations ran successfully"
        else
          render plain: "This action is only allowed in production"
        end
      end
end
