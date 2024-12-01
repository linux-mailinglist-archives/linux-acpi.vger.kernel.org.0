Return-Path: <linux-acpi+bounces-9838-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 693569DF475
	for <lists+linux-acpi@lfdr.de>; Sun,  1 Dec 2024 03:56:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4A0CB21067
	for <lists+linux-acpi@lfdr.de>; Sun,  1 Dec 2024 02:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B60C168BE;
	Sun,  1 Dec 2024 02:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hV3mrotw"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7892BF9E8;
	Sun,  1 Dec 2024 02:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733021767; cv=none; b=i4gi+KYAWioHaMyL5dyTdUr1rDl+YIGypNXP5nhdqJcQko9Y7gi+fzx41zFJqucYCiAbTrdy3KInsfINXiOAUnvYQXwJ5VCspMJxjfJtkajfsCh2vEQmvW5ckoveUQZ2/DHTIRowRKWZJQTt5Vxf3oneC+eiVkqFLAmNFCOFy4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733021767; c=relaxed/simple;
	bh=2MDLGdtixIr+eogn07QqelKmKPJW7oyKKYZK2ByJj5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=keAe4c+uavuY44QhCcoVQQz5q5qt7NjBcPudaLQ2oexUQYgTxTCElTRifBZMrKC8q+gPVKI2HSb34s5ModJLztVD+Z3UBKb5PXfcyBfu/7LWhXUx5V1UZiD8kU+JjBQZnXhr8ptTp8VYzH16fvBBYGLoLCg+vwv17SiK3I7PWMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hV3mrotw; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733021765; x=1764557765;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2MDLGdtixIr+eogn07QqelKmKPJW7oyKKYZK2ByJj5Y=;
  b=hV3mrotwWQCv5TVV+POUpRLLshlMDO+NGJ2+G4WFHtFkURLjdnaprQ/7
   rRkFtYJyKUM24LuWdta1GHezFQLZQdo09yzqU92r95m6kr+jdQv46M4yb
   2MOvC7nlYfUCVIhadw+1b07fTzwBaq6W5YSZmSAQQuygou9F2DaxUTBjd
   uocDk2qwBTPNdfVja8JRCdgzCl9saIBc+XovGJakgBjDpcwhfOZUD9PEJ
   fKi4zJoT1u/ZQOkw/rCjrzeA/lDkfO6QqXzUxbILVS9WMGe2I3MPXVab7
   +Gmq2R1EMS4aoNNc+rCLNnJmpT/Xgsk5MLNRNKrdykSrVUmN+NliMKMAJ
   g==;
X-CSE-ConnectionGUID: HXJMo9GbT/SI+gbM/GSATw==
X-CSE-MsgGUID: jX1s19gDSuW6T6tPpbEqLA==
X-IronPort-AV: E=McAfee;i="6700,10204,11272"; a="44248029"
X-IronPort-AV: E=Sophos;i="6.12,199,1728975600"; 
   d="scan'208";a="44248029"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2024 18:56:04 -0800
X-CSE-ConnectionGUID: awvlkQ0XQouCl51C2mZQ+w==
X-CSE-MsgGUID: NoGx+l5vQ26mWR/7dI8L2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,199,1728975600"; 
   d="scan'208";a="97890037"
Received: from lkp-server02.sh.intel.com (HELO 36a1563c48ff) ([10.239.97.151])
  by orviesa004.jf.intel.com with ESMTP; 30 Nov 2024 18:55:59 -0800
Received: from kbuild by 36a1563c48ff with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tHa7o-0001An-2a;
	Sun, 01 Dec 2024 02:55:56 +0000
Date: Sun, 1 Dec 2024 10:55:19 +0800
From: kernel test robot <lkp@intel.com>
To: Mario Limonciello <mario.limonciello@amd.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Ilpo =?unknown-8bit?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: oe-kbuild-all@lists.linux.dev, "Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Maximilian Luz <luzmaximilian@gmail.com>,
	Lee Chun-Yi <jlee@suse.com>,
	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
	Corentin Chary <corentin.chary@gmail.com>,
	"Luke D . Jones" <luke@ljones.dev>,
	Ike Panhc <ike.pan@canonical.com>,
	Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
	Alexis Belmonte <alexbelm48@gmail.com>,
	Uwe =?unknown-8bit?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Ai Chao <aichao@kylinos.cn>, Gergo Koteles <soyer@irl.hu>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:ACPI" <linux-acpi@vger.kernel.org>,
	"open list:MICROSOFT SURFACE PLATFORM PROFILE DRIVER" <platform-driver-x86@vger.kernel.org>,
	"open list:THINKPAD ACPI EXTRAS DRIVER" <ibm-acpi-devel@lists.sourceforge.net>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	Matthew Schwartz <matthew.schwartz@linux.dev>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Armin Wolf <W_Armin@gmx.de>
Subject: Re: [PATCH v8 02/22] platform/x86/dell: dell-pc: Create platform
 device
Message-ID: <202412011002.Hb0aRIsM-lkp@intel.com>
References: <20241130140454.455-3-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241130140454.455-3-mario.limonciello@amd.com>

Hi Mario,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 2ba9f676d0a2e408aef14d679984c26373bf37b7]

url:    https://github.com/intel-lab-lkp/linux/commits/Mario-Limonciello/ACPI-platform-profile-Add-a-name-member-to-handlers/20241130-221102
base:   2ba9f676d0a2e408aef14d679984c26373bf37b7
patch link:    https://lore.kernel.org/r/20241130140454.455-3-mario.limonciello%40amd.com
patch subject: [PATCH v8 02/22] platform/x86/dell: dell-pc: Create platform device
config: x86_64-randconfig-121-20241201 (https://download.01.org/0day-ci/archive/20241201/202412011002.Hb0aRIsM-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241201/202412011002.Hb0aRIsM-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412011002.Hb0aRIsM-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/platform/x86/dell/dell-pc.c:252:32: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected long error @@     got struct platform_device *static [assigned] [toplevel] platform_device @@
   drivers/platform/x86/dell/dell-pc.c:252:32: sparse:     expected long error
   drivers/platform/x86/dell/dell-pc.c:252:32: sparse:     got struct platform_device *static [assigned] [toplevel] platform_device
>> drivers/platform/x86/dell/dell-pc.c:252:31: sparse: sparse: incorrect type in return expression (different base types) @@     expected int @@     got void * @@
   drivers/platform/x86/dell/dell-pc.c:252:31: sparse:     expected int
   drivers/platform/x86/dell/dell-pc.c:252:31: sparse:     got void *

vim +252 drivers/platform/x86/dell/dell-pc.c

   233	
   234	static int thermal_init(void)
   235	{
   236		int ret;
   237		int supported_modes;
   238	
   239		/* If thermal commands are not supported, exit without error */
   240		if (!dell_smbios_class_is_supported(CLASS_INFO))
   241			return 0;
   242	
   243		/* If thermal modes are not supported, exit without error */
   244		ret = thermal_get_supported_modes(&supported_modes);
   245		if (ret < 0)
   246			return ret;
   247		if (!supported_modes)
   248			return 0;
   249	
   250		platform_device = platform_device_register_simple("dell-pc", PLATFORM_DEVID_NONE, NULL, 0);
   251		if (IS_ERR(platform_device))
 > 252			return ERR_PTR(platform_device);
   253	
   254		thermal_handler = devm_kzalloc(&platform_device->dev, sizeof(*thermal_handler), GFP_KERNEL);
   255		if (!thermal_handler) {
   256			ret = -ENOMEM;
   257			goto cleanup_platform_device;
   258		}
   259		thermal_handler->name = "dell-pc";
   260		thermal_handler->profile_get = thermal_platform_profile_get;
   261		thermal_handler->profile_set = thermal_platform_profile_set;
   262	
   263		if (supported_modes & DELL_QUIET)
   264			set_bit(PLATFORM_PROFILE_QUIET, thermal_handler->choices);
   265		if (supported_modes & DELL_COOL_BOTTOM)
   266			set_bit(PLATFORM_PROFILE_COOL, thermal_handler->choices);
   267		if (supported_modes & DELL_BALANCED)
   268			set_bit(PLATFORM_PROFILE_BALANCED, thermal_handler->choices);
   269		if (supported_modes & DELL_PERFORMANCE)
   270			set_bit(PLATFORM_PROFILE_PERFORMANCE, thermal_handler->choices);
   271	
   272		/* Clean up if failed */
   273		ret = platform_profile_register(thermal_handler);
   274		if (ret)
   275			goto cleanup_thermal_handler;
   276	
   277		return 0;
   278	
   279	cleanup_thermal_handler:
   280		thermal_handler = NULL;
   281	
   282	cleanup_platform_device:
   283		platform_device_unregister(platform_device);
   284	
   285		return ret;
   286	}
   287	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

