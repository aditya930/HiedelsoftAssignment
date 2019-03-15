/*********************************************************************************
Class Name      : AvoidRecursion 
Description     : Class to avoid recursive triggers
                 
Created By      : Aditya M
Created Date    : 14-Mar-19   
Modification Log:
---------------------------------------------------------------------------------- ,
Developer                   Date                   Description
-----------------------------------------------------------------------------------            
Aditya M            	 14-Mar-19                   Initial Version
*********************************************************************************/
public Class AvoidRecursion{
    private static boolean firstRun = true;
    public static boolean isFirstRun(){
    if(firstRun){
      firstRun = false;
      return true;
    }else{
        return firstRun;
    }
    }
}