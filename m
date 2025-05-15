Return-Path: <linux-acpi+bounces-13723-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 751B5AB7F1C
	for <lists+linux-acpi@lfdr.de>; Thu, 15 May 2025 09:45:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA61A867D4D
	for <lists+linux-acpi@lfdr.de>; Thu, 15 May 2025 07:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC3C817BD9;
	Thu, 15 May 2025 07:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=merlins.org header.i=@merlins.org header.b="WO27/P+V"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCAE34B1E51
	for <linux-acpi@vger.kernel.org>; Thu, 15 May 2025 07:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.81.13.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747295133; cv=none; b=grv8bm5Gt9kq/W5P/WOIT4E/4METd9nTqRKcxknZYHvxwkcRDnKXu1cNaVBju5bfSeK2dH6eumUpIpeTzOa8RCRoCqoanctsAHz9uJ31p8lBMDDz0jebQfRa7zWIGD5VDsYF+q9OYCpfskEXa7XSVjqUqW67eKKJe/IUCyzDQro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747295133; c=relaxed/simple;
	bh=+0N+Av5yTMFHY8wUzS7jXOFBYRDuZCmOe50Yz5iE2sQ=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=etGQGOcAytJ1ow83kCmpYUhvOeZ/1uu3QdchVsK1DH1gUMt8GUQAMUI4Bv1672M6z45EzPIDmv63f2HkTyBlk94xC8OCZoxM1QHKlDHJKICJFMuFRgZmZonFHWIPTfYMLLkvrN9Rjb3/wFsOiljqj0V/Fs3gJmsyGb/64zHJDtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=merlins.org; spf=pass smtp.mailfrom=merlins.org; dkim=fail (0-bit key) header.d=merlins.org header.i=@merlins.org header.b=WO27/P+V reason="key not found in DNS"; arc=none smtp.client-ip=209.81.13.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=merlins.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=merlins.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=merlins.org
	; s=key; h=Content-Type:MIME-Version:Message-ID:Subject:To:From:Date:Sender:
	Reply-To:Cc:Content-Transfer-Encoding:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=hSDmePh2cSLIdmVqCv3Jyeui8nECbX9UfUAS7kzyWjE=; b=WO27/P+VkpdwQcb8xLEK5mvMXC
	Att0b/c8Vq/3/gARuFtzhgn82SRvsX3wZTdXC4fo2eFaAhBmnGA98iWDV8tKL+idw4YjKXdCghYGp
	ifkGsK6ih3Fdw/+cpyGJfv+NBWCXF2mI5+MOHYizUTLbzqzNfsEFEsH5m9wDtQPDK1j8h/js2T1TK
	ifvH743UFRCEa2JhHKYPcUABqM09VodHR48b9JEZXWc/iSKUvyandM7EZ7dctj7tw5gQsAiM2pxLk
	NIpo5PTdLnb0+nxp9sC+E0yfhgpv8xojhsZsOrq9gcvOryOzBuF4S4zeVNLrf8qAA2mKsmYoUaJKd
	eMRAVYfQ==;
Received: from [172.56.208.45] (port=24821 helo=merlin.svh.merlins.org)
	by mail1.merlins.org with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.94.2 #2)
	id 1uFRm6-0003cL-87 by authid <merlins.org> with srv_auth_plain; Thu, 15 May 2025 00:45:30 -0700
Received: from merlin by merlin.svh.merlins.org with local (Exim 4.96)
	(envelope-from <marc@merlins.org>)
	id 1uFTHP-000Coo-1S;
	Thu, 15 May 2025 00:45:23 -0700
Date: Thu, 15 May 2025 00:45:23 -0700
From: Marc MERLIN <marc@merlins.org>
To: linux-acpi@vger.kernel.org
Subject: s2idle on kdell xps 9730 does go to sleep but laptop is warm
Message-ID: <aCWbk4z50QYym9gV@merlins.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SA-Exim-Connect-IP: 172.56.208.45
X-SA-Exim-Mail-From: marc@merlins.org

and burn a lot of battery during full kernel sleep
Reply-To: 
X-Sysadmin: BOFH
X-URL: http://marc.merlins.org/

 With kernel 6.6.9 when I put the laptop to sleep, syslog shows that the
 laptop was sleeping for 9h, fans were stopped, but when I gabbed my
 laptop it was warm and burned 80% of the battery overnight.

And yet, linux was not running, my logs show the kernel went into ACPI
sleep and back out

Logs show the system slept for 9h and went to sleep with s2idle.

Is it the wrong sleep outside of suspend to disk and full shutdown?

Are there devices that should have been powered off but didn't
(evidently yes since battery loss was 80% and laptop was warm)

logs below

2025-05-14T00:01:20 merlin root: >>>>>>>>>> suspend  #1 1747206080

2025-05-14T00:01:21 merlin dbus-daemon[2846]: [system] Activating via systemd: service name='org.wicd.daemon' unit='dbus-org.wicd.daemon.service' requested by ':1.1130' (uid=0 pid=3357435 comm="/usr/bin/python3 /usr/share/wicd/daemon/suspend.py")
2025-05-14T00:01:21 merlin dbus-daemon[2846]: [system] Activation via systemd failed for unit 'dbus-org.wicd.daemon.service': Unit dbus-org.wicd.daemon.service not found.
2025-05-14T00:01:21 merlin kernel: [1388664.621668] PM: suspend entry (s2idle)
2025-05-14T00:01:21 merlin kernel: [1388664.625122] Filesystems sync: 0.003 seconds
2025-05-14T09:20:43 merlin kernel: [1388664.635518] Freezing user space processes
2025-05-14T09:20:43 merlin kernel: [1388664.638313] Freezing user space processes completed (elapsed 0.002 seconds)
2025-05-14T09:20:43 merlin kernel: [1388664.638320] OOM killer disabled.
2025-05-14T09:20:43 merlin kernel: [1388664.638322] Freezing remaining freezable tasks
2025-05-14T09:20:43 merlin kernel: [1388664.640285] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
2025-05-14T09:20:43 merlin kernel: [1388664.640290] printk: Suspending console(s) (use no_console_suspend to debug)
(...)
2025-05-14T09:20:43 merlin kernel: [1422225.195325] OOM killer enabled.
2025-05-14T09:20:43 merlin kernel: [1422225.195328] Restarting tasks ... done.
2025-05-14T09:20:43 merlin kernel: [1422225.204356] vgaarb: client 0x00000000f7b9cd5c called 'target'
2025-05-14T09:20:43 merlin kernel: [1422225.204376] vgaarb: PCI:0000:00:02.0 ==> 0000:00:02.0 pdev 00000000dec5b5e7
2025-05-14T09:20:43 merlin kernel: [1422225.204383] vgaarb: vgadev 00000000dca48b8a
2025-05-14T09:20:43 merlin kernel: [1422225.321870] PM: suspend exit

Thanks,
Marc
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/                       | PGP 7F55D5F27AAF9D08

