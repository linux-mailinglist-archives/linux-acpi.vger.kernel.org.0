Return-Path: <linux-acpi+bounces-13839-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54673ABF7C1
	for <lists+linux-acpi@lfdr.de>; Wed, 21 May 2025 16:24:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72DAC7A34FA
	for <lists+linux-acpi@lfdr.de>; Wed, 21 May 2025 14:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AE191A5BB2;
	Wed, 21 May 2025 14:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=librem.one header.i=@librem.one header.b="U3WHaV5W"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mx1.librem.one (mx1.librem.one [138.201.176.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21DD01B392B
	for <linux-acpi@vger.kernel.org>; Wed, 21 May 2025 14:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=138.201.176.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747837403; cv=none; b=Dn+1W/u+MsTh7CGHjrrEUz0o801RylRFkSAAbSUcWh0eu1H9L9PBkbE3Z9c3VJVvNJCiREjrSvBFtmeSyjhAHMKkXkFS/0I8dlnutI8yiaK9n43U75ynFkGnIUvoUgU7IbDEg2UOM4eHn3lcKumGjL2TF69ZF/ZW+9btrwdkSw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747837403; c=relaxed/simple;
	bh=c78B8aCgDs389zeuCW5/WkMUuS5DbGlLteNG5rm9uZA=;
	h=Date:From:Subject:To:Message-Id:In-Reply-To:References:
	 Content-Type; b=bb7ygOJzoC3qhonuDSxdud5Ysqj+4tIm4OWicK7gjZtSuVzgk8g5qAL15rBeZUYlxN6qyIvbjub4ioODHkqU5M6qxYvI+dIu9pHfSaYtqNBLMN3PLsEQIX9cJVVKU12CB+EmHuQjmAvBX9J8+y7XobXpZGM/NtHxcqZxxyUwzvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=librem.one; spf=pass smtp.mailfrom=librem.one; dkim=pass (2048-bit key) header.d=librem.one header.i=@librem.one header.b=U3WHaV5W; arc=none smtp.client-ip=138.201.176.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=librem.one
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=librem.one
Received: from smtp.librem.one (unknown [192.241.214.14])
	by mx1.librem.one (Postfix) with ESMTPS id 502FC81E85
	for <linux-acpi@vger.kernel.org>; Wed, 21 May 2025 07:23:14 -0700 (PDT)
Authentication-Results: name mx1.librem.one; dmarc=fail (p=reject dis=none) header.from=librem.one
Date: Wed, 21 May 2025 07:23:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=librem.one; s=smtp;
	t=1747837392; bh=c78B8aCgDs389zeuCW5/WkMUuS5DbGlLteNG5rm9uZA=;
	h=Date:From:Subject:To:In-Reply-To:References:From;
	b=U3WHaV5WMV2bjXq15ot+t+f/oFS0HubfWhNmD0/u0iartEJppSROKDqFawdOBxfQH
	 ie1bivXmtCCW0j7df3GvfuBGfmCbki85JuGV4PtZauJhLlNngBQl3iVjlQ1s1NGI3f
	 4KmUEJ3zVbECqMPUpp6NbKru5VgFStB4fdF7UhZdkJDD6UfySGgwSk4a/N2R+0K06l
	 Awl5bG5n3qwcLqAtGEGaRkOqZCf53rURTUWhgrTVAq+lNtfqgSyYwRYBNn1ATml6cy
	 ukWGigfuKAzQkbfdHcC0lg3Acrzeol1i78DH3IACnRo3zN1z+h+ybwc4LL28Jva+Rz
	 otmuVccEdkmpg==
From: Captain <goatwildernesscollective@librem.one>
Subject: Re: ACPI Kernel Level 3 Log Messages on Apple Inc. MacPro7,1
To: linux-acpi@vger.kernel.org
Message-Id: <FY7MWS.UBIGIDNVC6V4@librem.one>
In-Reply-To: <5L7MWS.HH9OXTFTNIIY@librem.one>
References: <5L7MWS.HH9OXTFTNIIY@librem.one>
Content-Type: text/plain; charset=us-ascii; format=flowed
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

I am seeing the following kernel log level 3 messages, everything 
appears to work on the MacPro. There is also a known issue with system 
suspend "bce-vhci" and I am not sure that might be related or not.

Re-submitted as plain text.

Environment:

Apple Inc. MacPro7,1, Ubuntu Plucky Puffin.

Modules:
$less /proc/modules
wireguard 114688 0 - Live 0x0000000000000000
curve25519_x86_64 36864 1 wireguard, Live 0x0000000000000000
libcurve25519_generic 45056 2 wireguard,curve25519_x86_64, Live 
0x0000000000000000
ip6_udp_tunnel 16384 1 wireguard, Live 0x0000000000000000
udp_tunnel 32768 1 wireguard, Live 0x0000000000000000
dummy 12288 0 - Live 0x0000000000000000
isofs 61440 1 - Live 0x0000000000000000
exfat 110592 1 - Live 0x0000000000000000
snd_seq_dummy 12288 0 - Live 0x0000000000000000
snd_hrtimer 12288 1 - Live 0x0000000000000000
overlay 217088 0 - Live 0x0000000000000000
uhid 20480 2 - Live 0x0000000000000000
rfcomm 102400 6 - Live 0x0000000000000000
cmac 12288 3 - Live 0x0000000000000000
algif_hash 16384 1 - Live 0x0000000000000000
algif_skcipher 16384 1 - Live 0x0000000000000000
af_alg 32768 6 algif_hash,algif_skcipher, Live 0x0000000000000000
bnep 32768 2 - Live 0x0000000000000000
ip6t_REJECT 12288 1 - Live 0x0000000000000000
nf_reject_ipv6 20480 1 ip6t_REJECT, Live 0x0000000000000000
xt_hl 12288 22 - Live 0x0000000000000000
ip6t_rt 16384 3 - Live 0x0000000000000000
ipt_REJECT 12288 1 - Live 0x0000000000000000
nf_reject_ipv4 12288 1 ipt_REJECT, Live 0x0000000000000000
xt_LOG 16384 10 - Live 0x0000000000000000
nf_log_syslog 20480 10 - Live 0x0000000000000000
xt_multiport 16384 4 - Live 0x0000000000000000
xt_comment 12288 4 - Live 0x0000000000000000
nft_limit 16384 13 - Live 0x0000000000000000
xt_limit 12288 0 - Live 0x0000000000000000
xt_addrtype 12288 4 - Live 0x0000000000000000
xt_tcpudp 16384 60 - Live 0x0000000000000000
xt_conntrack 12288 16 - Live 0x0000000000000000
nf_conntrack 200704 1 xt_conntrack, Live 0x0000000000000000
nf_defrag_ipv6 24576 1 nf_conntrack, Live 0x0000000000000000
nf_defrag_ipv4 12288 1 nf_conntrack, Live 0x0000000000000000
nft_compat 20480 125 - Live 0x0000000000000000
nf_tables 385024 850 nft_limit,nft_compat, Live 0x0000000000000000
binfmt_misc 24576 1 - Live 0x0000000000000000
cdc_mbim 20480 0 - Live 0x0000000000000000
cdc_wdm 28672 1 cdc_mbim, Live 0x0000000000000000
nls_iso8859_1 12288 1 - Live 0x0000000000000000
brcmfmac_wcc 12288 0 - Live 0x0000000000000000
intel_rapl_msr 20480 0 - Live 0x0000000000000000
cdc_ncm 49152 1 cdc_mbim, Live 0x0000000000000000
intel_rapl_common 53248 1 intel_rapl_msr, Live 0x0000000000000000
cdc_ether 24576 1 cdc_ncm, Live 0x0000000000000000
usbnet 61440 3 cdc_mbim,cdc_ncm,cdc_ether, Live 0x0000000000000000
intel_uncore_frequency 16384 0 - Live 0x0000000000000000
intel_uncore_frequency_common 16384 1 intel_uncore_frequency, Live 
0x0000000000000000
mii 20480 1 usbnet, Live 0x0000000000000000
amdgpu 19755008 137 - Live 0x0000000000000000
skx_edac 20480 0 - Live 0x0000000000000000
skx_edac_common 24576 1 skx_edac, Live 0x0000000000000000
nfit 81920 1 skx_edac_common, Live 0x0000000000000000
x86_pkg_temp_thermal 20480 0 - Live 0x0000000000000000
amdxcp 12288 1 amdgpu, Live 0x0000000000000000
intel_powerclamp 24576 0 - Live 0x0000000000000000
gpu_sched 61440 1 amdgpu, Live 0x0000000000000000
snd_usb_audio 561152 3 - Live 0x0000000000000000
drm_panel_backlight_quirks 12288 1 amdgpu, Live 0x0000000000000000
drm_buddy 24576 1 amdgpu, Live 0x0000000000000000
drm_ttm_helper 16384 1 amdgpu, Live 0x0000000000000000
snd_hda_codec_hdmi 98304 2 - Live 0x0000000000000000
snd_usbmidi_lib 57344 1 snd_usb_audio, Live 0x0000000000000000
kvm_intel 483328 0 - Live 0x0000000000000000
ttm 118784 2 amdgpu,drm_ttm_helper, Live 0x0000000000000000
snd_ump 45056 1 snd_usb_audio, Live 0x0000000000000000
uvcvideo 147456 0 - Live 0x0000000000000000
ucsi_ccg 24576 0 - Live 0x0000000000000000
spi_nor 163840 0 - Live 0x0000000000000000
btusb 73728 0 - Live 0x0000000000000000
drm_exec 12288 1 amdgpu, Live 0x0000000000000000
videobuf2_vmalloc 20480 1 uvcvideo, Live 0x0000000000000000
btrtl 36864 1 btusb, Live 0x0000000000000000
typec_ucsi 65536 1 ucsi_ccg, Live 0x0000000000000000
snd_seq_midi 24576 0 - Live 0x0000000000000000
drm_suballoc_helper 16384 1 amdgpu, Live 0x0000000000000000
uvc 12288 1 uvcvideo, Live 0x0000000000000000
snd_seq_midi_event 16384 1 snd_seq_midi, Live 0x0000000000000000
typec 114688 1 typec_ucsi, Live 0x0000000000000000
mtd 102400 1 spi_nor, Live 0x0000000000000000
snd_hda_intel 65536 2 - Live 0x0000000000000000
applesmc 45056 0 - Live 0x0000000000000000 (OE)
videobuf2_memops 16384 1 videobuf2_vmalloc, Live 0x0000000000000000
btintel 69632 1 btusb, Live 0x0000000000000000
drm_display_helper 282624 1 amdgpu, Live 0x0000000000000000
videobuf2_v4l2 36864 1 uvcvideo, Live 0x0000000000000000
snd_seq 122880 9 snd_seq_dummy,snd_seq_midi,snd_seq_midi_event, Live 
0x0000000000000000
snd_intel_dspcfg 45056 1 snd_hda_intel, Live 0x0000000000000000
btbcm 24576 1 btusb, Live 0x0000000000000000
snd_intel_sdw_acpi 16384 1 snd_intel_dspcfg, Live 0x0000000000000000
videobuf2_common 90112 4 
uvcvideo,videobuf2_vmalloc,videobuf2_memops,videobuf2_v4l2, Live 
0x0000000000000000
kvm 1433600 1 kvm_intel, Live 0x0000000000000000
cec 94208 2 amdgpu,drm_display_helper, Live 0x0000000000000000
btmtk 36864 1 btusb, Live 0x0000000000000000
snd_hda_codec 204800 2 snd_hda_codec_hdmi,snd_hda_intel, Live 
0x0000000000000000
snd_rawmidi 57344 3 snd_usbmidi_lib,snd_ump,snd_seq_midi, Live 
0x0000000000000000
brcmfmac 536576 1 brcmfmac_wcc, Live 0x0000000000000000
rc_core 73728 1 cec, Live 0x0000000000000000
videodev 364544 2 uvcvideo,videobuf2_v4l2, Live 0x0000000000000000
irqbypass 12288 1 kvm, Live 0x0000000000000000
snd_seq_device 16384 4 snd_ump,snd_seq_midi,snd_seq,snd_rawmidi, Live 
0x0000000000000000
snd_hda_core 147456 3 snd_hda_codec_hdmi,snd_hda_intel,snd_hda_codec, 
Live 0x0000000000000000
video 77824 1 amdgpu, Live 0x0000000000000000
rapl 20480 0 - Live 0x0000000000000000
i2c_designware_pci 12288 0 - Live 0x0000000000000000
brcmutil 24576 1 brcmfmac, Live 0x0000000000000000
intel_cstate 20480 0 - Live 0x0000000000000000
bluetooth 1015808 34 rfcomm,bnep,btusb,btrtl,btintel,btbcm,btmtk, Live 
0x0000000000000000
mc 86016 5 
snd_usb_audio,uvcvideo,videobuf2_v4l2,videobuf2_common,videodev, Live 
0x0000000000000000
wmi 28672 1 video, Live 0x0000000000000000
i2c_ccgx_ucsi 12288 1 i2c_designware_pci, Live 0x0000000000000000
snd_hwdep 20480 2 snd_usb_audio,snd_hda_codec, Live 0x0000000000000000
cfg80211 1449984 1 brcmfmac, Live 0x0000000000000000
i2c_i801 36864 0 - Live 0x0000000000000000
spi_intel_pci 12288 0 - Live 0x0000000000000000
i2c_smbus 20480 1 i2c_i801, Live 0x0000000000000000
spi_intel 36864 1 spi_intel_pci, Live 0x0000000000000000
i2c_mux 16384 1 i2c_i801, Live 0x0000000000000000
lpc_ich 32768 0 - Live 0x0000000000000000
mei_me 53248 0 - Live 0x0000000000000000
mei 176128 1 mei_me, Live 0x0000000000000000
intel_pch_thermal 20480 0 - Live 0x0000000000000000
cdc_acm 49152 0 - Live 0x0000000000000000
ioatdma 90112 0 - Live 0x0000000000000000
acpi_tad 20480 0 - Live 0x0000000000000000
input_leds 12288 0 - Live 0x0000000000000000
hid_magicmouse 20480 0 - Live 0x0000000000000000
joydev 32768 0 - Live 0x0000000000000000
apple_mfi_fastcharge 16384 0 - Live 0x0000000000000000
mac_hid 12288 0 - Live 0x0000000000000000
sch_fq_codel 24576 30 - Live 0x0000000000000000
apple_bce 122880 0 - Live 0x0000000000000000 (OE)
coretemp 24576 0 - Live 0x0000000000000000
msr 12288 0 - Live 0x0000000000000000
parport_pc 53248 0 - Live 0x0000000000000000
ppdev 24576 0 - Live 0x0000000000000000
lp 28672 0 - Live 0x0000000000000000
parport 73728 3 parport_pc,ppdev,lp, Live 0x0000000000000000
efi_pstore 12288 0 - Live 0x0000000000000000
nfnetlink 20480 3 nft_compat,nf_tables, Live 0x0000000000000000
dmi_sysfs 24576 0 - Live 0x0000000000000000
ip_tables 36864 0 - Live 0x0000000000000000
x_tables 65536 13 
ip6t_REJECT,xt_hl,ip6t_rt,ipt_REJECT,xt_LOG,xt_multiport,xt_comment,xt_limit,xt_addrtype,xt_tcpudp,xt_conntrack,nft_compat,ip_tables, 
Live 0x0000000000000000
autofs4 57344 2 - Live 0x0000000000000000
btrfs 2121728 0 - Live 0x0000000000000000
blake2b_generic 20480 0 - Live 0x0000000000000000
dm_crypt 69632 3 - Live 0x0000000000000000
raid10 77824 0 - Live 0x0000000000000000
raid456 196608 0 - Live 0x0000000000000000
async_raid6_recov 20480 1 raid456, Live 0x0000000000000000
async_memcpy 16384 2 raid456,async_raid6_recov, Live 0x0000000000000000
async_pq 20480 2 raid456,async_raid6_recov, Live 0x0000000000000000
async_xor 16384 3 raid456,async_raid6_recov,async_pq, Live 
0x0000000000000000
async_tx 16384 5 
raid456,async_raid6_recov,async_memcpy,async_pq,async_xor, Live 
0x0000000000000000
xor 20480 2 btrfs,async_xor, Live 0x0000000000000000
raid6_pq 126976 4 btrfs,raid456,async_raid6_recov,async_pq, Live 
0x0000000000000000
raid1 61440 0 - Live 0x0000000000000000
linear 16384 0 - Live 0x0000000000000000
snd_pcm 196608 6 
snd_usb_audio,snd_hda_codec_hdmi,snd_hda_intel,snd_hda_codec,snd_hda_core,apple_bce, 
Live 0x0000000000000000
snd_timer 53248 3 snd_hrtimer,snd_seq,snd_pcm, Live 0x0000000000000000
snd 143360 25 
snd_usb_audio,snd_hda_codec_hdmi,snd_usbmidi_lib,snd_ump,snd_hda_intel,snd_seq,snd_hda_codec,snd_rawmidi,snd_seq_device,snd_hwdep,apple_bce,snd_pcm,snd_timer, 
Live 0x0000000000000000
soundcore 16384 1 snd, Live 0x0000000000000000
hid_generic 12288 0 - Live 0x0000000000000000
usbhid 77824 0 - Live 0x0000000000000000
raid0 28672 1 - Live 0x0000000000000000
uas 32768 0 - Live 0x0000000000000000
hid 266240 4 uhid,hid_magicmouse,hid_generic,usbhid, Live 
0x0000000000000000
igb 335872 0 - Live 0x0000000000000000
i2c_algo_bit 20480 2 amdgpu,igb, Live 0x0000000000000000
dca 16384 2 ioatdma,igb, Live 0x0000000000000000
polyval_clmulni 12288 0 - Live 0x0000000000000000
polyval_generic 12288 1 polyval_clmulni, Live 0x0000000000000000
ghash_clmulni_intel 16384 0 - Live 0x0000000000000000
sha256_ssse3 32768 0 - Live 0x0000000000000000
usb_storage 86016 3 uas, Live 0x0000000000000000
thunderbolt 544768 0 - Live 0x0000000000000000
nvme 61440 3 - Live 0x0000000000000000
sha1_ssse3 32768 0 - Live 0x0000000000000000
atlantic 327680 0 - Live 0x0000000000000000
nvme_core 229376 4 nvme, Live 0x0000000000000000
ahci 49152 3 - Live 0x0000000000000000
macsec 77824 1 atlantic, Live 0x0000000000000000
8250_pericom 16384 0 - Live 0x0000000000000000
libahci 53248 1 ahci, Live 0x0000000000000000
nvme_auth 28672 1 nvme_core, Live 0x0000000000000000
aesni_intel 122880 10 - Live 0x0000000000000000
crypto_simd 16384 1 aesni_intel, Live 0x0000000000000000
cryptd 24576 6 ghash_clmulni_intel,crypto_simd, Live 0x0000000000000000

$lsmod
Module                  Size  Used by
wireguard             114688  0
curve25519_x86_64      36864  1 wireguard
libcurve25519_generic    45056  2 curve25519_x86_64,wireguard
ip6_udp_tunnel         16384  1 wireguard
udp_tunnel             32768  1 wireguard
dummy                  12288  0
isofs                  61440  1
exfat                 110592  1
snd_seq_dummy          12288  0
snd_hrtimer            12288  1
overlay               217088  0
uhid                   20480  2
rfcomm                102400  6
cmac                   12288  3
algif_hash             16384  1
algif_skcipher         16384  1
af_alg                 32768  6 algif_hash,algif_skcipher
bnep                   32768  2
ip6t_REJECT            12288  1
nf_reject_ipv6         20480  1 ip6t_REJECT
xt_hl                  12288  22
ip6t_rt                16384  3
ipt_REJECT             12288  1
nf_reject_ipv4         12288  1 ipt_REJECT
xt_LOG                 16384  10
nf_log_syslog          20480  10
xt_multiport           16384  4
xt_comment             12288  4
nft_limit              16384  13
xt_limit               12288  0
xt_addrtype            12288  4
xt_tcpudp              16384  60
xt_conntrack           12288  16
nf_conntrack          200704  1 xt_conntrack
nf_defrag_ipv6         24576  1 nf_conntrack
nf_defrag_ipv4         12288  1 nf_conntrack
nft_compat             20480  125
nf_tables             385024  850 nft_compat,nft_limit
binfmt_misc            24576  1
cdc_mbim               20480  0
cdc_wdm                28672  1 cdc_mbim
nls_iso8859_1          12288  1
brcmfmac_wcc           12288  0
intel_rapl_msr         20480  0
cdc_ncm                49152  1 cdc_mbim
intel_rapl_common      53248  1 intel_rapl_msr
cdc_ether              24576  1 cdc_ncm
usbnet                 61440  3 cdc_mbim,cdc_ncm,cdc_ether
intel_uncore_frequency    16384  0
intel_uncore_frequency_common    16384  1 intel_uncore_frequency
mii                    20480  1 usbnet
amdgpu              19755008  139
skx_edac               20480  0
skx_edac_common        24576  1 skx_edac
nfit                   81920  1 skx_edac_common
x86_pkg_temp_thermal    20480  0
amdxcp                 12288  1 amdgpu
intel_powerclamp       24576  0
gpu_sched              61440  1 amdgpu
snd_usb_audio         561152  3
drm_panel_backlight_quirks    12288  1 amdgpu
drm_buddy              24576  1 amdgpu
drm_ttm_helper         16384  1 amdgpu
snd_hda_codec_hdmi     98304  2
snd_usbmidi_lib        57344  1 snd_usb_audio
kvm_intel             483328  0
ttm                   118784  2 amdgpu,drm_ttm_helper
snd_ump                45056  1 snd_usb_audio
uvcvideo              147456  0
ucsi_ccg               24576  0
spi_nor               163840  0
btusb                  73728  0
drm_exec               12288  1 amdgpu
videobuf2_vmalloc      20480  1 uvcvideo
btrtl                  36864  1 btusb
typec_ucsi             65536  1 ucsi_ccg
snd_seq_midi           24576  0
drm_suballoc_helper    16384  1 amdgpu
uvc                    12288  1 uvcvideo
snd_seq_midi_event     16384  1 snd_seq_midi
typec                 114688  1 typec_ucsi
mtd                   102400  1 spi_nor
snd_hda_intel          65536  2
applesmc               45056  0
videobuf2_memops       16384  1 videobuf2_vmalloc
btintel                69632  1 btusb
drm_display_helper    282624  1 amdgpu
videobuf2_v4l2         36864  1 uvcvideo
snd_seq               122880  9 
snd_seq_midi,snd_seq_midi_event,snd_seq_dummy
snd_intel_dspcfg       45056  1 snd_hda_intel
btbcm                  24576  1 btusb
snd_intel_sdw_acpi     16384  1 snd_intel_dspcfg
videobuf2_common       90112  4 
videobuf2_vmalloc,videobuf2_v4l2,uvcvideo,videobuf2_memops
kvm                  1433600  1 kvm_intel
cec                    94208  2 drm_display_helper,amdgpu
btmtk                  36864  1 btusb
snd_hda_codec         204800  2 snd_hda_codec_hdmi,snd_hda_intel
snd_rawmidi            57344  3 snd_seq_midi,snd_usbmidi_lib,snd_ump
brcmfmac              536576  1 brcmfmac_wcc
rc_core                73728  1 cec
videodev              364544  2 videobuf2_v4l2,uvcvideo
irqbypass              12288  1 kvm
snd_seq_device         16384  4 snd_seq,snd_seq_midi,snd_ump,snd_rawmidi
snd_hda_core          147456  3 
snd_hda_codec_hdmi,snd_hda_intel,snd_hda_codec
video                  77824  1 amdgpu
rapl                   20480  0
i2c_designware_pci     12288  0
brcmutil               24576  1 brcmfmac
intel_cstate           20480  0
bluetooth            1015808  34 
btrtl,btmtk,btintel,btbcm,bnep,btusb,rfcomm
mc                     86016  5 
videodev,snd_usb_audio,videobuf2_v4l2,uvcvideo,videobuf2_common
wmi                    28672  1 video
i2c_ccgx_ucsi          12288  1 i2c_designware_pci
snd_hwdep              20480  2 snd_usb_audio,snd_hda_codec
cfg80211             1449984  1 brcmfmac
i2c_i801               36864  0
spi_intel_pci          12288  0
i2c_smbus              20480  1 i2c_i801
spi_intel              36864  1 spi_intel_pci
i2c_mux                16384  1 i2c_i801
lpc_ich                32768  0
mei_me                 53248  0
mei                   176128  1 mei_me
intel_pch_thermal      20480  0
cdc_acm                49152  0
ioatdma                90112  0
acpi_tad               20480  0
input_leds             12288  0
hid_magicmouse         20480  0
joydev                 32768  0
apple_mfi_fastcharge    16384  0
mac_hid                12288  0
sch_fq_codel           24576  30
apple_bce             122880  0
coretemp               24576  0
msr                    12288  0
parport_pc             53248  0
ppdev                  24576  0
lp                     28672  0
parport                73728  3 parport_pc,lp,ppdev
efi_pstore             12288  0
nfnetlink              20480  3 nft_compat,nf_tables
dmi_sysfs              24576  0
ip_tables              36864  0
x_tables               65536  13 
xt_conntrack,nft_compat,xt_LOG,xt_multiport,xt_tcpudp,xt_addrtype,ip6t_rt,xt_comment,ipt_REJECT,ip_tables,xt_limit,xt_hl,ip6t_REJECT
autofs4                57344  2
btrfs                2121728  0
blake2b_generic        20480  0
dm_crypt               69632  3
raid10                 77824  0
raid456               196608  0
async_raid6_recov      20480  1 raid456
async_memcpy           16384  2 raid456,async_raid6_recov
async_pq               20480  2 raid456,async_raid6_recov
async_xor              16384  3 async_pq,raid456,async_raid6_recov
async_tx               16384  5 
async_pq,async_memcpy,async_xor,raid456,async_raid6_recov
xor                    20480  2 async_xor,btrfs
raid6_pq              126976  4 async_pq,btrfs,raid456,async_raid6_recov
raid1                  61440  0
linear                 16384  0
snd_pcm               196608  6 
snd_hda_codec_hdmi,snd_hda_intel,snd_usb_audio,snd_hda_codec,apple_bce,snd_hda_core
snd_timer              53248  3 snd_seq,snd_hrtimer,snd_pcm
snd                   143360  25 
snd_seq,snd_seq_device,snd_hda_codec_hdmi,snd_hwdep,snd_hda_intel,snd_usb_audio,snd_usbmidi_lib,snd_hda_codec,snd_timer,apple_bce,snd_ump,snd_pcm,snd_rawmidi
soundcore              16384  1 snd
hid_generic            12288  0
usbhid                 77824  0
raid0                  28672  1
uas                    32768  0
hid                   266240  4 usbhid,hid_generic,uhid,hid_magicmouse
igb                   335872  0
i2c_algo_bit           20480  2 igb,amdgpu
dca                    16384  2 igb,ioatdma
polyval_clmulni        12288  0
polyval_generic        12288  1 polyval_clmulni
ghash_clmulni_intel    16384  0
sha256_ssse3           32768  0
usb_storage            86016  3 uas
thunderbolt           544768  0
nvme                   61440  3
sha1_ssse3             32768  0
atlantic              327680  0
nvme_core             229376  4 nvme
ahci                   49152  3
macsec                 77824  1 atlantic
8250_pericom           16384  0
libahci                53248  1 ahci
nvme_auth              28672  1 nvme_core
aesni_intel           122880  10
crypto_simd            16384  1 aesni_intel
cryptd                 24576  6 crypto_simd,ghash_clmulni_intel

Hardware:

<pre> description: Tower Computer
    product: MacPro7,1
    vendor: Apple Inc.
    version: 1.0
    serial: F5KD805DK7GF
    width: 64 bits
    capabilities: smbios-3.3.0 dmi-3.3.0 smp vsyscall32
    configuration: boot=normal chassis=tower family=Mac Pro 
uuid=5729d150-31de-5104-a070-2dccafa9e3e6
  *-core
       description: Motherboard
       product: Mac-27AD2F918AE68F61
       vendor: Apple Inc.
       physical id: 0
       version: MacPro7,1
       serial: C029517002MK3F74X
     *-memory
          description: System Memory
          physical id: 1
          slot: System board or motherboard
          size: 256GiB
          capacity: 4608GiB
          capabilities: ecc
          configuration: errordetection=ecc
        *-bank:0
             description: DIMM DDR4 Synchronous 2666 MHz (0.4 ns)
             product: M386A8K40BM2-CTD
             vendor: Samsung
             physical id: 0
             serial: 37BD20F4
             slot: Slot 8 (Channel A / DIMM 1)
             size: 64GiB
             width: 64 bits
             clock: 2666MHz (0.4ns)
        *-bank:1
             description: DIMM Synchronous [empty]
             product: NO DIMM
             vendor: NO DIMM
             physical id: 1
             serial: NO DIMM
             slot: Slot 7 (Channel A / DIMM 2)
        *-bank:2
             description: DIMM DDR4 Synchronous 2666 MHz (0.4 ns)
             product: M386A8K40BM2-CTD
             vendor: Samsung
             physical id: 2
             serial: 37B4BF93
             slot: Slot 10 (Channel B / DIMM 1)
             size: 64GiB
             width: 64 bits
             clock: 2666MHz (0.4ns)
        *-bank:3
             description: DIMM Synchronous [empty]
             product: NO DIMM
             vendor: NO DIMM
             physical id: 3
             serial: NO DIMM
             slot: Slot 9 (Channel B / DIMM 2)
        *-bank:4
             description: DIMM Synchronous [empty]
             product: NO DIMM
             vendor: NO DIMM
             physical id: 4
             serial: NO DIMM
             slot: Slot 12 (Channel C / DIMM 1)
        *-bank:5
             description: DIMM Synchronous [empty]
             product: NO DIMM
             vendor: NO DIMM
             physical id: 5
             serial: NO DIMM
             slot: Slot 11 (Channel C / DIMM 2)
        *-bank:6
             description: DIMM DDR4 Synchronous 2666 MHz (0.4 ns)
             product: M386A8K40BM2-CTD
             vendor: Samsung
             physical id: 6
             serial: 37F8F7E5
             slot: Slot 5 (Channel D / DIMM 1)
             size: 64GiB
             width: 64 bits
             clock: 2666MHz (0.4ns)
        *-bank:7
             description: DIMM Synchronous [empty]
             product: NO DIMM
             vendor: NO DIMM
             physical id: 7
             serial: NO DIMM
             slot: Slot 6 (Channel D / DIMM 2)
        *-bank:8
             description: DIMM DDR4 Synchronous 2666 MHz (0.4 ns)
             product: M386A8K40BM2-CTD
             vendor: Samsung
             physical id: 8
             serial: 37F8F43F
             slot: Slot 3 (Channel E / DIMM 1)
             size: 64GiB
             width: 64 bits
             clock: 2666MHz (0.4ns)
        *-bank:9
             description: DIMM Synchronous [empty]
             product: NO DIMM
             vendor: NO DIMM
             physical id: 9
             serial: NO DIMM
             slot: Slot 4 (Channel E / DIMM 2)
        *-bank:10
             description: DIMM Synchronous [empty]
             product: NO DIMM
             vendor: NO DIMM
             physical id: a
             serial: NO DIMM
             slot: Slot 1 (Channel F / DIMM 1)
        *-bank:11
             description: DIMM Synchronous [empty]
             product: NO DIMM
             vendor: NO DIMM
             physical id: b
             serial: NO DIMM
             slot: Slot 2 (Channel F / DIMM 2)
     *-cache:0
          description: L1 cache
          physical id: 23
          slot: L1-Cache
          size: 512KiB
          capacity: 512KiB
          capabilities: synchronous internal write-back instruction
          configuration: level=1
     *-cache:1
          description: L2 cache
          physical id: 24
          slot: L2-Cache
          size: 8MiB
          capacity: 8MiB
          capabilities: synchronous internal varies unified
          configuration: level=2
     *-cache:2
          description: L3 cache
          physical id: 25
          slot: L3-Cache
          size: 16MiB
          capacity: 16MiB
          capabilities: synchronous internal varies unified
          configuration: level=3
     *-cpu
          description: CPU
          product: Intel(R) Xeon(R) W-3223 CPU @ 3.50GHz
          vendor: Intel Corp.
          physical id: 26
          bus info: cpu@0
          version: 6.85.7
          slot: CPU0
          size: 3800MHz
          capacity: 4200MHz
          width: 64 bits
          clock: 100MHz
          capabilities: lm fpu fpu_exception wp vme de pse tsc msr pae 
mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr 
sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp x86-64 constant_tsc art 
arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc cpuid 
aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 ssse3 
sdbg fma cx16 xtpr pdcm pcid dca sse4_1 sse4_2 x2apic movbe popcnt 
tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm 3dnowprefetch 
cpuid_fault epb cat_l3 cdp_l3 intel_ppin ssbd mba ibrs ibpb stibp 
ibrs_enhanced tpr_shadow flexpriority ept vpid ept_ad fsgsbase 
tsc_adjust bmi1 avx2 smep bmi2 erms invpcid cqm mpx rdt_a avx512f 
avx512dq rdseed adx smap clflushopt clwb intel_pt avx512cd avx512bw 
avx512vl xsaveopt xsavec xgetbv1 xsaves cqm_llc cqm_occup_llc 
cqm_mbm_total cqm_mbm_local dtherm ida arat pln pts hwp hwp_act_window 
hwp_epp hwp_pkg_req vnmi pku ospke avx512_vnni md_clear flush_l1d 
arch_capabilities cpufreq
          configuration: cores=8 enabledcores=8 microcode=83900167 
threads=16
     *-firmware
          description: BIOS
          vendor: Apple Inc.
          physical id: 27
          version: 2022.140.5.0.0 (iBridge: 21.16.6074.0.0,0)
          date: 07/03/2024
          size: 1MiB
          capacity: 8MiB
          capabilities: pci upgrade shadowing cdboot bootselect acpi 
smartbattery netboot uefi
     *-pci:0
          description: Host bridge
          product: Sky Lake-E DMI3 Registers
          vendor: Intel Corporation
          physical id: 100
          bus info: pci@0000:00:00.0
          version: 07
          width: 32 bits
          clock: 33MHz
        *-generic:0
             description: System peripheral
             product: Sky Lake-E CBDMA Registers
             vendor: Intel Corporation
             physical id: 4
             bus info: pci@0000:00:04.0
             logical name: /dev/fb0
             version: 07
             width: 64 bits
             clock: 33MHz
             capabilities: msix pciexpress pm bus_master cap_list fb
             configuration: depth=32 driver=ioatdma latency=0 
mode=3840x2160 visual=truecolor xres=3840 yres=2160
             resources: iomemory:8ff0-8fef irq:16 
memory:8fffff10000-8fffff13fff
        *-generic:1
             description: System peripheral
             product: Sky Lake-E CBDMA Registers
             vendor: Intel Corporation
             physical id: 4.1
             bus info: pci@0000:00:04.1
             version: 07
             width: 64 bits
             clock: 33MHz
             capabilities: msix pciexpress pm bus_master cap_list
             configuration: driver=ioatdma latency=0
             resources: iomemory:8ff0-8fef irq:17 
memory:8fffff14000-8fffff17fff
        *-generic:2
             description: System peripheral
             product: Sky Lake-E CBDMA Registers
             vendor: Intel Corporation
             physical id: 4.2
             bus info: pci@0000:00:04.2
             version: 07
             width: 64 bits
             clock: 33MHz
             capabilities: msix pciexpress pm bus_master cap_list
             configuration: driver=ioatdma latency=0
             resources: iomemory:8ff0-8fef irq:18 
memory:8fffff18000-8fffff1bfff
        *-generic:3
             description: System peripheral
             product: Sky Lake-E CBDMA Registers
             vendor: Intel Corporation
             physical id: 4.3
             bus info: pci@0000:00:04.3
             version: 07
             width: 64 bits
             clock: 33MHz
             capabilities: msix pciexpress pm bus_master cap_list
             configuration: driver=ioatdma latency=0
             resources: iomemory:8ff0-8fef irq:19 
memory:8fffff1c000-8fffff1ffff
        *-generic:4
             description: System peripheral
             product: Sky Lake-E CBDMA Registers
             vendor: Intel Corporation
             physical id: 4.4
             bus info: pci@0000:00:04.4
             version: 07
             width: 64 bits
             clock: 33MHz
             capabilities: msix pciexpress pm bus_master cap_list
             configuration: driver=ioatdma latency=0
             resources: iomemory:8ff0-8fef irq:16 
memory:8fffff20000-8fffff23fff
        *-generic:5
             description: System peripheral
             product: Sky Lake-E CBDMA Registers
             vendor: Intel Corporation
             physical id: 4.5
             bus info: pci@0000:00:04.5
             version: 07
             width: 64 bits
             clock: 33MHz
             capabilities: msix pciexpress pm bus_master cap_list
             configuration: driver=ioatdma latency=0
             resources: iomemory:8ff0-8fef irq:17 
memory:8fffff24000-8fffff27fff
        *-generic:6
             description: System peripheral
             product: Sky Lake-E CBDMA Registers
             vendor: Intel Corporation
             physical id: 4.6
             bus info: pci@0000:00:04.6
             version: 07
             width: 64 bits
             clock: 33MHz
             capabilities: msix pciexpress pm bus_master cap_list
             configuration: driver=ioatdma latency=0
             resources: iomemory:8ff0-8fef irq:18 
memory:8fffff28000-8fffff2bfff
        *-generic:7
             description: System peripheral
             product: Sky Lake-E CBDMA Registers
             vendor: Intel Corporation
             physical id: 4.7
             bus info: pci@0000:00:04.7
             version: 07
             width: 64 bits
             clock: 33MHz
             capabilities: msix pciexpress pm bus_master cap_list
             configuration: driver=ioatdma latency=0
             resources: iomemory:8ff0-8fef irq:19 
memory:8fffff2c000-8fffff2ffff
        *-generic:8 UNCLAIMED
             description: System peripheral
             product: Sky Lake-E MM/Vt-d Configuration Registers
             vendor: Intel Corporation
             physical id: 5
             bus info: pci@0000:00:05.0
             version: 07
             width: 32 bits
             clock: 33MHz
             capabilities: pciexpress cap_list
             configuration: latency=0
        *-generic:9 UNCLAIMED
             description: System peripheral
             product: Sky Lake-E RAS
             vendor: Intel Corporation
             physical id: 5.2
             bus info: pci@0000:00:05.2
             version: 07
             width: 32 bits
             clock: 33MHz
             capabilities: pciexpress cap_list
             configuration: latency=0
        *-generic:10 UNCLAIMED
             description: PIC
             product: Sky Lake-E IOAPIC
             vendor: Intel Corporation
             physical id: 5.4
             bus info: pci@0000:00:05.4
             version: 07
             width: 32 bits
             clock: 33MHz
             capabilities: pciexpress pm io_x_-apic bus_master cap_list
             configuration: latency=0
             resources: memory:71988000-71988fff
        *-generic:11 UNCLAIMED
             description: System peripheral
             product: Sky Lake-E Ubox Registers
             vendor: Intel Corporation
             physical id: 8
             bus info: pci@0000:00:08.0
             version: 07
             width: 32 bits
             clock: 33MHz
             capabilities: pciexpress cap_list
             configuration: latency=0
        *-generic:12 UNCLAIMED
             description: Performance counters
             product: Sky Lake-E Ubox Registers
             vendor: Intel Corporation
             physical id: 8.1
             bus info: pci@0000:00:08.1
             version: 07
             width: 32 bits
             clock: 33MHz
             configuration: latency=0
        *-generic:13 UNCLAIMED
             description: System peripheral
             product: Sky Lake-E Ubox Registers
             vendor: Intel Corporation
             physical id: 8.2
             bus info: pci@0000:00:08.2
             version: 07
             width: 32 bits
             clock: 33MHz
             capabilities: pciexpress cap_list
             configuration: latency=0
        *-generic:14 UNCLAIMED
             description: Unassigned class
             product: C620 Series Chipset Family MROM 0
             vendor: Intel Corporation
             physical id: 11
             bus info: pci@0000:00:11.0
             version: 09
             width: 32 bits
             clock: 33MHz
             capabilities: pm cap_list
             configuration: latency=0
        *-generic:15 UNCLAIMED
             description: Unassigned class
             product: C620 Series Chipset Family MROM 1
             vendor: Intel Corporation
             physical id: 11.1
             bus info: pci@0000:00:11.1
             version: 09
             width: 32 bits
             clock: 33MHz
             capabilities: pm cap_list
             configuration: latency=0
        *-usb
             description: USB controller
             product: C620 Series Chipset Family USB 3.0 xHCI Controller
             vendor: Intel Corporation
             physical id: 14
             bus info: pci@0000:00:14.0
             version: 09
             width: 64 bits
             clock: 33MHz
             capabilities: pm msi xhci bus_master cap_list
             configuration: driver=xhci_hcd latency=0
             resources: iomemory:8ff0-8fef irq:51 
memory:8fffff00000-8fffff0ffff
           *-usbhost:0
                product: xHCI Host Controller
                vendor: Linux 6.14.4-061404-generic xhci-hcd
                physical id: 0
                bus info: usb@1
                logical name: usb1
                version: 6.14
                capabilities: usb-2.00
                configuration: driver=hub slots=16 speed=480Mbit/s
              *-usb:0
                   description: Modem
                   product: USB-Serial (0001)
                   vendor: Apple Inc.
                   physical id: 6
                   bus info: usb@1:6
                   version: 0.00
                   capabilities: usb-2.00 atcommands
                   configuration: driver=cdc_acm maxpower=100mA 
speed=12Mbit/s
              *-usb:1
                   description: Mass storage device
                   product: MT1956
                   vendor: MediaTek Inc
                   physical id: a
                   bus info: usb@1:a
                   version: 0.00
                   capabilities: usb-2.00 atapi
                   configuration: driver=usb-storage maxpower=500mA 
speed=480Mbit/s
           *-usbhost:1
                product: xHCI Host Controller
                vendor: Linux 6.14.4-061404-generic xhci-hcd
                physical id: 1
                bus info: usb@2
                logical name: usb2
                version: 6.14
                capabilities: usb-3.00
                configuration: driver=hub slots=10 speed=5000Mbit/s
        *-generic:16
             description: Signal processing controller
             product: C620 Series Chipset Family Thermal Subsystem
             vendor: Intel Corporation
             physical id: 14.2
             bus info: pci@0000:00:14.2
             version: 09
             width: 64 bits
             clock: 33MHz
             capabilities: pm msi cap_list
             configuration: driver=intel_pch_thermal latency=0
             resources: iomemory:8ff0-8fef irq:18 
memory:8fffff30000-8fffff30fff
        *-communication:0
             description: Communication controller
             product: C620 Series Chipset Family MEI Controller #1
             vendor: Intel Corporation
             physical id: 16
             bus info: pci@0000:00:16.0
             version: 09
             width: 64 bits
             clock: 33MHz
             capabilities: pm msi bus_master cap_list
             configuration: driver=mei_me latency=0
             resources: iomemory:8ff0-8fef irq:225 
memory:8fffff31000-8fffff31fff
        *-communication:1
             description: Serial controller
             product: C620 Series Chipset Family KT Redirection
             vendor: Intel Corporation
             physical id: 16.3
             bus info: pci@0000:00:16.3
             version: 09
             width: 32 bits
             clock: 66MHz
             capabilities: msi pm 16550 cap_list
             configuration: driver=serial latency=0
             resources: irq:19 ioport:2048(size=8) 
memory:71987000-71987fff
        *-sata
             description: SATA controller
             product: C620 Series Chipset Family SATA Controller [AHCI 
mode]
             vendor: Intel Corporation
             physical id: 17
             bus info: pci@0000:00:17.0
             version: 09
             width: 32 bits
             clock: 66MHz
             capabilities: sata msi pm ahci_1.0 bus_master cap_list
             configuration: driver=ahci latency=0
             resources: irq:91 memory:71984000-71985fff 
memory:71989000-719890ff ioport:2040(size=8) ioport:2050(size=4) 
ioport:2020(size=32) memory:71900000-7197ffff
        *-pci:0
             description: PCI bridge
             product: C620 Series Chipset Family PCI Express Root Port 
#17
             vendor: Intel Corporation
             physical id: 1b
             bus info: pci@0000:00:1b.0
             version: f9
             width: 32 bits
             clock: 33MHz
             capabilities: pci pciexpress msi pm normal_decode 
bus_master cap_list
             configuration: driver=pcieport
             resources: irq:29 ioport:8fffec00000(size=19922944)
           *-storage
                description: NVMe device
                product: APPLE SSD AP1024N
                vendor: Apple Inc.
                physical id: 0
                bus info: pci@0000:01:00.0
                logical name: /dev/nvme0
                version: 1306
                serial: C029517002MK3F74X
                width: 64 bits
                clock: 33MHz
                capabilities: storage pm msi pciexpress bus_master 
cap_list
                configuration: driver=nvme latency=0 
nqn=nqn.2014.08.org.nvmexpress:106b106bC029517002MK3F74X APPLE SSD 
AP1024N state=live
                resources: iomemory:8ff0-8fef iomemory:8ff0-8fef 
iomemory:8ff0-8fef irq:102 memory:8ffff800000-8ffffbfffff 
memory:8ffffd80000-8ffffdfffff memory:8ffffe30000-8ffffe3ffff
              *-namespace:0
                   description: NVMe disk
                   physical id: 0
                   logical name: hwmon1
              *-namespace:1
                   description: NVMe disk
                   physical id: 2
                   logical name: /dev/ng0n1
              *-namespace:2
                   description: NVMe disk
                   physical id: 1
                   bus info: nvme@0:1
                   logical name: /dev/nvme0n1
                   size: 931GiB (1TB)
                   capabilities: partitioned partitioned:dos
                   configuration: logicalsectorsize=4096 
sectorsize=4096 
wwid=nvme.106b-433032393531373030324d4b3346373458-4150504c4520535344204150313032344e-00000001
                 *-volume:0 UNCLAIMED
                      description: EFI GPT partition
                      physical id: 1
                      bus info: nvme@0:1,1
                      capacity: 8207KiB
                      capabilities: primary nofs
                 *-volume:1
                      description: Linux filesystem partition
                      physical id: 2
                      bus info: nvme@0:1,2
                      logical name: /dev/nvme0n1p2
                      capacity: 26MiB
                      capabilities: primary bootable
                 *-volume:2 UNCLAIMED
                      description: Linux filesystem partition
                      physical id: 3
                      bus info: nvme@0:1,3
                      capacity: 14GiB
                      capabilities: primary
           *-generic:0
                description: Non-VGA unclassified device
                product: T2 Bridge Controller
                vendor: Apple Inc.
                physical id: 0.1
                bus info: pci@0000:01:00.1
                version: 01
                width: 64 bits
                clock: 33MHz
                capabilities: pm msi pciexpress bus_master cap_list
                configuration: driver=apple-bce latency=0
                resources: iomemory:8ff0-8fef iomemory:8ff0-8fef 
iomemory:8ff0-8fef irq:212 memory:8ffff400000-8ffff7fffff 
memory:8ffffd00000-8ffffd7ffff memory:8ffffe20000-8ffffe2ffff
           *-generic:1 UNCLAIMED
                description: Non-VGA unclassified device
                product: T2 Secure Enclave Processor
                vendor: Apple Inc.
                physical id: 0.2
                bus info: pci@0000:01:00.2
                version: 01
                width: 64 bits
                clock: 33MHz
                capabilities: pm msi pciexpress bus_master cap_list
                configuration: latency=0
                resources: iomemory:8ff0-8fef iomemory:8ff0-8fef 
iomemory:8ff0-8fef memory:8ffff000000-8ffff3fffff 
memory:8ffffc80000-8ffffcfffff memory:8ffffe10000-8ffffe1ffff
           *-multimedia
                description: Multimedia audio controller
                product: Apple Audio Device
                vendor: Apple Inc.
                physical id: 0.3
                bus info: pci@0000:01:00.3
                version: 01
                width: 64 bits
                clock: 33MHz
                capabilities: pm msi pciexpress bus_master cap_list
                configuration: driver=aaudio latency=0
                resources: iomemory:8ff0-8fef iomemory:8ff0-8fef 
iomemory:8ff0-8fef irq:0 memory:8fffec00000-8fffeffffff 
memory:8ffffc00000-8ffffc7ffff memory:8ffffe00000-8ffffe0ffff
        *-pci:1
             description: PCI bridge
             product: C620 Series Chipset Family PCI Express Root Port 
#1
             vendor: Intel Corporation
             physical id: 1c
             bus info: pci@0000:00:1c.0
             version: f9
             width: 32 bits
             clock: 33MHz
             capabilities: pci pciexpress msi pm normal_decode 
bus_master cap_list
             configuration: driver=pcieport
             resources: irq:30 memory:71400000-718fffff
           *-network DISABLED
                description: Wireless interface
                product: BCM4364 802.11ac Wireless Network Adapter
                vendor: Broadcom Inc. and subsidiaries
                physical id: 0
                bus info: pci@0000:02:00.0
                logical name: wlp2s0
                version: 04
                serial: f8:ff:c2:1c:76:19
                width: 64 bits
                clock: 33MHz
                capabilities: pm msi pciexpress bus_master cap_list 
ethernet physical wireless
                configuration: broadcast=yes driver=brcmfmac 
driverversion=unknown firmware=01-e7856862 latency=0 multicast=yes 
wireless=IEEE 802.11
                resources: irq:232 memory:71800000-71807fff 
memory:71400000-717fffff
        *-pci:2
             description: PCI bridge
             product: C620 Series Chipset Family PCI Express Root Port 
#5
             vendor: Intel Corporation
             physical id: 1c.4
             bus info: pci@0000:00:1c.4
             version: f9
             width: 32 bits
             clock: 33MHz
             capabilities: pci pciexpress msi pm normal_decode 
bus_master cap_list
             configuration: driver=pcieport
             resources: irq:31 ioport:3000(size=4096) 
memory:70000000-700fffff
           *-communication
                description: Serial controller
                product: Pericom Semiconductor
                vendor: Pericom Semiconductor
                physical id: 0
                bus info: pci@0000:05:00.0
                version: 00
                width: 32 bits
                clock: 33MHz
                capabilities: pm msi pciexpress 16550 bus_master 
cap_list
                configuration: driver=8250_pericom latency=0
                resources: irq:16 ioport:3000(size=64) 
memory:70000000-70000fff
        *-pci:3
             description: PCI bridge
             product: C620 Series Chipset Family PCI Express Root Port 
#9
             vendor: Intel Corporation
             physical id: 1d
             bus info: pci@0000:00:1d.0
             version: f9
             width: 32 bits
             clock: 33MHz
             capabilities: pci pciexpress msi pm normal_decode 
bus_master cap_list
             configuration: driver=pcieport
             resources: irq:32 memory:70c00000-710fffff
           *-network
                description: Ethernet interface
                product: AQtion AQC107 NBase-T/IEEE 802.3an Ethernet 
Controller [Atlantic 10G]
                vendor: Aquantia Corp.
                physical id: 0
                bus info: pci@0000:03:00.0
                logical name: enp3s0
                version: 02
                serial: 9a:bd:00:35:89:bb
                capacity: 10Gbit/s
                width: 64 bits
                clock: 33MHz
                capabilities: pciexpress pm msix msi bus_master 
cap_list ethernet physical tp 100bt-fd 1000bt-fd 10000bt-fd 
autonegotiation
                configuration: autonegotiation=on broadcast=yes 
driver=atlantic driverversion=6.14.4-061404-generic duplex=full 
firmware=2.12.24 ip=192.168.0.120 latency=0 link=yes multicast=yes 
port=twisted pair
                resources: irq:16 memory:71000000-7100ffff 
memory:71010000-71010fff memory:70c00000-70ffffff
        *-pci:4
             description: PCI bridge
             product: C620 Series Chipset Family PCI Express Root Port 
#13
             vendor: Intel Corporation
             physical id: 1d.4
             bus info: pci@0000:00:1d.4
             version: f9
             width: 32 bits
             clock: 33MHz
             capabilities: pci pciexpress msi pm normal_decode 
bus_master cap_list
             configuration: driver=pcieport
             resources: irq:33 memory:70400000-708fffff
           *-network
                description: Ethernet interface
                product: AQtion AQC107 NBase-T/IEEE 802.3an Ethernet 
Controller [Atlantic 10G]
                vendor: Aquantia Corp.
                physical id: 0
                bus info: pci@0000:04:00.0
                logical name: enp4s0
                version: 02
                serial: cc:2d:b7:06:5b:6b
                capacity: 10Gbit/s
                width: 64 bits
                clock: 33MHz
                capabilities: pciexpress pm msix msi bus_master 
cap_list ethernet physical tp 100bt-fd 1000bt-fd 10000bt-fd 
autonegotiation
                configuration: autonegotiation=on broadcast=yes 
driver=atlantic driverversion=6.14.4-061404-generic firmware=2.12.24 
latency=0 link=no multicast=yes port=twisted pair
                resources: irq:16 memory:70800000-7080ffff 
memory:70810000-70810fff memory:70400000-707fffff
        *-isa
             description: ISA bridge
             product: C621 Series Chipset LPC/eSPI Controller
             vendor: Intel Corporation
             physical id: 1f
             bus info: pci@0000:00:1f.0
             version: 09
             width: 32 bits
             clock: 33MHz
             capabilities: isa
             configuration: latency=0
           *-pnp00:00
                product: PnP device PNP0c02
                physical id: 0
                capabilities: pnp
                configuration: driver=system
           *-pnp00:01
                product: PnP device PNP0c02
                physical id: 1
                capabilities: pnp
                configuration: driver=system
        *-memory UNCLAIMED
             description: Memory controller
             product: C620 Series Chipset Family Power Management 
Controller
             vendor: Intel Corporation
             physical id: 1f.2
             bus info: pci@0000:00:1f.2
             version: 09
             width: 32 bits
             clock: 33MHz (30.3ns)
             configuration: latency=0
             resources: memory:71980000-71983fff
        *-serial:0
             description: SMBus
             product: C620 Series Chipset Family SMBus
             vendor: Intel Corporation
             physical id: 1f.4
             bus info: pci@0000:00:1f.4
             version: 09
             width: 64 bits
             clock: 33MHz
             configuration: driver=i801_smbus latency=0
             resources: iomemory:8ff0-8fef irq:16 
memory:8fffff32000-8fffff320ff ioport:2000(size=32)
        *-serial:1
             description: Serial bus controller
             product: C620 Series Chipset Family SPI Controller
             vendor: Intel Corporation
             physical id: 1f.5
             bus info: pci@0000:00:1f.5
             version: 09
             width: 32 bits
             clock: 33MHz
             configuration: driver=intel-spi latency=0
             resources: irq:0 memory:fe010000-fe010fff
     *-pci:1
          description: PCI bridge
          product: Sky Lake-E PCI Express Root Port A
          vendor: Intel Corporation
          physical id: 101
          bus info: pci@0000:06:00.0
          version: 07
          width: 32 bits
          clock: 33MHz
          capabilities: pci msi pciexpress pm normal_decode bus_master 
cap_list
          configuration: driver=pcieport
          resources: irq:34 ioport:5000(size=4096) 
memory:74400000-747fffff ioport:90000000000(size=25769803776)
        *-pci
             description: PCI bridge
             product: Navi 10 XL Upstream Port of PCI Express Switch
             vendor: Advanced Micro Devices, Inc. [AMD/ATI]
             physical id: 0
             bus info: pci@0000:07:00.0
             version: c3
             width: 32 bits
             clock: 33MHz
             capabilities: pci pm pciexpress msi normal_decode 
bus_master cap_list
             configuration: driver=pcieport
             resources: irq:16 memory:74700000-74703fff 
ioport:5000(size=4096) memory:74400000-746fffff 
ioport:90000000000(size=25769803776)
           *-pci
                description: PCI bridge
                product: Navi 10 XL Downstream Port of PCI Express 
Switch
                vendor: Advanced Micro Devices, Inc. [AMD/ATI]
                physical id: 0
                bus info: pci@0000:08:00.0
                version: 00
                width: 32 bits
                clock: 33MHz
                capabilities: pci pm pciexpress msi normal_decode 
bus_master cap_list
                configuration: driver=pcieport
                resources: irq:35 ioport:5000(size=4096) 
memory:74400000-746fffff ioport:90000000000(size=25769803776)
              *-display
                   description: VGA compatible controller
                   product: Navi 21 [Radeon RX 6800/6800 XT / 6900 XT]
                   vendor: Advanced Micro Devices, Inc. [AMD/ATI]
                   physical id: 0
                   bus info: pci@0000:09:00.0
                   logical name: /dev/fb0
                   version: c3
                   width: 64 bits
                   clock: 33MHz
                   capabilities: pm pciexpress msi vga_controller 
bus_master cap_list rom fb
                   configuration: depth=32 driver=amdgpu latency=0 
resolution=3840,2160
                   resources: iomemory:9000-8fff iomemory:9040-903f 
irq:233 memory:90000000000-903ffffffff memory:90400000000-904001fffff 
ioport:5000(size=256) memory:74500000-745fffff memory:74600000-7461ffff
              *-multimedia
                   description: Audio device
                   product: Navi 21/23 HDMI/DP Audio Controller
                   vendor: Advanced Micro Devices, Inc. [AMD/ATI]
                   physical id: 0.1
                   bus info: pci@0000:09:00.1
                   logical name: card1
                   logical name: /dev/snd/controlC1
                   logical name: /dev/snd/hwC1D0
                   logical name: /dev/snd/pcmC1D10p
                   logical name: /dev/snd/pcmC1D11p
                   logical name: /dev/snd/pcmC1D3p
                   logical name: /dev/snd/pcmC1D7p
                   logical name: /dev/snd/pcmC1D8p
                   logical name: /dev/snd/pcmC1D9p
                   version: 00
                   width: 32 bits
                   clock: 33MHz
                   capabilities: pm pciexpress msi bus_master cap_list
                   configuration: driver=snd_hda_intel latency=0
                   resources: irq:230 memory:74624000-74627fff
                 *-input:0
                      product: HDA ATI HDMI HDMI/DP,pcm=3
                      physical id: 0
                      logical name: input16
                      logical name: /dev/input/event13
                 *-input:1
                      product: HDA ATI HDMI HDMI/DP,pcm=7
                      physical id: 1
                      logical name: input17
                      logical name: /dev/input/event14
                 *-input:2
                      product: HDA ATI HDMI HDMI/DP,pcm=8
                      physical id: 2
                      logical name: input18
                      logical name: /dev/input/event16
                 *-input:3
                      product: HDA ATI HDMI HDMI/DP,pcm=9
                      physical id: 3
                      logical name: input19
                      logical name: /dev/input/event17
                 *-input:4
                      product: HDA ATI HDMI HDMI/DP,pcm=10
                      physical id: 4
                      logical name: input20
                      logical name: /dev/input/event18
                 *-input:5
                      product: HDA ATI HDMI HDMI/DP,pcm=11
                      physical id: 5
                      logical name: input21
                      logical name: /dev/input/event20
              *-usb
                   description: USB controller
                   product: Advanced Micro Devices, Inc. [AMD/ATI]
                   vendor: Advanced Micro Devices, Inc. [AMD/ATI]
                   physical id: 0.2
                   bus info: pci@0000:09:00.2
                   version: 00
                   width: 64 bits
                   clock: 33MHz
                   capabilities: pm pciexpress msi msix xhci cap_list
                   configuration: driver=xhci_hcd latency=0
                   resources: irq:18 memory:74400000-744fffff
                 *-usbhost:0
                      product: xHCI Host Controller
                      vendor: Linux 6.14.4-061404-generic xhci-hcd
                      physical id: 0
                      bus info: usb@3
                      logical name: usb3
                      version: 6.14
                      capabilities: usb-2.00
                      configuration: driver=hub slots=1 speed=480Mbit/s
                 *-usbhost:1
                      product: xHCI Host Controller
                      vendor: Linux 6.14.4-061404-generic xhci-hcd
                      physical id: 1
                      bus info: usb@4
                      logical name: usb4
                      version: 6.14
                      capabilities: usb-3.10
                      configuration: driver=hub slots=1 
speed=10000Mbit/s
              *-serial
                   description: Serial bus controller
                   product: Navi 21 USB
                   vendor: Advanced Micro Devices, Inc. [AMD/ATI]
                   physical id: 0.3
                   bus info: pci@0000:09:00.3
                   version: 00
                   width: 64 bits
                   clock: 33MHz
                   capabilities: pm pciexpress msi bus_master cap_list
                   configuration: driver=i2c-designware-pci latency=0
                   resources: irq:229 memory:74620000-74623fff
     *-generic:0 UNCLAIMED
          description: System peripheral
          product: Sky Lake-E VT-d
          vendor: Intel Corporation
          physical id: 2
          bus info: pci@0000:06:05.0
          version: 07
          width: 32 bits
          clock: 33MHz
          capabilities: pciexpress cap_list
          configuration: latency=0
     *-generic:1 UNCLAIMED
          description: System peripheral
          product: Sky Lake-E RAS Configuration Registers
          vendor: Intel Corporation
          physical id: 3
          bus info: pci@0000:06:05.2
          version: 07
          width: 32 bits
          clock: 33MHz
          capabilities: pciexpress cap_list
          configuration: latency=0
     *-generic:2 UNCLAIMED
          description: PIC
          product: Sky Lake-E IOxAPIC Configuration Registers
          vendor: Intel Corporation
          physical id: 4
          bus info: pci@0000:06:05.4
          version: 07
          width: 32 bits
          clock: 33MHz
          capabilities: pciexpress pm io_x_-apic bus_master cap_list
          configuration: latency=0
          resources: memory:74800000-74800fff
     *-generic:3 UNCLAIMED
          description: System peripheral
          product: Sky Lake-E CHA Registers
          vendor: Intel Corporation
          physical id: 5
          bus info: pci@0000:06:08.0
          version: 07
          width: 32 bits
          clock: 33MHz
          configuration: latency=0
     *-generic:4 UNCLAIMED
          description: System peripheral
          product: Sky Lake-E CHA Registers
          vendor: Intel Corporation
          physical id: 8.1
          bus info: pci@0000:06:08.1
          version: 07
          width: 32 bits
          clock: 33MHz
          configuration: latency=0
     *-generic:5 UNCLAIMED
          description: System peripheral
          product: Sky Lake-E CHA Registers
          vendor: Intel Corporation
          physical id: 8.2
          bus info: pci@0000:06:08.2
          version: 07
          width: 32 bits
          clock: 33MHz
          configuration: latency=0
     *-generic:6 UNCLAIMED
          description: System peripheral
          product: Sky Lake-E CHA Registers
          vendor: Intel Corporation
          physical id: 8.3
          bus info: pci@0000:06:08.3
          version: 07
          width: 32 bits
          clock: 33MHz
          configuration: latency=0
     *-generic:7 UNCLAIMED
          description: System peripheral
          product: Sky Lake-E CHA Registers
          vendor: Intel Corporation
          physical id: 8.4
          bus info: pci@0000:06:08.4
          version: 07
          width: 32 bits
          clock: 33MHz
          configuration: latency=0
     *-generic:8 UNCLAIMED
          description: System peripheral
          product: Sky Lake-E CHA Registers
          vendor: Intel Corporation
          physical id: 8.5
          bus info: pci@0000:06:08.5
          version: 07
          width: 32 bits
          clock: 33MHz
          configuration: latency=0
     *-generic:9 UNCLAIMED
          description: System peripheral
          product: Sky Lake-E CHA Registers
          vendor: Intel Corporation
          physical id: 8.6
          bus info: pci@0000:06:08.6
          version: 07
          width: 32 bits
          clock: 33MHz
          configuration: latency=0
     *-generic:10 UNCLAIMED
          description: System peripheral
          product: Sky Lake-E CHA Registers
          vendor: Intel Corporation
          physical id: 8.7
          bus info: pci@0000:06:08.7
          version: 07
          width: 32 bits
          clock: 33MHz
          configuration: latency=0
     *-generic:11 UNCLAIMED
          description: System peripheral
          product: Sky Lake-E CHA Registers
          vendor: Intel Corporation
          physical id: 6
          bus info: pci@0000:06:09.0
          version: 07
          width: 32 bits
          clock: 33MHz
          configuration: latency=0
     *-generic:12 UNCLAIMED
          description: System peripheral
          product: Sky Lake-E CHA Registers
          vendor: Intel Corporation
          physical id: 9.1
          bus info: pci@0000:06:09.1
          version: 07
          width: 32 bits
          clock: 33MHz
          configuration: latency=0
     *-generic:13 UNCLAIMED
          description: System peripheral
          product: Sky Lake-E CHA Registers
          vendor: Intel Corporation
          physical id: 9.2
          bus info: pci@0000:06:09.2
          version: 07
          width: 32 bits
          clock: 33MHz
          configuration: latency=0
     *-generic:14 UNCLAIMED
          description: System peripheral
          product: Sky Lake-E CHA Registers
          vendor: Intel Corporation
          physical id: 9.3
          bus info: pci@0000:06:09.3
          version: 07
          width: 32 bits
          clock: 33MHz
          configuration: latency=0
     *-generic:15 UNCLAIMED
          description: System peripheral
          product: Sky Lake-E CHA Registers
          vendor: Intel Corporation
          physical id: 9.4
          bus info: pci@0000:06:09.4
          version: 07
          width: 32 bits
          clock: 33MHz
          configuration: latency=0
     *-generic:16 UNCLAIMED
          description: System peripheral
          product: Sky Lake-E CHA Registers
          vendor: Intel Corporation
          physical id: 9.5
          bus info: pci@0000:06:09.5
          version: 07
          width: 32 bits
          clock: 33MHz
          configuration: latency=0
     *-generic:17 UNCLAIMED
          description: System peripheral
          product: Sky Lake-E CHA Registers
          vendor: Intel Corporation
          physical id: 9.6
          bus info: pci@0000:06:09.6
          version: 07
          width: 32 bits
          clock: 33MHz
          configuration: latency=0
     *-generic:18 UNCLAIMED
          description: System peripheral
          product: Sky Lake-E CHA Registers
          vendor: Intel Corporation
          physical id: 9.7
          bus info: pci@0000:06:09.7
          version: 07
          width: 32 bits
          clock: 33MHz
          configuration: latency=0
     *-generic:19 UNCLAIMED
          description: System peripheral
          product: Sky Lake-E CHA Registers
          vendor: Intel Corporation
          physical id: 7
          bus info: pci@0000:06:0a.0
          version: 07
          width: 32 bits
          clock: 33MHz
          configuration: latency=0
     *-generic:20 UNCLAIMED
          description: System peripheral
          product: Sky Lake-E CHA Registers
          vendor: Intel Corporation
          physical id: 8
          bus info: pci@0000:06:0a.1
          version: 07
          width: 32 bits
          clock: 33MHz
          configuration: latency=0
     *-generic:21 UNCLAIMED
          description: System peripheral
          product: Sky Lake-E CHA Registers
          vendor: Intel Corporation
          physical id: 9
          bus info: pci@0000:06:0a.2
          version: 07
          width: 32 bits
          clock: 33MHz
          configuration: latency=0
     *-generic:22 UNCLAIMED
          description: System peripheral
          product: Sky Lake-E CHA Registers
          vendor: Intel Corporation
          physical id: a
          bus info: pci@0000:06:0a.3
          version: 07
          width: 32 bits
          clock: 33MHz
          configuration: latency=0
     *-generic:23 UNCLAIMED
          description: System peripheral
          product: Sky Lake-E CHA Registers
          vendor: Intel Corporation
          physical id: b
          bus info: pci@0000:06:0a.4
          version: 07
          width: 32 bits
          clock: 33MHz
          configuration: latency=0
     *-generic:24 UNCLAIMED
          description: System peripheral
          product: Sky Lake-E CHA Registers
          vendor: Intel Corporation
          physical id: e
          bus info: pci@0000:06:0a.5
          version: 07
          width: 32 bits
          clock: 33MHz
          configuration: latency=0
     *-generic:25 UNCLAIMED
          description: System peripheral
          product: Sky Lake-E CHA Registers
          vendor: Intel Corporation
          physical id: f
          bus info: pci@0000:06:0a.6
          version: 07
          width: 32 bits
          clock: 33MHz
          configuration: latency=0
     *-generic:26 UNCLAIMED
          description: System peripheral
          product: Sky Lake-E CHA Registers
          vendor: Intel Corporation
          physical id: 10
          bus info: pci@0000:06:0a.7
          version: 07
          width: 32 bits
          clock: 33MHz
          configuration: latency=0
     *-generic:27 UNCLAIMED
          description: System peripheral
          product: Sky Lake-E CHA Registers
          vendor: Intel Corporation
          physical id: 13
          bus info: pci@0000:06:0b.0
          version: 07
          width: 32 bits
          clock: 33MHz
          configuration: latency=0
     *-generic:28 UNCLAIMED
          description: System peripheral
          product: Sky Lake-E CHA Registers
          vendor: Intel Corporation
          physical id: 14
          bus info: pci@0000:06:0b.1
          version: 07
          width: 32 bits
          clock: 33MHz
          configuration: latency=0
     *-generic:29 UNCLAIMED
          description: System peripheral
          product: Sky Lake-E CHA Registers
          vendor: Intel Corporation
          physical id: 18
          bus info: pci@0000:06:0b.2
          version: 07
          width: 32 bits
          clock: 33MHz
          configuration: latency=0
     *-generic:30 UNCLAIMED
          description: System peripheral
          product: Sky Lake-E CHA Registers
          vendor: Intel Corporation
          physical id: 19
          bus info: pci@0000:06:0b.3
          version: 07
          width: 32 bits
          clock: 33MHz
          configuration: latency=0
     *-generic:31 UNCLAIMED
          description: System peripheral
          product: Sky Lake-E CHA Registers
          vendor: Intel Corporation
          physical id: 1a
          bus info: pci@0000:06:0e.0
          version: 07
          width: 32 bits
          clock: 33MHz
          configuration: latency=0
     *-generic:32 UNCLAIMED
          description: System peripheral
          product: Sky Lake-E CHA Registers
          vendor: Intel Corporation
          physical id: 1b
          bus info: pci@0000:06:0e.1
          version: 07
          width: 32 bits
          clock: 33MHz
          configuration: latency=0
     *-generic:33 UNCLAIMED
          description: System peripheral
          product: Sky Lake-E CHA Registers
          vendor: Intel Corporation
          physical id: e.2
          bus info: pci@0000:06:0e.2
          version: 07
          width: 32 bits
          clock: 33MHz
          configuration: latency=0
     *-generic:34 UNCLAIMED
          description: System peripheral
          product: Sky Lake-E CHA Registers
          vendor: Intel Corporation
          physical id: e.3
          bus info: pci@0000:06:0e.3
          version: 07
          width: 32 bits
          clock: 33MHz
          configuration: latency=0
     *-generic:35 UNCLAIMED
          description: System peripheral
          product: Sky Lake-E CHA Registers
          vendor: Intel Corporation
          physical id: e.4
          bus info: pci@0000:06:0e.4
          version: 07
          width: 32 bits
          clock: 33MHz
          configuration: latency=0
     *-generic:36 UNCLAIMED
          description: System peripheral
          product: Sky Lake-E CHA Registers
          vendor: Intel Corporation
          physical id: e.5
          bus info: pci@0000:06:0e.5
          version: 07
          width: 32 bits
          clock: 33MHz
          configuration: latency=0
     *-generic:37 UNCLAIMED
          description: System peripheral
          product: Sky Lake-E CHA Registers
          vendor: Intel Corporation
          physical id: e.6
          bus info: pci@0000:06:0e.6
          version: 07
          width: 32 bits
          clock: 33MHz
          configuration: latency=0
     *-generic:38 UNCLAIMED
          description: System peripheral
          product: Sky Lake-E CHA Registers
          vendor: Intel Corporation
          physical id: e.7
          bus info: pci@0000:06:0e.7
          version: 07
          width: 32 bits
          clock: 33MHz
          configuration: latency=0
     *-generic:39 UNCLAIMED
          description: System peripheral
          product: Sky Lake-E CHA Registers
          vendor: Intel Corporation
          physical id: 1c
          bus info: pci@0000:06:0f.0
          version: 07
          width: 32 bits
          clock: 33MHz
          configuration: latency=0
     *-generic:40 UNCLAIMED
          description: System peripheral
          product: Sky Lake-E CHA Registers
          vendor: Intel Corporation
          physical id: 1f
          bus info: pci@0000:06:0f.1
          version: 07
          width: 32 bits
          clock: 33MHz
          configuration: latency=0
     *-generic:41 UNCLAIMED
          description: System peripheral
          product: Sky Lake-E CHA Registers
          vendor: Intel Corporation
          physical id: f.2
          bus info: pci@0000:06:0f.2
          version: 07
          width: 32 bits
          clock: 33MHz
          configuration: latency=0
     *-generic:42 UNCLAIMED
          description: System peripheral
          product: Sky Lake-E CHA Registers
          vendor: Intel Corporation
          physical id: f.3
          bus info: pci@0000:06:0f.3
          version: 07
          width: 32 bits
          clock: 33MHz
          configuration: latency=0
     *-generic:43 UNCLAIMED
          description: System peripheral
          product: Sky Lake-E CHA Registers
          vendor: Intel Corporation
          physical id: f.4
          bus info: pci@0000:06:0f.4
          version: 07
          width: 32 bits
          clock: 33MHz
          configuration: latency=0
     *-generic:44 UNCLAIMED
          description: System peripheral
          product: Sky Lake-E CHA Registers
          vendor: Intel Corporation
          physical id: f.5
          bus info: pci@0000:06:0f.5
          version: 07
          width: 32 bits
          clock: 33MHz
          configuration: latency=0
     *-generic:45 UNCLAIMED
          description: System peripheral
          product: Sky Lake-E CHA Registers
          vendor: Intel Corporation
          physical id: f.6
          bus info: pci@0000:06:0f.6
          version: 07
          width: 32 bits
          clock: 33MHz
          configuration: latency=0
     *-generic:46 UNCLAIMED
          description: System peripheral
          product: Sky Lake-E CHA Registers
          vendor: Intel Corporation
          physical id: f.7
          bus info: pci@0000:06:0f.7
          version: 07
          width: 32 bits
          clock: 33MHz
          configuration: latency=0
     *-generic:47 UNCLAIMED
          description: System peripheral
          product: Sky Lake-E CHA Registers
          vendor: Intel Corporation
          physical id: 20
          bus info: pci@0000:06:10.0
          version: 07
          width: 32 bits
          clock: 33MHz
          configuration: latency=0
     *-generic:48 UNCLAIMED
          description: System peripheral
          product: Sky Lake-E CHA Registers
          vendor: Intel Corporation
          physical id: 21
          bus info: pci@0000:06:10.1
          version: 07
          width: 32 bits
          clock: 33MHz
          configuration: latency=0
     *-generic:49 UNCLAIMED
          description: System peripheral
          product: Sky Lake-E CHA Registers
          vendor: Intel Corporation
          physical id: 10.2
          bus info: pci@0000:06:10.2
          version: 07
          width: 32 bits
          clock: 33MHz
          configuration: latency=0
     *-generic:50 UNCLAIMED
          description: System peripheral
          product: Sky Lake-E CHA Registers
          vendor: Intel Corporation
          physical id: 10.3
          bus info: pci@0000:06:10.3
          version: 07
          width: 32 bits
          clock: 33MHz
          configuration: latency=0
     *-generic:51 UNCLAIMED
          description: System peripheral
          product: Sky Lake-E CHA Registers
          vendor: Intel Corporation
          physical id: 10.4
          bus info: pci@0000:06:10.4
          version: 07
          width: 32 bits
          clock: 33MHz
          configuration: latency=0
     *-generic:52 UNCLAIMED
          description: System peripheral
          product: Sky Lake-E CHA Registers
          vendor: Intel Corporation
          physical id: 10.5
          bus info: pci@0000:06:10.5
          version: 07
          width: 32 bits
          clock: 33MHz
          configuration: latency=0
     *-generic:53 UNCLAIMED
          description: System peripheral
          product: Sky Lake-E CHA Registers
          vendor: Intel Corporation
          physical id: 10.6
          bus info: pci@0000:06:10.6
          version: 07
          width: 32 bits
          clock: 33MHz
          configuration: latency=0
     *-generic:54 UNCLAIMED
          description: System peripheral
          product: Sky Lake-E CHA Registers
          vendor: Intel Corporation
          physical id: 10.7
          bus info: pci@0000:06:10.7
          version: 07
          width: 32 bits
          clock: 33MHz
          configuration: latency=0
     *-generic:55 UNCLAIMED
          description: System peripheral
          product: Sky Lake-E CHA Registers
          vendor: Intel Corporation
          physical id: 11
          bus info: pci@0000:06:11.0
          version: 07
          width: 32 bits
          clock: 33MHz
          configuration: latency=0
     *-generic:56 UNCLAIMED
          description: System peripheral
          product: Sky Lake-E CHA Registers
          vendor: Intel Corporation
          physical id: 11.1
          bus info: pci@0000:06:11.1
          version: 07
          width: 32 bits
          clock: 33MHz
          configuration: latency=0
     *-generic:57 UNCLAIMED
          description: System peripheral
          product: Sky Lake-E CHA Registers
          vendor: Intel Corporation
          physical id: 11.2
          bus info: pci@0000:06:11.2
          version: 07
          width: 32 bits
          clock: 33MHz
          configuration: latency=0
     *-generic:58 UNCLAIMED
          description: System peripheral
          product: Sky Lake-E CHA Registers
          vendor: Intel Corporation
          physical id: 11.3
          bus info: pci@0000:06:11.3
          version: 07
          width: 32 bits
          clock: 33MHz
          configuration: latency=0
     *-generic:59 UNCLAIMED
          description: System peripheral
          product: Sky Lake-E CHA Registers
          vendor: Intel Corporation
          physical id: 1d
          bus info: pci@0000:06:1d.0
          version: 07
          width: 32 bits
          clock: 33MHz
          configuration: latency=0
     *-generic:60 UNCLAIMED
          description: System peripheral
          product: Sky Lake-E CHA Registers
          vendor: Intel Corporation
          physical id: 1d.1
          bus info: pci@0000:06:1d.1
          version: 07
          width: 32 bits
          clock: 33MHz
          configuration: latency=0
     *-generic:61 UNCLAIMED
          description: System peripheral
          product: Sky Lake-E CHA Registers
          vendor: Intel Corporation
          physical id: 1d.2
          bus info: pci@0000:06:1d.2
          version: 07
          width: 32 bits
          clock: 33MHz
          configuration: latency=0
     *-generic:62 UNCLAIMED
          description: System peripheral
          product: Sky Lake-E CHA Registers
          vendor: Intel Corporation
          physical id: 1d.3
          bus info: pci@0000:06:1d.3
          version: 07
          width: 32 bits
          clock: 33MHz
          configuration: latency=0
     *-generic:63 UNCLAIMED
          description: System peripheral
          product: Sky Lake-E PCU Registers
          vendor: Intel Corporation
          physical id: 1e
          bus info: pci@0000:06:1e.0
          version: 07
          width: 32 bits
          clock: 33MHz
          configuration: latency=0
     *-generic:64 UNCLAIMED
          description: System peripheral
          product: Sky Lake-E PCU Registers
          vendor: Intel Corporation
          physical id: 1e.1
          bus info: pci@0000:06:1e.1
          version: 07
          width: 32 bits
          clock: 33MHz
          configuration: latency=0
     *-generic:65 UNCLAIMED
          description: System peripheral
          product: Sky Lake-E PCU Registers
          vendor: Intel Corporation
          physical id: 1e.2
          bus info: pci@0000:06:1e.2
          version: 07
          width: 32 bits
          clock: 33MHz
          configuration: latency=0
     *-generic:66 UNCLAIMED
          description: System peripheral
          product: Sky Lake-E PCU Registers
          vendor: Intel Corporation
          physical id: 1e.3
          bus info: pci@0000:06:1e.3
          version: 07
          width: 32 bits
          clock: 33MHz
          configuration: latency=0
     *-generic:67 UNCLAIMED
          description: System peripheral
          product: Sky Lake-E PCU Registers
          vendor: Intel Corporation
          physical id: 1e.4
          bus info: pci@0000:06:1e.4
          version: 07
          width: 32 bits
          clock: 33MHz
          configuration: latency=0
     *-generic:68 UNCLAIMED
          description: System peripheral
          product: Sky Lake-E PCU Registers
          vendor: Intel Corporation
          physical id: 1e.5
          bus info: pci@0000:06:1e.5
          version: 07
          width: 32 bits
          clock: 33MHz
          configuration: latency=0
     *-generic:69 UNCLAIMED
          description: System peripheral
          product: Sky Lake-E PCU Registers
          vendor: Intel Corporation
          physical id: 1e.6
          bus info: pci@0000:06:1e.6
          version: 07
          width: 32 bits
          clock: 33MHz
          configuration: latency=0
     *-pci:2
          description: PCI bridge
          product: Sky Lake-E PCI Express Root Port A
          vendor: Intel Corporation
          physical id: 102
          bus info: pci@0000:0a:00.0
          version: 07
          width: 32 bits
          clock: 33MHz
          capabilities: pci msi pciexpress pm normal_decode bus_master 
cap_list
          configuration: driver=pcieport
          resources: irq:36 memory:74c00000-753fffff
        *-pci
             description: PCI bridge
             product: PLX Technology, Inc.
             vendor: PLX Technology, Inc.
             physical id: 0
             bus info: pci@0000:0b:00.0
             version: ab
             width: 32 bits
             clock: 33MHz
             capabilities: pci pm msi pciexpress normal_decode 
bus_master cap_list
             configuration: driver=pcieport
             resources: irq:16 memory:75300000-7533ffff 
memory:74c00000-752fffff
           *-pci:0
                description: PCI bridge
                product: PLX Technology, Inc.
                vendor: PLX Technology, Inc.
                physical id: 8
                bus info: pci@0000:0c:08.0
                version: ab
                width: 64 bits
                clock: 33MHz
                capabilities: pci pm msi pciexpress normal_decode 
bus_master cap_list
                configuration: driver=pcieport
                resources: iomemory:1f10-1f0f irq:37
           *-pci:1
                description: PCI bridge
                product: PLX Technology, Inc.
                vendor: PLX Technology, Inc.
                physical id: c
                bus info: pci@0000:0c:0c.0
                version: ab
                width: 64 bits
                clock: 33MHz
                capabilities: pci pm msi pciexpress normal_decode 
bus_master cap_list
                configuration: driver=pcieport
                resources: iomemory:1f10-1f0f irq:38
           *-pci:2
                description: PCI bridge
                product: PLX Technology, Inc.
                vendor: PLX Technology, Inc.
                physical id: d
                bus info: pci@0000:0c:0d.0
                version: ab
                width: 64 bits
                clock: 33MHz
                capabilities: pci pm msi pciexpress normal_decode 
bus_master cap_list
                configuration: driver=pcieport
                resources: iomemory:1f10-1f0f irq:39 
memory:75200000-752fffff
              *-nvme
                   description: NVMe device
                   product: WD_BLACK SN850X 2000GB
                   vendor: Sandisk Corp
                   physical id: 0
                   bus info: pci@0000:0f:00.0
                   logical name: /dev/nvme1
                   version: 620361WD
                   serial: 23523B803817
                   width: 64 bits
                   clock: 33MHz
                   capabilities: nvme pm msi msix pciexpress 
nvm_express bus_master cap_list
                   configuration: driver=nvme latency=0 
nqn=nqn.2018-01.com.wdc:nguid:E8238FA6BF53-0001-001B448B4C3ACBFA 
state=live
                   resources: irq:17 memory:75200000-75203fff
                 *-namespace:0
                      description: NVMe disk
                      physical id: 0
                      logical name: hwmon2
                 *-namespace:1
                      description: NVMe disk
                      physical id: 2
                      logical name: /dev/ng1n1
                 *-namespace:2
                      description: NVMe disk
                      physical id: 1
                      bus info: nvme@1:1
                      logical name: /dev/nvme1n1
                      size: 1863GiB (2TB)
                      capabilities: gpt-1.00 partitioned partitioned:gpt
                      configuration: 
guid=f51ac628-9130-4705-b62f-9bfc5b71278f logicalsectorsize=512 
sectorsize=512 wwid=eui.e8238fa6bf530001001b448b4c3acbfa
                    *-volume:0
                         description: Windows FAT volume
                         vendor: mkfs.fat
                         physical id: 1
                         bus info: nvme@1:1,1
                         logical name: /dev/nvme1n1p1
                         logical name: /boot/efi
                         version: FAT32
                         serial: 2fc2-e95b
                         size: 1073MiB
                         capacity: 1074MiB
                         capabilities: boot fat initialized
                         configuration: FATs=2 filesystem=fat 
mount.fstype=vfat 
mount.options=rw,relatime,fmask=0022,dmask=0022,codepage=437,iocharset=iso8859-1,shortname=mixed,errors=remount-ro 
state=mounted
                    *-volume:1
                         description: EXT4 volume
                         vendor: Linux
                         physical id: 2
                         bus info: nvme@1:1,2
                         logical name: /dev/nvme1n1p2
                         logical name: /boot
                         version: 1.0
                         serial: fdec5262-f220-478c-93c7-7e8d57ffa103
                         size: 2GiB
                         capabilities: journaled extended_attributes 
large_files huge_files dir_nlink recover 64bit extents ext4 ext2 
initialized
                         configuration: created=2024-09-09 12:56:44 
filesystem=ext4 lastmountpoint=/boot modified=2025-05-20 17:48:21 
mount.fstype=ext4 mount.options=rw,relatime mounted=2025-05-20 17:48:21 
state=mounted
                    *-volume:2
                         description: EFI partition
                         physical id: 3
                         bus info: nvme@1:1,3
                         logical name: /dev/nvme1n1p3
                         serial: 870f6c50-1861-492f-8b1c-bba2d39dfcb1
                         size: 1859GiB
                         capacity: 1859GiB
                         width: 1613767752 bits
                         capabilities: encrypted luks initialized
                         configuration: bits=5908735048 filesystem=luks 
hash=sha256 version=2
           *-pci:3
                description: PCI bridge
                product: PLX Technology, Inc.
                vendor: PLX Technology, Inc.
                physical id: 10
                bus info: pci@0000:0c:10.0
                version: ab
                width: 64 bits
                clock: 33MHz
                capabilities: pci pm msi pciexpress normal_decode 
bus_master cap_list
                configuration: driver=pcieport
                resources: iomemory:1f10-1f0f irq:40 
memory:75100000-751fffff
              *-usb
                   description: USB controller
                   product: ASM2142/ASM3142 USB 3.1 Host Controller
                   vendor: ASMedia Technology Inc.
                   physical id: 0
                   bus info: pci@0000:10:00.0
                   version: 00
                   width: 64 bits
                   clock: 33MHz
                   capabilities: msi msix pm pciexpress xhci bus_master 
cap_list
                   configuration: driver=xhci_hcd latency=0
                   resources: irq:16 memory:75100000-75107fff
                 *-usbhost:0
                      product: xHCI Host Controller
                      vendor: Linux 6.14.4-061404-generic xhci-hcd
                      physical id: 0
                      bus info: usb@5
                      logical name: usb5
                      version: 6.14
                      capabilities: usb-2.00
                      configuration: driver=hub slots=2 speed=480Mbit/s
                    *-usb:0
                         description: USB hub
                         product: USB2.0 Hub
                         vendor: VIA Labs, Inc.
                         physical id: 1
                         bus info: usb@5:1
                         version: 7.04
                         serial: 000000001
                         capabilities: usb-2.10
                         configuration: driver=hub slots=4 
speed=480Mbit/s
                       *-usb:0
                            description: Bluetooth wireless interface
                            product: CSR8510 A10
                            vendor: Cambridge Silicon Radio, Ltd
                            physical id: 3
                            bus info: usb@5:1.3
                            version: 88.91
                            capabilities: bluetooth usb-2.00
                            configuration: driver=btusb maxpower=100mA 
speed=12Mbit/s
                       *-usb:1
                            description: USB hub
                            product: USB2.0 Hub
                            vendor: VIA Labs, Inc.
                            physical id: 4
                            bus info: usb@5:1.4
                            version: 7.04
                            serial: 000000001
                            capabilities: usb-2.10
                            configuration: driver=hub slots=4 
speed=480Mbit/s
                          *-usb
                               description: Mass storage device
                               product: Bridge-C
                               vendor: Leef
                               physical id: 3
                               bus info: usb@5:1.4.3
                               logical name: scsi14
                               version: 1.10
                               serial: 070B78FF14B55304
                               capabilities: usb-2.10 scsi emulated 
scsi-host
                               configuration: driver=usb-storage 
maxpower=300mA speed=480Mbit/s
                             *-disk
                                  description: SCSI Disk
                                  product: Bridge-C
                                  vendor: Leef
                                  physical id: 0.0.0
                                  bus info: scsi@14:0.0.0
                                  logical name: /dev/sdg
                                  version: PMAP
                                  serial: 057300B47080
                                  size: 28GiB (31GB)
                                  capabilities: removable
                                  configuration: ansiversion=6 
logicalsectorsize=512 sectorsize=512
                                *-medium
                                     physical id: 0
                                     logical name: /dev/sdg
                                     size: 28GiB (31GB)
                                     capabilities: partitioned 
partitioned:dos
                                     configuration: signature=712697c0
                                   *-volume:0
                                        description: Empty partition
                                        physical id: 1
                                        logical name: /dev/sdg1
                                        logical name: 
/media/amiga/Linux Mint 22 Cinnamon 64-bit
                                        capacity: 2773MiB
                                        capabilities: primary bootable 
nofs
                                        configuration: 
mount.fstype=iso9660 
mount.options=ro,nosuid,nodev,relatime,nojoliet,check=s,map=n,blocksize=2048,uid=1000,gid=1000,dmode=500,fmode=400,iocharset=utf8 
state=mounted
                                   *-volume:1
                                        description: Windows FAT volume
                                        vendor: mkfs.fat
                                        physical id: 2
                                        logical name: /dev/sdg2
                                        version: FAT12
                                        serial: 669d-0308
                                        size: 15EiB
                                        capabilities: primary boot fat 
initialized
                                        configuration: FATs=2 
filesystem=fat
                                   *-volume:2
                                        description: EXT4 volume
                                        vendor: Linux
                                        physical id: 3
                                        logical name: /dev/sdg3
                                        version: 1.0
                                        serial: 
f338d5fa-a56f-4278-9009-341d705b8a80
                                        size: 26GiB
                                        capacity: 26GiB
                                        capabilities: primary journaled 
extended_attributes large_files huge_files dir_nlink 64bit extents ext4 
ext2 initialized
                                        configuration: 
created=2024-10-15 12:03:01 filesystem=ext4 label=writable 
lastmountpoint=/root/var/log modified=2025-05-19 21:03:28 
mounted=2025-05-19 19:57:35 state=clean
                    *-usb:1
                         description: USB hub
                         product: USB2.0 Hub
                         vendor: VIA Labs, Inc.
                         physical id: 2
                         bus info: usb@5:2
                         version: 7.04
                         serial: 000000001
                         capabilities: usb-2.10
                         configuration: driver=hub slots=4 
speed=480Mbit/s
                       *-usb
                            description: USB hub
                            product: USB4206 Smart Hub
                            vendor: Microchip
                            physical id: 1
                            bus info: usb@5:2.1
                            version: 6.25
                            capabilities: usb-2.10
                            configuration: driver=hub slots=5 
speed=480Mbit/s
                          *-usb:0
                               description: Keyboard
                               product: Yubico Yubikey 4 OTP+U2F+CCID
                               vendor: Yubico
                               physical id: 1
                               bus info: usb@5:2.1.1
                               logical name: input29
                               logical name: /dev/input/event5
                               logical name: input29::capslock
                               logical name: input29::compose
                               logical name: input29::kana
                               logical name: input29::numlock
                               logical name: input29::scrolllock
                               version: 4.37
                               capabilities: usb-2.00 usb
                               configuration: driver=usbhid 
maxpower=30mA speed=12Mbit/s
                          *-usb:1
                               description: Human interface device
                               product: Apple Inc. Magic Trackpad
                               vendor: Apple Inc.
                               physical id: 4
                               bus info: usb@5:2.1.4
                               logical name: input14
                               logical name: /dev/input/event12
                               logical name: /dev/input/mouse1
                               logical name: input15
                               logical name: /dev/input/event6
                               logical name: /dev/input/mouse0
                               version: 8.71
                               serial: CC22256089W1F42AY
                               capabilities: usb-2.00 usb
                               configuration: driver=usbhid 
maxpower=500mA speed=12Mbit/s
                          *-usb:2
                               description: Keyboard
                               product: System76 Launch Heavy 
Configurable Keyboard (launch_heavy_3)
                               vendor: System76
                               physical id: 5
                               bus info: usb@5:2.1.5
                               logical name: input10
                               logical name: /dev/input/event8
                               logical name: input11
                               logical name: /dev/input/event9
                               logical name: input12
                               logical name: /dev/input/event10
                               logical name: input12::capslock
                               logical name: input12::compose
                               logical name: input12::kana
                               logical name: input12::numlock
                               logical name: input12::scrolllock
                               logical name: input9
                               logical name: /dev/input/event7
                               logical name: input9::capslock
                               logical name: input9::compose
                               logical name: input9::kana
                               logical name: input9::numlock
                               logical name: input9::scrolllock
                               version: 0.01
                               capabilities: usb-2.00 usb
                               configuration: driver=usbhid 
maxpower=500mA speed=12Mbit/s
                 *-usbhost:1
                      product: xHCI Host Controller
                      vendor: Linux 6.14.4-061404-generic xhci-hcd
                      physical id: 1
                      bus info: usb@6
                      logical name: usb6
                      version: 6.14
                      capabilities: usb-3.10
                      configuration: driver=hub slots=2 
speed=10000Mbit/s
                    *-usb:0
                         description: USB hub
                         product: USB3.1 Hub
                         vendor: VIA Labs, Inc.
                         physical id: 1
                         bus info: usb@6:1
                         version: 7.04
                         serial: 000000001
                         capabilities: usb-3.20
                         configuration: driver=hub slots=4 
speed=10000Mbit/s
                       *-usb
                            description: USB hub
                            product: USB3.1 Hub
                            vendor: VIA Labs, Inc.
                            physical id: 4
                            bus info: usb@6:1.4
                            version: 7.04
                            serial: 000000001
                            capabilities: usb-3.20
                            configuration: driver=hub slots=4 
speed=10000Mbit/s
                    *-usb:1
                         description: USB hub
                         product: USB3.1 Hub
                         vendor: VIA Labs, Inc.
                         physical id: 2
                         bus info: usb@6:2
                         version: 7.04
                         serial: 000000001
                         capabilities: usb-3.20
                         configuration: driver=hub slots=4 
speed=10000Mbit/s
                       *-usb
                            description: USB hub
                            product: USB7206 Smart Hub
                            vendor: Microchip
                            physical id: 1
                            bus info: usb@6:2.1
                            version: 6.25
                            capabilities: usb-3.20
                            configuration: driver=hub slots=4 
speed=10000Mbit/s
           *-pci:4
                description: PCI bridge
                product: PLX Technology, Inc.
                vendor: PLX Technology, Inc.
                physical id: 14
                bus info: pci@0000:0c:14.0
                version: ab
                width: 64 bits
                clock: 33MHz
                capabilities: pci pm msi pciexpress normal_decode 
bus_master cap_list
                configuration: driver=pcieport
                resources: iomemory:1f10-1f0f irq:41 
memory:74c00000-750fffff
              *-network
                   description: Ethernet interface
                   product: AQC113C NBase-T/IEEE 802.3an Ethernet 
Controller [Marvell Scalable mGig]
                   vendor: Aquantia Corp.
                   physical id: 0
                   bus info: pci@0000:11:00.0
                   logical name: enp17s0
                   version: 03
                   serial: 02:76:c6:01:3e:43
                   capacity: 10Gbit/s
                   width: 64 bits
                   clock: 33MHz
                   capabilities: pm msi pciexpress msix vpd bus_master 
cap_list rom ethernet physical tp 10bt-fd 100bt-fd 1000bt-fd 10000bt-fd 
autonegotiation
                   configuration: autonegotiation=on broadcast=yes 
driver=atlantic driverversion=6.14.4-061404-generic firmware=1.3.21 
latency=0 link=no multicast=yes port=twisted pair
                   resources: irq:16 memory:75000000-7507ffff 
memory:75080000-75080fff memory:74c00000-74ffffff 
memory:750a0000-750bffff
     *-generic:70 UNCLAIMED
          description: System peripheral
          product: Sky Lake-E VT-d
          vendor: Intel Corporation
          physical id: 22
          bus info: pci@0000:0a:05.0
          version: 07
          width: 32 bits
          clock: 33MHz
          capabilities: pciexpress cap_list
          configuration: latency=0
     *-generic:71 UNCLAIMED
          description: System peripheral
          product: Sky Lake-E RAS Configuration Registers
          vendor: Intel Corporation
          physical id: 28
          bus info: pci@0000:0a:05.2
          version: 07
          width: 32 bits
          clock: 33MHz
          capabilities: pciexpress cap_list
          configuration: latency=0
     *-generic:72 UNCLAIMED
          description: PIC
          product: Sky Lake-E IOxAPIC Configuration Registers
          vendor: Intel Corporation
          physical id: 29
          bus info: pci@0000:0a:05.4
          version: 07
          width: 32 bits
          clock: 33MHz
          capabilities: pciexpress pm io_x_-apic bus_master cap_list
          configuration: latency=0
          resources: memory:75400000-75400fff
     *-generic:73
          description: System peripheral
          product: Sky Lake-E Integrated Memory Controller
          vendor: Intel Corporation
          physical id: 2a
          bus info: pci@0000:0a:08.0
          version: 07
          width: 32 bits
          clock: 33MHz
          capabilities: pciexpress cap_list
          configuration: driver=skx_uncore latency=0
          resources: irq:0
     *-generic:74
          description: System peripheral
          product: Sky Lake-E Integrated Memory Controller
          vendor: Intel Corporation
          physical id: 2b
          bus info: pci@0000:0a:09.0
          version: 07
          width: 32 bits
          clock: 33MHz
          capabilities: pciexpress cap_list
          configuration: driver=skx_uncore latency=0
          resources: irq:0
     *-generic:75 UNCLAIMED
          description: System peripheral
          product: Sky Lake-E Integrated Memory Controller
          vendor: Intel Corporation
          physical id: 2c
          bus info: pci@0000:0a:0a.0
          version: 07
          width: 32 bits
          clock: 33MHz
          capabilities: pciexpress cap_list
          configuration: latency=0
     *-generic:76 UNCLAIMED
          description: System peripheral
          product: Sky Lake-E Integrated Memory Controller
          vendor: Intel Corporation
          physical id: 2d
          bus info: pci@0000:0a:0a.1
          version: 07
          width: 32 bits
          clock: 33MHz
          capabilities: pciexpress cap_list
          configuration: latency=0
     *-generic:77
          description: System peripheral
          product: Sky Lake-E Integrated Memory Controller
          vendor: Intel Corporation
          physical id: 2e
          bus info: pci@0000:0a:0a.2
          version: 07
          width: 32 bits
          clock: 33MHz
          capabilities: pciexpress cap_list
          configuration: driver=skx_uncore latency=0
          resources: irq:0
     *-generic:78 UNCLAIMED
          description: System peripheral
          product: Sky Lake-E Integrated Memory Controller
          vendor: Intel Corporation
          physical id: 2f
          bus info: pci@0000:0a:0a.3
          version: 07
          width: 32 bits
          clock: 33MHz
          capabilities: pciexpress cap_list
          configuration: latency=0
     *-generic:79 UNCLAIMED
          description: System peripheral
          product: Sky Lake-E Integrated Memory Controller
          vendor: Intel Corporation
          physical id: 30
          bus info: pci@0000:0a:0a.4
          version: 07
          width: 32 bits
          clock: 33MHz
          capabilities: pciexpress cap_list
          configuration: latency=0
     *-generic:80 UNCLAIMED
          description: System peripheral
          product: Sky Lake-E LM Channel 1
          vendor: Intel Corporation
          physical id: 31
          bus info: pci@0000:0a:0a.5
          version: 07
          width: 32 bits
          clock: 33MHz
          capabilities: pciexpress cap_list
          configuration: latency=0
     *-generic:81
          description: System peripheral
          product: Sky Lake-E LMS Channel 1
          vendor: Intel Corporation
          physical id: 32
          bus info: pci@0000:0a:0a.6
          version: 07
          width: 32 bits
          clock: 33MHz
          capabilities: pciexpress cap_list
          configuration: driver=skx_uncore latency=0
          resources: irq:0
     *-generic:82 UNCLAIMED
          description: System peripheral
          product: Sky Lake-E LMDP Channel 1
          vendor: Intel Corporation
          physical id: 33
          bus info: pci@0000:0a:0a.7
          version: 07
          width: 32 bits
          clock: 33MHz
          capabilities: pciexpress cap_list
          configuration: latency=0
     *-generic:83 UNCLAIMED
          description: System peripheral
          product: Sky Lake-E DECS Channel 2
          vendor: Intel Corporation
          physical id: 34
          bus info: pci@0000:0a:0b.0
          version: 07
          width: 32 bits
          clock: 33MHz
          capabilities: pciexpress cap_list
          configuration: latency=0
     *-generic:84 UNCLAIMED
          description: System peripheral
          product: Sky Lake-E LM Channel 2
          vendor: Intel Corporation
          physical id: 35
          bus info: pci@0000:0a:0b.1
          version: 07
          width: 32 bits
          clock: 33MHz
          capabilities: pciexpress cap_list
          configuration: latency=0
     *-generic:85
          description: System peripheral
          product: Sky Lake-E LMS Channel 2
          vendor: Intel Corporation
          physical id: 36
          bus info: pci@0000:0a:0b.2
          version: 07
          width: 32 bits
          clock: 33MHz
          capabilities: pciexpress cap_list
          configuration: driver=skx_uncore latency=0
          resources: irq:0
     *-generic:86 UNCLAIMED
          description: System peripheral
          product: Sky Lake-E LMDP Channel 2
          vendor: Intel Corporation
          physical id: 37
          bus info: pci@0000:0a:0b.3
          version: 07
          width: 32 bits
          clock: 33MHz
          capabilities: pciexpress cap_list
          configuration: latency=0
     *-generic:87 UNCLAIMED
          description: System peripheral
          product: Sky Lake-E Integrated Memory Controller
          vendor: Intel Corporation
          physical id: c
          bus info: pci@0000:0a:0c.0
          version: 07
          width: 32 bits
          clock: 33MHz
          capabilities: pciexpress cap_list
          configuration: latency=0
     *-generic:88 UNCLAIMED
          description: System peripheral
          product: Sky Lake-E Integrated Memory Controller
          vendor: Intel Corporation
          physical id: c.1
          bus info: pci@0000:0a:0c.1
          version: 07
          width: 32 bits
          clock: 33MHz
          capabilities: pciexpress cap_list
          configuration: latency=0
     *-generic:89
          description: System peripheral
          product: Sky Lake-E Integrated Memory Controller
          vendor: Intel Corporation
          physical id: c.2
          bus info: pci@0000:0a:0c.2
          version: 07
          width: 32 bits
          clock: 33MHz
          capabilities: pciexpress cap_list
          configuration: driver=skx_uncore latency=0
          resources: irq:0
     *-generic:90 UNCLAIMED
          description: System peripheral
          product: Sky Lake-E Integrated Memory Controller
          vendor: Intel Corporation
          physical id: c.3
          bus info: pci@0000:0a:0c.3
          version: 07
          width: 32 bits
          clock: 33MHz
          capabilities: pciexpress cap_list
          configuration: latency=0
     *-generic:91 UNCLAIMED
          description: System peripheral
          product: Sky Lake-E Integrated Memory Controller
          vendor: Intel Corporation
          physical id: c.4
          bus info: pci@0000:0a:0c.4
          version: 07
          width: 32 bits
          clock: 33MHz
          capabilities: pciexpress cap_list
          configuration: latency=0
     *-generic:92 UNCLAIMED
          description: System peripheral
          product: Sky Lake-E LM Channel 1
          vendor: Intel Corporation
          physical id: c.5
          bus info: pci@0000:0a:0c.5
          version: 07
          width: 32 bits
          clock: 33MHz
          capabilities: pciexpress cap_list
          configuration: latency=0
     *-generic:93
          description: System peripheral
          product: Sky Lake-E LMS Channel 1
          vendor: Intel Corporation
          physical id: c.6
          bus info: pci@0000:0a:0c.6
          version: 07
          width: 32 bits
          clock: 33MHz
          capabilities: pciexpress cap_list
          configuration: driver=skx_uncore latency=0
          resources: irq:0
     *-generic:94 UNCLAIMED
          description: System peripheral
          product: Sky Lake-E LMDP Channel 1
          vendor: Intel Corporation
          physical id: c.7
          bus info: pci@0000:0a:0c.7
          version: 07
          width: 32 bits
          clock: 33MHz
          capabilities: pciexpress cap_list
          configuration: latency=0
     *-generic:95 UNCLAIMED
          description: System peripheral
          product: Sky Lake-E DECS Channel 2
          vendor: Intel Corporation
          physical id: d
          bus info: pci@0000:0a:0d.0
          version: 07
          width: 32 bits
          clock: 33MHz
          capabilities: pciexpress cap_list
          configuration: latency=0
     *-generic:96 UNCLAIMED
          description: System peripheral
          product: Sky Lake-E LM Channel 2
          vendor: Intel Corporation
          physical id: d.1
          bus info: pci@0000:0a:0d.1
          version: 07
          width: 32 bits
          clock: 33MHz
          capabilities: pciexpress cap_list
          configuration: latency=0
     *-generic:97
          description: System peripheral
          product: Sky Lake-E LMS Channel 2
          vendor: Intel Corporation
          physical id: d.2
          bus info: pci@0000:0a:0d.2
          version: 07
          width: 32 bits
          clock: 33MHz
          capabilities: pciexpress cap_list
          configuration: driver=skx_uncore latency=0
          resources: irq:0
     *-generic:98 UNCLAIMED
          description: System peripheral
          product: Sky Lake-E LMDP Channel 2
          vendor: Intel Corporation
          physical id: d.3
          bus info: pci@0000:0a:0d.3
          version: 07
          width: 32 bits
          clock: 33MHz
          capabilities: pciexpress cap_list
          configuration: latency=0
     *-pci:3
          description: PCI bridge
          product: Sky Lake-E PCI Express Root Port A
          vendor: Intel Corporation
          physical id: 103
          bus info: pci@0000:12:00.0
          version: 07
          width: 32 bits
          clock: 33MHz
          capabilities: pci msi pciexpress pm normal_decode bus_master 
cap_list
          configuration: driver=pcieport
          resources: irq:42 ioport:7000(size=4096) 
memory:75800000-75afffff ioport:b0000000000(size=25769803776)
        *-pci
             description: PCI bridge
             product: Navi 10 XL Upstream Port of PCI Express Switch
             vendor: Advanced Micro Devices, Inc. [AMD/ATI]
             physical id: 0
             bus info: pci@0000:13:00.0
             version: c1
             width: 32 bits
             clock: 33MHz
             capabilities: pci pm pciexpress msi normal_decode 
bus_master cap_list
             configuration: driver=pcieport
             resources: irq:16 memory:75a00000-75a03fff 
ioport:7000(size=4096) memory:75800000-759fffff 
ioport:b0000000000(size=25769803776)
           *-pci
                description: PCI bridge
                product: Navi 10 XL Downstream Port of PCI Express 
Switch
                vendor: Advanced Micro Devices, Inc. [AMD/ATI]
                physical id: 0
                bus info: pci@0000:14:00.0
                version: 00
                width: 64 bits
                clock: 33MHz
                capabilities: pci pm pciexpress msi normal_decode 
bus_master cap_list
                configuration: driver=pcieport
                resources: iomemory:71710-7170f irq:43 
ioport:7000(size=4096) memory:75800000-759fffff 
ioport:b0000000000(size=25769803776)
              *-display
                   description: VGA compatible controller
                   product: Navi 21 [Radeon RX 6800/6800 XT / 6900 XT]
                   vendor: Advanced Micro Devices, Inc. [AMD/ATI]
                   physical id: 0
                   bus info: pci@0000:15:00.0
                   version: c1
                   width: 64 bits
                   clock: 33MHz
                   capabilities: pm pciexpress msi vga_controller 
bus_master cap_list rom
                   configuration: driver=amdgpu latency=0
                   resources: iomemory:b000-afff iomemory:b040-b03f 
irq:234 memory:b0000000000-b03ffffffff memory:b0400000000-b04001fffff 
ioport:7000(size=256) memory:75800000-758fffff memory:75900000-7591ffff
              *-multimedia
                   description: Audio device
                   product: Navi 21/23 HDMI/DP Audio Controller
                   vendor: Advanced Micro Devices, Inc. [AMD/ATI]
                   physical id: 0.1
                   bus info: pci@0000:15:00.1
                   logical name: card2
                   logical name: /dev/snd/controlC2
                   logical name: /dev/snd/hwC2D0
                   logical name: /dev/snd/pcmC2D10p
                   logical name: /dev/snd/pcmC2D11p
                   logical name: /dev/snd/pcmC2D3p
                   logical name: /dev/snd/pcmC2D7p
                   logical name: /dev/snd/pcmC2D8p
                   logical name: /dev/snd/pcmC2D9p
                   version: 00
                   width: 32 bits
                   clock: 33MHz
                   capabilities: pm pciexpress msi bus_master cap_list
                   configuration: driver=snd_hda_intel latency=0
                   resources: irq:231 memory:75920000-75923fff
                 *-input:0
                      product: HDA ATI HDMI HDMI/DP,pcm=3
                      physical id: 0
                      logical name: input22
                      logical name: /dev/input/event19
                 *-input:1
                      product: HDA ATI HDMI HDMI/DP,pcm=7
                      physical id: 1
                      logical name: input23
                      logical name: /dev/input/event21
                 *-input:2
                      product: HDA ATI HDMI HDMI/DP,pcm=8
                      physical id: 2
                      logical name: input24
                      logical name: /dev/input/event22
                 *-input:3
                      product: HDA ATI HDMI HDMI/DP,pcm=9
                      physical id: 3
                      logical name: input25
                      logical name: /dev/input/event23
                 *-input:4
                      product: HDA ATI HDMI HDMI/DP,pcm=10
                      physical id: 4
                      logical name: input26
                      logical name: /dev/input/event24
                 *-input:5
                      product: HDA ATI HDMI HDMI/DP,pcm=11
                      physical id: 5
                      logical name: input27
                      logical name: /dev/input/event25
     *-generic:99 UNCLAIMED
          description: System peripheral
          product: Sky Lake-E VT-d
          vendor: Intel Corporation
          physical id: 38
          bus info: pci@0000:12:05.0
          version: 07
          width: 32 bits
          clock: 33MHz
          capabilities: pciexpress cap_list
          configuration: latency=0
     *-generic:100 UNCLAIMED
          description: System peripheral
          product: Sky Lake-E RAS Configuration Registers
          vendor: Intel Corporation
          physical id: 39
          bus info: pci@0000:12:05.2
          version: 07
          width: 32 bits
          clock: 33MHz
          capabilities: pciexpress cap_list
          configuration: latency=0
     *-generic:101 UNCLAIMED
          description: PIC
          product: Sky Lake-E IOxAPIC Configuration Registers
          vendor: Intel Corporation
          physical id: 3a
          bus info: pci@0000:12:05.4
          version: 07
          width: 32 bits
          clock: 33MHz
          capabilities: pciexpress pm io_x_-apic bus_master cap_list
          configuration: latency=0
          resources: memory:75b00000-75b00fff
     *-generic:102
          description: Performance counters
          product: Sky Lake-E KTI 0
          vendor: Intel Corporation
          physical id: 3b
          bus info: pci@0000:12:0e.0
          version: 07
          width: 32 bits
          clock: 33MHz
          capabilities: cap_list
          configuration: driver=skx_uncore latency=0
          resources: irq:0
     *-generic:103 UNCLAIMED
          description: System peripheral
          product: Sky Lake-E UPI Registers
          vendor: Intel Corporation
          physical id: 3c
          bus info: pci@0000:12:0e.1
          version: 07
          width: 32 bits
          clock: 33MHz
          capabilities: cap_list
          configuration: latency=0
     *-generic:104
          description: Performance counters
          product: Sky Lake-E KTI 0
          vendor: Intel Corporation
          physical id: 3d
          bus info: pci@0000:12:0f.0
          version: 07
          width: 32 bits
          clock: 33MHz
          capabilities: cap_list
          configuration: driver=skx_uncore latency=0
          resources: irq:0
     *-generic:105 UNCLAIMED
          description: System peripheral
          product: Sky Lake-E UPI Registers
          vendor: Intel Corporation
          physical id: 3e
          bus info: pci@0000:12:0f.1
          version: 07
          width: 32 bits
          clock: 33MHz
          capabilities: cap_list
          configuration: latency=0
     *-generic:106
          description: Performance counters
          product: Sky Lake-E KTI 0
          vendor: Intel Corporation
          physical id: 3f
          bus info: pci@0000:12:10.0
          version: 07
          width: 32 bits
          clock: 33MHz
          capabilities: cap_list
          configuration: driver=skx_uncore latency=0
          resources: irq:0
     *-generic:107 UNCLAIMED
          description: System peripheral
          product: Sky Lake-E UPI Registers
          vendor: Intel Corporation
          physical id: 40
          bus info: pci@0000:12:10.1
          version: 07
          width: 32 bits
          clock: 33MHz
          capabilities: cap_list
          configuration: latency=0
     *-generic:108 UNCLAIMED
          description: Performance counters
          product: Sky Lake-E M3KTI Registers
          vendor: Intel Corporation
          physical id: 12
          bus info: pci@0000:12:12.0
          version: 07
          width: 32 bits
          clock: 33MHz
          capabilities: pciexpress cap_list
          configuration: latency=0
     *-generic:109
          description: Performance counters
          product: Sky Lake-E M3KTI Registers
          vendor: Intel Corporation
          physical id: 12.1
          bus info: pci@0000:12:12.1
          version: 07
          width: 32 bits
          clock: 33MHz
          configuration: driver=skx_uncore latency=0
          resources: irq:0
     *-generic:110
          description: System peripheral
          product: Sky Lake-E M3KTI Registers
          vendor: Intel Corporation
          physical id: 12.2
          bus info: pci@0000:12:12.2
          version: 07
          width: 32 bits
          clock: 33MHz
          configuration: driver=skx_uncore latency=0
          resources: irq:0
     *-generic:111 UNCLAIMED
          description: Performance counters
          product: Sky Lake-E M3KTI Registers
          vendor: Intel Corporation
          physical id: 12.4
          bus info: pci@0000:12:12.4
          version: 07
          width: 32 bits
          clock: 33MHz
          capabilities: pciexpress cap_list
          configuration: latency=0
     *-generic:112
          description: Performance counters
          product: Sky Lake-E M3KTI Registers
          vendor: Intel Corporation
          physical id: 12.5
          bus info: pci@0000:12:12.5
          version: 07
          width: 32 bits
          clock: 33MHz
          configuration: driver=skx_uncore latency=0
          resources: irq:0
     *-generic:113 UNCLAIMED
          description: System peripheral
          product: Sky Lake-E M2PCI Registers
          vendor: Intel Corporation
          physical id: 15
          bus info: pci@0000:12:15.0
          version: 07
          width: 32 bits
          clock: 33MHz
          configuration: latency=0
     *-generic:114
          description: Performance counters
          product: Sky Lake-E DDRIO Registers
          vendor: Intel Corporation
          physical id: 15.1
          bus info: pci@0000:12:15.1
          version: 07
          width: 32 bits
          clock: 33MHz
          configuration: driver=skx_uncore latency=0
          resources: irq:0
     *-generic:115 UNCLAIMED
          description: System peripheral
          product: Sky Lake-E M2PCI Registers
          vendor: Intel Corporation
          physical id: 16
          bus info: pci@0000:12:16.0
          version: 07
          width: 32 bits
          clock: 33MHz
          configuration: latency=0
     *-generic:116
          description: Performance counters
          product: Sky Lake-E DDRIO Registers
          vendor: Intel Corporation
          physical id: 16.1
          bus info: pci@0000:12:16.1
          version: 07
          width: 32 bits
          clock: 33MHz
          configuration: driver=skx_uncore latency=0
          resources: irq:0
     *-generic:117 UNCLAIMED
          description: System peripheral
          product: Sky Lake-E M2PCI Registers
          vendor: Intel Corporation
          physical id: 16.4
          bus info: pci@0000:12:16.4
          version: 07
          width: 32 bits
          clock: 33MHz
          configuration: latency=0
     *-generic:118 UNCLAIMED
          description: Performance counters
          product: Sky Lake-E DDRIO Registers
          vendor: Intel Corporation
          physical id: 16.5
          bus info: pci@0000:12:16.5
          version: 07
          width: 32 bits
          clock: 33MHz
          configuration: latency=0
     *-generic:119 UNCLAIMED
          description: System peripheral
          product: Sky Lake-E M2PCI Registers
          vendor: Intel Corporation
          physical id: 17
          bus info: pci@0000:12:17.0
          version: 07
          width: 32 bits
          clock: 33MHz
          configuration: latency=0
     *-generic:120
          description: Performance counters
          product: Sky Lake-E DDRIO Registers
          vendor: Intel Corporation
          physical id: 17.1
          bus info: pci@0000:12:17.1
          version: 07
          width: 32 bits
          clock: 33MHz
          configuration: driver=skx_uncore latency=0
          resources: irq:0
     *-pci:4
          description: PCI bridge
          product: Intel Corporation
          vendor: Intel Corporation
          physical id: 0
          bus info: pci@0000:16:00.0
          version: 07
          width: 32 bits
          clock: 33MHz
          capabilities: pci msi pciexpress pm normal_decode bus_master 
cap_list
          configuration: driver=pcieport
          resources: irq:44 ioport:8000(size=16384) 
memory:76000000-cc8fffff ioport:ce000000000(size=137438953472)
        *-pci
             description: PCI bridge
             product: PLX Technology, Inc.
             vendor: PLX Technology, Inc.
             physical id: 0
             bus info: pci@0000:17:00.0
             version: ab
             width: 32 bits
             clock: 33MHz
             capabilities: pci pm msi pciexpress normal_decode 
bus_master cap_list
             configuration: driver=pcieport
             resources: irq:16 memory:cc800000-cc83ffff 
ioport:8000(size=16384) memory:76000000-cc7fffff 
ioport:ce000000000(size=137438953472)
           *-pci:0
                description: PCI bridge
                product: PLX Technology, Inc.
                vendor: PLX Technology, Inc.
                physical id: 9
                bus info: pci@0000:18:09.0
                version: ab
                width: 32 bits
                clock: 33MHz
                capabilities: pci pm msi pciexpress normal_decode 
bus_master cap_list
                configuration: driver=pcieport
                resources: irq:45 ioport:8000(size=8192) 
memory:a1400000-cc7fffff ioport:cf000000000(size=68719476736)
              *-pci
                   description: PCI bridge
                   product: JHL7540 Thunderbolt 3 Bridge [Titan Ridge 
4C 2018]
                   vendor: Intel Corporation
                   physical id: 0
                   bus info: pci@0000:19:00.0
                   version: 06
                   width: 32 bits
                   clock: 33MHz
                   capabilities: pci pm msi pciexpress normal_decode 
bus_master cap_list
                   configuration: driver=pcieport
                   resources: irq:17 ioport:8000(size=8192) 
memory:a1400000-cc7fffff ioport:cf000000000(size=68719476736)
                 *-pci:0
                      description: PCI bridge
                      product: JHL7540 Thunderbolt 3 Bridge [Titan 
Ridge 4C 2018]
                      vendor: Intel Corporation
                      physical id: 0
                      bus info: pci@0000:1a:00.0
                      version: 06
                      width: 32 bits
                      clock: 33MHz
                      capabilities: pci pm msi pciexpress normal_decode 
bus_master cap_list
                      configuration: driver=pcieport
                      resources: irq:17 memory:a1500000-a15fffff
                    *-generic
                         description: System peripheral
                         product: JHL7540 Thunderbolt 3 NHI [Titan 
Ridge 4C 2018]
                         vendor: Intel Corporation
                         physical id: 0
                         bus info: pci@0000:1b:00.0
                         version: 06
                         width: 64 bits
                         clock: 33MHz
                         capabilities: pm msi pciexpress msix 
bus_master cap_list
                         configuration: driver=thunderbolt latency=0
                         resources: irq:17 memory:a1500000-a153ffff 
memory:a1540000-a1540fff
                 *-pci:1
                      description: PCI bridge
                      product: JHL7540 Thunderbolt 3 Bridge [Titan 
Ridge 4C 2018]
                      vendor: Intel Corporation
                      physical id: 1
                      bus info: pci@0000:1a:01.0
                      version: 06
                      width: 32 bits
                      clock: 33MHz
                      capabilities: pci pm msi pciexpress normal_decode 
bus_master cap_list
                      configuration: driver=pcieport
                      resources: irq:47 memory:a1600000-b6efffff 
ioport:cf000000000(size=34359738368)
                    *-pci
                         description: PCI bridge
                         product: JHL6540 Thunderbolt 3 Bridge (C step) 
[Alpine Ridge 4C 2016]
                         vendor: Intel Corporation
                         physical id: 0
                         bus info: pci@0000:1d:00.0
                         version: 02
                         width: 32 bits
                         clock: 33MHz
                         capabilities: pci pm msi pciexpress 
normal_decode bus_master cap_list
                         configuration: driver=pcieport
                         resources: irq:18 memory:a1600000-b6efffff 
ioport:cf000000000(size=34359738368)
                       *-pci:0
                            description: PCI bridge
                            product: JHL6540 Thunderbolt 3 Bridge (C 
step) [Alpine Ridge 4C 2016]
                            vendor: Intel Corporation
                            physical id: 0
                            bus info: pci@0000:1e:00.0
                            version: 02
                            width: 32 bits
                            clock: 33MHz
                            capabilities: pci pm msi pciexpress 
normal_decode bus_master cap_list
                            configuration: driver=pcieport
                            resources: irq:172 memory:a1600000-a16fffff 
ioport:cf000000000(size=1048576)
                          *-usb
                               description: USB controller
                               product: FL1100 USB 3.0 Host Controller
                               vendor: Fresco Logic
                               physical id: 0
                               bus info: pci@0000:1f:00.0
                               version: 10
                               width: 64 bits
                               clock: 33MHz
                               capabilities: pm msi pciexpress msix 
xhci bus_master cap_list
                               configuration: driver=xhci_hcd latency=0
                               resources: irq:18 
memory:a1600000-a160ffff memory:a1610000-a1610fff 
memory:a1611000-a1611fff
                             *-usbhost:0
                                  product: xHCI Host Controller
                                  vendor: Linux 6.14.4-061404-generic 
xhci-hcd
                                  physical id: 0
                                  bus info: usb@11
                                  logical name: usb11
                                  version: 6.14
                                  capabilities: usb-2.00
                                  configuration: driver=hub slots=4 
speed=480Mbit/s
                                *-usb:0
                                     description: Video
                                     product: NexiGo N930E FHD Webcam
                                     vendor: Nexight Inc
                                     physical id: 2
                                     bus info: usb@11:2
                                     logical name: card4
                                     logical name: /dev/snd/controlC4
                                     logical name: /dev/snd/pcmC4D0c
                                     version: 8.24
                                     serial: AN202208240001
                                     capabilities: usb-2.00
                                     configuration: 
driver=snd-usb-audio maxpower=500mA speed=480Mbit/s
                                *-usb:1
                                     description: Audio device
                                     product: Other World Computing OWC 
Thunderbolt 3 Audio Device
                                     vendor: Other World Computing
                                     physical id: 4
                                     bus info: usb@11:4
                                     logical name: card5
                                     logical name: /dev/snd/controlC5
                                     logical name: /dev/snd/pcmC5D0c
                                     logical name: /dev/snd/pcmC5D0p
                                     logical name: /dev/snd/pcmC5D1p
                                     logical name: input4
                                     logical name: /dev/input/event4
                                     version: 1.00
                                     capabilities: usb-2.00 
audio-control usb
                                     configuration: driver=usbhid 
maxpower=100mA speed=12Mbit/s
                             *-usbhost:1
                                  product: xHCI Host Controller
                                  vendor: Linux 6.14.4-061404-generic 
xhci-hcd
                                  physical id: 1
                                  bus info: usb@12
                                  logical name: usb12
                                  version: 6.14
                                  capabilities: usb-3.00
                                  configuration: driver=hub slots=4 
speed=5000Mbit/s
                                *-usb
                                     description: Mass storage device
                                     product: OWC Thunderbolt 3 Dock SD 
Card Reader
                                     vendor: Generic
                                     physical id: 3
                                     bus info: usb@12:3
                                     logical name: scsi12
                                     version: 16.16
                                     serial: 000000001616
                                     capabilities: usb-3.10 scsi 
emulated scsi-host
                                     configuration: driver=usb-storage 
maxpower=896mA speed=5000Mbit/s
                                   *-disk:0
                                        description: SCSI Disk
                                        product: SD Card Reader
                                        vendor: OWC TB3
                                        physical id: 0.0.0
                                        bus info: scsi@12:0.0.0
                                        logical name: /dev/sdc
                                        version: 1616
                                        serial: 000000001616
                                        size: 238GiB (256GB)
                                        capabilities: removable
                                        configuration: ansiversion=6 
logicalsectorsize=512 sectorsize=512
                                      *-medium
                                           physical id: 0
                                           logical name: /dev/sdc
                                           size: 238GiB (256GB)
                                           capabilities: partitioned 
partitioned:dos
                                         *-volume
                                              description: HPFS/NTFS 
partition
                                              physical id: 1
                                              logical name: /dev/sdc1
                                              logical name: 
/media/amiga/disk
                                              capacity: 238GiB
                                              capabilities: primary 
bootable
                                              configuration: 
mount.fstype=exfat 
mount.options=rw,nosuid,nodev,relatime,uid=1000,gid=1000,fmask=0022,dmask=0022,iocharset=utf8,errors=remount-ro 
state=mounted
                                   *-disk:1
                                        description: SCSI Disk
                                        product: SD Card Reader
                                        vendor: OWC TB3
                                        physical id: 0.0.1
                                        bus info: scsi@12:0.0.1
                                        logical name: /dev/sdd
                                        version: 1616
                                        serial: 000000001616
                                        capabilities: removable
                                        configuration: ansiversion=6 
logicalsectorsize=512 sectorsize=512
                                      *-medium
                                           physical id: 0
                                           logical name: /dev/sdd
                       *-pci:1
                            description: PCI bridge
                            product: JHL6540 Thunderbolt 3 Bridge (C 
step) [Alpine Ridge 4C 2016]
                            vendor: Intel Corporation
                            physical id: 1
                            bus info: pci@0000:1e:01.0
                            version: 02
                            width: 32 bits
                            clock: 33MHz
                            capabilities: pci pm msi pciexpress 
normal_decode bus_master cap_list
                            configuration: driver=pcieport
                            resources: irq:173 memory:a1700000-a17fffff 
ioport:cf000100000(size=1048576)
                          *-usb
                               description: USB controller
                               product: ASM1142 USB 3.1 Host Controller
                               vendor: ASMedia Technology Inc.
                               physical id: 0
                               bus info: pci@0000:20:00.0
                               version: 00
                               width: 64 bits
                               clock: 33MHz
                               capabilities: msi msix pm pciexpress 
xhci bus_master cap_list
                               configuration: driver=xhci_hcd latency=0
                               resources: irq:19 
memory:a1700000-a1707fff
                             *-usbhost:0
                                  product: xHCI Host Controller
                                  vendor: Linux 6.14.4-061404-generic 
xhci-hcd
                                  physical id: 0
                                  bus info: usb@13
                                  logical name: usb13
                                  version: 6.14
                                  capabilities: usb-2.00
                                  configuration: driver=hub slots=2 
speed=480Mbit/s
                             *-usbhost:1
                                  product: xHCI Host Controller
                                  vendor: Linux 6.14.4-061404-generic 
xhci-hcd
                                  physical id: 1
                                  bus info: usb@14
                                  logical name: usb14
                                  version: 6.14
                                  capabilities: usb-3.10
                                  configuration: driver=hub slots=2 
speed=10000Mbit/s
                                *-usb
                                     description: Mass storage device
                                     product: USB3.0 Card Reader
                                     vendor: Realtek
                                     physical id: 2
                                     bus info: usb@14:2
                                     logical name: scsi13
                                     version: 1.25
                                     serial: 201506301013
                                     capabilities: usb-3.00 scsi 
emulated scsi-host
                                     configuration: driver=usb-storage 
maxpower=800mA speed=5000Mbit/s
                                   *-disk:0
                                        description: SCSI Disk
                                        product: USB3.0 CRW -SD
                                        vendor: Generic-
                                        physical id: 0.0.0
                                        bus info: scsi@13:0.0.0
                                        logical name: /dev/sde
                                        version: 1.00
                                        serial: 2012062914345300
                                        capabilities: removable
                                        configuration: ansiversion=6 
logicalsectorsize=512 sectorsize=512
                                      *-medium
                                           physical id: 0
                                           logical name: /dev/sde
                                   *-disk:1
                                        description: SCSI Disk
                                        product: USB3.0 CRW -SD
                                        vendor: Generic-
                                        physical id: 0.0.1
                                        bus info: scsi@13:0.0.1
                                        logical name: /dev/sdf
                                        version: 1.00
                                        serial: 2012062914345300
                                        capabilities: removable
                                        configuration: ansiversion=6 
logicalsectorsize=512 sectorsize=512
                                      *-medium
                                           physical id: 0
                                           logical name: /dev/sdf
                       *-pci:2
                            description: PCI bridge
                            product: JHL6540 Thunderbolt 3 Bridge (C 
step) [Alpine Ridge 4C 2016]
                            vendor: Intel Corporation
                            physical id: 2
                            bus info: pci@0000:1e:02.0
                            version: 02
                            width: 32 bits
                            clock: 33MHz
                            capabilities: pci pm msi pciexpress 
normal_decode bus_master cap_list
                            configuration: driver=pcieport
                            resources: irq:174 memory:a1800000-a18fffff 
ioport:cf000200000(size=1048576)
                          *-usb
                               description: USB controller
                               product: FL1100 USB 3.0 Host Controller
                               vendor: Fresco Logic
                               physical id: 0
                               bus info: pci@0000:21:00.0
                               version: 10
                               width: 64 bits
                               clock: 33MHz
                               capabilities: pm msi pciexpress msix 
xhci bus_master cap_list
                               configuration: driver=xhci_hcd latency=0
                               resources: irq:16 
memory:a1800000-a180ffff memory:a1810000-a1810fff 
memory:a1811000-a1811fff
                             *-usbhost:0
                                  product: xHCI Host Controller
                                  vendor: Linux 6.14.4-061404-generic 
xhci-hcd
                                  physical id: 0
                                  bus info: usb@15
                                  logical name: usb15
                                  version: 6.14
                                  capabilities: usb-2.00
                                  configuration: driver=hub slots=4 
speed=480Mbit/s
                                *-usb
                                     description: Audio device
                                     product: Burr-Brown from TI USB 
Audio DAC
                                     vendor: Burr-Brown from TI
                                     physical id: 4
                                     bus info: usb@15:4
                                     logical name: card3
                                     logical name: /dev/snd/controlC3
                                     logical name: /dev/snd/pcmC3D0p
                                     logical name: input3
                                     logical name: /dev/input/event3
                                     version: 1.00
                                     capabilities: usb-1.10 
audio-control usb
                                     configuration: driver=usbhid 
maxpower=500mA speed=12Mbit/s
                             *-usbhost:1
                                  product: xHCI Host Controller
                                  vendor: Linux 6.14.4-061404-generic 
xhci-hcd
                                  physical id: 1
                                  bus info: usb@16
                                  logical name: usb16
                                  version: 6.14
                                  capabilities: usb-3.00
                                  configuration: driver=hub slots=4 
speed=5000Mbit/s
                       *-pci:3
                            description: PCI bridge
                            product: JHL6540 Thunderbolt 3 Bridge (C 
step) [Alpine Ridge 4C 2016]
                            vendor: Intel Corporation
                            physical id: 3
                            bus info: pci@0000:1e:03.0
                            version: 02
                            width: 32 bits
                            clock: 33MHz
                            capabilities: pci pm msi pciexpress 
normal_decode bus_master cap_list
                            configuration: driver=pcieport
                            resources: irq:175 memory:a1900000-a19fffff 
ioport:cf000300000(size=1048576)
                          *-network
                               description: Ethernet interface
                               product: I210 Gigabit Network Connection
                               vendor: Intel Corporation
                               physical id: 0
                               bus info: pci@0000:22:00.0
                               logical name: enp34s0
                               version: 03
                               serial: 00:50:b6:e9:f6:8f
                               capacity: 1Gbit/s
                               width: 32 bits
                               clock: 33MHz
                               capabilities: pm msi msix pciexpress 
bus_master cap_list ethernet physical tp 10bt 10bt-fd 100bt 100bt-fd 
1000bt-fd autonegotiation
                               configuration: autonegotiation=on 
broadcast=yes driver=igb driverversion=6.14.4-061404-generic 
firmware=3.25, 0x800005cf latency=0 link=no multicast=yes port=twisted 
pair
                               resources: irq:17 
memory:a1900000-a197ffff memory:a1980000-a1983fff
                       *-pci:4
                            description: PCI bridge
                            product: JHL6540 Thunderbolt 3 Bridge (C 
step) [Alpine Ridge 4C 2016]
                            vendor: Intel Corporation
                            physical id: 4
                            bus info: pci@0000:1e:04.0
                            version: 02
                            width: 32 bits
                            clock: 33MHz
                            capabilities: pci pm msi pciexpress 
normal_decode bus_master cap_list
                            configuration: driver=pcieport
                            resources: irq:176 memory:a1a00000-b6efffff 
ioport:cf000400000(size=34355544064)
                          *-pci
                               description: PCI bridge
                               product: CV82524 Thunderbolt Controller 
[Light Ridge 4C 2010]
                               vendor: Intel Corporation
                               physical id: 0
                               bus info: pci@0000:23:00.0
                               version: 00
                               width: 32 bits
                               clock: 33MHz
                               capabilities: pci pm msi pciexpress 
normal_decode bus_master cap_list
                               configuration: driver=pcieport
                               resources: irq:18 
memory:a1a00000-b6efffff ioport:cf000400000(size=34355544064)
                             *-pci:0
                                  description: PCI bridge
                                  product: CV82524 Thunderbolt 
Controller [Light Ridge 4C 2010]
                                  vendor: Intel Corporation
                                  physical id: 3
                                  bus info: pci@0000:24:03.0
                                  version: 00
                                  width: 64 bits
                                  clock: 33MHz
                                  capabilities: pci pm msi pciexpress 
normal_decode bus_master cap_list
                                  configuration: driver=pcieport
                                  resources: iomemory:1f10-1f0f irq:206 
memory:a1a00000-a1afffff ioport:cf000400000(size=1048576)
                                *-sata
                                     description: SATA controller
                                     product: 88SE9182 PCIe 2.0 x2 
2-port SATA 6 Gb/s Controller
                                     vendor: Marvell Technology Group 
Ltd.
                                     physical id: 0
                                     bus info: pci@0000:25:00.0
                                     logical name: scsi5
                                     logical name: scsi6
                                     version: 11
                                     width: 32 bits
                                     clock: 33MHz
                                     capabilities: sata pm msi 
pciexpress ahci_1.0 bus_master cap_list rom emulated
                                     configuration: driver=ahci 
latency=0
                                     resources: irq:207 
memory:a1a20000-a1a201ff ioport:a1a00000(size=131072)
                                   *-disk:0
                                        description: ATA Disk
                                        product: WUH721816ALE6L4
                                        physical id: 0
                                        bus info: scsi@5:0.0.0
                                        logical name: /dev/sda
                                        version: W232
                                        serial: 2CK5U75N
                                        size: 14TiB (16TB)
                                        configuration: ansiversion=5 
logicalsectorsize=512 sectorsize=4096
                                   *-disk:1
                                        description: ATA Disk
                                        product: WDC WUH721816AL
                                        vendor: Western Digital
                                        physical id: 1
                                        bus info: scsi@6:0.0.0
                                        logical name: /dev/sdb
                                        version: T680
                                        serial: 2PH7ZZKT
                                        size: 14TiB (16TB)
                                        configuration: ansiversion=5 
logicalsectorsize=512 sectorsize=4096
                             *-pci:1
                                  description: PCI bridge
                                  product: CV82524 Thunderbolt 
Controller [Light Ridge 4C 2010]
                                  vendor: Intel Corporation
                                  physical id: 4
                                  bus info: pci@0000:24:04.0
                                  version: 00
                                  width: 64 bits
                                  clock: 33MHz
                                  capabilities: pci pm msi pciexpress 
normal_decode bus_master cap_list
                                  configuration: driver=pcieport
                                  resources: iomemory:1f10-1f0f irq:18 
memory:a1b00000-ac5fffff ioport:cf000500000(size=17177772032)
                                *-pci
                                     description: PCI bridge
                                     product: DSL5520 Thunderbolt 2 
Bridge [Falcon Ridge 4C 2013]
                                     vendor: Intel Corporation
                                     physical id: 0
                                     bus info: pci@0000:26:00.0
                                     version: 00
                                     width: 32 bits
                                     clock: 33MHz
                                     capabilities: pci pm msi 
pciexpress normal_decode bus_master cap_list
                                     configuration: driver=pcieport
                                     resources: irq:18 
memory:a1b00000-ac5fffff ioport:cf000500000(size=17177772032)
                                   *-pci:0
                                        description: PCI bridge
                                        product: DSL5520 Thunderbolt 2 
Bridge [Falcon Ridge 4C 2013]
                                        vendor: Intel Corporation
                                        physical id: 3
                                        bus info: pci@0000:27:03.0
                                        version: 00
                                        width: 32 bits
                                        clock: 33MHz
                                        capabilities: pci pm msi 
pciexpress normal_decode bus_master cap_list
                                        configuration: driver=pcieport
                                        resources: irq:208 
memory:a1b00000-a1bfffff ioport:cf000500000(size=1048576)
                                      *-sata
                                           description: SATA controller
                                           product: 106x SATA/RAID 
Controller
                                           vendor: ASMedia Technology 
Inc.
                                           physical id: 0
                                           bus info: pci@0000:28:00.0
                                           logical name: scsi7
                                           version: 01
                                           width: 32 bits
                                           clock: 33MHz
                                           capabilities: sata msi pm 
pciexpress ahci_1.0 bus_master cap_list rom emulated
                                           configuration: driver=ahci 
latency=0
                                           resources: irq:211 
memory:a1b80000-a1b81fff memory:a1b00000-a1b7ffff
                                         *-disk
                                              description: ATA Disk
                                              product: OWC Mercury
                                              physical id: 0.0.0
                                              bus info: scsi@7:0.0.0
                                              logical name: /dev/sdh
                                              version: 1H02
                                              serial: ,OAkeb{Gne
                                              size: 7452GiB (8001GB)
                                              capabilities: gpt-1.00 
partitioned partitioned:gpt
                                              configuration: 
ansiversion=5 guid=197ac7ec-19fb-4422-a2a2-7c1605a6578e 
logicalsectorsize=512 sectorsize=4096
                                            *-volume
                                                 description: EFI 
partition
                                                 physical id: 1
                                                 bus info: 
scsi@7:0.0.0,1
                                                 logical name: /dev/sdh1
                                                 serial: 
cee754e5-30a8-490d-a78d-6173df7e1e3d
                                                 size: 7452GiB
                                                 capacity: 7452GiB
                                                 width: 2268419264 bits
                                                 capabilities: 
encrypted luks initialized
                                                 configuration: 
bits=28038223040 filesystem=luks hash=sha256 version=2
                                   *-pci:1
                                        description: PCI bridge
                                        product: DSL5520 Thunderbolt 2 
Bridge [Falcon Ridge 4C 2013]
                                        vendor: Intel Corporation
                                        physical id: 4
                                        bus info: pci@0000:27:04.0
                                        version: 00
                                        width: 32 bits
                                        clock: 33MHz
                                        capabilities: pci pm msi 
pciexpress normal_decode bus_master cap_list
                                        configuration: driver=pcieport
                                        resources: irq:209 
memory:a1c00000-a70fffff ioport:cf000600000(size=8587837440)
                                   *-pci:2
                                        description: PCI bridge
                                        product: DSL5520 Thunderbolt 2 
Bridge [Falcon Ridge 4C 2013]
                                        vendor: Intel Corporation
                                        physical id: 5
                                        bus info: pci@0000:27:05.0
                                        version: 00
                                        width: 32 bits
                                        clock: 33MHz
                                        capabilities: pci pm msi 
pciexpress normal_decode bus_master cap_list
                                        configuration: driver=pcieport
                                        resources: irq:210 
memory:a7100000-ac5fffff ioport:cf200400000(size=8587837440)
                             *-pci:2
                                  description: PCI bridge
                                  product: CV82524 Thunderbolt 
Controller [Light Ridge 4C 2010]
                                  vendor: Intel Corporation
                                  physical id: 5
                                  bus info: pci@0000:24:05.0
                                  version: 00
                                  width: 64 bits
                                  clock: 33MHz
                                  capabilities: pci pm msi pciexpress 
normal_decode bus_master cap_list
                                  configuration: driver=pcieport
                                  resources: iomemory:1f10-1f0f irq:19 
memory:ac600000-b6efffff ioport:cf400300000(size=17175674880)
                 *-pci:2
                      description: PCI bridge
                      product: JHL7540 Thunderbolt 3 Bridge [Titan 
Ridge 4C 2018]
                      vendor: Intel Corporation
                      physical id: 2
                      bus info: pci@0000:1a:02.0
                      version: 06
                      width: 32 bits
                      clock: 33MHz
                      capabilities: pci pm msi pciexpress normal_decode 
bus_master cap_list
                      configuration: driver=pcieport
                      resources: irq:19 memory:a1400000-a14fffff
                    *-usb
                         description: USB controller
                         product: JHL7540 Thunderbolt 3 USB Controller 
[Titan Ridge 4C 2018]
                         vendor: Intel Corporation
                         physical id: 0
                         bus info: pci@0000:1c:00.0
                         version: 06
                         width: 64 bits
                         clock: 33MHz
                         capabilities: pm msi pciexpress xhci cap_list
                         configuration: driver=xhci_hcd latency=0
                         resources: irq:75 memory:a1400000-a140ffff
                       *-usbhost:0
                            product: xHCI Host Controller
                            vendor: Linux 6.14.4-061404-generic xhci-hcd
                            physical id: 0
                            bus info: usb@7
                            logical name: usb7
                            version: 6.14
                            capabilities: usb-2.00
                            configuration: driver=hub slots=2 
speed=480Mbit/s
                       *-usbhost:1
                            product: xHCI Host Controller
                            vendor: Linux 6.14.4-061404-generic xhci-hcd
                            physical id: 1
                            bus info: usb@8
                            logical name: usb8
                            version: 6.14
                            capabilities: usb-3.10
                            configuration: driver=hub slots=2 
speed=10000Mbit/s
                 *-pci:3
                      description: PCI bridge
                      product: JHL7540 Thunderbolt 3 Bridge [Titan 
Ridge 4C 2018]
                      vendor: Intel Corporation
                      physical id: 4
                      bus info: pci@0000:1a:04.0
                      version: 06
                      width: 32 bits
                      clock: 33MHz
                      capabilities: pci pm msi pciexpress normal_decode 
bus_master cap_list
                      configuration: driver=pcieport
                      resources: irq:48 ioport:9000(size=4096) 
memory:b6f00000-cc7fffff ioport:cf800000000(size=34359738368)
           *-pci:1
                description: PCI bridge
                product: PLX Technology, Inc.
                vendor: PLX Technology, Inc.
                physical id: a
                bus info: pci@0000:18:0a.0
                version: ab
                width: 32 bits
                clock: 33MHz
                capabilities: pci pm msi pciexpress normal_decode 
bus_master cap_list
                configuration: driver=pcieport
                resources: irq:46 ioport:a000(size=8192) 
memory:76000000-a13fffff ioport:ce000000000(size=68719476736)
              *-pci
                   description: PCI bridge
                   product: JHL7540 Thunderbolt 3 Bridge [Titan Ridge 
4C 2018]
                   vendor: Intel Corporation
                   physical id: 0
                   bus info: pci@0000:8b:00.0
                   version: 06
                   width: 32 bits
                   clock: 33MHz
                   capabilities: pci pm msi pciexpress normal_decode 
bus_master cap_list
                   configuration: driver=pcieport
                   resources: irq:18 ioport:a000(size=8192) 
memory:76000000-a13fffff ioport:ce000000000(size=68719476736)
                 *-pci:0
                      description: PCI bridge
                      product: JHL7540 Thunderbolt 3 Bridge [Titan 
Ridge 4C 2018]
                      vendor: Intel Corporation
                      physical id: 0
                      bus info: pci@0000:8c:00.0
                      version: 06
                      width: 64 bits
                      clock: 33MHz
                      capabilities: pci pm msi pciexpress normal_decode 
bus_master cap_list
                      configuration: driver=pcieport
                      resources: iomemory:1f10-1f0f irq:18 
memory:76100000-761fffff
                    *-generic
                         description: System peripheral
                         product: JHL7540 Thunderbolt 3 NHI [Titan 
Ridge 4C 2018]
                         vendor: Intel Corporation
                         physical id: 0
                         bus info: pci@0000:8d:00.0
                         version: 06
                         width: 64 bits
                         clock: 33MHz
                         capabilities: pm msi pciexpress msix 
bus_master cap_list
                         configuration: driver=thunderbolt latency=0
                         resources: irq:18 memory:76100000-7613ffff 
memory:76140000-76140fff
                 *-pci:1
                      description: PCI bridge
                      product: JHL7540 Thunderbolt 3 Bridge [Titan 
Ridge 4C 2018]
                      vendor: Intel Corporation
                      physical id: 1
                      bus info: pci@0000:8c:01.0
                      version: 06
                      width: 64 bits
                      clock: 33MHz
                      capabilities: pci pm msi pciexpress normal_decode 
bus_master cap_list
                      configuration: driver=pcieport
                      resources: iomemory:a1a10-a1a0f irq:49 
ioport:a000(size=4096) memory:76200000-8bafffff 
ioport:ce000000000(size=34359738368)
                 *-pci:2
                      description: PCI bridge
                      product: JHL7540 Thunderbolt 3 Bridge [Titan 
Ridge 4C 2018]
                      vendor: Intel Corporation
                      physical id: 2
                      bus info: pci@0000:8c:02.0
                      version: 06
                      width: 64 bits
                      clock: 33MHz
                      capabilities: pci pm msi pciexpress normal_decode 
bus_master cap_list
                      configuration: driver=pcieport
                      resources: iomemory:1f10-1f0f irq:16 
memory:76000000-760fffff
                    *-usb
                         description: USB controller
                         product: JHL7540 Thunderbolt 3 USB Controller 
[Titan Ridge 4C 2018]
                         vendor: Intel Corporation
                         physical id: 0
                         bus info: pci@0000:8e:00.0
                         version: 06
                         width: 64 bits
                         clock: 33MHz
                         capabilities: pm msi pciexpress xhci cap_list
                         configuration: driver=xhci_hcd latency=0
                         resources: irq:83 memory:76000000-7600ffff
                       *-usbhost:0
                            product: xHCI Host Controller
                            vendor: Linux 6.14.4-061404-generic xhci-hcd
                            physical id: 0
                            bus info: usb@9
                            logical name: usb9
                            version: 6.14
                            capabilities: usb-2.00
                            configuration: driver=hub slots=2 
speed=480Mbit/s
                       *-usbhost:1
                            product: xHCI Host Controller
                            vendor: Linux 6.14.4-061404-generic xhci-hcd
                            physical id: 1
                            bus info: usb@10
                            logical name: usb10
                            version: 6.14
                            capabilities: usb-3.10
                            configuration: driver=hub slots=2 
speed=10000Mbit/s
                 *-pci:3
                      description: PCI bridge
                      product: JHL7540 Thunderbolt 3 Bridge [Titan 
Ridge 4C 2018]
                      vendor: Intel Corporation
                      physical id: 4
                      bus info: pci@0000:8c:04.0
                      version: 06
                      width: 64 bits
                      clock: 33MHz
                      capabilities: pci pm msi pciexpress normal_decode 
bus_master cap_list
                      configuration: driver=pcieport
                      resources: iomemory:b1b10-b1b0f irq:50 
ioport:b000(size=4096) memory:8bb00000-a13fffff 
ioport:ce800000000(size=34359738368)
     *-generic:121 UNCLAIMED
          description: System peripheral
          product: Sky Lake-E VT-d
          vendor: Intel Corporation
          physical id: 41
          bus info: pci@0000:16:05.0
          version: 07
          width: 32 bits
          clock: 33MHz
          capabilities: pciexpress cap_list
          configuration: latency=0
     *-generic:122 UNCLAIMED
          description: System peripheral
          product: Sky Lake-E RAS Configuration Registers
          vendor: Intel Corporation
          physical id: 42
          bus info: pci@0000:16:05.2
          version: 07
          width: 32 bits
          clock: 33MHz
          capabilities: pciexpress cap_list
          configuration: latency=0
     *-generic:123 UNCLAIMED
          description: PIC
          product: Sky Lake-E IOxAPIC Configuration Registers
          vendor: Intel Corporation
          physical id: 43
          bus info: pci@0000:16:05.4
          version: 07
          width: 32 bits
          clock: 33MHz
          capabilities: pciexpress pm io_x_-apic bus_master cap_list
          configuration: latency=0
          resources: memory:cc900000-cc900fff
     *-scsi
          physical id: 44
          bus info: usb@1:10
          logical name: scsi4
          capabilities: emulated scsi-host
          configuration: driver=usb-storage
        *-cdrom
             description: DVD-RAM writer
             product: BDDVDW SE-506AB
             vendor: TSSTcorp
             physical id: 0.0.0
             bus info: scsi@4:0.0.0
             logical name: /dev/cdrom
             logical name: /dev/sr0
             version: TS01
             capabilities: removable audio cd-r cd-rw dvd dvd-r dvd-ram
             configuration: status=open
  *-battery
       physical id: 2
  *-usbhost
       product: BCE VHCI Host Controller
       vendor: Linux 6.14.4-061404-generic bce-vhci
       physical id: 1
       bus info: usb@17
       logical name: usb17
       version: 6.14
       capabilities: usb-2.00
       configuration: driver=hub slots=7 speed=480Mbit/s
     *-usb:0
          description: Communication device
          product: Apple T2 Controller
          vendor: Apple Inc.
          physical id: 1
          bus info: usb@17:1
          version: 2.01
          serial: 0000000000000000
          capabilities: usb-2.00
          configuration: driver=cdc_ncm maxpower=500mA speed=480Mbit/s
     *-usb:1
          description: Human interface device
          product: Apple Headset
          vendor: Apple
          physical id: 2
          bus info: usb@17:2
          logical name: input28
          logical name: /dev/input/event15
          version: 2.06
          serial: 000000000000
          capabilities: usb-2.00 usb
          configuration: driver=usbhid maxpower=500mA speed=480Mbit/s
  *-sound
       description: Audio
       physical id: 3
       logical name: card0
       logical name: /dev/snd/controlC0
       logical name: /dev/snd/pcmC0D0p
       logical name: /dev/snd/pcmC0D2p
       logical name: /dev/snd/pcmC0D3c
  *-input:0
       product: Power Button
       physical id: 4
       logical name: input0
       logical name: /dev/input/event0
       capabilities: platform
  *-input:1
       product: Sleep Button
       physical id: 5
       logical name: input1
       logical name: /dev/input/event1
       capabilities: platform
  *-input:2
       product: Apple T2 Audio Codec Output
       physical id: 6
       logical name: input13
       logical name: /dev/input/event11
  *-input:3
       product: Power Button
       physical id: 7
       logical name: input2
       logical name: /dev/input/event2
       capabilities: platform
  *-network
       description: Ethernet interface
       physical id: 8
       bus info: usb@17:1
       logical name: enxacde48001122
       serial: ac:de:48:00:11:22
       capabilities: ethernet physical
       configuration: autonegotiation=off broadcast=yes driver=cdc_ncm 
driverversion=6.14.4-061404-generic duplex=half firmware=CDC NCM (NO 
ZLP) link=no multicast=yes port=twisted pair
</pre>

ACPI and a few other level 3 messages seen:

17:48:18 kernel: bce-vhci: Not implemented: wait for pending output 
requests
17:48:18 kernel: bce-vhci: Not implemented: wait for pending output 
requests
17:48:18 kernel: bce-vhci: Not implemented: wait for pending output 
requests
17:48:18 kernel: integrity: Reading UEFI Secure Boot Certs is not 
supported on T2 Macs.
17:48:18 kernel: apple-properties: 00000120: 70 9d d9 14 12 de 5a 00    
                      p.....Z.
17:48:18 kernel: apple-properties: 00000120: 70 9d d9 14 12 de 5a 00    
                      p.....Z.
17:48:18 kernel: apple-properties: 00000110: 20 00 47 00 55 00 49 00 44 
00 00 00 0c 00 00 00   .G.U.I.D.......
17:48:18 kernel: apple-properties: 00000100: 45 00 6e 00 64 00 70 00 6f 
00 69 00 6e 00 74 00  E.n.d.p.o.i.n.t.
17:48:18 kernel: apple-properties: 000000f0: 00 00 54 00 75 00 6e 00 6e 
00 65 00 6c 00 20 00  ..T.u.n.n.e.l. .
17:48:18 kernel: apple-properties: 000000e0: 49 00 44 00 00 00 08 00 00 
00 12 de 00 00 2e 00  I.D.............
17:48:18 kernel: apple-properties: 000000d0: 65 00 20 00 4d 00 6f 00 64 
00 65 00 6c 00 20 00  e. .M.o.d.e.l. .
17:48:18 kernel: apple-properties: 000000c0: 6e 00 74 00 20 00 44 00 65 
00 76 00 69 00 63 00  n.t. .D.e.v.i.c.
17:48:18 kernel: apple-properties: 000000b0: 6c 00 20 00 45 00 6e 00 64 
00 70 00 6f 00 69 00  l. .E.n.d.p.o.i.
17:48:18 kernel: apple-properties: 000000a0: 00 00 44 00 00 00 54 00 75 
00 6e 00 6e 00 65 00  ..D...T.u.n.n.e.
17:48:18 kernel: apple-properties: 00000090: 72 00 20 00 49 00 44 00 00 
00 08 00 00 00 5a 00  r. .I.D.......Z.
17:48:18 kernel: apple-properties: 00000080: 63 00 65 00 20 00 56 00 65 
00 6e 00 64 00 6f 00  c.e. .V.e.n.d.o.
17:48:18 kernel: apple-properties: 00000070: 69 00 6e 00 74 00 20 00 44 
00 65 00 76 00 69 00  i.n.t. .D.e.v.i.
17:48:18 kernel: apple-properties: 00000060: 65 00 6c 00 20 00 45 00 6e 
00 64 00 70 00 6f 00  e.l. .E.n.d.p.o.
17:48:18 kernel: apple-properties: 00000050: 7f ff 04 00 46 00 00 00 54 
00 75 00 6e 00 6e 00  ....F...T.u.n.n.
17:48:18 kernel: apple-properties: 00000040: 06 00 00 00 01 01 06 00 00 
04 01 01 06 00 00 00  ................
17:48:18 kernel: apple-properties: 00000030: 00 01 01 01 06 00 00 00 01 
01 06 00 00 04 01 01  ................
17:48:18 kernel: apple-properties: 00000020: 01 01 06 00 00 09 01 01 06 
00 00 00 01 01 06 00  ................
17:48:18 kernel: apple-properties: 00000010: 04 00 00 00 01 01 06 00 00 
00 01 01 06 00 00 00  ................
17:48:18 kernel: apple-properties: 00000000: 28 01 00 00 03 00 00 00 02 
01 0c 00 d0 41 03 0a  (............A..
17:48:18 kernel: apple-properties: device path parse error -19 at 0x32:
17:48:18 kernel: apple-properties: 00000110: 0c 00 00 00 10 ed d4 0f 00 
00 03 00              ............
17:48:18 kernel: apple-properties: 00000100: 6e 00 74 00 20 00 47 00 55 
00 49 00 44 00 00 00  n.t. .G.U.I.D...
17:48:18 kernel: apple-properties: 000000f0: 6c 00 20 00 45 00 6e 00 64 
00 70 00 6f 00 69 00  l. .E.n.d.p.o.i.
17:48:18 kernel: apple-properties: 000000e0: 00 00 2e 00 00 00 54 00 75 
00 6e 00 6e 00 65 00  ......T.u.n.n.e.
17:48:18 kernel: apple-properties: 000000d0: 6c 00 20 00 49 00 44 00 00 
00 08 00 00 00 02 00  l. .I.D.........
17:48:18 kernel: apple-properties: 000000c0: 69 00 63 00 65 00 20 00 4d 
00 6f 00 64 00 65 00  i.c.e. .M.o.d.e.
17:48:18 kernel: apple-properties: 000000b0: 6f 00 69 00 6e 00 74 00 20 
00 44 00 65 00 76 00  o.i.n.t. .D.e.v.
17:48:18 kernel: apple-properties: 000000a0: 6e 00 65 00 6c 00 20 00 45 
00 6e 00 64 00 70 00  n.e.l. .E.n.d.p.
17:48:18 kernel: apple-properties: 00000090: 00 00 03 00 00 00 44 00 00 
00 54 00 75 00 6e 00  ......D...T.u.n.
17:48:18 kernel: apple-properties: 00000080: 64 00 6f 00 72 00 20 00 49 
00 44 00 00 00 08 00  d.o.r. .I.D.....
17:48:18 kernel: apple-properties: 00000070: 76 00 69 00 63 00 65 00 20 
00 56 00 65 00 6e 00  v.i.c.e. .V.e.n.
17:48:18 kernel: apple-properties: 00000060: 70 00 6f 00 69 00 6e 00 74 
00 20 00 44 00 65 00  p.o.i.n.t. .D.e.
17:48:18 kernel: apple-properties: 00000050: 6e 00 6e 00 65 00 6c 00 20 
00 45 00 6e 00 64 00  n.n.e.l. .E.n.d.
17:48:18 kernel: apple-properties: 00000040: 06 00 00 00 7f ff 04 00 46 
00 00 00 54 00 75 00  ........F...T.u.
17:48:18 kernel: apple-properties: 00000030: 00 01 01 01 06 00 00 00 01 
01 06 00 00 04 01 01  ................
17:48:18 kernel: apple-properties: 00000020: 01 01 06 00 00 09 01 01 06 
00 00 00 01 01 06 00  ................
17:48:18 kernel: apple-properties: 00000010: 04 00 00 00 01 01 06 00 00 
00 01 01 06 00 00 00  ................
17:48:18 kernel: apple-properties: 00000000: 1c 01 00 00 03 00 00 00 02 
01 0c 00 d0 41 03 0a  .............A..
17:48:18 kernel: apple-properties: device path parse error -19 at 0x32:
17:48:18 kernel: apple-properties: 00000100: 44 00 00 00 0c 00 00 00 00 
c3 f9 68 dc cf 5a 00  D..........h..Z.
17:48:18 kernel: apple-properties: 000000f0: 6f 00 69 00 6e 00 74 00 20 
00 47 00 55 00 49 00  o.i.n.t. .G.U.I.
17:48:18 kernel: apple-properties: 000000e0: 6e 00 65 00 6c 00 20 00 45 
00 6e 00 64 00 70 00  n.e.l. .E.n.d.p.
17:48:18 kernel: apple-properties: 000000d0: 00 00 21 de 00 00 2e 00 00 
00 54 00 75 00 6e 00  ..!.......T.u.n.
17:48:18 kernel: apple-properties: 000000c0: 64 00 65 00 6c 00 20 00 49 
00 44 00 00 00 08 00  d.e.l. .I.D.....
17:48:18 kernel: apple-properties: 000000b0: 65 00 76 00 69 00 63 00 65 
00 20 00 4d 00 6f 00  e.v.i.c.e. .M.o.
17:48:18 kernel: apple-properties: 000000a0: 64 00 70 00 6f 00 69 00 6e 
00 74 00 20 00 44 00  d.p.o.i.n.t. .D.
17:48:18 kernel: apple-properties: 00000090: 75 00 6e 00 6e 00 65 00 6c 
00 20 00 45 00 6e 00  u.n.n.e.l. .E.n.
17:48:18 kernel: apple-properties: 00000080: 00 00 08 00 00 00 5a 00 00 
00 44 00 00 00 54 00  ......Z...D...T.
17:48:18 kernel: apple-properties: 00000070: 65 00 6e 00 64 00 6f 00 72 
00 20 00 49 00 44 00  e.n.d.o.r. .I.D.
17:48:18 kernel: apple-properties: 00000060: 44 00 65 00 76 00 69 00 63 
00 65 00 20 00 56 00  D.e.v.i.c.e. .V.
17:48:18 kernel: apple-properties: 00000050: 6e 00 64 00 70 00 6f 00 69 
00 6e 00 74 00 20 00  n.d.p.o.i.n.t. .
17:48:18 kernel: apple-properties: 00000040: 54 00 75 00 6e 00 6e 00 65 
00 6c 00 20 00 45 00  T.u.n.n.e.l. .E.
17:48:18 kernel: apple-properties: 00000030: 00 01 01 01 06 00 00 00 7f 
ff 04 00 46 00 00 00  ............F...
17:48:18 kernel: apple-properties: 00000020: 01 01 06 00 00 09 01 01 06 
00 00 00 01 01 06 00  ................
17:48:18 kernel: apple-properties: 00000010: 04 00 00 00 01 01 06 00 00 
00 01 01 06 00 00 00  ................
17:48:18 kernel: apple-properties: 00000000: 10 01 00 00 03 00 00 00 02 
01 0c 00 d0 41 03 0a  .............A..
17:48:18 kernel: apple-properties: device path parse error -19 at 0x32:
17:48:18 kernel: ACPI Error: Aborting method \_SB.PCI0.LPCB.EC._REG due 
to previous error (AE_TIME) (20240827/psparse-529)
17:48:18 kernel: ACPI Error: Aborting method \_SB.PCI0.LPCB.EC._REG due 
to previous error (AE_TIME) (20240827/psparse-529)
17:48:18 kernel: ACPI Error: Timeout from EC hardware or EC device 
driver (20240827/evregion-311)
17:48:18 kernel: ACPI Error: AE_TIME, Returned by Handler for 
[EmbeddedControl] (20240827/evregion-301)
17:48:18 kernel: ACPI Error: Aborting method \_SB.PCI0.LPCB.EC._REG due 
to previous error (AE_TIME) (20240827/psparse-529)
17:48:18 kernel: ACPI Error: Timeout from EC hardware or EC device 
driver (20240827/evregion-311)
17:48:18 kernel: ACPI Error: AE_TIME, Returned by Handler for 
[EmbeddedControl] (20240827/evregion-301)
17:48:18 kernel: ACPI Error: Aborting method 
\_SB.PC04.MCP0.US00.DS1B.UPSB.DSB2.XHC7._PSW due to previous error 
(AE_TIME) (20240827/psparse-529)
17:48:18 kernel: ACPI Error: Timeout from EC hardware or EC device 
driver (20240827/evregion-311)
17:48:18 kernel: ACPI Error: AE_TIME, Returned by Handler for 
[EmbeddedControl] (20240827/evregion-301)
17:48:18 kernel: ACPI Error: Aborting method 
\_SB.PC04.MCP0.US00.DS1A.UPSB.DSB2.XHC6._PSW due to previous error 
(AE_TIME) (20240827/psparse-529)
17:48:18 kernel: ACPI Error: Timeout from EC hardware or EC device 
driver (20240827/evregion-311)
17:48:18 kernel: ACPI Error: AE_TIME, Returned by Handler for 
[EmbeddedControl] (20240827/evregion-301)
17:48:18 kernel: ACPI Error: Aborting method 
\_SB.PC04.MCP0.US00.DS19.UPSB.DSB2.XHC3._PSW due to previous error 
(AE_TIME) (20240827/psparse-529)
17:48:18 kernel: ACPI Error: Timeout from EC hardware or EC device 
driver (20240827/evregion-311)
17:48:18 kernel: ACPI Error: AE_TIME, Returned by Handler for 
[EmbeddedControl] (20240827/evregion-301)
17:48:18 kernel: ACPI Error: Aborting method 
\_SB.PC04.MCP0.US00.DS18.UPSB.DSB2.XHC2._PSW due to previous error 
(AE_TIME) (20240827/psparse-529)
17:48:18 kernel: ACPI Error: Timeout from EC hardware or EC device 
driver (20240827/evregion-311)
17:48:18 kernel: ACPI Error: AE_TIME, Returned by Handler for 
[EmbeddedControl] (20240827/evregion-301)
17:48:18 kernel: ACPI Error: Aborting method 
\_SB.PC04.MCP0.US00.DS0A.UPSB.DSB2.XHC5._PSW due to previous error 
(AE_TIME) (20240827/psparse-529)
17:48:18 kernel: ACPI Error: Timeout from EC hardware or EC device 
driver (20240827/evregion-311)
17:48:18 kernel: ACPI Error: AE_TIME, Returned by Handler for 
[EmbeddedControl] (20240827/evregion-301)
17:48:18 kernel: ACPI Error: Aborting method 
\_SB.PC04.MCP0.US00.DS09.UPSB.DSB2.XHC4._PSW due to previous error 
(AE_TIME) (20240827/psparse-529)
17:48:18 kernel: ACPI Error: Timeout from EC hardware or EC device 
driver (20240827/evregion-311)
17:48:18 kernel: ACPI Error: AE_TIME, Returned by Handler for 
[EmbeddedControl] (20240827/evregion-301)
17:48:18 kernel: ACPI Error: Aborting method \_SB.PCI0.RP13.XGBE._PSW 
due to previous error (AE_TIME) (20240827/psparse-529)
17:48:18 kernel: ACPI Error: Timeout from EC hardware or EC device 
driver (20240827/evregion-311)
17:48:18 kernel: ACPI Error: AE_TIME, Returned by Handler for 
[EmbeddedControl] (20240827/evregion-301)
17:48:18 kernel: ACPI Error: Aborting method \_SB.PCI0.RP09.XGBE._PSW 
due to previous error (AE_TIME) (20240827/psparse-529)
17:48:18 kernel: ACPI Error: Timeout from EC hardware or EC device 
driver (20240827/evregion-311)
17:48:18 kernel: ACPI Error: AE_TIME, Returned by Handler for 
[EmbeddedControl] (20240827/evregion-301)
17:48:18 kernel: ACPI Error: Aborting method \_SB.PCI0.RP01.ARPT._PSW 
due to previous error (AE_TIME) (20240827/psparse-529)
17:48:18 kernel: ACPI Error: Timeout from EC hardware or EC device 
driver (20240827/evregion-311)
17:48:18 kernel: ACPI Error: AE_TIME, Returned by Handler for 
[EmbeddedControl] (20240827/evregion-301)




