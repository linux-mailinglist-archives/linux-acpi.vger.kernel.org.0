Return-Path: <linux-acpi+bounces-13455-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 576B2AA977E
	for <lists+linux-acpi@lfdr.de>; Mon,  5 May 2025 17:27:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C05CE171BC6
	for <lists+linux-acpi@lfdr.de>; Mon,  5 May 2025 15:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C98025C831;
	Mon,  5 May 2025 15:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q/cGyR0+"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058AD24EAAF
	for <linux-acpi@vger.kernel.org>; Mon,  5 May 2025 15:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746458846; cv=none; b=Iz27Yn2jVV4v0xyHps+n7EN8W2pnYM1wee08uN0/ZMOMYRdiFLEnW7cNO946A8e863oa/wXR+aARmAanRyufwmaFcm3e0UFmfk1nF0ntVdC5cJ2nf5i+AXBtrCWHMvZpa+FT4Rid6YTodrd7gfPajtJ6a9hWKMTqyJp1SM7RaRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746458846; c=relaxed/simple;
	bh=Dxx8EYgJbY7CssNFRN4+hvSg8TXenIRQlELRJTUm0sQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p9KgJmF+QoChBFlB1HLjqEURKcval7YTWKrTCuisWz5vHELrCm20LygNtEdSZqwobqIJ1ZlcBxSaTlDE1Zn4f5dboPZ/qdtr3OQvXMD+xtDrwLoeB5wJPBT6IAWnaE/g/cbzXT+PjAN6osfhb234VyY86pGJp02ai8T4uL5LoTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q/cGyR0+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7740DC4CEE4
	for <linux-acpi@vger.kernel.org>; Mon,  5 May 2025 15:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746458845;
	bh=Dxx8EYgJbY7CssNFRN4+hvSg8TXenIRQlELRJTUm0sQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Q/cGyR0+J+Sr56Mf3rvSUmLW5jjzCDX1HUosNkN90pFGHZ3fZfdq5JrRDwp9LEGhW
	 CqQ/s/cPo/zdsnoVW+M1z9QzZerL4gFy+N00+/SKYd6EjYmOjp46xYtPrI5+/xNoKy
	 u3Bfl0l1xdmtQQw3S0TUgiOpSerISBwU+O/lARQ3t+9dxNEeoXZdMLzEnKz70a1gHR
	 cDsCkNqrdrhQCh1F8t+kz/Z22bR/1SmCptn8DbCkJ7Ywvzy6MmOHXC6uMzW8nFhzmP
	 4KSEqqh4aZgX/28rVSPEjv6M91DKopr07VnIqjf+fF8a4bBiqVMgwdbETSKjZwsxJz
	 D0eGFVWeKZb/A==
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-604ad6c4cf1so1447147eaf.3
        for <linux-acpi@vger.kernel.org>; Mon, 05 May 2025 08:27:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVxu2VUoePHoA6SE/j3wWMCBU0ONCr4AbQmXH+V5WwQdVIcAOLk5aBq/bF3fC3cbkDeUbGUKLoJSQBN@vger.kernel.org
X-Gm-Message-State: AOJu0YxWkUtV2LC8heMIkPJH2GHV2JR46gGWL/tUxoexNPcCr61xpHMO
	Me5tQkEaLNXQsBhoTJKpkvgwX/cK5KCwumTvPOdL0+5k7O9lMEunjmwKICdb9ZD5uEnuFVpC1U+
	bhlyC6nj1mQbn/uaq2ZerexzOjSE=
X-Google-Smtp-Source: AGHT+IHjUs1C+Fh+dRtx9gLwcfIYFUJj/QqAu6Hem0QBD+UTthzFsnznTzFpPvzlVMIyTMoP0D/lKLXGPAsaV+0rWFo=
X-Received: by 2002:a05:6870:8613:b0:2d6:2a40:fb9d with SMTP id
 586e51a60fabf-2dae863e0dfmr5024469fac.28.1746458844798; Mon, 05 May 2025
 08:27:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250415212740.2371758-1-superm1@kernel.org> <54cbc6d5-1102-45f4-8b71-97bccd717416@kernel.org>
 <CAJZ5v0jdR1agmiFaPyGjrSoozCBot4tW8MV_diPDfXrOURvPww@mail.gmail.com> <db06f729-50dc-48b3-a001-70f4a2b54963@kernel.org>
In-Reply-To: <db06f729-50dc-48b3-a001-70f4a2b54963@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 5 May 2025 17:27:13 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iK8Q=Qak-RU3n3RCOWC-=2jiZXh_-EkMH1PdEQ_E+2iA@mail.gmail.com>
X-Gm-Features: ATxdqUGBvk5Q4QouUmgXNpTqM3Po5U92d8klkYbE6Mjm8klBXHyucVMGTKUQwx8
Message-ID: <CAJZ5v0iK8Q=Qak-RU3n3RCOWC-=2jiZXh_-EkMH1PdEQ_E+2iA@mail.gmail.com>
Subject: Re: [PATCH] ACPI: Enable CONFIG_ACPI_DEBUG by default
To: Mario Limonciello <superm1@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Ingo Molnar <mingo@kernel.org>, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 5, 2025 at 5:15=E2=80=AFPM Mario Limonciello <superm1@kernel.or=
g> wrote:
>
> On 5/5/2025 10:03 AM, Rafael J. Wysocki wrote:
> > On Mon, May 5, 2025 at 4:58=E2=80=AFPM Mario Limonciello <superm1@kerne=
l.org> wrote:
> >>
> >> On 4/15/2025 4:27 PM, Mario Limonciello wrote:
> >>> From: Mario Limonciello <mario.limonciello@amd.com>
> >>>
> >>> CONFIG_ACPI_DEBUG can be helpful for getting debug messages on OEM
> >>> systems to identify a BIOS bug.  It's a relatively small size increas=
e
> >>> to turn it on by default (50kb) and that saves asking people to enabl=
e
> >>> it when an issue comes up because it wasn't in defconfig.
> >>>
> >>> Enable it by default.
> >>>
> >>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> >>
> >> Rafael,
> >>
> >> Any thoughts on this?  Especially in seeing Ingo trying to modernize
> >> more of the defconfig [1]?
> >>
> >> [1]
> >> https://lore.kernel.org/lkml/20250505110946.1095363-1-mingo@kernel.org=
/#t
> >
> > I'm not sure if this is a good idea TBH.
> >
> > The risk is that people will start reporting issues that have been
> > there already, but now they become visible due to enabling ACPI_DEBUG
> > by default.
>
> As several distros already enable it by default I would have expected
> some "noise" like this to have settled down.
>
> Do you have specific messages in mind you think could be turning noisy
> from the extra debug statements?

Nothing in particular, mostly messages coming from ACPICA, like the
ones complaining about missing objects that have always been missing
and the firmware is now too old for anyone to really care.

Those messages are only really useful when there is someone willing to
fix the issues that trigger them.  Otherwise, they are just noise.

Though if it is enabled by default by distros used by the vast
majority of people, it could be enabled by default in the mainline
too.

Do you know which distros enable it by default?

