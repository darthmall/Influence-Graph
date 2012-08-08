class Node {
  int id;
  String label;
  float degree;
  float weightedDegree;
  float nodeSize;
  int r;
  int g;
  int b;
  float x;
  float y;

  ArrayList<Edge> edges;

  public Node(int id) {
    edges = new ArrayList<Edge>();
    
    this.id = id;
  }
  
  public void addEdge(Edge e) {
    edges.add(e);
  }
  
  public void setAttr(String name, String value) {
    if (name.equals("label")) {
      label = value;
    } else if (name.equals("degree")) {
      degree = float(value);
    } else if (name.equals("weighted degree")) {
      weightedDegree = float(value);
    } else if (name.equals("size")) {
      nodeSize = float(value);
    } else if (name.equals("r")) {
      r = int(value);
    } else if (name.equals("g")) {
      g = int(value);
    } else if (name.equals("b")) {
      b = int(value);
    } else if (name.equals("x")) {
      x = float(value);
    } else if (name.equals("y")) {
      y = float(value);
    }
  }
  
  public boolean contains(float x, float y) {
    return (dist(x, y, this.x, this.y) < this.nodeSize);
  }
}
