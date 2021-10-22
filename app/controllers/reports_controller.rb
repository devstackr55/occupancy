class ReportsController < ApplicationController
    before_action :authenticate_user!
    
    def top_gaining_projects
    end

    def losing_projects
    end

    def total_invoice_amount
    end

    def employee_reports
    end
end
