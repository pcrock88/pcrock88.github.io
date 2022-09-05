// ==UserScript==
// @name          mpv ²¥·Å
// @version       1.0.0
// @author        Grant Howard
// @match         https://www.bilibili.com/video/*
// @grant         unsafeWindow
// ==/UserScript==

;(async () => {
  if (!unsafeWindow.bilibiliEvolved) {
    unsafeWindow.bilibiliEvolved = {}
  }
  if (!unsafeWindow.bilibiliEvolved.downloadVideoExtensionButtons) {
    unsafeWindow.bilibiliEvolved.downloadVideoExtensionButtons = []
  }
  unsafeWindow.bilibiliEvolved.downloadVideoExtensionButtons.push({
    name: 'mpv',
    displayName: 'mpv ²¥·Å',
    batch: false,
    action: video => {
      const urls = video.fragments.map(it => it.url).join('@')
      const link = `mpv-bilibili://bilibili?url=${urls}`
      window.open(link)
    }
  })
})()