<#
.SYNOPSIS
  PowerShellで動作する、パスワード生成GUIプログラム
.DESCRIPTION
  ランダムなパスワードを生成し、CSVファイルの他、様々な形式でデータを保存できます。
  対応形式：  CSV、HTML、XML、JSON、RTF、XPS、TXT (※XPSはPowerShell 3.0以降のみ対応)
#>
$MsgBox = {
	param($str,$title,$icon)
	[Void][System.Windows.Forms.MessageBox]::Show($str,$title,"OK",$icon)
}

[Void][System.Reflection.Assembly]::LoadWithPartialName("System.Drawing")
[Void][System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")

if ([string]::IsNullOrEmpty($myInvocation.MyCommand.path))
{
	$path = (Get-Location).Path
}
else
{
	$path = Split-Path $myInvocation.MyCommand.path
}

if ($Host.Runspace.ApartmentState -ne "STA")
{
	powershell.exe -Sta -File (Join-Path $path "PasswordGenerator.ps1")
	exit
}

$cp = [Windows.Forms.Clipboard]

$Form1 = New-Object System.Windows.Forms.Form
$Form1.Size = New-Object System.Drawing.Size(610,390)
$Form1.Text = "PasswordGenerator"
$Form1.FormBorderStyle = "FixedSingle"
$Form1.MaximizeBox = $False
$Form1.StartPosition = "CenterScreen"

$GroupBox1 = New-Object System.Windows.Forms.GroupBox
$GroupBox1.Location = New-Object System.Drawing.Size(10,10)
$GroupBox1.Size = New-Object System.Drawing.Size(430,120)
$GroupBox1.Text = "パスワードに使用する文字"
$Form1.Controls.Add($GroupBox1)

$CheckBox1 = New-Object System.Windows.Forms.checkbox
$CheckBox1.Location = New-Object System.Drawing.Size(10,15)
$CheckBox1.Size = New-Object System.Drawing.Size(110,20)
$CheckBox1.Checked = $True
$CheckBox1.Text = "英字小文字(&L)"
$CheckBox1.Add_CheckedChanged({
	if ($ComboBox1.SelectedIndex.Equals(0) -Or $ComboBox1.SelectedIndex.Equals(1)) {$NumberBox1.Minimum = checkboxescount}
	if (($CheckBox2.Checked.Equals($False)) -And($CheckBox3.Checked.Equals($False)) -And($CheckBox4.Checked.Equals($False))) {$CheckBox1.Checked = $True}
})
$GroupBox1.Controls.Add($CheckBox1)

$Button1 = New-Object System.Windows.Forms.Button
$Button1.Location = New-Object System.Drawing.Size(125,15)
$Button1.Size = New-Object System.Drawing.Size(60,20)
$Button1.Text = "編集(&W)"
$Button1.Add_Click({
	EditDialog "英字小文字[a-z]" $Label1.Text "abcdefghijklmnopqrstuvwxyz" "[^a-z]" 1
})
$GroupBox1.Controls.Add($Button1)

$Label1 = New-Object System.Windows.Forms.Label
$Label1.Location = New-Object System.Drawing.Size(195,15)
$Label1.Size = New-Object System.Drawing.Size(220,20)
$Label1.Text = "abcdefghijklmnopqrstuvwxyz"
$Label1.TextAlign = "MiddleLeft"
$Label1.BorderStyle = "Fixed3D"
$Label1.Font = "ＭＳ ゴシック,9"
$GroupBox1.Controls.Add($Label1)

$CheckBox2 = New-Object System.Windows.Forms.checkbox
$CheckBox2.Location = New-Object System.Drawing.Size(10,35)
$CheckBox2.Size = New-Object System.Drawing.Size(110,20)
$CheckBox2.Checked = $True
$CheckBox2.Text = "英字大文字(&U)"
$CheckBox2.Add_CheckedChanged({
	if ($ComboBox1.SelectedIndex.Equals(0) -Or $ComboBox1.SelectedIndex.Equals(1)) {$NumberBox1.Minimum = checkboxescount}
	if (($CheckBox1.Checked.Equals($False)) -And($CheckBox3.Checked.Equals($False)) -And($CheckBox4.Checked.Equals($False))) {$CheckBox2.Checked = $True}
})
$GroupBox1.Controls.Add($CheckBox2)

$Button2 = New-Object System.Windows.Forms.Button
$Button2.Location = New-Object System.Drawing.Size(125,35)
$Button2.Size = New-Object System.Drawing.Size(60,20)
$Button2.Text = "編集(&R)"
$Button2.Add_Click({
	EditDialog "英字大文字" $Label2.Text "ABCDEFGHIJKLMNOPQRSTUVWXYZ" "[^A-Z]" 2
})
$GroupBox1.Controls.Add($Button2)

$Label2 = New-Object System.Windows.Forms.Label
$Label2.Location = New-Object System.Drawing.Size(195,35)
$Label2.Size = New-Object System.Drawing.Size(220,20)
$Label2.Text = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
$Label2.TextAlign = "MiddleLeft"
$Label2.BorderStyle = "Fixed3D"
$Label2.Font = "ＭＳ ゴシック,9"
$GroupBox1.Controls.Add($Label2)

$CheckBox3 = New-Object System.Windows.Forms.checkbox
$CheckBox3.Location = New-Object System.Drawing.Size(10,55)
$CheckBox3.Size = New-Object System.Drawing.Size(110,20)
$CheckBox3.Checked = $True
$CheckBox3.Text = "数字(&N)"
$CheckBox3.Add_CheckedChanged({
	if ($ComboBox1.SelectedIndex.Equals(0) -Or $ComboBox1.SelectedIndex.Equals(1)) {$NumberBox1.Minimum = checkboxescount}
	if (($CheckBox1.Checked.Equals($False)) -And($CheckBox2.Checked.Equals($False)) -And($CheckBox4.Checked.Equals($False))) {$CheckBox3.Checked = $True}
})
$GroupBox1.Controls.Add($CheckBox3)

$Button3 = New-Object System.Windows.Forms.Button
$Button3.Location = New-Object System.Drawing.Size(125,55)
$Button3.Size = New-Object System.Drawing.Size(60,20)
$Button3.Text = "編集(&B)"
$Button3.Add_Click({
	EditDialog "数字[0-9]" $Label3.Text "0123456789" "\D" 3
})
$GroupBox1.Controls.Add($Button3)

$Label3 = New-Object System.Windows.Forms.Label
$Label3.Location = New-Object System.Drawing.Size(195,55)
$Label3.Size = New-Object System.Drawing.Size(220,20)
$Label3.Text = "0123456789"
$Label3.TextAlign = "MiddleLeft"
$Label3.BorderStyle = "Fixed3D"
$Label3.Font = "ＭＳ ゴシック,9"
$GroupBox1.Controls.Add($Label3)

$CheckBox4 = New-Object System.Windows.Forms.checkbox
$CheckBox4.Location = New-Object System.Drawing.Size(10,75)
$CheckBox4.Size = New-Object System.Drawing.Size(110,20)
$CheckBox4.Checked = $True
$CheckBox4.Text = "記号(&M)"
$CheckBox4.Add_CheckedChanged({
	if ($ComboBox1.SelectedIndex.Equals(0) -Or $ComboBox1.SelectedIndex.Equals(1)) {$NumberBox1.Minimum = checkboxescount}
	if (($CheckBox1.Checked.Equals($False)) -And($CheckBox2.Checked.Equals($False)) -And($CheckBox3.Checked.Equals($False))) {$CheckBox4.Checked = $True}
})
$GroupBox1.Controls.Add($CheckBox4)

$Button4 = New-Object System.Windows.Forms.Button
$Button4.Location = New-Object System.Drawing.Size(125,75)
$Button4.Size = New-Object System.Drawing.Size(60,20)
$Button4.Text = "編集(&Y)"
$Button4.Add_Click({
	EditDialog "記号" ($Label4.Text.Replace("&&","&")) '!"#$%&''()*+,-./:;<=>?@[\]^_`{|}~' '[^-^@\[;:\],./!"#$%&&''()=~|`{+*}<>?_\\]' 4
})
$GroupBox1.Controls.Add($Button4)

$Label4 = New-Object System.Windows.Forms.Label
$Label4.Location = New-Object System.Drawing.Size(195,75)
$Label4.Size = New-Object System.Drawing.Size(220,20)
$Label4.Text = '!"#$%&&''()*+,-./:;<=>?@[\]^_`{|}~'
$Label4.TextAlign = "MiddleLeft"
$Label4.BorderStyle = "Fixed3D"
$Label4.Font = "ＭＳ ゴシック,9"
$GroupBox1.Controls.Add($Label4)

$CheckBox5 = New-Object System.Windows.Forms.checkbox
$CheckBox5.Location = New-Object System.Drawing.Size(10,95)
$CheckBox5.Size = New-Object System.Drawing.Size(100,20)
$CheckBox5.Text = "スペース(&S)"
$CheckBox5.Add_CheckedChanged({
	if ($ComboBox1.SelectedIndex.Equals(0) -Or $ComboBox1.SelectedIndex.Equals(1)) {$NumberBox1.Minimum = checkboxescount}
})
$GroupBox1.Controls.Add($CheckBox5)

$GroupBox3 = New-Object System.Windows.Forms.GroupBox
$GroupBox3.Location = New-Object System.Drawing.Size(450,10)
$GroupBox3.Size = New-Object System.Drawing.Size(130,60)
$GroupBox3.Text = "パスワードの桁数(&C)"

$NumberBox1 = New-Object System.Windows.Forms.NumericUpDown
$NumberBox1.Location = New-Object Drawing.Size(5,15)
$NumberBox1.Size = New-Object Drawing.Size(55,20)
$NumberBox1.Minimum = 4
$NumberBox1.Maximum = 1024
$NumberBox1.Text = 8
$NumberBox1.Add_TextChanged({
	$NumberBox2.Minimum = $NumberBox1.Text
})
$GroupBox3.Controls.Add($NumberBox1)

$Label6 = New-Object System.Windows.Forms.Label
$Label6.Location = New-Object System.Drawing.Size(60,15)
$Label6.Size = New-Object System.Drawing.Size(10,20)
$Label6.Text = "-"
$Label6.TextAlign = "MiddleLeft"
$Label6.Visible = $False
$GroupBox3.Controls.Add($Label6)

$NumberBox2 = New-Object System.Windows.Forms.NumericUpDown
$NumberBox2.Location = New-Object Drawing.Size(70,15)
$NumberBox2.Size = New-Object Drawing.Size(55,20)
$NumberBox2.Maximum = 1024
$NumberBox2.Text = 8
$NumberBox2.Minimum = $NumberBox2.Text
$NumberBox2.Visible = $False
$GroupBox3.Controls.Add($NumberBox2)
$Form1.Controls.Add($GroupBox3)

$CheckBox6 = New-Object System.Windows.Forms.checkbox
$CheckBox6.Location = New-Object System.Drawing.Size(5,35)
$CheckBox6.Size = New-Object System.Drawing.Size(65,20)
$CheckBox6.Text = "変動(&V)"
$CheckBox6.Add_CheckedChanged({
	switch ($CheckBox6.Checked)
	{
		$True {
			$NumberBox2.Visible = $True
			$Label6.Visible = $True
			$NumberBox2.Focus()
		}
		$False {
			$NumberBox2.Visible = $False
			$Label6.Visible = $False
			$NumberBox1.Focus()
		}
	}
})
$GroupBox3.Controls.Add($CheckBox6)

$Button5 = New-Object System.Windows.Forms.Button
$Button5.Location = New-Object System.Drawing.Size(10,135)
$Button5.Size = New-Object System.Drawing.Size(80,20)
$Button5.Text = "簡易生成(&G)"
$GenerateSettingsLoad1 = @'
	$strLower = $Label1.Text
	$strUpper = $Label2.Text
	$strNumber = $Label3.Text
	$strSign = $Label4.Text.Replace("&&","&")
	switch ($CheckBox6.Checked)
	{
		$True {$strlengthmax = $NumberBox2.Text}
		$False {$strlengthmax = $NumberBox1.Text}
	}
'@
$GenerateSettingsLoad2 = @'
	$Numberofdigits = Get-Random -input ($NumberBox1.Text..$strlengthmax)
	if ($ComboBox1.SelectedIndex.Equals(0))
	{
		$EachCharCount = 1
		if ($CheckBoxesCount -ne $Numberofdigits)
		{
			$RandomCount = $Numberofdigits - $CheckBoxesCount
		}
	}
	elseif ($ComboBox1.SelectedIndex.Equals(1))
	{
		if ($CheckBox5.Checked)
		{
			if ((($Numberofdigits - $CheckBoxesCount) % ($CheckBoxesCount -1)) -eq 0)
			{
				$EachCharCount = ($Numberofdigits - $CheckBoxesCount) / ($CheckBoxesCount -1) + 1
				$RandomCount = 0
			}
			else
			{
				$EachCharCount = [Math]::Floor(($Numberofdigits - $CheckBoxesCount) / ($CheckBoxesCount -1)) + 1
				$RandomCount = ($Numberofdigits - $CheckBoxesCount) % ($CheckBoxesCount -1)
			}
		}
		else
		{
			$EachCharCount = [Math]::Floor(($Numberofdigits - $CheckBoxesCount) / ($CheckBoxesCount)) + 1
			if ((($Numberofdigits - $CheckBoxesCount) % ($CheckBoxesCount)) -eq 0)
			{
				$RandomCount = 0
			}
			else
			{
				$RandomCount = ($Numberofdigits - $CheckBoxesCount) % ($CheckBoxesCount)
			}
		}
	}
	else
	{
		$RandomCount = $Numberofdigits
	}
'@

$Button5.Add_Click({
	if ($NumberBox1.Text -eq "") {$NumberBox1.Text = $NumberBox1.Minimum}
	if ($NumberBox2.Text -eq "") {$NumberBox2.Text = $NumberBox1.Text}
	$CheckBoxesCount = checkboxescount
	Invoke-Expression ($GenerateSettingsLoad1 -Join "`r`n")
	Invoke-Expression ($GenerateSettingsLoad2 -Join "`r`n")
	$strChars = strcharscreate
	$transcode = [Scriptblock]::Create((transcodegenerate "single"))
	$TextBox1.Text = $GeneratePassword.Invoke($Numberofdigits,$EachCharCount,$RandomCount)
	$TextBox2.Text = ([string]$transcode.Invoke()).Replace([char]0,",")
	$Button9.Enabled = $True
	$Button10.Enabled = $True
	$Label11.Text = ($TextBox1.Text -creplace "[^a-z]","").Length
	$Label13.Text = ($TextBox1.Text -creplace "[^A-Z]","").Length
	$Label15.Text = ($TextBox1.Text -replace "\D","").Length
	$Label17.Text = ($TextBox1.Text -replace '[^-^@\[;:\],./!"#$%&''()=~|`{+*}<>?_\\]',"").Length
	$Label19.Text = ($TextBox1.Text -replace "\S","").Length
	$Label22.Text = [Int]$Label11.Text + [Int]$Label13.Text + [Int]$Label15.Text + [Int]$Label17.Text + [Int]$Label19.Text
})
$Form1.Controls.Add($Button5)

$Button6 = New-Object System.Windows.Forms.Button
$Button6.Location = New-Object System.Drawing.Size(95,135)
$Button6.Size = New-Object System.Drawing.Size(80,20)
$Button6.Text = "複数生成(&D)"
$Button6.Add_Click({
	if ($NumberBox1.Text -eq "") {$NumberBox1.Text = $NumberBox1.Minimum}
	if ($NumberBox2.Text -eq "") {$NumberBox2.Text = $NumberBox1.Text}
	$CheckBoxesCount = checkboxescount
	Invoke-Expression ($GenerateSettingsLoad1 -Join "`r`n")
	$strChars = strcharscreate
	$transcode = [Scriptblock]::Create((transcodegenerate))
	$Form3.ShowDialog()
	[Void]$ListView1.Items.Clear()
	$Button16.Enabled = $False
	$Button17.Enabled = $False
	$ContextMenu.Enabled = $False
})
$Form1.Controls.Add($Button6)

$Button7 = New-Object System.Windows.Forms.Button
$Button7.Location = New-Object System.Drawing.Size(495,75)
$Button7.Size = New-Object System.Drawing.Size(85,30)
$Button7.Text = "設定保存(&P)"
$Button7.Add_Click({
	appconfig
})
$Form1.Controls.Add($Button7)

$Button8 = New-Object System.Windows.Forms.Button
$Button8.Location = New-Object System.Drawing.Size(495,105)
$Button8.Size = New-Object System.Drawing.Size(85,30)
$Button8.Text = "終了(&T)"
$Button8.Add_Click({
	$Form1.Close()
})
$Form1.Controls.Add($Button8)

$Form3 = New-Object System.Windows.Forms.Form
$Form3.Text = "PasswordGenerator"
$Form3.MinimumSize = New-Object System.Drawing.Size(600,500)
$Form3.MinimizeBox = $False
$Form3.SizeGripStyle = "Hide"
$Form3.ShowIcon = $False
$Form3.StartPosition = "CenterScreen"

$Button15 = New-Object System.Windows.Forms.Button
$Button15.Location = New-Object System.Drawing.Size(10,10)
$Button15.Size = New-Object System.Drawing.Size(60,20)
$Button15.Text = "生成(&G)"
$Button15.Add_Click({
	if ($NumberBox3.Text -eq "") {$NumberBox3.Text = 1}
	$Form4 = New-Object System.Windows.Forms.Form
	$Form4.Size = New-Object System.Drawing.Size(300,100)
	$Form4.FormBorderStyle = "FixedSingle"
	$Form4.TopMost = $True
	$Form4.Text = "PasswordGenerator"
	$Form4.ControlBox = $False
	$Form4.StartPosition = "CenterScreen"
	if ($RadioButton1.Checked)
	{
		$ProgressBar1 = New-Object System.Windows.Forms.ProgressBar
		$progressBar1.DataBindings.DefaultDataSourceUpdateMode = 0
		$ProgressBar1.Location = New-Object System.Drawing.Size(10,20)
		$ProgressBar1.Size = New-Object System.Drawing.Size(265,20)
		$ProgressBar1.Style = "Continuous"
		$ProgressBar1.Minimum = 1
		$ProgressBar1.Maximum = $NumberBox3.Text
		$ProgressBar1.Step = 1
		$Form4.Controls.Add($ProgressBar1)
	}
	else
	{
		$Label9 = New-Object System.Windows.Forms.Label
		$Label9.Location = New-Object System.Drawing.Size(20,20)
		$Label9.Size = New-Object System.Drawing.Size(220,20)
		$Label9.Text = "パスワード生成中・・・"
		$Label9.TextAlign = "MiddleLeft"
		$Form4.Controls.Add($Label9)
	}
	[Void]$Form4.Show()

	$SessionState = [System.Management.Automation.Runspaces.InitialSessionState]::CreateDefault()
	$EntryVariable = "ComboBox1","NumberBox1","NumberBox2","NumberBox3","Checkbox5","GenerateSettingsLoad2","strChars","transcode","strlengthmax","GetRandom","CheckBoxesCount","GenerateRandomString","GeneratePassword","eachpartchars","Form4","RadioButton1","ProgressBar1"
	$SetVariableStr = New-Object System.Collections.Generic.List[System.String]
	foreach ($i in $EntryVariable)
	{
		$SetVariableStr.Add('$SessionState.Variables.Add((New-Object System.Management.Automation.Runspaces.SessionStateVariableEntry(''' + $i + ''',$' + $i + ',$null)))')
	}
	$SetVariable = [Scriptblock]::Create($SetVariableStr -Join ";")
	$SetVariable.Invoke()
	$RunspacePool = [RunspaceFactory]::CreateRunspacePool(1,2,$SessionState,$Host)
	$RunspacePool.ApartmentState = 'STA'
	$RunspacePool.Open()
	$Job = [PowerShell]::Create()
	$Job.AddScript({
		$ListTable = New-Object object[] ($NumberBox3.Text)
		foreach ($i in (0..($NumberBox3.Text -1)))
		{
			Invoke-Expression ($GenerateSettingsLoad2 -Join "`r`n")
			$password = & $GeneratePassword $Numberofdigits $EachCharCount $RandomCount
			$ListTable[$i] = New-Object PSObject -Property @{
				"No." = $i + 1
				"パスワード" = $password
				"読み方" = ([string]$transcode.Invoke()).Replace([char]0,",")
			}
			if ($RadioButton1.Checked)
			{
				$Form4.Text = ("パスワード生成中・・・(" + ($i + 1) + "/" + $NumberBox3.Text + ")完了")
				$ProgressBar1.Value = $i + 1
			}
		}
		return $ListTable
	})
	$Job.RunspacePool = $RunspacePool
	$BackJob = New-Object PSObject -Property @{
		Pipe = $Job
		Result = $Job.BeginInvoke()
	}
	[Void]$ListView1.Items.Clear()
	$Button15.Enabled = $False
	$Button16.Enabled = $False
	$Button17.Enabled = $False
	$Button18.Enabled = $False
	$BackJob.Result.AsyncWaitHandle.WaitOne()
	$Global:ListTable = $BackJob.Pipe.EndInvoke($BackJob.Result)
	for ($i = 0;$i -lt $NumberBox3.Text;$i ++)
	{
		[Void]$ListView1.Items.Add(($i + 1))
		[Void]$ListView1.Items[$i].SubItems.Add($ListTable[$i].{パスワード})
		[Void]$ListView1.Items[$i].SubItems.Add($ListTable[$i].{読み方})
	}
	$ListView1.AutoResizeColumns([Windows.Forms.ColumnHeaderAutoResizeStyle]::HeaderSize)
	[Void]$Form4.Close()
	[System.Windows.Forms.Application]::DoEvents()
	$Button15.Enabled = $True
	$Button16.Enabled = $True
	$Button17.Enabled = $True
	$Button18.Enabled = $True
})
$Form3.Controls.Add($Button15)

$Label7 = New-Object System.Windows.Forms.Label
$Label7.Location = New-Object System.Drawing.Size(80,10)
$Label7.Size = New-Object System.Drawing.Size(70,20)
$Label7.Text = "生成数："
$Label7.TextAlign = "MiddleLeft"
$Form3.Controls.Add($Label7)

$NumberBox3 = New-Object System.Windows.Forms.NumericUpDown
$NumberBox3.Location = New-Object Drawing.Size(150,10)
$NumberBox3.Size = New-Object Drawing.Size(70,20)
$NumberBox3.Minimum = 1
$NumberBox3.Maximum = 9999
$NumberBox3.Text = 100
$Form3.Controls.Add($NumberBox3)

$Label8 = New-Object System.Windows.Forms.Label
$Label8.Location = New-Object System.Drawing.Size(260,10)
$Label8.Size = New-Object System.Drawing.Size(120,20)
$Label8.Text = "プログレスバーの表示："
$Label8.TextAlign = "MiddleLeft"
$Label8.Anchor = ([System.Windows.Forms.AnchorStyles]([System.Windows.Forms.AnchorStyles]::Top -bor [System.Windows.Forms.AnchorStyles]::Right))
$Form3.Controls.Add($Label8)

$RadioButton1 = New-Object Windows.Forms.RadioButton
$RadioButton1.Text = "表示する(&I)"
$RadioButton1.Location = New-Object System.Drawing.Size(390,10)
$RadioButton1.Size = New-Object System.Drawing.Size(80,20)
$RadioButton1.Checked = $True
$RadioButton1.Anchor = ([System.Windows.Forms.AnchorStyles]([System.Windows.Forms.AnchorStyles]::Top -bor [System.Windows.Forms.AnchorStyles]::Right))
$Form3.Controls.Add($RadioButton1)

$RadioButton2 = New-Object Windows.Forms.RadioButton
$RadioButton2.Text = "表示しない(&E)"
$RadioButton2.Location = New-Object System.Drawing.Size(480,10)
$RadioButton2.Size = New-Object System.Drawing.Size(120,20)
$RadioButton2.Checked = $False
$RadioButton2.Anchor = ([System.Windows.Forms.AnchorStyles]([System.Windows.Forms.AnchorStyles]::Top -bor [System.Windows.Forms.AnchorStyles]::Right))
$Form3.Controls.Add($RadioButton2)

$ListView1 = New-Object System.Windows.Forms.ListView
$ListView1.Location = New-Object System.Drawing.Point(5, 40)
$ListView1.Size = New-Object System.Drawing.Size(575,370)
$ListView1.View = [System.Windows.Forms.View]::Details
$ListView1.MultiSelect = $False
$ListView1.LabelEdit = $False
$ListView1.GridLines = $False
$ListView1.FullRowSelect = $True
$ListView1.Font = "ＭＳ ゴシック,9"
$ListView1.Add_ItemSelectionChanged({
	switch ($ListView1.SelectedIndices.Count)
	{
		0 {$ContextMenu.Enabled = $False}
		1 {$ContextMenu.Enabled = $True}
	}
})
$ListView1.Anchor = ([System.Windows.Forms.AnchorStyles]([System.Windows.Forms.AnchorStyles]::Top -bor [System.Windows.Forms.AnchorStyles]::Bottom -bor [System.Windows.Forms.AnchorStyles]::Left -bor [System.Windows.Forms.AnchorStyles]::Right))
$LVcol1 = New-Object System.Windows.Forms.ColumnHeader
$LVcol1.Text = "No."
$LVcol1.Width = 50
$LVcol2 = New-Object System.Windows.Forms.ColumnHeader
$LVcol2.Text = "パスワード"
$LVcol2.Width = 300
$LVcol3 = New-Object System.Windows.Forms.ColumnHeader
$LVcol3.Text = "読み方"
$LVcol3.Width = 400
$ContextMenu = New-object System.Windows.Forms.ContextMenuStrip
$ContextMenu.Enabled = $False
$ListView1.ContextMenuStrip = $ContextMenu
$ContextMenuFile1 = New-Object System.Windows.Forms.ToolStripMenuItem
$ContextMenuFile1.Text = "パスワードをコピー"
$ContextMenuFile1.Add_Click({
	$cp::SetText($ListView1.SelectedItems[0].SubItems[1].Text)
})
[Void]$ContextMenu.Items.Add($contextMenuFile1)
$ContextMenuFile2 = New-Object System.Windows.Forms.ToolStripMenuItem
$ContextMenuFile2.Text = "読み方をコピー"
$ContextMenuFile2.Add_Click({
	$cp::SetText($ListView1.SelectedItems[0].SubItems[2].Text)
})
[Void]$ContextMenu.Items.Add($contextMenuFile2)
$ListView1.Columns.AddRange([System.Windows.Forms.ColumnHeader[]](@($LVcol1, $LVcol2, $LVcol3)))
$Form3.Controls.Add($ListView1)

$SaveDialog = New-Object Windows.Forms.SaveFileDialog
switch ($PSVersionTable.PSVersion.Major -ge 3)
{
	$True {$SaveDialog.Filter = "CSV (UTF-8 BOM付) (*.csv)|*.csv|CSV (UTF-8 BOM無) (*.csv)|*.csv|XML データ (*.xml)|*.xml|JSON データ (*.json)|*.json|Web ページ (*.html)|*.html|リッチ テキスト (*.rtf)|*.rtf|XPS ドキュメント (*.xps)|*.xps|プレーン テキスト (パスワードのみ出力) (*.txt)|*.txt"}
	$False {$SaveDialog.Filter = "CSV (UTF-8 BOM付) (*.csv)|*.csv|CSV (UTF-8 BOM無) (*.csv)|*.csv|XML データ (*.xml)|*.xml|JSON データ (*.json)|*.json|Web ページ (*.html)|*.html|リッチ テキスト (*.rtf)|*.rtf|プレーン テキスト (パスワードのみ出力) (*.txt)|*.txt"}
}
$SaveDialog.InitialDirectory = $path
$SaveDialog.Title = "保存するファイル名を指定"

$Button16 = New-Object System.Windows.Forms.Button
$Button16.Location = New-Object System.Drawing.Size(10,420)
$Button16.Size = New-Object System.Drawing.Size(60,20)
$Button16.Text = "保存(&S)"
$Button16.Enabled = $False
$Button16.Anchor =([System.Windows.Forms.AnchorStyles]([System.Windows.Forms.AnchorStyles]::Bottom -bor [System.Windows.Forms.AnchorStyles]::Left))
$Button16.Add_Click({
	if ($SaveDialog.ShowDialog() -match "OK") {
		$Button15.Enabled = $False
		$Button16.Enabled = $False
		$Button17.Enabled = $False
		$Button18.Enabled = $False
		$SessionState = [System.Management.Automation.Runspaces.InitialSessionState]::CreateDefault()
		$SessionState.Variables.Add((New-Object System.Management.Automation.Runspaces.SessionStateVariableEntry('ListTable',$ListTable,$null)))
		$SessionState.Variables.Add((New-Object System.Management.Automation.Runspaces.SessionStateVariableEntry('SaveDialog',$SaveDialog,$null)))
		$SessionState.Variables.Add((New-Object System.Management.Automation.Runspaces.SessionStateVariableEntry('CheckBox4',$CheckBox4,$null)))
		$SessionState.Variables.Add((New-Object System.Management.Automation.Runspaces.SessionStateVariableEntry('Label9',$Label9,$null)))
		$RunspacePool = [RunspaceFactory]::CreateRunspacePool(1,1,$SessionState,$Host)
		$RunspacePool.ApartmentState = 'STA'
		$RunspacePool.Open()
		$Job = [PowerShell]::Create()
		$Job.RunspacePool = $RunspacePool
		$RunJob = {
			$Form4 = New-Object System.Windows.Forms.Form
			$Form4.Size = New-Object System.Drawing.Size(300,100)
			$Form4.FormBorderStyle = "FixedSingle"
			$Form4.TopMost = $True
			$Form4.Text = "PasswordGenerator"
			$Form4.ControlBox = $False
			$Form4.StartPosition = "CenterScreen"
			$Label9 = New-Object System.Windows.Forms.Label
			$Label9.Location = New-Object System.Drawing.Size(20,20)
			$Label9.Size = New-Object System.Drawing.Size(220,20)
			$Label9.TextAlign = "MiddleLeft"
			$Form4.Controls.Add($Label9)
			[Void]$Form4.Show()
			$SessionState = [System.Management.Automation.Runspaces.InitialSessionState]::CreateDefault()
			$SessionState.Variables.Add((New-Object System.Management.Automation.Runspaces.SessionStateVariableEntry('Label9',$Label9,$null)))
			$RunspacePool = [RunspaceFactory]::CreateRunspacePool(1,1,$SessionState,$Host)
			$RunspacePool.Open()
			$DrawJob = [PowerShell]::Create()
			$DrawJob.RunspacePool = $RunspacePool
			$DrawJob.AddScript({
				$Label9.Text = "ファイルを保存しています・・・"
			})
			($DrawJob.BeginInvoke()).AsyncWaitHandle.WaitOne()
			$BackJob = New-Object PSObject -Property @{
				Pipe = $Job
				Result = $Job.BeginInvoke()
			}
			$BackJob.Result.AsyncWaitHandle.WaitOne()
			[Void]$Form4.Close()
			[System.Windows.Forms.Application]::DoEvents()
		}
		if ($SaveDialog.FilterIndex.Equals(1))
		{
			$Job.AddScript({
				$ListTable | Select-Object "No.","パスワード","読み方" | Export-Csv -Encoding utf8 -NoTypeInformation -Path $SaveDialog.FileNames[0]
			})
			$RunJob.Invoke()
		}
		elseif ($SaveDialog.FilterIndex.Equals(2))
		{
			$Job.AddScript({
				$content = $ListTable | Select-Object "No.","パスワード","読み方" | ConvertTo-CSV -NoTypeInformation
				$Utf8NoBomEncoding = New-Object System.Text.UTF8Encoding($False)
				[System.IO.File]::WriteAllLines($SaveDialog.FileNames[0], $content, $Utf8NoBomEncoding)
			})
			$RunJob.Invoke()
		}
		elseif ($SaveDialog.FilterIndex.Equals(3))
		{
			$Job.AddScript({
				$Xml = New-Object System.XML.XMLDocument
				$root = $Xml.CreateElement("Root")
				[Void]$Xml.AppendChild($root)
				filter XmlAppend {
					$data = $Xml.CreateElement("Data")
					[Void]$root.AppendChild($data)
					$number = $Xml.CreateElement("No.")
					$number.PSBase.InnerText = $_ + 1
					[Void]$data.AppendChild($number)
					$pass = $Xml.CreateElement("パスワード")
					$pass.PSBase.InnerText = $ListTable[$_].{パスワード}
					[Void]$data.AppendChild($pass)
					$read = $Xml.CreateElement("読み方")
					$read.PSBase.InnerText = $ListTable[$_].{読み方}
					[Void]$data.AppendChild($read)
				}
				0..($ListTable.count -1)| XmlAppend
				$Utf8NoBomEncoding = New-Object System.Text.UTF8Encoding($False)
				$XmlWriter = New-Object System.Xml.XmlTextWriter($SaveDialog.FileNames[0],$Utf8NoBomEncoding)
				$XmlWriter.Formatting = [System.Xml.Formatting]::Indented
				$Xml.Save($XmlWriter)
				$XmlWriter.Close()
			})
			$RunJob.Invoke()
		}
		elseif ($SaveDialog.FilterIndex.Equals(4))
		{
			$Job.AddScript({
				Add-Type -Assembly System.ServiceModel.Web,System.Runtime.Serialization
				function Create-Json
				{
					param([Parameter(ValueFromPipeline=$True)]$Hash)
					begin
					{
						$Serialize = @{}
						$JsonArr = New-Object System.Collections.ArrayList
					}
					process
					{
						$InputJson = New-Object System.Collections.ArrayList
						foreach($Input in ($Hash.GetEnumerator() | Sort-Object -Property "Name"))
						{
							$type = $Input.Value.GetType()
							$Serialize.($Type) = New-Object System.Runtime.Serialization.Json.DataContractJsonSerializer $type
							$Stream = New-Object System.IO.MemoryStream
							$Serialize.($Type).WriteObject($Stream,$Input.Value)
							switch ($ListTable.Count -gt 1)
							{
								$True {[Void]$InputJson.Add("`r`n    """ + $Input.Key + '": ' + [System.Text.Encoding]::UTF8.GetString($Stream.ToArray(),0,$Stream.ToArray().Length))}
								$False {[Void]$InputJson.Add("`r`n  """ + $Input.Key + '": ' + [System.Text.Encoding]::UTF8.GetString($Stream.ToArray(),0,$Stream.ToArray().Length))}
							}
						}
						switch ($ListTable.Count -gt 1)
						{
							$True {[Void]$JsonArr.Add("`r`n  {$($InputJson -Join ",")`r`n  }")}
							$False {[Void]$JsonArr.Add("{$($InputJson -Join ",")`r`n}")}
						}
					}
					end
					{
						switch ($ListTable.Count -gt 1)
						{
							$True {return "[$($JsonArr -Join ",")`r`n]"}
							$False {return $JsonArr}
						}
					}
				}
				$Hash = New-Object object[] ($ListTable.count)
				$i = 0
				foreach ($Input in $ListTable)
				{
					$Hash[$i] = @{
						"No." = $i + 1
						"パスワード" = $Input.{パスワード}
						"読み方" = $Input.{読み方}
					}
					$i ++
				}
				$Utf8NoBomEncoding = New-Object System.Text.UTF8Encoding($False)
				[System.IO.File]::WriteAllLines($SaveDialog.FileNames[0],($Hash | Create-Json),$Utf8NoBomEncoding)
			})
			$RunJob.Invoke()
		}
		elseif ($SaveDialog.FilterIndex.Equals(5))
		{
			$Job.AddScript({
				$head = New-Object System.Text.StringBuilder
				[Void]$head.Append("<meta charset='utf-8'><title>パスワード一覧</title><style>")
				[Void]$head.Append("BODY{font-family:ＭＳ ゴシック;background-color:#FFFFFF;}")
				[Void]$head.Append("TABLE{border-width: 1px;border-style: solid;border-color: black;border-collapse: collapse;}")
				[Void]$head.Append("TH{border-width: 1px;padding: 0px;border-style: solid;border-color: black;background-color:#00FFFF}")
				[Void]$head.Append("TD{border-width: 1px;padding: 0px;border-style: solid;border-color: black;background-color:#FFFFFF}")
				[Void]$head.Append("</style>")
				$Utf8NoBomEncoding = New-Object System.Text.UTF8Encoding($False)
				$content = $ListTable | ConvertTo-HTML -property "No.","パスワード","読み方" -head $head.ToString()
				$content = $content[0..7] + (($content[8..($content.count -1)]) -replace ' ','&nbsp;')
				[System.IO.File]::WriteAllLines($SaveDialog.FileNames[0], $content, $Utf8NoBomEncoding)
			})
			$RunJob.Invoke()
		}
		elseif ($SaveDialog.FilterIndex.Equals(6))
		{
			$Job.AddScript({
				$Xaml = New-Object System.XML.XMLDocument
				$Window = $Xaml.CreateElement('Window')
				$Window.SetAttribute("xmlns","http://schemas.microsoft.com/winfx/2006/xaml/presentation")
				$Window.SetAttribute("xmlns:x","http://schemas.microsoft.com/winfx/2006/xaml")
				[Void]$Xaml.AppendChild($Window)
				$RichTextBox = $Xaml.CreateElement("RichTextBox")
				[Void]$Window.AppendChild($RichTextBox)
				$RichTextBox.SetAttribute("Name","RTB")
				$FlowDocument = $Xaml.CreateElement("FlowDocument")
				[Void]$RichTextBox.AppendChild($FlowDocument)
				$Table = $Xaml.CreateElement("Table")
				[Void]$FlowDocument.AppendChild($Table)
				$Table = $Xaml.CreateElement("Table")
				[Void]$FlowDocument.AppendChild($Table)
				$TableColumns = $Xaml.CreateElement("Table.Columns")
				[Void]$Table.AppendChild($TableColumns)
				$TableColumn = $Xaml.CreateElement("TableColumn")
				[Void]$TableColumns.AppendChild($TableColumn)
				$TableColumn.SetAttribute("Width","40")
				$TableColumn = $Xaml.CreateElement("TableColumn")
				[Void]$TableColumns.AppendChild($TableColumn)
				$TableColumn.SetAttribute("Width","100")
				$TableColumn = $Xaml.CreateElement("TableColumn")
				[Void]$TableColumns.AppendChild($TableColumn)
				$TableColumn.SetAttribute("Width","120")
				$TableRowGroup = $Xaml.CreateElement("TableRowGroup")
				[Void]$Table.AppendChild($TableRowGroup)
				$TableRow = $Xaml.CreateElement("TableRow")
				[Void]$TableRowGroup.AppendChild($TableRow)
				$TableRow.SetAttribute("Background","SkyBlue")
				$TableCell = $Xaml.CreateElement("TableCell")
				[Void]$TableRow.AppendChild($TableCell)
				$TableCell.SetAttribute("BorderBrush","DarkGray")
				$TableCell.SetAttribute("BorderThickness","1")
				$TableCell.SetAttribute("RowSpan","1")
				$TableCell.SetAttribute("ColumnSpan","1")
				$Paragraph = $Xaml.CreateElement("Paragraph")
				[Void]$TableCell.AppendChild($Paragraph)
				$Bold = $Xaml.CreateElement("Bold")
				[Void]$Paragraph.AppendChild($Bold)
				$Bold.PSBase.InnerText = "No."
				[Void]$TableCell.AppendChild($Paragraph)
				$TableCell = $Xaml.CreateElement("TableCell")
				[Void]$TableRow.AppendChild($TableCell)
				$TableCell.SetAttribute("BorderBrush","DarkGray")
				$TableCell.SetAttribute("BorderThickness","1")
				$TableCell.SetAttribute("RowSpan","1")
				$TableCell.SetAttribute("ColumnSpan","2")
				$Paragraph = $Xaml.CreateElement("Paragraph")
				[Void]$TableCell.AppendChild($Paragraph)
				$Bold = $Xaml.CreateElement("Bold")
				[Void]$Paragraph.AppendChild($Bold)
				$Bold.PSBase.InnerText = "パスワード"
				[Void]$TableCell.AppendChild($Paragraph)
				$TableCell = $Xaml.CreateElement("TableCell")
				[Void]$TableRow.AppendChild($TableCell)
				$TableCell.SetAttribute("BorderBrush","DarkGray")
				$TableCell.SetAttribute("BorderThickness","1")
				$TableCell.SetAttribute("RowSpan","1")
				$TableCell.SetAttribute("ColumnSpan","5")
				$Paragraph = $Xaml.CreateElement("Paragraph")
				[Void]$TableCell.AppendChild($Paragraph)
				$Bold = $Xaml.CreateElement("Bold")
				[Void]$Paragraph.AppendChild($Bold)
				$Bold.PSBase.InnerText = "読み方"
				foreach ($Input in $ListTable)
				{
					$TableRow = $Xaml.CreateElement("TableRow")
					[Void]$TableRowGroup.AppendChild($TableRow)
					$TableCell = $Xaml.CreateElement("TableCell")
					[Void]$TableRow.AppendChild($TableCell)
					$TableCell.SetAttribute("BorderBrush","DarkGray")
					$TableCell.SetAttribute("BorderThickness","1")
					$TableCell.SetAttribute("RowSpan","1")
					$TableCell.SetAttribute("ColumnSpan","1")
					$Paragraph = $Xaml.CreateElement("Paragraph")
					[Void]$TableCell.AppendChild($Paragraph)
					$Paragraph.PSBase.InnerText = $Input.{No.}
					$TableCell = $Xaml.CreateElement("TableCell")
					[Void]$TableRow.AppendChild($TableCell)
					$TableCell.SetAttribute("BorderBrush","DarkGray")
					$TableCell.SetAttribute("BorderThickness","1")
					$TableCell.SetAttribute("RowSpan","1")
					$TableCell.SetAttribute("ColumnSpan","2")
					$Paragraph = $Xaml.CreateElement("Paragraph")
					[Void]$TableCell.AppendChild($Paragraph)
					$Paragraph.PSBase.InnerText = $Input.{パスワード}
					$TableCell = $Xaml.CreateElement("TableCell")
					[Void]$TableRow.AppendChild($TableCell)
					$TableCell.SetAttribute("BorderBrush","DarkGray")
					$TableCell.SetAttribute("BorderThickness","1")
					$TableCell.SetAttribute("RowSpan","1")
					$TableCell.SetAttribute("ColumnSpan","5")
					$Paragraph = $Xaml.CreateElement("Paragraph")
					[Void]$TableCell.AppendChild($Paragraph)
					$Paragraph.PSBase.InnerText = $Input.{読み方}
				}
				Add-Type -AssemblyName "WindowsBase"
				Add-Type -AssemblyName "PresentationCore"
				Add-Type -AssemblyName "PresentationFramework"
				Add-Type -AssemblyName "system.xaml"
				$HideWindow = [System.Windows.Markup.XamlReader]::Parse($Xaml.OuterXML)
				$RichText = $HideWindow.FindName("RTB")
				$TextRange = New-Object System.Windows.Documents.TextRange($RichText.Document.ContentStart,$RichText.Document.ContentEnd)
				$FileStream = New-Object System.IO.FileStream $SaveDialog.FileNames[0],"Create"
				$TextRange.Save($FileStream,[Windows.DataFormats]::Rtf)
				$FileStream.Close()
			})
			$RunJob.Invoke()
		}
		elseif ($SaveDialog.FilterIndex.Equals(7) -And ($PSVersionTable.PSVersion.Major -ge 3))
		{
			$Job.AddScript({
				$Xaml = New-Object System.XML.XMLDocument
				$Window = $Xaml.CreateElement('Window')
				$Window.SetAttribute("xmlns","http://schemas.microsoft.com/winfx/2006/xaml/presentation")
				$Window.SetAttribute("xmlns:x","http://schemas.microsoft.com/winfx/2006/xaml")
				[Void]$Xaml.AppendChild($Window)
				$RichTextBox = $Xaml.CreateElement("RichTextBox")
				[Void]$Window.AppendChild($RichTextBox)
				[Void]$StackPanel.AppendChild($RichTextBox)
				$FlowDocument = $Xaml.CreateElement("FlowDocument")
				[Void]$RichTextBox.AppendChild($FlowDocument)
				$FlowDocument.SetAttribute("Name","FlowDoc")
				$FlowDocument.SetAttribute("ColumnWidth","600")
				$Table = $Xaml.CreateElement("Table")
				[Void]$FlowDocument.AppendChild($Table)
				$Table.SetAttribute("CellSpacing","0")
				$Table.SetAttribute("BorderBrush","DarkGray")
				$Table.SetAttribute("BorderThickness","0.5")
				$TableColumns = $Xaml.CreateElement("Table.Columns")
				[Void]$Table.AppendChild($TableColumns)
				$TableColumn = $Xaml.CreateElement("TableColumn")
				[Void]$TableColumns.AppendChild($TableColumn)
				$TableColumn.SetAttribute("Width","40")
				$TableColumn = $Xaml.CreateElement("TableColumn")
				[Void]$TableColumns.AppendChild($TableColumn)
				$TableColumn.SetAttribute("Width","100")
				$TableColumn = $Xaml.CreateElement("TableColumn")
				[Void]$TableColumns.AppendChild($TableColumn)
				$TableColumn.SetAttribute("Width","100")
				$TableRowGroup = $Xaml.CreateElement("TableRowGroup")
				[Void]$Table.AppendChild($TableRowGroup)
				$TableRow = $Xaml.CreateElement("TableRow")
				[Void]$TableRowGroup.AppendChild($TableRow)
				$TableRow.SetAttribute("Background","SkyBlue")
				$TableCell = $Xaml.CreateElement("TableCell")
				[Void]$TableRow.AppendChild($TableCell)
				$TableCell.SetAttribute("BorderBrush","DarkGray")
				$TableCell.SetAttribute("BorderThickness","0.5")
				$TableCell.SetAttribute("RowSpan","1")
				$TableCell.SetAttribute("ColumnSpan","1")
				$Paragraph = $Xaml.CreateElement("Paragraph")
				[Void]$TableCell.AppendChild($Paragraph)
				$Bold = $Xaml.CreateElement("Bold")
				[Void]$Paragraph.AppendChild($Bold)
				$Bold.PSBase.InnerText = "No."
				[Void]$TableCell.AppendChild($Paragraph)
				$TableCell = $Xaml.CreateElement("TableCell")
				[Void]$TableRow.AppendChild($TableCell)
				$TableCell.SetAttribute("BorderBrush","DarkGray")
				$TableCell.SetAttribute("BorderThickness","0.5")
				$TableCell.SetAttribute("RowSpan","1")
				$TableCell.SetAttribute("ColumnSpan","2")
				$Paragraph = $Xaml.CreateElement("Paragraph")
				[Void]$TableCell.AppendChild($Paragraph)
				$Bold = $Xaml.CreateElement("Bold")
				[Void]$Paragraph.AppendChild($Bold)
				$Bold.PSBase.InnerText = "パスワード"
				[Void]$TableCell.AppendChild($Paragraph)
				$TableCell = $Xaml.CreateElement("TableCell")
				[Void]$TableRow.AppendChild($TableCell)
				$TableCell.SetAttribute("BorderBrush","DarkGray")
				$TableCell.SetAttribute("BorderThickness","0.5")
				$TableCell.SetAttribute("RowSpan","1")
				$TableCell.SetAttribute("ColumnSpan","5")
				$Paragraph = $Xaml.CreateElement("Paragraph")
				[Void]$TableCell.AppendChild($Paragraph)
				$Bold = $Xaml.CreateElement("Bold")
				[Void]$Paragraph.AppendChild($Bold)
				$Bold.PSBase.InnerText = "読み方"
				foreach ($Input in $ListTable)
				{
					$TableRow = $Xaml.CreateElement("TableRow")
					[Void]$TableRowGroup.AppendChild($TableRow)
					$TableCell = $Xaml.CreateElement("TableCell")
					[Void]$TableRow.AppendChild($TableCell)
					$TableCell.SetAttribute("BorderBrush","DarkGray")
					$TableCell.SetAttribute("BorderThickness","0.5")
					$TableCell.SetAttribute("RowSpan","1")
					$TableCell.SetAttribute("ColumnSpan","1")
					$Paragraph = $Xaml.CreateElement("Paragraph")
					[Void]$TableCell.AppendChild($Paragraph)
					$Paragraph.PSBase.InnerText = $Input.{No.}
					$TableCell = $Xaml.CreateElement("TableCell")
					[Void]$TableRow.AppendChild($TableCell)
					$TableCell.SetAttribute("BorderBrush","DarkGray")
					$TableCell.SetAttribute("BorderThickness","0.5")
					$TableCell.SetAttribute("RowSpan","1")
					$TableCell.SetAttribute("ColumnSpan","2")
					$Paragraph = $Xaml.CreateElement("Paragraph")
					[Void]$TableCell.AppendChild($Paragraph)
					$Paragraph.PSBase.InnerText = $Input.{パスワード}
					$TableCell = $Xaml.CreateElement("TableCell")
					[Void]$TableRow.AppendChild($TableCell)
					$TableCell.SetAttribute("BorderBrush","DarkGray")
					$TableCell.SetAttribute("BorderThickness","0.5")
					$TableCell.SetAttribute("RowSpan","1")
					$TableCell.SetAttribute("ColumnSpan","5")
					$Paragraph = $Xaml.CreateElement("Paragraph")
					[Void]$TableCell.AppendChild($Paragraph)
					$Paragraph.PSBase.InnerText = $Input.{読み方}
				}
				Add-Type -AssemblyName "WindowsBase"
				Add-Type -AssemblyName "PresentationCore"
				Add-Type -AssemblyName "PresentationFramework"
				Add-Type -AssemblyName "system.xaml"
				Add-Type -AssemblyName "ReachFramework"
				$HideWindow = [System.Windows.Markup.XamlReader]::Parse($Xaml.OuterXML)
				$FlowDoc = $HideWindow.FindName("FlowDoc")
				$XpsDocument = New-Object System.Windows.Xps.Packaging.XpsDocument($SaveDialog.FileNames[0],[System.IO.FileAccess]::ReadWrite)
				$XpsDocumentWriter = [System.Windows.Xps.Packaging.XpsDocument]::CreateXpsDocumentWriter($XpsDocument)
				$XpsDocumentWriter.Write($FlowDoc.DocumentPaginator)
				$XpsDocument.Close()
			})
			$RunJob.Invoke()
		}
		else 
		{
			$Job.AddScript({
				$strpassword = New-Object System.Collections.ArrayList
				0..($ListTable.count -1) | & {process{
					[Void]$strpassword.Add($ListTable[$_].{パスワード})
				}}
				$Writer = New-object System.IO.StreamWriter($SaveDialog.FileNames[0],$False,[Text.Encoding]::GetEncoding("Shift_JIS"))
				$Writer.Write(($strpassword -Join "`r`n"))
				$Writer.Close()
			})
			$RunJob.Invoke()
		}
		$Button15.Enabled = $True
		$Button16.Enabled = $True
		$Button17.Enabled = $True
		$Button18.Enabled = $True
		$SaveDialog.InitialDirectory = Split-Path $SaveDialog.FileNames[0]
	}
})
$Form3.Controls.Add($Button16)

$Button17 = New-Object System.Windows.Forms.Button
$Button17.Location = New-Object System.Drawing.Size(75,420)
$Button17.Size = New-Object System.Drawing.Size(60,20)
$Button17.Text = "消去(&D)"
$Button17.Enabled = $False
$Button17.Anchor =([System.Windows.Forms.AnchorStyles]([System.Windows.Forms.AnchorStyles]::Bottom -bor [System.Windows.Forms.AnchorStyles]::Left))
$Button17.Add_Click({
	[Void]$ListView1.Items.Clear()
	$Button16.Enabled = $False
	$Button17.Enabled = $False
	$ContextMenu.Enabled = $False
})
$Form3.Controls.Add($Button17)

$Button18 = New-Object System.Windows.Forms.Button
$Button18.Location = New-Object System.Drawing.Size(505,420)
$Button18.Size = New-Object System.Drawing.Size(70,20)
$Button18.Text = "閉じる(&C)"
$Button18.Anchor =([System.Windows.Forms.AnchorStyles]([System.Windows.Forms.AnchorStyles]::Bottom -bor [System.Windows.Forms.AnchorStyles]::Right))
$Button18.Add_Click({
	$Form3.Close()
})
$Form3.Controls.Add($Button18)

$Label5 = New-Object System.Windows.Forms.Label
$Label5.Location = New-Object System.Drawing.Size(190,135)
$Label5.Size = New-Object System.Drawing.Size(70,20)
$Label5.Text = "組み合わせ："
$Label5.TextAlign = "MiddleLeft"
$Form1.Controls.Add($Label5)

$ComboBox1 = New-Object System.Windows.Forms.ComboBox
$ComboBox1.Location = New-Object System.Drawing.Size(260,135)
$ComboBox1.Size = New-Object System.Drawing.Size(215,20)
$ComboBox1.FlatStyle = "System"
"各要素を最低一文字以上含める","スペース以外の各要素を均等に使用","無作為にランダム生成する" | % {[Void]$ComboBox1.Items.Add($_)}
$ComboBox1.SelectedIndex = 0
$ComboBox1.DropDownStyle = "DropDownList"
$ComboBox1.Add_SelectedIndexChanged({
	if ($ComboBox1.SelectedIndex.Equals(0) -Or $ComboBox1.SelectedIndex.Equals(1))
	{
		$NumberBox1.Minimum = checkboxescount
	}
	else
	{
		$NumberBox1.Minimum = 1
	}
})
$Form1.Controls.Add($ComboBox1)

$TextBox1 = New-Object System.Windows.Forms.TextBox
$TextBox1.Location = New-Object System.Drawing.Size(10,160)
$TextBox1.Size = New-Object System.Drawing.Size(500,20)
$TextBox1.Font = "ＭＳ ゴシック,10"
$TextBox1.ReadOnly = $True
$TextBox1.BackColor = [System.Drawing.Color]::FromArgb(255,255,255)
$Form1.Controls.Add($TextBox1)

$Button9 = New-Object System.Windows.Forms.Button
$Button9.Location = New-Object System.Drawing.Size(515,160)
$Button9.Size = New-Object System.Drawing.Size(65,20)
$Button9.Text = "コピー(&O)"
$Button9.Enabled = $False
$Button9.Add_Click({
	$cp::SetText($TextBox1.Text)
	$MsgBox.Invoke("クリップボードにパスワードをコピーしました。","",64)
})
$Form1.Controls.Add($Button9)

$TextBox2 = New-Object System.Windows.Forms.TextBox
$TextBox2.Location = New-Object System.Drawing.Size(10,185)
$TextBox2.Size = New-Object System.Drawing.Size(500,145)
$TextBox2.Multiline = $True
$TextBox2.Font = "ＭＳ ゴシック,10"
$TextBox2.ReadOnly = $True
$TextBox2.BackColor = [System.Drawing.Color]::FromArgb(255,255,255)
$Form1.Controls.Add($TextBox2)

$Button10 = New-Object System.Windows.Forms.Button
$Button10.Location = New-Object System.Drawing.Size(515,185)
$Button10.Size = New-Object System.Drawing.Size(65,20)
$Button10.Text = "コピー(&H)"
$Button10.Enabled = $False
$Button10.Add_Click({
	$cp::SetText($TextBox2.Text)
	$MsgBox.Invoke("クリップボードにパスワードの読み方をコピーしました。","",64)
})
$Form1.Controls.Add($Button10)

$GroupBox4 = New-Object System.Windows.Forms.GroupBox
$GroupBox4.Location = New-Object System.Drawing.Size(515,215)
$GroupBox4.Size = New-Object System.Drawing.Size(65,115)
$GroupBox4.Text = "カウント"
$Form1.Controls.Add($GroupBox4)

$Label10 = New-Object System.Windows.Forms.Label
$Label10.Location = New-Object System.Drawing.Size(5,15)
$Label10.Size = New-Object System.Drawing.Size(15,15)
$Label10.TextAlign = "MiddleLeft"
$Label10.Text = "小"
$GroupBox4.Controls.Add($Label10)

$Label11 = New-Object System.Windows.Forms.Label
$Label11.Location = New-Object System.Drawing.Size(25,15)
$Label11.Size = New-Object System.Drawing.Size(32,15)
$Label11.TextAlign = "MiddleLeft"
$Label11.BorderStyle = "Fixed3D"
$GroupBox4.Controls.Add($Label11)

$Label12 = New-Object System.Windows.Forms.Label
$Label12.Location = New-Object System.Drawing.Size(5,30)
$Label12.Size = New-Object System.Drawing.Size(15,15)
$Label12.TextAlign = "MiddleLeft"
$Label12.Text = "大"
$GroupBox4.Controls.Add($Label12)

$Label13 = New-Object System.Windows.Forms.Label
$Label13.Location = New-Object System.Drawing.Size(25,30)
$Label13.Size = New-Object System.Drawing.Size(32,15)
$Label13.TextAlign = "MiddleLeft"
$Label13.BorderStyle = "Fixed3D"
$GroupBox4.Controls.Add($Label13)

$Label14 = New-Object System.Windows.Forms.Label
$Label14.Location = New-Object System.Drawing.Size(5,45)
$Label14.Size = New-Object System.Drawing.Size(15,15)
$Label14.TextAlign = "MiddleLeft"
$Label14.Text = "数"
$GroupBox4.Controls.Add($Label14)

$Label15 = New-Object System.Windows.Forms.Label
$Label15.Location = New-Object System.Drawing.Size(25,45)
$Label15.Size = New-Object System.Drawing.Size(32,15)
$Label15.TextAlign = "MiddleLeft"
$Label15.BorderStyle = "Fixed3D"
$GroupBox4.Controls.Add($Label15)

$Label16 = New-Object System.Windows.Forms.Label
$Label16.Location = New-Object System.Drawing.Size(5,60)
$Label16.Size = New-Object System.Drawing.Size(15,15)
$Label16.TextAlign = "MiddleLeft"
$Label16.Text = "記"
$GroupBox4.Controls.Add($Label16)

$Label17 = New-Object System.Windows.Forms.Label
$Label17.Location = New-Object System.Drawing.Size(25,60)
$Label17.Size = New-Object System.Drawing.Size(32,15)
$Label17.TextAlign = "MiddleLeft"
$Label17.BorderStyle = "Fixed3D"
$GroupBox4.Controls.Add($Label17)

$Label18 = New-Object System.Windows.Forms.Label
$Label18.Location = New-Object System.Drawing.Size(5,75)
$Label18.Size = New-Object System.Drawing.Size(15,15)
$Label18.TextAlign = "MiddleLeft"
$Label18.Text = "ス"
$GroupBox4.Controls.Add($Label18)

$Label19 = New-Object System.Windows.Forms.Label
$Label19.Location = New-Object System.Drawing.Size(25,75)
$Label19.Size = New-Object System.Drawing.Size(32,15)
$Label19.TextAlign = "MiddleLeft"
$Label19.BorderStyle = "Fixed3D"
$GroupBox4.Controls.Add($Label19)

$GroupBox5 = New-Object System.Windows.Forms.GroupBox
$GroupBox5.Location = New-Object System.Drawing.Size(5,92)
$GroupBox5.Size = New-Object System.Drawing.Size(55,2)
$GroupBox4.Controls.Add($GroupBox5)

$Label21 = New-Object System.Windows.Forms.Label
$Label21.Location = New-Object System.Drawing.Size(5,95)
$Label21.Size = New-Object System.Drawing.Size(15,15)
$Label21.TextAlign = "MiddleLeft"
$Label21.Text = "合"
$GroupBox4.Controls.Add($Label21)

$Label22 = New-Object System.Windows.Forms.Label
$Label22.Location = New-Object System.Drawing.Size(25,95)
$Label22.Size = New-Object System.Drawing.Size(32,15)
$Label22.TextAlign = "MiddleLeft"
$Label22.BorderStyle = "Fixed3D"
$GroupBox4.Controls.Add($Label22)

function EditDialog($title,$text,$default,$pattern,$labelnumber)
{
	$Form2 = New-Object System.Windows.Forms.Form
	$Form2.Size = New-Object System.Drawing.Size(380,160)
	$Form2.Text = "PasswordGenerator"
	$Form2.FormBorderStyle = "FixedSingle"
	$Form2.MaximizeBox = $False
	$Form2.StartPosition = "CenterScreen"

	$GroupBox2 = New-Object System.Windows.Forms.GroupBox
	$GroupBox2.Location = New-Object System.Drawing.Size(10,10)
	$GroupBox2.Size = New-Object System.Drawing.Size(250,85)
	$GroupBox2.Text = $title + "に使用する文字(&C)"

	$TextBox3 = New-Object System.Windows.Forms.TextBox
	$TextBox3.Location = New-Object System.Drawing.Size(10,20)
	$TextBox3.Size = New-Object System.Drawing.Size(230,20)
	$TextBox3.Font = "ＭＳ ゴシック,10"
	$TextBox3.Text = $text
	$TextBox3.Add_TextChanged({
		if (([Regex]::Replace($TextBox3.Text,$pattern,"")).Equals("")) {$Button13.Enabled = $False} else {$Button13.Enabled = $True}
	})
	$TextBox3.Add_keyDown({
		if (($_.control.Equals($True)) -and ($_.KeyCode.Equals(([System.Windows.Forms.Keys]::A)))) {$TextBox3.SelectAll();$_.SuppressKeyPress = $True}
	})
	$GroupBox2.Controls.Add($TextBox3)

	$Button11 = New-Object System.Windows.Forms.Button
	$Button11.Location = New-Object System.Drawing.Size(105,50)
	$Button11.Size = New-Object System.Drawing.Size(65,20)
	$Button11.Text = "消去(&D)"
	$Button11.Add_Click({
		$TextBox3.Text = ""
		$TextBox3.Focus()
	})
	$GroupBox2.Controls.Add($Button11)

	$Button12 = New-Object System.Windows.Forms.Button
	$Button12.Location = New-Object System.Drawing.Size(175,50)
	$Button12.Size = New-Object System.Drawing.Size(65,20)
	$Button12.Text = "初期値(&S)"
	$Button12.Add_Click({
		$TextBox3.Text = $default
		$TextBox3.Focus()
	})
	$GroupBox2.Controls.Add($Button12)

	$Button13 = New-Object System.Windows.Forms.Button
	$Button13.Location = New-Object System.Drawing.Size(270,15)
	$Button13.Size = New-Object System.Drawing.Size(80,20)
	$Button13.Text = "OK(&O)"
	$Button13.Add_Click({
		$strArr = @(($TextBox3.Text -creplace $pattern,"").GetEnumerator())
		$str = (($strArr | Sort-Object -Unique) -Join "").Replace("&","&&")
		switch ($labelnumber)
		{
			1 {$Label1.Text = $str}
			2 {$Label2.Text = $str}
			3 {$Label3.Text = $str}
			4 {$Label4.Text = $str}
		}
		$Form2.Close()
	})
	$Form2.Controls.Add($Button13)

	$Button14 = New-Object System.Windows.Forms.Button
	$Button14.Location = New-Object System.Drawing.Size(270,40)
	$Button14.Size = New-Object System.Drawing.Size(80,20)
	$Button14.Text = "キャンセル(&N)"
	$Button14.Add_Click({
		$Form2.Close()
	})
	$Form2.Controls.Add($Button14)
	$Form2.Controls.Add($GroupBox2)
	$Form2.ActiveControl = $TextBox3
	$Form2.ShowDialog()
	$Form2.Dispose()
}

$GetRandom = New-Object System.Random
$GeneratePassword = {
	param($Numberofdigits,$EachCharCount,$RandomCount)
	if ($ComboBox1.SelectedIndex.Equals(0))
	{
		if ($Numberofdigits -eq (checkboxescount))
		{
			$Generate_Password = Get-Random -input ([String](& $eachchars)).ToCharArray() -count $Numberofdigits
		}
		else
		{
			$Generate_Password = Get-Random -input ([String](& $eachchars) + [String](& $GenerateRandomString $RandomCount)).ToCharArray() -count $Numberofdigits
		}
	}
	elseif ($ComboBox1.SelectedIndex.Equals(1))
	{
		$Generate_Password = Get-Random -input ([String](& $eachchars)).ToCharArray() -count $Numberofdigits
	}
	else
	{
		$Generate_Password = Get-Random -input ([String](& $GenerateRandomString $RandomCount)).ToCharArray() -count $Numberofdigits
	}
	return [String]::Join("",$Generate_Password)
}

$eachchars = {
	$eachchars = New-Object System.Text.StringBuilder
	foreach ($i in (1..$EachCharCount))
	{
		if ($CheckBox1.Checked) {[Void]$eachchars.Append(($strLower[$GetRandom.Next(0,$strLower.Length)]))}
		if ($CheckBox2.Checked) {[Void]$eachchars.Append(($strUpper[$GetRandom.Next(0,$strUpper.Length)]))}
		if ($CheckBox3.Checked) {[Void]$eachchars.Append(($strNumber[$GetRandom.Next(0,$strNumber.Length)]))}
		if ($CheckBox4.Checked) {[Void]$eachchars.Append(($strSign[$GetRandom.Next(0,$strSign.Length)]))}
		if ($CheckBox5.Checked -And ($i -eq 1)) {[Void]$eachchars.Append([Char]32)}
	}
	if ($ComboBox1.SelectedIndex.Equals(0) -Or $RandomCount -eq 0)
	{
		return $eachchars.ToString()
	}
	else
	{
		$randomchars = New-Object System.Collections.ArrayList
		if ($CheckBox1.Checked) {[Void]$randomchars.Add(($strLower[$GetRandom.Next(0,$strLower.Length)]))}
		if ($CheckBox2.Checked) {[Void]$randomchars.Add(($strUpper[$GetRandom.Next(0,$strUpper.Length)]))}
		if ($CheckBox3.Checked) {[Void]$randomchars.Add(($strNumber[$GetRandom.Next(0,$strNumber.Length)]))}
		if ($CheckBox4.Checked) {[Void]$randomchars.Add(($strSign[$GetRandom.Next(0,$strSign.Length)]))}
		return ($eachchars.ToString() + [String]::Join("",(Get-Random -input $randomchars -count $RandomCount)))
	}
}

function transcodegenerate($type)
{
	$targetcount = 0
	$codearray = New-Object System.Collections.Generic.List[System.String]
	switch -Regex ($strChars) {"a" {$codearray.Add(' -replace "a","えー"')}}
	switch -Regex ($strChars) {"b" {$codearray.Add(' -replace "b","びー"')}}
	switch -Regex ($strChars) {"c" {$codearray.Add(' -replace "c","しー"')}}
	switch -Regex ($strChars) {"d" {$codearray.Add(' -replace "d","でぃー"')}}
	switch -Regex ($strChars) {"e" {$codearray.Add(' -replace "e","いー"')}}
	switch -Regex ($strChars) {"f" {$codearray.Add(' -replace "f","えふ"')}}
	switch -Regex ($strChars) {"g" {$codearray.Add(' -replace "g","じー"')}}
	switch -Regex ($strChars) {"h" {$codearray.Add(' -replace "h","えいち"')}}
	switch -Regex ($strChars) {"i" {$codearray.Add(' -replace "i","あい"')}}
	switch -Regex ($strChars) {"j" {$codearray.Add(' -replace "j","じぇい"')}}
	switch -Regex ($strChars) {"k" {$codearray.Add(' -replace "k","けー"')}}
	switch -Regex ($strChars) {"l" {$codearray.Add(' -replace "l","える"')}}
	switch -Regex ($strChars) {"m" {$codearray.Add(' -replace "m","えむ"')}}
	switch -Regex ($strChars) {"n" {$codearray.Add(' -replace "n","えぬ"')}}
	switch -Regex ($strChars) {"o" {$codearray.Add(' -replace "o","おー"')}}
	switch -Regex ($strChars) {"p" {$codearray.Add(' -replace "p","ぴー"')}}
	switch -Regex ($strChars) {"q" {$codearray.Add(' -replace "q","きゅー"')}}
	switch -Regex ($strChars) {"r" {$codearray.Add(' -replace "r","あーる"')}}
	switch -Regex ($strChars) {"s" {$codearray.Add(' -replace "s","えす"')}}
	switch -Regex ($strChars) {"t" {$codearray.Add(' -replace "t","てぃー"')}}
	switch -Regex ($strChars) {"u" {$codearray.Add(' -replace "u","ゆー"')}}
	switch -Regex ($strChars) {"v" {$codearray.Add(' -replace "v","ぶい"')}}
	switch -Regex ($strChars) {"w" {$codearray.Add(' -replace "w","だぶりゅー"')}}
	switch -Regex ($strChars) {"x" {$codearray.Add(' -replace "x","えっくす"')}}
	switch -Regex ($strChars) {"y" {$codearray.Add(' -replace "y","わい"')}}
	switch -Regex ($strChars) {"z" {$codearray.Add(' -replace "z","ぜっと"')}}
	switch -Regex ($strChars) {"0" {$codearray.Add('.ToString().Replace("0","ぜろ")')}}
	switch -Regex ($strChars) {"1" {$codearray.Add('.ToString().Replace("1","いち")')}}
	switch -Regex ($strChars) {"2" {$codearray.Add('.ToString().Replace("2","にー")')}}
	switch -Regex ($strChars) {"3" {$codearray.Add('.ToString().Replace("3","さん")')}}
	switch -Regex ($strChars) {"4" {$codearray.Add('.ToString().Replace("4","よん")')}}
	switch -Regex ($strChars) {"5" {$codearray.Add('.ToString().Replace("5","ご")')}}
	switch -Regex ($strChars) {"6" {$codearray.Add('.ToString().Replace("6","ろく")')}}
	switch -Regex ($strChars) {"7" {$codearray.Add('.ToString().Replace("7","なな")')}}
	switch -Regex ($strChars) {"8" {$codearray.Add('.ToString().Replace("8","はち")')}}
	switch -Regex ($strChars) {"9" {$codearray.Add('.ToString().Replace("9","きゅう")')}}
	switch -Regex ($strChars) {"'" {$codearray.Add('.ToString().Replace("''","シングルクォート")')}}
	switch -Regex ($strChars) {"-" {$codearray.Add('.ToString().Replace("-","ハイフン")')}}
	switch -Regex ($strChars) {"!" {$codearray.Add('.ToString().Replace("!","エクスクラメーション")')}}
	switch -Regex ($strChars) {"""" {$codearray.Add('.ToString().Replace("""","ダブルクォート")')}}
	switch -Regex ($strChars) {"#" {$codearray.Add('.ToString().Replace("#","番号記号")')}}
	switch -Regex ($strChars) {"\$" {$codearray.Add('.ToString().Replace("$","ドル記号")')}}
	switch -Regex ($strChars) {"%" {$codearray.Add('.ToString().Replace("%","パーセント")')}}
	switch -Regex ($strChars) {"&" {$codearray.Add('.ToString().Replace("&","アンパサンド")')}}
	switch -Regex ($strChars) {"\(" {$codearray.Add('.ToString().Replace("(","左カッコ")')}}
	switch -Regex ($strChars) {"\)" {$codearray.Add('.ToString().Replace(")","右カッコ")')}}
	switch -Regex ($strChars) {"\*" {$codearray.Add('.ToString().Replace("*","アスタリスク")')}}
	switch -Regex ($strChars) {"," {$codearray.Add('.ToString().Replace(",","カンマ")')}}
	switch -Regex ($strChars) {"\." {$codearray.Add('.ToString().Replace(".","ピリオド")')}}
	switch -Regex ($strChars) {"/" {$codearray.Add('.ToString().Replace("/","スラッシュ")')}}
	switch -Regex ($strChars) {":" {$codearray.Add('.ToString().Replace(":","コロン")')}}
	switch -Regex ($strChars) {";" {$codearray.Add('.ToString().Replace(";","セミコロン")')}}
	switch -Regex ($strChars) {"\?" {$codearray.Add('.ToString().Replace("?","クエスチョン")')}}
	switch -Regex ($strChars) {"@" {$codearray.Add('.ToString().Replace("@","アットマーク")')}}
	switch -Regex ($strChars) {"\[" {$codearray.Add('.ToString().Replace("[","左角カッコ")')}}
	switch -Regex ($strChars) {"\]" {$codearray.Add('.ToString().Replace("]","右角カッコ")')}}
	switch -Regex ($strChars) {"\^" {$codearray.Add('.ToString().Replace("^","キャレット")')}}
	switch -Regex ($strChars) {"_" {$codearray.Add('.ToString().Replace("_","アンダースコア")')}}
	switch -Regex ($strChars) {"``" {$codearray.Add('.ToString().Replace("``","バッククオート")')}}
	switch -Regex ($strChars) {"{" {$codearray.Add('.ToString().Replace("{","左中カッコ")')}}
	switch -Regex ($strChars) {"\|" {$codearray.Add('.ToString().Replace("|","パイプライン")')}}
	switch -Regex ($strChars) {"}" {$codearray.Add('.ToString().Replace("}","右中カッコ")')}}
	switch -Regex ($strChars) {"~" {$codearray.Add('.ToString().Replace("~","チルダ")')}}
	switch -Regex ($strChars) {"\\" {$codearray.Add('.ToString().Replace("\","円マーク")')}}
	switch -Regex ($strChars) {"\+" {$codearray.Add('.ToString().Replace("+","プラス")')}}
	switch -Regex ($strChars) {"<" {$codearray.Add('.ToString().Replace("<","左カギカッコ")')}}
	switch -Regex ($strChars) {"=" {$codearray.Add('.ToString().Replace("=","イコール")')}}
	switch -Regex ($strChars) {">" {$codearray.Add('.ToString().Replace(">","右カギカッコ")')}}
	switch -Regex ($strChars) {"\s" {$codearray.Add('.ToString().Replace([String][Char]32,"スペース")')}}
	switch ($type)
	{
		"single" {return ('return (' + ("(" * ($codearray.count -1)) + '[String]::Join([char]0,[char[]]$TextBox1.Text)' + [String]::Join(")",$codearray) + ")")}
		default {return ('return (' + ("(" * ($codearray.count -1)) + '[String]::Join([char]0,[char[]]$password)' + [String]::Join(")",$codearray) + ")")}
	}
}

function appconfig()
{
	. $appconfiginitial
	If ([string]::IsNullOrEmpty($cfg_chklower)) {$Config.AppSettings.Settings.Add("chklower", $CheckBox1.Checked)} else {$cfg_chklower.Value = $CheckBox1.Checked}
	If ([string]::IsNullOrEmpty($cfg_chkupper)) {$Config.AppSettings.Settings.Add("chkupper", $CheckBox2.Checked)} else {$cfg_chkupper.Value = $CheckBox2.Checked}
	If ([string]::IsNullOrEmpty($cfg_chknumber)) {$Config.AppSettings.Settings.Add("chknumber", $CheckBox3.Checked)} else {$cfg_chknumber.Value = $CheckBox3.Checked}
	If ([string]::IsNullOrEmpty($cfg_chksign)) {$Config.AppSettings.Settings.Add("chksign", $CheckBox4.Checked)} else {$cfg_chksign.Value = $CheckBox4.Checked}
	If ([string]::IsNullOrEmpty($cfg_chkspace)) {$Config.AppSettings.Settings.Add("chkspace", $CheckBox5.Checked)} else {$cfg_chkspace.Value = $CheckBox5.Checked}
	If ([string]::IsNullOrEmpty($cfg_strlower)) {$Config.AppSettings.Settings.Add("strlower", $Label1.Text)} else {$cfg_strlower.Value = $Label1.Text}
	If ([string]::IsNullOrEmpty($cfg_strupper)) {$Config.AppSettings.Settings.Add("strupper", $Label2.Text)} else {$cfg_strupper.Value = $Label2.Text}
	If ([string]::IsNullOrEmpty($cfg_strnumber)) {$Config.AppSettings.Settings.Add("strnumber", $Label3.Text)} else {$cfg_strnumber.Value = $Label3.Text}
	If ([string]::IsNullOrEmpty($cfg_strsign)) {$Config.AppSettings.Settings.Add("strsign", $Label4.Text)} else {$cfg_strsign.Value = $Label4.Text}
	If ([string]::IsNullOrEmpty($cfg_strlengthmin)) {$Config.AppSettings.Settings.Add("strlengthmin", $NumberBox1.Text)} else {$cfg_strlengthmin.Value = $NumberBox1.Text}
	If ([string]::IsNullOrEmpty($cfg_strlengthmax)) {$Config.AppSettings.Settings.Add("strlengthmax", $NumberBox2.Text)} else {$cfg_strlengthmax.Value = $NumberBox2.Text}
	If ([string]::IsNullOrEmpty($cfg_strlengthvariable)) {$Config.AppSettings.Settings.Add("strlengthvariable", $CheckBox6.Checked)} else {$cfg_strlengthvariable.Value = $CheckBox6.Checked}
	If ([string]::IsNullOrEmpty($cfg_useallchar)) {$Config.AppSettings.Settings.Add("useallchar", $ComboBox1.SelectedIndex)} else {$cfg_useallchar.Value = $ComboBox1.SelectedIndex}
	If ([string]::IsNullOrEmpty($cfg_quantity)) {$Config.AppSettings.Settings.Add("quantity", $NumberBox3.Text)} else {$cfg_quantity.Value = $NumberBox3.Text}
	If ([string]::IsNullOrEmpty($cfg_progressbar)) {$Config.AppSettings.Settings.Add("progressbar", $RadioButton1.Checked)} else {$cfg_progressbar.Value = $RadioButton1.Checked}
	If ([string]::IsNullOrEmpty($cfg_windowwidth)) {$Config.AppSettings.Settings.Add("windowwidth", $Form3.Size.Width)} else {$cfg_windowwidth.Value = $Form3.Size.Width}
	If ([string]::IsNullOrEmpty($cfg_windowheight)) {$Config.AppSettings.Settings.Add("windowheight", $Form3.Size.Height)} else {$cfg_windowheight.Value = $Form3.Size.Height}
	If ([string]::IsNullOrEmpty($cfg_savefiletype)) {$Config.AppSettings.Settings.Add("savefiletype", $SaveDialog.FilterIndex)} else {$cfg_savefiletype.Value = $SaveDialog.FilterIndex}
	If ([string]::IsNullOrEmpty($cfg_savefilepath)) {$Config.AppSettings.Settings.Add("savefilepath", $SaveDialog.InitialDirectory)} else {$cfg_savefilepath.Value = $SaveDialog.InitialDirectory}
	$Config.Save()
	$MsgBox.Invoke("設定を保存しました。","",64)
}

function strcharscreate()
{
	$strChars = New-Object System.Text.StringBuilder
	if ($CheckBox1.Checked) {[Void]$strChars.Append($strLower)}
	if ($CheckBox2.Checked) {[Void]$strChars.Append($strUpper)}
	if ($CheckBox3.Checked) {[Void]$strChars.Append($strNumber)}
	if ($CheckBox4.Checked) {[Void]$strChars.Append($strSign)}
	if ($CheckBox5.Checked) {[Void]$strChars.Append([Char]32)}
	return $strChars.ToString()
}

function checkboxescount()
{
	$CheckBoxesCount = 0
	if ($CheckBox1.Checked) {$CheckBoxesCount ++}
	if ($CheckBox2.Checked) {$CheckBoxesCount ++}
	if ($CheckBox3.Checked) {$CheckBoxesCount ++}
	if ($CheckBox4.Checked) {$CheckBoxesCount ++}
	if ($CheckBox5.Checked) {$CheckBoxesCount ++}
	return $CheckBoxesCount
}

$GenerateRandomString = {
	param($RandomCount)
	$GenerateRandom = New-Object System.Text.StringBuilder

	foreach ($i in (1..$RandomCount))
	{
		[Void]$GenerateRandom.Append($strChars[$GetRandom.Next(0,$strChars.Length)])
	}
	return $GenerateRandom.ToString()
}

$appconfiginitial = {
	Add-Type -AssemblyName System.Configuration
	$Map = New-Object System.Configuration.ExeConfigurationFileMap
	$Map.ExeConfigFilename = Join-Path $path "PasswordGenerator.config"
	$Config = [System.Configuration.ConfigurationManager]::OpenMappedExeConfiguration($Map,[System.Configuration.ConfigurationUserLevel]::None)

	$cfg_chklower = $Config.AppSettings.Settings["chklower"]
	$cfg_chkupper = $Config.AppSettings.Settings["chkupper"]
	$cfg_chknumber = $Config.AppSettings.Settings["chknumber"]
	$cfg_chksign = $Config.AppSettings.Settings["chksign"]
	$cfg_chkspace = $Config.AppSettings.Settings["chkspace"]
	$cfg_strlower = $Config.AppSettings.Settings["strlower"]
	$cfg_strupper = $Config.AppSettings.Settings["strupper"]
	$cfg_strnumber = $Config.AppSettings.Settings["strnumber"]
	$cfg_strsign = $Config.AppSettings.Settings["strsign"]
	$cfg_strlengthmin = $Config.AppSettings.Settings["strlengthmin"]
	$cfg_strlengthmax = $Config.AppSettings.Settings["strlengthmax"]
	$cfg_strlengthvariable = $Config.AppSettings.Settings["strlengthvariable"]
	$cfg_useallchar = $Config.AppSettings.Settings["useallchar"]
	$cfg_quantity = $Config.AppSettings.Settings["quantity"]
	$cfg_progressbar = $Config.AppSettings.Settings["progressbar"]
	$cfg_windowwidth = $Config.AppSettings.Settings["windowwidth"]
	$cfg_windowheight = $Config.AppSettings.Settings["windowheight"]
	$cfg_savefiletype = $Config.AppSettings.Settings["savefiletype"]
	$cfg_savefilepath = $Config.AppSettings.Settings["savefilepath"]
}

if ((Test-Path (Join-Path $path "PasswordGenerator.config")))
{
	. $appconfiginitial
	if ($cfg_chklower.Value -eq $True) {$CheckBox1.Checked = $True} else {$CheckBox1.Checked = $False}
	if ($cfg_chkupper.Value -eq $True) {$CheckBox2.Checked = $True} else {$CheckBox2.Checked = $False}
	if ($cfg_chknumber.Value -eq $True) {$CheckBox3.Checked = $True} else {$CheckBox3.Checked = $False}
	if ($cfg_chksign.Value -eq $True) {$CheckBox4.Checked = $True} else {$CheckBox4.Checked = $False}
	if ($cfg_chkspace.Value -eq $True) {$CheckBox5.Checked = $True} else {$CheckBox5.Checked = $False}
	$Label1.Text = $cfg_strlower.Value
	$Label2.Text = $cfg_strupper.Value
	$Label3.Text = $cfg_strnumber.Value
	$Label4.Text = $cfg_strsign.Value
	$NumberBox1.Text = $cfg_strlengthmin.Value
	$NumberBox2.Text = $cfg_strlengthmax.Value
	if ($cfg_strlengthvariable.Value -eq $True) {$CheckBox6.Checked = $True} else {$CheckBox6.Checked = $False}
	$ComboBox1.SelectedIndex = $cfg_useallchar.Value
	$NumberBox3.Text = $cfg_quantity.Value
	if ($cfg_progressbar.Value -eq $True) {$RadioButton1.Checked = $True} else {$RadioButton2.Checked = $True}
	$Form3.Size = New-Object System.Drawing.Size($cfg_windowwidth.Value,$cfg_windowheight.Value)
	$SaveDialog.FilterIndex = $cfg_savefiletype.Value
	$SaveDialog.InitialDirectory = $cfg_savefilepath.Value
}

[Void]$Form1.ShowDialog()
$Form3.Dispose()
$Form1.Dispose()
