Imports System
Imports System.IO
Imports System.Collections.Generic

Module Part1

    Sub Main()
		Dim totalSyntaxErrorScore as Integer = 0
		' Dictionnaire associant les délimiteurs ouvrants à leur pendant fermant
		Dim chunksDelimiters = CreateObject("Scripting.Dictionary")
		chunksDelimiters("(") = ")"
		chunksDelimiters("[") = "]"
		chunksDelimiters("{") = "}"
		chunksDelimiters("<") = ">"
		' Dictionnaire pour les scores en fonction des erreurs de syntaxe
		Dim syntaxErrorScores = CreateObject("Scripting.Dictionary")
		syntaxErrorScores(")") = 3
		syntaxErrorScores("]") = 57
		syntaxErrorScores("}") = 1197
		syntaxErrorScores(">") = 25137
		' Récupération et traitement des lignes
		Dim reader as StreamReader = My.Computer.FileSystem.OpenTextFileReader("input.txt")
		Dim line as String = reader.ReadLine
		While line IsNot Nothing
			Dim startingDelimiters As List(Of String) = New List(Of String)()
			For Each character As String in line
				If chunksDelimiters.Exists(character)
					startingDelimiters.Add(character)
				ElseIf chunksDelimiters.Item(startingDelimiters(startingDelimiters.Count-1)) = character
					startingDelimiters.RemoveAt(startingDelimiters.Count-1)
				Else
					totalSyntaxErrorScore += syntaxErrorScores.Item(character)
					Exit For 'On s'arrête dès la première corruption trouvée
				End If
			Next
			line = reader.ReadLine
		End While
		reader.Close()
		Console.WriteLine("Score total quant aux erreurs de syntaxe trouvées = {0}", totalSyntaxErrorScore)
    End Sub 
	
End Module