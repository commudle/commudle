class CreateRoleAttendanceManager < ActiveRecord::Migration[5.2]
  def change
    UserRole.create([{ :name => 'attendance_manager' }])
  end
end
