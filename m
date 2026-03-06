Return-Path: <linux-acpi+bounces-21484-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SCE3AELCqmlXWQEAu9opvQ
	(envelope-from <linux-acpi+bounces-21484-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Fri, 06 Mar 2026 13:02:10 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BDC8220039
	for <lists+linux-acpi@lfdr.de>; Fri, 06 Mar 2026 13:02:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D1DC43014C4A
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Mar 2026 12:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C40638910E;
	Fri,  6 Mar 2026 12:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q4RSgsYa"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0969E3815E4
	for <linux-acpi@vger.kernel.org>; Fri,  6 Mar 2026 12:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772798527; cv=none; b=hkcqAinZwQIKNXTuUJ6NcxSD6wih3uuRdC4fPhXjeQqUa+KpDudFPnn/pOChWZb2OdNDWZliEuaUKlXJAnuM7Yked5bClXeLOxWHcgIk6NRmIh/rwOXE1WRmN9zZNKogd0GluI2vtOuMjdRV+wodBdgFlE3GxAemzijWxpz+gmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772798527; c=relaxed/simple;
	bh=rnPqsCNGT1fnERziYPsvdsT/xcaik+k+N10KDnWIvE8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=caozpJqmfzVQNgIVr3ftJQOXXrP889LrIDKs1e6nX3SGpKheTjud1Aqa6bcX7KRcJAAJBmpxyzaXX/ubIBPbrIfAlD7riNzvO43iwu6CP6PMUk2KMi4F/f4f6MCmClHPsJmTdDpbohjD9W98pBMMkOlzengveIU1vmrgmHsRuIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q4RSgsYa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF410C2BC87
	for <linux-acpi@vger.kernel.org>; Fri,  6 Mar 2026 12:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772798526;
	bh=rnPqsCNGT1fnERziYPsvdsT/xcaik+k+N10KDnWIvE8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=q4RSgsYaNIZQaTiB0T1t9yve1FaCWCBjnTLcewbCHtcURYlvcAJCo8TjSRurNT9/M
	 h3S2eRGLvPu+S0/nmde81nEqpZjuCSFFXngaxUZI3BxOXvTFJNStnOm4WGmSyb7d8s
	 Fo/g+QWLJpmqVumErM76YtArZgypY9491dSpXbY4y7b8gxhn2PHW1g7faDHmE2UmIP
	 Sk3ns7Wj8HImn+o8WM2ZQ4a/O0T0e7BaegizTnPjrYCR/clF8O/3ZCUweby7EYTYmh
	 MPuFSigZZwajEkQOjz5gCiz8xdXPalCxcrEJVRDQJN6yhHNQJic9EOsS2EuRawwR2j
	 D425eLhxLId4A==
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-40ee9b945d5so2666657fac.0
        for <linux-acpi@vger.kernel.org>; Fri, 06 Mar 2026 04:02:06 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV4OHLhqbHpToduUmyOXROHVyhctAiTgxf02DTQO7Cf4FCVd6h9S15PHVn8IPzFIdpo69LV9kBA+W3D@vger.kernel.org
X-Gm-Message-State: AOJu0YzyUryGVr2I6CrCWVnqhU1W5deEkiihBED1gNVuHL+0jpW+8CWm
	87cu1l4s8yLiGzwWOeZrq767NtwZ80q6bdKrBVETcs0gp1VVeMEV6jbByQxNjeIZvFXV2SO/iqF
	uKC0lbbLckpe8xEhJAYFPTKLqOjKgHqg=
X-Received: by 2002:a05:6870:e18f:b0:40e:a746:1f6f with SMTP id
 586e51a60fabf-416e4084167mr1151131fac.28.1772798525872; Fri, 06 Mar 2026
 04:02:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <007e3390-6b2b-457e-83c7-c794c5952018@amd.com> <23e8f0df-3eec-46e8-b5f1-5f417460e272@kernel.org>
In-Reply-To: <23e8f0df-3eec-46e8-b5f1-5f417460e272@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 6 Mar 2026 13:01:54 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gQK_OPyZGZDPC6WCbVtBuJKggk0Lrscmxxkq1GHiiVRQ@mail.gmail.com>
X-Gm-Features: AaiRm51cpoQT3DB-H36raF0RWiM4-U7Ze_2IvkEziwDtZ9iZd7MlRua1wnkgjIw
Message-ID: <CAJZ5v0gQK_OPyZGZDPC6WCbVtBuJKggk0Lrscmxxkq1GHiiVRQ@mail.gmail.com>
Subject: Re: [REGRESSION] AMDISP failure with kernel v7.0-rc2 due to Commit: 02c057ddefef5
To: "Mario Limonciello (AMD) (kernel.org)" <superm1@kernel.org>
Cc: "Nirujogi, Pratap" <pnirujog@amd.com>, rafael@kernel.org, W_Armin@gmx.de, lenb@kernel.org, 
	Bin Du <bin.du@amd.com>, benjamin.chan@amd.com, king.li@amd.com, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 5BDC8220039
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21484-lists,linux-acpi=lfdr.de];
	FREEMAIL_CC(0.00)[amd.com,kernel.org,gmx.de,vger.kernel.org,lists.linux.dev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-acpi@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-acpi];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Fri, Mar 6, 2026 at 1:35=E2=80=AFAM Mario Limonciello (AMD) (kernel.org)
<superm1@kernel.org> wrote:
>
>
>
> On 3/5/2026 5:11 PM, Nirujogi, Pratap wrote:
> > Hi Rafael,
> >
> > In kernel version 7.0-rc2, the AMDISP device reports the following
> > errors when created via mfd_add_hotplug_devices.
> >
> > [    5.236645] ACPI: video: Video Device [GFX0] (multi-head: yes  rom:
> > no  post: no)
> > [    5.236744] input: Video Bus as /devices/
> > pci0000:00/0000:00:08.1/0000:c3:00.0/amd_isp_capture.1.auto/input/input=
21
> > [    5.236779] acpi device:14: Error installing notify handler
> > [    5.236782] acpi device:15: Error installing notify handler
> > [    5.236783] acpi device:16: Error installing notify handler
> > [    5.236784] acpi device:17: Error installing notify handler
> > [    5.236785] acpi device:18: Error installing notify handler
> > [    5.236786] acpi device:19: Error installing notify handler
> > [    5.236786] acpi device:1a: Error installing notify handler
> > [    5.236787] acpi device:1b: Error installing notify handler
> > [    5.236788] acpi device:1c: Error installing notify handler
> >
> > These failures indicate AMDISP device is incorrectly detected as ACPI
> > Video device while it is not.
> >
> > The seems like a regression caused by the change that converts the ACPI
> > video device to a platform device (commit: 02c057ddefef5).
> >
> > Issue is not observed in 6.19-rc6, and also when this change is reverte=
d
> > in 7.0-rc2.
> >
> > I really appreciate your inputs on addressing this issue and helping us
> > make progress on 7.0 rc2.
> >
> > Steps followed to reproduce the issue:
> >
> > 1. Apply AMDISP v9 patch series [1] on top of kernel v7.0-rc2
> > 2. Add NULL check for =E2=80=9Cdev->type=E2=80=9D in isp_genpd_add_devi=
ce() [2] (to
> > avoid kernel panic found in v7.0-rc2)
> > 3. Build kernel with:
> >      - CONFIG_AMD_ISP_PLATFORM=3Dy
> >      - CONFIG_VIDEO_AMD_ISP4_CAPTURE=3Dm
> > 4. Install kernel on AMDISP supported system (HP ZBook Ultra G1a)
> > 5. Boot system to see the failures
> >
> > [1] https://lore.kernel.org/all/20260302073020.148277-1-Bin.Du@amd.com/
> > [2] https://github.com/torvalds/linux/blob/master/drivers/gpu/drm/amd/
> > amdgpu/isp_v4_1_1.c#L132
> >
> > Thanks,
> > Pratap
> >
> >
> >
>
> It's a bit weird to see it even probe in this path in the first place.
> acpi_video_bus_probe() getting called with the mfd device doesn't seem
> right to me.
>
> I wonder if it's because ISP is an MFD device of GPU (and thus LNXVIDEO
> ends up matching).
>
> Would a sensible solution be to reject mfd device types in
> acpi_video_bus_probe()?

Every platform device with LNXVIDEO in the device ID list will be
matched and so probed.

I'm wondering how those devices get that ID though.

Also, is this really a mainline regression?  AMDISP patches are not in
the mainline, no?

