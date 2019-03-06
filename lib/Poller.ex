defmodule Poller do
   @moduledoc """
    Poller module periodically checks buttons and floor sensors
    Sends messages to OrderHandler and StateMachine
    """
  @floors Order.get_all_floors
  @button_types Order.get_valid_order
  def floor_poller elevator_pid, state_machine_pid do
    case DriverInterface.get_floor_sensor_state elevator_pid do
      :between_floors ->
        :timer.sleep(100)
        floor_poller elevator_pid, state_machine_pid
      floor -> 
        floor_msg = {:at_floor, floor}
        send(state_machine_pid, floor_msg)
        :timer.sleep(100)
        floor_poller elevator_pid, state_machine_pid
    end
  end
  def button_poller elevator_pid do
    Enum.each(@floors, fn(floor) ->
      Enum.each(@button_types, fn(button)->
        case DriverInterface.get_order_button_state(elevator_pid, floor, button) do
          1 ->
             IO.puts "Noticed press: #{button} on floor: #{floor}"#Pass received message to OrderHandler
             :timer.sleep(100)
             IO.puts "Eyo"
          _ -> {:no_orders}
        end
      end)
    end)
    button_poller(elevator_pid)
  end
  def test do
    {:ok, pid} = DriverInterface.start();
    button_poller(pid)
  end
end