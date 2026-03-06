Return-Path: <linux-acpi+bounces-21496-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SBsNHOjYqmnmXgEAu9opvQ
	(envelope-from <linux-acpi+bounces-21496-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Fri, 06 Mar 2026 14:38:48 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 83C38221DA8
	for <lists+linux-acpi@lfdr.de>; Fri, 06 Mar 2026 14:38:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 13B77307E35A
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Mar 2026 13:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C845F39902C;
	Fri,  6 Mar 2026 13:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RkJTRTcn"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44E4396D26
	for <linux-acpi@vger.kernel.org>; Fri,  6 Mar 2026 13:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772803719; cv=none; b=ZjAOqLnk8YlflhrBf9GumgTnWghHzIVhx4fjhCpqtpyUlLvEvZP9qoos2RRI5KVHU0kCUE7jUD5OtpBDeUfjNnxOXyZPqxsbHaWsTjfWPoMullmklolSyDCwTro1B7Q+8MdTPpRwlc/d3SIBgZVScODCVBD8hjktbE1gAKvGtEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772803719; c=relaxed/simple;
	bh=t5MEZmHiOWv5PxQVBO0gx0iq3Ay3b0Mur5FWEPIyD5w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=doIWkBwgVf5oYJlUrOVMpSAXY0Xq+iXIERr4VJTCxx21BcD9H+Aktw1Md7At2sBEeu+pnycFhPprQgV2ceoE+vaercdl87hHQqO12lEhtG7aHCsrA359ams3u+NYYDj2mQ4j1tfdXIfwv+8ZoUaj6yMPm+6YgGccyqqC7BJ5H2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RkJTRTcn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86105C2BCAF
	for <linux-acpi@vger.kernel.org>; Fri,  6 Mar 2026 13:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772803719;
	bh=t5MEZmHiOWv5PxQVBO0gx0iq3Ay3b0Mur5FWEPIyD5w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=RkJTRTcn7+v+KofZk8+7mAdluhgzWikglWmrFbf0zFMuGgEE+eASLeeI3rQJhDml4
	 Qx90Zs9I+AyjAoGUE+SHiULputMu2Y5zMIFpaulur6UY4b50xHjwhITlxgMPfLZufW
	 vgQi65sUAvA5PwUEBJL9Z+SIDaho9SOplO9PTgrl2i74mY/7ZlcldGm+JUSuHb+b2A
	 OlM85Zv1cRh2fI8PBBJ5Wugco5jwOUsyL4DJE5g08MCZbyW/QzA/Hi63IckumR4vbA
	 Y4Jb1YEl6XO/KjO/z+rFS70MFdOuzT6Gc1mBDzCAxxOa/yEGJUW9GyL7lYVU7uw06C
	 +vz4ZbnRzM3xw==
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-4094b31a037so2834657fac.1
        for <linux-acpi@vger.kernel.org>; Fri, 06 Mar 2026 05:28:39 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXtaOCtMEkqBNdZPKejeiSIUF+XGJWzc5eRLsDpLKA9BV0rd4eCS9mJat6V9YMnTeSTD62Fu0up32lj@vger.kernel.org
X-Gm-Message-State: AOJu0YyXimadH4gmhevAzKBLJJUrKGKvy1GZT8RaJJR3flilR/sbp1ti
	ix6cKamDQpHsfXYoUeGFpfDuLfPWQUrzJvqqE0r4+eMBMAYSNMptkc9OppYZH3ClgHZ6XGGLVbM
	gwM4MrDofyWRjvrJS39EW7fKDUIe0bv8=
X-Received: by 2002:a05:6870:506b:b0:404:3569:59ef with SMTP id
 586e51a60fabf-416e4284629mr1177182fac.36.1772803718642; Fri, 06 Mar 2026
 05:28:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <007e3390-6b2b-457e-83c7-c794c5952018@amd.com> <23e8f0df-3eec-46e8-b5f1-5f417460e272@kernel.org>
 <CAJZ5v0gQK_OPyZGZDPC6WCbVtBuJKggk0Lrscmxxkq1GHiiVRQ@mail.gmail.com> <971fc64d-abef-448a-aa7d-7d4b3391f67e@kernel.org>
In-Reply-To: <971fc64d-abef-448a-aa7d-7d4b3391f67e@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 6 Mar 2026 14:28:25 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gWvtF2aUc8VhQUt6R7hb4xZ66rYaLx+aJhibig968rZQ@mail.gmail.com>
X-Gm-Features: AaiRm5215giZCeldrH7h2CgBvzOz5O7T1l92DAMiHY0Bp9Ssx_fPBUW-rCTmAS4
Message-ID: <CAJZ5v0gWvtF2aUc8VhQUt6R7hb4xZ66rYaLx+aJhibig968rZQ@mail.gmail.com>
Subject: Re: [REGRESSION] AMDISP failure with kernel v7.0-rc2 due to Commit: 02c057ddefef5
To: Mario Limonciello <superm1@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Nirujogi, Pratap" <pnirujog@amd.com>, W_Armin@gmx.de, lenb@kernel.org, 
	Bin Du <bin.du@amd.com>, benjamin.chan@amd.com, king.li@amd.com, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 83C38221DA8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FREEMAIL_CC(0.00)[kernel.org,amd.com,gmx.de,vger.kernel.org,lists.linux.dev];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21496-lists,linux-acpi=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-acpi@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-acpi];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Fri, Mar 6, 2026 at 1:45=E2=80=AFPM Mario Limonciello <superm1@kernel.or=
g> wrote:
>
>
>
> On 3/6/26 6:01 AM, Rafael J. Wysocki wrote:
> > On Fri, Mar 6, 2026 at 1:35=E2=80=AFAM Mario Limonciello (AMD) (kernel.=
org)
> > <superm1@kernel.org> wrote:
> >>
> >>
> >>
> >> On 3/5/2026 5:11 PM, Nirujogi, Pratap wrote:
> >>> Hi Rafael,
> >>>
> >>> In kernel version 7.0-rc2, the AMDISP device reports the following
> >>> errors when created via mfd_add_hotplug_devices.
> >>>
> >>> [    5.236645] ACPI: video: Video Device [GFX0] (multi-head: yes  rom=
:
> >>> no  post: no)
> >>> [    5.236744] input: Video Bus as /devices/
> >>> pci0000:00/0000:00:08.1/0000:c3:00.0/amd_isp_capture.1.auto/input/inp=
ut21
> >>> [    5.236779] acpi device:14: Error installing notify handler
> >>> [    5.236782] acpi device:15: Error installing notify handler
> >>> [    5.236783] acpi device:16: Error installing notify handler
> >>> [    5.236784] acpi device:17: Error installing notify handler
> >>> [    5.236785] acpi device:18: Error installing notify handler
> >>> [    5.236786] acpi device:19: Error installing notify handler
> >>> [    5.236786] acpi device:1a: Error installing notify handler
> >>> [    5.236787] acpi device:1b: Error installing notify handler
> >>> [    5.236788] acpi device:1c: Error installing notify handler
> >>>
> >>> These failures indicate AMDISP device is incorrectly detected as ACPI
> >>> Video device while it is not.
> >>>
> >>> The seems like a regression caused by the change that converts the AC=
PI
> >>> video device to a platform device (commit: 02c057ddefef5).
> >>>
> >>> Issue is not observed in 6.19-rc6, and also when this change is rever=
ted
> >>> in 7.0-rc2.
> >>>
> >>> I really appreciate your inputs on addressing this issue and helping =
us
> >>> make progress on 7.0 rc2.
> >>>
> >>> Steps followed to reproduce the issue:
> >>>
> >>> 1. Apply AMDISP v9 patch series [1] on top of kernel v7.0-rc2
> >>> 2. Add NULL check for =E2=80=9Cdev->type=E2=80=9D in isp_genpd_add_de=
vice() [2] (to
> >>> avoid kernel panic found in v7.0-rc2)
> >>> 3. Build kernel with:
> >>>       - CONFIG_AMD_ISP_PLATFORM=3Dy
> >>>       - CONFIG_VIDEO_AMD_ISP4_CAPTURE=3Dm
> >>> 4. Install kernel on AMDISP supported system (HP ZBook Ultra G1a)
> >>> 5. Boot system to see the failures
> >>>
> >>> [1] https://lore.kernel.org/all/20260302073020.148277-1-Bin.Du@amd.co=
m/
> >>> [2] https://github.com/torvalds/linux/blob/master/drivers/gpu/drm/amd=
/
> >>> amdgpu/isp_v4_1_1.c#L132
> >>>
> >>> Thanks,
> >>> Pratap
> >>>
> >>>
> >>>
> >>
> >> It's a bit weird to see it even probe in this path in the first place.
> >> acpi_video_bus_probe() getting called with the mfd device doesn't seem
> >> right to me.
> >>
> >> I wonder if it's because ISP is an MFD device of GPU (and thus LNXVIDE=
O
> >> ends up matching).
> >>
> >> Would a sensible solution be to reject mfd device types in
> >> acpi_video_bus_probe()?
> >
> > Every platform device with LNXVIDEO in the device ID list will be
> > matched and so probed.
> >
> > I'm wondering how those devices get that ID though.
>
> Yeah me too.  I was surprised an MFD device got it.
>
> Pratap - can you figure this out before we go too far in this path?
>
> If they really shouldn't have LNXVIDEO fixing that may be a better soluti=
on.

The current theory is that they share the ACPI companion with the
"right" ACPI video bus device.  If that is confirmed (for example, by
testing the patch posted by me earlier), I will be wondering why they
do so.

If the ACPI companion sharing is necessary for some reason, maybe
changing the type of the other devices to something like auxiliary
devices can be considered.

> >
> > Also, is this really a mainline regression?  AMDISP patches are not in
> > the mainline, no?
>
> The amdgpu half of it is mainline, the other half is still on the lists.

Well, I mean the other part seems to be necessary to reproduce the error.

Also please note that this error is just a bit noisy, but it actually
means that the probe has failed which is what we want.

