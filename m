Return-Path: <linux-acpi+bounces-18257-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FD40C112C1
	for <lists+linux-acpi@lfdr.de>; Mon, 27 Oct 2025 20:38:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 067ED352A1C
	for <lists+linux-acpi@lfdr.de>; Mon, 27 Oct 2025 19:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDA232D8372;
	Mon, 27 Oct 2025 19:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EQfA/FZ+"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992CF246BB7
	for <linux-acpi@vger.kernel.org>; Mon, 27 Oct 2025 19:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761593927; cv=none; b=hW+0JJnOq+3mcsiEr1guowJUfw2bo4M5Ea4he5lEaLhhMoN9MsosZVBYC7PdLvY3Xofxo8T6ChYLviTkTiqjGrmW7u8wxMrly3mhDRqm1GxexjRVIlVPvMkVlJsKxOcZntYOVLZNhoRQtWZMvnIpMTMZ8gBWHWILfdoQq5DH17A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761593927; c=relaxed/simple;
	bh=6D/vadzULQm6byWSb6yy7xi0Eg8k+Seb5Ly5iPlDX7w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oFtG20FgETlW0/Dx74fIeUlYhAC2YXVCE2Qu1fWTl3yBf3iU/VY5lxQTrpAqQ/hSQ7KZKhZVposHZcTGlw+VzRMpEmgXk+hIxua1b3VHFRtWHsC/7PpsbGzh/0QzwwlA54nJGIs0x3DYyzNNqN4cM1DO0l1+NZue/ORk11a730o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EQfA/FZ+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42115C116B1
	for <linux-acpi@vger.kernel.org>; Mon, 27 Oct 2025 19:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761593927;
	bh=6D/vadzULQm6byWSb6yy7xi0Eg8k+Seb5Ly5iPlDX7w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=EQfA/FZ+eL3IbONuUpadDAL168wvwF/8dEGTo2/dG+vRXTvJZzxu462ac7SrKxyq/
	 nm/wPq8hLESYMv4/oEaMxcHUZ9Q3a/yb552FTS/Spt31FBRkqPA+8cwz+ShaULnMPk
	 VYAB9qJF9aRZ8Ot9Jw+6vfSIPOQBT1RzMF44to53xX9j5wvxOJgeKr8Qtfned/F/gb
	 pScPaJR1WQhN37fsK3d8YUFRgxQuxGpSIxD4ikAGaQTRkC70Il8sSbHhw5LlICrqNZ
	 uU7euAMUQqYoxlSXY4+9ej/o4S0h5yySbMA4RZxI2sriVGlokgIpdwwchAEAnSRye/
	 ojPgD3L4yLy+A==
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-654ecc2af9aso1633066eaf.3
        for <linux-acpi@vger.kernel.org>; Mon, 27 Oct 2025 12:38:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVbv2Mb+MTHuZd60lvctCt0JkUt1nr3Oyf9zvKa7Z+cDBcCqnAA3ID4637VVH1KpUdwOvB2rXrCYu4P@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ6JkIcNIlh12SW0egf03s080G7IuALBU1f8cwMoooBpnV0zjR
	I3l5JgqRU0QVDhpj6hE0LZx89Pw/nIhAoau5+5llp39+uzMsYjDGyjEmt/GSoyKiZ32RQvz9L+5
	jsBqawSLQ2eN4l9/NSqfPgVoLefSuDLc=
X-Google-Smtp-Source: AGHT+IFmnlDgQUImb9t/NaXrezavKItkeIFXPau2RUm7yfbUBFYRHMh3VQTJqHSg5g8FDOXQJ8P1rVS54gf95+/TZ4A=
X-Received: by 2002:a05:6820:2113:b0:651:c86b:528e with SMTP id
 006d021491bc7-6566f1337demr598730eaf.1.1761593926586; Mon, 27 Oct 2025
 12:38:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022204523.10752-1-tony.luck@intel.com> <CAJZ5v0hhnAq-HJhXU8VTAWKNg0PJkYbeocCKEffYOurZn0U81Q@mail.gmail.com>
 <SJ1PR11MB60835AF413CB53076304AABCFCF0A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <CAJZ5v0io8xoh2zgdo7A6sMRA9XU=s8_EF0PcUpgkH8xmui3YAw@mail.gmail.com>
In-Reply-To: <CAJZ5v0io8xoh2zgdo7A6sMRA9XU=s8_EF0PcUpgkH8xmui3YAw@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 27 Oct 2025 20:38:35 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hFb_SMYvbEuWJt2cfzYxAwAyUfAvWKwNaae_hz+Bj==w@mail.gmail.com>
X-Gm-Features: AWmQ_blS7zvmaYu9bszfN45eqFj1tLh-FZoNqpy6MJYGGdncg0-fYfi8wtt49v4
Message-ID: <CAJZ5v0hFb_SMYvbEuWJt2cfzYxAwAyUfAvWKwNaae_hz+Bj==w@mail.gmail.com>
Subject: Re: [PATCH] ACPI: MRRM: Check revision of MRRM table
To: "Luck, Tony" <tony.luck@intel.com>
Cc: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, 
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"patches@lists.linux.dev" <patches@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 6:01=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Thu, Oct 23, 2025 at 5:56=E2=80=AFPM Luck, Tony <tony.luck@intel.com> =
wrote:
> >
> > >> Before trying to parse the MRRM table, check that the table revision
> > >> is the one that is expected.
> > >
> > > OK, so should there be a Fixes: tag?  Or is it just a tidy-up of the =
code?
> >
> > I'd be surprised if this table changed. But the h/w team that proposed =
the
> > MRRM table nagged me to check the revision "just in case". Which seems
> > like good practice.
> >
> > Might as well add a Fixes to get this back ported in case someone locks=
 onto
> > v6.16 or v6.17.
> >
> > Fixes: b9020bdb9f76 ("ACPI: MRRM: Minimal parse of ACPI MRRM table")
> >
> > Would you like me to post a V2, or can you just edit this in as you app=
ly?
>
> No worries, I can edit it.

Applied with the Fixed: tag added as 6.18-rc material, thanks!

