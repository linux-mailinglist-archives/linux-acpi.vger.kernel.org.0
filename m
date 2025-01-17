Return-Path: <linux-acpi+bounces-10739-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13119A15487
	for <lists+linux-acpi@lfdr.de>; Fri, 17 Jan 2025 17:43:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B8A4188911F
	for <lists+linux-acpi@lfdr.de>; Fri, 17 Jan 2025 16:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B38619CC27;
	Fri, 17 Jan 2025 16:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PutZ6ynX"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2994E33062;
	Fri, 17 Jan 2025 16:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737132176; cv=none; b=QuIy2+DzV25eT8ogqcikPfmrXsP/V732N6Zhe5BZmjcodrAuUIK4uRXJUVSaf6Xk98KmZ99qQud+fDSU/IbqX7Tgkbl/TEQw8c62Y8ZWjQaIUfvmbF5CF9qSprDlgk4ayMO3n8UfLYXiRueTw6OrD6lSfunuf44/alSV3BwmRq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737132176; c=relaxed/simple;
	bh=RL3soOxhPtQsaBhYmUFABIcYNw2jzZXmS4ftUKKHWrE=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=EelVrTJqqx8qnmBY9yf1wNcFHajoDpS5+tUaR3gaiZ2LB0wGAXsl6cLDbbeDClNZuylQKLV+8uSP52s0FgOAcKdFdlniUHtc39y5prqi8VTxiZ8VvpaBhhwvuoscLBXuUc5d4lOzJtn/aebeWENbOmA3Nycp4PPfwGT1mBcdFRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PutZ6ynX; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737132175; x=1768668175;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=RL3soOxhPtQsaBhYmUFABIcYNw2jzZXmS4ftUKKHWrE=;
  b=PutZ6ynXM5J5KPji2lfDFuK/ZDZX6MRC6UMmy3atUMwp+Xr5lazPEKFE
   39JqtKDJZ7JnpONT4teBq9+HMh7sIlFWAItyJe65nQAotrZFfOqiyGKtz
   uFcrre8VH8+G46GPhjtp1TmvALk8nI16QtQR0xSbwMO0i3YwBxtkf97HR
   VVNpYBwyZi6SMbXB8N7lZ0SnPud5CZWYxXj4cEns++sBVruUYvpwTDK3y
   t0HoM3lRf72tUxGKRovpEnti1mFwsMbgBMYt7dpyb6GHYtjUUSQ6jYxC5
   VyhBL+f2zupgWbdvBswKQd8fRPRblEPCozp9OtqHqO9Kzc6HwHaBmatI+
   Q==;
X-CSE-ConnectionGUID: 3y3qkZ2uTUKPZfppGaYQxg==
X-CSE-MsgGUID: DlPdCYEPQ8uOygpP0kXdZw==
X-IronPort-AV: E=McAfee;i="6700,10204,11318"; a="48231581"
X-IronPort-AV: E=Sophos;i="6.13,212,1732608000"; 
   d="scan'208";a="48231581"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2025 08:42:54 -0800
X-CSE-ConnectionGUID: SeXuZ7zEQfSQse9gjhDF+A==
X-CSE-MsgGUID: UZfCO3EmRK6cbgrcvsgDPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,212,1732608000"; 
   d="scan'208";a="105694783"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.76])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2025 08:42:46 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 17 Jan 2025 18:42:42 +0200 (EET)
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
In-Reply-To: <1eb2720a-c9af-4e5c-8df2-c4ce3c017d5c@app.fastmail.com>
Message-ID: <3aab5072-f032-7458-56af-1d45e89a5d44@linux.intel.com>
References: <20250116002721.75592-1-kuurtb@gmail.com> <1eb2720a-c9af-4e5c-8df2-c4ce3c017d5c@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 16 Jan 2025, Mark Pearson wrote:

> Hi
> 
> On Wed, Jan 15, 2025, at 7:27 PM, Kurt Borja wrote:
> > Hi :)
> >
> > The merge window is about to open, so I rebased this patchset on top of
> > pdx86/review-ilpo-next to pick up acer-wmi latest commits, in case we
> > manage to squeeze this into v6.14.
> >
> > ~ Kurt
> > ---
> > v3 -> v4:
> >
> > [09/19]
> >   - Replace error message with a user-friendly one
> >
> > v3: 
> > https://lore.kernel.org/platform-driver-x86/20250115071022.4815-1-kuurtb@gmail.com/
> >
> > Kurt Borja (19):
> >   ACPI: platform_profile: Replace *class_dev member with class_dev
> >   ACPI: platform_profile: Let drivers set drvdata to the class device
> >   ACPI: platform_profile: Remove platform_profile_handler from callbacks
> >   ACPI: platform_profile: Add `ops` member to handlers
> >   ACPI: platform_profile: Add `probe` to platform_profile_ops
> >   platform/surface: surface_platform_profile: Use
> >     devm_platform_profile_register()
> >   platform/x86: acer-wmi: Use devm_platform_profile_register()
> >   platform/x86: amd: pmf: sps: Use devm_platform_profile_register()
> >   platform/x86: asus-wmi: Use devm_platform_profile_register()
> >   platform/x86: dell-pc: Use devm_platform_profile_register()
> >   platform/x86: ideapad-laptop: Use devm_platform_profile_register()
> >   platform/x86: hp-wmi: Use devm_platform_profile_register()
> >   platform/x86: inspur_platform_profile: Use
> >     devm_platform_profile_register()
> >   platform/x86: thinkpad_acpi: Use devm_platform_profile_register()
> >   ACPI: platform_profile: Remove platform_profile_handler from exported
> >     symbols
> >   ACPI: platform_profile: Move platform_profile_handler
> >   ACPI: platform_profile: Clean platform_profile_handler
> >   ACPI: platform_profile: Add documentation
> >   ACPI: platform_profile: Add a prefix to log messages
> >
> >  .../ABI/testing/sysfs-class-platform-profile  |  44 +++++
> >  drivers/acpi/platform_profile.c               | 172 +++++++++++++-----
> >  .../surface/surface_platform_profile.c        |  48 ++---
> >  drivers/platform/x86/acer-wmi.c               | 114 ++++++------
> >  drivers/platform/x86/amd/pmf/core.c           |   1 -
> >  drivers/platform/x86/amd/pmf/pmf.h            |   3 +-
> >  drivers/platform/x86/amd/pmf/sps.c            |  51 +++---
> >  drivers/platform/x86/asus-wmi.c               |  55 +++---
> >  drivers/platform/x86/dell/alienware-wmi.c     |  34 ++--
> >  drivers/platform/x86/dell/dell-pc.c           |  60 +++---
> >  drivers/platform/x86/hp/hp-wmi.c              |  83 +++++----
> >  drivers/platform/x86/ideapad-laptop.c         |  45 +++--
> >  .../platform/x86/inspur_platform_profile.c    |  48 +++--
> >  drivers/platform/x86/thinkpad_acpi.c          |  37 ++--
> >  include/linux/platform_profile.h              |  37 ++--
> >  15 files changed, 495 insertions(+), 337 deletions(-)
> >  create mode 100644 Documentation/ABI/testing/sysfs-class-platform-profile
> >
> >
> > base-commit: d98bf6a6ed61a8047e199495b0887cce392f8e5b
> > -- 
> > 2.48.1
> 
> For the series up to v4 commit 15/19:
> Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> 
> I need to go over the last few commits just once more, as there a few 
> pieces I need to get my head around - and I'm not going to get it done 
> this evening. Hope it's OK to add review for the bits that I have done.

I, for the first time ever, tested filter-branch and after some initial 
hickups on how to specify the commit range, got your Reviewed-bys added
with single command :-).

While at it, I also managed to catch one rev-by line without any 
name+email (I assume it was b4 messing something up).

I'll soon want to merge fixes branch into for-next though, and after that 
adding any rev-bys will not be as easy as it was now.

-- 
 i.


