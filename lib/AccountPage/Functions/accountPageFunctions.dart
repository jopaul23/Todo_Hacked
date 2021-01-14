class AccountFunctions {
  var db;
  Future<int> getCompletedTask() async {
    List todos = await db.getCompletedTask();
    print(todos);
    return todos.length;
  }

  Future<int> getPendingTask() async {
    List todos = await db.getPendingTask();
    print(todos);
    return todos.length;
  }
}
