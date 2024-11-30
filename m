Return-Path: <linux-acpi+bounces-9836-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A4519DF257
	for <lists+linux-acpi@lfdr.de>; Sat, 30 Nov 2024 18:43:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB0B02813D6
	for <lists+linux-acpi@lfdr.de>; Sat, 30 Nov 2024 17:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFF5D1A9B30;
	Sat, 30 Nov 2024 17:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KVsBsjWR"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F661A9B2E;
	Sat, 30 Nov 2024 17:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732988601; cv=none; b=mLEJB0CIj8FUdx8IOHskuf36SRah1rNcx24SNkkKqJ/K6HFchdFJgGuULaPDlQMKvoaA5ZznHUG4D0AITmtADVAjAVwkQDR0CbVGspgLWwaI5kkMVvS30vWIC6u0XNu7+/smPB/7+35kOJKSru597TY22pXnfflI/+e7CB5qKKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732988601; c=relaxed/simple;
	bh=hp79E4kQ26QL67QnIKLFTCKPhH95s/jPskxdhk6jR3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tvPHlMzZQE0a7BHhy/LESp7Xy1nGz0pey1Dd0QF3EbFkDFRkl7d4mnG0HtOv4JiUP+UFGe+NQd+ADW3OxfipuJDNAWA43yx6ASxDqMeFoVHNmVZ2MYMpHLgwI8NdcGVA9IgbTPQmDgE1xZ19qtBtI1MxFVLVYfwivDHjQQ0PBwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KVsBsjWR; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732988599; x=1764524599;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hp79E4kQ26QL67QnIKLFTCKPhH95s/jPskxdhk6jR3A=;
  b=KVsBsjWRuN2cN0wCJDJbq7KFL907NGl6wAp/N6bFv/TRXZaMuwWukx7U
   eJAUcxihT8JpSzidaphshqcR4OqDjcyafJ3QlqXE3+duQ3klX+423favA
   6bkqWT2QTUZPT4hrcqEbiiqRh2OmykI3u84Vo3lDxw9dzUz+ObMa6yRHU
   IoOdJZFSD7n7ebV2WmadX8KmzT9ERU1W7IrXD9Agx93wLI4swF0TRtZ4P
   KcNYeUHSY+VK8VDcM1ympygWP0mavyseQs6Aox2UkTckDQX/2mi99QlsC
   jekK7JamVCbLnRwX/PhWvGiR2Vdq+4UB5kvbhFBrJ+VsclDv2d7oVx/2Z
   w==;
X-CSE-ConnectionGUID: rHfEG30LTzeeiGZgVkLhOg==
X-CSE-MsgGUID: 2IdsykmdQU6HHhKOx6YAZw==
X-IronPort-AV: E=McAfee;i="6700,10204,11272"; a="33319829"
X-IronPort-AV: E=Sophos;i="6.12,198,1728975600"; 
   d="scan'208";a="33319829"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2024 09:43:18 -0800
X-CSE-ConnectionGUID: STfJSgtMSQuLn6aITruuUg==
X-CSE-MsgGUID: 9i8jZTqRS2GKg5alYFu95w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,198,1728975600"; 
   d="scan'208";a="93546463"
Received: from lkp-server02.sh.intel.com (HELO 36a1563c48ff) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 30 Nov 2024 09:43:12 -0800
Received: from kbuild by 36a1563c48ff with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tHRUs-0000s3-29;
	Sat, 30 Nov 2024 17:43:10 +0000
Date: Sun, 1 Dec 2024 01:42:47 +0800
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
Message-ID: <202412010129.zSeGQmOm-lkp@intel.com>
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
config: i386-buildonly-randconfig-003-20241130 (https://download.01.org/0day-ci/archive/20241201/202412010129.zSeGQmOm-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241201/202412010129.zSeGQmOm-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412010129.zSeGQmOm-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/platform/x86/dell/dell-pc.c: In function 'thermal_init':
>> drivers/platform/x86/dell/dell-pc.c:252:32: warning: passing argument 1 of 'ERR_PTR' makes integer from pointer without a cast [-Wint-conversion]
     252 |                 return ERR_PTR(platform_device);
         |                                ^~~~~~~~~~~~~~~
         |                                |
         |                                struct platform_device *
   In file included from include/linux/kernfs.h:9,
                    from include/linux/sysfs.h:16,
                    from include/linux/kobject.h:20,
                    from include/linux/dmi.h:6,
                    from drivers/platform/x86/dell/dell-pc.c:15:
   include/linux/err.h:39:48: note: expected 'long int' but argument is of type 'struct platform_device *'
      39 | static inline void * __must_check ERR_PTR(long error)
         |                                           ~~~~~^~~~~
>> drivers/platform/x86/dell/dell-pc.c:252:24: warning: returning 'void *' from a function with return type 'int' makes integer from pointer without a cast [-Wint-conversion]
     252 |                 return ERR_PTR(platform_device);
         |                        ^~~~~~~~~~~~~~~~~~~~~~~~


vim +/ERR_PTR +252 drivers/platform/x86/dell/dell-pc.c

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

