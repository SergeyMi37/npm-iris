Class REST.Routes.Kanban Extends %CSP.REST
{

ClassMethod List() As %Status
{
    //set %response.ContentType = "application/json"

    set tSC = $system.Status.OK()
    set arrayTask = []
    set dynamicTask = {}

    try {

        set oRS = ##class(%SQL.Statement).%New()

        set sql = "SELECT ID, AssignedUser, TaskName, %EXTERNAL(StartDate) as StartDate, %EXTERNAL(DueDate) as DueDate, Status, Priority, Progress, ParentId FROM SQLUser.Task"

        set tSC = oRS.%Prepare(sql)

        quit:$system.Status.IsError(tSC)

        set intcolumnCount = oRS.%Metadata.columnCount

        set result = oRS.%Execute()

        if (result.%SQLCODE '< 0) {
            while result.%Next() {
                set json = {}
                for i=1:1:intcolumnCount {
                    do json.%Set(oRS.%Metadata.columns.GetAt(i).colName,result.%GetData(i))
                }
                do arrayTask.%Push(json)
            }
        }
        else {
            throw ##class(%Exception.SQL).CreateFromSQLCODE(result.%SQLCODE,result.%Message)
        }


    }
    catch (oException) {
        set tSC = oException.AsStatus()
    }

    //do dynamicTask.%Set("data",arrayTask)

    write arrayTask.%ToJSON() 

    quit tSC
}

ClassMethod Update(id As %Integer) As %Status
{
    set obj = ##class(%DynamicObject).%FromJSON(%request.Content)

    set objTask = ##class(User.Task).%OpenId(id)

    if '$isobject(objTask) {
        set %response.Status = ..#HTTP404NOTFOUND
        quit $$$OK
    }

    set iter = obj.%GetIterator()
    while iter.%GetNext(.key , .value )  {
        set $property(objTask, key) = value
    }

    set tSC = objTask.%Save()

    if $$$ISERR(tSC) {
        quit $system.OBJ.DisplayError(tSC)
    }

    quit $$$OK
}

ClassMethod GetKanban(id As %Integer) As %Status
{

    set %response.ContentType = "application/json"

    set objTask = ##class(User.Task).%OpenId(id)
    set obj = {}

    do obj.%Set("id", objTask.%Id())
    do obj.%Set("TaskName", objTask.TaskName)
    do obj.%Set("StartDate", objTask.StartDate)
    do obj.%Set("DueDate", objTask.DueDate)
    do obj.%Set("Progress", objTask.Progress)
    do obj.%Set("Priority", objTask.Priority)
    do obj.%Set("Status", objTask.Status)
    do obj.%Set("AssignedUser", objTask.AssignedUser)
    do obj.%Set("ParentId", objTask.ParentId)
    do obj.%Set("PredecessorId", objTask.PredecessorId)
    do obj.%Set("SucessorId", objTask.SucessorId)

    write obj.%ToJSON()

    quit $$$OK
}

}