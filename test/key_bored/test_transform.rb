require_relative "../test_helper"

require "key_bored/transform"

class TestTransform < Minitest::Test
  def test_transform
    points = []

    KeyBored::transform do
      translate(1, 2) do
        points << point
      end

      translate(10, -10) do
        points << point

        rotate(-90) do
          points << point

          translate(0, 1) do
            points << point
          end
        end
      end

      rotate(90) do
        translate(1, 0) do
          points << point
        end

        translate(0, 1) do
          points << point
        end

        translate(10, 0) do
          points << point

          translate(-11, 0) do
            points << point
          end
        end
      end
    end

    assert_point [1, 2], points.shift
    assert_point [10, -10], points.shift
    assert_point [10, -10], points.shift
    assert_point [11, -10], points.shift
    assert_point [0, 1], points.shift
    assert_point [-1, 0], points.shift
    assert_point [0, 10], points.shift
    assert_point [0, -1], points.shift
  end

  def assert_point(expected, actual)
    assert_in_delta expected[0], actual[0]
    assert_in_delta expected[1], actual[1]
  end
end

