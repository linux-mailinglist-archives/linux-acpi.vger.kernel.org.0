Return-Path: <linux-acpi+bounces-10405-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED936A04520
	for <lists+linux-acpi@lfdr.de>; Tue,  7 Jan 2025 16:48:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD2391887890
	for <lists+linux-acpi@lfdr.de>; Tue,  7 Jan 2025 15:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8EEF1F37DD;
	Tue,  7 Jan 2025 15:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OhOLfGZS"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9201EE7BB;
	Tue,  7 Jan 2025 15:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736264910; cv=none; b=PlR3OU2AHDlydmtdRqsZCu89WYTKyEWLEiPh9EZH0DiPpFTrGZ7eM9AP4aIn6j+bAjlsjTI/WG5Li75hrTVQC4XB/ee6j+Fi9xv3e3hMiWd7vwL1D4EShZ42f9mdml8Ioft3yQumI2O4ElFYprOGwchIjj5mtaBKzV8seR/RA04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736264910; c=relaxed/simple;
	bh=CaHjk1NO/x+gFM2Y+rIaeQEdIEy2bxyc/1fziZMlsBM=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=iV8eMSywRN9N8pVmJiQzkNre+pGBXrfJoEypuL+CpcUKOE6nTx/mUggJa/2NsrZVXMbPhIi09Ew7Gcq3hucJHOYvXmNvDaPoQFoeU8nDntA8e4FK526aDXsBqq138NSV+b2MZzNMaR/7Fx8vXSiAOifgx/ncwBYvEjCZEn/XEvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OhOLfGZS; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736264909; x=1767800909;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=CaHjk1NO/x+gFM2Y+rIaeQEdIEy2bxyc/1fziZMlsBM=;
  b=OhOLfGZS51JWDWQKR1kNdd6be3i9CSxcsRbsYAlNyMbkbEEJzfMSXgcW
   2RLZULoguLPmmZDIq43TyGatjcGTUzbtKRSWKGLFgfQAYxTN3l4UcJzFL
   9HZemvuAZJgVXL54woTPLh7piMwBhrnXQEUJijxvRHD3VpB7JXj6lOg74
   0iMNmIPOV0iey0QegTEickzrbJRtL3pJ0uDROVdkWw/kX06jz3P/l6ZBC
   kckh7XYrko34uF49jdYQuQyDjj8HOEKdOOXEadxscRP7PdbYHnw+vZzqa
   wcE0DMju5B15u4ZJDpOQtNZ5Y2E8EdZ9Ywx9FZ6AaIJ6psIist/0/6K7l
   g==;
X-CSE-ConnectionGUID: InTC2WNwQ7a3zxFrG4Hdhg==
X-CSE-MsgGUID: 874T0CPbRZu5igcLKG6YTg==
X-IronPort-AV: E=McAfee;i="6700,10204,11308"; a="47811359"
X-IronPort-AV: E=Sophos;i="6.12,295,1728975600"; 
   d="scan'208";a="47811359"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2025 07:48:28 -0800
X-CSE-ConnectionGUID: cbU9Ei/ISo2GpH/dNdhiWQ==
X-CSE-MsgGUID: +gjx2I2WRuuADvC7Aaymaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,296,1728975600"; 
   d="scan'208";a="102705991"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.206])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2025 07:48:23 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 7 Jan 2025 17:48:19 +0200 (EET)
To: Kurt Borja <kuurtb@gmail.com>
cc: platform-driver-x86@vger.kernel.org, W_Armin@gmx.de, 
    Hans de Goede <hdegoede@redhat.com>, lenb@kernel.org, 
    linux-acpi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    mario.limonciello@amd.com, Mark Pearson <mpearson-lenovo@squebb.ca>, 
    "Rafael J. Wysocki" <rafael@kernel.org>, soyer@irl.hu
Subject: Re: [PATCH v2 0/2] Device managed platform_profile_register()
In-Reply-To: <q45nl5wdout46frnjbkufvi2pmyhz3cfyp72qyqrsnhpnlmhue@3no6u65stho2>
Message-ID: <687daa3a-af4e-f959-aeb9-43fccd1b8989@linux.intel.com>
References: <20241224140131.30362-2-kuurtb@gmail.com> <00b64207-ec35-5c99-9bdc-13c77e51e453@linux.intel.com> <q45nl5wdout46frnjbkufvi2pmyhz3cfyp72qyqrsnhpnlmhue@3no6u65stho2>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1276535145-1736264899=:1001"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1276535145-1736264899=:1001
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 31 Dec 2024, Kurt Borja wrote:
> On Mon, Dec 30, 2024 at 08:31:28PM +0200, Ilpo J=E4rvinen wrote:
> > On Tue, 24 Dec 2024, Kurt Borja wrote:
> >=20
> > > Hi :)
> > >=20
> > > This is meant to be merged on the pdx86 tree.
> > >=20
> > > ~ Kurt
> > >=20
> > > v2:
> > >  - Replaced convoluted cast with intermediate variable (1/2)
> > >  - Restored dropped empty line (1/2)
> > >  - Couldn't incorporate Armin's second comment. I probably didn't
> > >    understand it (1/2)
> > > v1:=20
> > >  - https://lore.kernel.org/platform-driver-x86/20241221070817.3764-2-=
kuurtb@gmail.com
> > >=20
> > > Kurt Borja (2):
> > >   ACPI: platform_profile: Add devm_platform_profile_register()
> > >   alienware-wmi: Use devm_platform_profile_register()
> > >=20
> > >  drivers/acpi/platform_profile.c           | 29 +++++++++++++++++++++=
++
> > >  drivers/platform/x86/dell/alienware-wmi.c | 10 +-------
> > >  include/linux/platform_profile.h          |  1 +
> > >  3 files changed, 31 insertions(+), 9 deletions(-)
> >=20
> > Thanks. I've now applied these.
> >=20
> > The first patch is already in the for-next branch and the second is=20
> > currently in the review-ilpo-next branch (as I wanted to retain ability=
 to=20
> > easily separate changes into platform_profile.c from the rest, they go =
to=20
> > their own branch first).
>=20
> Thanks Ilpo!
>=20
> Should I rebase the alienware-wmi rework patch series on top of
> review-ilpo-next in v3? Currently it's on top of for-next branch.

Hi Kurt,

You've probably seen it by now but in general, the content in those=20
review-ilpo-* branches is just a staging area to what will become the=20
for-next or fixes branch once LKP has been able to build test the changes.=
=20
If no issues appear, they'll become content of the for-next or fixes=20
branch as is.

In case of problems, I will rebase/edit/drop patches in the=20
review-ilpo-* branches with a relatively low bar so it might not always=20
be fast-forwardable but other than that minor annoyance, I see no issue in=
=20
basing your work on top of those branches (in particular, if you know=20
there are going to be conflicts).

I might rebase also fixes and for-next at times, but I try to avoid=20
having to do that.

--=20
 i.

--8323328-1276535145-1736264899=:1001--

