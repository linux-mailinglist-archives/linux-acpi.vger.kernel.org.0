Return-Path: <linux-acpi+bounces-14039-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA31BAC9CE7
	for <lists+linux-acpi@lfdr.de>; Sat, 31 May 2025 23:26:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1D3E3A48C5
	for <lists+linux-acpi@lfdr.de>; Sat, 31 May 2025 21:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C91BD1A8419;
	Sat, 31 May 2025 21:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=merlins.org header.i=@merlins.org header.b="r/+bM7kB"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C4126AE4
	for <linux-acpi@vger.kernel.org>; Sat, 31 May 2025 21:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.81.13.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748726795; cv=none; b=g40CtflRYtLW5pP+c7iqsEkk8ubu8km8TzH1+DDfM9km2/1qK8BjA3/+xvs5YW7S70484uNew/UdRku0y2skIzSG1wU+zq8duN6EUsXu+lCZV8Lv34JhWj6qDgsGmiNnKwxVsZGUg3CoodmL4bd7p2UPmggrLgXTe95ZyxfHrmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748726795; c=relaxed/simple;
	bh=ADypfsi230cGVGlvQ2M78FZtbbLIWf++urgeylNld14=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KbOqSCc67EEhK3y1hSfPEgkX0f1cR7niXI2i9rGS1igBqmil023wbqs09W+7EKdB9zrbM82BJmJZZ03cEYOeY7VK2xvb1IT3jj6V5K8aOWQszwOv14i6EpGUNCMl5zZ99epWLaLJpA8Q14YTBA87j7dP14+0xXpqTqSAiApgihc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=merlins.org; spf=pass smtp.mailfrom=merlins.org; dkim=fail (0-bit key) header.d=merlins.org header.i=@merlins.org header.b=r/+bM7kB reason="key not found in DNS"; arc=none smtp.client-ip=209.81.13.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=merlins.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=merlins.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=merlins.org
	; s=key; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=VB207adBUd9kbONP6wPT0BT2tC1tOEmgU5FsQR8Sifk=; b=r/+bM7kB9nMOLx9GwkVuXrwmyr
	kDkbjPyvOYnBQjGJcsyWggwhnmp8m5xAygn3QDXu5gPzxahs7jpeR2o9M6jTRQW9rhhW557td+wvT
	/IOvDoOnbOe+RTLIAu6Tk7iUR1sOPsR6SHZexuuVibyIfiR182xoD4cBDLg3JFPmk0m6UfDe9SMGy
	umuaZ0bsAzTx0PXeXP43Gv+qgfXNEpd6ZTMTHiqKg4RH+nop4DqsgveNW5DJCnbBRMuAfsI/7raRv
	TgCoH6r1Ny0ovfVMEzlhtELKETG30fsS3c0d3lqOJrfqmpoiJmMQFkwncIz1N3d6lvdbrDOqPW+PP
	DGHh4R+w==;
Received: from c-24-4-65-180.hsd1.ca.comcast.net ([24.4.65.180]:49488 helo=sauron.svh.merlins.org)
	by mail1.merlins.org with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.94.2 #2)
	id 1uLSDQ-0004VT-3D by authid <merlins.org> with srv_auth_plain; Sat, 31 May 2025 14:26:32 -0700
Received: from merlin by sauron.svh.merlins.org with local (Exim 4.96)
	(envelope-from <marc@merlins.org>)
	id 1uLTiq-002NoA-0X;
	Sat, 31 May 2025 14:26:32 -0700
Date: Sat, 31 May 2025 14:26:32 -0700
From: Marc MERLIN <marc@merlins.org>
To: linux-acpi@vger.kernel.org
Subject: Re: s2idle on kdell xps 9730 does go to sleep but laptop is warm
Message-ID: <aDt0CH4zO96pxdIu@merlins.org>
References: <aCWbk4z50QYym9gV@merlins.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aCWbk4z50QYym9gV@merlins.org>
X-Sysadmin: BOFH
X-URL: http://marc.merlins.org/
X-SA-Exim-Connect-IP: 24.4.65.180
X-SA-Exim-Mail-From: marc@merlins.org

This is still a problem. Is there more info I can provide? For now it's
bad enough that I can't have the battery be in S3 sleep for 24H without
the batteries running out :-/

On Thu, May 15, 2025 at 12:45:23AM -0700, Marc MERLIN wrote:
> and burn a lot of battery during full kernel sleep
> Reply-To: 
> X-Sysadmin: BOFH
> X-URL: http://marc.merlins.org/
> 
>  With kernel 6.6.9 when I put the laptop to sleep, syslog shows that the
>  laptop was sleeping for 9h, fans were stopped, but when I gabbed my
>  laptop it was warm and burned 80% of the battery overnight.
> 
> And yet, linux was not running, my logs show the kernel went into ACPI
> sleep and back out
> 
> Logs show the system slept for 9h and went to sleep with s2idle.
> 
> Is it the wrong sleep outside of suspend to disk and full shutdown?
> 
> Are there devices that should have been powered off but didn't
> (evidently yes since battery loss was 80% and laptop was warm)
> 
> logs below
> 
> 2025-05-14T00:01:20 merlin root: >>>>>>>>>> suspend  #1 1747206080
> 
> 2025-05-14T00:01:21 merlin dbus-daemon[2846]: [system] Activating via systemd: service name='org.wicd.daemon' unit='dbus-org.wicd.daemon.service' requested by ':1.1130' (uid=0 pid=3357435 comm="/usr/bin/python3 /usr/share/wicd/daemon/suspend.py")
> 2025-05-14T00:01:21 merlin dbus-daemon[2846]: [system] Activation via systemd failed for unit 'dbus-org.wicd.daemon.service': Unit dbus-org.wicd.daemon.service not found.
> 2025-05-14T00:01:21 merlin kernel: [1388664.621668] PM: suspend entry (s2idle)
> 2025-05-14T00:01:21 merlin kernel: [1388664.625122] Filesystems sync: 0.003 seconds
> 2025-05-14T09:20:43 merlin kernel: [1388664.635518] Freezing user space processes
> 2025-05-14T09:20:43 merlin kernel: [1388664.638313] Freezing user space processes completed (elapsed 0.002 seconds)
> 2025-05-14T09:20:43 merlin kernel: [1388664.638320] OOM killer disabled.
> 2025-05-14T09:20:43 merlin kernel: [1388664.638322] Freezing remaining freezable tasks
> 2025-05-14T09:20:43 merlin kernel: [1388664.640285] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
> 2025-05-14T09:20:43 merlin kernel: [1388664.640290] printk: Suspending console(s) (use no_console_suspend to debug)
> (...)
> 2025-05-14T09:20:43 merlin kernel: [1422225.195325] OOM killer enabled.
> 2025-05-14T09:20:43 merlin kernel: [1422225.195328] Restarting tasks ... done.
> 2025-05-14T09:20:43 merlin kernel: [1422225.204356] vgaarb: client 0x00000000f7b9cd5c called 'target'
> 2025-05-14T09:20:43 merlin kernel: [1422225.204376] vgaarb: PCI:0000:00:02.0 ==> 0000:00:02.0 pdev 00000000dec5b5e7
> 2025-05-14T09:20:43 merlin kernel: [1422225.204383] vgaarb: vgadev 00000000dca48b8a
> 2025-05-14T09:20:43 merlin kernel: [1422225.321870] PM: suspend exit
> 
> Thanks,
> Marc
> -- 
> "A mouse is a device used to point at the xterm you want to type in" - A.S.R.
>  
> Home page: http://marc.merlins.org/                       | PGP 7F55D5F27AAF9D08
> 

-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/                       | PGP 7F55D5F27AAF9D08

