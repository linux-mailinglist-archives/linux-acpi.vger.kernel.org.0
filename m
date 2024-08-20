Return-Path: <linux-acpi+bounces-7696-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D6D957BE6
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Aug 2024 05:25:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66CB2B21BD5
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Aug 2024 03:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE52E481CE;
	Tue, 20 Aug 2024 03:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EQHcXtLg"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347BE4643B;
	Tue, 20 Aug 2024 03:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724124316; cv=none; b=gRSGXomB2Gak+PPuzbUyGcZ4gjWfBJrTBPeyI8TkY/cwvGVUajlguLnayUabz6cvWa8aL4IAh4yK0vcB5GbAb8qEnaKJ0QShmxvIPNvIKw9qlpbOJD2cXMGkxbRf6Ewh923VnSF2PHLwVXh3WMOsfRZQwtycQw2tA1LlKyRskIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724124316; c=relaxed/simple;
	bh=arXtY8+yaGUrI22wutV9mAq9/y3cKEwah96ncigoBI0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Iw0g2EHmmhOPJNRVavMbVzAeB9RZJOOq8DEyaB4JotnL6JJARpqYrm2cky12XT9kvSB1l9Jl4TnDD3R2RBS61dXCBxkoLas6N4kUtiHOF4nQTVtlambhw6J5zz/GRQgaUbdWbiIjEnI3bO4VdCCL9/51FmR7b95RzFrKE9NqXrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EQHcXtLg; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724124314; x=1755660314;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=arXtY8+yaGUrI22wutV9mAq9/y3cKEwah96ncigoBI0=;
  b=EQHcXtLgqihDMG8dPYcKrhSY+GC0/lGJ7RLMAhdgIXYNAQL2i8YdK0vs
   vx9RSTODLGW9LTU0YN5rFlMGyCY30Vj0YgRi20O8Dors4SWjKCyp85svX
   PwfWXO4gYUf7rjNOscw5UtoIL0prCNqJpbziv4nP6la0v4zRQ3PqWD4DT
   yBiJ8Nq6qZvJzGgQqbKxLVaTPkva7oTSYYErpGp7SMWBKCzqDjxpSqAh6
   go5bpDHwqqcXwCTYjElKdgzTX0YfZF9FlcS0rO+MZWrJ2w9P5QMdAL0sL
   R6Vf8FCAZPr9SQ5DYSoWd5Hw2SX3JpQPcpCSmpS1ttr6hW5IQ1eUz5go2
   Q==;
X-CSE-ConnectionGUID: bZssVPFCTcu0FHtZrMKWgA==
X-CSE-MsgGUID: mGlzBKiiQZGltO713QfNKg==
X-IronPort-AV: E=McAfee;i="6700,10204,11169"; a="39859355"
X-IronPort-AV: E=Sophos;i="6.10,160,1719903600"; 
   d="scan'208";a="39859355"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 20:25:14 -0700
X-CSE-ConnectionGUID: gCn0BrekRTuczmvKIWQTdQ==
X-CSE-MsgGUID: ueTI0RlPRQ+C183K6oyRIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,160,1719903600"; 
   d="scan'208";a="64759969"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 19 Aug 2024 20:25:12 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sgFUc-0009fY-12;
	Tue, 20 Aug 2024 03:25:10 +0000
Date: Tue, 20 Aug 2024 11:24:43 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: oe-kbuild-all@lists.linux.dev, linux-acpi@vger.kernel.org,
	devel@acpica.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:thermal-core-testing 7/23]
 drivers/thermal/testing/zone.c:405:31: warning: 'kmalloc_array_noprof' sizes
 specified with 'sizeof' in the earlier argument and not in the later
 argument
Message-ID: <202408201147.hRhwCUcp-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-core-testing
head:   b7e46a95eece4ca15b1656c3c45323068642d11a
commit: e89b27c5a79c07b289c3bf1b32bba376f6fa5b7e [7/23] thermal: Introduce a debugfs-based testing facility
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20240820/202408201147.hRhwCUcp-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240820/202408201147.hRhwCUcp-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408201147.hRhwCUcp-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/percpu.h:5,
                    from include/linux/percpu_counter.h:14,
                    from include/linux/mm_types.h:21,
                    from include/linux/mmzone.h:22,
                    from include/linux/gfp.h:7,
                    from include/linux/xarray.h:16,
                    from include/linux/list_lru.h:14,
                    from include/linux/fs.h:13,
                    from include/linux/debugfs.h:15,
                    from drivers/thermal/testing/zone.c:12:
   drivers/thermal/testing/zone.c: In function 'tt_zone_register_tz':
>> drivers/thermal/testing/zone.c:405:31: warning: 'kmalloc_array_noprof' sizes specified with 'sizeof' in the earlier argument and not in the later argument [-Wcalloc-transposed-args]
     405 |         trips = kcalloc(sizeof(*trips), tt_zone->num_trips, GFP_KERNEL);
         |                               ^
   include/linux/alloc_tag.h:206:16: note: in definition of macro 'alloc_hooks_tag'
     206 |         typeof(_do_alloc) _res = _do_alloc;                             \
         |                ^~~~~~~~~
   include/linux/slab.h:728:49: note: in expansion of macro 'alloc_hooks'
     728 | #define kmalloc_array(...)                      alloc_hooks(kmalloc_array_noprof(__VA_ARGS__))
         |                                                 ^~~~~~~~~~~
   include/linux/slab.h:757:41: note: in expansion of macro 'kmalloc_array'
     757 | #define kcalloc(n, size, flags)         kmalloc_array(n, size, (flags) | __GFP_ZERO)
         |                                         ^~~~~~~~~~~~~
   drivers/thermal/testing/zone.c:405:17: note: in expansion of macro 'kcalloc'
     405 |         trips = kcalloc(sizeof(*trips), tt_zone->num_trips, GFP_KERNEL);
         |                 ^~~~~~~
   drivers/thermal/testing/zone.c:405:31: note: earlier argument should specify number of elements, later size of each element
     405 |         trips = kcalloc(sizeof(*trips), tt_zone->num_trips, GFP_KERNEL);
         |                               ^
   include/linux/alloc_tag.h:206:16: note: in definition of macro 'alloc_hooks_tag'
     206 |         typeof(_do_alloc) _res = _do_alloc;                             \
         |                ^~~~~~~~~
   include/linux/slab.h:728:49: note: in expansion of macro 'alloc_hooks'
     728 | #define kmalloc_array(...)                      alloc_hooks(kmalloc_array_noprof(__VA_ARGS__))
         |                                                 ^~~~~~~~~~~
   include/linux/slab.h:757:41: note: in expansion of macro 'kmalloc_array'
     757 | #define kcalloc(n, size, flags)         kmalloc_array(n, size, (flags) | __GFP_ZERO)
         |                                         ^~~~~~~~~~~~~
   drivers/thermal/testing/zone.c:405:17: note: in expansion of macro 'kcalloc'
     405 |         trips = kcalloc(sizeof(*trips), tt_zone->num_trips, GFP_KERNEL);
         |                 ^~~~~~~
>> drivers/thermal/testing/zone.c:405:31: warning: 'kmalloc_array_noprof' sizes specified with 'sizeof' in the earlier argument and not in the later argument [-Wcalloc-transposed-args]
     405 |         trips = kcalloc(sizeof(*trips), tt_zone->num_trips, GFP_KERNEL);
         |                               ^
   include/linux/alloc_tag.h:206:34: note: in definition of macro 'alloc_hooks_tag'
     206 |         typeof(_do_alloc) _res = _do_alloc;                             \
         |                                  ^~~~~~~~~
   include/linux/slab.h:728:49: note: in expansion of macro 'alloc_hooks'
     728 | #define kmalloc_array(...)                      alloc_hooks(kmalloc_array_noprof(__VA_ARGS__))
         |                                                 ^~~~~~~~~~~
   include/linux/slab.h:757:41: note: in expansion of macro 'kmalloc_array'
     757 | #define kcalloc(n, size, flags)         kmalloc_array(n, size, (flags) | __GFP_ZERO)
         |                                         ^~~~~~~~~~~~~
   drivers/thermal/testing/zone.c:405:17: note: in expansion of macro 'kcalloc'
     405 |         trips = kcalloc(sizeof(*trips), tt_zone->num_trips, GFP_KERNEL);
         |                 ^~~~~~~
   drivers/thermal/testing/zone.c:405:31: note: earlier argument should specify number of elements, later size of each element
     405 |         trips = kcalloc(sizeof(*trips), tt_zone->num_trips, GFP_KERNEL);
         |                               ^
   include/linux/alloc_tag.h:206:34: note: in definition of macro 'alloc_hooks_tag'
     206 |         typeof(_do_alloc) _res = _do_alloc;                             \
         |                                  ^~~~~~~~~
   include/linux/slab.h:728:49: note: in expansion of macro 'alloc_hooks'
     728 | #define kmalloc_array(...)                      alloc_hooks(kmalloc_array_noprof(__VA_ARGS__))
         |                                                 ^~~~~~~~~~~
   include/linux/slab.h:757:41: note: in expansion of macro 'kmalloc_array'
     757 | #define kcalloc(n, size, flags)         kmalloc_array(n, size, (flags) | __GFP_ZERO)
         |                                         ^~~~~~~~~~~~~
   drivers/thermal/testing/zone.c:405:17: note: in expansion of macro 'kcalloc'
     405 |         trips = kcalloc(sizeof(*trips), tt_zone->num_trips, GFP_KERNEL);
         |                 ^~~~~~~
--
>> drivers/thermal/testing/zone.c:52: warning: Function parameter or struct member 'refcount' not described in 'tt_thermal_zone'
>> drivers/thermal/testing/zone.c:52: warning: Excess struct member 'refcont' description in 'tt_thermal_zone'
>> drivers/thermal/testing/zone.c:71: warning: Excess struct member 'tt_zone' description in 'tt_trip'


vim +405 drivers/thermal/testing/zone.c

   392	
   393	static int tt_zone_register_tz(struct tt_thermal_zone *tt_zone)
   394	{
   395		struct thermal_trip *trips __free(kfree);
   396		struct thermal_zone_device *tz;
   397		struct tt_trip *tt_trip;
   398		int i;
   399	
   400		guard(tt_zone)(tt_zone);
   401	
   402		if (tt_zone->tz)
   403			return -EINVAL;
   404	
 > 405		trips = kcalloc(sizeof(*trips), tt_zone->num_trips, GFP_KERNEL);
   406		if (!trips)
   407			return -ENOMEM;
   408	
   409		i = 0;
   410		list_for_each_entry(tt_trip, &tt_zone->trips, list_node)
   411			trips[i++] = tt_trip->trip;
   412	
   413		tt_zone->tz_temp = tt_zone->temp;
   414	
   415		tz = thermal_zone_device_register_with_trips("test_tz", trips, i, tt_zone,
   416							     &tt_zone_ops, NULL, 0, 0);
   417		if (IS_ERR(tz))
   418			return PTR_ERR(tz);
   419	
   420		tt_zone->tz = tz;
   421	
   422		thermal_zone_device_enable(tz);
   423	
   424		return 0;
   425	}
   426	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

