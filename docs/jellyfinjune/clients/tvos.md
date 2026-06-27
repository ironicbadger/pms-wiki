# Jellyfin tvOS client buyer's guide

!!! info "Last updated: 2026-06-27"
    Codec support below is based on App Store listings and project documentation, not the YouTube episode. Episode observations are kept separate and only cover behavior seen in the video.

This guide covers the tvOS clients reviewed in [JellyfinJune Episode 4](https://perfectmediaserver.com/jellyfinjune/e04/) and turns the source data into a practical buying matrix.

## Shortlist

| Client | Best fit | Price model | Published codec detail | Published media/features |
| --- | --- | --- | --- | --- |
| [Swiftfin](#swiftfin) | Official baseline Jellyfin client | Free | Exact project codec tables | Live TV/recordings, video libraries |
| [Infuse](#infuse) | Maximum format compatibility | Free app, Pro for more features | Exact App Store format list | Plex/Emby/Jellyfin, NAS/cloud, Trakt |
| [Neptune](#neptune) | Polished native Jellyfin experience | Free base, paid licensed features planned | Broad project claim | Seerr, AI search, profiles |
| [Zuno](#zuno) | Plex/Jellyfin beta with discovery features | TestFlight beta | No public codec list found | Seerr, Trakt |
| [JellySee](#jellysee) | Jellyfin + Seerr + music on Apple TV | Paid app | Exact App Store codec list | Seerr, music, PiP |
| [JellyTV](#jellytv) | Modern Jellyfin app with request/admin extras | Free app, optional Plus | Broad App Store claim | Seerr, Live TV, downloads |
| [Moonfin](#moonfin) | Full-featured cross-platform Jellyfin/Emby client | Free | Exact project format list | Music, books, Live TV/DVR, Seerr |
| [SenPlayer](#senplayer) | Infuse-style all-in-one player | Free app, Pro for advanced formats | Exact App Store format list | Local files, NAS/cloud, IPTV, Trakt |
| [Plezy](#plezy) | Paid no-subscription Plex/Jellyfin player | Paid app | Partial App Store codec list | Downloads, profiles, server discovery |
| [Reefy](#reefy) | tvOS-native Jellyfin fork of Swiftfin | Paid app | Broad VLC/project claim | Video-first; Live TV planned |
| [TechDad Player](#techdad-player) | Lightweight Jellyfin/Emby player | Free app, subscription observed | Partial App Store codec list | Local file playback |
| [Streamyfin](#streamyfin) | Open-source Jellyfin video client | Free | Broad MPV project claim | Downloads, plugin settings, Seerr |
| [Stingray](#stingray) | Native Jellyfin app with track controls | Free | No public codec list found | Quality/audio/subtitle controls |
| [OopsPlayer](#oopsplayer) | Multi-source player with Jellyfin support | Free app, Pro limits removed | Partial App Store codec list | SMB/WebDAV/cloud/IPTV |
| [LiquidFin](#liquidfin) | Jellyfin app with music/books/admin extras | Free app, optional premium | No public codec list found | Music, audiobooks, books, Live TV, Jellyseerr |
| [Nostalgex](#nostalgex) | Turn library into channel-surfing TV | Free | Not codec-focused | EPG-style channels from Plex/Jellyfin |

## How to read this

- **Exact** means the publisher lists specific containers/codecs/subtitles/HDR formats.
- **Partial** means the publisher names several headline codecs but not a complete table.
- **Broad** means the publisher claims a player engine or wide support without a full inventory.
- **Unknown** means I did not find a public codec list on the App Store, project page, or project docs.

<h2 id="swiftfin" class="client-heading"><img class="client-logo" src="../../../images/jellyfinjune/clients/tvos/swiftfin.jpg" alt=""> Swiftfin</h2>
<p class="client-meta">Official Jellyfin client. Free.</p>

**Buyer's read:** start here if you want the official app and do not need the richest tvOS experience.

**Published codec support:** exact project documentation. Swiftfin documents two players: Swiftfin/VLCKit and Native/AVPlayer. The VLCKit path lists containers such as AVI, FLV, M4V, MKV, MOV, MP4, MPEG-TS, TS, 3G2, 3GP, and WebM; video codecs including AV1 with hardware caveats, H.264, H.265/HEVC, MPEG-1/2/4, VC-1, VP8, VP9, ProRes, and WMV variants; audio including AAC, AC3, ALAC, DTS, EAC3, FLAC, MP3, Opus, PCM, Vorbis, WMA, and others; subtitles including ASS, DVBSub, DVDSub, PGS, SSA, SRT, TTML, VTT, and others; HDR support including HDR10, HLG, and several Dolby Vision/HDR10+ caveated paths.

**Published features:** Live TV and recorded shows, Jellyfin server discovery/login, video library browsing.

**Episode notes:** Quick Connect and discovery worked; music and personal video libraries were not exposed in the tested build.

Sources: [App Store](https://apps.apple.com/us/app/swiftfin/id1604098728), [Swiftfin playback docs](https://github.com/jellyfin/Swiftfin/blob/main/Documentation/players.md)
{: .client-source-list }

<h2 id="infuse" class="client-heading"><img class="client-logo" src="../../../images/jellyfinjune/clients/tvos/infuse.jpg" alt=""> Infuse</h2>
<p class="client-meta">Multi-source player. Free app with Infuse Pro upgrade.</p>

**Buyer's read:** strongest published format story, especially if your Apple TV is expected to direct-play odd files.

**Published codec support:** exact App Store list. Video/container support includes 33GP, AVI, AV1, ASF, BDMV, DIVX, DVDMEDIA, DVR-MS, FLV, H.264/AVC, H.265/HEVC, ISO/IMG, M4V, MKV, MOV, MP4, MPEG, MTS/M2TS, MXF, OGM, OGV, RMVB, TS, VC1, VIDEO_TS, VOB, VP9, WEBM, WMV, and WTV. Audio includes AAC, AC3/E-AC3, Dolby TrueHD, DTS, DTS-HD MA, FLAC, MP3, OGG, PCM, and WMA. Subtitles include DVB, DVDSUB, MicroDVD, MPL2, PGS, SMI, SSA/ASS, SRT, SUB, SUP, Timed Text, TXT, VobSub, VTT, and XSUB. HDR claims include HDR, HDR10+, and Dolby Vision.

**Published features:** Plex, Emby, Jellyfin, Kodi, NAS, cloud, OpenSubtitles, Trakt, downloads, sync.

**Episode notes:** Jellyfin discovery worked; Quick Connect did not. Video and local-file playback were strong; music/audiobooks were not exposed.

Sources: [App Store](https://apps.apple.com/us/app/infuse/id1136220934)
{: .client-source-list }

<h2 id="neptune" class="client-heading"><img class="client-logo" src="../../../images/jellyfinjune/clients/tvos/neptune.png" alt=""> Neptune</h2>
<p class="client-meta">Native Jellyfin-first client. Beta; paid licensed features planned.</p>

**Buyer's read:** most interesting if you want a modern Jellyfin-specific UI, AI search, and Seerr in one app.

**Published codec support:** broad project claim. Neptune's project page describes its Trident Player as a custom playback engine with advanced HDR and lossless audio support.

**Published features:** natural-language search, Seerr discovery, LLM providers, Trident Player, rich Jellyfin UI.

**Episode notes:** Quick Connect worked. The tested build had a long beta onboarding flow; personal videos and music did not load.

Sources: [Project page](https://neptuneplayer.com/)
{: .client-source-list }

<h2 id="zuno" class="client-heading"><img class="client-logo" src="../../../images/jellyfinjune/clients/tvos/zuno.jpg" alt=""> Zuno</h2>
<p class="client-meta">Plex/Jellyfin beta. TestFlight.</p>

**Buyer's read:** worth watching, but not enough public technical data yet to buy on codec support.

**Published codec support:** unknown. The public TestFlight page confirms iOS/tvOS availability but does not publish a codec list.

**Published features:** public TestFlight page only. Episode showed Seerr and Trakt options, but I did not find a stable public project page documenting them.

**Episode notes:** discovery worked; Quick Connect did not in the tested build.

Sources: [TestFlight](https://testflight.apple.com/join/D9QKAMMF)
{: .client-source-list }

<h2 id="jellysee" class="client-heading"><img class="client-logo" src="../../../images/jellyfinjune/clients/tvos/jellysee.jpg" alt=""> JellySee</h2>
<p class="client-meta">Native Jellyfin + Seerr app. Paid app.</p>

**Buyer's read:** one of the clearest published technical pages, with explicit codec and music claims.

**Published codec support:** exact App Store list. Containers: MP4, M4V, and MOV direct play; MKV direct stream/remux; AVI limited. Video: MPEG4 limited, H.264, H.265, VP9. Dynamic range: SDR, HLG, HDR10+, Dolby Vision profiles 5, 7, 8.1, and 8.4. Audio up to 7.1: AAC, AC3, EAC3 + Atmos, ALAC, FLAC, Opus, Vorbis. Subtitles: PGS, WebVTT, SRT, ASS; DVD/VobSub via transcode.

**Published features:** Jellyfin + Seerr, music views, system Now Playing, PiP, trickplay with plugin, subtitle customization, version switching, audio track selection.

**Episode notes:** music appeared; personal videos struggled in the tested build.

Sources: [App Store](https://apps.apple.com/us/app/jellysee/id6748783768)
{: .client-source-list }

<h2 id="jellytv" class="client-heading"><img class="client-logo" src="../../../images/jellyfinjune/clients/tvos/jellytv.jpg" alt=""> JellyTV</h2>
<p class="client-meta">Native Jellyfin app. Free app with optional JellyTV+.</p>

**Buyer's read:** good candidate if you want a modern interface plus request/admin features, but codec detail is light.

**Published codec support:** broad App Store claim. The listing claims high-quality video support, live streaming, and transcoding, but does not publish a codec/container table.

**Published features:** Seerr request management, push notifications, offline downloads, sync across Apple devices. JellyTV+ adds admin interface, Trakt, AniList, and home customization.

**Episode notes:** discovery and Quick Connect worked; quality selection existed but was not very granular.

Sources: [App Store](https://apps.apple.com/us/app/jellytv/id6752357290)
{: .client-source-list }

<h2 id="moonfin" class="client-heading"><img class="client-logo" src="../../../images/jellyfinjune/clients/tvos/moonfin.jpg" alt=""> Moonfin</h2>
<p class="client-meta">Cross-platform Jellyfin/Emby client. Free.</p>

**Buyer's read:** broadest published app-scope: video, music, books, Live TV, DVR, and admin-style features.

**Published codec support:** exact project documentation. Moonfin-Core lists video support for H.264, HEVC/H.265, VP8, VP9, AV1, MPEG-2, MPEG-4, and VC-1; audio support for AAC, MP3, FLAC, Opus, Vorbis, AC3, EAC3, DTS, TrueHD, PCM, and ALAC; containers MP4, MKV, WebM, AVI, MOV, TS/M2TS, and WMV/ASF; subtitles SRT, ASS/SSA, VTT/WebVTT, TTML, and SUB, with bitmap subtitle support on desktop. The project docs say Apple TV uses MPVKit and supports Dolby Vision Profile 7 direct play.

**Published features:** downloads, ebooks, audiobooks, Live TV/DVR, Seerr discovery, SyncPlay, themes, admin panel, trailer previews, advanced playback controls.

**Episode notes:** Quick Connect and local video playback worked; player controls were strong in the tested build.

Sources: [App Store](https://apps.apple.com/us/app/moonfin/id6761283970), [Moonfin-Core](https://github.com/Moonfin-Client/Moonfin-Core)
{: .client-source-list }

<h2 id="senplayer" class="client-heading"><img class="client-logo" src="../../../images/jellyfinjune/clients/tvos/senplayer.jpg" alt=""> SenPlayer</h2>
<p class="client-meta">All-in-one local/network/media-server player. Free app with Pro tier.</p>

**Buyer's read:** a strong Infuse-style option if you also care about local files, NAS/cloud sources, and IPTV.

**Published codec support:** exact App Store list. Video/container support includes MP4, MKV, VOB, BIK, DAT, TS, MTS, M2T, M2TS, MPG, MPEG, AVI, RMVB, FLV, SWF, WEBM, 3GP, MOV, ISO, and more. Audio includes MP3, FLAC, AAC, WMA, APE, M4A, WAV, DFF, and DSF. Image support includes JPEG, PNG, GIF, WEBP, BMP, and HEIC. The listing also claims 4K/8K, 120fps, HDR10, HDR10+, and HLG.

**Published features:** Plex, Emby, Jellyfin, local files, WebDAV, SMB, FTP, cloud services, M3U/M3U8/TXT IPTV playlists, subtitle search/customization, watch history sync.

**Episode notes:** no auto discovery or Quick Connect; folder browsing and local files worked.

Sources: [App Store](https://apps.apple.com/us/app/senplayer-media-player/id6443975850)
{: .client-source-list }

<h2 id="plezy" class="client-heading"><img class="client-logo" src="../../../images/jellyfinjune/clients/tvos/plezy.jpg" alt=""> Plezy</h2>
<p class="client-meta">Plex/Jellyfin client. Paid app, no subscription claimed.</p>

**Buyer's read:** polished paid option with strong headline codec support and no subscription pitch in the listing.

**Published codec support:** partial App Store list. The listing claims wide codec support including HEVC, AV1, VP9, HDR playback, and advanced ASS/SSA subtitle rendering, but does not publish full container/audio/HDR tables.

**Published features:** offline downloads, whole-season downloads, watch progress sync, multiple user profiles with optional PIN, multiple Plex/Jellyfin servers, smart server discovery.

**Episode notes:** discovery and Quick Connect worked after a restart; local files played.

Sources: [App Store](https://apps.apple.com/us/app/plezy-for-plex-jellyfin/id6754315964)
{: .client-source-list }

<h2 id="reefy" class="client-heading"><img class="client-logo" src="../../../images/jellyfinjune/clients/tvos/reefy.jpg" alt=""> Reefy</h2>
<p class="client-meta">tvOS-focused Jellyfin client. Paid app.</p>

**Buyer's read:** interesting if you want a tvOS-only Swiftfin fork, but current public codec detail is broad.

**Published codec support:** broad project/App Store claim. The App Store listing says Reefy uses a VLC-based player with broad codec support and surround passthrough. The GitHub README says it is a Swiftfin fork using VLC for direct playback, but neither page publishes a full codec table.

**Published features:** tvOS-native UI, redesigned playback controls, VLC playback, surround passthrough, stereo downmix. Live TV remains a stated goal.

**Episode notes:** local files played; Live TV was shown as coming soon.

Sources: [App Store](https://apps.apple.com/us/app/reefy-media-player/id6757623550), [GitHub](https://github.com/jmhunter83/reefy)
{: .client-source-list }

<h2 id="techdad-player" class="client-heading"><img class="client-logo" src="../../../images/jellyfinjune/clients/tvos/techdad.jpg" alt=""> TechDad Player</h2>
<p class="client-meta">Lightweight Jellyfin/Emby player. Free app; subscription observed in episode.</p>

**Buyer's read:** lightweight, but weak buyer signal unless its minimalism is specifically what you want.

**Published codec support:** partial App Store list. The listing claims H.264, HEVC, AV1, MKV/MP4 containers, HDR, embedded tracks, embedded/external subtitles, and local MP4/MOV playback.

**Published features:** Emby and Jellyfin protocols, local file playback, privacy/no ads claims.

**Episode notes:** no auto discovery or Quick Connect; some media did not play in the tested build.

Sources: [App Store](https://apps.apple.com/us/app/techdad-player/id6756520836)
{: .client-source-list }

<h2 id="streamyfin" class="client-heading"><img class="client-logo" src="../../../images/jellyfinjune/clients/tvos/streamyfin.jpg" alt=""> Streamyfin</h2>
<p class="client-meta">Open-source Jellyfin video client. Free.</p>

**Buyer's read:** open-source client to watch closely, especially if you like its mobile app and plugin approach.

**Published codec support:** broad project claim. The project README says Streamyfin uses MPV via MPVKit and describes MPV as having wide format support, but it does not publish a tvOS-specific codec table.

**Published features:** downloads, trickplay, skip intro/credits, settings plugin, Seerr integration, sessions view, Chromecast. The README says music is not currently supported.

**Episode notes:** Quick Connect worked; local video playback worked; tvOS library navigation was still rough.

Sources: [App Store](https://apps.apple.com/us/app/streamyfin/id6593660679), [GitHub](https://github.com/streamyfin/streamyfin)
{: .client-source-list }

<h2 id="stingray" class="client-heading"><img class="client-logo" src="../../../images/jellyfinjune/clients/tvos/stingray.jpg" alt=""> Stingray</h2>
<p class="client-meta">Native Jellyfin client. Free.</p>

**Buyer's read:** not enough empirical or published codec data yet.

**Published codec support:** unknown. The App Store listing says the app can adjust quality, video tracks, audio tracks, and subtitles, but does not publish codec/container support.

**Published features:** profiles, PiP, episode switching from the player, quality/audio/subtitle/video-track controls.

**Episode notes:** login failed in the tested build, so no playback behavior could be verified.

Sources: [App Store](https://apps.apple.com/us/app/stingray-streaming/id6756280505)
{: .client-source-list }

<h2 id="oopsplayer" class="client-heading"><img class="client-logo" src="../../../images/jellyfinjune/clients/tvos/oopsplayer.jpg" alt=""> OopsPlayer</h2>
<p class="client-meta">Multi-source video player. Free app with OopsPlayer Pro.</p>

**Buyer's read:** useful if Jellyfin is one of many sources you want in a single player.

**Published codec support:** partial App Store list. The listing claims 4K, HDR, Dolby Vision, Blu-ray ISO/BDMV, MKV, MP4, MOV, AVI, FLV, WMV, and PiP.

**Published features:** Plex, Emby, Jellyfin, SMB, WebDAV, cloud drives, local files, network streams, IPTV. Pro removes limits on 4K/MKV playback, servers, and cloud services.

**Episode notes:** setup was awkward; local files played; Jellyfin felt secondary to the generic player experience.

Sources: [App Store](https://apps.apple.com/us/app/oopsplayer-media-player/id6758075545)
{: .client-source-list }

<h2 id="liquidfin" class="client-heading"><img class="client-logo" src="../../../images/jellyfinjune/clients/tvos/liquidfin.jpg" alt=""> LiquidFin</h2>
<p class="client-meta">Native Jellyfin client. Free app with optional premium.</p>

**Buyer's read:** broad Jellyfin feature coverage, but no public codec table found.

**Published codec support:** unknown. The App Store listing describes native playback but does not publish codec/container support.

**Published features:** movies, TV, collections, Live TV, full music and audiobook support, books, playlists, offline downloads, Jellyseerr, admin tools, server switching, focused modes.

**Episode notes:** phone-to-TV QR pairing worked; local video playback worked; player controls were sparse.

Sources: [App Store](https://apps.apple.com/us/app/liquidfin/id6755673532)
{: .client-source-list }

<h2 id="nostalgex" class="client-heading"><img class="client-logo" src="../../../images/jellyfinjune/clients/tvos/nostalgex.jpg" alt=""> Nostalgex</h2>
<p class="client-meta">Plex/Jellyfin channel-surfing app. Free.</p>

**Buyer's read:** not a normal client replacement. Use it when you want your library to feel like TV channels.

**Published codec support:** not codec-focused. The App Store listing does not publish codec support.

**Published features:** Plex/Jellyfin PIN connection, channel packages, EPG-style guide, mini guide overlay, collection channels, kids/family-safe channels, retro CRT mode.

**Episode notes:** included as a bonus because it changes browsing behavior rather than competing as a full Jellyfin client.

Sources: [App Store](https://apps.apple.com/us/app/nostalgex/id6762563534)
{: .client-source-list }

## Retest checklist

For a future fully empirical pass, use the same sample pack on every client: H.264, HEVC, AV1, VP9, MKV remux, MP4 direct play, HDR10, HDR10+, Dolby Vision, DTS/TrueHD, EAC3 Atmos, ASS subtitles, PGS subtitles, Live TV, music, audiobook, and an unmatched personal-video library.
