require 'order_repository'

RSpec.describe OrderRepository do
  def reset_shop_table
    seed_sql = File.read('spec/seeds.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
    connection.exec(seed_sql)
  end

  before(:each) do
    reset_shop_table
  end

  it "returns list of all orders" do
    repo = OrderRepository.new
    order_list = repo.all_orders
    output = []
    customer_names = [
      "Emma Jones",
      "Benjamin Lee",
      "Sophie Chen",
      "Jack Wilson",
      "Olivia Brown"
    ]

    order_list.each { |order|
      output << order.customer
    }

    expect(output.length).to eq 5
    expect(output).to eq customer_names
  end

  it "returns single order information" do
    repo = OrderRepository.new
    single_item = repo.single_order(2)

    expect(single_item.customer).to eq "Benjamin Lee"
    expect(single_item.date_of_order).to eq "2023-04-03"
  end
end
