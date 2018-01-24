object Main {
  def is_p1(n: Int): Boolean = {
    n % 3 == 0 | n % 5 == 0
  }

  def main(args: Array[String]): Unit = {
    println((1 to 999).filter(this.is_p1).reduce(_+_))
  }
}
