require 'helper'

class TestPgCreditcard < Test::Unit::TestCase
  
  def test_raises_argument_error_if_options_nil
    assert_raise(ArgumentError) do
      @cc = PgCreditcard.new
    end
  end
  
  def test_does_not_raise_argument_error_if_options_nil
    assert_nothing_raised(ArgumentError) do
      @cc = PgCreditcard.new(
        :name => "Homer Simpsons",
        :number => "4111111111111111",
        :month  => "03",
        :year   => "20",
        :cvv    => "123"
      )
    end
  end

  def test_initializing_new_pg_creditcard_instance
    @cc = PgCreditcard.new(
      :name => "Homer Simpsons",
      :number => "4111111111111111",
      :month  => "03",
      :year   => "20",
      :cvv    => "123"
    )
    assert @cc, "PgCreditcard instance not set"
  end
  
  def test_determine_cc_type_from_cc_number
    @cc = PgCreditcard.new(
      :name => "Homer Simpsons",
      :number => "4111111111111111",
      :month  => "03",
      :year   => "20",
      :cvv    => "123"
    )
    assert_equal @cc.type, "visa"
  end
  
  def test_return_false_if_not_expired
    @cc = PgCreditcard.new(
      :name => "Homer Simpsons",
      :number => "4111111111111111",
      :month  => "03",
      :year   => "12",
      :cvv    => "123"
    )
    assert !@cc.expired?, "PgCreditcard is expired when it is not"
  end
  
  def test_return_true_if_expired
    @cc = PgCreditcard.new(
      :name => "Homer Simpsons",
      :number => "4111111111111111",
      :month  => "03",
      :year   => "10",
      :cvv    => "123"
    )
    assert @cc.expired?, "PgCreditcard is not expired when it should be expired"
  end
  
  def test_return_false_if_invalid_credit_card
    @cc = PgCreditcard.new(
      :name => "Homer Simpsons",
      :number => "4111111111111110",
      :month  => "03",
      :year   => "20",
      :cvv    => "123"
    )
    assert !@cc.valid?, "PgCreditcard is valid when credit card number is invalid"
  end
  
  def test_return_true_if_valid_credit_card
    @cc = PgCreditcard.new(
      :name => "Homer Simpsons",
      :number => "4111111111111111",
      :month  => "03",
      :year   => "10",
      :cvv    => "123"
    )
    assert @cc.valid?, "PgCreditcard is invalid when credit card number is valid"
  end
  
end
