*** Settings ***
Resource            Filtering.robot
Resource            tasks.robot
#Resource            Tricare Humana CP Combined.robot

*** Tasks ***
Run Task
    MAIN FLOW
    # Ad-Hoc Run
	#util_status_log_text_file		Batch 1			BT_Doc_dwnld		Brightree		PortalCompleted


