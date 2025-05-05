Return-Path: <linux-acpi+bounces-13457-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB038AA9812
	for <lists+linux-acpi@lfdr.de>; Mon,  5 May 2025 17:55:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FCDA3A6236
	for <lists+linux-acpi@lfdr.de>; Mon,  5 May 2025 15:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1E152620E7;
	Mon,  5 May 2025 15:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qPyJ0s7o"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE14253F2D
	for <linux-acpi@vger.kernel.org>; Mon,  5 May 2025 15:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746460541; cv=none; b=BO3F0XVwKVyzDFGo/7JuYwz6tHfJ061EeXF7WgQB2d2ASuaoEmjsLvrPurXY+ds+triz9YPAyBYw/KjmvF2c23TR8HRii0xOTppZ5ERo59eZylBg5r20tt5ezu56P06Hb/OUYyZpFmEfy6R5Y8zcNelYGf1orOi7JAMoBg7xLa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746460541; c=relaxed/simple;
	bh=QJys3v5I7N32zU+B1BVUSXMK9433/Zom5K3OpjtNk8c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UXB0Bha8Vdmx1NAYBJeyxg7Yac5Q11T74IBzYXA1onlQIJPZ+vTINpOQmQSJTpYbYWOkA+Rd5ZSVJNFdACme/Ab7+49f6oPLn08DXSetdwBy4EVWA2LemD0ARnbxH5DuUTfZYAdOnH1/FdptmU248jT46B897i8usN0EoIa+udI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qPyJ0s7o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 199B6C4CEE4
	for <linux-acpi@vger.kernel.org>; Mon,  5 May 2025 15:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746460540;
	bh=QJys3v5I7N32zU+B1BVUSXMK9433/Zom5K3OpjtNk8c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=qPyJ0s7oR1A1IjIWcrbH/sWaWNw2WFDSKU6sllmMarqXoG4istOsT6OysgCMc4aWE
	 VAbNkl0ttEJ2dvucoULhI3F6lIDOEIPi3yfxOrO0kDT2crBn5Bjc2t/Dq472pmwLRD
	 0KUAWSnastZ3lCZf0WVokPEwmnvxhr4Hg60yoXHA6GNp/VkM1nnKUG5hYIw5+2Hngw
	 E1x9OefSupAyQV772r0gISKsEOqf2oxESxEhwfBWzsP4nFoc/mU7mELxG5EfQJWevX
	 Dj4/j6sYD9phWW4T93NWCQfNTjfiVLbwev8X4F4RRqJvuwlDsORZKgqpus1E1I+6KH
	 phTxsX7QEj5mA==
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-2dab7a32fb7so1337629fac.0
        for <linux-acpi@vger.kernel.org>; Mon, 05 May 2025 08:55:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVEn6VjnrQWByKz8mSTkJUtfvHAhTQkWCim40ZgMyls1jEQdmNS2ieVTBXOAZeUJuqnAhBXLilCYtTH@vger.kernel.org
X-Gm-Message-State: AOJu0YzxTekdQ4IMh/ACAPQd0gaee2mElDLlHXufo5SglWD05dCNkUAQ
	m6r39tI1mvUfNMVfcY/muoN1G9Qv0DVUfnavugmmArwSEq3zUmVgbYP6MG9BrSPVns9X+KLYIMX
	yvvd7R8j5db1O/fNNo/LYq3JQDHc=
X-Google-Smtp-Source: AGHT+IGK8FBUFyNDXYeiIyAuYO/rf1W8bydzpPJK5BYYeu0WqZ9i217Y+e2uK27/DSFyLZZpnpw8mIAhXTUNvL9NP4U=
X-Received: by 2002:a05:6870:8989:b0:296:bbc8:4a82 with SMTP id
 586e51a60fabf-2dae85c51e4mr4999004fac.27.1746460539442; Mon, 05 May 2025
 08:55:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250415212740.2371758-1-superm1@kernel.org> <54cbc6d5-1102-45f4-8b71-97bccd717416@kernel.org>
 <CAJZ5v0jdR1agmiFaPyGjrSoozCBot4tW8MV_diPDfXrOURvPww@mail.gmail.com>
 <db06f729-50dc-48b3-a001-70f4a2b54963@kernel.org> <CAJZ5v0iK8Q=Qak-RU3n3RCOWC-=2jiZXh_-EkMH1PdEQ_E+2iA@mail.gmail.com>
 <d93c8d7a-5f79-4dca-b14b-cf637b3b0779@kernel.org>
In-Reply-To: <d93c8d7a-5f79-4dca-b14b-cf637b3b0779@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 5 May 2025 17:55:27 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iXK+Tqu0wyRU5fkHe5JpAqM5L30dDyr+J6d348tPo1Mw@mail.gmail.com>
X-Gm-Features: ATxdqUF7nxs7FhVt6qDCSZkBrr5QLjtgdSzUpOGauGQMK8OdAZvJAX2baguD8PU
Message-ID: <CAJZ5v0iXK+Tqu0wyRU5fkHe5JpAqM5L30dDyr+J6d348tPo1Mw@mail.gmail.com>
Subject: Re: [PATCH] ACPI: Enable CONFIG_ACPI_DEBUG by default
To: Mario Limonciello <superm1@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Ingo Molnar <mingo@kernel.org>, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 5, 2025 at 5:32=E2=80=AFPM Mario Limonciello <superm1@kernel.or=
g> wrote:
>
> On 5/5/2025 10:27 AM, Rafael J. Wysocki wrote:
> > On Mon, May 5, 2025 at 5:15=E2=80=AFPM Mario Limonciello <superm1@kerne=
l.org> wrote:
> >>
> >> On 5/5/2025 10:03 AM, Rafael J. Wysocki wrote:
> >>> On Mon, May 5, 2025 at 4:58=E2=80=AFPM Mario Limonciello <superm1@ker=
nel.org> wrote:
> >>>>
> >>>> On 4/15/2025 4:27 PM, Mario Limonciello wrote:
> >>>>> From: Mario Limonciello <mario.limonciello@amd.com>
> >>>>>
> >>>>> CONFIG_ACPI_DEBUG can be helpful for getting debug messages on OEM
> >>>>> systems to identify a BIOS bug.  It's a relatively small size incre=
ase
> >>>>> to turn it on by default (50kb) and that saves asking people to ena=
ble
> >>>>> it when an issue comes up because it wasn't in defconfig.
> >>>>>
> >>>>> Enable it by default.
> >>>>>
> >>>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> >>>>
> >>>> Rafael,
> >>>>
> >>>> Any thoughts on this?  Especially in seeing Ingo trying to modernize
> >>>> more of the defconfig [1]?
> >>>>
> >>>> [1]
> >>>> https://lore.kernel.org/lkml/20250505110946.1095363-1-mingo@kernel.o=
rg/#t
> >>>
> >>> I'm not sure if this is a good idea TBH.
> >>>
> >>> The risk is that people will start reporting issues that have been
> >>> there already, but now they become visible due to enabling ACPI_DEBUG
> >>> by default.
> >>
> >> As several distros already enable it by default I would have expected
> >> some "noise" like this to have settled down.
> >>
> >> Do you have specific messages in mind you think could be turning noisy
> >> from the extra debug statements?
> >
> > Nothing in particular, mostly messages coming from ACPICA, like the
> > ones complaining about missing objects that have always been missing
> > and the firmware is now too old for anyone to really care.
> >
> > Those messages are only really useful when there is someone willing to
> > fix the issues that trigger them.  Otherwise, they are just noise.
>
> Ah I see.  I suppose we could always have this on by default and if it
> becomes untenable from reports flip it back to off.

The problem is that we'd only see the impact after the distros picked
up the new default config, which would take some time and then it
might not be practical to disable it again.

I guess enabling it by default could be combined with changing
ACPI_DEBUG_DEFAULT to ACPI_LV_REPAIR, say, but then you'd probably
still need to ask people to make it more verbose to see the
interesting messages.

> >
> > Though if it is enabled by default by distros used by the vast
> > majority of people, it could be enabled by default in the mainline
> > too.
> >
> > Do you know which distros enable it by default?
>
> I know Ubuntu and CachyOS both do today.  Fedora did it in some of their
> kernels and they're pushing a change to enable it in more of them right n=
ow.

So why don't we let them do it and then decide?

