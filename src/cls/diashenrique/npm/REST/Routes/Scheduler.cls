Class diashenrique.npm.REST.Routes.Scheduler Extends %CSP.REST
{

ClassMethod List() As %Status
{
    ;set %response.ContentType = "application/json"

    Set tSC = $System.Status.OK()
    Set arrayScheduler = []

    Try {

        Set oRS = ##class(%SQL.Statement).%New()

        Set sql = "SELECT ID, TaskName, %EXTERNAL(StartDate) As StartDate, %EXTERNAL(DueDate) As DueDate, Priority, Status, Progress, "_
                "AssignedUser, ParentId, PredecessorId, SucessorId FROM diashenrique_npm_Data.Task"

        Set tSC = oRS.%Prepare(sql)

        Quit:$System.Status.IsError(tSC)

        Set result = oRS.%Execute()

        If (result.%SQLCODE '< 0) {
            While result.%Next() {
                Set json = { }
                Do json.%Set("ID", result.ID)
                Do json.%Set("text", result.TaskName)
                Do json.%Set("startDate", result.StartDate)
                Do json.%Set("endDate", result.DueDate)
                Do arrayScheduler.%Push(json)
            }
        }
        Else {
            Throw ##class(%Exception.SQL).CreateFromSQLCODE(result.%SQLCODE,result.%Message)
        }
    }
    Catch (oException) {
        Set tSC = oException.AsStatus()
    }

    Write arrayScheduler.%ToJSON() 

    Quit tSC
}

ClassMethod Update(id As %Integer) As %Status
{
    Set obj = ##class(%DynamicObject).%FromJSON(%request.Content)

    Set objTask = ##class(User.Task).%OpenId(id)

    If '$IsObject(objTask) {
        Set %response.Status = ..#HTTP404NOTFOUND
        Quit $$$OK
    }

    Set iter = obj.%GetIterator()
    While iter.%GetNext(.key , .value )  {
        If ((key = "StartDate") || (key = "DueDate")) {
            Set $Property(objTask, key) = $ZDateh($Replace(value,"/",""),8)
        }
        ElseIf (key = "AssignedUser") {
            Set $Property(objTask, key) = ##class(diashenrique.npm.Data.Person).%OpenId(value) 
        }	 
        Else {
            Set $Property(objTask, key) = value
        }
    }

    Set tSC = objTask.%Save()

    If $$$ISERR(tSC) {
        Quit $System.OBJ.DisplayError(tSC)
    }

    Quit $$$OK
}

ClassMethod Delete(id As %Integer) As %Status
{
    If '##class(diashenrique.npm.Data.Task).%ExistsId(id) {
        Set %responde.Status = ..#HTTP404NOTFOUND
        Quit $$$OK	
    }

    Do ##class(diashenrique.npm.Data.Task).%DeleteId(id)

    Quit $$$OK
}

ClassMethod NewScheduler() As %Status
{
    #dim task As diashenrique.npm.Data.Task

    Set obj = ##class(%DynamicAbstractObject).%FromJSON(%request.Content)

    Set objTask = ##class(diashenrique.npm.Data.Task).%New()

    Set objTask.TaskName = obj.TaskName
    Set objTask.StartDate = $ZDateh($Replace(obj.StartDate,"/",""),8)
    Set objTask.DueDate = $ZDateh($Replace(obj.DueDate,"/",""),8)
    Set objTask.Progress = obj.Progress
    Set objTask.Priority = obj.Priority
    Set objTask.Status = obj.Status
    Set objTask.AssignedUser = ##class(diashenrique.npm.Data.Person).%OpenId(obj.AssignedUser)
    ;set objTask.ParentId = obj.ParentId
    ;set objTask.PredecessorId = obj.PredecessorId
    ;set objTask.SucessorId = obj.SucessorId

    Set tSC = objTask.%Save()

    If $$$ISOK(tSC) {
        Set ^zHGD("NewTask","%Oid")=objTask.%Oid()
        Set ^zHGD("NewTask","%Id")=objTask.%Id()
    }

    Quit tSC
}

ClassMethod GetScheduler(id As %Integer) As %Status
{

    Set %response.ContentType = "application/json"

    Set objTask = ##class(diashenrique.npm.Data.Task).%OpenId(id)
    Set obj = { }

    Do obj.%Set("id", objTask.%Id())
    Do obj.%Set("TaskName", objTask.TaskName)
    Do obj.%Set("StartDate", objTask.StartDate)
    Do obj.%Set("DueDate", objTask.DueDate)
    Do obj.%Set("Progress", objTask.Progress)
    Do obj.%Set("Priority", objTask.Priority)
    Do obj.%Set("Status", objTask.Status)
    Do obj.%Set("AssignedUser", objTask.AssignedUser)
    Do obj.%Set("ParentId", objTask.ParentId)
    Do obj.%Set("PredecessorId", objTask.PredecessorId)
    Do obj.%Set("SucessorId", objTask.SucessorId)

    Write obj.%ToJSON()

    Quit $$$OK
}

}