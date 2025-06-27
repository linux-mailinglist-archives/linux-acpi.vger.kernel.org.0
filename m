Return-Path: <linux-acpi+bounces-14810-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D8ACAEC2D5
	for <lists+linux-acpi@lfdr.de>; Sat, 28 Jun 2025 00:51:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8D063B594B
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Jun 2025 22:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3800B266EE7;
	Fri, 27 Jun 2025 22:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=merlins.org header.i=@merlins.org header.b="cAiOl28O"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E882CCA9
	for <linux-acpi@vger.kernel.org>; Fri, 27 Jun 2025 22:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.81.13.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751064674; cv=none; b=p4Vx/zWcYLBEpgopjXTUayyNo3bYxknIuDp4IkjiDKpOHfli78JIQcgRDwOB8TqtkQ9lkrHdizdv6SsZ5xOgNQ61Rx7oUpGShyx9YxE1Y8HMKpnoFzYHQJj467ThvhdrPaBOvIEtX3RESvHh0xmebWaESeuGstD99DCFz++0PK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751064674; c=relaxed/simple;
	bh=VrBC+MxIwgKQRfdozJ6MBshZJguqwkq7JzwY5k+FwCk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aj5z6T6o8BE8laHvvnS1vVOSj0Kc7GKZWpPUaRi5hgbcAxlbM0ylP09fGZRIB/gSyD6VYtf4BhkHCeqmiuMCfuKSmNKgOCE/285NtthvA8OonA90ZDH2F5ShiHzWI6I9xhiELTKCd87/81SDFiRhUhers6tXT1gmZnAByMOGc6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=merlins.org; spf=pass smtp.mailfrom=merlins.org; dkim=fail (0-bit key) header.d=merlins.org header.i=@merlins.org header.b=cAiOl28O reason="key not found in DNS"; arc=none smtp.client-ip=209.81.13.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=merlins.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=merlins.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=merlins.org
	; s=key; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=xj/Xg0DW6omOLXDRzyJHCJ34in1YZzwpdsMNoeo1mbM=; b=cAiOl28OUNlw7t0/WLk3y8hWjB
	h3XfCJIkqmd2PJwapHNb70tDdhJ0NaNDcUWBBfQs8sBCueL4tDgqy1me+vweTr7zl8vCGcfWBzRKm
	+8JL6M2RZKDB4bFElpndiPJg/ZumEH7SlyJTGcugZIY1qYgpTCJycc50t+4Zy5CCD/+bhEXDWQbdm
	t1KI8HZhAlJIflzAGVaPFsVU1LZGvLDtJ0r6Plx0VGbGsnJYMUtbfYLDamxqj/7auDxthRc6vcK5E
	D+3m7l6FoNlyNhUpsXfT7ntvCE91YgOB2fss7YuYsECwPExJhxn5ExgtblqUdpFZB1rUFKnCmWhHc
	KC2NtipQ==;
Received: from [24.6.49.44] (port=50802 helo=sauron.svh.merlins.org)
	by mail1.merlins.org with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.94.2 #2)
	id 1uVGM6-0005ET-P8 by authid <merlins.org> with srv_auth_plain; Fri, 27 Jun 2025 15:51:11 -0700
Received: from merlin by sauron.svh.merlins.org with local (Exim 4.96)
	(envelope-from <marc@merlins.org>)
	id 1uVHuS-000TVd-11;
	Fri, 27 Jun 2025 15:51:04 -0700
Date: Fri, 27 Jun 2025 15:51:04 -0700
From: Marc MERLIN <marc@merlins.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-acpi@vger.kernel.org
Subject: Re: s2idle on kdell xps 9730 does go to sleep but laptop is warm
Message-ID: <aF8gWDpwyREwf36O@merlins.org>
References: <aCWbk4z50QYym9gV@merlins.org>
 <CAJZ5v0j0NK29+D=RjsLgmAmh7_bujA5xXoLpo--FC2Gd98RMig@mail.gmail.com>
 <aD4P7eU0tOgNhPI5@merlins.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aD4P7eU0tOgNhPI5@merlins.org>
X-Sysadmin: BOFH
X-URL: http://marc.merlins.org/
X-SA-Exim-Connect-IP: 24.6.49.44
X-SA-Exim-Mail-From: marc@merlins.org

Were the logs I gave useful in any way, or just confirm that it's just
some new-ish laptop (2 years old now) that sadly does things in ways
that don't work well with linux?

https://marc.merlins.org/tmp/merlin-sleep-6.14.5_dmesg.txt
https://marc.merlins.org/tmp/merlin-sleep-6.14.5_acpi.txt


On Mon, Jun 02, 2025 at 01:56:13PM -0700, Marc MERLIN wrote:
> On Mon, Jun 02, 2025 at 04:23:42PM +0200, Rafael J. Wysocki wrote:
> > >  With kernel 6.6.9 when I put the laptop to sleep, syslog shows that the
> > >  laptop was sleeping for 9h, fans were stopped, but when I gabbed my
> > >  laptop it was warm and burned 80% of the battery overnight.
> > 
> > First off, I'd try a newer kernel.  Say 6.15.0 (unless you boot with
> > "nosmt" in the kernel command line).
>  
> Fair point, I somehow failed to upgrade the kernel on that machine.
> I have a 6.14.5 kernel I just installed.
> 
> I also upgraded all firmware:
> dpkggrep firmware | awk '{ print $1 }' | xargs apt-get install -t unstable  -y
> 
> > > And yet, linux was not running, my logs show the kernel went into ACPI
> > > sleep and back out
> > 
> > It wouldn't be "ACPI sleep" if it was suspend-to-idle.
> 
> My thinkpad has:
> sauron:~# cat /sys/power/mem_sleep
> s2idle [deep]
> 
> The Dell XPS only has:
> merlin:/usr/src# cat /sys/power/mem_sleep
> [s2idle]
> 
> > What processor is there in your system?
> 
> model name      : 13th Gen Intel(R) Core(TM) i7-13700H
> 
> > Well, it obviously is not a complete log.
> 
> Ok, I tested again with the new kernel. The laptop didn't feel warm when
> in sleep, but I lost 20% battery in 4H, which means the battery would
> not last 24H in sleep
> 
> For logs, which one did you want?  I have pretty full logs here:
> https://marc.merlins.org/tmp/merlin-sleep-6.14.5_dmesg.txt
> https://marc.merlins.org/tmp/merlin-sleep-6.14.5_acpi.txt
> 
> One thing I changed recently is that unloading wireless altogether,
> causes issues at times, so now I have
> rfkill block wlan
> instead of
> killall wpa_supplicant &>/dev/null
> pkill -f "dhclient.*wlan0"
> ifconfig -a | grep -q wlan0 && ifconfig wlan0 down
> rmmod iwlmvm
> rmmod iwlwifi iwlagn iwlcore
> rmmod ieee80211
> rmmod ieee80211_crypt_wep 2>/dev/null
> rmmod ieee80211_crypt_tkip 2>/dev/null
> rmmod ieee80211_crypt 2>/dev/null
> rmmod mac80211 2>/dev/null
> rmmod cfg80211 2>/dev/null
> 
> This bit of dmesg just before sleep may be relevant:
> [  226.365652] thunderbolt 0000:00:0d.2: save config 0x34: 0x00000080
> [  226.365654] thunderbolt 0000:00:0d.3: save config 0x2c: 0x0bda1028
> [  226.365655] thunderbolt 0000:00:0d.2: save config 0x38: 0x00000000
> [  226.365656] thunderbolt 0000:00:0d.3: save config 0x30: 0x00000000
> [  226.365657] thunderbolt 0000:00:0d.2: save config 0x3c: 0x000001ff
> [  226.365659] thunderbolt 0000:00:0d.3: save config 0x34: 0x00000080
> [  226.365661] thunderbolt 0000:00:0d.3: save config 0x38: 0x00000000
> [  226.365663] thunderbolt 0000:00:0d.3: save config 0x3c: 0x000001ff
> [  226.366245] thunderbolt 0000:00:0d.2: PME# enabled
> [  226.366424] thunderbolt 0000:00:0d.3: PME# enabled
> [  226.370305] pcieport 10000:e0:06.2: PCI PM: Suspend power state: D3hot
> [  226.370328] pcieport 10000:e0:06.0: PCI PM: Suspend power state: D3hot
> [  226.370539] vmd 0000:00:0e.0: save config 0x00: 0xa77f8086
> [  226.370551] vmd 0000:00:0e.0: save config 0x04: 0x00100406
> [  226.370555] vmd 0000:00:0e.0: save config 0x08: 0x01040000
> [  226.370560] vmd 0000:00:0e.0: save config 0x0c: 0x00800000
> [  226.370565] vmd 0000:00:0e.0: save config 0x10: 0x02000004
> [  226.370575] vmd 0000:00:0e.0: save config 0x14: 0x00000062
> [  226.370581] vmd 0000:00:0e.0: save config 0x18: 0x72000000
> [  226.370587] vmd 0000:00:0e.0: save config 0x1c: 0x00000000
> [  226.370592] vmd 0000:00:0e.0: save config 0x20: 0x07900004
> [  226.370596] vmd 0000:00:0e.0: save config 0x24: 0x00000062
> [  226.370600] vmd 0000:00:0e.0: save config 0x28: 0x00000000
> [  226.370603] vmd 0000:00:0e.0: save config 0x2c: 0x0bda1028
> [  226.370607] vmd 0000:00:0e.0: save config 0x30: 0x00000000
> [  226.370611] vmd 0000:00:0e.0: save config 0x34: 0x00000080
> [  226.370615] vmd 0000:00:0e.0: save config 0x38: 0x00000000
> [  226.370620] vmd 0000:00:0e.0: save config 0x3c: 0x00000000
> [  226.375481] intel-lpss 0000:00:15.1: ACPI _REG disconnect evaluation failed (5)
> [  226.375487] mei_me 0000:00:16.0: PCI PM: Suspend power state: D3hot
> [  226.375908] intel-lpss 0000:00:15.0: ACPI _REG disconnect evaluation failed (5)
> [  226.376162] proc_thermal_pci 0000:00:04.0: PCI PM: Suspend power state: D3hot
> [  226.377183] intel-lpss 0000:00:15.1: power state changed by ACPI to D3hot
> [  226.377277] intel-lpss 0000:00:15.1: PCI PM: Suspend power state: D3hot
> [  226.377771] intel-lpss 0000:00:15.0: power state changed by ACPI to D3hot
> [  226.378257] rtsx_pci 0000:06:00.0: PCI PM: Suspend power state: D3hot
> [  226.378422] intel-lpss 0000:00:15.0: PCI PM: Suspend power state: D3hot
> [  226.378448] pcieport 0000:00:1c.0: save config 0x00: 0x51bb8086
> [  226.378607] pcieport 0000:00:1c.0: save config 0x04: 0x00100407
> [  226.378656] pcieport 0000:00:1c.0: save config 0x08: 0x06040001
> [  226.378707] pcieport 0000:00:1c.0: save config 0x0c: 0x00810000
> [  226.378758] pcieport 0000:00:1c.0: save config 0x10: 0x00000000
> [  226.378782] pcieport 0000:00:1c.0: save config 0x14: 0x00000000
> [  226.378806] pcieport 0000:00:1c.0: save config 0x18: 0x00060600
> [  226.378830] pcieport 0000:00:1c.0: save config 0x1c: 0x000000f0
> [  226.378853] pcieport 0000:00:1c.0: save config 0x20: 0x75007500
> [  226.378877] pcieport 0000:00:1c.0: save config 0x24: 0x0001fff1
> [  226.378899] pcieport 0000:00:1c.0: save config 0x28: 0x00000000
> [  226.378905] pcieport 0000:00:1c.0: save config 0x2c: 0x00000000
> [  226.378935] pcieport 0000:00:1c.0: save config 0x30: 0x00000000
> [  226.378958] pcieport 0000:00:1c.0: save config 0x34: 0x00000040
> [  226.378982] pcieport 0000:00:1c.0: save config 0x38: 0x00000000
> [  226.379006] pcieport 0000:00:1c.0: save config 0x3c: 0x000204ff
> [  226.379534] pcieport 0000:00:1c.0: PME# enabled
> [  226.379589] thunderbolt 0000:00:0d.2: ACPI _REG disconnect evaluation failed (5)
> [  226.380218] xhci_hcd 0000:00:0d.0: ACPI _REG disconnect evaluation failed (5)
> [  226.381101] thunderbolt 0000:00:0d.3: ACPI _REG disconnect evaluation failed (5)
> [  226.382316] iwlwifi 0000:00:14.3: power state changed by ACPI to D3hot
> [  226.382528] iwlwifi 0000:00:14.3: PCI PM: Suspend power state: D3hot
> [  226.383140] vmd 0000:00:0e.0: ACPI _REG disconnect evaluation failed (5)
> [  226.384467] xhci_hcd 0000:00:14.0: power state changed by ACPI to D3hot
> [  226.384574] xhci_hcd 0000:00:14.0: PCI PM: Suspend power state: D3hot
> [  226.384813] vmd 0000:00:0e.0: power state changed by ACPI to D3hot
> [  226.384825] vmd 0000:00:0e.0: PCI PM: Suspend power state: D3hot
> [  226.385180] xhci_hcd 0000:00:0d.0: power state changed by ACPI to D3cold
> [  226.385191] xhci_hcd 0000:00:0d.0: PCI PM: Suspend power state: D3cold
> [  226.391528] pcieport 0000:00:1c.0: ACPI _REG disconnect evaluation failed (5)
> [  226.392369] pcieport 0000:00:1c.0: power state changed by ACPI to D3hot
> [  226.392484] pcieport 0000:00:1c.0: PCI PM: Suspend power state: D3hot
> [  226.395162] thunderbolt 0000:00:0d.2: power state changed by ACPI to D3cold
> [  226.395172] thunderbolt 0000:00:0d.2: PCI PM: Suspend power state: D3cold
> [  226.396283] thunderbolt 0000:00:0d.3: power state changed by ACPI to D3cold
> [  226.396291] thunderbolt 0000:00:0d.3: PCI PM: Suspend power state: D3cold
> [14916.770339] ACPI: EC: interrupt unblocked
> 
> -- 
> "A mouse is a device used to point at the xterm you want to type in" - A.S.R.
>  
> Home page: http://marc.merlins.org/                       | PGP 7F55D5F27AAF9D08

-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/                       | PGP 7F55D5F27AAF9D08

