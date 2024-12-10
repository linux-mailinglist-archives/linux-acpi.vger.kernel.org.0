Return-Path: <linux-acpi+bounces-10028-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 685339EB86E
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Dec 2024 18:38:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96BEF18856E9
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Dec 2024 17:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC30D8634E;
	Tue, 10 Dec 2024 17:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S5EYM6o1"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF7D23ED70;
	Tue, 10 Dec 2024 17:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733852307; cv=none; b=sWsgEZG2pCyYv9UqsmV97N6SoUzU3XhHSzmGqtAfBoqtoiNz+xOp0mMJFBHqY6kRkADgTQD5lkcBU5LaXY3C4AmFRj1B9NTmgIwFCMPIX+dMhHIZuWR3ZXf5LvmCPPe7L8W5zzIRCM2IYadRNstv6svQ5PerYXJDr3jRTstZmRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733852307; c=relaxed/simple;
	bh=o1u7OnnttQeO/IxubvdYjlivgCC+xe/2UUhXo9WuHNs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q7+PU8uk6ZS93JB5tPkWTq5r7Bn4fZeu08Fdzp5CFNdbXZxMC1RtJY6YUYrlbQBauxMjHl2dR87O772dkeEkYhyKXs06+B1Glp8mKFhWD5WE6v01sCH3o7n2AYx4n0N6euDr4Eia1rtxwYM7/hh1rqpFWpqPc2FFcDYbRKjhEMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S5EYM6o1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46362C4CEE5;
	Tue, 10 Dec 2024 17:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733852307;
	bh=o1u7OnnttQeO/IxubvdYjlivgCC+xe/2UUhXo9WuHNs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=S5EYM6o1of1es8VkyjY3dGYI580AUWB0gWB53ssDKo5A1HWo4xG0ap9vSMf9ZoVlA
	 SNM53uVlEt6jB2m2Y9YcFSB9OovNVqh33v3c/P3/0JD3xHYCB7fHqvP3XxcJkg9TWC
	 KCk97aujictxFbaz6s9cYyNkruKUQMJ0HIxE8bkyZ1cVB1W/akyEHt73PzKmWS87bR
	 /yWOX7+iap+Qs/iXF66XMzwgVxl0mWIZfB2C85Y4C38tAwfzxveT6KVSg7TKvn9C5z
	 cju/5RKbBkQ1kcW6CZtuVwEt8gvQLB4+eE9JQQzLpaGpXRdla5SELqpNFJlmJmZcWO
	 Q6LbrMVeGA9vg==
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-71deb3745easo580531a34.3;
        Tue, 10 Dec 2024 09:38:27 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUiXnNvPfCLnSk9kJ0HF0RkZoEj2sQ4nrvTWFfu1r/GSDhuvoFGgNdnw6LCWm9zpH8y78ehyaZ777Ua1WbxujtQlNZ2bQ==@vger.kernel.org, AJvYcCVA4573TY88ClnHmZ1KCiXkRRPtvzbiRigT6yQCTtv8Hb/+fPNdpxiu2rCpMF1IhAwNk3rMj2o4+57sd0lo@vger.kernel.org, AJvYcCX4t6BDgJmCieWhbnWuG1Sds3eNrLDQtkRufspQuty14fAKlRr6+WF2Ohm93xgeNcfrhQ7ppMDPuQkt@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2QMiZlkaqXZDg2HVBZ5mO/iqES1FcM5lZcQrrA06ZfGUI+E+6
	gxQVEH/RvaIRozVUzMcr/KfxofswWELhHSbPKH85kEJSQQIqAlpLJhET329djBGcV1P/T/AcpQd
	k7DzzlTYTElJTWyw3LrDnk03iPYs=
X-Google-Smtp-Source: AGHT+IHUPbz3C9KxTvXmAiFGqFm6CPuGoDB51rE0jLIxNsliSKNlQMBOJ52QuORyme2pcvawVTYaO/jhx6VltCaUhOA=
X-Received: by 2002:a05:6830:34a3:b0:717:f701:4842 with SMTP id
 46e09a7af769-71e0227fc96mr4131664a34.28.1733852306444; Tue, 10 Dec 2024
 09:38:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241206031918.1537-1-mario.limonciello@amd.com> <a34c7648-02cb-76e9-53f4-e54003c98ecb@linux.intel.com>
In-Reply-To: <a34c7648-02cb-76e9-53f4-e54003c98ecb@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 10 Dec 2024 18:38:15 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hoD9ZBvsbE4bvfgJc09ijAY421vNngCYaz3qy-Cg2bdw@mail.gmail.com>
Message-ID: <CAJZ5v0hoD9ZBvsbE4bvfgJc09ijAY421vNngCYaz3qy-Cg2bdw@mail.gmail.com>
Subject: Re: [PATCH v10 00/22] Add support for binding ACPI platform profile
 to multiple drivers
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Hans de Goede <hdegoede@redhat.com>, Len Brown <lenb@kernel.org>, 
	Maximilian Luz <luzmaximilian@gmail.com>, Lee Chun-Yi <jlee@suse.com>, 
	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, Corentin Chary <corentin.chary@gmail.com>, 
	"Luke D . Jones" <luke@ljones.dev>, Ike Panhc <ike.pan@canonical.com>, 
	Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Alexis Belmonte <alexbelm48@gmail.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
	Ai Chao <aichao@kylinos.cn>, Gergo Koteles <soyer@irl.hu>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:ACPI" <linux-acpi@vger.kernel.org>, 
	"open list:MICROSOFT SURFACE PLATFORM PROFILE DRIVER" <platform-driver-x86@vger.kernel.org>, 
	"open list:THINKPAD ACPI EXTRAS DRIVER" <ibm-acpi-devel@lists.sourceforge.net>, 
	Mark Pearson <mpearson-lenovo@squebb.ca>, Matthew Schwartz <matthew.schwartz@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ilpo,

On Tue, Dec 10, 2024 at 6:30=E2=80=AFPM Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> Hi Rafael,
>
> This series seems ready and Mario has requested it to be merged through
> platform drivers tree despite majority of changes touching
> drivers/acpi/platform_profile.c because its API relates to many pdx86
> drivers.
>
> Is that fine with you?

Yes, it is, thanks!

> On Thu, 5 Dec 2024, Mario Limonciello wrote:
>
> > Currently there are a number of ASUS products on the market that happen=
 to
> > have ACPI objects for amd-pmf to bind to as well as an ACPI platform
> > profile provided by asus-wmi.
> >
> > The ACPI platform profile support created by amd-pmf on these ASUS
> > products is "Function 9" which is specifically for "BIOS or EC
> > notification" of power slider position. This feature is actively used
> > by some designs such as Framework 13 and Framework 16.
> >
> > On these ASUS designs we keep on quirking more and more of them to turn
> > off this notification so that asus-wmi can bind.
> >
> > This however isn't how Windows works.  "Multiple" things are notified f=
or
> > the power slider position. This series adjusts Linux to behave similarl=
y.
> >
> > Multiple drivers can now register an ACPI platform profile and will rea=
ct
> > to set requests.
> >
> > To avoid chaos, only positions that are common to both drivers are
> > accepted when the legacy /sys/firmware/acpi/platform_profile interface
> > is used.
> >
> > This series also adds a new concept of a "custom" profile.  This allows
> > userspace to discover that there are multiple driver handlers that are
> > configured differently.
> >
> > This series also allows dropping all of the PMF quirks from amd-pmf.
> >
> > NOTE: Although this series changes code in acpi platform profile, I thi=
nk
> >       it is better to go through the platform-x86 tree as more drivers =
can
> >       be introduced during the kernel cycle and should make the changes=
 to
> >       support class interface when merging.
> >
> > v10:
> >  * Whitespace changes
> >  * Documentation update for custom in a single driver
> >
> > Mario Limonciello (22):
> >   ACPI: platform-profile: Add a name member to handlers
> >   platform/x86/dell: dell-pc: Create platform device
> >   ACPI: platform_profile: Add device pointer into platform profile
> >     handler
> >   ACPI: platform_profile: Add platform handler argument to
> >     platform_profile_remove()
> >   ACPI: platform_profile: Pass the profile handler into
> >     platform_profile_notify()
> >   ACPI: platform_profile: Move sanity check out of the mutex
> >   ACPI: platform_profile: Move matching string for new profile out of
> >     mutex
> >   ACPI: platform_profile: Use guard(mutex) for register/unregister
> >   ACPI: platform_profile: Use `scoped_cond_guard`
> >   ACPI: platform_profile: Create class for ACPI platform profile
> >   ACPI: platform_profile: Add name attribute to class interface
> >   ACPI: platform_profile: Add choices attribute for class interface
> >   ACPI: platform_profile: Add profile attribute for class interface
> >   ACPI: platform_profile: Notify change events on register and
> >     unregister
> >   ACPI: platform_profile: Only show profiles common for all handlers
> >   ACPI: platform_profile: Add concept of a "custom" profile
> >   ACPI: platform_profile: Make sure all profile handlers agree on
> >     profile
> >   ACPI: platform_profile: Check all profile handler to calculate next
> >   ACPI: platform_profile: Notify class device from
> >     platform_profile_notify()
> >   ACPI: platform_profile: Allow multiple handlers
> >   platform/x86/amd: pmf: Drop all quirks
> >   Documentation: Add documentation about class interface for platform
> >     profiles
> >
> >  .../ABI/testing/sysfs-platform_profile        |   5 +
> >  .../userspace-api/sysfs-platform_profile.rst  |  38 ++
> >  drivers/acpi/platform_profile.c               | 534 ++++++++++++++----
> >  .../surface/surface_platform_profile.c        |   8 +-
> >  drivers/platform/x86/acer-wmi.c               |  12 +-
> >  drivers/platform/x86/amd/pmf/Makefile         |   2 +-
> >  drivers/platform/x86/amd/pmf/core.c           |   1 -
> >  drivers/platform/x86/amd/pmf/pmf-quirks.c     |  66 ---
> >  drivers/platform/x86/amd/pmf/pmf.h            |   3 -
> >  drivers/platform/x86/amd/pmf/sps.c            |   4 +-
> >  drivers/platform/x86/asus-wmi.c               |   8 +-
> >  drivers/platform/x86/dell/alienware-wmi.c     |   8 +-
> >  drivers/platform/x86/dell/dell-pc.c           |  38 +-
> >  drivers/platform/x86/hp/hp-wmi.c              |   8 +-
> >  drivers/platform/x86/ideapad-laptop.c         |   6 +-
> >  .../platform/x86/inspur_platform_profile.c    |   7 +-
> >  drivers/platform/x86/thinkpad_acpi.c          |  16 +-
> >  include/linux/platform_profile.h              |   9 +-
> >  18 files changed, 559 insertions(+), 214 deletions(-)
> >  delete mode 100644 drivers/platform/x86/amd/pmf/pmf-quirks.c
>
> --
>  i.
>

