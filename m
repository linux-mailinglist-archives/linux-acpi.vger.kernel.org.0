Return-Path: <linux-acpi+bounces-21485-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GAgIKHXFqmnVWwEAu9opvQ
	(envelope-from <linux-acpi+bounces-21485-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Fri, 06 Mar 2026 13:15:49 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0268A2205A8
	for <lists+linux-acpi@lfdr.de>; Fri, 06 Mar 2026 13:15:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 165A930692D5
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Mar 2026 12:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2488738F223;
	Fri,  6 Mar 2026 12:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GyRhytLT"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E9238E5C9
	for <linux-acpi@vger.kernel.org>; Fri,  6 Mar 2026 12:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772799059; cv=none; b=b0HUSwY9+p19xpa4hw2Uekfao6lklEFAD8z/UMN9PaIBe3znf/i5c0BnGIEhesIRUP9vd+Y4CcvxSFOmDu6zhOzV5+VHuvzvZpLphnlrnTtSCwVOmD1pqeZMPCyu8H2J7BDkFr1GLujtVoSomRv4AMTR/zfDMBbiCKJINtGwRfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772799059; c=relaxed/simple;
	bh=elJWyHuTIBbvkV4AmlndDBecEMsoB6UmS3hXf/fnc2A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RWI8NAGRjyOeFNXXlJDvV+tTEyVLeO1y0v+CuBDzyVTcWN6yHsczcozSKP1lhYJsWJgppXReijJbEVZ8IP++ykWRD2oYacpT41XJ0netgs7M7qp0maXoaFxWJfCyVSyvmI9VnobhXBIxQ5fXAGKdmotXWwvtV2Zus87xmXxuomU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GyRhytLT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFA55C2BCAF
	for <linux-acpi@vger.kernel.org>; Fri,  6 Mar 2026 12:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772799058;
	bh=elJWyHuTIBbvkV4AmlndDBecEMsoB6UmS3hXf/fnc2A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=GyRhytLT0/B/oT4dvNvrPcfI2kLzEtb/1ASgSDbfSRVYeFh4T508m0TweGi3vLJEh
	 Qq5P12pfkfuKVNhBgk7Ml1lT5nYJDqy5g6HNYZ2DFveh7BqAijIN+QRegbn9k+M0am
	 teENDjN6g8jdmwUo/ilEyoKbepZ026XZQnbQpVCZDAWPfhYhdo8rWm9JPWGvS7lXeV
	 R/wo2DlPa4vdwqKTrkLxlNPXdDBwWylRILnJSx9JFvlKNWVF/h1CWvyG0tnKE0Mmz3
	 hjGP6Zm0kzVDMjFh2fY1GwUxkho16No69nie6XK9cF4hdtM4kelRJctO1M3+QfElTu
	 CpUxk3MPFaxTg==
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-409de4132b5so2913790fac.1
        for <linux-acpi@vger.kernel.org>; Fri, 06 Mar 2026 04:10:58 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWFneuqebw1toS9op54nNpUMQPYSjmYsnpEGNxEespqpByzax3BNEJ7SzskEhBh6vjKDe02ySiedKUX@vger.kernel.org
X-Gm-Message-State: AOJu0YwpkhLnxI7C+MbbVQIHqRvim/0ZN5wRej92eBKhpjmLAH7FRCxF
	ZpMEalsVPLBu3SrwkkjprtcMh5+AlLVE0GVqcdYzFid/IrtiSJ4E7aaBha6OSSi6aT1Kyy8I7Fa
	BGFzjPtMEodPnoPXF+gA2hjOrNnt51rs=
X-Received: by 2002:a05:6870:e992:b0:3f9:ff05:438 with SMTP id
 586e51a60fabf-416e3f895c5mr1088336fac.24.1772799057807; Fri, 06 Mar 2026
 04:10:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <007e3390-6b2b-457e-83c7-c794c5952018@amd.com>
In-Reply-To: <007e3390-6b2b-457e-83c7-c794c5952018@amd.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 6 Mar 2026 13:10:46 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jAsLURhTQf1VGgkzwVeHsDC0Zw4YMgjCTTqY=4pV6=ww@mail.gmail.com>
X-Gm-Features: AaiRm52C8M_Jb3ZZmjHD-Q-820HQSE493zrydekOG_1HRYjAsg8hzzrzqVRjBxI
Message-ID: <CAJZ5v0jAsLURhTQf1VGgkzwVeHsDC0Zw4YMgjCTTqY=4pV6=ww@mail.gmail.com>
Subject: Re: [REGRESSION] AMDISP failure with kernel v7.0-rc2 due to Commit: 02c057ddefef5
To: "Nirujogi, Pratap" <pnirujog@amd.com>
Cc: rafael@kernel.org, W_Armin@gmx.de, lenb@kernel.org, 
	Mario Limonciello <mario.limonciello@amd.com>, Bin Du <bin.du@amd.com>, benjamin.chan@amd.com, 
	king.li@amd.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 0268A2205A8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FREEMAIL_CC(0.00)[kernel.org,gmx.de,amd.com,vger.kernel.org,lists.linux.dev];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21485-lists,linux-acpi=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-acpi@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-acpi];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid,amd.com:email]
X-Rspamd-Action: no action

Hi,

On Fri, Mar 6, 2026 at 12:11=E2=80=AFAM Nirujogi, Pratap <pnirujog@amd.com>=
 wrote:
>
> Hi Rafael,
>
> In kernel version 7.0-rc2, the AMDISP device reports the following
> errors when created via mfd_add_hotplug_devices.
>
> [    5.236645] ACPI: video: Video Device [GFX0] (multi-head: yes  rom:
> no  post: no)
> [    5.236744] input: Video Bus as
> /devices/pci0000:00/0000:00:08.1/0000:c3:00.0/amd_isp_capture.1.auto/inpu=
t/input21
> [    5.236779] acpi device:14: Error installing notify handler
> [    5.236782] acpi device:15: Error installing notify handler
> [    5.236783] acpi device:16: Error installing notify handler
> [    5.236784] acpi device:17: Error installing notify handler
> [    5.236785] acpi device:18: Error installing notify handler
> [    5.236786] acpi device:19: Error installing notify handler
> [    5.236786] acpi device:1a: Error installing notify handler
> [    5.236787] acpi device:1b: Error installing notify handler
> [    5.236788] acpi device:1c: Error installing notify handler
>
> These failures indicate AMDISP device is incorrectly detected as ACPI
> Video device while it is not.

I think that this is because those devices share the ACPI companion
with their parent, which is the ACPI video bus device, and they are
also platform devices.

If they were, say, auxiliary devices, there wouldn't be a problem.

A check can be added to acpi_video_bus_probe() to avoid this, kind of
along the lines of Mario's patch, but please note that sharing an ACPI
companion between multiple devices of the same type on different
levels of device hierarchy is a slippery slope.

> The seems like a regression caused by the change that converts the ACPI
> video device to a platform device (commit: 02c057ddefef5).
>
> Issue is not observed in 6.19-rc6, and also when this change is reverted
> in 7.0-rc2.
>
> I really appreciate your inputs on addressing this issue and helping us
> make progress on 7.0 rc2.
>
> Steps followed to reproduce the issue:
>
> 1. Apply AMDISP v9 patch series [1] on top of kernel v7.0-rc2
> 2. Add NULL check for =E2=80=9Cdev->type=E2=80=9D in isp_genpd_add_device=
() [2] (to
> avoid kernel panic found in v7.0-rc2)
> 3. Build kernel with:
>      - CONFIG_AMD_ISP_PLATFORM=3Dy
>      - CONFIG_VIDEO_AMD_ISP4_CAPTURE=3Dm
> 4. Install kernel on AMDISP supported system (HP ZBook Ultra G1a)
> 5. Boot system to see the failures
>
> [1] https://lore.kernel.org/all/20260302073020.148277-1-Bin.Du@amd.com/
> [2]
> https://github.com/torvalds/linux/blob/master/drivers/gpu/drm/amd/amdgpu/=
isp_v4_1_1.c#L132
>
> Thanks,
> Pratap
>
>
>
>

