require 'google_drive'
require 'dotenv/load'

class GoogleSheetsService
  def initialize
    @session = GoogleDrive::Session.from_service_account_key("config/google_sheets.json")
    @spreadsheet = @session.spreadsheet_by_key(ENV['GOOGLE_SHEETS_KEY'])
  end
  
  def already_registred?(bixe, worksheet)
		worksheet.rows.any? { |row| row.include?(bixe.id) }
  end

	def worksheet_for_team(team_name)
		puts @spreadsheet.worksheets.map(&:title)
		@spreadsheet.worksheets.find { |worksheet| worksheet.title.downcase == "time #{team_name}" }
	end

  def add_confirmation(bixe)
		puts "Adding confirmation for #{bixe.nome}"
		puts "Team: #{bixe.confirmacao.team}"
		puts "loking for '#{bixe.confirmacao.team}'"
		worksheet = worksheet_for_team(bixe.confirmacao.team)

		puts "Worksheet: #{worksheet.title}"

    return if already_registred?(bixe, worksheet)
		
		# Insere o registro na planilha
		# A fila de zeros é para as pontuações de cada uma das modalidades
		# Por padrão, eviamos 0 pontos para cada modalidade, sendo 12 modalidades 
		# A última coluna é a soma das pontuações de todas as modalidades
    worksheet.insert_rows(worksheet.num_rows + 1, [[
      bixe.id,
      bixe.nome,
      bixe.curso,
      bixe.confirmacao.team,
      bixe.confirmacao.created_at,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			"=SUM(F#{worksheet.num_rows+1}:Q#{worksheet.num_rows+1})"
    ]])
    worksheet.save
  end
end
