class Edge {
  
  Node source;
  Node target;
  float weight;
  
  public Edge(Node source, Node target) {
    super();

    this.source = source;
    this.target = target;
  }

  public void setAttr(String name, String value) {
   if (name.equals("weight")) {
    weight = float(value);
   }
  } 
}
