Return-Path: <linux-acpi+bounces-11797-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6D88A4E708
	for <lists+linux-acpi@lfdr.de>; Tue,  4 Mar 2025 17:55:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77A5E420F35
	for <lists+linux-acpi@lfdr.de>; Tue,  4 Mar 2025 16:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B72529AAFD;
	Tue,  4 Mar 2025 16:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F050aL2e"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AAB6BA2E;
	Tue,  4 Mar 2025 16:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741105445; cv=none; b=TP+8kXMnPbLmZC5OgfYCd78tURNwUcL18PCwrAUB/loNBBYhgXMWRX9kd0rPvUOtQClziBZ25hphQ4ynrCRBkl+v2NcRp1UCwcJbdu+jPSr2gdhGuCVlAr450CIcgmdW/8iIRa0jpFk5HVycv8z12M9iyoZx6+nxiCHk3H/YrP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741105445; c=relaxed/simple;
	bh=1g/E3QxFi8+f57T291+uHeqUByWPis4PZu0PV68aBXI=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=pVSdsu/horJgvyzrjbHTuiq3uszp6WZ7arKSG8Z4VXVMXFFLNusc5wBxteITvmVVjn5Vxug2+j/JGZOURYSkx75PwL2rPUYSzjiRJg3jSaP8ntlOD9WNeNTUJUpIVrWLAzNKaRVsPUEkSY3qOhFt3A/DycDmmsU1lRKyw6/KpxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F050aL2e; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741105444; x=1772641444;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=1g/E3QxFi8+f57T291+uHeqUByWPis4PZu0PV68aBXI=;
  b=F050aL2eIGP4yCYMgMl8e5ZxXRtVUZQzY99r70+JmJSxZ2UgN4PgP4mL
   rTS1/YdmsIX5JaFRI5PPEll++P1S4Z3WgktPxxyTA69R8d+wZp2pBpdEC
   bMgDrNP4htz4TKJEg2h9Zn2Li2GRrU/SNIGLZ6KgMQKk7HccUJA61etuG
   wS090I7aMENF2Hxj5tlZVsZEvKkyTIOKN7sH4jfxKUHwiBqfsEESjjzAj
   riNa8BZhZqw5/+HPLGcxEvbu+CmEyeREJhBgl1CEZnQcJ0yUDRyOvwGTl
   pi9JE80uAsMFguw0D3BOsBSg7lg2eFtCR79F9R3M60pTb7DCwf2wCRwED
   w==;
X-CSE-ConnectionGUID: 3nAd31OWTw2c0oSlse1gZg==
X-CSE-MsgGUID: 53lKW6uPRzGY4euLjlBigg==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="59445033"
X-IronPort-AV: E=Sophos;i="6.14,220,1736841600"; 
   d="scan'208";a="59445033"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 08:24:03 -0800
X-CSE-ConnectionGUID: qmAMMgOIRCiEcONdfDlsoQ==
X-CSE-MsgGUID: pPUNwViDTFGOFN0AyWOFnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="118937744"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.220])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 08:23:59 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 4 Mar 2025 18:23:54 +0200 (EET)
To: "Rafael J. Wysocki" <rafael@kernel.org>
cc: Mario Limonciello <superm1@kernel.org>, 
    Antheas Kapenekakis <lkml@antheas.dev>, Kurt Borja <kuurtb@gmail.com>, 
    Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, 
    Hans de Goede <hdegoede@redhat.com>, "Luke D . Jones" <luke@ljones.dev>, 
    Mark Pearson <mpearson-lenovo@squebb.ca>, 
    "open list:AMD PMF DRIVER" <platform-driver-x86@vger.kernel.org>, 
    open list <linux-kernel@vger.kernel.org>, 
    "open list:ACPI" <linux-acpi@vger.kernel.org>, 
    "Derek J . Clark" <derekjohn.clark@gmail.com>, me@kylegospodneti.ch, 
    Denis Benato <benato.denis96@gmail.com>, 
    Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH v2 1/1] ACPI: platform_profile: Treat quiet and low power
 the same
In-Reply-To: <CAJZ5v0hNHFLtBwTTuPc7mNZhCKkmFJgFwgw88_BR_7nQ+rc6Cw@mail.gmail.com>
Message-ID: <ccea4f8c-6ffe-a322-4d84-71377909dca1@linux.intel.com>
References: <20250304064745.1073770-1-superm1@kernel.org> <20250304064745.1073770-2-superm1@kernel.org> <CAGwozwHniWGQ7qK6FYD_WK5zNjkro7-Q1nTcFPAuWDt9UQ+noA@mail.gmail.com> <23d6c735-e94f-4d43-87b0-ff119941fcac@kernel.org>
 <CAJZ5v0geaYYRQm0Hs2M4ak_8AZoWLJS-v0jqyrsaVjmXk267rA@mail.gmail.com> <71b14dc3-77e1-4fd7-b576-821e3a41ba19@kernel.org> <CAJZ5v0hNHFLtBwTTuPc7mNZhCKkmFJgFwgw88_BR_7nQ+rc6Cw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-2083532595-1741105319=:931"
Content-ID: <2aa3ead2-130a-9dd0-aed8-c4cb1d958aaa@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2083532595-1741105319=:931
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <f17d2118-68e9-267f-44c9-8ec2bbc031e5@linux.intel.com>

On Tue, 4 Mar 2025, Rafael J. Wysocki wrote:

> On Tue, Mar 4, 2025 at 3:52=E2=80=AFPM Mario Limonciello <superm1@kernel.=
org> wrote:
> >
> > On 3/4/2025 08:08, Rafael J. Wysocki wrote:
> > > On Tue, Mar 4, 2025 at 1:49=E2=80=AFPM Mario Limonciello <superm1@ker=
nel.org> wrote:
> > >>
> > >> On 3/4/25 02:38, Antheas Kapenekakis wrote:
> > >>> On Tue, 4 Mar 2025 at 07:48, Mario Limonciello <superm1@kernel.org>=
 wrote:
> > >>>>
> > >>>> From: Mario Limonciello <mario.limonciello@amd.com>
> > >>>>
> > >>>> When two drivers don't support all the same profiles the legacy in=
terface
> > >>>> only exports the common profiles.
> > >>>>
> > >>>> This causes problems for cases where one driver uses low-power but=
 another
> > >>>> uses quiet because the result is that neither is exported to sysfs=
=2E
> > >>>>
> > >>>> If one platform profile handler supports quiet and the other
> > >>>> supports low power treat them as the same for the purpose of
> > >>>> the sysfs interface.
> > >>>>
> > >>>> Fixes: 688834743d67 ("ACPI: platform_profile: Allow multiple handl=
ers")
> > >>>> Reported-by: Antheas Kapenekakis <lkml@antheas.dev>
> > >>>> Closes: https://lore.kernel.org/platform-driver-x86/e64b771e-3255-=
42ad-9257-5b8fc6c24ac9@gmx.de/T/#mc068042dd29df36c16c8af92664860fc4763974b
> > >>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> > >>>> ---
> > >>>>    drivers/acpi/platform_profile.c | 38 ++++++++++++++++++++++++++=
++++---
> > >>>>    1 file changed, 35 insertions(+), 3 deletions(-)
> > >>>>
> > >>>> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platfo=
rm_profile.c
> > >>>> index 2ad53cc6aae53..d9a7cc5891734 100644
> > >>>> --- a/drivers/acpi/platform_profile.c
> > >>>> +++ b/drivers/acpi/platform_profile.c
> > >>>> @@ -73,8 +73,20 @@ static int _store_class_profile(struct device *=
dev, void *data)
> > >>>>
> > >>>>           lockdep_assert_held(&profile_lock);
> > >>>>           handler =3D to_pprof_handler(dev);
> > >>>> -       if (!test_bit(*bit, handler->choices))
> > >>>> -               return -EOPNOTSUPP;
> > >>>> +       if (!test_bit(*bit, handler->choices)) {
> > >>>> +               switch (*bit) {
> > >>>> +               case PLATFORM_PROFILE_QUIET:
> > >>>> +                       *bit =3D PLATFORM_PROFILE_LOW_POWER;
> > >>>> +                       break;
> > >>>> +               case PLATFORM_PROFILE_LOW_POWER:
> > >>>> +                       *bit =3D PLATFORM_PROFILE_QUIET;
> > >>>> +                       break;
> > >>>> +               default:
> > >>>> +                       return -EOPNOTSUPP;
> > >>>> +               }
> > >>>> +               if (!test_bit(*bit, handler->choices))
> > >>>> +                       return -EOPNOTSUPP;
> > >>>> +       }
> > >>>>
> > >>>>           return handler->ops->profile_set(dev, *bit);
> > >>>>    }
> > >>>> @@ -252,8 +264,16 @@ static int _aggregate_choices(struct device *=
dev, void *data)
> > >>>>           handler =3D to_pprof_handler(dev);
> > >>>>           if (test_bit(PLATFORM_PROFILE_LAST, aggregate))
> > >>>>                   bitmap_copy(aggregate, handler->choices, PLATFOR=
M_PROFILE_LAST);
> > >>>> -       else
> > >>>> +       else {
> > >>>> +               /* treat quiet and low power the same for aggregat=
ion purposes */
> > >>>> +               if (test_bit(PLATFORM_PROFILE_QUIET, handler->choi=
ces) &&
> > >>>> +                   test_bit(PLATFORM_PROFILE_LOW_POWER, aggregate=
))
> > >>>> +                       set_bit(PLATFORM_PROFILE_QUIET, aggregate)=
;
> > >>>> +               else if (test_bit(PLATFORM_PROFILE_LOW_POWER, hand=
ler->choices) &&
> > >>>> +                        test_bit(PLATFORM_PROFILE_QUIET, aggregat=
e))
> > >>>> +                       set_bit(PLATFORM_PROFILE_LOW_POWER, aggreg=
ate);
> > >>>>                   bitmap_and(aggregate, handler->choices, aggregat=
e, PLATFORM_PROFILE_LAST);
> > >>>> +       }
> > >>>
> > >>> So you end up showing both? If that's the case, isn't it equivalent=
 to
> > >>> just make amd-pmf show both quiet and low-power?
> > >>>
> > >>> I guess it is not ideal for framework devices. But if asus devices =
end
> > >>> up showing both, then it should be ok for framework devices to show
> > >>> both.
> > >>>
> > >>> I like the behavior of the V1 personally.
> > >>
> > >> No; this doesn't cause it to show both.  It only causes one to show =
up.
> > >
> > > Which may not be the one that was shown before IIUC and that's not go=
od.
> > >
> > > What actually is the problem with the previous version?
> >
> > Functionally?  Nothing.  This was to demonstrate the other way to do it
> > that I preferred and get feedback on it as an alternative.
> >
> > If you and Ilpo are happy with v1 that's totally fine and we can go wit=
h
> > that.
>=20
> I'd prefer to go for the v1 at this point because it fixes a
> regression affecting user space that needs to be addressed before the
> 6.14 release (and there is not too much time left) and it has been
> checked on the affected systems.
>=20
> Ilpo, do you agree?
>=20

Yes, I'm fine with that.

I would have acked those patches earlier but noticed they'd managed to in=
=20
the meantime come up yet another version of the fix so I waited some more.
I've added my ack there now.

--=20
 i.
--8323328-2083532595-1741105319=:931--

