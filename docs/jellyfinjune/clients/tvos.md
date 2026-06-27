# Jellyfin tvOS client buyer's guide

!!! info "Last updated: 2026-06-27"
    Codec support below is based on App Store listings and project documentation on a best effort basis. Prices are US App Store prices where listed. If you spot a mistake, please open a PR!

This guide covers the tvOS clients reviewed in [JellyfinJune Episode 4](https://perfectmediaserver.com/jellyfinjune/e04/).

## Legend

<div class="pill-legend">
<div><span class="guide-pill codec-exact">Exact codecs</span><span>Concrete containers, codecs, subtitles, or HDR formats.</span></div>
<div><span class="guide-pill codec-partial">Partial codecs</span><span>Headline formats, but no full table.</span></div>
<div><span class="guide-pill codec-broad">Broad claim</span><span>Broad player support claim without an inventory.</span></div>
<div><span class="guide-pill codec-unknown">Unknown</span><span>No public codec list found.</span></div>
<div><span class="guide-pill type-native">Native</span><span>Jellyfin-focused app.</span></div>
<div><span class="guide-pill type-aggregator">Aggregator</span><span>Multi-source player that can connect to Jellyfin.</span></div>
</div>

## Capability grid

| Client | Best for | Type | Codec source | Notable features | Price |
| --- | --- | --- | --- | --- | --- |
| <img class="mini-client-logo" src="../../../images/jellyfinjune/clients/tvos/swiftfin.jpg" alt=""> [Swiftfin](#swiftfin) | Official baseline | <span class="guide-pill type-native">Native</span> | <span class="guide-pill codec-exact">Exact codecs</span> | Live TV, recordings | Free |
| <img class="mini-client-logo" src="../../../images/jellyfinjune/clients/tvos/infuse.jpg" alt=""> [Infuse](#infuse) | Maximum format compatibility | <span class="guide-pill type-aggregator">Aggregator</span> | <span class="guide-pill codec-exact">Exact codecs</span> | Plex, Emby, Jellyfin, NAS, cloud, Trakt | Free + Pro |
| <img class="mini-client-logo" src="../../../images/jellyfinjune/clients/tvos/neptune.png" alt=""> [Neptune](#neptune) | Polished Jellyfin UI | <span class="guide-pill type-native">Native</span> | <span class="guide-pill codec-broad">Broad claim</span> | Seerr, AI search, profiles | Free base, paid planned |
| <img class="mini-client-logo" src="../../../images/jellyfinjune/clients/tvos/zuno.jpg" alt=""> [Zuno](#zuno) | Plex/Jellyfin beta | <span class="guide-pill type-native">Native</span> | <span class="guide-pill codec-unknown">Unknown</span> | Seerr and Trakt seen in episode | TestFlight beta |
| <img class="mini-client-logo" src="../../../images/jellyfinjune/clients/tvos/jellysee.jpg" alt=""> [JellySee](#jellysee) | Seerr plus music | <span class="guide-pill type-native">Native</span> | <span class="guide-pill codec-exact">Exact codecs</span> | Seerr, music, PiP, trickplay | Paid app |
| <img class="mini-client-logo" src="../../../images/jellyfinjune/clients/tvos/jellytv.jpg" alt=""> [JellyTV](#jellytv) | Request/admin extras | <span class="guide-pill type-native">Native</span> | <span class="guide-pill codec-broad">Broad claim</span> | Seerr, Live TV, downloads | Free + Plus |
| <img class="mini-client-logo" src="../../../images/jellyfinjune/clients/tvos/moonfin.jpg" alt=""> [Moonfin](#moonfin) | Full-featured Jellyfin/Emby | <span class="guide-pill type-native">Native</span> | <span class="guide-pill codec-exact">Exact codecs</span> | Music, books, Live TV/DVR, Seerr | Free |
| <img class="mini-client-logo" src="../../../images/jellyfinjune/clients/tvos/senplayer.jpg" alt=""> [SenPlayer](#senplayer) | Local files and IPTV | <span class="guide-pill type-aggregator">Aggregator</span> | <span class="guide-pill codec-exact">Exact codecs</span> | NAS, cloud, IPTV, Trakt | Free + Pro |
| <img class="mini-client-logo" src="../../../images/jellyfinjune/clients/tvos/plezy.jpg" alt=""> [Plezy](#plezy) | Paid no-subscription playback | <span class="guide-pill type-native">Native</span> | <span class="guide-pill codec-partial">Partial codecs</span> | Downloads, profiles, discovery | Paid app |
| <img class="mini-client-logo" src="../../../images/jellyfinjune/clients/tvos/reefy.jpg" alt=""> [Reefy](#reefy) | tvOS-only Swiftfin fork | <span class="guide-pill type-native">Native</span> | <span class="guide-pill codec-broad">Broad claim</span> | VLC player, Live TV planned | Paid app |
| <img class="mini-client-logo" src="../../../images/jellyfinjune/clients/tvos/techdad.jpg" alt=""> [TechDad Player](#techdad-player) | Lightweight playback | <span class="guide-pill type-aggregator">Aggregator</span> | <span class="guide-pill codec-partial">Partial codecs</span> | Emby, Jellyfin, local files | Free, subscription observed |
| <img class="mini-client-logo" src="../../../images/jellyfinjune/clients/tvos/streamyfin.jpg" alt=""> [Streamyfin](#streamyfin) | Open-source Jellyfin video | <span class="guide-pill type-native">Native</span> | <span class="guide-pill codec-broad">Broad claim</span> | Downloads, plugin settings, Seerr | Free |
| <img class="mini-client-logo" src="../../../images/jellyfinjune/clients/tvos/stingray.jpg" alt=""> [Stingray](#stingray) | Native track controls | <span class="guide-pill type-native">Native</span> | <span class="guide-pill codec-unknown">Unknown</span> | Quality/audio/subtitle controls | Free |
| <img class="mini-client-logo" src="../../../images/jellyfinjune/clients/tvos/oopsplayer.jpg" alt=""> [OopsPlayer](#oopsplayer) | Many source types | <span class="guide-pill type-aggregator">Aggregator</span> | <span class="guide-pill codec-partial">Partial codecs</span> | SMB, WebDAV, cloud, IPTV | Free + Pro |
| <img class="mini-client-logo" src="../../../images/jellyfinjune/clients/tvos/liquidfin.jpg" alt=""> [LiquidFin](#liquidfin) | Music, books, admin extras | <span class="guide-pill type-native">Native</span> | <span class="guide-pill codec-unknown">Unknown</span> | Music, audiobooks, Live TV, Jellyseerr | Free + premium |
| <img class="mini-client-logo" src="../../../images/jellyfinjune/clients/tvos/nostalgex.jpg" alt=""> [Nostalgex](#nostalgex) | Channel-surfing your library | <span class="guide-pill type-native">Native</span> | <span class="guide-pill codec-unknown">Unknown</span> | EPG-style channels | Free |

## Client notes

<h2 id="swiftfin" class="client-heading"><img class="client-logo" src="../../../images/jellyfinjune/clients/tvos/swiftfin.jpg" alt=""> Swiftfin</h2>
<p class="client-summary">Official Jellyfin companion app and the baseline native tvOS client. Best treated as the reference Jellyfin-first player, with Live TV and recording support but fewer library surfaces than some newer competitors.</p>

<div class="client-facts" markdown>
<span><strong>Price:</strong> Free download; no IAP section found.</span>
<span><strong>Version checked:</strong> App Store 1.4.1, released 2026-01-13.</span>
</div>

<div class="client-note-grid" markdown>
<div markdown>
**Good fit:** You want the official app and a simple movies/TV baseline.
</div>
<div markdown>
**Watch outs:** The episode build did not expose music or personal-video libraries.
</div>
</div>

!!! info "Published codec details"
    Swiftfin documents two players: Swiftfin/VLCKit and Native/AVPlayer. The VLCKit path lists containers such as AVI, FLV, M4V, MKV, MOV, MP4, MPEG-TS, TS, 3G2, 3GP, and WebM; video codecs including AV1 with hardware caveats, H.264, H.265/HEVC, MPEG-1/2/4, VC-1, VP8, VP9, ProRes, and WMV variants; audio including AAC, AC3, ALAC, DTS, EAC3, FLAC, MP3, Opus, PCM, Vorbis, WMA, and others; subtitles including ASS, DVBSub, DVDSub, PGS, SSA, SRT, TTML, VTT, and others; HDR support including HDR10, HLG, and several Dolby Vision/HDR10+ caveated paths.

Sources: [App Store](https://apps.apple.com/us/app/swiftfin/id1604098728), [Swiftfin playback docs](https://github.com/jellyfin/Swiftfin/blob/main/Documentation/players.md)
{: .client-source-list }

<h2 id="infuse" class="client-heading"><img class="client-logo" src="../../../images/jellyfinjune/clients/tvos/infuse.jpg" alt=""> Infuse</h2>
<p class="client-summary">Polished multi-source player focused on broad direct-play compatibility across NAS, cloud, Plex, Emby, Jellyfin, and local libraries. It is an aggregator rather than a Jellyfin-native workflow, so Jellyfin-specific extras are secondary.</p>

<div class="client-facts" markdown>
<span><strong>Price:</strong> Free download; Infuse Pro IAPs list monthly $1.99, yearly $16.99, and lifetime $99.99.</span>
<span><strong>Version checked:</strong> App Store 8.4.7, released 2026-06-16.</span>
</div>

<div class="client-note-grid" markdown>
<div markdown>
**Good fit:** You want the strongest published format support and do not mind an aggregator workflow.
</div>
<div markdown>
**Watch outs:** No Quick Connect in the episode; Jellyfin-specific features are not the focus.
</div>
</div>

!!! info "Published codec details"
    App Store lists video/container support for 33GP, AVI, AV1, ASF, BDMV, DIVX, DVDMEDIA, DVR-MS, FLV, H.264/AVC, H.265/HEVC, ISO/IMG, M4V, MKV, MOV, MP4, MPEG, MTS/M2TS, MXF, OGM, OGV, RMVB, TS, VC1, VIDEO_TS, VOB, VP9, WEBM, WMV, and WTV. Audio includes AAC, AC3/E-AC3, Dolby TrueHD, DTS, DTS-HD MA, FLAC, MP3, OGG, PCM, and WMA. Subtitles include DVB, DVDSUB, MicroDVD, MPL2, PGS, SMI, SSA/ASS, SRT, SUB, SUP, Timed Text, TXT, VobSub, VTT, and XSUB. HDR claims include HDR, HDR10+, and Dolby Vision.

Sources: [App Store](https://apps.apple.com/us/app/infuse/id1136220934)
{: .client-source-list }

<h2 id="neptune" class="client-heading"><img class="client-logo" src="../../../images/jellyfinjune/clients/tvos/neptune.png" alt=""> Neptune</h2>
<p class="client-summary">Jellyfin-first beta client with a premium-feeling interface, Seerr, profiles, AI search, and the Trident playback engine. Current public status is still beta, with a freemium model announced for licensed premium features.</p>

<div class="client-facts" markdown>
<span><strong>Price:</strong> Free TestFlight beta; announced premium pricing is monthly $1.99, yearly $16.99, and lifetime $129.99.</span>
<span><strong>Version checked:</strong> Version 0.1.6, Build 135, published 2026-06-13.</span>
</div>

<div class="client-note-grid" markdown>
<div markdown>
**Good fit:** You want a polished Jellyfin UI with AI search, Seerr, and profiles.
</div>
<div markdown>
**Watch outs:** Public codec detail is broad, not exact; the tested beta still had rough edges.
</div>
</div>

!!! info "Published codec details"
    Neptune's project page describes its Trident Player as a custom playback engine with advanced HDR and lossless audio support. We did not find an exact public codec/container table.

Sources: [Project page](https://neptuneplayer.com/), [Newsroom](https://news.neptuneplayer.com/), [TestFlight](https://testflight.apple.com/join/HcdyHvES)
{: .client-source-list }

<h2 id="zuno" class="client-heading"><img class="client-logo" src="../../../images/jellyfinjune/clients/tvos/zuno.jpg" alt=""> Zuno</h2>
<p class="client-summary">Early Plex/Jellyfin TestFlight client with Seerr and Trakt signals seen in the episode. Treat it as an in-flight beta until public docs or an App Store listing publish pricing, version, and codec details.</p>

<div class="client-facts" markdown>
<span><strong>Price:</strong> TestFlight beta; no public App Store price or paid tier found.</span>
<span><strong>Version checked:</strong> Public TestFlight page checked; build/version not exposed.</span>
</div>

<div class="client-note-grid" markdown>
<div markdown>
**Good fit:** You want to track a new Plex/Jellyfin beta with Seerr and Trakt signals.
</div>
<div markdown>
**Watch outs:** The public TestFlight page does not publish codec support or detailed feature docs.
</div>
</div>

!!! info "Published codec details"
    No public codec list found. The public TestFlight page only confirms iOS/tvOS beta availability.

Sources: [TestFlight](https://testflight.apple.com/join/D9QKAMMF)
{: .client-source-list }

<h2 id="jellysee" class="client-heading"><img class="client-logo" src="../../../images/jellyfinjune/clients/tvos/jellysee.jpg" alt=""> JellySee</h2>
<p class="client-summary">Paid Jellyfin plus Seerr app with unusually explicit codec documentation plus music, PiP, trickplay, and request features. The feature list is strong on paper; episode notes still need a retest because playback struggled.</p>

<div class="client-facts" markdown>
<span><strong>Price:</strong> $8.99 upfront; optional donation IAPs list $1, $5, $10, $15, $20, and $100.</span>
<span><strong>Version checked:</strong> App Store 3.0.3, released 2026-06-25.</span>
</div>

<div class="client-note-grid" markdown>
<div markdown>
**Good fit:** You want Jellyfin, Seerr, music support, PiP, and explicit codec documentation.
</div>
<div markdown>
**Watch outs:** Episode playback was poor on the tested build; personal videos struggled.
</div>
</div>

!!! info "Published codec details"
    Containers: MP4, M4V, and MOV direct play; MKV direct stream/remux; AVI limited. Video: MPEG4 limited, H.264, H.265, VP9. Dynamic range: SDR, HLG, HDR10+, Dolby Vision profiles 5, 7, 8.1, and 8.4. Audio up to 7.1: AAC, AC3, EAC3 + Atmos, ALAC, FLAC, Opus, Vorbis. Subtitles: PGS, WebVTT, SRT, ASS; DVD/VobSub via transcode.

Sources: [App Store](https://apps.apple.com/us/app/jellysee/id6748783768)
{: .client-source-list }

<h2 id="jellytv" class="client-heading"><img class="client-logo" src="../../../images/jellyfinjune/clients/tvos/jellytv.jpg" alt=""> JellyTV</h2>
<p class="client-summary">Free native Jellyfin app with a modern Apple-style UI, Seerr request management, downloads, and optional JellyTV+ extras. Core playback is free; admin, customization, and integration features sit behind JellyTV+ or separate unlocks.</p>

<div class="client-facts" markdown>
<span><strong>Price:</strong> Free download; IAP list includes JellyTV+ monthly $1.99/$3.99, yearly $14.99/$29.99, lifetime $19.99/$39.99, family lifetime $89.99, and admin tools $14.99.</span>
<span><strong>Version checked:</strong> App Store 1.3.1, released 2026-06-13.</span>
</div>

<div class="client-note-grid" markdown>
<div markdown>
**Good fit:** You want a modern Apple-style Jellyfin UI with Seerr requests and optional admin extras.
</div>
<div markdown>
**Watch outs:** Codec support is described broadly; the listing does not publish a format table.
</div>
</div>

!!! info "Published codec details"
    App Store claims high-quality video support, live streaming, and transcoding. I did not find a public codec/container table.

Sources: [App Store](https://apps.apple.com/us/app/jellytv/id6752357290)
{: .client-source-list }

<h2 id="moonfin" class="client-heading"><img class="client-logo" src="../../../images/jellyfinjune/clients/tvos/moonfin.jpg" alt=""> Moonfin</h2>
<p class="client-summary">Fast-moving cross-platform Jellyfin/Emby client with broad library coverage: video, music, books, Live TV/DVR, Seerr, and admin-style tooling. It currently reads like one of the most feature-complete Jellyfin-native candidates, with some UI roughness in the episode.</p>

<div class="client-facts" markdown>
<span><strong>Price:</strong> Free download; no IAP section found.</span>
<span><strong>Version checked:</strong> App Store 2.2.0, released 2026-06-19.</span>
</div>

<div class="client-note-grid" markdown>
<div markdown>
**Good fit:** You want one of the widest Jellyfin feature sets: video, music, books, Live TV/DVR, Seerr, and admin-style tools.
</div>
<div markdown>
**Watch outs:** The app is moving fast; episode notes found UI roughness despite strong playback controls.
</div>
</div>

!!! info "Published codec details"
    Moonfin-Core lists video support for H.264, HEVC/H.265, VP8, VP9, AV1, MPEG-2, MPEG-4, and VC-1; audio support for AAC, MP3, FLAC, Opus, Vorbis, AC3, EAC3, DTS, TrueHD, PCM, and ALAC; containers MP4, MKV, WebM, AVI, MOV, TS/M2TS, and WMV/ASF; subtitles SRT, ASS/SSA, VTT/WebVTT, TTML, and SUB, with bitmap subtitle support on desktop. The project docs say Apple TV uses MPVKit and supports Dolby Vision Profile 7 direct play.

Sources: [App Store](https://apps.apple.com/us/app/moonfin/id6761283970), [Moonfin-Core](https://github.com/Moonfin-Client/Moonfin-Core)
{: .client-source-list }

<h2 id="senplayer" class="client-heading"><img class="client-logo" src="../../../images/jellyfinjune/clients/tvos/senplayer.jpg" alt=""> SenPlayer</h2>
<p class="client-summary">All-in-one media player for local files, NAS/cloud sources, IPTV, Plex/Emby/Jellyfin, and high-end playback formats. Jellyfin is one source among many, and some advanced playback/server features are Pro-gated.</p>

<div class="client-facts" markdown>
<span><strong>Price:</strong> Free download; IAP list includes Lifetime Pro Apple TV $9.99, Suite $12.99, iPhone+iPad $9.99, Mac $9.99, and Suite upgrade $6.99.</span>
<span><strong>Version checked:</strong> App Store 6.1.3, released 2026-06-24.</span>
</div>

<div class="client-note-grid" markdown>
<div markdown>
**Good fit:** You want Jellyfin alongside local files, NAS/cloud sources, IPTV, and broad published format support.
</div>
<div markdown>
**Watch outs:** Manual setup only in the episode; some advanced playback is Pro-gated.
</div>
</div>

!!! info "Published codec details"
    Video/container support includes MP4, MKV, VOB, BIK, DAT, TS, MTS, M2T, M2TS, MPG, MPEG, AVI, RMVB, FLV, SWF, WEBM, 3GP, MOV, ISO, and more. Audio includes MP3, FLAC, AAC, WMA, APE, M4A, WAV, DFF, and DSF. Image support includes JPEG, PNG, GIF, WEBP, BMP, and HEIC. The listing also claims 4K/8K, 120fps, HDR10, HDR10+, and HLG.

Sources: [App Store](https://apps.apple.com/us/app/senplayer-media-player/id6443975850)
{: .client-source-list }

<h2 id="plezy" class="client-heading"><img class="client-logo" src="../../../images/jellyfinjune/clients/tvos/plezy.jpg" alt=""> Plezy</h2>
<p class="client-summary">Paid Plex/Jellyfin client positioned around a one-time purchase rather than subscriptions. Feature set centers on playback, downloads, profiles, and discovery with a less complete public codec table.</p>

<div class="client-facts" markdown>
<span><strong>Price:</strong> $5.99 upfront; no IAP section found.</span>
<span><strong>Version checked:</strong> App Store 2.6.0, released 2026-06-11.</span>
</div>

<div class="client-note-grid" markdown>
<div markdown>
**Good fit:** You want a paid Plex/Jellyfin client with downloads, profiles, and no subscription claim in the listing.
</div>
<div markdown>
**Watch outs:** Published codec detail names headline formats, not a full table.
</div>
</div>

!!! info "Published codec details"
    App Store claims wide codec support including HEVC, AV1, VP9, HDR playback, and advanced ASS/SSA subtitle rendering. It does not publish full container/audio/HDR tables.

Sources: [App Store](https://apps.apple.com/us/app/plezy-for-plex-jellyfin/id6754315964)
{: .client-source-list }

<h2 id="reefy" class="client-heading"><img class="client-logo" src="../../../images/jellyfinjune/clients/tvos/reefy.jpg" alt=""> Reefy</h2>
<p class="client-summary">tvOS-only Swiftfin fork with VLC-based direct playback and a paid App Store model. It is narrowly focused on Apple TV Jellyfin use, with Live TV still listed as a future goal.</p>

<div class="client-facts" markdown>
<span><strong>Price:</strong> $9.99 upfront; no IAP section found.</span>
<span><strong>Version checked:</strong> App Store 1.4.2, released 2026-06-16.</span>
</div>

<div class="client-note-grid" markdown>
<div markdown>
**Good fit:** You want a tvOS-only Swiftfin fork with VLC-based playback.
</div>
<div markdown>
**Watch outs:** Live TV is still a goal, and public codec detail is broad rather than exact.
</div>
</div>

!!! info "Published codec details"
    App Store says Reefy uses a VLC-based player with broad codec support and surround passthrough. The GitHub README says it is a Swiftfin fork using VLC for direct playback. I did not find a full codec table.

Sources: [App Store](https://apps.apple.com/us/app/reefy-media-player/id6757623550), [GitHub](https://github.com/jmhunter83/reefy)
{: .client-source-list }

<h2 id="techdad-player" class="client-heading"><img class="client-logo" src="../../../images/jellyfinjune/clients/tvos/techdad.jpg" alt=""> TechDad Player</h2>
<p class="client-summary">Lightweight Jellyfin/Emby/local-file player with a small feature surface and App Store-listed paid unlock tiers. The episode found weak playback and scaling issues, so it needs a careful retest before recommending.</p>

<div class="client-facts" markdown>
<span><strong>Price:</strong> Free download; IAP list includes Pro monthly $0.99, yearly $6.99, and lifetime $13.99.</span>
<span><strong>Version checked:</strong> App Store 1.1.7, released 2026-04-09.</span>
</div>

<div class="client-note-grid" markdown>
<div markdown>
**Good fit:** You want a small, lightweight player and are willing to accept a minimal library model.
</div>
<div markdown>
**Watch outs:** Episode playback was weak, and the library UI did not scale well.
</div>
</div>

!!! info "Published codec details"
    App Store claims H.264, HEVC, AV1, MKV/MP4 containers, HDR, embedded tracks, embedded/external subtitles, and local MP4/MOV playback.

Sources: [App Store](https://apps.apple.com/us/app/techdad-player/id6756520836)
{: .client-source-list }

<h2 id="streamyfin" class="client-heading"><img class="client-logo" src="../../../images/jellyfinjune/clients/tvos/streamyfin.jpg" alt=""> Streamyfin</h2>
<p class="client-summary">Open-source Jellyfin video client built around the Streamyfin ecosystem and companion plugin settings. It is attractive if you value open development, but public docs still say music is not supported.</p>

<div class="client-facts" markdown>
<span><strong>Price:</strong> Free download; no IAP section found.</span>
<span><strong>Version checked:</strong> App Store 0.54.1, released 2026-06-02.</span>
</div>

<div class="client-note-grid" markdown>
<div markdown>
**Good fit:** You like the open-source Streamyfin ecosystem and server-side settings plugin.
</div>
<div markdown>
**Watch outs:** The README says music is not currently supported; tvOS navigation was rough in the episode.
</div>
</div>

!!! info "Published codec details"
    The project README says Streamyfin uses MPV via MPVKit and describes MPV as having wide format support. I did not find a tvOS-specific codec table.

Sources: [App Store](https://apps.apple.com/us/app/streamyfin/id6593660679), [GitHub](https://github.com/streamyfin/streamyfin)
{: .client-source-list }

<h2 id="stingray" class="client-heading"><img class="client-logo" src="../../../images/jellyfinjune/clients/tvos/stingray.jpg" alt=""> Stingray</h2>
<p class="client-summary">Native Jellyfin client that advertises quality, audio, subtitle, and track controls. It remains hard to judge empirically from the episode because login failed and no public codec table was found.</p>

<div class="client-facts" markdown>
<span><strong>Price:</strong> Free download; optional Supporter IAP lists $1.49.</span>
<span><strong>Version checked:</strong> App Store v1.3.0, released 2026-06-16.</span>
</div>

<div class="client-note-grid" markdown>
<div markdown>
**Good fit:** You want to watch a native Jellyfin app that advertises track and quality controls.
</div>
<div markdown>
**Watch outs:** Login failed in the episode, and no public codec list was found.
</div>
</div>

!!! info "Published codec details"
    App Store says the app can adjust quality, video tracks, audio tracks, and subtitles. I did not find codec/container support.

Sources: [App Store](https://apps.apple.com/us/app/stingray-streaming/id6756280505)
{: .client-source-list }

<h2 id="oopsplayer" class="client-heading"><img class="client-logo" src="../../../images/jellyfinjune/clients/tvos/oopsplayer.jpg" alt=""> OopsPlayer</h2>
<p class="client-summary">Multi-source player covering local files, SMB/WebDAV, cloud, IPTV, Plex, Emby, and Jellyfin. It publishes useful format claims, but Jellyfin felt secondary in the episode and Pro gates several source/playback limits.</p>

<div class="client-facts" markdown>
<span><strong>Price:</strong> Free download; OopsPlayer Pro IAPs list monthly $1.99, yearly $17.99, and lifetime $8.99.</span>
<span><strong>Version checked:</strong> App Store 2.1.1, released 2026-06-25.</span>
</div>

<div class="client-note-grid" markdown>
<div markdown>
**Good fit:** Jellyfin is one of several sources you want in a single player.
</div>
<div markdown>
**Watch outs:** Jellyfin felt secondary in the episode; setup was awkward.
</div>
</div>

!!! info "Published codec details"
    App Store claims 4K, HDR, Dolby Vision, Blu-ray ISO/BDMV, MKV, MP4, MOV, AVI, FLV, WMV, and PiP.

Sources: [App Store](https://apps.apple.com/us/app/oopsplayer-media-player/id6758075545)
{: .client-source-list }

<h2 id="liquidfin" class="client-heading"><img class="client-logo" src="../../../images/jellyfinjune/clients/tvos/liquidfin.jpg" alt=""> LiquidFin</h2>
<p class="client-summary">Native Jellyfin app with broad library coverage across video, music, audiobooks, books, Live TV, Jellyseerr, and admin tools. The feature list is extensive, but the episode found sparse playback controls and no public codec table is published.</p>

<div class="client-facts" markdown>
<span><strong>Price:</strong> Free download; Pro IAPs list monthly $1.99, yearly $9.99/$12.99, and lifetime $29.99/$39.99.</span>
<span><strong>Version checked:</strong> App Store 1.1.2, released 2026-06-27.</span>
</div>

<div class="client-note-grid" markdown>
<div markdown>
**Good fit:** You want broad Jellyfin feature coverage: music, books, Live TV, Jellyseerr, and admin tools.
</div>
<div markdown>
**Watch outs:** No public codec table found; episode player controls were sparse.
</div>
</div>

!!! info "Published codec details"
    App Store describes native playback but does not publish codec/container support.

Sources: [App Store](https://apps.apple.com/us/app/liquidfin/id6755673532)
{: .client-source-list }

<h2 id="nostalgex" class="client-heading"><img class="client-logo" src="../../../images/jellyfinjune/clients/tvos/nostalgex.jpg" alt=""> Nostalgex</h2>
<p class="client-summary">Bonus Plex/Jellyfin channel-surfing app rather than a standard client replacement. It turns library items into EPG-style channels, so pricing/version matter but codec support is not the core purchase question.</p>

<div class="client-facts" markdown>
<span><strong>Price:</strong> Free download; no IAP section found.</span>
<span><strong>Version checked:</strong> App Store 1.0.9, released 2026-06-25.</span>
</div>

<div class="client-note-grid" markdown>
<div markdown>
**Good fit:** You want your Plex/Jellyfin library to feel like channel surfing.
</div>
<div markdown>
**Watch outs:** It is not a normal Jellyfin client replacement and is not codec-focused.
</div>
</div>

!!! info "Published codec details"
    App Store does not publish codec support. Nostalgex focuses on EPG-style channel packages, mini guide overlay, collection channels, family-safe channels, and retro mode.

Sources: [App Store](https://apps.apple.com/us/app/nostalgex/id6762563534)
{: .client-source-list }
