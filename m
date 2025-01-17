Return-Path: <linux-acpi+bounces-10741-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8336FA15598
	for <lists+linux-acpi@lfdr.de>; Fri, 17 Jan 2025 18:20:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BE361673B2
	for <lists+linux-acpi@lfdr.de>; Fri, 17 Jan 2025 17:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 841FA19CC34;
	Fri, 17 Jan 2025 17:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aStRgvEl"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D4625A643;
	Fri, 17 Jan 2025 17:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737134401; cv=none; b=Zz7HwGUBbiLqeC3kf5o6qL5fBDDwJahJy9EavlVX5N4KwvDkDU8IhrXlU5rvfcrG8MrMbUb+FdGFddiWlDro3K0HNuu3o/w1ISsXZduwSEBVcc9B1IMMLMckMoSZPm1w9v4S6EPOiWv1Fa/P5jmhndLVOIvZsUnneM8r8U5NycE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737134401; c=relaxed/simple;
	bh=Q7JXFmbEwyi2AuI6PcTDZpPbuZ/DFXBIQbTHw1eHUVM=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=CIsECBu5yoQdn/whW4mfmG3kpeBicZMKvTh6HdlbcLSocYjJ9GZkzVDeZZzRycVe7UXGs7xHAGtQD3HjJDIcgHBGJhW2yLy9FM7noStFjFkZQkMxXwGo3HrEh4ykKmkB+DcPOF7ckvROPhlwq9x/IHRzsoRoF2yGAo9vRko6IR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aStRgvEl; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737134400; x=1768670400;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Q7JXFmbEwyi2AuI6PcTDZpPbuZ/DFXBIQbTHw1eHUVM=;
  b=aStRgvEl2pkELYJajHn9fmFCJxeqWQ+kFg4lE+erZA6ghGr4P+XRwHDn
   C3dySYwWOSwVIOD1c9HS1rjZB6miukGh4Y731Tx+uH9iQal+Q0y3fJOtZ
   zGZEVXescQ9x0A3p9T0QUTjsd23UQMy4EPGPvi58iPH6FFg1FGJaihLfC
   bjEzN6iIP3F8v85n1jF0sxA5bIC/1Ac3EVetWARNuABhVDNnqdBFLaCTg
   jnKSk4rdFTJXFmjF9JEii9yGOIuF5zR+GnDxxyA9QpnsBSHRcJMQUHJ+c
   JaI+sP5kXCkzY3WWDBlZ87qHZBq/g+D9IfuNuPb59w6JTHnYBydtrLqSd
   w==;
X-CSE-ConnectionGUID: 5tsUmfbLQXWYNxFFb298gg==
X-CSE-MsgGUID: yRZ3s45oQ9a09WdTnMq8vg==
X-IronPort-AV: E=McAfee;i="6700,10204,11318"; a="41339563"
X-IronPort-AV: E=Sophos;i="6.13,212,1732608000"; 
   d="scan'208";a="41339563"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2025 09:19:59 -0800
X-CSE-ConnectionGUID: eMatHeCPT+yvElMzb0Xgvg==
X-CSE-MsgGUID: 7sD+sG0xRbykgSLbsRyNaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,212,1732608000"; 
   d="scan'208";a="105822656"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.76])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2025 09:19:50 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 17 Jan 2025 19:19:47 +0200 (EET)
To: Kurt Borja <kuurtb@gmail.com>
cc: Mark Pearson <mpearson-lenovo@squebb.ca>, 
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
In-Reply-To: <D74IM4AZ87C9.1R1S1KOA89PX7@gmail.com>
Message-ID: <f8678f9c-56c2-b3a9-f24d-04c9433dba9f@linux.intel.com>
References: <20250116002721.75592-1-kuurtb@gmail.com> <1eb2720a-c9af-4e5c-8df2-c4ce3c017d5c@app.fastmail.com> <3aab5072-f032-7458-56af-1d45e89a5d44@linux.intel.com> <D74IM4AZ87C9.1R1S1KOA89PX7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1934912631-1737134387=:932"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1934912631-1737134387=:932
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 17 Jan 2025, Kurt Borja wrote:

> On Fri Jan 17, 2025 at 11:42 AM -05, Ilpo J=C3=A4rvinen wrote:
> > On Thu, 16 Jan 2025, Mark Pearson wrote:
> >
> > > Hi
> > >=20
> > > On Wed, Jan 15, 2025, at 7:27 PM, Kurt Borja wrote:
> > > > Hi :)
> > > >
> > > > The merge window is about to open, so I rebased this patchset on to=
p of
> > > > pdx86/review-ilpo-next to pick up acer-wmi latest commits, in case =
we
> > > > manage to squeeze this into v6.14.
> > > >
> > > > ~ Kurt
> > > > ---
> > > > v3 -> v4:
> > > >
> > > > [09/19]
> > > >   - Replace error message with a user-friendly one
> > > >
> > > > v3:=20
> > > > https://lore.kernel.org/platform-driver-x86/20250115071022.4815-1-k=
uurtb@gmail.com/
> > > >
> > > > Kurt Borja (19):
> > > >   ACPI: platform_profile: Replace *class_dev member with class_dev
> > > >   ACPI: platform_profile: Let drivers set drvdata to the class devi=
ce
> > > >   ACPI: platform_profile: Remove platform_profile_handler from call=
backs
> > > >   ACPI: platform_profile: Add `ops` member to handlers
> > > >   ACPI: platform_profile: Add `probe` to platform_profile_ops
> > > >   platform/surface: surface_platform_profile: Use
> > > >     devm_platform_profile_register()
> > > >   platform/x86: acer-wmi: Use devm_platform_profile_register()
> > > >   platform/x86: amd: pmf: sps: Use devm_platform_profile_register()
> > > >   platform/x86: asus-wmi: Use devm_platform_profile_register()
> > > >   platform/x86: dell-pc: Use devm_platform_profile_register()
> > > >   platform/x86: ideapad-laptop: Use devm_platform_profile_register(=
)
> > > >   platform/x86: hp-wmi: Use devm_platform_profile_register()
> > > >   platform/x86: inspur_platform_profile: Use
> > > >     devm_platform_profile_register()
> > > >   platform/x86: thinkpad_acpi: Use devm_platform_profile_register()
> > > >   ACPI: platform_profile: Remove platform_profile_handler from expo=
rted
> > > >     symbols
> > > >   ACPI: platform_profile: Move platform_profile_handler
> > > >   ACPI: platform_profile: Clean platform_profile_handler
> > > >   ACPI: platform_profile: Add documentation
> > > >   ACPI: platform_profile: Add a prefix to log messages
> > > >
> > > >  .../ABI/testing/sysfs-class-platform-profile  |  44 +++++
> > > >  drivers/acpi/platform_profile.c               | 172 +++++++++++++-=
----
> > > >  .../surface/surface_platform_profile.c        |  48 ++---
> > > >  drivers/platform/x86/acer-wmi.c               | 114 ++++++------
> > > >  drivers/platform/x86/amd/pmf/core.c           |   1 -
> > > >  drivers/platform/x86/amd/pmf/pmf.h            |   3 +-
> > > >  drivers/platform/x86/amd/pmf/sps.c            |  51 +++---
> > > >  drivers/platform/x86/asus-wmi.c               |  55 +++---
> > > >  drivers/platform/x86/dell/alienware-wmi.c     |  34 ++--
> > > >  drivers/platform/x86/dell/dell-pc.c           |  60 +++---
> > > >  drivers/platform/x86/hp/hp-wmi.c              |  83 +++++----
> > > >  drivers/platform/x86/ideapad-laptop.c         |  45 +++--
> > > >  .../platform/x86/inspur_platform_profile.c    |  48 +++--
> > > >  drivers/platform/x86/thinkpad_acpi.c          |  37 ++--
> > > >  include/linux/platform_profile.h              |  37 ++--
> > > >  15 files changed, 495 insertions(+), 337 deletions(-)
> > > >  create mode 100644 Documentation/ABI/testing/sysfs-class-platform-=
profile
> > > >
> > > >
> > > > base-commit: d98bf6a6ed61a8047e199495b0887cce392f8e5b
> > > > --=20
> > > > 2.48.1
> > >=20
> > > For the series up to v4 commit 15/19:
> > > Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> > >=20
> > > I need to go over the last few commits just once more, as there a few=
=20
> > > pieces I need to get my head around - and I'm not going to get it don=
e=20
> > > this evening. Hope it's OK to add review for the bits that I have don=
e.
> >
> > I, for the first time ever, tested filter-branch and after some initial=
=20
> > hickups on how to specify the commit range, got your Reviewed-bys added
> > with single command :-).
>=20
> Awesome! I believe commit 15/19
>=20
> a213108c01e0 ("ACPI: platform_profile: Remove platform_profile_handler fr=
om exported symbols")
>=20
> is still missing a rev-by by Mark, if there is still time.

Thanks for noticing this. I just recalled the patch numbering wrong.

It should be fixed now.

--=20
 i.

--8323328-1934912631-1737134387=:932--

