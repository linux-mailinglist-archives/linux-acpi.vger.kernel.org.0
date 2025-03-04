Return-Path: <linux-acpi+bounces-11809-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC53A4EDFA
	for <lists+linux-acpi@lfdr.de>; Tue,  4 Mar 2025 20:59:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15712188CEAA
	for <lists+linux-acpi@lfdr.de>; Tue,  4 Mar 2025 20:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E709252915;
	Tue,  4 Mar 2025 19:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gS9wCbsM"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1CC7202974;
	Tue,  4 Mar 2025 19:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741118393; cv=none; b=qblkVSSlaQ/Ph3Xe8hLfXkjohyINAz1xiV8Db9vWVBC1Cx21hysreN7etIcdmwM2Vx/bjBdkmkkCbVn7i92DdRAiA1Tb/a987UCi6d59kPwg+2+Dth9xjgzDSUhZGty3F7z7g9vkvP5NSQM0HjB+ATExqxPQDIChWaHSjT0TJts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741118393; c=relaxed/simple;
	bh=HCVRt543L+DnrBTrvidSR29yVIC0OEMhbbDb767AuSU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NEcauJ+ZUdIOrxNisPEtOLorRAocyMS5At7lBkcABNRblWpXsO3gxKhL9GNXgWmCdqJbQFK1emvJtC5uKLAR940+0RXaXvi9hp1xW9t2yx7EnSoLSXcz+Qf/rm+jzn5XAJREV88bFsA4X/plIAzHDjC6r8BdumyGdfAI1UpJsL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gS9wCbsM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5238AC4CEED;
	Tue,  4 Mar 2025 19:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741118392;
	bh=HCVRt543L+DnrBTrvidSR29yVIC0OEMhbbDb767AuSU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=gS9wCbsMb5Tho0A1fKrUcdGMHSXNo1+R03JPBcmA3FF2B0sBDc0bVRCqicPKejHW4
	 7KX5aEmmYDbiVzQHEfGOwDQ6h+69l0qsVkjIq9lNP1U0ifulDkj36d7f+i3OycgH0s
	 F5yY99SEpDWFwXYwHzTzHizo2NSPfK6z/tC6qGnP2XL4n7c6OTXjDKzkOvkJ8iD/6x
	 3Tg6WJI91PgcOnClMxpqmKCJWDxbDVclsGseu586xCsQxv+s9A5ikyOVFIGTOivhHe
	 pAXNoRLXbP4akySzqB9DqlhKmyqjYG4Wf3BR4pBoZMUilzg87L8MHkd0DGSuIoqwer
	 Puyy7IMHvza6g==
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-72a17886ac5so269995a34.2;
        Tue, 04 Mar 2025 11:59:52 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVZKCnh2rvtp/dYQEo/KlRHFIoQykqjZdN2Vwh4frP80bNhhZiFdOsOBHyqG6nSxBg141komQscfTdXDpXr@vger.kernel.org, AJvYcCWl2kXCtrvZWNGL1ouoghRsgRwwMkQ0gw48wHXMXc2rrDY/rOLIpqZrn3wG/JfWRxY4/tCa38eXWGdF@vger.kernel.org, AJvYcCXRlBMQe8DDyqBxA1HwNtdgJ3+sitGoutpaycFaw2WkgxOR4fJFXJ99qosvdbR/p+h3V/TuNS/JfqB11oy5As0LP+6ztw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxyv4vsW35l+0P8Z1Onf42jOG1NEiCxgErh1kqVulHYC2ghdIYU
	y66OIbsDyn4/0+keK56T0dieLbi0zWrhOcixYuydzyXj/xngfIVhluCHOijNxOK3bKApTtobkIe
	9tg0QpAn1s+zq85PyyXmTnNQsm0E=
X-Google-Smtp-Source: AGHT+IGrpWir63TtRFU/TuZgtv3qgV7FgjoHtEHUHiDP101iyhdgw7ntMrVf16/5lbaFA2xVtbVUr+4GQ3MY+PlN49Y=
X-Received: by 2002:a05:6830:3785:b0:727:24c6:87e8 with SMTP id
 46e09a7af769-72a1fc822e0mr151368a34.19.1741118391592; Tue, 04 Mar 2025
 11:59:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250228170155.2623386-1-superm1@kernel.org> <bda43bf4-1d45-d1bf-8d5c-f27727ebc80e@linux.intel.com>
In-Reply-To: <bda43bf4-1d45-d1bf-8d5c-f27727ebc80e@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 4 Mar 2025 20:59:40 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jvvfWCoCZxZzGRM01QLLgmL8Xmz8pQa8jHde1Sr1BqRQ@mail.gmail.com>
X-Gm-Features: AQ5f1JqBgC5sjj5BTk2bGhzNeC-ApBBAHKveJHreZ1Mf15uuHsfBuhgNJMA8_CQ
Message-ID: <CAJZ5v0jvvfWCoCZxZzGRM01QLLgmL8Xmz8pQa8jHde1Sr1BqRQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] Add support for hidden choices to platform_profile
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Mario Limonciello <superm1@kernel.org>
Cc: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Hans de Goede <hdegoede@redhat.com>, "Luke D . Jones" <luke@ljones.dev>, 
	Mark Pearson <mpearson-lenovo@squebb.ca>, 
	"open list:AMD PMF DRIVER" <platform-driver-x86@vger.kernel.org>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:ACPI" <linux-acpi@vger.kernel.org>, "Derek J . Clark" <derekjohn.clark@gmail.com>, 
	Antheas Kapenekakis <lkml@antheas.dev>, me@kylegospodneti.ch, 
	Denis Benato <benato.denis96@gmail.com>, Mario Limonciello <mario.limonciello@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 4, 2025 at 5:22=E2=80=AFPM Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> On Fri, 28 Feb 2025, Mario Limonciello wrote:
>
> > From: Mario Limonciello <mario.limonciello@amd.com>
> >
> > When two drivers provide platform profile handlers but use different
> > strings to mean (essentially) the same thing the legacy interface won't
> > export them because it only shows profiles common to multiple drivers.
> >
> > This causes an unexpected behavior to people who have upgraded from an
> > earlier kernel because if multiple drivers have bound platform profile
> > handlers they might not be able to access profiles they were expecting.
> >
> > Introduce a concept of a "hidden choice" that drivers can register and
> > the platform profile handler code will utilize when using the legacy
> > interface.
> >
> > There have been some other attempts at solving this issue in other ways=
.
> > This serves as an alternative to those attempts.
> >
> > Link: https://lore.kernel.org/platform-driver-x86/e64b771e-3255-42ad-92=
57-5b8fc6c24ac9@gmx.de/T/#t
> > Link: https://lore.kernel.org/platform-driver-x86/CAGwozwF-WVEgiAbWbRCi=
UaXf=3DBVa3KqmMJfs06trdMQHpTGmjQ@mail.gmail.com/T/#m2f3929e2d4f73cc0eedd147=
38170dad45232fd18
> > Cc: Antheas Kapenekakis <lkml@antheas.dev>
> > Cc: "Luke D. Jones" <luke@ljones.dev>
> >
> > Mario Limonciello (3):
> >   ACPI: platform_profile: Add support for hidden choices
> >   platform/x86/amd: pmf: Add 'quiet' to hidden choices
> >   platform/x86/amd: pmf: Add balanced-performance to hidden choices
> >
> >  drivers/acpi/platform_profile.c    | 94 +++++++++++++++++++++++-------
> >  drivers/platform/x86/amd/pmf/sps.c | 11 ++++
> >  include/linux/platform_profile.h   |  3 +
> >  3 files changed, 87 insertions(+), 21 deletions(-)
> >
> >
>
> Acked-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

All 3 patches applied as 6.14-rc6 material, thanks!

