module Api
  class RecordsController < ApiController
    def index
      @records = records_scope.with_range(params).order(date: :desc, time: :desc).includes(:user)
    end

    def show
      @record = records_scope.find(params.require(:id))
    end

    def create
      record = records_scope.new(record_strong_params)
      if record.save
        render json: record, status: :created
      else
        render json: { errors: record.errors }, status: :unprocessable_entity
      end
    end

    def update
      record = records_scope.find(params.require(:id))
      record.assign_attributes(record_strong_params)
      if record.save
        render json: record
      else
        render json: { errors: record.errors }, status: :unprocessable_entity
      end
    end

    def destroy
      record = records_scope.find(params.require(:id))
      record.destroy
      render json: nil, status: 200
    end

    private

    def records_scope
      if current_user.admin?
        Record.all
      else
        current_user.records.all
      end
    end

    def record_strong_params
      if current_user.admin?
        params.fetch(:record, {}).permit(:user_id, :date, :time, :meal, :num_of_calories)
      else
        params.fetch(:record, {}).permit(:date, :time, :meal, :num_of_calories)
      end
    end
  end
end
