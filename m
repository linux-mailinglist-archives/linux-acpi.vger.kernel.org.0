Return-Path: <linux-acpi+bounces-11295-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B380FA3AF8F
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Feb 2025 03:24:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AA033A55DB
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Feb 2025 02:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB34F157A55;
	Wed, 19 Feb 2025 02:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IJr+05dg"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF1713665A;
	Wed, 19 Feb 2025 02:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739931886; cv=none; b=CNo1+GS/iX6WPBb+TTP7+03BlK1c9mov0nq44F53XKSmd/6eZ/TVKY0ClgM3nsbV2YPowyAFzdMxl995A6v35kddl8lzvqJlqMd9S1BeFTfMhdTQMHNk79chW1+YTtzrZtfBGMGVvaA0XlGexpWr/+Au9p1/48OBPO3kydwpWf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739931886; c=relaxed/simple;
	bh=LBpZq/a48dev9X/UCB1qvb48c4v7TvEUV3/PMaoinGM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=S9UV+oxCqVRm3YGiRv+nmK7ayowpQD1ctmVXqSuEA9IpjEmulKIKSK6I3bo2tmvNf15GIxKDyyn5lLhxUTLDaYMCIVOCBLApGJyZ0sdID+IKRxEi1WeR6wRLIHe2rHtEhBKl3Z9nkdjfSk/63Uzn22CSsKGCUaynuY7TMoOXnVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IJr+05dg; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739931883; x=1771467883;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=LBpZq/a48dev9X/UCB1qvb48c4v7TvEUV3/PMaoinGM=;
  b=IJr+05dghQNEgEmBSK+nt5LdtRISkiWeLIx+S7ApK3lf0wijdVFR7OXl
   x9PTRP80/LzdD1FrYA5flTJJNxldyx4XWf55tz5ahYPalhOfFjY3+/Uqs
   6cNu73MzxaKKThiJ/OHPNwvs2UgtQecX2ejPGsum2KcCZ+Pq+mMJeHnWi
   TZwAZj9VngD5K45ukfm0tD3DGnE0rLCVAKQi9+ITc5gl24ZQJFdQEvMKi
   wuGwzloBjWsOEqYwrr7AnXQL3XbWjBRqatz4v7+r8ODTHJKXpYK8zdtdX
   O3B3OCqs4bgPyStTkBZgy9Z45CJo1KXflayNQlt5CfpQ9ZzM4i5tA9Isb
   A==;
X-CSE-ConnectionGUID: CagLIUUzSGyBRFJkKefQ6g==
X-CSE-MsgGUID: 7VrYj/2yQZ6SUhaJ7RssuQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="43486299"
X-IronPort-AV: E=Sophos;i="6.13,296,1732608000"; 
   d="scan'208";a="43486299"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2025 18:24:42 -0800
X-CSE-ConnectionGUID: pVH+6gDITlieNkge4N7uRw==
X-CSE-MsgGUID: LMFhQgYyQTy6tO/XYJmaUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="119512739"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa003.jf.intel.com with ESMTP; 18 Feb 2025 18:24:40 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tkZlO-00018d-0w;
	Wed, 19 Feb 2025 02:24:38 +0000
Date: Wed, 19 Feb 2025 10:24:01 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: oe-kbuild-all@lists.linux.dev, linux-acpi@vger.kernel.org,
	devel@acpica.org, linux-pm@vger.kernel.org,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: [rafael-pm:pm-sleep-testing 5/6] sound/drivers/virmidi.c:49:12:
 warning: 'index' defined but not used
Message-ID: <202502191030.TEY1JGtg-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-sleep-testing
head:   e0d95f1b2b755e2cd05b11dcddabb6cab24a041b
commit: d7aa9525f39c3c2f5520db30b40edb9c8f13774e [5/6] PM: sleep: Use DPM_FLAG_SMART_SUSPEND conditionally
config: parisc-randconfig-001-20250219 (https://download.01.org/0day-ci/archive/20250219/202502191030.TEY1JGtg-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250219/202502191030.TEY1JGtg-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502191030.TEY1JGtg-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/platform_device.h:13,
                    from sound/drivers/virmidi.c:33:
   include/linux/device.h: In function 'dev_pm_smart_suspend':
   include/linux/device.h:1030:26: error: 'struct dev_pm_info' has no member named 'smart_suspend'
    1030 |         return dev->power.smart_suspend;
         |                          ^
   In file included from include/linux/build_bug.h:5,
                    from include/linux/init.h:5,
                    from sound/drivers/virmidi.c:30:
   sound/drivers/virmidi.c: At top level:
   include/linux/compiler.h:197:77: error: expression in static assertion is not an integer
     197 | #define __BUILD_BUG_ON_ZERO_MSG(e, msg) ((int)sizeof(struct {_Static_assert(!(e), msg);}))
         |                                                                             ^
   include/linux/compiler.h:202:33: note: in expansion of macro '__BUILD_BUG_ON_ZERO_MSG'
     202 | #define __must_be_array(a)      __BUILD_BUG_ON_ZERO_MSG(!__is_array(a), \
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/array_size.h:11:59: note: in expansion of macro '__must_be_array'
      11 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
         |                                                           ^~~~~~~~~~~~~~~
   include/linux/moduleparam.h:521:20: note: in expansion of macro 'ARRAY_SIZE'
     521 |         = { .max = ARRAY_SIZE(array), .num = nump,                      \
         |                    ^~~~~~~~~~
   include/linux/moduleparam.h:505:9: note: in expansion of macro 'module_param_array_named'
     505 |         module_param_array_named(name, name, type, nump, perm)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~
   sound/drivers/virmidi.c:54:1: note: in expansion of macro 'module_param_array'
      54 | module_param_array(index, int, NULL, 0444);
         | ^~~~~~~~~~~~~~~~~~
>> sound/drivers/virmidi.c:49:12: warning: 'index' defined but not used [-Wunused-variable]
      49 | static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX;      /* Index 0-MAX */
         |            ^~~~~
--
   In file included from include/linux/platform_device.h:13,
                    from sound/drivers/mtpav.c:41:
   include/linux/device.h: In function 'dev_pm_smart_suspend':
   include/linux/device.h:1030:26: error: 'struct dev_pm_info' has no member named 'smart_suspend'
    1030 |         return dev->power.smart_suspend;
         |                          ^
   sound/drivers/mtpav.c: At top level:
>> sound/drivers/mtpav.c:62:12: warning: 'index' defined but not used [-Wunused-variable]
      62 | static int index = SNDRV_DEFAULT_IDX1;
         |            ^~~~~
--
   In file included from include/linux/dma-mapping.h:5,
                    from sound/parisc/harmony.c:33:
   include/linux/device.h: In function 'dev_pm_smart_suspend':
   include/linux/device.h:1030:26: error: 'struct dev_pm_info' has no member named 'smart_suspend'
    1030 |         return dev->power.smart_suspend;
         |                          ^
   sound/parisc/harmony.c: At top level:
>> sound/parisc/harmony.c:48:12: warning: 'index' defined but not used [-Wunused-variable]
      48 | static int index = SNDRV_DEFAULT_IDX1;  /* Index 0-MAX */
         |            ^~~~~
--
   In file included from include/linux/usb.h:19,
                    from sound/usb/bcd2000/bcd2000.c:14:
   include/linux/device.h: In function 'dev_pm_smart_suspend':
   include/linux/device.h:1030:26: error: 'struct dev_pm_info' has no member named 'smart_suspend'
    1030 |         return dev->power.smart_suspend;
         |                          ^
   sound/usb/bcd2000/bcd2000.c: At top level:
>> sound/usb/bcd2000/bcd2000.c:60:12: warning: 'index' defined but not used [-Wunused-variable]
      60 | static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX;
         |            ^~~~~
--
   In file included from include/linux/usb.h:19,
                    from sound/usb/hiface/chip.h:16,
                    from sound/usb/hiface/chip.c:17:
   include/linux/device.h: In function 'dev_pm_smart_suspend':
   include/linux/device.h:1030:26: error: 'struct dev_pm_info' has no member named 'smart_suspend'
    1030 |         return dev->power.smart_suspend;
         |                          ^
   In file included from include/linux/build_bug.h:5,
                    from include/linux/container_of.h:5,
                    from include/linux/list.h:5,
                    from include/linux/module.h:12,
                    from sound/usb/hiface/chip.c:13:
   sound/usb/hiface/chip.c: At top level:
   include/linux/compiler.h:197:77: error: expression in static assertion is not an integer
     197 | #define __BUILD_BUG_ON_ZERO_MSG(e, msg) ((int)sizeof(struct {_Static_assert(!(e), msg);}))
         |                                                                             ^
   include/linux/compiler.h:202:33: note: in expansion of macro '__BUILD_BUG_ON_ZERO_MSG'
     202 | #define __must_be_array(a)      __BUILD_BUG_ON_ZERO_MSG(!__is_array(a), \
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/array_size.h:11:59: note: in expansion of macro '__must_be_array'
      11 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
         |                                                           ^~~~~~~~~~~~~~~
   include/linux/moduleparam.h:521:20: note: in expansion of macro 'ARRAY_SIZE'
     521 |         = { .max = ARRAY_SIZE(array), .num = nump,                      \
         |                    ^~~~~~~~~~
   include/linux/moduleparam.h:505:9: note: in expansion of macro 'module_param_array_named'
     505 |         module_param_array_named(name, name, type, nump, perm)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~
   sound/usb/hiface/chip.c:32:1: note: in expansion of macro 'module_param_array'
      32 | module_param_array(index, int, NULL, 0444);
         | ^~~~~~~~~~~~~~~~~~
>> sound/usb/hiface/chip.c:25:12: warning: 'index' defined but not used [-Wunused-variable]
      25 | static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX; /* Index 0-max */
         |            ^~~~~
--
   In file included from include/linux/pnp.h:12,
                    from sound/drivers/mpu401/mpu401.c:9:
   include/linux/device.h: In function 'dev_pm_smart_suspend':
   include/linux/device.h:1030:26: error: 'struct dev_pm_info' has no member named 'smart_suspend'
    1030 |         return dev->power.smart_suspend;
         |                          ^
   In file included from include/linux/build_bug.h:5,
                    from include/linux/init.h:5,
                    from sound/drivers/mpu401/mpu401.c:8:
   sound/drivers/mpu401/mpu401.c: At top level:
   include/linux/compiler.h:197:77: error: expression in static assertion is not an integer
     197 | #define __BUILD_BUG_ON_ZERO_MSG(e, msg) ((int)sizeof(struct {_Static_assert(!(e), msg);}))
         |                                                                             ^
   include/linux/compiler.h:202:33: note: in expansion of macro '__BUILD_BUG_ON_ZERO_MSG'
     202 | #define __must_be_array(a)      __BUILD_BUG_ON_ZERO_MSG(!__is_array(a), \
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/array_size.h:11:59: note: in expansion of macro '__must_be_array'
      11 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
         |                                                           ^~~~~~~~~~~~~~~
   include/linux/moduleparam.h:521:20: note: in expansion of macro 'ARRAY_SIZE'
     521 |         = { .max = ARRAY_SIZE(array), .num = nump,                      \
         |                    ^~~~~~~~~~
   include/linux/moduleparam.h:505:9: note: in expansion of macro 'module_param_array_named'
     505 |         module_param_array_named(name, name, type, nump, perm)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~
   sound/drivers/mpu401/mpu401.c:31:1: note: in expansion of macro 'module_param_array'
      31 | module_param_array(index, int, NULL, 0444);
         | ^~~~~~~~~~~~~~~~~~
>> sound/drivers/mpu401/mpu401.c:21:12: warning: 'index' defined but not used [-Wunused-variable]
      21 | static int index[SNDRV_CARDS] = {[0 ... (SNDRV_CARDS - 1)] = -2}; /* exclude the first card */
         |            ^~~~~


vim +/index +49 sound/drivers/virmidi.c

^1da177e4c3f41 Linus Torvalds 2005-04-16  48  
^1da177e4c3f41 Linus Torvalds 2005-04-16 @49  static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX;	/* Index 0-MAX */
^1da177e4c3f41 Linus Torvalds 2005-04-16  50  static char *id[SNDRV_CARDS] = SNDRV_DEFAULT_STR;	/* ID for this card */
a67ff6a54095e2 Rusty Russell  2011-12-15  51  static bool enable[SNDRV_CARDS] = {1, [1 ... (SNDRV_CARDS - 1)] = 0};
^1da177e4c3f41 Linus Torvalds 2005-04-16  52  static int midi_devs[SNDRV_CARDS] = {[0 ... (SNDRV_CARDS - 1)] = 4};
^1da177e4c3f41 Linus Torvalds 2005-04-16  53  

:::::: The code at line 49 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

