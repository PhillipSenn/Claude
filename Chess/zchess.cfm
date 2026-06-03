<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Chess</title>
<link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;600&family=Source+Serif+4:wght@300;400&display=swap" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
<style>
  *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

  body {
    background: #1a1612;
    min-height: 100vh;
    display: flex;
    align-items: center;
    justify-content: center;
    font-family: 'Source Serif 4', serif;
    color: #e8e0d0;
    padding: 20px;
  }

  .app {
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 18px;
  }

  h1 {
    font-family: 'Playfair Display', serif;
    font-weight: 400;
    font-size: 28px;
    letter-spacing: 0.12em;
    color: #c9a96e;
    text-transform: uppercase;
  }

  .status-bar {
    display: flex;
    align-items: center;
    gap: 20px;
    font-size: 14px;
    letter-spacing: 0.06em;
  }

  .turn-indicator {
    display: flex;
    align-items: center;
    gap: 8px;
    background: #2a2218;
    border: 1px solid #3d3020;
    border-radius: 4px;
    padding: 6px 14px;
    font-family: 'Playfair Display', serif;
    font-size: 13px;
    letter-spacing: 0.08em;
    color: #c9a96e;
  }

  .turn-dot {
    width: 10px;
    height: 10px;
    border-radius: 50%;
    border: 1.5px solid #555;
  }

  .turn-dot.white { background: #f0e8d8; border-color: #c9a96e; }
  .turn-dot.black { background: #1a1612; border-color: #c9a96e; }

  .game-message {
    font-size: 13px;
    color: #c9856e;
    font-family: 'Playfair Display', serif;
    letter-spacing: 0.05em;
    min-height: 20px;
    font-style: italic;
  }

  .game-message.game-over {
    font-size: 17px;
    font-style: normal;
    font-weight: 600;
    color: #f0c060;
    background: #2a1e08;
    border: 1px solid #c9a96e;
    border-radius: 4px;
    padding: 8px 24px;
    letter-spacing: 0.08em;
  }

  .board-wrapper {
    position: relative;
    display: flex;
    align-items: flex-start;
    gap: 8px;
  }

  .captured-panel {
    display: flex;
    flex-direction: column;
    gap: 12px;
    padding: 8px 6px;
    min-width: 52px;
  }

  .captured-side {
    display: flex;
    flex-direction: column;
    gap: 2px;
  }

  .captured-label {
    font-size: 10px;
    letter-spacing: 0.08em;
    color: #6b5d45;
    font-family: 'Source Serif 4', serif;
    text-transform: uppercase;
    margin-bottom: 2px;
  }

  .captured-pieces {
    display: flex;
    flex-wrap: wrap;
    gap: 0;
    width: 52px;
  }

  .captured-pieces i {
    font-size: 18px;
    line-height: 1.3;
  }

  .captured-pieces.white-captures i {
    color: #f5ead8;
    text-shadow:
      0 0 2px #2a1800,
      1px 1px 0 #3a2500,
      -1px -1px 0 #3a2500,
      1px -1px 0 #3a2500,
      -1px 1px 0 #3a2500;
  }

  .captured-pieces.black-captures i {
    color: #1a0e04;
    text-shadow:
      0 0 2px #c8a97a,
      1px 1px 0 #c8a97a,
      -1px -1px 0 #c8a97a,
      1px -1px 0 #c8a97a,
      -1px 1px 0 #c8a97a;
  }

  .coord-col {
    display: flex;
    flex-direction: column;
    gap: 0;
    justify-content: space-around;
  }

  .coord-col span {
    display: flex;
    align-items: center;
    justify-content: center;
    width: 18px;
    height: 72px;
    font-size: 11px;
    color: #6b5d45;
    font-family: 'Source Serif 4', serif;
    letter-spacing: 0.05em;
  }

  .coord-row {
    display: flex;
    justify-content: space-around;
    padding: 0 0 0 18px;
  }

  .coord-row span {
    width: 72px;
    text-align: center;
    font-size: 11px;
    color: #6b5d45;
    font-family: 'Source Serif 4', serif;
    letter-spacing: 0.05em;
    padding-top: 4px;
  }

  .board {
    display: grid;
    grid-template-columns: repeat(8, 72px);
    grid-template-rows: repeat(8, 72px);
    border: 2px solid #3d3020;
    box-shadow: 0 0 40px rgba(0,0,0,0.7), inset 0 0 0 1px #1a1612;
  }

  .square {
    width: 72px;
    height: 72px;
    display: flex;
    align-items: center;
    justify-content: center;
    position: relative;
    cursor: default;
    transition: background 0.1s;
  }

  .square.light { background: #f0d9b5; }
  .square.dark  { background: #b58863; }

  .square.reachable.light { background: #5a9e6f; }
  .square.reachable.dark  { background: #3d7a52; }

  .square.valid-move {
    cursor: pointer;
  }

  .square.valid-move.light { background: #cdd16f; }
  .square.valid-move.dark  { background: #a9ad44; }

  .square.selected.light { background: #f6f669; }
  .square.selected.dark  { background: #baca2b; }

  .square.last-move-from.light { background: #cdd16f; }
  .square.last-move-from.dark  { background: #a9ad44; }
  .square.last-move-to.light   { background: #cdd16f; }
  .square.last-move-to.dark    { background: #a9ad44; }

  .square.in-check.light { background: #e74c3c; }
  .square.in-check.dark  { background: #c0392b; }

  .valid-dot {
    position: absolute;
    width: 22px;
    height: 22px;
    border-radius: 50%;
    background: rgba(0,0,0,0.18);
    pointer-events: none;
    z-index: 1;
  }

  .valid-capture-ring {
    position: absolute;
    inset: 0;
    border-radius: 50%;
    border: 5px solid rgba(0,0,0,0.18);
    pointer-events: none;
    z-index: 1;
  }

  .piece {
    width: 62px;
    height: 62px;
    cursor: default;
    user-select: none;
    position: relative;
    z-index: 2;
    display: flex;
    align-items: center;
    justify-content: center;
  }

  .piece i {
    font-size: 38px;
    pointer-events: none;
    line-height: 1;
  }

  .piece.white-piece i {
    color: #f5ead8;
    text-shadow:
      0 0 3px #2a1800,
      1px 1px 0 #3a2500,
      -1px -1px 0 #3a2500,
      1px -1px 0 #3a2500,
      -1px 1px 0 #3a2500,
      0 2px 6px rgba(0,0,0,0.6);
  }

  .piece.black-piece i {
    color: #1a0e04;
    text-shadow:
      0 0 3px #c8a97a,
      1px 1px 0 #c8a97a,
      -1px -1px 0 #c8a97a,
      1px -1px 0 #c8a97a,
      -1px 1px 0 #c8a97a,
      0 2px 6px rgba(0,0,0,0.7);
  }

  .piece.piece-highlight i {
    color: #28a745 !important;
    text-shadow:
      0 0 4px #145222,
      1px 1px 0 #145222,
      -1px -1px 0 #145222,
      1px -1px 0 #145222,
      -1px 1px 0 #145222 !important;
  }

  .drag-ghost {
    position: fixed;
    width: 70px;
    height: 70px;
    pointer-events: none;
    z-index: 9999;
    transform: translate(-50%, -50%);
    display: flex;
    align-items: center;
    justify-content: center;
    cursor: grabbing;
  }

  .drag-ghost i {
    font-size: 48px;
    line-height: 1;
  }

  .drag-ghost.white-piece i {
    color: #f5ead8;
    text-shadow:
      0 0 4px #2a1800,
      1px 1px 0 #3a2500,
      -1px -1px 0 #3a2500,
      1px -1px 0 #3a2500,
      -1px 1px 0 #3a2500,
      0 3px 10px rgba(0,0,0,0.8);
  }

  .drag-ghost.black-piece i {
    color: #1a0e04;
    text-shadow:
      0 0 4px #c8a97a,
      1px 1px 0 #c8a97a,
      -1px -1px 0 #c8a97a,
      1px -1px 0 #c8a97a,
      -1px 1px 0 #c8a97a,
      0 3px 10px rgba(0,0,0,0.8);
  }

  .controls {
    display: flex;
    gap: 12px;
  }

  button {
    background: #2a2218;
    border: 1px solid #3d3020;
    color: #c9a96e;
    font-family: 'Playfair Display', serif;
    font-size: 12px;
    letter-spacing: 0.08em;
    padding: 8px 18px;
    border-radius: 3px;
    cursor: pointer;
    text-transform: uppercase;
    transition: background 0.15s, border-color 0.15s;
  }

  button:hover {
    background: #3a3025;
    border-color: #c9a96e;
  }

  .promotion-modal {
    position: fixed;
    inset: 0;
    background: rgba(0,0,0,0.75);
    display: flex;
    align-items: center;
    justify-content: center;
    z-index: 10000;
  }

  .promotion-box {
    background: #2a2218;
    border: 2px solid #c9a96e;
    border-radius: 6px;
    padding: 20px;
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 14px;
  }

  .promotion-box h3 {
    font-family: 'Playfair Display', serif;
    font-weight: 400;
    font-size: 16px;
    color: #c9a96e;
    letter-spacing: 0.1em;
    text-transform: uppercase;
  }

  .promotion-choices {
    display: flex;
    gap: 12px;
  }

  .promotion-choice {
    cursor: pointer;
    transition: transform 0.1s;
    background: #1a1612;
    border: 1px solid #3d3020;
    border-radius: 4px;
    width: 72px;
    height: 72px;
    display: flex;
    align-items: center;
    justify-content: center;
  }

  .promotion-choice i {
    font-size: 40px;
    line-height: 1;
  }

  .promotion-choice.white-piece i {
    color: #f5ead8;
    text-shadow:
      0 0 3px #2a1800,
      1px 1px 0 #3a2500,
      -1px -1px 0 #3a2500,
      1px -1px 0 #3a2500,
      -1px 1px 0 #3a2500;
  }

  .promotion-choice.black-piece i {
    color: #1a0e04;
    text-shadow:
      0 0 3px #c8a97a,
      1px 1px 0 #c8a97a,
      -1px -1px 0 #c8a97a,
      1px -1px 0 #c8a97a,
      -1px 1px 0 #c8a97a;
  }

  .promotion-choice:hover { transform: scale(1.1); border-color: #c9a96e; }
</style>
</head>
<body>

<div class="app">
  <h1>Chess <span style="font-size:14px; letter-spacing:0.05em; color:#7a6040; font-family:'Source Serif 4',serif; font-weight:300; vertical-align:middle;">v10</span></h1>
  <div class="status-bar">
    <div class="turn-indicator">
      <div class="turn-dot" id="turnDot"></div>
      <span id="turnText">White to move</span>
    </div>
  </div>
  <div class="game-message" id="gameMessage"></div>
  <div class="board-wrapper">
    <div class="coord-col" id="rankCoords"></div>
    <div>
      <div class="board" id="board"></div>
      <div class="coord-row" id="fileCoords"></div>
    </div>
    <div class="captured-panel" id="capturedPanel">
      <div class="captured-side">
        <div class="captured-label">Captured</div>
        <div class="captured-pieces black-captures" id="capturedBlack"></div>
      </div>
      <div class="captured-side">
        <div class="captured-pieces white-captures" id="capturedWhite"></div>
      </div>
    </div>
  </div>
  <div class="controls">
    <button onclick="resetGame()">New Game</button>
    <button onclick="flipBoard()">Flip Board</button>
  </div>
</div>

<div class="promotion-modal" id="promotionModal" style="display:none">
  <div class="promotion-box">
    <h3>Promote Pawn</h3>
    <div class="promotion-choices" id="promotionChoices"></div>
  </div>
</div>

<script>
var PIECE_TITLES = {
  K: 'King', Q: 'Queen', R: 'Rook', B: 'Bishop', N: 'Knight', P: 'Pawn'
}

var FA_CLASSES = {
  K: 'fas fa-chess-king',
  Q: 'fas fa-chess-queen',
  R: 'fas fa-chess-rook',
  B: 'fas fa-chess-bishop',
  N: 'fas fa-chess-knight',
  P: 'fas fa-chess-pawn'
}

function makePieceHTML(pieceCode) {
  var color = pieceCode[0]
  var type = pieceCode[1]
  var isWhite = color === 'w'
  var colorClass = isWhite ? 'white-piece' : 'black-piece'
  var faClass = FA_CLASSES[type]
  var label = PIECE_TITLES[type]
  var titleAttr = (type === 'K' || type === 'Q') ? ' title="' + label + '"' : ''
  return { colorClass: colorClass, titleAttr: titleAttr, html: '<i class="' + faClass + '" aria-label="' + label + '"></i>' }
}

var initialBoard = [
  ['bR','bN','bB','bQ','bK','bB','bN','bR'],
  ['bP','bP','bP','bP','bP','bP','bP','bP'],
  [null,null,null,null,null,null,null,null],
  [null,null,null,null,null,null,null,null],
  [null,null,null,null,null,null,null,null],
  [null,null,null,null,null,null,null,null],
  ['wP','wP','wP','wP','wP','wP','wP','wP'],
  ['wR','wN','wB','wQ','wK','wB','wN','wR']
]

var state = {}

function cloneBoard(b) {
  return b.map(function(row) { return row.slice() })
}

function resetGame() {
  state = {
    board: cloneBoard(initialBoard),
    turn: 'w',
    selected: null,
    validMoves: [],
    enPassantTarget: null,
    castlingRights: { wK: true, wQ: true, bK: true, bQ: true },
    lastMoveFrom: null,
    lastMoveTo: null,
    flipped: state.flipped || false,
    promotionPending: null,
    gameOver: false,
    capturedByWhite: [],
    capturedByBlack: []
  }
  renderBoard()
  updateStatus()
}

function flipBoard() {
  state.flipped = !state.flipped
  renderBoard()
}

function pieceColor(p) {
  if (!p) return null
  return p[0]
}

function pieceType(p) {
  if (!p) return null
  return p[1]
}

function opponent(color) {
  return color === 'w' ? 'b' : 'w'
}

function inBounds(r, c) {
  return r >= 0 && r <= 7 && c >= 0 && c <= 7
}

function getRawMoves(board, r, c, enPassantTarget, castlingRights) {
  var piece = board[r][c]
  if (!piece) return []
  var color = pieceColor(piece)
  var type = pieceType(piece)
  var moves = []
  var opp = opponent(color)
  var dir = color === 'w' ? -1 : 1

  function addIf(tr, tc) {
    if (inBounds(tr, tc)) moves.push([tr, tc])
  }

  if (type === 'P') {
    var nr = r + dir
    if (inBounds(nr, c) && !board[nr][c]) {
      moves.push([nr, c])
      var startRow = color === 'w' ? 6 : 1
      var nr2 = nr + dir
      if (r === startRow && inBounds(nr2, c) && !board[nr2][c]) {
        moves.push([nr2, c])
      }
    }
    for (var dc = -1; dc <= 1; dc += 2) {
      if (inBounds(nr, c + dc)) {
        if (board[nr][c + dc] && pieceColor(board[nr][c + dc]) === opp) {
          moves.push([nr, c + dc])
        }
        if (enPassantTarget && enPassantTarget[0] === nr && enPassantTarget[1] === c + dc) {
          moves.push([nr, c + dc])
        }
      }
    }
  }

  if (type === 'N') {
    var knightMoves = [[-2,-1],[-2,1],[-1,-2],[-1,2],[1,-2],[1,2],[2,-1],[2,1]]
    for (var i = 0; i < knightMoves.length; i++) {
      var tr = r + knightMoves[i][0]
      var tc = c + knightMoves[i][1]
      if (inBounds(tr, tc) && pieceColor(board[tr][tc]) !== color) {
        moves.push([tr, tc])
      }
    }
  }

  if (type === 'B' || type === 'Q') {
    var diagDirs = [[-1,-1],[-1,1],[1,-1],[1,1]]
    for (var d = 0; d < diagDirs.length; d++) {
      for (var step = 1; step <= 7; step++) {
        var tr = r + diagDirs[d][0] * step
        var tc = c + diagDirs[d][1] * step
        if (!inBounds(tr, tc)) break
        if (board[tr][tc]) {
          if (pieceColor(board[tr][tc]) === opp) moves.push([tr, tc])
          break
        }
        moves.push([tr, tc])
      }
    }
  }

  if (type === 'R' || type === 'Q') {
    var lineDirs = [[-1,0],[1,0],[0,-1],[0,1]]
    for (var d = 0; d < lineDirs.length; d++) {
      for (var step = 1; step <= 7; step++) {
        var tr = r + lineDirs[d][0] * step
        var tc = c + lineDirs[d][1] * step
        if (!inBounds(tr, tc)) break
        if (board[tr][tc]) {
          if (pieceColor(board[tr][tc]) === opp) moves.push([tr, tc])
          break
        }
        moves.push([tr, tc])
      }
    }
  }

  if (type === 'K') {
    var kingMoves = [[-1,-1],[-1,0],[-1,1],[0,-1],[0,1],[1,-1],[1,0],[1,1]]
    for (var i = 0; i < kingMoves.length; i++) {
      var tr = r + kingMoves[i][0]
      var tc = c + kingMoves[i][1]
      if (inBounds(tr, tc) && pieceColor(board[tr][tc]) !== color) {
        moves.push([tr, tc])
      }
    }
    if (castlingRights) {
      var backRank = color === 'w' ? 7 : 0
      if (r === backRank && c === 4) {
        if (castlingRights[color + 'K'] &&
            !board[backRank][5] && !board[backRank][6] &&
            board[backRank][7] === color + 'R' &&
            !isSquareAttacked(board, backRank, 4, opp) &&
            !isSquareAttacked(board, backRank, 5, opp) &&
            !isSquareAttacked(board, backRank, 6, opp)) {
          moves.push([backRank, 6])
        }
        if (castlingRights[color + 'Q'] &&
            !board[backRank][3] && !board[backRank][2] && !board[backRank][1] &&
            board[backRank][0] === color + 'R' &&
            !isSquareAttacked(board, backRank, 4, opp) &&
            !isSquareAttacked(board, backRank, 3, opp) &&
            !isSquareAttacked(board, backRank, 2, opp)) {
          moves.push([backRank, 2])
        }
      }
    }
  }

  return moves
}

function isSquareAttacked(board, r, c, byColor) {
  for (var pr = 0; pr < 8; pr++) {
    for (var pc = 0; pc < 8; pc++) {
      var piece = board[pr][pc]
      if (!piece || pieceColor(piece) !== byColor) continue
      var moves = getRawMoves(board, pr, pc, null, null)
      for (var i = 0; i < moves.length; i++) {
        if (moves[i][0] === r && moves[i][1] === c) return true
      }
    }
  }
  return false
}

function findKing(board, color) {
  for (var r = 0; r < 8; r++) {
    for (var c = 0; c < 8; c++) {
      if (board[r][c] === color + 'K') return [r, c]
    }
  }
  return null
}

function isInCheck(board, color) {
  var king = findKing(board, color)
  if (!king) return false
  return isSquareAttacked(board, king[0], king[1], opponent(color))
}

function applyMove(board, fromR, fromC, toR, toC, enPassantTarget, castlingRights) {
  var b = cloneBoard(board)
  var piece = b[fromR][fromC]
  var color = pieceColor(piece)
  var type = pieceType(piece)
  var newEP = null
  var newCR = {
    wK: castlingRights.wK,
    wQ: castlingRights.wQ,
    bK: castlingRights.bK,
    bQ: castlingRights.bQ
  }

  if (type === 'K') {
    newCR[color + 'K'] = false
    newCR[color + 'Q'] = false
    var backRank = color === 'w' ? 7 : 0
    if (fromC === 4 && toC === 6) {
      b[backRank][5] = color + 'R'
      b[backRank][7] = null
    }
    if (fromC === 4 && toC === 2) {
      b[backRank][3] = color + 'R'
      b[backRank][0] = null
    }
  }

  if (type === 'R') {
    if (fromR === 7 && fromC === 0) newCR.wQ = false
    if (fromR === 7 && fromC === 7) newCR.wK = false
    if (fromR === 0 && fromC === 0) newCR.bQ = false
    if (fromR === 0 && fromC === 7) newCR.bK = false
  }

  if (type === 'P') {
    if (Math.abs(toR - fromR) === 2) {
      newEP = [(fromR + toR) / 2, toC]
    }
    if (enPassantTarget && toR === enPassantTarget[0] && toC === enPassantTarget[1]) {
      var capturedPawnRow = color === 'w' ? toR + 1 : toR - 1
      b[capturedPawnRow][toC] = null
    }
  }

  b[toR][toC] = piece
  b[fromR][fromC] = null
  return { board: b, enPassantTarget: newEP, castlingRights: newCR }
}

function getLegalMoves(board, r, c, enPassantTarget, castlingRights) {
  var piece = board[r][c]
  if (!piece) return []
  var color = pieceColor(piece)
  var rawMoves = getRawMoves(board, r, c, enPassantTarget, castlingRights)
  var legal = []
  for (var i = 0; i < rawMoves.length; i++) {
    var tr = rawMoves[i][0]
    var tc = rawMoves[i][1]
    var result = applyMove(board, r, c, tr, tc, enPassantTarget, castlingRights)
    if (!isInCheck(result.board, color)) {
      legal.push([tr, tc])
    }
  }
  return legal
}

function hasAnyLegalMoves(board, color, enPassantTarget, castlingRights) {
  for (var r = 0; r < 8; r++) {
    for (var c = 0; c < 8; c++) {
      if (pieceColor(board[r][c]) === color) {
        var moves = getLegalMoves(board, r, c, enPassantTarget, castlingRights)
        if (moves.length > 0) return true
      }
    }
  }
  return false
}

function getAllReachableSquares(board, color, enPassantTarget, castlingRights) {
  var reachable = {}
  var reachableFrom = {}
  for (var r = 0; r < 8; r++) {
    for (var c = 0; c < 8; c++) {
      if (pieceColor(board[r][c]) === color) {
        var moves = getLegalMoves(board, r, c, enPassantTarget, castlingRights)
        for (var i = 0; i < moves.length; i++) {
          var key = moves[i][0] + ',' + moves[i][1]
          reachable[key] = true
          if (!reachableFrom[key]) reachableFrom[key] = []
          reachableFrom[key].push(r + ',' + c)
        }
      }
    }
  }
  return { reachable: reachable, reachableFrom: reachableFrom }
}

function toAlgebraic(r, c) {
  return String.fromCharCode(97 + c) + (8 - r)
}

function boardRowForDisplay(row) {
  return state.flipped ? 7 - row : row
}

function boardColForDisplay(col) {
  return state.flipped ? 7 - col : col
}

function displayToBoard(dispRow, dispCol) {
  return [boardRowForDisplay(dispRow), boardColForDisplay(dispCol)]
}

var PIECE_ORDER = ['Q','R','B','N','P']

function renderCaptured() {
  var whiteEl = document.getElementById('capturedWhite')
  var blackEl = document.getElementById('capturedBlack')
  whiteEl.innerHTML = ''
  blackEl.innerHTML = ''

  var sortedByWhite = state.capturedByWhite.slice().sort(function(a, b) {
    return PIECE_ORDER.indexOf(pieceType(a)) - PIECE_ORDER.indexOf(pieceType(b))
  })
  var sortedByBlack = state.capturedByBlack.slice().sort(function(a, b) {
    return PIECE_ORDER.indexOf(pieceType(a)) - PIECE_ORDER.indexOf(pieceType(b))
  })

  for (var i = 0; i < sortedByWhite.length; i++) {
    var ico = document.createElement('i')
    ico.className = FA_CLASSES[pieceType(sortedByWhite[i])]
    blackEl.appendChild(ico)
  }
  for (var j = 0; j < sortedByBlack.length; j++) {
    var ico2 = document.createElement('i')
    ico2.className = FA_CLASSES[pieceType(sortedByBlack[j])]
    whiteEl.appendChild(ico2)
  }
}
var dragFromR = -1
var dragFromC = -1

function handleReachableEnter(e) {
  var sources = e.currentTarget.dataset.sources
  if (!sources) return
  var coords = sources.split('|')
  for (var i = 0; i < coords.length; i++) {
    var parts = coords[i].split(',')
    var el = document.querySelector('.piece[data-row="' + parts[0] + '"][data-col="' + parts[1] + '"]')
    if (el) el.classList.add('piece-highlight')
  }
}

function handleReachableLeave() {
  var els = document.querySelectorAll('.piece-highlight')
  for (var i = 0; i < els.length; i++) {
    els[i].classList.remove('piece-highlight')
  }
}

function renderBoard() {
  var boardEl = document.getElementById('board')
  boardEl.innerHTML = ''

  var rankEl = document.getElementById('rankCoords')
  rankEl.innerHTML = ''
  var fileEl = document.getElementById('fileCoords')
  fileEl.innerHTML = ''

  for (var dispRow = 0; dispRow < 8; dispRow++) {
    var boardRow = boardRowForDisplay(dispRow)
    var rankLabel = document.createElement('span')
    rankLabel.textContent = 8 - boardRow
    rankEl.appendChild(rankLabel)
  }

  var files = ['a','b','c','d','e','f','g','h']
  for (var dispCol = 0; dispCol < 8; dispCol++) {
    var boardCol = boardColForDisplay(dispCol)
    var fileLabel = document.createElement('span')
    fileLabel.textContent = files[boardCol]
    fileEl.appendChild(fileLabel)
  }

  var reachableSquares = {}
  var reachableFrom = {}
  if (!state.selected && !state.gameOver) {
    var reachData = getAllReachableSquares(state.board, state.turn, state.enPassantTarget, state.castlingRights)
    reachableSquares = reachData.reachable
    reachableFrom = reachData.reachableFrom
  }

  for (var dispRow = 0; dispRow < 8; dispRow++) {
    for (var dispCol = 0; dispCol < 8; dispCol++) {
      var boardRow = boardRowForDisplay(dispRow)
      var boardCol = boardColForDisplay(dispCol)
      var sq = document.createElement('div')
      var isLight = (boardRow + boardCol) % 2 === 0
      sq.className = 'square ' + (isLight ? 'light' : 'dark')
      sq.dataset.row = boardRow
      sq.dataset.col = boardCol

      if (state.selected !== null && state.selected[0] === boardRow && state.selected[1] === boardCol) {
        sq.classList.add('selected')
      }

      var isValid = false
      for (var v = 0; v < state.validMoves.length; v++) {
        if (state.validMoves[v][0] === boardRow && state.validMoves[v][1] === boardCol) {
          isValid = true
          break
        }
      }

      if (isValid) {
        sq.classList.add('valid-move')
        if (state.board[boardRow][boardCol]) {
          var ring = document.createElement('div')
          ring.className = 'valid-capture-ring'
          sq.appendChild(ring)
        } else {
          var dot = document.createElement('div')
          dot.className = 'valid-dot'
          sq.appendChild(dot)
        }
      } else if (!state.selected && reachableSquares[boardRow + ',' + boardCol]) {
        sq.classList.add('reachable')
        sq.dataset.sources = (reachableFrom[boardRow + ',' + boardCol] || []).join('|')
        sq.addEventListener('mouseenter', handleReachableEnter)
        sq.addEventListener('mouseleave', handleReachableLeave)
      }

      if (state.lastMoveFrom && state.lastMoveFrom[0] === boardRow && state.lastMoveFrom[1] === boardCol &&
          !(state.selected && state.selected[0] === boardRow && state.selected[1] === boardCol)) {
        sq.classList.add('last-move-from')
      }
      if (state.lastMoveTo && state.lastMoveTo[0] === boardRow && state.lastMoveTo[1] === boardCol &&
          !(state.selected && state.selected[0] === boardRow && state.selected[1] === boardCol)) {
        sq.classList.add('last-move-to')
      }

      var king = findKing(state.board, state.turn)
      if (king && king[0] === boardRow && king[1] === boardCol && isInCheck(state.board, state.turn)) {
        sq.classList.add('in-check')
      }

      var piece = state.board[boardRow][boardCol]
      if (piece) {
        var pieceEl = document.createElement('div')
        var result = makePieceHTML(piece)
        pieceEl.className = 'piece ' + result.colorClass
        if (result.titleAttr) pieceEl.title = PIECE_TITLES[pieceType(piece)]
        pieceEl.innerHTML = result.html
        pieceEl.dataset.row = boardRow
        pieceEl.dataset.col = boardCol
        pieceEl.dataset.piece = piece

        if (!state.gameOver && pieceColor(piece) === state.turn) {
          pieceEl.draggable = false
          pieceEl.style.cursor = 'grab'
          pieceEl.addEventListener('mousedown', handlePieceMouseDown)
          pieceEl.addEventListener('touchstart', handlePieceTouchStart, { passive: false })
        }
        sq.appendChild(pieceEl)
      }

      sq.addEventListener('mousedown', handleSquareMouseDown)
      boardEl.appendChild(sq)
    }
  }
  renderCaptured()
}

function handlePieceMouseDown(e) {
  e.preventDefault()
  if (state.gameOver) return
  var r = parseInt(e.currentTarget.dataset.row)
  var c = parseInt(e.currentTarget.dataset.col)
  startDrag(r, c, e.clientX, e.clientY)
}

function handlePieceTouchStart(e) {
  e.preventDefault()
  if (state.gameOver) return
  var r = parseInt(e.currentTarget.dataset.row)
  var c = parseInt(e.currentTarget.dataset.col)
  var touch = e.touches[0]
  startDrag(r, c, touch.clientX, touch.clientY)
}

function handleSquareMouseDown(e) {
  if (e.target.classList.contains('piece')) return
  var sq = e.currentTarget
  var r = parseInt(sq.dataset.row)
  var c = parseInt(sq.dataset.col)
  if (state.selected) {
    var isValid = false
    for (var v = 0; v < state.validMoves.length; v++) {
      if (state.validMoves[v][0] === r && state.validMoves[v][1] === c) {
        isValid = true
        break
      }
    }
    if (isValid) {
      executeMove(state.selected[0], state.selected[1], r, c)
    } else {
      state.selected = null
      state.validMoves = []
      renderBoard()
    }
  }
}

function startDrag(r, c, clientX, clientY) {
  state.selected = [r, c]
  state.validMoves = getLegalMoves(state.board, r, c, state.enPassantTarget, state.castlingRights)
  dragFromR = r
  dragFromC = c

  var pieceSymbol = state.board[r][c]

  dragGhost = document.createElement('div')
  var ghostResult = makePieceHTML(pieceSymbol)
  dragGhost.className = 'drag-ghost ' + ghostResult.colorClass
  dragGhost.innerHTML = ghostResult.html
  dragGhost.style.left = clientX + 'px'
  dragGhost.style.top = clientY + 'px'
  document.body.appendChild(dragGhost)

  var pieceEl = document.querySelector('.piece[data-row="' + r + '"][data-col="' + c + '"]')
  if (pieceEl) pieceEl.classList.add('dragging')

  renderBoard()

  document.addEventListener('mousemove', handleDragMove)
  document.addEventListener('mouseup', handleDragEnd)
  document.addEventListener('touchmove', handleTouchMove, { passive: false })
  document.addEventListener('touchend', handleTouchEnd)
}

function handleDragMove(e) {
  if (!dragGhost) return
  dragGhost.style.left = e.clientX + 'px'
  dragGhost.style.top = e.clientY + 'px'
}

function handleTouchMove(e) {
  e.preventDefault()
  if (!dragGhost) return
  var touch = e.touches[0]
  dragGhost.style.left = touch.clientX + 'px'
  dragGhost.style.top = touch.clientY + 'px'
}

function handleDragEnd(e) {
  endDrag(e.clientX, e.clientY)
}

function handleTouchEnd(e) {
  var touch = e.changedTouches[0]
  endDrag(touch.clientX, touch.clientY)
}

function endDrag(clientX, clientY) {
  document.removeEventListener('mousemove', handleDragMove)
  document.removeEventListener('mouseup', handleDragEnd)
  document.removeEventListener('touchmove', handleTouchMove)
  document.removeEventListener('touchend', handleTouchEnd)

  if (dragGhost) {
    dragGhost.parentNode.removeChild(dragGhost)
    dragGhost = null
  }

  var el = document.elementFromPoint(clientX, clientY)
  var sq = el ? el.closest('.square') : null

  if (sq) {
    var toR = parseInt(sq.dataset.row)
    var toC = parseInt(sq.dataset.col)
    var isValid = false
    for (var v = 0; v < state.validMoves.length; v++) {
      if (state.validMoves[v][0] === toR && state.validMoves[v][1] === toC) {
        isValid = true
        break
      }
    }
    if (isValid) {
      executeMove(dragFromR, dragFromC, toR, toC)
      return
    }
  }

  var pieceEl = document.querySelector('.piece[data-row="' + dragFromR + '"][data-col="' + dragFromC + '"]')
  if (pieceEl) pieceEl.classList.remove('dragging')
  state.selected = null
  state.validMoves = []
  renderBoard()
}

function executeMove(fromR, fromC, toR, toC) {
  var piece = state.board[fromR][fromC]
  var color = pieceColor(piece)
  var type = pieceType(piece)

  var captured = state.board[toR][toC]
  if (!captured && type === 'P' && state.enPassantTarget &&
      toR === state.enPassantTarget[0] && toC === state.enPassantTarget[1]) {
    var epRow = color === 'w' ? toR + 1 : toR - 1
    captured = state.board[epRow][toC]
  }

  if (captured) {
    if (color === 'w') {
      state.capturedByWhite.push(captured)
    } else {
      state.capturedByBlack.push(captured)
    }
  }

  var result = applyMove(state.board, fromR, fromC, toR, toC, state.enPassantTarget, state.castlingRights)
  state.board = result.board
  state.enPassantTarget = result.enPassantTarget
  state.castlingRights = result.castlingRights
  state.lastMoveFrom = null
  state.lastMoveTo = null
  state.selected = null
  state.validMoves = []

  var promotionRow = color === 'w' ? 0 : 7
  if (type === 'P' && toR === promotionRow) {
    state.promotionPending = { r: toR, c: toC, color: color }
    renderBoard()
    showPromotionModal(color, toR, toC)
    return
  }

  state.turn = opponent(color)
  checkGameState()
  renderBoard()
  updateStatus()
}

function showPromotionModal(color, r, c) {
  var modal = document.getElementById('promotionModal')
  var choices = document.getElementById('promotionChoices')
  choices.innerHTML = ''
  var types = ['Q','R','B','N']
  for (var i = 0; i < types.length; i++) {
    var t = types[i]
    var div = document.createElement('div')
    var promoResult = makePieceHTML(color + t)
    div.className = 'promotion-choice ' + promoResult.colorClass
    div.innerHTML = promoResult.html
    div.dataset.type = t
    div.addEventListener('click', handlePromotion)
    choices.appendChild(div)
  }
  modal.style.display = 'flex'
}

function handlePromotion(e) {
  var type = e.currentTarget.dataset.type
  var pending = state.promotionPending
  state.board[pending.r][pending.c] = pending.color + type
  state.promotionPending = null
  document.getElementById('promotionModal').style.display = 'none'
  state.turn = opponent(pending.color)
  checkGameState()
  renderBoard()
  updateStatus()
}

function checkGameState() {
  var turn = state.turn
  var inCheck = isInCheck(state.board, turn)
  var hasLegal = hasAnyLegalMoves(state.board, turn, state.enPassantTarget, state.castlingRights)

  if (!hasLegal) {
    state.gameOver = true
    if (inCheck) {
      state.gameOverMessage = (turn === 'w' ? 'Black' : 'White') + ' wins by checkmate'
    } else {
      state.gameOverMessage = 'Stalemate — draw'
    }
  } else {
    state.gameOverMessage = null
    state.inCheck = inCheck
  }
}

function updateStatus() {
  var turnDot = document.getElementById('turnDot')
  var turnText = document.getElementById('turnText')
  var msg = document.getElementById('gameMessage')

  if (state.gameOver) {
    turnText.textContent = 'Game over'
    turnDot.className = 'turn-dot'
    msg.textContent = state.gameOverMessage
    msg.className = 'game-message game-over'
    return
  }

  msg.className = 'game-message'

  turnDot.className = 'turn-dot ' + (state.turn === 'w' ? 'white' : 'black')
  turnText.textContent = (state.turn === 'w' ? 'White' : 'Black') + ' to move'
  msg.textContent = state.inCheck ? 'Check!' : ''
}

resetGame()
</script>
</body>
</html>
