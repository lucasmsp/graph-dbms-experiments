1- Criar uma coleção de 'documentos'

db.createCollection(name="Characters")

LET data = [
{ "name": "Ned", "surname": "Stark", "alive": true, "age": 41, "traits": ["A","H","C","N","P"] },
{ "name": "Robert", "surname": "Baratheon", "alive": false, "traits": ["A","H","C"] },
{ "name": "Jaime", "surname": "Lannister", "alive": true, "age": 36, "traits": ["A","F","B"] },
{ "name": "Catelyn", "surname": "Stark", "alive": false, "age": 40, "traits": ["D","H","C"] },
{ "name": "Cersei", "surname": "Lannister", "alive": true, "age": 36, "traits": ["H","E","F"] },
{ "name": "Daenerys", "surname": "Targaryen", "alive": true, "age": 16, "traits": ["D","H","C"] },
{ "name": "Jorah", "surname": "Mormont", "alive": false, "traits": ["A","B","C","F"] },
{ "name": "Petyr", "surname": "Baelish", "alive": false, "traits": ["E","G","F"] },
{ "name": "Viserys", "surname": "Targaryen", "alive": false, "traits": ["O","L","N"] },
{ "name": "Jon", "surname": "Snow", "alive": true, "age": 16, "traits": ["A","B","C","F"] },
{ "name": "Sansa", "surname": "Stark", "alive": true, "age": 13, "traits": ["D","I","J"] },
{ "name": "Arya", "surname": "Stark", "alive": true, "age": 11, "traits": ["C","K","L"] },
{ "name": "Robb", "surname": "Stark", "alive": false, "traits": ["A","B","C","K"] },
{ "name": "Theon", "surname": "Greyjoy", "alive": true, "age": 16, "traits": ["E","R","K"] },
{ "name": "Bran", "surname": "Stark", "alive": true, "age": 10, "traits": ["L","J"] },
{ "name": "Joffrey", "surname": "Baratheon", "alive": false, "age": 19, "traits": ["I","L","O"] },
{ "name": "Sandor", "surname": "Clegane", "alive": true, "traits": ["A","P","K","F"] },
{ "name": "Tyrion", "surname": "Lannister", "alive": true, "age": 32, "traits": ["F","K","M","N"] },
{ "name": "Khal", "surname": "Drogo", "alive": false, "traits": ["A","C","O","P"] },
{ "name": "Tywin", "surname": "Lannister", "alive": false, "traits": ["O","M","H","F"] },
{ "name": "Davos", "surname": "Seaworth", "alive": true, "age": 49, "traits": ["C","K","P","F"] },
{ "name": "Samwell", "surname": "Tarly", "alive": true, "age": 17, "traits": ["C","L","I"] },
{ "name": "Stannis", "surname": "Baratheon", "alive": false, "traits": ["H","O","P","M"] },
{ "name": "Melisandre", "alive": true, "traits": ["G","E","H"] },
{ "name": "Margaery", "surname": "Tyrell", "alive": false, "traits": ["M","D","B"] },
{ "name": "Jeor", "surname": "Mormont", "alive": false, "traits": ["C","H","M","P"] },
{ "name": "Bronn", "alive": true, "traits": ["K","E","C"] },
{ "name": "Varys", "alive": true, "traits": ["M","F","N","E"] },
{ "name": "Shae", "alive": false, "traits": ["M","D","G"] },
{ "name": "Talisa", "surname": "Maegyr", "alive": false, "traits": ["D","C","B"] },
{ "name": "Gendry", "alive": false, "traits": ["K","C","A"] },
{ "name": "Ygritte", "alive": false, "traits": ["A","P","K"] },
{ "name": "Tormund", "surname": "Giantsbane", "alive": true, "traits": ["C","P","A","I"] },
{ "name": "Gilly", "alive": true, "traits": ["L","J"] },
{ "name": "Brienne", "surname": "Tarth", "alive": true, "age": 32, "traits": ["P","C","A","K"] },
{ "name": "Ramsay", "surname": "Bolton", "alive": true, "traits": ["E","O","G","A"] },
{ "name": "Ellaria", "surname": "Sand", "alive": true, "traits": ["P","O","A","E"] },
{ "name": "Daario", "surname": "Naharis", "alive": true, "traits": ["K","P","A"] },
{ "name": "Missandei", "alive": true, "traits": ["D","L","C","M"] },
{ "name": "Tommen", "surname": "Baratheon", "alive": true, "traits": ["I","L","B"] },
{ "name": "Jaqen", "surname": "H'ghar", "alive": true, "traits": ["H","F","K"] },
{ "name": "Roose", "surname": "Bolton", "alive": true, "traits": ["H","E","F","A"] },
{ "name": "The High Sparrow", "alive": true, "traits": ["H","M","F","O"] }
]

FOR d IN data
INSERT d INTO Characters

--
FOR c IN Characters
FILTER c.name == "Ned"
RETURN c

---

FOR c IN Characters
FILTER c.age < 13
RETURN { name: c.name, age: c.age }
---


FOR person1 IN Characters
  FOR person2 IN Characters
    FILTER person1.surname == person2.surname AND person1._id != person2._id
    RETURN {_from: person1._id, _to: person2._id}

FOR person1 IN Characters
  FOR person2 IN Characters
    FILTER person1.surname == person2.surname
    INSERT {_from: person1._id, _to: person2._id} IN relationship
    RETURN NEW



# Spark




spark-shell --packages com.arangodb:arangodb-spark-connector:1.0.2 
com.arangodb:arangodb-spark-connector_2.12:1.1.0

import org.apache.spark.SparkConf
import org.apache.spark._
import com.arangodb.spark.ReadOptions
import com.arangodb.spark.WriteOptions
import com.arangodb.spark.ArangoSpark
import scala.beans.BeanProperty

sc.stop()
val conf = new SparkConf(false).setMaster("local[2]").setAppName("movie-example").set("arangodb.host", "127.0.0.1").set("arangodb.port", "8529").set("arangodb.user", "root").set("arangodb.password", "123456")

val sc = new SparkContext(conf)
case class Movie(@BeanProperty name: String) {
    def this() = this(name = null)
  }

val rdd = ArangoSpark.load[Movie](sc, "Characters", ReadOptions("lucas"))

import scala.beans.BeanProperty

case class TestEntity(@BeanProperty var test: Int = Int.MaxValue,
                      @BeanProperty var booleanValue: Boolean = true,
                      @BeanProperty var doubleValue: Double = Double.MaxValue,
                      @BeanProperty var floatValue: Float = Float.MaxValue,
                      @BeanProperty var longValue: Long = Long.MaxValue,
                      @BeanProperty var intValue: Int = Int.MaxValue,
                      @BeanProperty var shortValue: Short = Short.MaxValue,
                      @BeanProperty var nullString: String = null,
                      @BeanProperty var stringValue: String = "test") {

  def this() = this(test = Int.MaxValue)

}

val documents = sc.parallelize((1 to 100).map { i => TestEntity(i) })
ArangoSpark.save(documents, COLLECTION, WriteOptions(DB))

val rdd = ArangoSpark.load[String](sc, "spark", ReadOptions("lucas")
rdd.count()
rdd.take(2)
