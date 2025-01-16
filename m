Return-Path: <linux-acpi+bounces-10726-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1667A13EEE
	for <lists+linux-acpi@lfdr.de>; Thu, 16 Jan 2025 17:10:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07CCB162312
	for <lists+linux-acpi@lfdr.de>; Thu, 16 Jan 2025 16:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E23C222CF23;
	Thu, 16 Jan 2025 16:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TmZhn6XL"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC05922CA1F;
	Thu, 16 Jan 2025 16:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737043804; cv=none; b=UAfQTV3QROl3F3CPwb/GytI2IkWarmFke5c+/17yBSE/0jzq8klTnsJ/sjTkVdWWOcz0g+B2ti0Fnr+5xCA0nfD2IOvPQxjf4eTBPJ7RRc5sAONqLx4fdLmQXjgvKlLaqGtI0cAPgwBm8BWCD0kOChl6+8wwCjYAI+K5mOJ/55c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737043804; c=relaxed/simple;
	bh=W8VIobZSRVf1OK8a6nb3xONSGANGyFq4l3JZ6+ugD+Y=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=mzLnUsqQgl7q47bueRpQ+s8w8Obs8U4RwGoU6NiTxkfiX+1UUYAgHi9s5E0kcBCuCiexet1cIDVzqyyDJLnCMnJlJmXFMFMW+P/GSfdUuaE2zSQTOpwQi5OfHLyLDxdg3rfQlN/gMBXPj8Pyx+ZWpSmqa6DCy6SxYBq3ZgTEjqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TmZhn6XL; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737043803; x=1768579803;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=W8VIobZSRVf1OK8a6nb3xONSGANGyFq4l3JZ6+ugD+Y=;
  b=TmZhn6XLoum5xN82zk2QdLNOqQ82OHrxktABKetYbu2vPP7dID+S9teP
   gw7Jvz//yR0RxGuDwxuboQwwrHdvRqdJW2/ziHZwrpBcL4DI8Q7Ek/H2c
   3h74RO9Sqo3YfpLHYISLx3oblnJh8ufITB6cA7pLN6ORoXW5yhpRJuBjD
   6C7+sQe3Teo7cBpelRk+xwLzFO9wtCmzAxGdrxx+tCFKgABdZSXxEfM8U
   V9iwrys+x7oOmIyOxt0i+Au6VdneAP1kBkEFQsA8GuqKmlpRG1V03/ZTS
   gx42IsTF+mvbyJcppjHei09bu5wmXa+QTch6S75+We+XWWd3lHKSJVKx6
   g==;
X-CSE-ConnectionGUID: QPmDBFPGTRunzXt/1Aq+0Q==
X-CSE-MsgGUID: 3Tv1PsbSQw2ygfUp9KEQ4A==
X-IronPort-AV: E=McAfee;i="6700,10204,11317"; a="37597301"
X-IronPort-AV: E=Sophos;i="6.13,209,1732608000"; 
   d="scan'208";a="37597301"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2025 08:10:01 -0800
X-CSE-ConnectionGUID: +9b7GambQ1ew3SDhGzmB2g==
X-CSE-MsgGUID: EHjKv30cShygoiSa4uHwbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="110511626"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.116])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2025 08:09:53 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 16 Jan 2025 18:09:49 +0200 (EET)
To: Kurt Borja <kuurtb@gmail.com>
cc: platform-driver-x86@vger.kernel.org, 
    "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
    linux-acpi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    Mario Limonciello <mario.limonciello@amd.com>, Armin Wolf <W_Armin@gmx.de>, 
    Joshua Grisham <josh@joshuagrisham.com>, 
    "Derek J. Clark" <derekjohn.clark@gmail.com>, 
    Hans de Goede <hdegoede@redhat.com>, 
    Maximilian Luz <luzmaximilian@gmail.com>, "Lee, Chun-Yi" <jlee@suse.com>, 
    Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, 
    Corentin Chary <corentin.chary@gmail.com>, 
    "Luke D. Jones" <luke@ljones.dev>, Lyndon Sanche <lsanche@lyndeno.ca>, 
    Ike Panhc <ike.pan@canonical.com>, 
    Henrique de Moraes Holschuh <hmh@hmh.eng.br>, 
    Mark Pearson <mpearson-lenovo@squebb.ca>, 
    Alexis Belmonte <alexbelm48@gmail.com>, Ai Chao <aichao@kylinos.cn>, 
    Gergo Koteles <soyer@irl.hu>, Dell.Client.Kernel@dell.com, 
    ibm-acpi-devel@lists.sourceforge.net
Subject: Re: [PATCH v4 00/19] Hide platform_profile_handler from consumers
In-Reply-To: <20250116002721.75592-1-kuurtb@gmail.com>
Message-ID: <a5f7d82f-23a7-8e6a-9e68-9f302cf177d7@linux.intel.com>
References: <20250116002721.75592-1-kuurtb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 15 Jan 2025, Kurt Borja wrote:

> The merge window is about to open, so I rebased this patchset on top of
> pdx86/review-ilpo-next to pick up acer-wmi latest commits, in case we
> manage to squeeze this into v6.14.

Hi all,

I was hoping to finish this in this cycle since it has been so close and 
has only required minor tweaks recently.

I went to review the changes once again and ended up applying this now 
into the review-ilpo-next branch. Thank you all who worked on to improve 
this series! :-)

There were minor nits, however, I hadto address while applying. I added 
the justification into 5/19 commit message and changed a few trivial 
things in the code. Please check that the diff compared with your series 
w/o any modifications makes sense:


diff --git a/Documentation/ABI/testing/sysfs-class-platform-profile b/Documentation/ABI/testing/sysfs-class-platform-profile
index b5a3600080bc..dc72adfb830a 100644
--- a/Documentation/ABI/testing/sysfs-class-platform-profile
+++ b/Documentation/ABI/testing/sysfs-class-platform-profile
@@ -1,12 +1,15 @@
 What:		/sys/class/platform-profile/platform-profile-X/name
-Date:		January 2025
+Date:		March 2025
+KernelVersion:	6.14
 Description:	Name of the class device given by the driver.
 
 		RO
 
 What:		/sys/class/platform-profile/platform-profile-X/choices
-Date:		January 2025
-Description:	This file contains a space-separated list of profiles supported for this device.
+Date:		March 2025
+KernelVersion:	6.14
+Description:	This file contains a space-separated list of profiles supported
+		for this device.
 
 		Drivers must use the following standard profile-names:
 
@@ -26,7 +29,8 @@ Description:	This file contains a space-separated list of profiles supported for
 		RO
 
 What:		/sys/class/platform-profile/platform-profile-X/profile
-Date:		January 2025
+Date:		March 2025
+KernelVersion:	6.14
 Description:	Reading this file gives the current selected profile for this
 		device. Writing this file with one of the strings from
 		platform_profile_choices changes the profile to the new value.
diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index c9e46b6e27da..fc92e43d0fe9 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -540,7 +540,7 @@ struct device *platform_profile_register(struct device *dev, const char *name,
 	pprof->dev.parent = dev;
 	dev_set_drvdata(&pprof->dev, drvdata);
 	dev_set_name(&pprof->dev, "platform-profile-%d", pprof->minor);
-	/* device_register() takes ownership of ppdev */
+	/* device_register() takes ownership of pprof/ppdev */
 	ppdev = &no_free_ptr(pprof)->dev;
 	err = device_register(ppdev);
 	if (err) {
diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 9a485f777591..1032c0e84e3d 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -3894,7 +3894,7 @@ static int platform_profile_setup(struct asus_wmi *asus)
 	asus->ppdev = devm_platform_profile_register(dev, "asus-wmi", asus,
 						     &asus_wmi_platform_profile_ops);
 	if (IS_ERR(asus->ppdev)) {
-		dev_err(dev, "Failed to register a platform_profile class device");
+		dev_err(dev, "Failed to register a platform_profile class device\n");
 		return PTR_ERR(asus->ppdev);
 	}
 
diff --git a/drivers/platform/x86/dell/dell-pc.c b/drivers/platform/x86/dell/dell-pc.c
index 1874d4adfb8a..483240bb36e7 100644
--- a/drivers/platform/x86/dell/dell-pc.c
+++ b/drivers/platform/x86/dell/dell-pc.c
@@ -270,17 +270,16 @@ static int thermal_init(void)
 	if (IS_ERR(platform_device))
 		return PTR_ERR(platform_device);
 
-	/* Clean up if failed */
 	ppdev = devm_platform_profile_register(&platform_device->dev, "dell-pc",
 					       NULL, &dell_pc_platform_profile_ops);
 	if (IS_ERR(ppdev)) {
 		ret = PTR_ERR(ppdev);
-		goto cleanup_thermal_handler;
+		goto cleanup_platform_device;
 	}
 
 	return 0;
 
-cleanup_thermal_handler:
+cleanup_platform_device:
 	platform_device_unregister(platform_device);
 
 	return ret;


> 
> ~ Kurt
> ---
> v3 -> v4:
> 
> [09/19]
>   - Replace error message with a user-friendly one
> 
> v3: https://lore.kernel.org/platform-driver-x86/20250115071022.4815-1-kuurtb@gmail.com/
> 
> Kurt Borja (19):
>   ACPI: platform_profile: Replace *class_dev member with class_dev
>   ACPI: platform_profile: Let drivers set drvdata to the class device
>   ACPI: platform_profile: Remove platform_profile_handler from callbacks
>   ACPI: platform_profile: Add `ops` member to handlers
>   ACPI: platform_profile: Add `probe` to platform_profile_ops
>   platform/surface: surface_platform_profile: Use
>     devm_platform_profile_register()
>   platform/x86: acer-wmi: Use devm_platform_profile_register()
>   platform/x86: amd: pmf: sps: Use devm_platform_profile_register()
>   platform/x86: asus-wmi: Use devm_platform_profile_register()
>   platform/x86: dell-pc: Use devm_platform_profile_register()
>   platform/x86: ideapad-laptop: Use devm_platform_profile_register()
>   platform/x86: hp-wmi: Use devm_platform_profile_register()
>   platform/x86: inspur_platform_profile: Use
>     devm_platform_profile_register()
>   platform/x86: thinkpad_acpi: Use devm_platform_profile_register()
>   ACPI: platform_profile: Remove platform_profile_handler from exported
>     symbols
>   ACPI: platform_profile: Move platform_profile_handler
>   ACPI: platform_profile: Clean platform_profile_handler
>   ACPI: platform_profile: Add documentation
>   ACPI: platform_profile: Add a prefix to log messages
> 
>  .../ABI/testing/sysfs-class-platform-profile  |  44 +++++
>  drivers/acpi/platform_profile.c               | 172 +++++++++++++-----
>  .../surface/surface_platform_profile.c        |  48 ++---
>  drivers/platform/x86/acer-wmi.c               | 114 ++++++------
>  drivers/platform/x86/amd/pmf/core.c           |   1 -
>  drivers/platform/x86/amd/pmf/pmf.h            |   3 +-
>  drivers/platform/x86/amd/pmf/sps.c            |  51 +++---
>  drivers/platform/x86/asus-wmi.c               |  55 +++---
>  drivers/platform/x86/dell/alienware-wmi.c     |  34 ++--
>  drivers/platform/x86/dell/dell-pc.c           |  60 +++---
>  drivers/platform/x86/hp/hp-wmi.c              |  83 +++++----
>  drivers/platform/x86/ideapad-laptop.c         |  45 +++--
>  .../platform/x86/inspur_platform_profile.c    |  48 +++--
>  drivers/platform/x86/thinkpad_acpi.c          |  37 ++--
>  include/linux/platform_profile.h              |  37 ++--
>  15 files changed, 495 insertions(+), 337 deletions(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-class-platform-profile
> 
> 
> base-commit: d98bf6a6ed61a8047e199495b0887cce392f8e5b
> 

-- 
 i.


