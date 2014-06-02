$#include "luacodeTolua.h"


typedef unsigned int size_t;
typedef unsigned char GLubyte;
typedef unsigned int bituint;
typedef long long int64_t;
typedef std::string wxString;

extern bool isseq(const char * p, const char * c);
extern bool isseq_ignorecase(const char * p, const char * c);
extern void switch_console();
extern void color_print(const char * s, int color);

bool isalpha(unsigned char c);
bool isupper(unsigned char c);
bool islower(unsigned char c);
bool isdigit(unsigned char c);
bool ispunct(unsigned char c);
bool isblank(unsigned char c);
bool isalnum(unsigned char c);
bool isgraph(unsigned char c);



class wxKeyEvent
{
    int GetModifiers();
    bool ControlDown();
    bool ShiftDown();
    bool MetaDown();
    bool AltDown();
    bool CmdDown() const;
    bool isProsessed() ;
    void setProsessed(bool pro) ;
    bool HasModifiers() const { return ControlDown() || AltDown(); }
    // get the key code: an ASCII7 char or an element of wxKeyCode enum
    int GetKeyCode() const { return (int)m_keyCode; }
    // get the raw key code (platform-dependent)
    wxUint32 GetRawKeyCode() const { return m_rawCode; }
    // get the raw key flags (platform-dependent)
    wxUint32 GetRawKeyFlags() const { return m_rawFlags; }
    void GetPosition(long *xpos, long *ypos) const;
}

class ScriptManager
{
	static ScriptManager * sharedMgr();
	void init(const char * workpath);
	void dofile(const char * path);
	void dostring(const char * str);
}

class CodeEdit
{
	void SetDefaultLexer();
	void SetLexer (int lexer);
	void SetKeyWords (int keywordSet, const wxString& keyWords);

    void AddText (const wxString& text);
    void AddText (const int length, const wxString& text);
    void AddStyledText (const wxMemoryBuffer& data);
    void InsertText (int pos, const wxString& text);
    void ClearAll();
    void ClearDocumentStyle();
    int GetLength();
    int GetCharAt (int pos);
    int GetCurrentPos();
    int GetAnchor();
    int GetStyleAt (int pos);
    void Redo();
    void SetUndoCollection (bool collectUndo);
    void SelectAll();
    void SetSavePoint();
    wxMemoryBuffer GetStyledText (int startPos, int endPos);
    bool CanRedo();
    int MarkerLineFromHandle (int handle);
    void MarkerDeleteHandle (int handle);
    bool GetUndoCollection();
    int GetViewWhiteSpace();
    void SetViewWhiteSpace (int viewWS);
    int PositionFromPoint (wxPoint pt);
    int PositionFromPointClose (int x, int y);
    void GotoLine (int line);
    void GotoPos (int pos);
    void SetAnchor (int posAnchor);
    wxString GetCurLine (int* linePos = NULL);
    // Retrieve the position of the last correctly styled character.
    int GetEndStyled();

    // Convert all line endings in the document to one mode.
    void ConvertEOLs (int eolMode);

    // Retrieve the current end of line mode - one of CRLF, CR, or LF.
    int GetEOLMode();

    // Set the current end of line mode.
    void SetEOLMode (int eolMode);

    // Set the current styling position to pos and the styling mask to mask.
    // The styling mask can be used to protect some bits in each styling byte from modification.
    void StartStyling (int pos, int mask);

    // Change style from current styling position for length characters to a style
    // and move the current styling position to after this newly styled segment.
    void SetStyling (int length, int style);

    // Is drawing done first into a buffer or direct to the screen?
    bool GetBufferedDraw();

    // If drawing is buffered then each line of text is drawn into a bitmap buffer
    // before drawing it to the screen to avoid flicker.
    void SetBufferedDraw (bool buffered);

    // Change the visible size of a tab to be a multiple of the width of a space character.
    void SetTabWidth (int tabWidth);

    // Retrieve the visible size of a tab.
    int GetTabWidth();

    // Set the code page used to interpret the bytes of the document as characters.
    void SetCodePage (int codePage);

    // Set the symbol used for a particular marker number,
    void MarkerDefine (int markerNumber, int markerSymbol);

    // Set the foreground colour used for a particular marker number.
    void MarkerSetForeground (int markerNumber, const wxColour& fore);

    // Set the background colour used for a particular marker number.
    void MarkerSetBackground (int markerNumber, const wxColour& back);

    // Add a marker to a line, returning an ID which can be used to find or delete the marker.
    int MarkerAdd (int line, int markerNumber);

    // Delete a marker from a line.
    void MarkerDelete (int line, int markerNumber);

    // Delete a marker with a particular number from all lines.
    void MarkerDeleteAll (int markerNumber);

    // Get a bit mask of all the markers set on a line.
    int MarkerGet (int line);

    // Find the next line after lineStart that includes a marker in mask.
    int MarkerNext (int lineStart, int markerMask);

    // Find the previous line before lineStart that includes a marker in mask.
    int MarkerPrevious (int lineStart, int markerMask);

    // Define a marker from a bitmap
    void MarkerDefineBitmap (int markerNumber, const wxBitmap& bmp);

    // Add a set of markers to a line.
    void MarkerAddSet (int line, int markerSet);

    // Set the alpha used for a marker that is drawn in the text area, not the margin.
    void MarkerSetAlpha (int markerNumber, int alpha);

    // Set a margin to be either numeric or symbolic.
    void SetMarginType (int margin, int marginType);

    // Retrieve the type of a margin.
    int GetMarginType (int margin);

    // Set the width of a margin to a width expressed in pixels.
    void SetMarginWidth (int margin, int pixels);

    // Retrieve the width of a margin in pixels.
    int GetMarginWidth (int margin);

    // Set a mask that determines which markers are displayed in a margin.
    void SetMarginMask (int margin, int mask);

    // Retrieve the marker mask of a margin.
    int GetMarginMask (int margin);

    // Make a margin sensitive or insensitive to mouse clicks.
    void SetMarginSensitive (int margin, bool sensitive);

    // Retrieve the mouse click sensitivity of a margin.
    bool GetMarginSensitive (int margin);

    // Clear all the styles and make equivalent to the global default style.
    void StyleClearAll();

    // Set the foreground colour of a style.
    void StyleSetForeground (int style, const wxColour& fore);

    // Set the background colour of a style.
    void StyleSetBackground (int style, const wxColour& back);

    // Set a style to be bold or not.
    void StyleSetBold (int style, bool bold);

    // Set a style to be italic or not.
    void StyleSetItalic (int style, bool italic);

    // Set the size of characters of a style.
    void StyleSetSize (int style, int sizePoints);

    // Set the font of a style.
    void StyleSetFaceName (int style, const wxString& fontName);

    // Set a style to have its end of line filled or not.
    void StyleSetEOLFilled (int style, bool filled);

    // Reset the default style to its state at startup
    void StyleResetDefault();

    // Set a style to be underlined or not.
    void StyleSetUnderline (int style, bool underline);

    // Set a style to be mixed case, or to force upper or lower case.
    void StyleSetCase (int style, int caseMode);

    // Set a style to be a hotspot or not.
    void StyleSetHotSpot (int style, bool hotspot);

    // Get the alpha of the selection.
    int GetSelAlpha ();

    // Set the alpha of the selection.
    void SetSelAlpha (int alpha);

    // Set the foreground colour of the selection and whether to use this setting.
    void SetSelForeground (bool useSetting, const wxColour& fore);

    // Set the background colour of the selection and whether to use this setting.
    void SetSelBackground (bool useSetting, const wxColour& back);

    // Set the foreground colour of the caret.
    void SetCaretForeground (const wxColour& fore);

    // When key+modifier combination km is pressed perform msg.
    void CmdKeyAssign (int key, int modifiers, int cmd);

    // When key+modifier combination km is pressed do nothing.
    void CmdKeyClear (int key, int modifiers);

    // Drop all key mappings.
    void CmdKeyClearAll();

    // Set the styles for a segment of the document.
    void SetStyleBytes (int length, char* styleBytes);

    // Set a style to be visible or not.
    void StyleSetVisible (int style, bool visible);

    // Get the time in milliseconds that the caret is on and off.
    int GetCaretPeriod();

    // Get the time in milliseconds that the caret is on and off. 0 = steady on.
    void SetCaretPeriod (int milliseconds);

    // Set the set of characters making up words for when moving or selecting by word.
    // First sets deaults like SetCharsDefault.
    void SetWordChars (const wxString& characters);

    // Start a sequence of actions that is undone and redone as a unit.
    // May be nested.
    void BeginUndoAction();

    // End a sequence of actions that is undone and redone as a unit.
    void EndUndoAction();

    // Set an indicator to plain, squiggle or TT.
    void IndicatorSetStyle (int indic, int style);

    // Retrieve the style of an indicator.
    int IndicatorGetStyle (int indic);

    // Set the foreground colour of an indicator.
    void IndicatorSetForeground (int indic, const wxColour& fore);

    // Retrieve the foreground colour of an indicator.
    wxColour IndicatorGetForeground (int indic);

    // Set the foreground colour of all whitespace and whether to use this setting.
    void SetWhitespaceForeground (bool useSetting, const wxColour& fore);

    // Set the background colour of all whitespace and whether to use this setting.
    void SetWhitespaceBackground (bool useSetting, const wxColour& back);

    // Divide each styling byte into lexical class bits (default: 5) and indicator
    // bits (default: 3). If a lexer requires more than 32 lexical states, then this
    // is used to expand the possible states.
    void SetStyleBits (int bits);

    // Retrieve number of bits in style bytes used to hold the lexical state.
    int GetStyleBits();

    // Used to hold extra styling information for each line.
    void SetLineState (int line, int state);

    // Retrieve the extra styling information for a line.
    int GetLineState (int line);

    // Retrieve the last line number that has line state.
    int GetMaxLineState();

    // Is the background of the line containing the caret in a different colour?
    bool GetCaretLineVisible();

    // Display the background of the line containing the caret in a different colour.
    void SetCaretLineVisible (bool show);

    // Get the colour of the background of the line containing the caret.
    wxColour GetCaretLineBackground();

    // Set the colour of the background of the line containing the caret.
    void SetCaretLineBackground (const wxColour& back);

    // Set a style to be changeable or not (read only).
    // Experimental feature, currently buggy.
    void StyleSetChangeable (int style, bool changeable);

    // Display a auto-completion list.
    // The lenEntered parameter indicates how many characters before
    // the caret should be used to provide context.
    void AutoCompShow (int lenEntered, const wxString& itemList);

    // Remove the auto-completion list from the screen.
    void AutoCompCancel();

    // Is there an auto-completion list visible?
    bool AutoCompActive();

    // Retrieve the position of the caret when the auto-completion list was displayed.
    int AutoCompPosStart();

    // User has selected an item so remove the list and insert the selection.
    void AutoCompComplete();

    // Define a set of character that when typed cancel the auto-completion list.
    void AutoCompStops (const wxString& characterSet);

    // Change the separator character in the string setting up an auto-completion list.
    // Default is space but can be changed if items contain space.
    void AutoCompSetSeparator (int separatorCharacter);

    // Retrieve the auto-completion list separator character.
    int AutoCompGetSeparator();

    // Select the item in the auto-completion list that starts with a string.
    void AutoCompSelect (const wxString& text);

    // Should the auto-completion list be cancelled if the user backspaces to a
    // position before where the box was created.
    void AutoCompSetCancelAtStart (bool cancel);

    // Retrieve whether auto-completion cancelled by backspacing before start.
    bool AutoCompGetCancelAtStart();

    // Define a set of characters that when typed will cause the autocompletion to
    // choose the selected item.
    void AutoCompSetFillUps (const wxString& characterSet);

    // Should a single item auto-completion list automatically choose the item.
    void AutoCompSetChooseSingle (bool chooseSingle);

    // Retrieve whether a single item auto-completion list automatically choose the item.
    bool AutoCompGetChooseSingle();

    // Set whether case is significant when performing auto-completion searches.
    void AutoCompSetIgnoreCase (bool ignoreCase);

    // Retrieve state of ignore case flag.
    bool AutoCompGetIgnoreCase();

    // Display a list of strings and send notification when user chooses one.
    void UserListShow (int listType, const wxString& itemList);

    // Set whether or not autocompletion is hidden automatically when nothing matches.
    void AutoCompSetAutoHide (bool autoHide);

    // Retrieve whether or not autocompletion is hidden automatically when nothing matches.
    bool AutoCompGetAutoHide();

    // Set whether or not autocompletion deletes any word characters
    // after the inserted text upon completion.
    void AutoCompSetDropRestOfWord (bool dropRestOfWord);

    // Retrieve whether or not autocompletion deletes any word characters
    // after the inserted text upon completion.
    bool AutoCompGetDropRestOfWord();

    // Register an image for use in autocompletion lists.
    void RegisterImage (int type, const wxBitmap& bmp);

    // Clear all the registered images.
    void ClearRegisteredImages();

    // Retrieve the auto-completion list type-separator character.
    int AutoCompGetTypeSeparator();

    // Change the type-separator character in the string setting up an auto-completion list.
    // Default is '?' but can be changed if items contain '?'.
    void AutoCompSetTypeSeparator (int separatorCharacter);

    // Set the maximum width, in characters, of auto-completion and user lists.
    // Set to 0 to autosize to fit longest item, which is the default.
    void AutoCompSetMaxWidth (int characterCount);

    // Get the maximum width, in characters, of auto-completion and user lists.
    int AutoCompGetMaxWidth();

    // Set the maximum height, in rows, of auto-completion and user lists.
    // The default is 5 rows.
    void AutoCompSetMaxHeight (int rowCount);

    // Set the maximum height, in rows, of auto-completion and user lists.
    int AutoCompGetMaxHeight();

    // Set the number of spaces used for one level of indentation.
    void SetIndent (int indentSize);

    // Retrieve indentation size.
    int GetIndent();

    // Indentation will only use space characters if useTabs is false, otherwise
    // it will use a combination of tabs and spaces.
    void SetUseTabs (bool useTabs);

    // Retrieve whether tabs will be used in indentation.
    bool GetUseTabs();

    // Change the indentation of a line to a number of columns.
    void SetLineIndentation (int line, int indentSize);

    // Retrieve the number of columns that a line is indented.
    int GetLineIndentation (int line);

    // Retrieve the position before the first non indentation character on a line.
    int GetLineIndentPosition (int line);

    // Retrieve the column number of a position, taking tab width into account.
    int GetColumn (int pos);

    // Returns the position of a column (max. end of line position if beyond)
    // on a line taking the width of tabs into account.
    int FindColumn (int line, int column);

    // Can the caret preferred x position only be changed by explicit movement commands?
    bool GetCaretSticky ();

    // Stop the caret preferred x position changing when the user types.
    void SetCaretSticky (bool useCaretStickyBehaviour);

    // Switch between sticky and non-sticky: meant to be bound to a key.
    void ToggleCaretSticky ();

    // Enable/Disable convert-on-paste for line endings.
    void SetPasteConvertEndings (bool convert);

    // Get convert-on-paste setting.
    bool GetPasteConvertEndings ();

    // Duplicate the selection. If selection empty duplicate the line containing the caret.
    void SelectionDuplicate ();

    // Get the background alpha of the caret line.
    int GetCaretLineBackroundAlpha ();

    // Set background alpha of the caret line.
    void SetCaretLineBackgroundAlpha (int alpha);

    // Show or hide the horizontal scroll bar.
    void SetUseHorizontalScrollBar (bool show);

    // Is the horizontal scroll bar visible?
    bool GetUseHorizontalScrollBar();

    // Show or hide indentation guides.
    void SetIndentationGuides (bool show);

    // Are the indentation guides visible?
    bool GetIndentationGuides();

    // Set the highlighted indentation guide column.
    // 0 = no highlighted guide.
    void SetHighlightGuide (int column);

    // Get the highlighted indentation guide column.
    int GetHighlightGuide();

    // Get the position after the last visible characters on a line.
    int GetLineEndPosition (int line);

    // Get the code page used to interpret the bytes of the document as characters.
    int GetCodePage();

    // Get the foreground colour of the caret.
    wxColour GetCaretForeground();

    // In read-only mode?
    bool GetReadOnly();

    // Sets the position of the caret.
    void SetCurrentPos (int pos);

    // Sets the position that starts the selection - this becomes the anchor.
    void SetSelectionStart (int pos);

    // Returns the position at the start of the selection.
    int GetSelectionStart();

    // Sets the position that ends the selection - this becomes the currentPosition.
    void SetSelectionEnd (int pos);

    // Returns the position at the end of the selection.
    int GetSelectionEnd();

    // Sets the print magnification added to the point size of each style for printing.
    void SetPrintMagnification (int magnification);

    // Returns the print magnification.
    int GetPrintMagnification();

    // Modify colours when printing for clearer printed text.
    void SetPrintColourMode (int mode);

    // Returns the print colour mode.
    int GetPrintColourMode();

    // Find some text in the document.
    int FindText (int minPos, int maxPos, const wxString& text, int flags=0, int* lengthFound = NULL);

    // On Windows, will draw the document into a display context such as a printer.
    int FormatRange (bool doDraw, int startPos, int endPos, wxDC* draw, wxDC* target, wxRect renderRect, wxRect pageRect);

    // Retrieve the display line at the top of the display.
    int GetFirstVisibleLine();

    // Retrieve the contents of a line.
    wxString GetLine (int line);

    // Returns the number of lines in the document. There is always at least one.
    int GetLineCount();

    // Sets the size in pixels of the left margin.
    void SetMarginLeft (int pixels);

    // Returns the size in pixels of the left margin.
    int GetMarginLeft();

    // Sets the size in pixels of the right margin.
    void SetMarginRight (int pixels);

    // Returns the size in pixels of the right margin.
    int GetMarginRight();

    // Is the document different from when it was last saved?
    bool GetModify();

    // Select a range of text.
    void SetSelection (int startPos, int endPos);

    // Retrieve the selected text.
    wxString GetSelectedText();

    // Retrieve a range of text.
    wxString GetTextRange (int startPos, int endPos);

    // Draw the selection in normal style or with selection highlighted.
    void HideSelection (bool hide);

    // Retrieve the line containing a position.
    int LineFromPosition (int pos);

    // Retrieve the position at the start of a line.
    int PositionFromLine (int line);

    // Scroll horizontally and vertically.
    void LineScroll (int columns, int lines);

    // Ensure the caret is visible.
    void EnsureCaretVisible();

    // Replace the selected text with the argument text.
    void ReplaceSelection (const wxString& text);

    // Set to read only or read write.
    void SetReadOnly (bool readOnly);

    // Will a paste succeed?
    bool CanPaste();

    // Are there any undoable actions in the undo history?
    bool CanUndo();

    // Delete the undo history.
    void EmptyUndoBuffer();

    // Undo one action in the undo history.
    void Undo();

    // Cut the selection to the clipboard.
    void Cut();

    // Copy the selection to the clipboard.
    void Copy();

    // Paste the contents of the clipboard into the document replacing the selection.
    void Paste();

    // Clear the selection.
    void Clear();

    // Replace the contents of the document with the argument text.
    void SetText (const wxString& text);

    // Retrieve all the text in the document.
    wxString GetText();

    // Retrieve the number of characters in the document.
    int GetTextLength();

    // Set to overtype (true) or insert mode.
    void SetOvertype (bool overtype);

    // Returns true if overtype mode is active otherwise false is returned.
    bool GetOvertype();

    // Set the width of the insert mode caret.
    void SetCaretWidth (int pixels);

    // Returns the width of the insert mode caret.
    int GetCaretWidth();

    // Sets the position that starts the target which is used for updating the
    // document without affecting the scroll position.
    void SetTargetStart (int pos);

    // Get the position that starts the target.
    int GetTargetStart();

    // Sets the position that ends the target which is used for updating the
    // document without affecting the scroll position.
    void SetTargetEnd (int pos);

    // Get the position that ends the target.
    int GetTargetEnd();

    // Replace the target text with the argument text.
    // Text is counted so it can contain NULs.
    // Returns the length of the replacement text.
    int ReplaceTarget (const wxString& text);

    // Replace the target text with the argument text after \d processing.
    // Text is counted so it can contain NULs.
    // Looks for \d where d is between 1 and 9 and replaces these with the strings
    // matched in the last search operation which were surrounded by \( and \).
    // Returns the length of the replacement text including any change
    // caused by processing the \d patterns.
    int ReplaceTargetRE (const wxString& text);

    // Search for a counted string in the target and set the target to the found
    // range. Text is counted so it can contain NULs.
    // Returns length of range or -1 for failure in which case target is not moved.
    int SearchInTarget (const wxString& text);

    // Set the search flags used by SearchInTarget.
    void SetSearchFlags (int flags);

    // Get the search flags used by SearchInTarget.
    int GetSearchFlags();

    // Show a call tip containing a definition near position pos.
    void CallTipShow (int pos, const wxString& definition);

    // Remove the call tip from the screen.
    void CallTipCancel();

    // Is there an active call tip?
    bool CallTipActive();

    // Retrieve the position where the caret was before displaying the call tip.
    int CallTipPosAtStart();

    // Highlight a segment of the definition.
    void CallTipSetHighlight (int startPos, int endPos);

    // Set the background colour for the call tip.
    void CallTipSetBackground (const wxColour& back);

    // Set the foreground colour for the call tip.
    void CallTipSetForeground (const wxColour& fore);

    // Set the foreground colour for the highlighted part of the call tip.
    void CallTipSetForegroundHighlight (const wxColour& fore);

    // Enable use of STYLE_CALLTIP and set call tip tab size in pixels.
    void CallTipUseStyle (int tabSize);

    // Find the display line of a document line taking hidden lines into account.
    int VisibleFromDocLine (int line);

    // Find the document line of a display line taking hidden lines into account.
    int DocLineFromVisible (int lineDisplay);

    // The number of display lines needed to wrap a document line
    int WrapCount (int line);

    // Set the fold level of a line.
    // This encodes an integer level along with flags indicating whether the
    // line is a header and whether it is effectively white space.
    void SetFoldLevel (int line, int level);

    // Retrieve the fold level of a line.
    int GetFoldLevel (int line);

    // Find the last child line of a header line.
    int GetLastChild (int line, int level);

    // Find the parent line of a child line.
    int GetFoldParent (int line);

    // Make a range of lines visible.
    void ShowLines (int lineStart, int lineEnd);

    // Make a range of lines invisible.
    void HideLines (int lineStart, int lineEnd);

    // Is a line visible?
    bool GetLineVisible (int line);

    // Show the children of a header line.
    void SetFoldExpanded (int line, bool expanded);

    // Is a header line expanded?
    bool GetFoldExpanded (int line);

    // Switch a header line between expanded and contracted.
    void ToggleFold (int line);

    // Ensure a particular line is visible by expanding any header line hiding it.
    void EnsureVisible (int line);

    // Set some style options for folding.
    void SetFoldFlags (int flags);

    // Ensure a particular line is visible by expanding any header line hiding it.
    // Use the currently set visibility policy to determine which range to display.
    void EnsureVisibleEnforcePolicy (int line);

    // Sets whether a tab pressed when caret is within indentation indents.
    void SetTabIndents (bool tabIndents);

    // Does a tab pressed when caret is within indentation indent?
    bool GetTabIndents();

    // Sets whether a backspace pressed when caret is within indentation unindents.
    void SetBackSpaceUnIndents (bool bsUnIndents);

    // Does a backspace pressed when caret is within indentation unindent?
    bool GetBackSpaceUnIndents();

    // Sets the time the mouse must sit still to generate a mouse dwell event.
    void SetMouseDwellTime (int periodMilliseconds);

    // Retrieve the time the mouse must sit still to generate a mouse dwell event.
    int GetMouseDwellTime();

    // Get position of start of word.
    int WordStartPosition (int pos, bool onlyWordCharacters);

    // Get position of end of word.
    int WordEndPosition (int pos, bool onlyWordCharacters);

    // Sets whether text is word wrapped.
    void SetWrapMode (int mode);

    // Retrieve whether text is word wrapped.
    int GetWrapMode();

    // Set the display mode of visual flags for wrapped lines.
    void SetWrapVisualFlags (int wrapVisualFlags);

    // Retrive the display mode of visual flags for wrapped lines.
    int GetWrapVisualFlags();

    // Set the location of visual flags for wrapped lines.
    void SetWrapVisualFlagsLocation (int wrapVisualFlagsLocation);

    // Retrive the location of visual flags for wrapped lines.
    int GetWrapVisualFlagsLocation();

    // Set the start indent for wrapped lines.
    void SetWrapStartIndent (int indent);

    // Retrive the start indent for wrapped lines.
    int GetWrapStartIndent();

    // Sets the degree of caching of layout information.
    void SetLayoutCache (int mode);

    // Retrieve the degree of caching of layout information.
    int GetLayoutCache();

    // Sets the document width assumed for scrolling.
    void SetScrollWidth (int pixels);

    // Retrieve the document width assumed for scrolling.
    int GetScrollWidth();

    // Measure the pixel width of some text in a particular style.
    // NUL terminated text argument.
    // Does not handle tab or control characters.
    int TextWidth (int style, const wxString& text);

    // Sets the scroll range so that maximum scroll position has
    // the last line at the bottom of the view (default).
    // Setting this to false allows scrolling one page below the last line.
    void SetEndAtLastLine (bool endAtLastLine);

    // Retrieve whether the maximum scroll position has the last
    // line at the bottom of the view.
    bool GetEndAtLastLine();

    // Retrieve the height of a particular line of text in pixels.
    int TextHeight (int line);

    // Show or hide the vertical scroll bar.
    void SetUseVerticalScrollBar (bool show);

    // Is the vertical scroll bar visible?
    bool GetUseVerticalScrollBar();

    // Append a string to the end of the document without changing the selection.
    void AppendText (const wxString& text);
    void AppendText (int length, const wxString& text);

    // Is drawing done in two phases with backgrounds drawn before foregrounds?
    bool GetTwoPhaseDraw();

    // In twoPhaseDraw mode, drawing is performed in two phases, first the background
    // and then the foreground. This avoids chopping off characters that overlap the next run.
    void SetTwoPhaseDraw (bool twoPhase);

    // Make the target range start and end be the same as the selection range start and end.
    void TargetFromSelection();

    // Join the lines in the target.
    void LinesJoin();

    // Split the lines in the target into lines that are less wide than pixelWidth
    // where possible.
    void LinesSplit (int pixels);

    // Set the colours used as a chequerboard pattern in the fold margin
    void SetFoldMarginColour (bool useSetting, const wxColour& back);
    void SetFoldMarginHiColour (bool useSetting, const wxColour& fore);

    // Move caret down one line.
    void LineDown();

    // Move caret down one line extending selection to new caret position.
    void LineDownExtend();

    // Move caret up one line.
    void LineUp();

    // Move caret up one line extending selection to new caret position.
    void LineUpExtend();

    // Move caret left one character.
    void CharLeft();

    // Move caret left one character extending selection to new caret position.
    void CharLeftExtend();

    // Move caret right one character.
    void CharRight();

    // Move caret right one character extending selection to new caret position.
    void CharRightExtend();

    // Move caret left one word.
    void WordLeft();

    // Move caret left one word extending selection to new caret position.
    void WordLeftExtend();

    // Move caret right one word.
    void WordRight();

    // Move caret right one word extending selection to new caret position.
    void WordRightExtend();

    // Move caret to first position on line.
    void Home();

    // Move caret to first position on line extending selection to new caret position.
    void HomeExtend();

    // Move caret to last position on line.
    void LineEnd();

    // Move caret to last position on line extending selection to new caret position.
    void LineEndExtend();

    // Move caret to first position in document.
    void DocumentStart();

    // Move caret to first position in document extending selection to new caret position.
    void DocumentStartExtend();

    // Move caret to last position in document.
    void DocumentEnd();

    // Move caret to last position in document extending selection to new caret position.
    void DocumentEndExtend();

    // Move caret one page up.
    void PageUp();

    // Move caret one page up extending selection to new caret position.
    void PageUpExtend();

    // Move caret one page down.
    void PageDown();

    // Move caret one page down extending selection to new caret position.
    void PageDownExtend();

    // Switch from insert to overtype mode or the reverse.
    void EditToggleOvertype();

    // Cancel any modes such as call tip or auto-completion list display.
    void Cancel();

    // Delete the selection or if no selection, the character before the caret.
    void DeleteBack();

    // If selection is empty or all on one line replace the selection with a tab character.
    // If more than one line selected, indent the lines.
    void Tab();

    // Dedent the selected lines.
    void BackTab();

    // Insert a new line, may use a CRLF, CR or LF depending on EOL mode.
    void NewLine();

    // Insert a Form Feed character.
    void FormFeed();

    // Move caret to before first visible character on line.
    // If already there move to first character on line.
    void VCHome();

    // Like VCHome but extending selection to new caret position.
    void VCHomeExtend();

    // Magnify the displayed text by increasing the sizes by 1 point.
    void ZoomIn();

    // Make the displayed text smaller by decreasing the sizes by 1 point.
    void ZoomOut();

    // Delete the word to the left of the caret.
    void DelWordLeft();

    // Delete the word to the right of the caret.
    void DelWordRight();

    // Cut the line containing the caret.
    void LineCut();

    // Delete the line containing the caret.
    void LineDelete();

    // Switch the current line with the previous.
    void LineTranspose();

    // Duplicate the current line.
    void LineDuplicate();

    // Transform the selection to lower case.
    void LowerCase();

    // Transform the selection to upper case.
    void UpperCase();

    // Scroll the document down, keeping the caret visible.
    void LineScrollDown();

    // Scroll the document up, keeping the caret visible.
    void LineScrollUp();

    // Delete the selection or if no selection, the character before the caret.
    // Will not delete the character before at the start of a line.
    void DeleteBackNotLine();

    // Move caret to first position on display line.
    void HomeDisplay();

    // Move caret to first position on display line extending selection to
    // new caret position.
    void HomeDisplayExtend();

    // Move caret to last position on display line.
    void LineEndDisplay();

    // Move caret to last position on display line extending selection to new
    // caret position.
    void LineEndDisplayExtend();

    // These are like their namesakes Home(Extend)?, LineEnd(Extend)?, VCHome(Extend)?
    // except they behave differently when word-wrap is enabled:
    // They go first to the start / end of the display line, like (Home|LineEnd)Display
    // The difference is that, the cursor is already at the point, it goes on to the start
    // or end of the document line, as appropriate for (Home|LineEnd|VCHome)(Extend)?.
    void HomeWrap();
    void HomeWrapExtend();
    void LineEndWrap();
    void LineEndWrapExtend();
    void VCHomeWrap();
    void VCHomeWrapExtend();

    // Copy the line containing the caret.
    void LineCopy();

    // Move the caret inside current view if it's not there already.
    void MoveCaretInsideView();

    // How many characters are on a line, not including end of line characters?
    int LineLength (int line);

    // Highlight the characters at two positions.
    void BraceHighlight (int pos1, int pos2);

    // Highlight the character at a position indicating there is no matching brace.
    void BraceBadLight (int pos);

    // Find the position of a matching brace or INVALID_POSITION if no match.
    int BraceMatch (int pos);

    // Are the end of line characters visible?
    bool GetViewEOL();

    // Make the end of line characters visible or invisible.
    void SetViewEOL (bool visible);

    // Retrieve a pointer to the document object.
    void* GetDocPointer();

    // Change the document object used.
    void SetDocPointer (void* docPointer);

    // Set which document modification events are sent to the container.
    void SetModEventMask (int mask);

    // Retrieve the column number which text should be kept within.
    int GetEdgeColumn();

    // Set the column number of the edge.
    // If text goes past the edge then it is highlighted.
    void SetEdgeColumn (int column);

    // Retrieve the edge highlight mode.
    int GetEdgeMode();

    // The edge may be displayed by a line (EDGE_LINE) or by highlighting text that
    // goes beyond it (EDGE_BACKGROUND) or not displayed at all (EDGE_NONE).
    void SetEdgeMode (int mode);

    // Retrieve the colour used in edge indication.
    wxColour GetEdgeColour();

    // Change the colour used in edge indication.
    void SetEdgeColour (const wxColour& colour);

    // Sets the current caret position to be the search anchor.
    void SearchAnchor();

    // Find some text starting at the search anchor.
    // Does not ensure the selection is visible.
    int SearchNext (int flags, const wxString& text);

    // Find some text starting at the search anchor and moving backwards.
    // Does not ensure the selection is visible.
    int SearchPrev (int flags, const wxString& text);

    // Retrieves the number of lines completely visible.
    int LinesOnScreen();

    // Set whether a pop up menu is displayed automatically when the user presses
    // the wrong mouse button.
    void UsePopUp (bool allowPopUp);

    // Is the selection rectangular? The alternative is the more common stream selection.
    bool SelectionIsRectangle();

    // Set the zoom level. This number of points is added to the size of all fonts.
    // It may be positive to magnify or negative to reduce.
    void SetZoom (int zoom);

    // Retrieve the zoom level.
    int GetZoom();

    // Create a new document object.
    // Starts with reference count of 1 and not selected into editor.
    void* CreateDocument();

    // Extend life of document.
    void AddRefDocument (void* docPointer);

    // Release a reference to the document, deleting document if it fades to black.
    void ReleaseDocument (void* docPointer);

    // Get which document modification events are sent to the container.
    int GetModEventMask();

    // Change internal focus flag.
    void SetSCIFocus (bool focus);

    // Get internal focus flag.
    bool GetSCIFocus();

    // Change error status - 0 = OK.
    void SetStatus (int status);

    // Get error status.
    int GetStatus();

    // Set whether the mouse is captured when its button is pressed.
    void SetMouseDownCaptures (bool captures);

    // Get whether mouse gets captured.
    bool GetMouseDownCaptures();

    // Sets the cursor to one of the SC_CURSOR* values.
    void SetCursorType (int cursorType);

    // Get cursor type.
    int GetCursorType();

    // Change the way control characters are displayed:
    // If symbol is < 32, keep the drawn way, else, use the given character.
    void SetControlCharSymbol (int symbol);

    // Get the way control characters are displayed.
    int GetControlCharSymbol();

    // Move to the previous change in capitalisation.
    void WordPartLeft();

    // Move to the previous change in capitalisation extending selection
    // to new caret position.
    void WordPartLeftExtend();

    // Move to the change next in capitalisation.
    void WordPartRight();

    // Move to the next change in capitalisation extending selection
    // to new caret position.
    void WordPartRightExtend();

    // Set the way the display area is determined when a particular line
    // is to be moved to by Find, FindNext, GotoLine, etc.
    void SetVisiblePolicy (int visiblePolicy, int visibleSlop);

    // Delete back from the current position to the start of the line.
    void DelLineLeft();

    // Delete forwards from the current position to the end of the line.
    void DelLineRight();

    // Get and Set the xOffset (ie, horizonal scroll position).
    void SetXOffset (int newOffset);
    int GetXOffset();

    // Set the last x chosen value to be the caret x position.
    void ChooseCaretX();

    // Set the way the caret is kept visible when going sideway.
    // The exclusion zone is given in pixels.
    void SetXCaretPolicy (int caretPolicy, int caretSlop);

    // Set the way the line the caret is on is kept visible.
    // The exclusion zone is given in lines.
    void SetYCaretPolicy (int caretPolicy, int caretSlop);

    // Set printing to line wrapped (SC_WRAP_WORD) or not line wrapped (SC_WRAP_NONE).
    void SetPrintWrapMode (int mode);

    // Is printing line wrapped?
    int GetPrintWrapMode();

    // Set a fore colour for active hotspots.
    void SetHotspotActiveForeground (bool useSetting, const wxColour& fore);

    // Set a back colour for active hotspots.
    void SetHotspotActiveBackground (bool useSetting, const wxColour& back);

    // Enable / Disable underlining active hotspots.
    void SetHotspotActiveUnderline (bool underline);

    // Limit hotspots to single line so hotspots on two lines don't merge.
    void SetHotspotSingleLine (bool singleLine);

    // Move caret between paragraphs (delimited by empty lines).
    void ParaDown();
    void ParaDownExtend();
    void ParaUp();
    void ParaUpExtend();

    // Given a valid document position, return the previous position taking code
    // page into account. Returns 0 if passed 0.
    int PositionBefore (int pos);

    // Given a valid document position, return the next position taking code
    // page into account. Maximum value returned is the last position in the document.
    int PositionAfter (int pos);

    // Copy a range of text to the clipboard. Positions are clipped into the document.
    void CopyRange (int startPos, int endPos);

    // Copy argument text to the clipboard.
    void CopyText (int length, const wxString& text);

    // Set the selection mode to stream (SC_SEL_STREAM=1) or rectangular (SC_SEL_RECTANGLE=2) or
    // by lines (SC_SEL_LINES=3).
    void SetSelectionMode (int mode);

    // Get the mode of the current selection.
    int GetSelectionMode();

    // Retrieve the position of the start of the selection at the given line (INVALID_POSITION if no selection on this line).
    int GetLineSelStartPosition (int line);

    // Retrieve the position of the end of the selection at the given line (INVALID_POSITION if no selection on this line).
    int GetLineSelEndPosition (int line);

    // Move caret down one line, extending rectangular selection to new caret position.
    void LineDownRectExtend();

    // Move caret up one line, extending rectangular selection to new caret position.
    void LineUpRectExtend();

    // Move caret left one character, extending rectangular selection to new caret position.
    void CharLeftRectExtend();

    // Move caret right one character, extending rectangular selection to new caret position.
    void CharRightRectExtend();

    // Move caret to first position on line, extending rectangular selection to new caret position.
    void HomeRectExtend();

    // Move caret to before first visible character on line.
    // If already there move to first character on line.
    // In either case, extend rectangular selection to new caret position.
    void VCHomeRectExtend();

    // Move caret to last position on line, extending rectangular selection to new caret position.
    void LineEndRectExtend();

    // Move caret one page up, extending rectangular selection to new caret position.
    void PageUpRectExtend();

    // Move caret one page down, extending rectangular selection to new caret position.
    void PageDownRectExtend();

    // Move caret to top of page, or one page up if already at top of page.
    void StutteredPageUp();

    // Move caret to top of page, or one page up if already at top of page, extending selection to new caret position.
    void StutteredPageUpExtend();

    // Move caret to bottom of page, or one page down if already at bottom of page.
    void StutteredPageDown();

    // Move caret to bottom of page, or one page down if already at bottom of page, extending selection to new caret position.
    void StutteredPageDownExtend();

    // Move caret left one word, position cursor at end of word.
    void WordLeftEnd();

    // Move caret left one word, position cursor at end of word, extending selection to new caret position.
    void WordLeftEndExtend();

    // Move caret right one word, position cursor at end of word.
    void WordRightEnd();

    // Move caret right one word, position cursor at end of word, extending selection to new caret position.
    void WordRightEndExtend();

    // Set the set of characters making up whitespace for when moving or selecting by word.
    // Should be called after SetWordChars.
    void SetWhitespaceChars (const wxString& characters);

    // Reset the set of characters for whitespace and word characters to the defaults.
    void SetCharsDefault();

    // Get currently selected item position in the auto-completion list
    int AutoCompGetCurrent();

    // Enlarge the document to a particular size of text bytes.
    void Allocate (int bytes);

    // Start notifying the container of all key presses and commands.
    void StartRecord();

    // Stop notifying the container of all key presses and commands.
    void StopRecord();

    // Set the lexing language of the document.
    void SetLexer (int lexer);

    // Retrieve the lexing language of the document.
    int GetLexer();

    // Colourise a segment of the document using the current lexing language.
    void Colourise (int startPos, int endPos);

    // Set up a value that may be used by a lexer for some optional feature.
    void SetProperty (const wxString& key, const wxString& value);

    // Retrieve a value that may be used by a lexer for some optional feature.
    wxString GetProperty (const wxString& key);
    wxString GetPropertyExpanded (const wxString& key);
    int GetPropertyInt (const wxString& key);

    // Retrieve the number of bits the current lexer needs for styling.
    int GetStyleBitsNeeded ();

    // Set up the key words used by the lexer.
    void SetKeyWords (int keywordSet, const wxString& keyWords);

    // Set the lexing language of the document based on string name.
    void SetLexerLanguage (const wxString& language);
    // Returns the line number of the line with the caret.
    int GetCurrentLine();

    // Extract style settings from a spec-string which is composed of one or
    // more of the following comma separated elements:
    //
    //      bold                    turns on bold
    //      italic                  turns on italics
    //      fore:[name or #RRGGBB]  sets the foreground colour
    //      back:[name or #RRGGBB]  sets the background colour
    //      face:[facename]         sets the font face name to use
    //      size:[num]              sets the font size in points
    //      eol                     turns on eol filling
    //      underline               turns on underlining
    //
    void StyleSetSpec (int styleNum, const wxString& spec);

    // Set style size, face, bold, italic, and underline attributes from
    // a wxFont's attributes.
    void StyleSetFont (int styleNum, wxFont& font);

    // Set all font style attributes at once.
    void StyleSetFontAttr (int styleNum, int size,const wxString& faceName,
                           bool bold, bool italic, bool underline,
                           wxFontEncoding encoding);

    // Set the character set of the font in a style.
    void StyleSetCharacterSet (int style, int characterSet);

    // Set the font encoding to be used by a style.
    void StyleSetFontEncoding (int style, wxFontEncoding encoding);

    // Perform one of the operations defined by the wxSCI_CMD_* constants.
    void CmdKeyExecute (int cmd);

    // Set the left and right margin in the edit area, measured in pixels.
    void SetMargins (int left, int right);
    void GetSelection (int* startPos, int* endPos);

    // Retrieve the point in the window where a position is displayed.
    wxPoint PointFromPosition (int pos);

    // Scroll enough to make the given line visible
    void ScrollToLine (int line);

    // Scroll enough to make the given column visible
    void ScrollToColumn (int column);

    // Send a message to Scintilla
    long SendMsg (int msg, long wp=0, long lp=0);


    // Set the vertical scrollbar to use instead of the ont that's built-in.
    void SetVScrollBar (wxScrollBar* bar);

    // Set the horizontal scrollbar to use instead of the ont that's built-in.
    void SetHScrollBar (wxScrollBar* bar);

    // Can be used to prevent the EVT_CHAR handler from adding the char
    bool GetLastKeydownProcessed() { return m_lastKeyDownConsumed; }
    void SetLastKeydownProcessed (bool val) { m_lastKeyDownConsumed = val; }

    // Write the contents of the editor to filename
    bool SaveFile (const wxString& filename);

    // Load the contents of filename into the editor
    bool LoadFile (const wxString& filename);
    // Specify whether anti-aliased fonts should be used.  Will have no effect
    // on some platforms, but on some (wxMac for example) can greatly improve
    // performance.
    void SetUseAntiAliasing (bool useAA);

    // Returns the current UseAntiAliasing setting.
    bool GetUseAntiAliasing();
    // Add text to the document at current position.
    void AddTextRaw (const char* text);

    // Insert string at a position.
    void InsertTextRaw (int pos, const char* text);
    // Retrieve the contents of a line.
    wxCharBuffer GetLineRaw (int line);

    // Retrieve the selected text.
    wxCharBuffer GetSelectedTextRaw();

    // Retrieve a range of text.
    wxCharBuffer GetTextRangeRaw (int startPos, int endPos);

    // Replace the contents of the document with the argument text.
    void SetTextRaw (const char* text);

    // Retrieve all the text in the document.
    wxCharBuffer GetTextRaw();

    // Append a string to the end of the document without changing the selection.
    void AppendTextRaw (const char* text);

    void CursorUpOrDown(int dir);
    wxCharBuffer GetCurLineRaw (int* linePos = NULL);
}

class MainFrame
{
    void selectPage(int index);
    /**
     * Removes the small green arrow that indicates the current line selected
     * in the call stack from whatever file its currently on.
     */
    void ClearCurrentLineMarker();

    /**
     * Removes the small yellow arrow that indicates the line that execution is
     * broken on from whatever file its currently on.
     */
    void ClearBreakLineMarker();
     /**
     * Moves the caret to the line in the edit window indicated and brings the
     * editor into focus.
     */
    void GotoNewLine(CodeEdit* edit, unsigned int newLine, bool center);

    /**
     * Moves the caret to the line in the script indicated and brings the editor
     * into focus.
     */
    OpenFileInfo* GotoOldLine(unsigned int scriptIndex, unsigned int newLine, bool center);
    /**
     * Closes all of the open files. If any of the open files need to be saved, the
     * used will be prompted. If the user cancels the save, the method returns false.
     */
    bool CloseAllFiles();
    /**
     * Saves thge specified file. If the file does not have an appropriate file
     * name associated with it, the user will be prompted for one.
     */
    bool SaveFile(OpenFileInfo* file, bool promptForName);

    /**
     * Closes the document in the specified page of the notebook.
     */
    void CloseDocument(int pageIndex, bool promptForSave = true);
    /**
     * Saves all of the open files that need to be saved.
     */
    void SaveAllFiles();

    /** 
     * Updates all of the open editors with the current font, color, etc.
     * options.
     */
    void UpdateEditorOptions();

    /**
     * Searches for the specified text in the open file.
     */
    void FindText(OpenFileInfo* file, const wxString& text, int flags);

    /**
     * Performs a find next operation in the currently open document.
     */
    void FindNext(const wxString& text, int flags);

    /** 
     * Adds the default profile to the hot keys.
     */
    void SetDefaultHotKeys();

    /**
     * Updates the text in the line and column fields on the status bar.
     */
    void UpdateStatusBarLineAndColumn();

    /**
     * Checks all of the open files needs to see if any need to be reloaded
     * because they have changed on disk.
     */
    void CheckReload();

    /**
     * Checks to see if the specified file needs to be reloaded because it has
     * changed on disk.
     */
    void CheckReload(OpenFileInfo* file);

    /**
     * Reloads the contents of the specified file from disk.
     */
    void ReloadFile(OpenFileInfo* file);
    void loadFile(OpenFileInfo* file, const char * path);
    /**
     * Returns the index of the currently selected page (or open file index) or -1
     * if no document is open.
     */
    int GetSelectedPage() const;

    /**
     * Removes all of the breakpoints from the specified file. This will also remove
     * the markers if the file is open in the editor. Note this won't remove the
     * breakpoints from the backend.
     */
    void RemoveAllLocalBreakpoints(Project::File* file);

    /**
     * Initialize source control for the current project, if this project is
     * setup to use source control. Otherwise it has no effect.
     */
    bool InitializeSourceControl();

    /**
     * Updates the source control status of all the files in the project.
     */
    void UpdateProjectFileStatus();

    /**
     * Updates the soruce control status of a single file in the project.
     */
    void UpdateProjectFileStatus(Project::File* file);

    /**
     * Gets the names of all the files selected in the project explorer widow.
     */
    void GetProjectSelectedFileNames(std::vector<std::string>& fileNames) const;

    /**
     * Gets the names of all the files selected in the notebook. Note there is only
     * ever one tab selected current explorer window.
     */
    void GetNotebookTabSelectedFileNames(std::vector<std::string>& fileNames) const;

    /**
     * Changes to a new mode and rearranges the layout.
     */
    void SetMode(Mode mode);

    /**
     * Returns the directory where application data should be stored.
     */
    wxString GetAppDataDirectory() const;

    /**
     * Shows the project settings dialog. Returns true if the user hits ok.
     */
    bool ShowProjectSettingsDialog();

    /**
     * Updates the read-only status of the currently open document's editor.
     */
    void UpdateDocumentReadOnlyStatus();

    /**
     * Callback used to notify the application when information about updates
     * available is ready.
     */
    static void UpdateCallback(Updater* updater, void* param);
    
    /**
     * Handles applying an update if one is available. If no update is available
     * the method does nothing.
     */
    void HandleUpdate();

    /**
     * Updates the syntax coloring for the file based on the file name extension.
     */
    void UpdateSyntaxColoring(OpenFileInfo* openFile);

    /**
     * Call this before closing a notebook page to handle saving, cleaning up
     * temporary files, etc. If the function returns false, the user cancelled
     * the close.
     */
    bool PreNotebookPageClose(int page, bool promptForSave = true);

    /**
     * Updates the internally stored startup placement fields based on the current
     * state of the window.
     */
    void UpdateStartUpPlacement();

    /**
     * Brings the window to the front of the z-order.
     */
    void BringToFront();

    /**
     * Matches up a project file to a script file.
     */
    Project::File* GetFileMatchingSource(const wxFileName& fileName, const std::string& source) const;

    /**
     * Called when a new file is added to the project.
     */
    void UpdateForNewFile(Project::File* file);

    /**
     * Updates the line mapper for the specified page. If the line mapper is
     * up-to-date this method does nothing.
     */
    void UpdateLineMappingIfNecessary(Project::File* file);

    /**
     * Sets the status for a file based on the specified source control status.
     */
    void SetFileStatus(Project::File* file, SourceControl::Status status);

    /**
     * Updates the line mapping for script file source based on the a diff with a disk file.
     */
    void UpdateScriptLineMappingFromFile(const Project::File* file, DebugFrontend::Script* script);

    /**
     * Marks the specified page as 'most recently used', i.e. moves it to the front of m_tabOrder.
     * If m_tabOrder does not contain pageIndex, it will be added.
     */
    void SetMostRecentlyUsedPage(int pageIndex);

    /**
     * Removes the specified page from m_tabOrder and decrement all page indices greater than pageIndex.
     */
    void RemovePageFromTabOrder(int pageIndex);
}