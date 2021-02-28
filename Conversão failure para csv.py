#Abrindo arquivo com dados dos sensores
sensores = open('equipment_failure_sensors (2).log', "r")
sensores_new = open("equipment_failure_sensors_new", "w")

#lendo linhas
lines = sensores.readlines()


for i in range(len(lines)):
    if lines[i][36]==']':
        #data
        sensores_new.write(lines[i][1:20]+";"+lines[i][35:36]+"\n")
    elif lines[i][37]=="]":
        sensores_new.write(lines[i][1:20]+";"+lines[i][35:37]+"\n")
    else:
        sensores_new.write(lines[i][1:20]+";"+lines[i][35:38]+"\n")


