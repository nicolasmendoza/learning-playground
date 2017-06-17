require 'nokogiri'
require 'open-uri'
require 'json'

# Public: Subte/subway service from Buenos Aires city. (this is an experiment..:P)
#
# Examples
#   get_subte_status()
#   # => [ { "name": "Línea B", "service": "Normal"}]

# Returns array of statuses.
def get_subte_status
  begin

    url = 'http://www.metrovias.com.ar/'
    html = open(url)
    subtes = []

    # fetch and parse HTML document
    doc = Nokogiri::HTML(html)
    doc.css('section#linesStateSection div table.table tbody tr').each do |lineRowTable|

      if lineRowTable.at_css('td.estado')
        subte_name = lineRowTable.css('td')[1].text
        subte_status = lineRowTable.css('td')[2].css('div span')[1].text
        subtes.push(
            name: subte_name,
            status: subte_status,
        )
      end

    end

    return subtes
      # bad practice...but this code is only an example, remember catch/rescue explicitly (python Zen? :-D)
  rescue Exception => e
    puts 'Sorry about this...', e.message
  end
end

puts "Ruby is a great scripting language, beautiful and very productive."

puts JSON.pretty_generate(get_subte_status())
