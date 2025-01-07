Return-Path: <linux-acpi+bounces-10418-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B66C9A048E3
	for <lists+linux-acpi@lfdr.de>; Tue,  7 Jan 2025 19:06:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F777160B01
	for <lists+linux-acpi@lfdr.de>; Tue,  7 Jan 2025 18:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1887B49652;
	Tue,  7 Jan 2025 18:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wi6O8IlN"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39F553AC;
	Tue,  7 Jan 2025 18:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736273206; cv=none; b=mTKHc4Nsz0IM9bcKr26Td7idlKlqTDuxrqVD2Wo0X8M6dit+dG7WJ0tuYOPExSifopEYldNkfw7JS9J7R8jxdE10uMkolZVyUj+nEJxVjY3fNiTXmMT2d9SDHap29aJAE4nqISRsnBM7wl7dU9/0skD503mXurdvWdtgzdQEW9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736273206; c=relaxed/simple;
	bh=qH3iaPc3xYhUIjEj3FoNIbTteiXJFoRC28nJ8gnXI1c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hJWv2hcRDQ5CSWXwXn5NxtGTMlWrqzdCbQ7ERzmV7Q4OB3U/NX4QI34PhpfrjteJXp2MBX+5qb9IkQVXaMDvBlbPSvwaZ1wWAAx370Njmn3uoTmcz4YqRW6+E9aprx97YT9roiZTLgfC3sNDLy7Ywkeuhu+31wcxfWsoc0zkAsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wi6O8IlN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5A61C4CED6;
	Tue,  7 Jan 2025 18:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736273205;
	bh=qH3iaPc3xYhUIjEj3FoNIbTteiXJFoRC28nJ8gnXI1c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Wi6O8IlNYQeCFyJktjQZVYtTtJxXTTxBB3LXil5RqleDoI72sHzpKceDQfDTHIDnf
	 0mMAzT6ndgjSBRxkKMLWU+8DTiivsF+sFGcItW8aSd2MpIfgv0eYtqOJ+XoumSCPSV
	 UYWQb4lDIGOpfhxJl+tCNNGgR1GbLBXk6b6B/16biLFmfHYkp75im+q05Alibb1bk5
	 xmbj0lf1iFP54QI3ado2fjm5mZxCsVoD+0MBBKDBXDIKQVMeJVkQOlUFbzQ6RA9Iij
	 5xl58bYrqzI0V1HgjTWBmiFR2BGpufg5ahZ1kPidvwG9oa3+xxTmEJDBgjxGRK8IWh
	 oLcsf+O9Cd0NQ==
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3ebc678b5c9so8679290b6e.3;
        Tue, 07 Jan 2025 10:06:45 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUDPbt/XPzmDxSFyWifkeXsqaQLBhGTxBIN/r5CiMUAFIHOUJ6jFIaJrqNl4DARPeYwJmmVpNP3qgglYF5F@vger.kernel.org, AJvYcCXr6pZaHacXtu8yjfTSln4QtIRit5MZ5RLiLA/eBmF3bQ1DEC2Bexcm0PMT5m2ApHV3of5riH2OjHUS@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8uGOeViKdqF851Sw5bCQgYuRPKyRWkeIhDYLHo0xFX8EL/BbO
	JYGkV96DKKGb3H5bhzmfZN6TukMn6+t+SP5/VFVoR04ORk7/9Y201JzomMEi9qDG4H6DDyrkXpE
	a4fa8YmeufdfAaSzDSaWyDTYOp7Y=
X-Google-Smtp-Source: AGHT+IG1NHJhEJz1E0ET76oxQrww1eXON879XyPLOolOWfKwB31uUDyaOy8XXeIOxtzd5NgCo8HnCddLN+jryBZWSsw=
X-Received: by 2002:a05:6871:5e10:b0:29e:32f2:cd4d with SMTP id
 586e51a60fabf-2a7fafda73fmr35789737fac.2.1736273204981; Tue, 07 Jan 2025
 10:06:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z2yQvTyg_MWwrlj3@debian.local> <b98f2fa5-fbe8-4958-bf20-fa5d28c5a38b@math.uni-bielefeld.de>
 <Z2yw_eJwR5ih1Npr@debian.local>
In-Reply-To: <Z2yw_eJwR5ih1Npr@debian.local>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 7 Jan 2025 19:06:33 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0i=ap+w4QZ8f2DsaHY6D=XUEuSNjyQ-2_=DGOLfZjdn+w@mail.gmail.com>
X-Gm-Features: AbW1kvbSjSNE-bEgLl-tfpxMU20u1L2jkdssynIbWEcaoblc3eEMeR8l-j1XXf0
Message-ID: <CAJZ5v0i=ap+w4QZ8f2DsaHY6D=XUEuSNjyQ-2_=DGOLfZjdn+w@mail.gmail.com>
Subject: Re: [PATCH] drm/amd: Fix random crashes due to bad kfree
To: Chris Bainbridge <chris.bainbridge@gmail.com>
Cc: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>, 
	Mario Limonciello <mario.limonciello@amd.com>, amd-gfx@lists.freedesktop.org, 
	alex.hung@amd.com, regressions@lists.linux.dev, lenb@kernel.org, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Hans de Goede <hdegoede@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

CC Hans who's been dealing with the acpi_video code for some time.

On Thu, Dec 26, 2024 at 2:27=E2=80=AFAM Chris Bainbridge
<chris.bainbridge@gmail.com> wrote:
>
> On Thu, Dec 26, 2024 at 12:19:02AM +0100, Tobias Jakobi wrote:
> > Hi Chris!
> >
> > On 12/26/24 00:09, Chris Bainbridge wrote:
> >
> > > Commit c6a837088bed ("drm/amd/display: Fetch the EDID from _DDC if
> > > available for eDP") added function dm_helpers_probe_acpi_edid, which
> > > fetches the EDID from the BIOS by calling acpi_video_get_edid.
> > > acpi_video_get_edid returns a pointer to the EDID, but this pointer d=
oes
> > > not originate from kmalloc - it is actually the internal "pointer" fi=
eld
> > > from an acpi_buffer struct (which did come from kmalloc).
> > > dm_helpers_probe_acpi_edid then attempts to kfree the EDID pointer,
> > > resulting in memory corruption which leads to random, intermittent
> > > crashes (e.g. 4% of boots will fail with some Oops).
> > >
> > > Fix this by allocating a new array (which can be safely freed) for th=
e
> > > EDID data in acpi_video_get_edid, and correctly freeing the acpi_buff=
er.
> >
> > Hmm, maybe I'm missing something here. But shouldn't it suffice to just
> > remove the kfree call in dm_helpers_probe_acpi_edid()?
>
> Yes, that would work to fix the bad kfree, but there would be a small
> memory leak of the acpi_buffer struct. It's not a huge problem since
> this code is rarely run, and the Nouveau code has never tried to free
> the edid buffer and apparently nobody noticed, but it would be better to
> do the correct thing.
>
> One other curiosity is this comment in the code that allocates the
> memory:
>
> case ACPI_ALLOCATE_BUFFER:
>         /*
>          * Allocate a new buffer. We directectly call acpi_os_allocate he=
re to
>          * purposefully bypass the (optionally enabled) internal allocati=
on
>          * tracking mechanism since we only want to track internal
>          * allocations. Note: The caller should use acpi_os_free to free =
this
>          * buffer created via ACPI_ALLOCATE_BUFFER.
>          */
>
> Which makes me wonder if all the calls to kfree on acpi_buffer structs
> with ACPI_ALLOCATE_BUFFER in acpi_video.c should actually be calls to
> acpi_os_free instead? I used kfree just for consistency with the
> existing code.

In Linux, acpi_os_free() is a wrapper around kfree(), so it doesn't
matter in practice which one is used, although in principle you are
right.

So Hans points out that you should check the kmemdup() return value
against NULL because returning a nonzero length along with a NULL
buffer pointer is confusing at best.

But if you want to kmemdup() the buffer, it is better to additionally
check if the length of it really equals to the 'length' value.

And I would put the entire buffer management into
acpi_video_device_EDID() including the kmemdup() and make it return
the actual length of the buffer on success.

