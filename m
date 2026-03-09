Return-Path: <linux-acpi+bounces-21534-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8BOIAD23rmnMIAIAu9opvQ
	(envelope-from <linux-acpi+bounces-21534-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Mon, 09 Mar 2026 13:04:13 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F38223864F
	for <lists+linux-acpi@lfdr.de>; Mon, 09 Mar 2026 13:04:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BF205302C5CD
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Mar 2026 11:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91A2D3A6EEA;
	Mon,  9 Mar 2026 11:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WBT5m1gM"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8653A5E92
	for <linux-acpi@vger.kernel.org>; Mon,  9 Mar 2026 11:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773057498; cv=none; b=FrLhFjdqgz4Qf5k438upe2582wEQq3Rg5XyYkVWSlANhtlcNSO1wWB0OVyV+J+CH+tsIYN5d9LNXQkiolhTz+0LfHkDTWA40o8/HV84LmSCJyb/GF24owx64aj+bM1ff/EZHwkSqOv1toOVziT9KFu2xNNPkfr2wO1vOrtZldRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773057498; c=relaxed/simple;
	bh=2gI7Yjc5NAvinWUylak3mIquzVHXb1csOEJHFOpP6qI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mEYSwAmpzXyRS0R2xXGGA9rZlVd+/IH7c1Wu+wa2cNV0FFOSHEMWTCDBYw6BqLeQjzknzMbm6wXnEciaNGazEFs2kjtxPWfoiu45PW+OxOG4ToxjaLiLnEb1CA+kfKypHf50ZrFhQOP/oNZ3wOlYcopd+h2FE+p6+FjfgkCb9Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WBT5m1gM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 368F2C2BCB2
	for <linux-acpi@vger.kernel.org>; Mon,  9 Mar 2026 11:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773057498;
	bh=2gI7Yjc5NAvinWUylak3mIquzVHXb1csOEJHFOpP6qI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=WBT5m1gMEJLrTxF+4rQ1z4cVP5+qoLQD7IxK2PBbQ7vk6Zz0UirR8mMeV2+dGQsqR
	 OpMqLgA+F3y4DV5YY+5o9ctlTqzyeUzbg/gzPcZC6ugKqb76SwNg0mOk9AHsxHrHoD
	 kuqYzU4uGIH7BcZazZxnqDbFYkRHsUgSWSAGLANPscxglQ9Rf75P8F0W97HGgz5D+0
	 yODivjrofGn2AoOa2NZMYmusZWpx8ZHeEFS7Xvwhn+xqG7oO5IJmnyc+r4IibKyfbv
	 Lvn6SUxqlUdHneUVyVBtvI3wHlLAaEuTk4kt6xJnhTk6+wIxeeGjikqBvNfNsPY8Tq
	 IAkaQtaYVxOQQ==
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-463a0e14abfso8404838b6e.2
        for <linux-acpi@vger.kernel.org>; Mon, 09 Mar 2026 04:58:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU2qM/giEGCm8CY1FwSItJMUGpLI066FFQsLQOuOH7kQH8gUjZTGO0sOh3JO/lHR6bDhXKrtz1rwufZ@vger.kernel.org
X-Gm-Message-State: AOJu0YzQK/IyEqTCTCYFt8rxu+YQwkzwnYOQVEaBGFA/JYLhuVs+Tvs4
	IcTXA8MZFp089jQw+AzN32XKfaDtbbuPs9TroyNREjgDNQFe3FdwpDBK8E7yBeDlWhNejObHQ+w
	nNSzq/isGXcpTazRxAc1Lq+dre5nI6NM=
X-Received: by 2002:a05:6808:3025:b0:45e:d827:2d73 with SMTP id
 5614622812f47-466dca38648mr6205531b6e.16.1773057497220; Mon, 09 Mar 2026
 04:58:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <007e3390-6b2b-457e-83c7-c794c5952018@amd.com> <23e8f0df-3eec-46e8-b5f1-5f417460e272@kernel.org>
 <CAJZ5v0gQK_OPyZGZDPC6WCbVtBuJKggk0Lrscmxxkq1GHiiVRQ@mail.gmail.com>
 <971fc64d-abef-448a-aa7d-7d4b3391f67e@kernel.org> <44b0ec66-59d0-4c73-807a-790817f22409@amd.com>
 <20cf0dc1-f1da-464b-9700-e2ce30e438e7@amd.com>
In-Reply-To: <20cf0dc1-f1da-464b-9700-e2ce30e438e7@amd.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 9 Mar 2026 12:58:04 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0iNdTFExoupRmwJmdykdRJa1QUJXzsb+j4M1cpn1qALig@mail.gmail.com>
X-Gm-Features: AaiRm50iawWOuCu7hmav7E_lB9A1F0LE9lRU-OUy93uItjEVmUhDVKDI8mSanAk
Message-ID: <CAJZ5v0iNdTFExoupRmwJmdykdRJa1QUJXzsb+j4M1cpn1qALig@mail.gmail.com>
Subject: Re: [REGRESSION] AMDISP failure with kernel v7.0-rc2 due to Commit: 02c057ddefef5
To: "Du, Bin" <bin.du@amd.com>
Cc: "Nirujogi, Pratap" <pnirujog@amd.com>, Mario Limonciello <superm1@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, W_Armin@gmx.de, lenb@kernel.org, benjamin.chan@amd.com, 
	king.li@amd.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 4F38223864F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FREEMAIL_CC(0.00)[amd.com,kernel.org,gmx.de,vger.kernel.org,lists.linux.dev];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21534-lists,linux-acpi=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-acpi@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.982];
	TAGGED_RCPT(0.00)[linux-acpi];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,amd.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Mon, Mar 9, 2026 at 9:11=E2=80=AFAM Du, Bin <bin.du@amd.com> wrote:
>
>
>
> On 3/9/2026 11:52 AM, Nirujogi, Pratap wrote:
> >
> >
> > On 3/6/2026 7:45 AM, Mario Limonciello wrote:
> >> Caution: This message originated from an External Source. Use proper
> >> caution when opening attachments, clicking links, or responding.
> >>
> >>
> >> On 3/6/26 6:01 AM, Rafael J. Wysocki wrote:
> >>> On Fri, Mar 6, 2026 at 1:35=E2=80=AFAM Mario Limonciello (AMD) (kerne=
l.org)
> >>> <superm1@kernel.org> wrote:
> >>>>
> >>>>
> >>>>
> >>>> On 3/5/2026 5:11 PM, Nirujogi, Pratap wrote:
> >>>>> Hi Rafael,
> >>>>>
> >>>>> In kernel version 7.0-rc2, the AMDISP device reports the following
> >>>>> errors when created via mfd_add_hotplug_devices.
> >>>>>
> >>>>> [    5.236645] ACPI: video: Video Device [GFX0] (multi-head: yes  r=
om:
> >>>>> no  post: no)
> >>>>> [    5.236744] input: Video Bus as /devices/
> >>>>> pci0000:00/0000:00:08.1/0000:c3:00.0/amd_isp_capture.1.auto/input/
> >>>>> input21
> >>>>> [    5.236779] acpi device:14: Error installing notify handler
> >>>>> [    5.236782] acpi device:15: Error installing notify handler
> >>>>> [    5.236783] acpi device:16: Error installing notify handler
> >>>>> [    5.236784] acpi device:17: Error installing notify handler
> >>>>> [    5.236785] acpi device:18: Error installing notify handler
> >>>>> [    5.236786] acpi device:19: Error installing notify handler
> >>>>> [    5.236786] acpi device:1a: Error installing notify handler
> >>>>> [    5.236787] acpi device:1b: Error installing notify handler
> >>>>> [    5.236788] acpi device:1c: Error installing notify handler
> >>>>>
> >>>>> These failures indicate AMDISP device is incorrectly detected as AC=
PI
> >>>>> Video device while it is not.
> >>>>>
> >>>>> The seems like a regression caused by the change that converts the
> >>>>> ACPI
> >>>>> video device to a platform device (commit: 02c057ddefef5).
> >>>>>
> >>>>> Issue is not observed in 6.19-rc6, and also when this change is
> >>>>> reverted
> >>>>> in 7.0-rc2.
> >>>>>
> >>>>> I really appreciate your inputs on addressing this issue and
> >>>>> helping us
> >>>>> make progress on 7.0 rc2.
> >>>>>
> >>>>> Steps followed to reproduce the issue:
> >>>>>
> >>>>> 1. Apply AMDISP v9 patch series [1] on top of kernel v7.0-rc2
> >>>>> 2. Add NULL check for =E2=80=9Cdev->type=E2=80=9D in isp_genpd_add_=
device() [2] (to
> >>>>> avoid kernel panic found in v7.0-rc2)
> >>>>> 3. Build kernel with:
> >>>>>       - CONFIG_AMD_ISP_PLATFORM=3Dy
> >>>>>       - CONFIG_VIDEO_AMD_ISP4_CAPTURE=3Dm
> >>>>> 4. Install kernel on AMDISP supported system (HP ZBook Ultra G1a)
> >>>>> 5. Boot system to see the failures
> >>>>>
> >>>>> [1] https://lore.kernel.org/all/20260302073020.148277-1-
> >>>>> Bin.Du@amd.com/
> >>>>> [2] https://github.com/torvalds/linux/blob/master/drivers/gpu/drm/a=
md/
> >>>>> amdgpu/isp_v4_1_1.c#L132
> >>>>>
> >>>>> Thanks,
> >>>>> Pratap
> >>>>>
> >>>>>
> >>>>>
> >>>>
> >>>> It's a bit weird to see it even probe in this path in the first plac=
e.
> >>>> acpi_video_bus_probe() getting called with the mfd device doesn't se=
em
> >>>> right to me.
> >>>>
> >>>> I wonder if it's because ISP is an MFD device of GPU (and thus LNXVI=
DEO
> >>>> ends up matching).
> >>>>
> >>>> Would a sensible solution be to reject mfd device types in
> >>>> acpi_video_bus_probe()?
> >>>
> >>> Every platform device with LNXVIDEO in the device ID list will be
> >>> matched and so probed.
> >>>
> >>> I'm wondering how those devices get that ID though.
> >>
> >> Yeah me too.  I was surprised an MFD device got it.
> >>
> >> Pratap - can you figure this out before we go too far in this path?
> >>
> > yes, MFD child devices in this case have the device ID as that of paren=
t
> > (GPU) i.e. LNXVIDEO. Its because when no acpi_match is specified, the
> > MFD child devices are inheriting the parent's ACPI companion device and
> > this is resulting in having the same parent's ACPI device ID.
> >
> > device_set_node(&pdev->dev, acpi_fwnode_handle(adev ?: parent));
> > https://github.com/torvalds/linux/blob/master/drivers/mfd/mfd-core.c#L9=
1
> >
> >> If they really shouldn't have LNXVIDEO fixing that may be a better
> >> solution.
> >>
> > AMD ISP related MFD devices are using the same LNXVIDEO device ID even
> > on 6.19-rc4, no issues observed earlier. I can confirm automatic AMD IS=
P
> > device probe works and also camera works on 7.0-rc2 if I avoid
> > inheriting ACPI companion of the parent (GPU) in the mfd-core.c
> >
> > // device_set_node(&pdev->dev, acpi_fwnode_handle(adev ?: parent));
> > https://github.com/torvalds/linux/blob/master/drivers/mfd/mfd-core.c#L9=
1
> >
> > But why this is an issue on 7.0-rc2 while it works on 6.19-rc4 needs to
> > be root caused.
> >
>
> Possible cause may be.
> 1. On 6.x (without commit 02c057ddefef5), the ACPI video driver was
> registered as an acpi_driver (static struct acpi_driver acpi_video_bus)
> ,  it lives on the ACPI bus (acpi_bus_type). It only binds to struct
> acpi_device objects in the ACPI namespace. MFD children of GFX
> (amd_isp_capture, amd_isp_i2c_designware, amdisp-pinctrl) are platform
> devices on the platform bus, they are completely invisible to
> acpi_driver, so there is no chance of the ACPI video driver matching an
> MFD child.
> 2. On 7.0 (with commit 02c057ddefef5), the ACPI video driver was
> converted to a platform_driver (static struct platform_driver
> acpi_video_bus), it lives on the platform bus. When the kernel registers
> a new platform device, it checks ALL registered platform drivers to see
> if any match. The matching logic for acpi_match_table works like this:
> - Get the platform device's ACPI companion (ACPI_COMPANION(dev))
> - Check if the companion's HID/CID matches any entry in acpi_match_table
> - If yes, the driver probes the device

It does, but then the probe fails.  This is the problem that has been
reported to start with.

> amd_isp_capture, amd_isp_i2c_designware, and amdisp-pinctrl are MFD
> children of GFX and inherit their parent's ACPI companion, which uses
> the HID "LNXVIDEO". As a result, all these components will match with
> the ACPI video driver. Consequently, this issue impacts not only
> amd_isp_capture but also the upstreamed driver amd_isp_i2c_designware
> (located in drivers/i2c/busses/i2c-designware-amdisp.c under the
> I2C_DESIGNWARE_AMDISP config) and amdisp-pinctrl (found in
> drivers/pinctrl/pinctrl-amdisp.c under the PINCTRL_AMDISP config).

Why is inheriting the parent's ACPI node regarded as a good idea?

