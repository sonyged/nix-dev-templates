{
  outputs = inputs: {
    templates = rec {
      node = {
        path = ./node;
        description = "Node.js development environment";
      };
      nodejs = node;
      ruby = {
        path = ./ruby;
        description = "Ruby development environment";
      };
    };
  };
}
