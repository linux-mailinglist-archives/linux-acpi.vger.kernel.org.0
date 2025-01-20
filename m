Return-Path: <linux-acpi+bounces-10762-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82DC9A16C5A
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Jan 2025 13:28:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 907863A431A
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Jan 2025 12:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B86FA1DFDB8;
	Mon, 20 Jan 2025 12:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FDCuOWG7"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0B11DF257;
	Mon, 20 Jan 2025 12:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737376121; cv=none; b=aYQUjgKVCWe4I0WqmSSm6Ws/8TmaHoyfxB9xrdUfh/LLuvfgdN9sNITty42jwhPjUd9HEzXBAzfg1xoqa8vP2AcujiZxfeadDD6FsoTZ11TqWlIF9xKrGMNY2MJ7habccezXDuz4DvguBnf0yk3a8+pGdy0yY+NaZM0C9SPyV+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737376121; c=relaxed/simple;
	bh=EF0BsW/iDlobxmed/KsoaXepF7UhyCiZ8lFlifR5/CU=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=oZUHuAvH6phYg3ABwhaFLbDEmb820dl0YbXrbQ2HHhyjGtx0DzEKVO99Mv4G8h4mpSiq8WuVKdQ3P9E7EEQM55JzB2FzbCUPFe/WdZrN5m0e8zkleMJGamQske1X7GDOaQWIVKR2o60umt7o8zes6uppkLpU39R2Yc9oRiz3288=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FDCuOWG7; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737376119; x=1768912119;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=EF0BsW/iDlobxmed/KsoaXepF7UhyCiZ8lFlifR5/CU=;
  b=FDCuOWG7avC1RLm2+2/dXK5xAgN9UvpL3U9bNGF/8+bjOy73GMyvgVsB
   0ccDUeU5q40kJi8/xFBOZG9EzBzj3QG6si1aqZb8mRn40aJgvGQof9SqU
   OkQqiKRDV/amunCEhb9TIpZCn11Fg10LKTJ4ehVXj5uBUdR1Vta3xpzgC
   1jzxY+YmBxNRt+s3EqN2jizW6OR1TLchjfSNdwaNnozWifclJVoVWZUAV
   MUp/xJ0gSjAaMHV8mpwawSwnJJCMxcJuVCNgKG1E+kaIPcxWihr3ucu4o
   YnGL1R+ke5nYFmqKYsfheCN1Ri2EqT1nO3akBOWaFt+eEOWagQvnbybOA
   w==;
X-CSE-ConnectionGUID: 6FxdT4bxSEi0MAvluu0UtQ==
X-CSE-MsgGUID: Fix/ukZQR0Srvaa6FO5now==
X-IronPort-AV: E=McAfee;i="6700,10204,11320"; a="37458065"
X-IronPort-AV: E=Sophos;i="6.13,219,1732608000"; 
   d="scan'208";a="37458065"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2025 04:28:36 -0800
X-CSE-ConnectionGUID: 1UaFwhlNS6OiOAyiPwitGA==
X-CSE-MsgGUID: ezSywaj2RKm3eWs2nWfMGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,219,1732608000"; 
   d="scan'208";a="107045703"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.8])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2025 04:28:27 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 20 Jan 2025 14:28:24 +0200 (EET)
To: Mark Pearson <mpearson-lenovo@squebb.ca>
cc: Kurt Borja <kuurtb@gmail.com>, 
    "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>, 
    "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
    "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, 
    LKML <linux-kernel@vger.kernel.org>, 
    "Limonciello, Mario" <mario.limonciello@amd.com>, 
    Armin Wolf <W_Armin@gmx.de>, Joshua Grisham <josh@joshuagrisham.com>, 
    "Derek J . Clark" <derekjohn.clark@gmail.com>, 
    Hans de Goede <hdegoede@redhat.com>, 
    Maximilian Luz <luzmaximilian@gmail.com>, Lee Chun-Yi <jlee@suse.com>, 
    Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, 
    Corentin Chary <corentin.chary@gmail.com>, 
    "Luke D . Jones" <luke@ljones.dev>, Lyndon Sanche <lsanche@lyndeno.ca>, 
    Ike Panhc <ike.pan@canonical.com>, 
    Henrique de Moraes Holschuh <hmh@hmh.eng.br>, 
    Alexis Belmonte <alexbelm48@gmail.com>, Ai Chao <aichao@kylinos.cn>, 
    Gergo Koteles <soyer@irl.hu>, Dell.Client.Kernel@dell.com, 
    ibm-acpi-devel@lists.sourceforge.net
Subject: Re: [PATCH v4 00/19] Hide platform_profile_handler from consumers
In-Reply-To: <01d3c53e-666a-46d8-b629-ba8a089011ee@app.fastmail.com>
Message-ID: <b6bc4559-b087-5a5d-b254-f5d332880fb3@linux.intel.com>
References: <20250116002721.75592-1-kuurtb@gmail.com> <1eb2720a-c9af-4e5c-8df2-c4ce3c017d5c@app.fastmail.com> <3aab5072-f032-7458-56af-1d45e89a5d44@linux.intel.com> <D74IM4AZ87C9.1R1S1KOA89PX7@gmail.com> <f8678f9c-56c2-b3a9-f24d-04c9433dba9f@linux.intel.com>
 <f4e08213-0f42-4f35-a150-a75bf91537bf@app.fastmail.com> <01d3c53e-666a-46d8-b629-ba8a089011ee@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-104566123-1737375498=:1251"
Content-ID: <3d3ad761-6865-1724-aa70-d532ca32e41e@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-104566123-1737375498=:1251
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <27b750af-c603-3791-6f72-ffa87e0aedbb@linux.intel.com>

On Fri, 17 Jan 2025, Mark Pearson wrote:

>=20
>=20
> On Fri, Jan 17, 2025, at 3:45 PM, Mark Pearson wrote:
> > Hi,
> >
> > On Fri, Jan 17, 2025, at 12:19 PM, Ilpo J=E4rvinen wrote:
> >> On Fri, 17 Jan 2025, Kurt Borja wrote:
> >>
> >>> On Fri Jan 17, 2025 at 11:42 AM -05, Ilpo J=E4rvinen wrote:
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

Thanks a lot for testing this! I've added you tags into the entire series=
=20
now.

--=20
 i.
--8323328-104566123-1737375498=:1251--

