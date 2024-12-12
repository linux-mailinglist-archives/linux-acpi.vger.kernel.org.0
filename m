Return-Path: <linux-acpi+bounces-10125-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C719E9EE87F
	for <lists+linux-acpi@lfdr.de>; Thu, 12 Dec 2024 15:11:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A62016293D
	for <lists+linux-acpi@lfdr.de>; Thu, 12 Dec 2024 14:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A8ED2144A6;
	Thu, 12 Dec 2024 14:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ls8wYXeN"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9772147E5;
	Thu, 12 Dec 2024 14:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734012683; cv=none; b=HbGkFMUxZdRqucvCqKku2Raf3k/vWPfugQapjrLA0gbCV4yx+KbS/aMJSRQYww0aOsZPLoTUQ/bnfrHltIlrw+afEdhKt4DqfSqhnflE9oI90THeMtlc1SsLMA2sGigesf3AFeMCaeLidz+G7QlKgUtCZhBcknZ0FLcnoY8Emfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734012683; c=relaxed/simple;
	bh=3EpobGzETERsdulpRcIj2Hv8kaV36PySw0jBWYiwdzc=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=bThFDENG7lRPzAh2Idpy0PgDbqSbTlOJcImujfAQuTECnO5hgevBvuPTFPSluDxrfq+OyQf2AxSXs9AW6KMAlJrHQ08vIVXHpxO6U6PqELPSvXU66l8LKRC/5/TpCmw+cw4DD7hdo9VESJ5QBzByaR6qHjkydBuY+eJ6PYiS6LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ls8wYXeN; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734012682; x=1765548682;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=3EpobGzETERsdulpRcIj2Hv8kaV36PySw0jBWYiwdzc=;
  b=ls8wYXeNgj9Gd9IksxujxIndfIA6z5pdUis3wklKon5dr36BBLnYiM0i
   kj/YFdoEy/kvUor062osFfihGCtio1je57u/jstZ5RSmHlMDPy0KD8CSU
   2muy+dtNRjp0KFd+ooGe9cSGrZIRSekxUIl4hjq5UfP1eerD9bZVmIs8P
   +h4xOJKkzTBdJfVHDkUtYkMIBplejsVLTFs5KTyKaoMezvdZ4UeI/m+hk
   jN00jWgkIKOrSp9nBxQXVVp4Exu8aZUSxuBkRFdz4vOL9lSF6LEi4RcQl
   AaCWGzMzWSf2sQrssjo10W/94CYskmc8+Oz5BGcC/m2g5MAjGb4KmNJAw
   g==;
X-CSE-ConnectionGUID: rO5sg6+aSJKe0A5FZ3gNPA==
X-CSE-MsgGUID: NH642JiBSjiTLmWY0Wsx/A==
X-IronPort-AV: E=McAfee;i="6700,10204,11284"; a="59825884"
X-IronPort-AV: E=Sophos;i="6.12,228,1728975600"; 
   d="scan'208";a="59825884"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2024 06:11:19 -0800
X-CSE-ConnectionGUID: QNTSIgtDQDyX4HtVGrz/vw==
X-CSE-MsgGUID: B1hx+sobQCS9mIHqveTbNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="127228595"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.137])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2024 06:11:13 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 12 Dec 2024 16:11:10 +0200 (EET)
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
    Mario Limonciello <mario.limonciello@amd.com>
cc: Hans de Goede <hdegoede@redhat.com>, Len Brown <lenb@kernel.org>, 
    Maximilian Luz <luzmaximilian@gmail.com>, Lee Chun-Yi <jlee@suse.com>, 
    Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, 
    Corentin Chary <corentin.chary@gmail.com>, 
    "Luke D . Jones" <luke@ljones.dev>, Ike Panhc <ike.pan@canonical.com>, 
    Henrique de Moraes Holschuh <hmh@hmh.eng.br>, 
    Alexis Belmonte <alexbelm48@gmail.com>, 
    =?ISO-8859-15?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, 
    Ai Chao <aichao@kylinos.cn>, Gergo Koteles <soyer@irl.hu>, 
    open list <linux-kernel@vger.kernel.org>, 
    "open list:ACPI" <linux-acpi@vger.kernel.org>, 
    "open list:MICROSOFT SURFACE PLATFORM PROFILE DRIVER" <platform-driver-x86@vger.kernel.org>, 
    "open list:THINKPAD ACPI EXTRAS DRIVER" <ibm-acpi-devel@lists.sourceforge.net>, 
    Mark Pearson <mpearson-lenovo@squebb.ca>, 
    Matthew Schwartz <matthew.schwartz@linux.dev>
Subject: Re: [PATCH v10 00/22] Add support for binding ACPI platform profile
 to multiple drivers
In-Reply-To: <CAJZ5v0hoD9ZBvsbE4bvfgJc09ijAY421vNngCYaz3qy-Cg2bdw@mail.gmail.com>
Message-ID: <5cae1882-b7c2-9621-e732-336c893e017d@linux.intel.com>
References: <20241206031918.1537-1-mario.limonciello@amd.com> <a34c7648-02cb-76e9-53f4-e54003c98ecb@linux.intel.com> <CAJZ5v0hoD9ZBvsbE4bvfgJc09ijAY421vNngCYaz3qy-Cg2bdw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-126186957-1734012670=:936"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-126186957-1734012670=:936
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 10 Dec 2024, Rafael J. Wysocki wrote:

> Hi Ilpo,
>=20
> On Tue, Dec 10, 2024 at 6:30=E2=80=AFPM Ilpo J=C3=A4rvinen
> <ilpo.jarvinen@linux.intel.com> wrote:
> >
> > Hi Rafael,
> >
> > This series seems ready and Mario has requested it to be merged through
> > platform drivers tree despite majority of changes touching
> > drivers/acpi/platform_profile.c because its API relates to many pdx86
> > drivers.
> >
> > Is that fine with you?
>=20
> Yes, it is, thanks!

Thanks all.

The series has been applied into pdx86/platform-drivers-x86-platform-profil=
e=20
and then merged into the for-next branch.

--=20
 i.


> > On Thu, 5 Dec 2024, Mario Limonciello wrote:
> >
> > > Currently there are a number of ASUS products on the market that happ=
en to
> > > have ACPI objects for amd-pmf to bind to as well as an ACPI platform
> > > profile provided by asus-wmi.
> > >
> > > The ACPI platform profile support created by amd-pmf on these ASUS
> > > products is "Function 9" which is specifically for "BIOS or EC
> > > notification" of power slider position. This feature is actively used
> > > by some designs such as Framework 13 and Framework 16.
> > >
> > > On these ASUS designs we keep on quirking more and more of them to tu=
rn
> > > off this notification so that asus-wmi can bind.
> > >
> > > This however isn't how Windows works.  "Multiple" things are notified=
 for
> > > the power slider position. This series adjusts Linux to behave simila=
rly.
> > >
> > > Multiple drivers can now register an ACPI platform profile and will r=
eact
> > > to set requests.
> > >
> > > To avoid chaos, only positions that are common to both drivers are
> > > accepted when the legacy /sys/firmware/acpi/platform_profile interfac=
e
> > > is used.
> > >
> > > This series also adds a new concept of a "custom" profile.  This allo=
ws
> > > userspace to discover that there are multiple driver handlers that ar=
e
> > > configured differently.
> > >
> > > This series also allows dropping all of the PMF quirks from amd-pmf.
> > >
> > > NOTE: Although this series changes code in acpi platform profile, I t=
hink
> > >       it is better to go through the platform-x86 tree as more driver=
s can
> > >       be introduced during the kernel cycle and should make the chang=
es to
> > >       support class interface when merging.
> > >
> > > v10:
> > >  * Whitespace changes
> > >  * Documentation update for custom in a single driver
> > >
> > > Mario Limonciello (22):
> > >   ACPI: platform-profile: Add a name member to handlers
> > >   platform/x86/dell: dell-pc: Create platform device
> > >   ACPI: platform_profile: Add device pointer into platform profile
> > >     handler
> > >   ACPI: platform_profile: Add platform handler argument to
> > >     platform_profile_remove()
> > >   ACPI: platform_profile: Pass the profile handler into
> > >     platform_profile_notify()
> > >   ACPI: platform_profile: Move sanity check out of the mutex
> > >   ACPI: platform_profile: Move matching string for new profile out of
> > >     mutex
> > >   ACPI: platform_profile: Use guard(mutex) for register/unregister
> > >   ACPI: platform_profile: Use `scoped_cond_guard`
> > >   ACPI: platform_profile: Create class for ACPI platform profile
> > >   ACPI: platform_profile: Add name attribute to class interface
> > >   ACPI: platform_profile: Add choices attribute for class interface
> > >   ACPI: platform_profile: Add profile attribute for class interface
> > >   ACPI: platform_profile: Notify change events on register and
> > >     unregister
> > >   ACPI: platform_profile: Only show profiles common for all handlers
> > >   ACPI: platform_profile: Add concept of a "custom" profile
> > >   ACPI: platform_profile: Make sure all profile handlers agree on
> > >     profile
> > >   ACPI: platform_profile: Check all profile handler to calculate next
> > >   ACPI: platform_profile: Notify class device from
> > >     platform_profile_notify()
> > >   ACPI: platform_profile: Allow multiple handlers
> > >   platform/x86/amd: pmf: Drop all quirks
> > >   Documentation: Add documentation about class interface for platform
> > >     profiles
> > >
> > >  .../ABI/testing/sysfs-platform_profile        |   5 +
> > >  .../userspace-api/sysfs-platform_profile.rst  |  38 ++
> > >  drivers/acpi/platform_profile.c               | 534 ++++++++++++++--=
--
> > >  .../surface/surface_platform_profile.c        |   8 +-
> > >  drivers/platform/x86/acer-wmi.c               |  12 +-
> > >  drivers/platform/x86/amd/pmf/Makefile         |   2 +-
> > >  drivers/platform/x86/amd/pmf/core.c           |   1 -
> > >  drivers/platform/x86/amd/pmf/pmf-quirks.c     |  66 ---
> > >  drivers/platform/x86/amd/pmf/pmf.h            |   3 -
> > >  drivers/platform/x86/amd/pmf/sps.c            |   4 +-
> > >  drivers/platform/x86/asus-wmi.c               |   8 +-
> > >  drivers/platform/x86/dell/alienware-wmi.c     |   8 +-
> > >  drivers/platform/x86/dell/dell-pc.c           |  38 +-
> > >  drivers/platform/x86/hp/hp-wmi.c              |   8 +-
> > >  drivers/platform/x86/ideapad-laptop.c         |   6 +-
> > >  .../platform/x86/inspur_platform_profile.c    |   7 +-
> > >  drivers/platform/x86/thinkpad_acpi.c          |  16 +-
> > >  include/linux/platform_profile.h              |   9 +-
> > >  18 files changed, 559 insertions(+), 214 deletions(-)
> > >  delete mode 100644 drivers/platform/x86/amd/pmf/pmf-quirks.c
> >
> > --
> >  i.
> >
>=20
--8323328-126186957-1734012670=:936--

