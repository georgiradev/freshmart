$jar = 'C:\Users\Georgi Radev\Desktop\E-commerce-project-springBoot-master2\target\JtSpringProject-0.0.1-SNAPSHOT.jar'
$dir = 'C:\Users\Georgi Radev\Desktop\E-commerce-project-springBoot-master2'
$log = "$dir\app.log"
$errLog = "$dir\app-err.log"

$proc = Start-Process -FilePath "java" `
    -ArgumentList @("-jar", "`"$jar`"") `
    -WorkingDirectory $dir `
    -RedirectStandardOutput $log `
    -RedirectStandardError $errLog `
    -NoNewWindow -PassThru

Write-Host "Started PID: $($proc.Id)"
