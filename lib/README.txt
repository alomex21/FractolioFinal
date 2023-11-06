Muhhamad:

The main files which are needed to refactor would be all files inside view which have direct import of
firebase auth or any of them. i have folders inside services which their purpose is to initialize all firebase and call them
in any view. unfortunately some views has firebase imports and those would be the objective.
Also im using provider for storing info for example email and username in the main menu, probably i wish to delete provider since
i have no clue how to use it anymore

In summary:
check the views for any possible firebase package and create if doable a service file for each.
I'll wait for any questions :)