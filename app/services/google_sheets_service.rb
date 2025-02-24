require 'google_drive'
require 'dotenv/load'

class GoogleSheetsService
  def initialize
    @session = GoogleDrive::Session.from_service_account_key("config/google_sheets.json")
    @spreadsheet = @session.spreadsheet_by_key(ENV['GOOGLE_SHEETS_KEY'])
  end
  
  def already_registred?(bixe, worksheet)
		worksheet.rows?.any? { |row| row.include?(bixe.id) }
  end

	def worksheet_for_team(team_name)
		@spreadsheet.worksheets.find { |worksheet| worksheet.title.downcase == team_name }
	end

  def add_confirmation(bixe)
		puts "Adding confirmation for #{bixe.nome}"
		puts "Team: #{bixe.confirmacao.team}"
		worksheet = worksheet_for_team(bixe.confirmacao.team)

		puts "Worksheet: #{worksheet.title}"

    return if already_registred?(bixe, worksheet)
		
		return unless worksheet

    @worksheet.insert_rows(@worksheet.num_rows + 1, [[
      bixe.id,
      bixe.nome,
      bixe.curso,
      bixe.confirmacao.team,
        bixe.confirmacao.created_at
    ]])
    @worksheet.save
  end



  
end
