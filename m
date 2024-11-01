Return-Path: <linux-acpi+bounces-9238-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD5259B930F
	for <lists+linux-acpi@lfdr.de>; Fri,  1 Nov 2024 15:23:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 176BFB226C2
	for <lists+linux-acpi@lfdr.de>; Fri,  1 Nov 2024 14:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A472819CC29;
	Fri,  1 Nov 2024 14:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cpOXUkvZ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B6728FC;
	Fri,  1 Nov 2024 14:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730471033; cv=none; b=BNT3/CAGpmeFeKwIKNXpsN0tcC7AzC0lglFWxj1fIgEv5hX3hqsbOPM+q13R3TqZRR1o2zWtEeAz6HkGRubMBHrFlXtFtIIYXRYRlcw12HMEPoqChDCO7Bx4/qfYkJFJA/juLsMhqbR1Mz87pEMKrgNRYI2BRUIKbPRqHYvXSxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730471033; c=relaxed/simple;
	bh=OXDMAqh2nLfuHgCU8Sscde62QdU4PrQcAwb72r1rD80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X6UMm6BYs18UzvqVtHwsEic67M9Kh/fStNmFXdhdrjZc1eaBqQelvlcs0+vTRB+tuSwuzN2m2K1zNMQ5kYDiI/h3nEjQxSyJGISDcVp9EoXIfq3l16969GoS04gFlj8cuajA78xHhbnYkQO+ObZ36m+J5p04TiH7eXGEtmAomBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cpOXUkvZ; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730471031; x=1762007031;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OXDMAqh2nLfuHgCU8Sscde62QdU4PrQcAwb72r1rD80=;
  b=cpOXUkvZpAUuXnp8eAxltHh0uNZfmroaWQ/NJmEUWUzMIm8ysT8d0IRh
   cRGzvCAje1yhzmf9nvo3LwA440Xoj+fmBPwc8nVqQjclQZlgAy6uA8wTN
   cqNEhhs7ColF8sLahAItLk3fKwE3zcxsgQ7WdEMerT3INC9Fc/dGbeL6Q
   Ftrnloe6SFI+GZhO3YbjhWS8MrzEBqQ1UOwfGwRrS1ljZOGA4KofpH74+
   6OXXu42Y8VCeopRDZeb+5TKxiCU01HJfcN+0MDw+yYEt9EV2t4cY1ollu
   jZ502BG3kBw0PFPRkeE6Vxzxq+FdeoO/X7xFIIRw0bpjV9kjk8tSuSaig
   w==;
X-CSE-ConnectionGUID: XtZGKWwsTY6T+J+I9L8p6A==
X-CSE-MsgGUID: E00dVKKCS8WY6R3GRz9B7Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="41337041"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="41337041"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2024 07:23:50 -0700
X-CSE-ConnectionGUID: imwns5Y0QGea1ZlKb1YZtA==
X-CSE-MsgGUID: WV7WXGAMRJiX01/aCBZLeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,250,1725346800"; 
   d="scan'208";a="87516207"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 01 Nov 2024 07:23:42 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t6sYt-000hdV-1s;
	Fri, 01 Nov 2024 14:23:39 +0000
Date: Fri, 1 Nov 2024 22:22:47 +0800
From: kernel test robot <lkp@intel.com>
To: Mario Limonciello <mario.limonciello@amd.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Maximilian Luz <luzmaximilian@gmail.com>,
	Lee Chun-Yi <jlee@suse.com>,
	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
	Corentin Chary <corentin.chary@gmail.com>,
	"Luke D . Jones" <luke@ljones.dev>,
	Ike Panhc <ike.pan@canonical.com>,
	Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
	Alexis Belmonte <alexbelm48@gmail.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Ai Chao <aichao@kylinos.cn>, Gergo Koteles <soyer@irl.hu>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:ACPI" <linux-acpi@vger.kernel.org>,
	"open list:MICROSOFT SURFACE PLATFORM PROFILE DRIVER" <platform-driver-x86@vger.kernel.org>,
	"open list:THINKPAD ACPI EXTRAS DRIVER" <ibm-acpi-devel@lists.sourceforge.net>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	Matthew Schwartz <matthew.schwartz@linux.dev>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH v3 20/22] ACPI: platform_profile: Register class device
 for platform profile handlers
Message-ID: <202411012227.46a4WcxB-lkp@intel.com>
References: <20241031040952.109057-21-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241031040952.109057-21-mario.limonciello@amd.com>

Hi Mario,

kernel test robot noticed the following build errors:

[auto build test ERROR on rafael-pm/linux-next]
[also build test ERROR on rafael-pm/bleeding-edge linus/master v6.12-rc5 next-20241101]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Mario-Limonciello/ACPI-platform-profile-Add-a-name-member-to-handlers/20241031-121650
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20241031040952.109057-21-mario.limonciello%40amd.com
patch subject: [PATCH v3 20/22] ACPI: platform_profile: Register class device for platform profile handlers
config: i386-buildonly-randconfig-005-20241101 (https://download.01.org/0day-ci/archive/20241101/202411012227.46a4WcxB-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241101/202411012227.46a4WcxB-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411012227.46a4WcxB-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/acpi/platform_profile.c:303:7: error: call to undeclared function 'MKDEV'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     303 |                                          MKDEV(0, pprof->minor), NULL, "platform-profile-%s",
         |                                          ^
   drivers/acpi/platform_profile.c:344:42: error: call to undeclared function 'MKDEV'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     344 |         device_destroy(&platform_profile_class, MKDEV(0, pprof->minor));
         |                                                 ^
   2 errors generated.


vim +/MKDEV +303 drivers/acpi/platform_profile.c

   261	
   262	int platform_profile_register(struct platform_profile_handler *pprof)
   263	{
   264		bool registered;
   265		int err;
   266	
   267		/* Sanity check the profile handler */
   268		if (!pprof || bitmap_empty(pprof->choices, PLATFORM_PROFILE_LAST) ||
   269		    !pprof->profile_set || !pprof->profile_get) {
   270			pr_err("platform_profile: handler is invalid\n");
   271			return -EINVAL;
   272		}
   273		if (!test_bit(PLATFORM_PROFILE_BALANCED, pprof->choices)) {
   274			pr_err("platform_profile: handler does not support balanced profile\n");
   275			return -EINVAL;
   276		}
   277		if (!pprof->dev) {
   278			pr_err("platform_profile: handler device is not set\n");
   279			return -EINVAL;
   280		}
   281	
   282		guard(mutex)(&profile_lock);
   283		/* We can only have one active profile */
   284		if (cur_profile)
   285			return -EEXIST;
   286	
   287		registered = platform_profile_is_registered();
   288		if (!registered) {
   289			/* class for individual handlers */
   290			err = class_register(&platform_profile_class);
   291			if (err)
   292				return err;
   293			/* legacy sysfs files */
   294			err = sysfs_create_group(acpi_kobj, &platform_profile_group);
   295			if (err)
   296				goto cleanup_class;
   297	
   298		}
   299	
   300		/* create class interface for individual handler */
   301		pprof->minor = idr_alloc(&platform_profile_minor_idr, pprof, 0, 0, GFP_KERNEL);
   302		pprof->class_dev = device_create(&platform_profile_class, pprof->dev,
 > 303						 MKDEV(0, pprof->minor), NULL, "platform-profile-%s",
   304						 pprof->name);
   305		if (IS_ERR(pprof->class_dev)) {
   306			err = PTR_ERR(pprof->class_dev);
   307			goto cleanup_legacy;
   308		}
   309		err = sysfs_create_group(&pprof->class_dev->kobj, &platform_profile_group);
   310		if (err)
   311			goto cleanup_device;
   312	
   313		list_add_tail(&pprof->list, &platform_profile_handler_list);
   314		sysfs_notify(acpi_kobj, NULL, "platform_profile");
   315	
   316		cur_profile = pprof;
   317		return 0;
   318	
   319	cleanup_device:
   320		device_destroy(&platform_profile_class, MKDEV(0, pprof->minor));
   321	
   322	cleanup_legacy:
   323		if (!registered)
   324			sysfs_remove_group(acpi_kobj, &platform_profile_group);
   325	cleanup_class:
   326		if (!registered)
   327			class_unregister(&platform_profile_class);
   328	
   329		return err;
   330	}
   331	EXPORT_SYMBOL_GPL(platform_profile_register);
   332	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

