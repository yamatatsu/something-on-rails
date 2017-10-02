gi = Team.find_by(name: '魏')
go = Team.find_by(name: '呉')
shoku = Team.find_by(name: '蜀')

Person.seed(:id,
  { id: 1, user_id: 1, name: '劉備玄徳', team: shoku },
  { id: 2, user_id: 1, name: '諸葛亮', team: shoku },
  { id: 3, user_id: 1, name: '曹操孟徳', team: gi },
  { id: 4, user_id: 1, name: '悪来典韋', team: gi },
  { id: 5, user_id: 1, name: '孫権', team: go },
  { id: 6, user_id: 1, name: '周瑜', team: go },
)
