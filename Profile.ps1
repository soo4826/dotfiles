# $PS_HOME/Profile.ps1

# Hanyang GPU Server shortcut
function Connect-3090-1 { ssh -X ailab@server.ailab-web.kro.kr -p 2201 }
Set-Alias -Name 3090:1 -Value Connect-3090-1

function Connect-3090-2 { ssh -X ailab@server.ailab-web.kro.kr -p 2202 }
Set-Alias -Name 3090:2 -Value Connect-3090-2

function Connect-3090-3 { ssh -X ailab@server.ailab-web.kro.kr -p 2203 }
Set-Alias -Name 3090:3 -Value Connect-3090-3

function Connect-3090-4 { ssh -X ailab@server.ailab-web.kro.kr -p 2204 }
Set-Alias -Name 3090:4 -Value Connect-3090-4

function Connect-a6000 { ssh -X ailab@server.ailab-web.kro.kr -p 2205 }
Set-Alias -Name a6000 -Value Connect-a6000

function Connect-1080tix2 { ssh -X ailab@server.ailab-web.kro.kr -p 2206 }
Set-Alias -Name 1080tix2 -Value Connect-1080tix2

function Connect-2080tix2 { ssh -X ailab@server.ailab-web.kro.kr -p 2207 }
Set-Alias -Name 2080tix2 -Value Connect-2080tix2

function Connect-3080x4 { ssh -X ailab@server.ailab-web.kro.kr -p 2208 }
Set-Alias -Name 3080x4 -Value Connect-3080x4

function Connect-alien01{ ssh alien01@166.104.168.233 }
Set-Alias -Name alien01 -Value Connect-alien01
