# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# User.destroy_all
User.create! [
  {username: "Fiorina", password_digest: "samplepass"},
  {username: "Trump", password_digest: "samplepass"},
  {username: "Carson", password_digest: "samplepass"},
  {username: "Clinton", password_digest: "samplepass"}
]
#rename_column(todo_items, todolist_id, todo_list_id)
u1= User.find_by username: "Fiorina";
u1.create_profile first_name:"Carly", last_name:"Fiorina", gender:"female", birth_year:1954;

u2= User.find_by username: "Trump";
u2.create_profile first_name:"Donald", last_name:"Trump", gender:"male", birth_year:1946;

u3= User.find_by username: "Carson";
u3.create_profile first_name:"Ben", last_name:"Carson", gender:"male", birth_year:1951;

u4= User.find_by username: "Clinton";
u4.create_profile first_name:"Hillary", last_name:"Clinton", gender:"female", birth_year:1947;

u1.todo_lists.create! [{list_name:"List1", list_due_date:Date.today+1.year}]
u2.todo_lists.create! [{list_name:"List2", list_due_date:Date.today+1.year}]
u3.todo_lists.create! [{list_name:"List3", list_due_date:Date.today+1.year}]
u4.todo_lists.create! [{list_name:"List4", list_due_date:Date.today+1.year}]

tl1= TodoList.find_by list_name: "List1";
tl2= TodoList.find_by list_name: "List2";
tl3= TodoList.find_by list_name: "List3";
tl4= TodoList.find_by list_name: "List4";

tl1.todo_items.create! [
  {due_date:Date.today+1.year, title:"Item1", description:"Item1 of list1", completed:false},
  {due_date:Date.today+1.year, title:"Item2", description:"Item2 of list1", completed:false},
  {due_date:Date.today+1.year, title:"Item3", description:"Item3 of list1", completed:false},
  {due_date:Date.today+1.year, title:"Item4", description:"Item4 of list1", completed:false},
  {due_date:Date.today+1.year, title:"Item5", description:"Item5 of list1", completed:false}];

tl2.todo_items.create! [
  {due_date:Date.today+1.year, title:"Item1", description:"Item1 of list2", completed:false},
  {due_date:Date.today+1.year, title:"Item2", description:"Item2 of list2", completed:false},
  {due_date:Date.today+1.year, title:"Item3", description:"Item3 of list2", completed:false},
  {due_date:Date.today+1.year, title:"Item4", description:"Item4 of list2", completed:false},
  {due_date:Date.today+1.year, title:"Item5", description:"Item5 of list2", completed:false}];

tl3.todo_items.create! [
  {due_date:Date.today+1.year, title:"Item1", description:"Item1 of list3", completed:false},
  {due_date:Date.today+1.year, title:"Item2", description:"Item2 of list3", completed:false},
  {due_date:Date.today+1.year, title:"Item3", description:"Item3 of list3", completed:false},
  {due_date:Date.today+1.year, title:"Item4", description:"Item4 of list3", completed:false},
  {due_date:Date.today+1.year, title:"Item5", description:"Item5 of list3", completed:false}];

tl4.todo_items.create! [
  {due_date:Date.today+1.year, title:"Item1", description:"Item1 of list4", completed:false},
  {due_date:Date.today+1.year, title:"Item2", description:"Item2 of list4", completed:false},
  {due_date:Date.today+1.year, title:"Item3", description:"Item3 of list4", completed:false},
  {due_date:Date.today+1.year, title:"Item4", description:"Item4 of list4", completed:false},
  {due_date:Date.today+1.year, title:"Item5", description:"Item5 of list4", completed:false}];

# TodoItem.create(due_date:Date.today+1.year, title:"Item1", description:"Item1 of list1", completed:false, todo_list_id:1);
# TodoItem.create(due_date:Date.today+1.year, title:"Item2", description:"Item2 of list1", completed:false, todo_list_id:1);
# TodoItem.create(due_date:Date.today+1.year, title:"Item3", description:"Item3 of list1", completed:false, todo_list_id:1);
# TodoItem.create(due_date:Date.today+1.year, title:"Item4", description:"Item4 of list1", completed:false, todo_list_id:1);
# TodoItem.create(due_date:Date.today+1.year, title:"Item5", description:"Item5 of list1", completed:false, todo_list_id:1);
#
# TodoItem.create(due_date:Date.today+1.year, title:"Item1", description:"Item1 of list2", completed:false, todo_list_id:2);
# TodoItem.create(due_date:Date.today+1.year, title:"Item2", description:"Item2 of list2", completed:false, todo_list_id:2);
# TodoItem.create(due_date:Date.today+1.year, title:"Item3", description:"Item3 of list2", completed:false, todo_list_id:2);
# TodoItem.create(due_date:Date.today+1.year, title:"Item4", description:"Item4 of list2", completed:false, todo_list_id:2);
# TodoItem.create(due_date:Date.today+1.year, title:"Item5", description:"Item5 of list2", completed:false, todo_list_id:2);
#
# TodoItem.create(due_date:Date.today+1.year, title:"Item1", description:"Item1 of list3", completed:false, todo_list_id:3);
# TodoItem.create(due_date:Date.today+1.year, title:"Item2", description:"Item2 of list3", completed:false, todo_list_id:3);
# TodoItem.create(due_date:Date.today+1.year, title:"Item3", description:"Item3 of list3", completed:false, todo_list_id:3);
# TodoItem.create(due_date:Date.today+1.year, title:"Item4", description:"Item4 of list3", completed:false, todo_list_id:3);
# TodoItem.create(due_date:Date.today+1.year, title:"Item5", description:"Item5 of list3", completed:false, todo_list_id:3);
#
# TodoItem.create(due_date:Date.today+1.year, title:"Item1", description:"Item1 of list4", completed:false, todo_list_id:4);
# TodoItem.create(due_date:Date.today+1.year, title:"Item2", description:"Item2 of list4", completed:false, todo_list_id:4);
# TodoItem.create(due_date:Date.today+1.year, title:"Item3", description:"Item3 of list4", completed:false, todo_list_id:4);
# TodoItem.create(due_date:Date.today+1.year, title:"Item4", description:"Item4 of list4", completed:false, todo_list_id:4);
# TodoItem.create(due_date:Date.today+1.year, title:"Item5", description:"Item5 of list4", completed:false, todo_list_id:4);
