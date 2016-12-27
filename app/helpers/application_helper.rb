module ApplicationHelper
	def number_to_currency number, options={}
		result = super(number, options)
		if result.present?
			result.delete!(" ")
		end
		return result
	end
end
