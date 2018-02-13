require('pg')

class Bounty

  attr_accessor :name, :bounty_value, :danger_level, :favourite_weapon
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @bounty_value = options['bounty_value'].to_i
    @danger_level = options['danger_level']
    @favourite_weapon = options['favourite_weapon']
  end

  def save()
    db = PG.connect(
      {
        dbname: 'bounty_hunter',
        host: 'localhost'
      }
    )
    sql =
      "INSERT INTO bounty
      (
        name,
        bounty_value,
        danger_level,
        favourite_weapon
      ) VALUES
      (
        $1, $2, $3, $4
      )
      RETURNING *;"
    values = [@name, @bounty_value, @danger_level, @favourite_weapon]
    db.prepare("save", sql)
    @id = db.exec_prepared("save", values)[0]['id'].to_i
    db.close()
  end

  def delete()
    db = PG.connect(
      {
        dbname: 'bounty_hunter',
        host: 'localhost'
      }
    )
    sql = "DELETE FROM bounty WHERE id = $1;"
    values = [@id]
    db.prepare("delete_one", sql)
    db.exec_prepared("delete_one", values)
    db.close()
  end

  def update()
    db = PG.connect(
      {
        dbname: 'bounty_hunter',
        host: 'localhost'
      }
    )
    sql =
    "UPDATE bounty
      SET
      (
        name,
        bounty_value,
        danger_level,
        favourite_weapon
      ) =
      (
        $1, $2, $3, $4
      )
      WHERE id = $5"
    values = [@name, @bounty_value, @danger_level, @favourite_weapon, @id]
    db.prepare("update", sql)
    db.exec_prepared("update", values)
    db.close()
  end

  def Bounty.find(id)
    db = PG.connect(
      {
        dbname: 'bounty_hunter',
        host: 'localhost'
      }
    )
    sql = "SELECT * FROM bounty WHERE id = $1;"
    values = [id]
    db.prepare("find", sql)
    bounties = db.exec_prepared("find", values)
    db.close()
    return bounties.map {|bounty| Bounty.new(bounty)}
  end

  def Bounty.all()
    db = PG.connect(
      {
        dbname: 'bounty_hunter',
        host: 'localhost'
      }
    )
    sql = "SELECT * FROM bounty;"
    values = []
    db.prepare("all", sql)
    bounties = db.exec_prepared("all", values)
    db.close()
    return bounties.map {|bounty| Bounty.new(bounty)}
  end

  def Bounty.delete_all()
    db = PG.connect(
      {
        dbname: 'bounty_hunter',
        host: 'localhost'
      }
    )
    sql = "DELETE FROM bounty;"
    values = []
    db.prepare("delete_all", sql)
    bounties = db.exec_prepared("delete_all", values)
    db.close()
  end

end
