sekiheki_event = Event.find_by!(name: '赤壁の戦い')

EventPerson.seed(:id,
  { id: 1, event: sekiheki_event, person: Person.find_by!(name: '諸葛亮') },
  { id: 2, event: sekiheki_event, person: Person.find_by!(name: '曹操孟徳') },
  { id: 3, event: sekiheki_event, person: Person.find_by!(name: '孫権') },
  { id: 4, event: sekiheki_event, person: Person.find_by!(name: '周瑜') },
)
