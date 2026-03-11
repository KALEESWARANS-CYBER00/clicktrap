<#
.SYNOPSIS
    ClickTrap Awareness Windows Environment (System Lockdown & UX)
    Replicates the visual and behavioral traits of awareness.py natively on Windows via WinForms.
#>

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

[System.Windows.Forms.Application]::EnableVisualStyles()

# --- Forensic Data Gathering ---
$user = [Environment]::UserName
$host = [System.Net.Dns]::GetHostName()
$ip = "127.0.0.1"
try {
    $ip = ([System.Net.Dns]::GetHostAddresses($host) | Where-Object { $_.AddressFamily -eq 'InterNetwork' })[0].IPAddressToString
} catch {}

$homePath = $env:USERPROFILE
$allFiles = @()

try {
    # Attempt to grab some random standard files to demonstrate the 'scan'
    $allFiles = @(Get-ChildItem -Path $homePath -File -Recurse -Depth 3 -ErrorAction SilentlyContinue | Select-Object -First 100).FullName
} catch {}

if ($allFiles.Count -eq 0) {
    $allFiles = @("C:\Windows\System32\config\SAM", "C:\Users\$user\Documents\passwords.txt", "C:\Users\$user\Desktop\wallet.dat")
}

function Get-RandomHash {
    $bytes = New-Object Byte[] 16
    (New-Object Random).NextBytes($bytes)
    return ([System.BitConverter]::ToString($bytes) -replace '-','').ToLower()
}

$lockoutDuration = 60
$startTime = [DateTime]::Now
$canExit = $false

# --- Extreme System-Level Hijack GUI ---
$form = New-Object System.Windows.Forms.Form
$form.Text = "ClickTrap Simulator"
$form.FormBorderStyle = [System.Windows.Forms.FormBorderStyle]::None
$form.WindowState = [System.Windows.Forms.FormWindowState]::Maximized
$form.BackColor = [System.Drawing.ColorTranslator]::FromHtml('#050505')
$form.TopMost = $true
$form.ShowInTaskbar = $false
$form.Cursor = [System.Windows.Forms.Cursors]::Cross

# Header
$header = New-Object System.Windows.Forms.Label
$header.Text = "[ RE-INITIALIZING SYSTEM ]"
$header.Font = New-Object System.Drawing.Font("Consolas", 35, [System.Drawing.FontStyle]::Bold)
$header.ForeColor = [System.Drawing.ColorTranslator]::FromHtml('#ff0033')
$header.AutoSize = $true
$header.Location = New-Object System.Drawing.Point(80, 100)
$form.Controls.Add($header)

# Terminal Area
$terminal = New-Object System.Windows.Forms.RichTextBox
$terminal.BackColor = [System.Drawing.ColorTranslator]::FromHtml('#050505')
$terminal.ForeColor = [System.Drawing.ColorTranslator]::FromHtml('#00ff41')
$terminal.Font = New-Object System.Drawing.Font("Consolas", 14)
$terminal.BorderStyle = [System.Windows.Forms.BorderStyle]::None
$terminal.ReadOnly = $true
$terminal.Location = New-Object System.Drawing.Point(80, 200)
$terminal.Size = New-Object System.Drawing.Size([System.Windows.Forms.Screen]::PrimaryScreen.Bounds.Width - 160, [System.Windows.Forms.Screen]::PrimaryScreen.Bounds.Height - 400)
$form.Controls.Add($terminal)

# Progress Section
$progressFrame = New-Object System.Windows.Forms.Panel
$progressFrame.Size = New-Object System.Drawing.Size([System.Windows.Forms.Screen]::PrimaryScreen.Bounds.Width - 160, 100)
$progressFrame.Location = New-Object System.Drawing.Point(80, [System.Windows.Forms.Screen]::PrimaryScreen.Bounds.Height - 150)
$form.Controls.Add($progressFrame)
$progressFrame.Visible = $false

$progressLabel = New-Object System.Windows.Forms.Label
$progressLabel.Text = "LOCKING SYSTEM ARCHITECTURE..."
$progressLabel.Font = New-Object System.Drawing.Font("Consolas", 12, [System.Drawing.FontStyle]::Bold)
$progressLabel.ForeColor = [System.Drawing.ColorTranslator]::FromHtml('#ff0033')
$progressLabel.AutoSize = $true
$progressLabel.Location = New-Object System.Drawing.Point(0,0)
$progressFrame.Controls.Add($progressLabel)

$progressBg = New-Object System.Windows.Forms.Panel
$progressBg.Size = New-Object System.Drawing.Size($progressFrame.Width, 20)
$progressBg.Location = New-Object System.Drawing.Point(0, 30)
$progressBg.BackColor = [System.Drawing.ColorTranslator]::FromHtml('#111111')
$progressFrame.Controls.Add($progressBg)

$progressBar = New-Object System.Windows.Forms.Label
$progressBar.Size = New-Object System.Drawing.Size(0, 20)
$progressBar.Location = New-Object System.Drawing.Point(0, 0)
$progressBar.BackColor = [System.Drawing.ColorTranslator]::FromHtml('#ff0033')
$progressBg.Controls.Add($progressBar)

# Utility Methods
function Log-Text($text, $colorHtml = '#00ff41') {
    $terminal.SelectionStart = $terminal.TextLength
    $terminal.SelectionLength = 0
    $terminal.SelectionColor = [System.Drawing.ColorTranslator]::FromHtml($colorHtml)
    $terminal.AppendText($text + "`n")
    $terminal.ScrollToCaret()
}

$form.Add_FormClosing({
    if (-not $script:canExit) {
        $_.Cancel = $true
        $elapsed = ([DateTime]::Now - $script:startTime).TotalSeconds
        $remaining = [math]::Max(0, $script:lockoutDuration - $elapsed)
        Log-Text "`n[!] EXIT DENIED. KEYBOARD INTERCEPT ACTIVE. LOCKOUT: $([math]::Round($remaining))s remaining." '#ff0033'
    }
})

$form.KeyPreview = $true
$form.Add_KeyDown({
    if ($_.KeyCode -eq 'Escape') {
        if ($script:canExit) {
            $form.Close()
        } else {
            $elapsed = ([DateTime]::Now - $script:startTime).TotalSeconds
            $remaining = [math]::Max(0, $script:lockoutDuration - $elapsed)
            Log-Text "`n[!] EXIT DENIED. KEYBOARD INTERCEPT ACTIVE. LOCKOUT: $([math]::Round($remaining))s remaining." '#ff0033'
        }
    }
})

# State Variables
$script:awarenessMsg = @"
SYSTEM COMPROMISE SIMULATION COMPLETE.
---------------------------------------------------

NO DATA WAS ACTUALLY STOLEN. YOU ARE SAFE.
This was a test of your 'COGNITIVE GAP'.

YOU ARE CURRENTLY IN A 'SECURITY LOCKDOWN' PHASE.
This is meant to simulate the feeling of having no 
control over your system after a breach.

In a real attack, your files would be encrypted 
and your access permanently revoked.

`"The greatest exploit in the history of computing is 
not a line of code, but the exploitation of trust.`"
"@
$script:typeIndex = 0

# --- Timers for Sequences ---

$timerRecon = New-Object System.Windows.Forms.Timer
$timerRecon.Interval = 1000
$timerRecon.Add_Tick({
    $timerRecon.Stop()
    $header.Text = "[ VULNERABILITY EXPLOITED ]"
    Log-Text "[*] Payload successfully delivered to $user"
    Log-Text "[*] Establishing persistence on $host"
    Log-Text "[*] Remote IP captured: $ip"
    Log-Text "------------------------------------------------------------"
    $timerHarvest.Start()
})

$script:fileIndex = 0
$timerHarvest = New-Object System.Windows.Forms.Timer
$timerHarvest.Interval = 30
$timerHarvest.Add_Tick({
    if ($script:fileIndex -eq 0) {
        $header.Text = "[ INDEXING SENSITIVE DATA ]"
        Log-Text "[!] ACCESSING PRIVATE STORAGE..." '#ffcc00'
    }
    if ($script:fileIndex -lt 30 -and $script:fileIndex -lt $allFiles.Count) {
        Log-Text " TARGET: $($allFiles[$script:fileIndex])"
        $script:fileIndex++
    } else {
        $timerHarvest.Stop()
        Log-Text "`n[+] Total assets indexed: $($allFiles.Count)" '#ffcc00'
        $timerTheftSetup = New-Object System.Windows.Forms.Timer
        $timerTheftSetup.Interval = 1000
        $timerTheftSetup.Add_Tick({
            $timerTheftSetup.Stop()
            $header.Text = "[ EXFILTRATING ASSETS ]"
            $header.ForeColor = [System.Drawing.ColorTranslator]::FromHtml('#ff0033')
            $progressFrame.Visible = $true
            $timerHeist.Start()
        })
        $timerTheftSetup.Start()
    }
})

$script:currentVal = 0.0
$timerHeist = New-Object System.Windows.Forms.Timer
$timerHeist.Interval = 30
$timerHeist.Add_Tick({
    if ($script:currentVal -lt 100) {
        $rndAdd = (Get-Random -Minimum 5 -Maximum 40) / 10.0
        $script:currentVal += $rndAdd
        if ($script:currentVal -gt 100) { $script:currentVal = 100 }
        $progressBar.Width = [math]::Floor(($script:currentVal / 100.0) * $progressBg.Width)
        
        $rnd = Get-Random -Minimum 0 -Maximum $allFiles.Count
        if ($rnd -ge 0 -and $rnd -lt $allFiles.Count) {
            $shortPath = Split-Path -Path $allFiles[$rnd] -Leaf
            if ($shortPath.Length -gt 20) { $shortPath = $shortPath.Substring(0, 20) }
            $shortPath = $shortPath.PadRight(20)
            $hash = (Get-RandomHash).Substring(0,10)
            Log-Text " [SENDING] $shortPath | BLOCK: $hash | OK"
        }
    } else {
        $timerHeist.Stop()
        Log-Text "`n[+] SUCCESS: DATA STREAM SECURED BY REMOTE SERVER." '#00ff41'
        $timerRevealSetup = New-Object System.Windows.Forms.Timer
        $timerRevealSetup.Interval = 2000
        $timerRevealSetup.Add_Tick({
            $timerRevealSetup.Stop()
            Phase-Reveal
        })
        $timerRevealSetup.Start()
    }
})

$script:titleLbl = $null
$script:textLabel = $null
$script:timerLabel = $null
$script:exitHint = $null

function Phase-Reveal {
    $form.Controls.Clear()
    $form.BackColor = [System.Drawing.ColorTranslator]::FromHtml('#0a0a0a')
    $form.Cursor = [System.Windows.Forms.Cursors]::Default
    
    $script:titleLbl = New-Object System.Windows.Forms.Label
    $script:titleLbl.Text = "[ SECURITY BREACH DETECTED ]"
    $script:titleLbl.Font = New-Object System.Drawing.Font("Consolas", 40, [System.Drawing.FontStyle]::Bold)
    $script:titleLbl.ForeColor = [System.Drawing.ColorTranslator]::FromHtml('#ff0033')
    $script:titleLbl.AutoSize = $true
    $script:titleLbl.Location = New-Object System.Drawing.Point(80, 100)
    $form.Controls.Add($script:titleLbl)

    $script:textLabel = New-Object System.Windows.Forms.Label
    $script:textLabel.Text = ""
    $script:textLabel.Font = New-Object System.Drawing.Font("Consolas", 18)
    $script:textLabel.ForeColor = [System.Drawing.ColorTranslator]::FromHtml('#ffffff')
    $script:textLabel.AutoSize = $true
    $script:textLabel.Location = New-Object System.Drawing.Point(80, 250)
    $form.Controls.Add($script:textLabel)

    $script:timerLabel = New-Object System.Windows.Forms.Label
    $script:timerLabel.Text = ""
    $script:timerLabel.Font = New-Object System.Drawing.Font("Consolas", 14, [System.Drawing.FontStyle]::Bold)
    $script:timerLabel.ForeColor = [System.Drawing.ColorTranslator]::FromHtml('#ffcc00')
    $script:timerLabel.AutoSize = $true
    $script:timerLabel.Location = New-Object System.Drawing.Point(80, [System.Windows.Forms.Screen]::PrimaryScreen.Bounds.Height - 150)
    $form.Controls.Add($script:timerLabel)

    $script:exitHint = New-Object System.Windows.Forms.Label
    $script:exitHint.Text = "EXIT RESTRICTED UNTIL SECURITY BRIEFING IS COMPLETE"
    $script:exitHint.Font = New-Object System.Drawing.Font("Consolas", 12)
    $script:exitHint.ForeColor = [System.Drawing.ColorTranslator]::FromHtml('#444444')
    $script:exitHint.AutoSize = $true
    $script:exitHint.Location = New-Object System.Drawing.Point(80, [System.Windows.Forms.Screen]::PrimaryScreen.Bounds.Height - 100)
    $form.Controls.Add($script:exitHint)
    
    $timerTypeWrite.Start()
}

$timerTypeWrite = New-Object System.Windows.Forms.Timer
$timerTypeWrite.Interval = 15
$timerTypeWrite.Add_Tick({
    if ($script:typeIndex -lt $script:awarenessMsg.Length) {
        $script:textLabel.Text = $script:awarenessMsg.Substring(0, $script:typeIndex + 1) + "█"
        $script:typeIndex++
    } else {
        $timerTypeWrite.Stop()
        $script:textLabel.Text = $script:awarenessMsg
        $timerCountdown.Start()
    }
})

$timerCountdown = New-Object System.Windows.Forms.Timer
$timerCountdown.Interval = 1000
$timerCountdown.Add_Tick({
    $elapsed = ([DateTime]::Now - $script:startTime).TotalSeconds
    $remaining = [math]::Max(0, $script:lockoutDuration - $elapsed)
    
    if ($remaining -gt 0) {
        $script:timerLabel.Text = "MANDATORY SECURITY LOCKDOWN: $([math]::Round($remaining))s REMAINING"
    } else {
        $timerCountdown.Stop()
        $script:canExit = $true
        $script:titleLbl.Text = "[ AWARENESS COMPLETE ]"
        $script:titleLbl.ForeColor = [System.Drawing.ColorTranslator]::FromHtml('#00ffcc')
        $script:timerLabel.Text = "SYSTEM SECURITY RESTORED"
        $script:timerLabel.ForeColor = [System.Drawing.ColorTranslator]::FromHtml('#00ffcc')
        $script:exitHint.Text = "[ PRESS ESC TO ACKNOWLEDGE AND CONTACT RESEARCHER ]"
        $script:exitHint.ForeColor = [System.Drawing.ColorTranslator]::FromHtml('#ffffff')
    }
})

# Maintain dominance hook
$timerDominance = New-Object System.Windows.Forms.Timer
$timerDominance.Interval = 500
$timerDominance.Add_Tick({
    if (-not $script:canExit) {
        $form.TopMost = $true
    }
})
$timerDominance.Start()

$form.Add_Shown({
    $timerRecon.Start()
})

$form.ShowDialog() | Out-Null
