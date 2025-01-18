Return-Path: <linux-acpi+bounces-10750-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ECA4A15BB5
	for <lists+linux-acpi@lfdr.de>; Sat, 18 Jan 2025 08:16:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC2233A935D
	for <lists+linux-acpi@lfdr.de>; Sat, 18 Jan 2025 07:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24B4E13D8B2;
	Sat, 18 Jan 2025 07:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bwNzhi+K"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B33139D0A;
	Sat, 18 Jan 2025 07:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737184611; cv=none; b=FWk5hgyI9pXxP5LyOQAdk4HqNMIHs3tkING6Ds8MmoXUjVDGO9CBmcx+8J8a5Zb4k22A093BIxhn1BkThL3hYTByJRzxyjP67ImTw2R3gZUJoDbTd/nRZSSgCkvehvx9cf8y1NTL+WrANdlQ5SJ/gHPotUbcw5dtPRn0sRqIjG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737184611; c=relaxed/simple;
	bh=xQ8v6C3RjZyxKCsl4t628hXhl+6Ltz4EkIshCEZFS7Q=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=MR/SxkLzETVtdssNFYc42Ofh5jUpB1yxW6atWXVcBXDqgu1yJ+Hw/zmqE0xv2i8oXNPFLK/mVuB5FekA9IYRGVELFR+epOERI/00Vcno8m3QLtpyMGYMATVOE3hWWCDEN7alkF+3R3ilBoTLBiPJFkzUKoyETFWqsxEUkzxnArI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bwNzhi+K; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e39f43344c5so4208160276.1;
        Fri, 17 Jan 2025 23:16:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737184608; x=1737789408; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PSNPpxIIcKUwp6W5JYXhXR1LNX62xt6EEhK2b2IjbIc=;
        b=bwNzhi+Kg0A9p1T7ReiVb5tpu6Snqs2iNmWCZKpkRjzXELNIpFQm3jeIF3UwERUN35
         yPcuXgIitjUwgL4YyaMe3mgpkifD4vxb27WIlVSUOBLUpHzCZCgteeLX8WiuqehDdRAF
         3R/rxnlBWIxatd5aQlHjAoeHo2qqJOLAwu0zBR6jikvlxtrC954vt8Y3UM6ARgg8d//U
         0EBUiVdSNnnjmpG2xr6VIzJcKIM+btiDgTIwsPyHloZhNC/Sz4NdxDcw1i6f1HKs2GLz
         qyjs2AtH7uiOaxMcLz15HEuwUbrFde45AbVy88UU/rWSiwepcZozzQoBC1APfgmhgDuj
         Lw7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737184608; x=1737789408;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PSNPpxIIcKUwp6W5JYXhXR1LNX62xt6EEhK2b2IjbIc=;
        b=TCYViyHx3z+vi/pfXaaqYGS5iX8INZmsm8tUJiVKYgjH/CYfpZzONolVo7TIV7u0nJ
         K/TD1sN3vGS1QpTPWohAOzhmx1lvA/eBtmpz01kyOP9itznoP61YAWUiJawFTeJiEGwP
         zxD1EyKcBqDRoH8BfJgfzQeQwk9yadh5a9/CfdcUszSzJ5THob+lE8kJdloJhgrFZq9v
         DgNQzZRAxGQj7T+GsokgfTMNOsgN5qCp+IcJ5ba/dp+SbqXaLmT9UnRNw/bSBa2hG2GP
         eh8haRmTy6I+xwcZ53LXzFUJ/YCQ4vBB0yeJxs+9Yjetw6VKO/hG8LqsQED/f/h/Fkgd
         B9Yg==
X-Forwarded-Encrypted: i=1; AJvYcCUHEzAYOFYr7QV9+uNccz+7qps/Simf5Shtn3zwCWhTszLp7S17AhoCOjQ59VSzABH1tPCpDLuWvZNR@vger.kernel.org, AJvYcCXfkfoiHp1KcNP92XCFKUYmslWW38RppI2IPh4PeHxdFNtIBysmGy3P99QqdIv0VZ8rBHOFRDDTBcB5S54S@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3CldKw0Ho/dYpRIa6MO/S1tVTnDd7cxYZ6a2ADqha4oVRoXjh
	1QlZYY9MQgCdOpYk8HEbbfh4/t4hxYzM9j2pFB/rGnlOqY2mu6NO
X-Gm-Gg: ASbGncvZN7fkAj/IQLvLZRvV5bsMugO6mjRxPnP3fXxRk75ebCnZD03WE5xgtZ9n66F
	S8pefxI7loowWKBk2nNDER62I62vwGka90GADfvdnfKr84xv6aE3v5gb/+etmNVTEIR1vEJVVt1
	uKx6veh+0Hwz8zeVEjNGVWR8HX0MEFH1ECaEzjhgm4CizHCdUTgl/c36FWRD65hlnfbLTTdlR5+
	UCiwwhc2AaQSOwHNmn3YOcGLcygJMokvxJvSYzu5DemlHFddtt7deJRHj1DVQ==
X-Google-Smtp-Source: AGHT+IH/XGyH2Sf61toLo+fZGgDjUWQdJNW9FGiofyi2c3nMEQAqvYd+m9xaxdlLbSK7jpeXsgriMw==
X-Received: by 2002:a05:6902:210e:b0:e38:b87f:52a7 with SMTP id 3f1490d57ef6-e57b1059e5bmr4425042276.14.1737184608176;
        Fri, 17 Jan 2025 23:16:48 -0800 (PST)
Received: from localhost ([2800:bf0:82:1159:c837:3446:190b:188d])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e57ab2e7d24sm734903276.14.2025.01.17.23.16.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jan 2025 23:16:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 18 Jan 2025 02:16:43 -0500
Message-Id: <D750JPP15G81.33MSP8F75PFRW@gmail.com>
From: "Kurt Borja" <kuurtb@gmail.com>
To: "Mark Pearson" <mpearson-lenovo@squebb.ca>,
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: "platform-driver-x86@vger.kernel.org"
 <platform-driver-x86@vger.kernel.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Len Brown" <lenb@kernel.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "LKML"
 <linux-kernel@vger.kernel.org>, "Limonciello, Mario"
 <mario.limonciello@amd.com>, "Armin Wolf" <W_Armin@gmx.de>, "Joshua
 Grisham" <josh@joshuagrisham.com>, "Derek J . Clark"
 <derekjohn.clark@gmail.com>, "Hans de Goede" <hdegoede@redhat.com>,
 "Maximilian Luz" <luzmaximilian@gmail.com>, "Lee Chun-Yi" <jlee@suse.com>,
 "Shyam Sundar S K" <Shyam-sundar.S-k@amd.com>, "Corentin Chary"
 <corentin.chary@gmail.com>, "Luke D . Jones" <luke@ljones.dev>, "Lyndon
 Sanche" <lsanche@lyndeno.ca>, "Ike Panhc" <ike.pan@canonical.com>,
 "Henrique de Moraes Holschuh" <hmh@hmh.eng.br>, "Alexis Belmonte"
 <alexbelm48@gmail.com>, "Ai Chao" <aichao@kylinos.cn>, "Gergo Koteles"
 <soyer@irl.hu>, <Dell.Client.Kernel@dell.com>,
 <ibm-acpi-devel@lists.sourceforge.net>
Subject: Re: [PATCH v4 00/19] Hide platform_profile_handler from consumers
X-Mailer: aerc 0.18.2-0-ge037c095a049
References: <20250116002721.75592-1-kuurtb@gmail.com>
 <1eb2720a-c9af-4e5c-8df2-c4ce3c017d5c@app.fastmail.com>
 <3aab5072-f032-7458-56af-1d45e89a5d44@linux.intel.com>
 <D74IM4AZ87C9.1R1S1KOA89PX7@gmail.com>
 <f8678f9c-56c2-b3a9-f24d-04c9433dba9f@linux.intel.com>
 <f4e08213-0f42-4f35-a150-a75bf91537bf@app.fastmail.com>
 <01d3c53e-666a-46d8-b629-ba8a089011ee@app.fastmail.com>
In-Reply-To: <01d3c53e-666a-46d8-b629-ba8a089011ee@app.fastmail.com>

On Fri Jan 17, 2025 at 8:33 PM -05, Mark Pearson wrote:
>
>
> On Fri, Jan 17, 2025, at 3:45 PM, Mark Pearson wrote:
> > Hi,
> >
> > On Fri, Jan 17, 2025, at 12:19 PM, Ilpo J=C3=A4rvinen wrote:
> >> On Fri, 17 Jan 2025, Kurt Borja wrote:
> >>
> >>> On Fri Jan 17, 2025 at 11:42 AM -05, Ilpo J=C3=A4rvinen wrote:
> >>> > On Thu, 16 Jan 2025, Mark Pearson wrote:
> >>> >
> >>> > > Hi
> >>> > >=20
> >>> > > On Wed, Jan 15, 2025, at 7:27 PM, Kurt Borja wrote:
> >>> > > > Hi :)
> >>> > > >
> >>> > > > The merge window is about to open, so I rebased this patchset o=
n top of
> >>> > > > pdx86/review-ilpo-next to pick up acer-wmi latest commits, in c=
ase we
> >>> > > > manage to squeeze this into v6.14.
> >>> > > >
> >>> > > > ~ Kurt
> >>> > > > ---
> >>> > > > v3 -> v4:
> >>> > > >
> >>> > > > [09/19]
> >>> > > >   - Replace error message with a user-friendly one
> >>> > > >
> >>> > > > v3:=20
> >>> > > > https://lore.kernel.org/platform-driver-x86/20250115071022.4815=
-1-kuurtb@gmail.com/
> >>> > > >
> >>> > > > Kurt Borja (19):
> >>> > > >   ACPI: platform_profile: Replace *class_dev member with class_=
dev
> >>> > > >   ACPI: platform_profile: Let drivers set drvdata to the class =
device
> >>> > > >   ACPI: platform_profile: Remove platform_profile_handler from =
callbacks
> >>> > > >   ACPI: platform_profile: Add `ops` member to handlers
> >>> > > >   ACPI: platform_profile: Add `probe` to platform_profile_ops
> >>> > > >   platform/surface: surface_platform_profile: Use
> >>> > > >     devm_platform_profile_register()
> >>> > > >   platform/x86: acer-wmi: Use devm_platform_profile_register()
> >>> > > >   platform/x86: amd: pmf: sps: Use devm_platform_profile_regist=
er()
> >>> > > >   platform/x86: asus-wmi: Use devm_platform_profile_register()
> >>> > > >   platform/x86: dell-pc: Use devm_platform_profile_register()
> >>> > > >   platform/x86: ideapad-laptop: Use devm_platform_profile_regis=
ter()
> >>> > > >   platform/x86: hp-wmi: Use devm_platform_profile_register()
> >>> > > >   platform/x86: inspur_platform_profile: Use
> >>> > > >     devm_platform_profile_register()
> >>> > > >   platform/x86: thinkpad_acpi: Use devm_platform_profile_regist=
er()
> >>> > > >   ACPI: platform_profile: Remove platform_profile_handler from =
exported
> >>> > > >     symbols
> >>> > > >   ACPI: platform_profile: Move platform_profile_handler
> >>> > > >   ACPI: platform_profile: Clean platform_profile_handler
> >>> > > >   ACPI: platform_profile: Add documentation
> >>> > > >   ACPI: platform_profile: Add a prefix to log messages
> >>> > > >
> >>> > > >  .../ABI/testing/sysfs-class-platform-profile  |  44 +++++
> >>> > > >  drivers/acpi/platform_profile.c               | 172 ++++++++++=
+++-----
> >>> > > >  .../surface/surface_platform_profile.c        |  48 ++---
> >>> > > >  drivers/platform/x86/acer-wmi.c               | 114 ++++++----=
--
> >>> > > >  drivers/platform/x86/amd/pmf/core.c           |   1 -
> >>> > > >  drivers/platform/x86/amd/pmf/pmf.h            |   3 +-
> >>> > > >  drivers/platform/x86/amd/pmf/sps.c            |  51 +++---
> >>> > > >  drivers/platform/x86/asus-wmi.c               |  55 +++---
> >>> > > >  drivers/platform/x86/dell/alienware-wmi.c     |  34 ++--
> >>> > > >  drivers/platform/x86/dell/dell-pc.c           |  60 +++---
> >>> > > >  drivers/platform/x86/hp/hp-wmi.c              |  83 +++++----
> >>> > > >  drivers/platform/x86/ideapad-laptop.c         |  45 +++--
> >>> > > >  .../platform/x86/inspur_platform_profile.c    |  48 +++--
> >>> > > >  drivers/platform/x86/thinkpad_acpi.c          |  37 ++--
> >>> > > >  include/linux/platform_profile.h              |  37 ++--
> >>> > > >  15 files changed, 495 insertions(+), 337 deletions(-)
> >>> > > >  create mode 100644 Documentation/ABI/testing/sysfs-class-platf=
orm-profile
> >>> > > >
> >>> > > >
> >>> > > > base-commit: d98bf6a6ed61a8047e199495b0887cce392f8e5b
> >>> > > > --=20
> >>> > > > 2.48.1
> >>> > >=20
> >>> > > For the series up to v4 commit 15/19:
> >>> > > Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> >>> > >=20
> >>> > > I need to go over the last few commits just once more, as there a=
 few=20
> >>> > > pieces I need to get my head around - and I'm not going to get it=
 done=20
> >>> > > this evening. Hope it's OK to add review for the bits that I have=
 done.
> >>> >
> >>> > I, for the first time ever, tested filter-branch and after some ini=
tial=20
> >>> > hickups on how to specify the commit range, got your Reviewed-bys a=
dded
> >>> > with single command :-).
> >>>=20
> >>> Awesome! I believe commit 15/19
> >>>=20
> >>> a213108c01e0 ("ACPI: platform_profile: Remove platform_profile_handle=
r from exported symbols")
> >>>=20
> >>> is still missing a rev-by by Mark, if there is still time.
> >>
> >> Thanks for noticing this. I just recalled the patch numbering wrong.
> >>
> >> It should be fixed now.
> >>
> >> --=20
> >>  i.
> >
> > I finished my review, and no concerns. For the series:
> > Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> >
> > Note - I'm building and will give it a sniff test too, but that will=20
> > take a bit longer.
> >
> > Thanks for your work on this Kurt
> >
> Ran the series on an X1 Carbon G12 and profiles working well. Was able to=
 check the new class and didn't find any issues.
> For the series:
> Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>

Thank you so much for testing this too! This gives me a lot of peace of
mind :)

~ Kurt


