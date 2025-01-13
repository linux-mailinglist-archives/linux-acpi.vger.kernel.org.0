Return-Path: <linux-acpi+bounces-10574-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09739A0C278
	for <lists+linux-acpi@lfdr.de>; Mon, 13 Jan 2025 21:12:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7A213A52C2
	for <lists+linux-acpi@lfdr.de>; Mon, 13 Jan 2025 20:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41DBD1CD210;
	Mon, 13 Jan 2025 20:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EJ7dPa49"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167CF1CBE95;
	Mon, 13 Jan 2025 20:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736799170; cv=none; b=PJeHscLeLkD36tenLvW299A1+H+OZ9CUEKugxI3X6I89+R7cQfeH4ryV2nBgZXyJOGtSvxwEt74xVgDrMEPl6a9u+df0OFDwUX0Zr+HrLE/usvjHYyGXnWSNaafPtxtc55Yu1PJh9/byI8t2ytyMXEYqGhBnznxPRvl4Gcd/9XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736799170; c=relaxed/simple;
	bh=VO71TFfgjbrSIr+nIvPjvtiNtN2bS1Ejb31IvQuMFAE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DVoDjKtRWoejJTQCLnPS4EwZFOVQqPydSmQXWG8arsl/Rt2IKCphj1qa8R8UH0WwDLJjCqtEsFV7e51lAc1nYRQ6RsCiO+yWNDvepizKGcm8qzG3CLifRoa+6jaOmA4RPjLM2xavGff9nc9BWeEfygnpW+8Wu1ilqmXj5bTrzzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EJ7dPa49; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DE8AC4CEE2;
	Mon, 13 Jan 2025 20:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736799169;
	bh=VO71TFfgjbrSIr+nIvPjvtiNtN2bS1Ejb31IvQuMFAE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=EJ7dPa49b1O9B8dg8wg+GUJLNOMr3Mq41AUFMX0KJzwGuf0+MdelqsQChhgIh3cgI
	 eBLI3iIL1FCdKLSFxZi2YEk05pduXPCM5azvGQuApTIVzJAmFOcz0ru+EID/akFR8w
	 KqvyGWnJsEjBuenI5YK54XUXVs6UlMoHEl6lgh9zlZGyfxxZzGDaoaT1GmN7wWjtnZ
	 fGhfJl9QiwGhyk8FU1fC9NDVRpRJPr+wj8K9RZIJZ/GGgLe12K9AJKWPPScFIpDtHo
	 CGPBehOWZBoFvML3dFpXMHF5CEY6ofuTZrDCpUJitsrXl8UBc+YJnRP/+X5uDrNSmr
	 S98h7WNC8++jQ==
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3eb8bdcac2eso878769b6e.0;
        Mon, 13 Jan 2025 12:12:49 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVp6y8EbziaKXBSRKGc5CaCiMiq1qSSehUs66hYDlx+e0SdlGkO8nq/NikxQE2Vs0k2v8fk+WoKP48U7vVb@vger.kernel.org, AJvYcCVsGRp8v+f2heu/QvUiBQMc3KFUnp42CyZshvea1ezrmoShfEdK0YRhaMwrmNfyGhWPQOPXA/l8w1oi@vger.kernel.org
X-Gm-Message-State: AOJu0YyYDjvTXbiX3jbjwDiWwnYpb6QhSEjo6FOZrXaxoltZMjxunXMH
	wrOskntlGPOakho9IRxmMN3UykUYaOQZxQJ1SGu1JisO3f/rqpEBm8+88QjZ7zy4Hg0Tf6Iec9Z
	uCI485RfveHfVLnqbI7kekLWuWTY=
X-Google-Smtp-Source: AGHT+IFDg16HTytPYaVRyH/8xx6u66EXlnnAVIt9DAQCoXWFaXHoTaenWY5JbLpFyrCHF6H+M9XGT/5CBd32kBtLvSA=
X-Received: by 2002:a05:6808:14c3:b0:3eb:4137:53bb with SMTP id
 5614622812f47-3ef2ed64538mr15530049b6e.31.1736799168905; Mon, 13 Jan 2025
 12:12:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z2yQvTyg_MWwrlj3@debian.local> <b98f2fa5-fbe8-4958-bf20-fa5d28c5a38b@math.uni-bielefeld.de>
 <Z2yw_eJwR5ih1Npr@debian.local> <CAJZ5v0i=ap+w4QZ8f2DsaHY6D=XUEuSNjyQ-2_=DGOLfZjdn+w@mail.gmail.com>
 <Z4K_oQL7eA9Owkbs@debian.local> <c6e622b2-64e4-41cf-acfb-31ae493571d2@amd.com>
 <ed72f369-bc74-44d8-9cce-34aa125176fa@amd.com>
In-Reply-To: <ed72f369-bc74-44d8-9cce-34aa125176fa@amd.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 13 Jan 2025 21:12:38 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gwS72w6byCpRqRmzJO_u_fK_f9cmRZiEyd5Dj4N+FTvg@mail.gmail.com>
X-Gm-Features: AbW1kvZxA99UjPRblh6jzrEs3eL3h3OldUrIIIJvmVyRjY0jVsu8_oUgWNLXqlQ
Message-ID: <CAJZ5v0gwS72w6byCpRqRmzJO_u_fK_f9cmRZiEyd5Dj4N+FTvg@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: video: Fix random crashes due to bad kfree
To: Mario Limonciello <mario.limonciello@amd.com>, 
	Chris Bainbridge <chris.bainbridge@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Tobias Jakobi <tjakobi@math.uni-bielefeld.de>, 
	amd-gfx@lists.freedesktop.org, alex.hung@amd.com, regressions@lists.linux.dev, 
	lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Hans de Goede <hdegoede@redhat.com>, Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 13, 2025 at 4:59=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> On 1/13/2025 08:19, Mario Limonciello wrote:
> > On 1/11/2025 12:59, Chris Bainbridge wrote:
> >> Commit c6a837088bed ("drm/amd/display: Fetch the EDID from _DDC if
> >> available for eDP") added function dm_helpers_probe_acpi_edid, which
> >> fetches the EDID from the BIOS by calling acpi_video_get_edid.
> >> acpi_video_get_edid returns a pointer to the EDID, but this pointer do=
es
> >> not originate from kmalloc - it is actually the internal "pointer" fie=
ld
> >> from an acpi_buffer struct (which did come from kmalloc).
> >> dm_helpers_probe_acpi_edid then attempts to kfree the EDID pointer,
> >> resulting in memory corruption which leads to random, intermittent
> >> crashes (e.g. 4% of boots will fail with some Oops).
> >>
> >> Fix this by allocating a new array (which can be safely freed) for the
> >> EDID data, and correctly freeing the acpi_buffer pointer.
> >>
> >> The only other caller of acpi_video_get_edid is nouveau_acpi_edid:
> >> remove the extraneous kmemdup here as the EDID data is now copied in
> >> acpi_video_device_EDID.
> >>
> >> Signed-off-by: Chris Bainbridge <chris.bainbridge@gmail.com>
> >> Fixes: c6a837088bed ("drm/amd/display: Fetch the EDID from _DDC if
> >> available for eDP")
> >
> > Two minor documentation related comments to consider, otherwise I think
> > the code change looks good.  Feel free to include:
> >
> > Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
>
> A few more tags to collate from another thread:
>
> Reported-by: Borislav Petkov (AMD) <bp@alien8.de>
> Closes:
> https://lore.kernel.org/amd-gfx/20250110175252.GBZ4FedNKqmBRaY4T3@fat_cra=
te.local/T/#m324a23eb4c4c32fa7e89e31f8ba96c781e496fb1
> Tested-by: Borislav Petkov (AMD) <bp@alien8.de>

Applied as a fix for 6.13, thanks everyone!

