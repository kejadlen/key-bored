require "matrix"

module KeyBored
  def self.transform(&block)
    Transform.new(&block)
  end

  class Transform
    include Math

    def initialize(&block)
      @transforms = [Matrix.identity(3)]

      instance_eval(&block)
    end

    def point
      transform = @transforms.inject(&:*)
      point = transform * Matrix.column_vector([0, 0, 1])
      [point[0,0], point[1,0]]
    end

    def translate(x, y, &block)
      transform = Matrix[[1, 0, x],
                         [0, 1, y],
                         [0, 0, 1]]
      with_transform(transform, &block)
    end

    def rotate(degrees, &block)
      rads = PI * degrees / 180

      transform = Matrix[[cos(rads), -sin(rads), 0],
                         [sin(rads), cos(rads),  0],
                         [0,         0,          1]]
      with_transform(transform, &block)
    end

    def with_transform(transform, &block)
      @transforms << transform
      instance_eval(&block)
      @transforms.pop
    end

  end
end
