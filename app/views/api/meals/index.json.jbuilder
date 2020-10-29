#json.meal do |json|
  json.array!(meals) do |meal|
    json.extract! meal,  :title, :content
  end
#end
#json.extract! @meals, :id, :title, :content
#json.set! :key, 'value'


#json.text "text"