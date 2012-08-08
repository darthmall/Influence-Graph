class Graph {
  HashMap<Integer, Node> nodes;
  ArrayList<Edge> edges;
  
  public Graph() {
    nodes = new HashMap<Integer, Node>();
    edges = new ArrayList<Edge>();
  }
  
  public void addNode(Node node) {
    nodes.put(node.id, node);
  }
  
  public Node getNode(int id) {
    return nodes.get(id);
  }
  
  public void addEdge(Edge edge) {
    edges.add(edge);
  }
}
