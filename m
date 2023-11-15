Return-Path: <linux-acpi+bounces-1546-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7E5B7ED745
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Nov 2023 23:32:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 796371F22E40
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Nov 2023 22:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E00703A8E3
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Nov 2023 22:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nyqlKr9t"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E8B41BFD;
	Wed, 15 Nov 2023 13:05:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700082320; x=1731618320;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rcToWmLfNTrsUiv8LTunATTkIMt6WybUwub2LGTkAEY=;
  b=nyqlKr9t3dh/lap9dSQepKKxKtR7qozchfM6rDfe3kEbK3TzQqkgWn02
   9Kkb3UEnOdPngsQlDyoLCewerduzrD0k6L2aVxpMQ5lKCwfLpp6ifZxOi
   rTycPkPYB4lNroyDaKbg060FHxe3rGEmXyAZtVLG7szrWgPdvxIRu+25S
   XATAspsdSVAQZkpDamt4lLiTb9mThBx1cKObN7Sg+708Q4cPUDzuAuvoR
   Gltdhvb+UDLo7JmVOf4O3KKEO1Pb9Afj3bhxS/vMhG+YObKXQnsCKe02s
   ugLCeEweMz1rfIH9WgF/YokpXPGep3fqT1lSGQ0ZISB9h4UG/80A2gfSc
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="381348221"
X-IronPort-AV: E=Sophos;i="6.03,306,1694761200"; 
   d="scan'208";a="381348221"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 13:05:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,306,1694761200"; 
   d="scan'208";a="13327401"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 15 Nov 2023 13:05:17 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1r3N4V-0000pH-0H;
	Wed, 15 Nov 2023 21:05:15 +0000
Date: Thu, 16 Nov 2023 05:04:51 +0800
From: kernel test robot <lkp@intel.com>
To: Sakari Ailus <sakari.ailus@linux.intel.com>, linux-acpi@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-media@vger.kernel.org,
	rafael@kernel.org, jacopo.mondi@ideasonboard.com,
	laurent.pinchart@ideasonboard.com
Subject: Re: [PATCH 1/6] pm: runtime: Simplify pm_runtime_get_if_active()
 usage
Message-ID: <202311160402.sZooXBaB-lkp@intel.com>
References: <20231115181840.1509046-2-sakari.ailus@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231115181840.1509046-2-sakari.ailus@linux.intel.com>

Hi Sakari,

kernel test robot noticed the following build errors:

[auto build test ERROR on 3e238417254bfdcc23fe207780b59cbb08656762]

url:    https://github.com/intel-lab-lkp/linux/commits/Sakari-Ailus/pm-runtime-Simplify-pm_runtime_get_if_active-usage/20231116-022051
base:   3e238417254bfdcc23fe207780b59cbb08656762
patch link:    https://lore.kernel.org/r/20231115181840.1509046-2-sakari.ailus%40linux.intel.com
patch subject: [PATCH 1/6] pm: runtime: Simplify pm_runtime_get_if_active() usage
config: i386-buildonly-randconfig-006-20231116 (https://download.01.org/0day-ci/archive/20231116/202311160402.sZooXBaB-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231116/202311160402.sZooXBaB-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311160402.sZooXBaB-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/gpu/drm/i915/intel_runtime_pm.c: In function '__intel_runtime_pm_get_if_active':
>> drivers/gpu/drm/i915/intel_runtime_pm.c:437:21: error: too many arguments to function '__pm_runtime_get_conditional'
     437 |                 if (__pm_runtime_get_conditional(rpm->kdev, ignore_usecount) <= 0)
         |                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/gpu/drm/i915/intel_runtime_pm.c:29:
   include/linux/pm_runtime.h:300:19: note: declared here
     300 | static inline int __pm_runtime_get_conditional(struct device *dev)
         |                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/__pm_runtime_get_conditional +437 drivers/gpu/drm/i915/intel_runtime_pm.c

   404	
   405	/**
   406	 * __intel_runtime_pm_get_if_active - grab a runtime pm reference if device is active
   407	 * @rpm: the intel_runtime_pm structure
   408	 * @ignore_usecount: get a ref even if dev->power.usage_count is 0
   409	 *
   410	 * This function grabs a device-level runtime pm reference if the device is
   411	 * already active and ensures that it is powered up. It is illegal to try
   412	 * and access the HW should intel_runtime_pm_get_if_active() report failure.
   413	 *
   414	 * If @ignore_usecount is true, a reference will be acquired even if there is no
   415	 * user requiring the device to be powered up (dev->power.usage_count == 0).
   416	 * If the function returns false in this case then it's guaranteed that the
   417	 * device's runtime suspend hook has been called already or that it will be
   418	 * called (and hence it's also guaranteed that the device's runtime resume
   419	 * hook will be called eventually).
   420	 *
   421	 * Any runtime pm reference obtained by this function must have a symmetric
   422	 * call to intel_runtime_pm_put() to release the reference again.
   423	 *
   424	 * Returns: the wakeref cookie to pass to intel_runtime_pm_put(), evaluates
   425	 * as True if the wakeref was acquired, or False otherwise.
   426	 */
   427	static intel_wakeref_t __intel_runtime_pm_get_if_active(struct intel_runtime_pm *rpm,
   428								bool ignore_usecount)
   429	{
   430		if (IS_ENABLED(CONFIG_PM)) {
   431			/*
   432			 * In cases runtime PM is disabled by the RPM core and we get
   433			 * an -EINVAL return value we are not supposed to call this
   434			 * function, since the power state is undefined. This applies
   435			 * atm to the late/early system suspend/resume handlers.
   436			 */
 > 437			if (__pm_runtime_get_conditional(rpm->kdev, ignore_usecount) <= 0)
   438				return 0;
   439		}
   440	
   441		intel_runtime_pm_acquire(rpm, true);
   442	
   443		return track_intel_runtime_pm_wakeref(rpm);
   444	}
   445	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

