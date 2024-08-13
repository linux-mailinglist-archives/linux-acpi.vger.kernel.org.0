Return-Path: <linux-acpi+bounces-7554-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC4E895079F
	for <lists+linux-acpi@lfdr.de>; Tue, 13 Aug 2024 16:31:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C35E61C20AD2
	for <lists+linux-acpi@lfdr.de>; Tue, 13 Aug 2024 14:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C91E19DF57;
	Tue, 13 Aug 2024 14:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hK60+pN4"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD79319D887;
	Tue, 13 Aug 2024 14:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723559380; cv=none; b=dK+xhVkBq7r8KPI/bF9mSeaFmxtqtwoj+DRDtI96arfu6yqlKj0O17EvA4q31rZ38lulpl7RyJIpXVXzZdMT2VGSSk6SxZ1TRwDIdn5jIiszREAMwHfrHhuNxW6OZMgL/DDC7deWwGfagiIyCUGhvNvVPWB2qwXw90M8uGStv34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723559380; c=relaxed/simple;
	bh=u7dhztxftLLxaDnLyp09NQ+DPJeWDlxL4fOMtosZVuc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hLEbVtZthvM9GHk4/A3h4BEM7YttJULtzibO8AnPGL112ezB1Ii/gc6jwy9FMdFG2zEsv5R1YELieKdI+S5Iv+yq0U2i8TU9yBgwvUinaXq4zaOTBdaeeFgpjEEMi8eKI4+YCAUXY5Z0wxYnf3hntWGYcQ5aslTj4MF2lleoqaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hK60+pN4; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723559375; x=1755095375;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=u7dhztxftLLxaDnLyp09NQ+DPJeWDlxL4fOMtosZVuc=;
  b=hK60+pN4OTWAxj6la5mr6to2K5gyFi0J6YCIPZmQ0qRSu4m9gayu+/0B
   wVQkeFgXTLhT45L0q/ZRAhr/DHwUr37Rn8RERj9ZtBNU1ufHnNj9ZqD2L
   bCfvkLLVfCbzPSfyJrVXP0fC65Vbu+ePluXsaKIeUhcffySU6G5x/kwb/
   FKmMz65e330eD03VTCdu5m0tlzfafCKEjlRa/CxDlS5YdfyZI3yoUyYw+
   iJtVx1/tPq/TWe+AZl3VcRSomprvor37UHdHtBtiJ2yCe0NibibKgYezA
   Y4cHGnPJHM24J4JC+W0I9TZuomBpdK5zpRQR3NS004U4UdlvFey6zmo48
   w==;
X-CSE-ConnectionGUID: B2wVb3xZS2aEyffBakrn6A==
X-CSE-MsgGUID: nH3iAzLlQPWStpOJl3VRwQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11163"; a="21586926"
X-IronPort-AV: E=Sophos;i="6.09,286,1716274800"; 
   d="scan'208";a="21586926"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 07:29:33 -0700
X-CSE-ConnectionGUID: 8yyS+J8HQMOQ+Q85ZRbgZQ==
X-CSE-MsgGUID: MGqzL/MwRvubHwhb5DyraQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,286,1716274800"; 
   d="scan'208";a="62836480"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 13 Aug 2024 07:29:26 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sdsWa-0000TL-0U;
	Tue, 13 Aug 2024 14:29:24 +0000
Date: Tue, 13 Aug 2024 22:28:51 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: oe-kbuild-all@lists.linux.dev, linux-acpi@vger.kernel.org,
	devel@acpica.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge 81/99]
 drivers/thermal/thermal_core.c:862:37: error: 'struct thermal_instance' has
 no member named 'tz_node'; did you mean 'trip_node'?
Message-ID: <202408132228.D0Ke8etI-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
head:   c850ea465e36219149e4abe7f2e30ec8bf674862
commit: b23e156c27ccc76678678b3b92a8795dc3d95523 [81/99] thermal: core: Move lists of thermal instances to trip descriptors
config: x86_64-defconfig (https://download.01.org/0day-ci/archive/20240813/202408132228.D0Ke8etI-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240813/202408132228.D0Ke8etI-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408132228.D0Ke8etI-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/thermal/thermal_core.c: In function 'thermal_bind_cdev_to_trip':
>> drivers/thermal/thermal_core.c:862:37: error: 'struct thermal_instance' has no member named 'tz_node'; did you mean 'trip_node'?
     862 |                 list_add_tail(&dev->tz_node, &tz->thermal_instances);
         |                                     ^~~~~~~
         |                                     trip_node
>> drivers/thermal/thermal_core.c:862:49: error: 'struct thermal_zone_device' has no member named 'thermal_instances'
     862 |                 list_add_tail(&dev->tz_node, &tz->thermal_instances);
         |                                                 ^~
   In file included from include/linux/linkage.h:7,
                    from arch/x86/include/asm/cache.h:5,
                    from include/linux/cache.h:6,
                    from arch/x86/include/asm/current.h:10,
                    from include/linux/sched.h:12,
                    from include/linux/ratelimit.h:6,
                    from include/linux/dev_printk.h:16,
                    from include/linux/device.h:15,
                    from drivers/thermal/thermal_core.c:12:
   drivers/thermal/thermal_core.c:899:19: error: non-static declaration of 'thermal_zone_bind_cooling_device' follows static declaration
     899 | EXPORT_SYMBOL_GPL(thermal_zone_bind_cooling_device);
         |                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/export.h:56:28: note: in definition of macro '__EXPORT_SYMBOL'
      56 |         extern typeof(sym) sym;                                 \
         |                            ^~~
   include/linux/export.h:69:41: note: in expansion of macro '_EXPORT_SYMBOL'
      69 | #define EXPORT_SYMBOL_GPL(sym)          _EXPORT_SYMBOL(sym, "GPL")
         |                                         ^~~~~~~~~~~~~~
   drivers/thermal/thermal_core.c:899:1: note: in expansion of macro 'EXPORT_SYMBOL_GPL'
     899 | EXPORT_SYMBOL_GPL(thermal_zone_bind_cooling_device);
         | ^~~~~~~~~~~~~~~~~
   drivers/thermal/thermal_core.c:887:5: note: previous definition of 'thermal_zone_bind_cooling_device' with type 'int(struct thermal_zone_device *, int,  struct thermal_cooling_device *, long unsigned int,  long unsigned int,  unsigned int)'
     887 | int thermal_zone_bind_cooling_device(struct thermal_zone_device *tz,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/linkage.h:7,
                    from arch/x86/include/asm/cache.h:5,
                    from include/linux/cache.h:6,
                    from arch/x86/include/asm/current.h:10,
                    from include/linux/sched.h:12,
                    from include/linux/ratelimit.h:6,
                    from include/linux/dev_printk.h:16,
                    from include/linux/device.h:15,
                    from drivers/thermal/thermal_core.c:12:
   drivers/thermal/thermal_core.c:947:19: error: non-static declaration of 'thermal_unbind_cdev_from_trip' follows static declaration
     947 | EXPORT_SYMBOL_GPL(thermal_unbind_cdev_from_trip);
         |                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/export.h:56:28: note: in definition of macro '__EXPORT_SYMBOL'
      56 |         extern typeof(sym) sym;                                 \
         |                            ^~~
   include/linux/export.h:69:41: note: in expansion of macro '_EXPORT_SYMBOL'
      69 | #define EXPORT_SYMBOL_GPL(sym)          _EXPORT_SYMBOL(sym, "GPL")
         |                                         ^~~~~~~~~~~~~~
   drivers/thermal/thermal_core.c:947:1: note: in expansion of macro 'EXPORT_SYMBOL_GPL'
     947 | EXPORT_SYMBOL_GPL(thermal_unbind_cdev_from_trip);
         | ^~~~~~~~~~~~~~~~~
   drivers/thermal/thermal_core.c:913:5: note: previous definition of 'thermal_unbind_cdev_from_trip' with type 'int(struct thermal_zone_device *, struct thermal_trip *, struct thermal_cooling_device *)'
     913 | int thermal_unbind_cdev_from_trip(struct thermal_zone_device *tz,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/linkage.h:7,
                    from arch/x86/include/asm/cache.h:5,
                    from include/linux/cache.h:6,
                    from arch/x86/include/asm/current.h:10,
                    from include/linux/sched.h:12,
                    from include/linux/ratelimit.h:6,
                    from include/linux/dev_printk.h:16,
                    from include/linux/device.h:15,
                    from drivers/thermal/thermal_core.c:12:
   drivers/thermal/thermal_core.c:958:19: error: non-static declaration of 'thermal_zone_unbind_cooling_device' follows static declaration
     958 | EXPORT_SYMBOL_GPL(thermal_zone_unbind_cooling_device);
         |                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/export.h:56:28: note: in definition of macro '__EXPORT_SYMBOL'
      56 |         extern typeof(sym) sym;                                 \
         |                            ^~~
   include/linux/export.h:69:41: note: in expansion of macro '_EXPORT_SYMBOL'
      69 | #define EXPORT_SYMBOL_GPL(sym)          _EXPORT_SYMBOL(sym, "GPL")
         |                                         ^~~~~~~~~~~~~~
   drivers/thermal/thermal_core.c:958:1: note: in expansion of macro 'EXPORT_SYMBOL_GPL'
     958 | EXPORT_SYMBOL_GPL(thermal_zone_unbind_cooling_device);
         | ^~~~~~~~~~~~~~~~~
   drivers/thermal/thermal_core.c:949:5: note: previous definition of 'thermal_zone_unbind_cooling_device' with type 'int(struct thermal_zone_device *, int,  struct thermal_cooling_device *)'
     949 | int thermal_zone_unbind_cooling_device(struct thermal_zone_device *tz,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/thermal/thermal_core.c:960:13: error: invalid storage class for function 'thermal_release'
     960 | static void thermal_release(struct device *dev)
         |             ^~~~~~~~~~~~~~~
>> drivers/thermal/thermal_core.c:984:6: error: invalid storage class for function 'print_bind_err_msg'
     984 | void print_bind_err_msg(struct thermal_zone_device *tz,
         |      ^~~~~~~~~~~~~~~~~~
>> drivers/thermal/thermal_core.c:1008:1: error: invalid storage class for function '__thermal_cooling_device_register'
    1008 | __thermal_cooling_device_register(struct device_node *np,
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/linkage.h:7,
                    from arch/x86/include/asm/cache.h:5,
                    from include/linux/cache.h:6,
                    from arch/x86/include/asm/current.h:10,
                    from include/linux/sched.h:12,
                    from include/linux/ratelimit.h:6,
                    from include/linux/dev_printk.h:16,
                    from include/linux/device.h:15,
                    from drivers/thermal/thermal_core.c:12:
>> drivers/thermal/thermal_core.c:1133:19: error: non-static declaration of 'thermal_cooling_device_register' follows static declaration
    1133 | EXPORT_SYMBOL_GPL(thermal_cooling_device_register);
         |                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/export.h:56:28: note: in definition of macro '__EXPORT_SYMBOL'
      56 |         extern typeof(sym) sym;                                 \
         |                            ^~~
   include/linux/export.h:69:41: note: in expansion of macro '_EXPORT_SYMBOL'
      69 | #define EXPORT_SYMBOL_GPL(sym)          _EXPORT_SYMBOL(sym, "GPL")
         |                                         ^~~~~~~~~~~~~~
   drivers/thermal/thermal_core.c:1133:1: note: in expansion of macro 'EXPORT_SYMBOL_GPL'
    1133 | EXPORT_SYMBOL_GPL(thermal_cooling_device_register);
         | ^~~~~~~~~~~~~~~~~
   drivers/thermal/thermal_core.c:1128:1: note: previous definition of 'thermal_cooling_device_register' with type 'struct thermal_cooling_device *(const char *, void *, const struct thermal_cooling_device_ops *)'
    1128 | thermal_cooling_device_register(const char *type, void *devdata,
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/linkage.h:7,
                    from arch/x86/include/asm/cache.h:5,
                    from include/linux/cache.h:6,
                    from arch/x86/include/asm/current.h:10,
                    from include/linux/sched.h:12,
                    from include/linux/ratelimit.h:6,
                    from include/linux/dev_printk.h:16,
                    from include/linux/device.h:15,
                    from drivers/thermal/thermal_core.c:12:
>> drivers/thermal/thermal_core.c:1157:19: error: non-static declaration of 'thermal_of_cooling_device_register' follows static declaration
    1157 | EXPORT_SYMBOL_GPL(thermal_of_cooling_device_register);
         |                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/export.h:56:28: note: in definition of macro '__EXPORT_SYMBOL'
      56 |         extern typeof(sym) sym;                                 \
         |                            ^~~
   include/linux/export.h:69:41: note: in expansion of macro '_EXPORT_SYMBOL'
      69 | #define EXPORT_SYMBOL_GPL(sym)          _EXPORT_SYMBOL(sym, "GPL")
         |                                         ^~~~~~~~~~~~~~
   drivers/thermal/thermal_core.c:1157:1: note: in expansion of macro 'EXPORT_SYMBOL_GPL'
    1157 | EXPORT_SYMBOL_GPL(thermal_of_cooling_device_register);
         | ^~~~~~~~~~~~~~~~~
   drivers/thermal/thermal_core.c:1151:1: note: previous definition of 'thermal_of_cooling_device_register' with type 'struct thermal_cooling_device *(struct device_node *, const char *, void *, const struct thermal_cooling_device_ops *)'
    1151 | thermal_of_cooling_device_register(struct device_node *np,
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/thermal/thermal_core.c:1159:13: error: invalid storage class for function 'thermal_cooling_device_release'
    1159 | static void thermal_cooling_device_release(struct device *dev, void *res)
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/linkage.h:7,
                    from arch/x86/include/asm/cache.h:5,
                    from include/linux/cache.h:6,
                    from arch/x86/include/asm/current.h:10,
                    from include/linux/sched.h:12,
                    from include/linux/ratelimit.h:6,
                    from include/linux/dev_printk.h:16,
                    from include/linux/device.h:15,
                    from drivers/thermal/thermal_core.c:12:
>> drivers/thermal/thermal_core.c:1206:19: error: non-static declaration of 'devm_thermal_of_cooling_device_register' follows static declaration
    1206 | EXPORT_SYMBOL_GPL(devm_thermal_of_cooling_device_register);
         |                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/export.h:56:28: note: in definition of macro '__EXPORT_SYMBOL'
      56 |         extern typeof(sym) sym;                                 \
         |                            ^~~
   include/linux/export.h:69:41: note: in expansion of macro '_EXPORT_SYMBOL'
      69 | #define EXPORT_SYMBOL_GPL(sym)          _EXPORT_SYMBOL(sym, "GPL")
         |                                         ^~~~~~~~~~~~~~
   drivers/thermal/thermal_core.c:1206:1: note: in expansion of macro 'EXPORT_SYMBOL_GPL'
    1206 | EXPORT_SYMBOL_GPL(devm_thermal_of_cooling_device_register);
         | ^~~~~~~~~~~~~~~~~
   drivers/thermal/thermal_core.c:1183:1: note: previous definition of 'devm_thermal_of_cooling_device_register' with type 'struct thermal_cooling_device *(struct device *, struct device_node *, const char *, void *, const struct thermal_cooling_device_ops *)'
    1183 | devm_thermal_of_cooling_device_register(struct device *dev,
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/thermal/thermal_core.c:1208:13: error: invalid storage class for function 'thermal_cooling_device_present'
    1208 | static bool thermal_cooling_device_present(struct thermal_cooling_device *cdev)
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/linkage.h:7,
                    from arch/x86/include/asm/cache.h:5,
                    from include/linux/cache.h:6,
                    from arch/x86/include/asm/current.h:10,
                    from include/linux/sched.h:12,
                    from include/linux/ratelimit.h:6,
                    from include/linux/dev_printk.h:16,
                    from include/linux/device.h:15,
                    from drivers/thermal/thermal_core.c:12:
>> drivers/thermal/thermal_core.c:1291:19: error: non-static declaration of 'thermal_cooling_device_update' follows static declaration
    1291 | EXPORT_SYMBOL_GPL(thermal_cooling_device_update);
         |                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/export.h:56:28: note: in definition of macro '__EXPORT_SYMBOL'
      56 |         extern typeof(sym) sym;                                 \
         |                            ^~~
   include/linux/export.h:69:41: note: in expansion of macro '_EXPORT_SYMBOL'
      69 | #define EXPORT_SYMBOL_GPL(sym)          _EXPORT_SYMBOL(sym, "GPL")
         |                                         ^~~~~~~~~~~~~~
   drivers/thermal/thermal_core.c:1291:1: note: in expansion of macro 'EXPORT_SYMBOL_GPL'
    1291 | EXPORT_SYMBOL_GPL(thermal_cooling_device_update);
         | ^~~~~~~~~~~~~~~~~
   drivers/thermal/thermal_core.c:1230:6: note: previous definition of 'thermal_cooling_device_update' with type 'void(struct thermal_cooling_device *)'
    1230 | void thermal_cooling_device_update(struct thermal_cooling_device *cdev)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/linkage.h:7,
                    from arch/x86/include/asm/cache.h:5,
                    from include/linux/cache.h:6,
                    from arch/x86/include/asm/current.h:10,
                    from include/linux/sched.h:12,
                    from include/linux/ratelimit.h:6,
                    from include/linux/dev_printk.h:16,
                    from include/linux/device.h:15,
                    from drivers/thermal/thermal_core.c:12:
>> drivers/thermal/thermal_core.c:1328:19: error: non-static declaration of 'thermal_cooling_device_unregister' follows static declaration
    1328 | EXPORT_SYMBOL_GPL(thermal_cooling_device_unregister);
         |                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/export.h:56:28: note: in definition of macro '__EXPORT_SYMBOL'
      56 |         extern typeof(sym) sym;                                 \
         |                            ^~~
   include/linux/export.h:69:41: note: in expansion of macro '_EXPORT_SYMBOL'
      69 | #define EXPORT_SYMBOL_GPL(sym)          _EXPORT_SYMBOL(sym, "GPL")
         |                                         ^~~~~~~~~~~~~~
   drivers/thermal/thermal_core.c:1328:1: note: in expansion of macro 'EXPORT_SYMBOL_GPL'
    1328 | EXPORT_SYMBOL_GPL(thermal_cooling_device_unregister);
         | ^~~~~~~~~~~~~~~~~
   drivers/thermal/thermal_core.c:1300:6: note: previous definition of 'thermal_cooling_device_unregister' with type 'void(struct thermal_cooling_device *)'
    1300 | void thermal_cooling_device_unregister(struct thermal_cooling_device *cdev)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/thermal/thermal_core.c:1330:13: error: invalid storage class for function 'thermal_set_delay_jiffies'
    1330 | static void thermal_set_delay_jiffies(unsigned long *delay_jiffies, int delay_ms)
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/linkage.h:7,
                    from arch/x86/include/asm/cache.h:5,
                    from include/linux/cache.h:6,
                    from arch/x86/include/asm/current.h:10,
                    from include/linux/sched.h:12,
                    from include/linux/ratelimit.h:6,
                    from include/linux/dev_printk.h:16,
                    from include/linux/device.h:15,
                    from drivers/thermal/thermal_core.c:12:
>> drivers/thermal/thermal_core.c:1361:19: error: non-static declaration of 'thermal_zone_get_crit_temp' follows static declaration
    1361 | EXPORT_SYMBOL_GPL(thermal_zone_get_crit_temp);
         |                   ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/export.h:56:28: note: in definition of macro '__EXPORT_SYMBOL'
      56 |         extern typeof(sym) sym;                                 \
         |                            ^~~
   include/linux/export.h:69:41: note: in expansion of macro '_EXPORT_SYMBOL'
      69 | #define EXPORT_SYMBOL_GPL(sym)          _EXPORT_SYMBOL(sym, "GPL")
         |                                         ^~~~~~~~~~~~~~
   drivers/thermal/thermal_core.c:1361:1: note: in expansion of macro 'EXPORT_SYMBOL_GPL'
    1361 | EXPORT_SYMBOL_GPL(thermal_zone_get_crit_temp);
         | ^~~~~~~~~~~~~~~~~
   drivers/thermal/thermal_core.c:1337:5: note: previous definition of 'thermal_zone_get_crit_temp' with type 'int(struct thermal_zone_device *, int *)'
    1337 | int thermal_zone_get_crit_temp(struct thermal_zone_device *tz, int *temp)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/linkage.h:7,
                    from arch/x86/include/asm/cache.h:5,
                    from include/linux/cache.h:6,
                    from arch/x86/include/asm/current.h:10,
                    from include/linux/sched.h:12,
                    from include/linux/ratelimit.h:6,
                    from include/linux/dev_printk.h:16,
                    from include/linux/device.h:15,
                    from drivers/thermal/thermal_core.c:12:
>> drivers/thermal/thermal_core.c:1568:19: error: non-static declaration of 'thermal_zone_device_register_with_trips' follows static declaration
    1568 | EXPORT_SYMBOL_GPL(thermal_zone_device_register_with_trips);
         |                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/export.h:56:28: note: in definition of macro '__EXPORT_SYMBOL'
      56 |         extern typeof(sym) sym;                                 \
         |                            ^~~
   include/linux/export.h:69:41: note: in expansion of macro '_EXPORT_SYMBOL'
      69 | #define EXPORT_SYMBOL_GPL(sym)          _EXPORT_SYMBOL(sym, "GPL")
         |                                         ^~~~~~~~~~~~~~
   drivers/thermal/thermal_core.c:1568:1: note: in expansion of macro 'EXPORT_SYMBOL_GPL'
    1568 | EXPORT_SYMBOL_GPL(thermal_zone_device_register_with_trips);
         | ^~~~~~~~~~~~~~~~~
   drivers/thermal/thermal_core.c:1388:1: note: previous definition of 'thermal_zone_device_register_with_trips' with type 'struct thermal_zone_device *(const char *, const struct thermal_trip *, int,  void *, const struct thermal_zone_device_ops *, const struct thermal_zone_params *, unsigned int,  unsigned int)'
    1388 | thermal_zone_device_register_with_trips(const char *type,
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/linkage.h:7,
                    from arch/x86/include/asm/cache.h:5,
                    from include/linux/cache.h:6,
                    from arch/x86/include/asm/current.h:10,
                    from include/linux/sched.h:12,
                    from include/linux/ratelimit.h:6,
                    from include/linux/dev_printk.h:16,
                    from include/linux/device.h:15,
                    from drivers/thermal/thermal_core.c:12:
>> drivers/thermal/thermal_core.c:1579:19: error: non-static declaration of 'thermal_tripless_zone_device_register' follows static declaration
    1579 | EXPORT_SYMBOL_GPL(thermal_tripless_zone_device_register);
         |                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/export.h:56:28: note: in definition of macro '__EXPORT_SYMBOL'
      56 |         extern typeof(sym) sym;                                 \
         |                            ^~~
   include/linux/export.h:69:41: note: in expansion of macro '_EXPORT_SYMBOL'
      69 | #define EXPORT_SYMBOL_GPL(sym)          _EXPORT_SYMBOL(sym, "GPL")
         |                                         ^~~~~~~~~~~~~~
   drivers/thermal/thermal_core.c:1579:1: note: in expansion of macro 'EXPORT_SYMBOL_GPL'
    1579 | EXPORT_SYMBOL_GPL(thermal_tripless_zone_device_register);
         | ^~~~~~~~~~~~~~~~~
   drivers/thermal/thermal_core.c:1570:29: note: previous definition of 'thermal_tripless_zone_device_register' with type 'struct thermal_zone_device *(const char *, void *, const struct thermal_zone_device_ops *, const struct thermal_zone_params *)'
    1570 | struct thermal_zone_device *thermal_tripless_zone_device_register(
         |                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/linkage.h:7,
                    from arch/x86/include/asm/cache.h:5,
                    from include/linux/cache.h:6,
                    from arch/x86/include/asm/current.h:10,
                    from include/linux/sched.h:12,
                    from include/linux/ratelimit.h:6,
                    from include/linux/dev_printk.h:16,
                    from include/linux/device.h:15,
                    from drivers/thermal/thermal_core.c:12:
>> drivers/thermal/thermal_core.c:1585:19: error: non-static declaration of 'thermal_zone_device_priv' follows static declaration
    1585 | EXPORT_SYMBOL_GPL(thermal_zone_device_priv);
         |                   ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/export.h:56:28: note: in definition of macro '__EXPORT_SYMBOL'
      56 |         extern typeof(sym) sym;                                 \
         |                            ^~~
   include/linux/export.h:69:41: note: in expansion of macro '_EXPORT_SYMBOL'
      69 | #define EXPORT_SYMBOL_GPL(sym)          _EXPORT_SYMBOL(sym, "GPL")
         |                                         ^~~~~~~~~~~~~~
   drivers/thermal/thermal_core.c:1585:1: note: in expansion of macro 'EXPORT_SYMBOL_GPL'
    1585 | EXPORT_SYMBOL_GPL(thermal_zone_device_priv);
         | ^~~~~~~~~~~~~~~~~
   drivers/thermal/thermal_core.c:1581:7: note: previous definition of 'thermal_zone_device_priv' with type 'void *(struct thermal_zone_device *)'
    1581 | void *thermal_zone_device_priv(struct thermal_zone_device *tzd)
         |       ^~~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/linkage.h:7,
                    from arch/x86/include/asm/cache.h:5,
                    from include/linux/cache.h:6,
                    from arch/x86/include/asm/current.h:10,
                    from include/linux/sched.h:12,
                    from include/linux/ratelimit.h:6,
                    from include/linux/dev_printk.h:16,
                    from include/linux/device.h:15,
                    from drivers/thermal/thermal_core.c:12:
>> drivers/thermal/thermal_core.c:1591:19: error: non-static declaration of 'thermal_zone_device_type' follows static declaration
    1591 | EXPORT_SYMBOL_GPL(thermal_zone_device_type);
         |                   ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/export.h:56:28: note: in definition of macro '__EXPORT_SYMBOL'
      56 |         extern typeof(sym) sym;                                 \
         |                            ^~~
   include/linux/export.h:69:41: note: in expansion of macro '_EXPORT_SYMBOL'
      69 | #define EXPORT_SYMBOL_GPL(sym)          _EXPORT_SYMBOL(sym, "GPL")
         |                                         ^~~~~~~~~~~~~~
   drivers/thermal/thermal_core.c:1591:1: note: in expansion of macro 'EXPORT_SYMBOL_GPL'
    1591 | EXPORT_SYMBOL_GPL(thermal_zone_device_type);
         | ^~~~~~~~~~~~~~~~~
   drivers/thermal/thermal_core.c:1587:13: note: previous definition of 'thermal_zone_device_type' with type 'const char *(struct thermal_zone_device *)'
    1587 | const char *thermal_zone_device_type(struct thermal_zone_device *tzd)
         |             ^~~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/linkage.h:7,
                    from arch/x86/include/asm/cache.h:5,
                    from include/linux/cache.h:6,
                    from arch/x86/include/asm/current.h:10,
                    from include/linux/sched.h:12,
                    from include/linux/ratelimit.h:6,
                    from include/linux/dev_printk.h:16,
                    from include/linux/device.h:15,
                    from drivers/thermal/thermal_core.c:12:
>> drivers/thermal/thermal_core.c:1597:19: error: non-static declaration of 'thermal_zone_device_id' follows static declaration
    1597 | EXPORT_SYMBOL_GPL(thermal_zone_device_id);
         |                   ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/export.h:56:28: note: in definition of macro '__EXPORT_SYMBOL'
      56 |         extern typeof(sym) sym;                                 \
         |                            ^~~
   include/linux/export.h:69:41: note: in expansion of macro '_EXPORT_SYMBOL'
      69 | #define EXPORT_SYMBOL_GPL(sym)          _EXPORT_SYMBOL(sym, "GPL")
         |                                         ^~~~~~~~~~~~~~
   drivers/thermal/thermal_core.c:1597:1: note: in expansion of macro 'EXPORT_SYMBOL_GPL'
    1597 | EXPORT_SYMBOL_GPL(thermal_zone_device_id);
         | ^~~~~~~~~~~~~~~~~
   drivers/thermal/thermal_core.c:1593:5: note: previous definition of 'thermal_zone_device_id' with type 'int(struct thermal_zone_device *)'
    1593 | int thermal_zone_device_id(struct thermal_zone_device *tzd)
         |     ^~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/linkage.h:7,
                    from arch/x86/include/asm/cache.h:5,
                    from include/linux/cache.h:6,
                    from arch/x86/include/asm/current.h:10,
                    from include/linux/sched.h:12,
                    from include/linux/ratelimit.h:6,
                    from include/linux/dev_printk.h:16,
                    from include/linux/device.h:15,
                    from drivers/thermal/thermal_core.c:12:
>> drivers/thermal/thermal_core.c:1603:19: error: non-static declaration of 'thermal_zone_device' follows static declaration
    1603 | EXPORT_SYMBOL_GPL(thermal_zone_device);
         |                   ^~~~~~~~~~~~~~~~~~~
   include/linux/export.h:56:28: note: in definition of macro '__EXPORT_SYMBOL'
      56 |         extern typeof(sym) sym;                                 \
         |                            ^~~
   include/linux/export.h:69:41: note: in expansion of macro '_EXPORT_SYMBOL'
      69 | #define EXPORT_SYMBOL_GPL(sym)          _EXPORT_SYMBOL(sym, "GPL")
         |                                         ^~~~~~~~~~~~~~
   drivers/thermal/thermal_core.c:1603:1: note: in expansion of macro 'EXPORT_SYMBOL_GPL'
    1603 | EXPORT_SYMBOL_GPL(thermal_zone_device);
         | ^~~~~~~~~~~~~~~~~
   drivers/thermal/thermal_core.c:1599:16: note: previous definition of 'thermal_zone_device' with type 'struct device *(struct thermal_zone_device *)'
    1599 | struct device *thermal_zone_device(struct thermal_zone_device *tzd)
         |                ^~~~~~~~~~~~~~~~~~~
   In file included from include/linux/linkage.h:7,
                    from arch/x86/include/asm/cache.h:5,
                    from include/linux/cache.h:6,
                    from arch/x86/include/asm/current.h:10,
                    from include/linux/sched.h:12,
                    from include/linux/ratelimit.h:6,
                    from include/linux/dev_printk.h:16,
                    from include/linux/device.h:15,
                    from drivers/thermal/thermal_core.c:12:
   drivers/thermal/thermal_core.c:1659:19: error: non-static declaration of 'thermal_zone_device_unregister' follows static declaration
    1659 | EXPORT_SYMBOL_GPL(thermal_zone_device_unregister);
         |                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/export.h:56:28: note: in definition of macro '__EXPORT_SYMBOL'
      56 |         extern typeof(sym) sym;                                 \
         |                            ^~~
   include/linux/export.h:69:41: note: in expansion of macro '_EXPORT_SYMBOL'
      69 | #define EXPORT_SYMBOL_GPL(sym)          _EXPORT_SYMBOL(sym, "GPL")
         |                                         ^~~~~~~~~~~~~~
   drivers/thermal/thermal_core.c:1659:1: note: in expansion of macro 'EXPORT_SYMBOL_GPL'
    1659 | EXPORT_SYMBOL_GPL(thermal_zone_device_unregister);
         | ^~~~~~~~~~~~~~~~~
   drivers/thermal/thermal_core.c:1609:6: note: previous definition of 'thermal_zone_device_unregister' with type 'void(struct thermal_zone_device *)'
    1609 | void thermal_zone_device_unregister(struct thermal_zone_device *tz)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/linkage.h:7,
                    from arch/x86/include/asm/cache.h:5,
                    from include/linux/cache.h:6,
                    from arch/x86/include/asm/current.h:10,
                    from include/linux/sched.h:12,
                    from include/linux/ratelimit.h:6,
                    from include/linux/dev_printk.h:16,
                    from include/linux/device.h:15,
                    from drivers/thermal/thermal_core.c:12:
   drivers/thermal/thermal_core.c:1697:19: error: non-static declaration of 'thermal_zone_get_zone_by_name' follows static declaration
    1697 | EXPORT_SYMBOL_GPL(thermal_zone_get_zone_by_name);
         |                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/export.h:56:28: note: in definition of macro '__EXPORT_SYMBOL'
      56 |         extern typeof(sym) sym;                                 \
         |                            ^~~
   include/linux/export.h:69:41: note: in expansion of macro '_EXPORT_SYMBOL'
      69 | #define EXPORT_SYMBOL_GPL(sym)          _EXPORT_SYMBOL(sym, "GPL")
         |                                         ^~~~~~~~~~~~~~
   drivers/thermal/thermal_core.c:1697:1: note: in expansion of macro 'EXPORT_SYMBOL_GPL'
    1697 | EXPORT_SYMBOL_GPL(thermal_zone_get_zone_by_name);
         | ^~~~~~~~~~~~~~~~~
   drivers/thermal/thermal_core.c:1671:29: note: previous definition of 'thermal_zone_get_zone_by_name' with type 'struct thermal_zone_device *(const char *)'
    1671 | struct thermal_zone_device *thermal_zone_get_zone_by_name(const char *name)
         |                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/thermal/thermal_core.c:1699:13: error: invalid storage class for function 'thermal_zone_device_resume'
    1699 | static void thermal_zone_device_resume(struct work_struct *work)
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/thermal/thermal_core.c:1719:12: error: invalid storage class for function 'thermal_pm_notify'
    1719 | static int thermal_pm_notify(struct notifier_block *nb,
         |            ^~~~~~~~~~~~~~~~~
   drivers/thermal/thermal_core.c:1790:26: error: initializer element is not constant
    1790 |         .notifier_call = thermal_pm_notify,
         |                          ^~~~~~~~~~~~~~~~~
   drivers/thermal/thermal_core.c:1790:26: note: (near initialization for 'thermal_pm_nb.notifier_call')
   drivers/thermal/thermal_core.c:1799:19: error: invalid storage class for function 'thermal_init'
    1799 | static int __init thermal_init(void)
         |                   ^~~~~~~~~~~~
   In file included from include/linux/dev_printk.h:14,
                    from include/linux/device.h:15,
                    from drivers/thermal/thermal_core.c:12:
   include/linux/compiler.h:227:52: error: initializer element is not constant
     227 |         __UNIQUE_ID(__PASTE(__addressable_,sym)) = (void *)(uintptr_t)&sym;
         |                                                    ^
   include/linux/compiler.h:229:9: note: in expansion of macro '___ADDRESSABLE'
     229 |         ___ADDRESSABLE(sym, __section(".discard.addressable"))
         |         ^~~~~~~~~~~~~~
   include/linux/init.h:256:9: note: in expansion of macro '__ADDRESSABLE'
     256 |         __ADDRESSABLE(fn)
         |         ^~~~~~~~~~~~~
   include/linux/init.h:261:9: note: in expansion of macro '__define_initcall_stub'
     261 |         __define_initcall_stub(__stub, fn)                      \
         |         ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/init.h:274:9: note: in expansion of macro '____define_initcall'
     274 |         ____define_initcall(fn,                                 \
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/init.h:280:9: note: in expansion of macro '__unique_initcall'
     280 |         __unique_initcall(fn, id, __sec, __initcall_id(fn))
         |         ^~~~~~~~~~~~~~~~~
   include/linux/init.h:282:35: note: in expansion of macro '___define_initcall'
     282 | #define __define_initcall(fn, id) ___define_initcall(fn, id, .initcall##id)
         |                                   ^~~~~~~~~~~~~~~~~~
   include/linux/init.h:302:41: note: in expansion of macro '__define_initcall'


vim +862 drivers/thermal/thermal_core.c

329b064fbd13d6 drivers/thermal/thermal_core.c Daniel Lezcano         2020-07-06   748  
81193e2e6b4737 drivers/thermal/thermal_core.c Eduardo Valentin       2016-11-07   749  /*
81193e2e6b4737 drivers/thermal/thermal_core.c Eduardo Valentin       2016-11-07   750   * Device management section: cooling devices, zones devices, and binding
81193e2e6b4737 drivers/thermal/thermal_core.c Eduardo Valentin       2016-11-07   751   *
81193e2e6b4737 drivers/thermal/thermal_core.c Eduardo Valentin       2016-11-07   752   * Set of functions provided by the thermal core for:
81193e2e6b4737 drivers/thermal/thermal_core.c Eduardo Valentin       2016-11-07   753   * - cooling devices lifecycle: registration, unregistration,
81193e2e6b4737 drivers/thermal/thermal_core.c Eduardo Valentin       2016-11-07   754   *				binding, and unbinding.
81193e2e6b4737 drivers/thermal/thermal_core.c Eduardo Valentin       2016-11-07   755   * - thermal zone devices lifecycle: registration, unregistration,
81193e2e6b4737 drivers/thermal/thermal_core.c Eduardo Valentin       2016-11-07   756   *				     binding, and unbinding.
81193e2e6b4737 drivers/thermal/thermal_core.c Eduardo Valentin       2016-11-07   757   */
203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui              2008-01-17   758  
203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui              2008-01-17   759  /**
d069ed6b752f91 drivers/thermal/thermal_core.c Rafael J. Wysocki      2023-09-21   760   * thermal_bind_cdev_to_trip - bind a cooling device to a thermal zone
d2e4eb83e7523c drivers/thermal/thermal_core.c Eduardo Valentin       2013-04-23   761   * @tz:		pointer to struct thermal_zone_device
d069ed6b752f91 drivers/thermal/thermal_core.c Rafael J. Wysocki      2023-09-21   762   * @trip:	trip point the cooling devices is associated with in this zone.
d2e4eb83e7523c drivers/thermal/thermal_core.c Eduardo Valentin       2013-04-23   763   * @cdev:	pointer to struct thermal_cooling_device
d2e4eb83e7523c drivers/thermal/thermal_core.c Eduardo Valentin       2013-04-23   764   * @upper:	the Maximum cooling state for this trip point.
d2e4eb83e7523c drivers/thermal/thermal_core.c Eduardo Valentin       2013-04-23   765   *		THERMAL_NO_LIMIT means no upper limit,
d2e4eb83e7523c drivers/thermal/thermal_core.c Eduardo Valentin       2013-04-23   766   *		and the cooling device can be in max_state.
d2e4eb83e7523c drivers/thermal/thermal_core.c Eduardo Valentin       2013-04-23   767   * @lower:	the Minimum cooling state can be used for this trip point.
d2e4eb83e7523c drivers/thermal/thermal_core.c Eduardo Valentin       2013-04-23   768   *		THERMAL_NO_LIMIT means no lower limit,
d2e4eb83e7523c drivers/thermal/thermal_core.c Eduardo Valentin       2013-04-23   769   *		and the cooling device can be in cooling state 0.
6cd9e9f629f11b drivers/thermal/thermal_core.c Kapileshwar Singh      2015-02-18   770   * @weight:	The weight of the cooling device to be bound to the
6cd9e9f629f11b drivers/thermal/thermal_core.c Kapileshwar Singh      2015-02-18   771   *		thermal zone. Use THERMAL_WEIGHT_DEFAULT for the
6cd9e9f629f11b drivers/thermal/thermal_core.c Kapileshwar Singh      2015-02-18   772   *		default value
543a956140e1f5 drivers/thermal/thermal.c      Len Brown              2008-02-07   773   *
d2e4eb83e7523c drivers/thermal/thermal_core.c Eduardo Valentin       2013-04-23   774   * This interface function bind a thermal cooling device to the certain trip
d2e4eb83e7523c drivers/thermal/thermal_core.c Eduardo Valentin       2013-04-23   775   * point of a thermal zone device.
543a956140e1f5 drivers/thermal/thermal.c      Len Brown              2008-02-07   776   * This function is usually called in the thermal zone device .bind callback.
d2e4eb83e7523c drivers/thermal/thermal_core.c Eduardo Valentin       2013-04-23   777   *
d2e4eb83e7523c drivers/thermal/thermal_core.c Eduardo Valentin       2013-04-23   778   * Return: 0 on success, the proper error value otherwise.
203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui              2008-01-17   779   */
d069ed6b752f91 drivers/thermal/thermal_core.c Rafael J. Wysocki      2023-09-21   780  int thermal_bind_cdev_to_trip(struct thermal_zone_device *tz,
b23e156c27ccc7 drivers/thermal/thermal_core.c Rafael J. Wysocki      2024-07-30   781  				     struct thermal_trip *trip,
9d99842f99d847 drivers/thermal/thermal_sys.c  Zhang Rui              2012-06-26   782  				     struct thermal_cooling_device *cdev,
6cd9e9f629f11b drivers/thermal/thermal_core.c Kapileshwar Singh      2015-02-18   783  				     unsigned long upper, unsigned long lower,
6cd9e9f629f11b drivers/thermal/thermal_core.c Kapileshwar Singh      2015-02-18   784  				     unsigned int weight)
203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui              2008-01-17   785  {
b23e156c27ccc7 drivers/thermal/thermal_core.c Rafael J. Wysocki      2024-07-30   786  	struct thermal_trip_desc *td = trip_to_trip_desc(trip);
b23e156c27ccc7 drivers/thermal/thermal_core.c Rafael J. Wysocki      2024-07-30   787  	struct thermal_instance *dev, *instance;
790930f44289c8 drivers/thermal/thermal_core.c Rafael J. Wysocki      2023-03-17   788  	bool upper_no_limit;
c408b3d1d9bbc7 drivers/thermal/thermal_core.c Viresh Kumar           2022-10-17   789  	int result;
203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui              2008-01-17   790  
4812cf7c673701 drivers/thermal/thermal_core.c Rafael J. Wysocki      2024-07-30   791  	lockdep_assert_held(&thermal_list_lock);
c751670902c3dd drivers/thermal/thermal.c      Thomas Sujith          2008-02-15   792  
4812cf7c673701 drivers/thermal/thermal_core.c Rafael J. Wysocki      2024-07-30   793  	if (list_empty(&tz->node) || list_empty(&cdev->node))
203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui              2008-01-17   794  		return -EINVAL;
203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui              2008-01-17   795  
9d99842f99d847 drivers/thermal/thermal_sys.c  Zhang Rui              2012-06-26   796  	/* lower default 0, upper default max_state */
4812cf7c673701 drivers/thermal/thermal_core.c Rafael J. Wysocki      2024-07-30   797  	if (lower == THERMAL_NO_LIMIT)
4812cf7c673701 drivers/thermal/thermal_core.c Rafael J. Wysocki      2024-07-30   798  		lower = 0;
790930f44289c8 drivers/thermal/thermal_core.c Rafael J. Wysocki      2023-03-17   799  
790930f44289c8 drivers/thermal/thermal_core.c Rafael J. Wysocki      2023-03-17   800  	if (upper == THERMAL_NO_LIMIT) {
790930f44289c8 drivers/thermal/thermal_core.c Rafael J. Wysocki      2023-03-17   801  		upper = cdev->max_state;
790930f44289c8 drivers/thermal/thermal_core.c Rafael J. Wysocki      2023-03-17   802  		upper_no_limit = true;
790930f44289c8 drivers/thermal/thermal_core.c Rafael J. Wysocki      2023-03-17   803  	} else {
790930f44289c8 drivers/thermal/thermal_core.c Rafael J. Wysocki      2023-03-17   804  		upper_no_limit = false;
790930f44289c8 drivers/thermal/thermal_core.c Rafael J. Wysocki      2023-03-17   805  	}
9d99842f99d847 drivers/thermal/thermal_sys.c  Zhang Rui              2012-06-26   806  
c408b3d1d9bbc7 drivers/thermal/thermal_core.c Viresh Kumar           2022-10-17   807  	if (lower > upper || upper > cdev->max_state)
9d99842f99d847 drivers/thermal/thermal_sys.c  Zhang Rui              2012-06-26   808  		return -EINVAL;
9d99842f99d847 drivers/thermal/thermal_sys.c  Zhang Rui              2012-06-26   809  
95e3ed1513494a drivers/thermal/thermal_core.c Eduardo Valentin       2016-11-07   810  	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui              2008-01-17   811  	if (!dev)
203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui              2008-01-17   812  		return -ENOMEM;
203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui              2008-01-17   813  	dev->tz = tz;
203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui              2008-01-17   814  	dev->cdev = cdev;
203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui              2008-01-17   815  	dev->trip = trip;
9d99842f99d847 drivers/thermal/thermal_sys.c  Zhang Rui              2012-06-26   816  	dev->upper = upper;
790930f44289c8 drivers/thermal/thermal_core.c Rafael J. Wysocki      2023-03-17   817  	dev->upper_no_limit = upper_no_limit;
9d99842f99d847 drivers/thermal/thermal_sys.c  Zhang Rui              2012-06-26   818  	dev->lower = lower;
ce119f83257aae drivers/thermal/thermal_sys.c  Zhang Rui              2012-06-27   819  	dev->target = THERMAL_NO_TARGET;
6cd9e9f629f11b drivers/thermal/thermal_core.c Kapileshwar Singh      2015-02-18   820  	dev->weight = weight;
74051ba50583a5 drivers/thermal/thermal_sys.c  Zhang Rui              2012-06-26   821  
5a5b7d8d541684 drivers/thermal/thermal_core.c keliu                  2022-05-27   822  	result = ida_alloc(&tz->ida, GFP_KERNEL);
b31ef8285b19ec drivers/thermal/thermal_core.c Matthew Wilcox         2016-12-21   823  	if (result < 0)
203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui              2008-01-17   824  		goto free_mem;
203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui              2008-01-17   825  
b31ef8285b19ec drivers/thermal/thermal_core.c Matthew Wilcox         2016-12-21   826  	dev->id = result;
203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui              2008-01-17   827  	sprintf(dev->name, "cdev%d", dev->id);
203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui              2008-01-17   828  	result =
203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui              2008-01-17   829  	    sysfs_create_link(&tz->device.kobj, &cdev->device.kobj, dev->name);
203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui              2008-01-17   830  	if (result)
b31ef8285b19ec drivers/thermal/thermal_core.c Matthew Wilcox         2016-12-21   831  		goto release_ida;
203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui              2008-01-17   832  
c99626092efca3 drivers/thermal/thermal_core.c Dan Carpenter          2023-10-07   833  	snprintf(dev->attr_name, sizeof(dev->attr_name), "cdev%d_trip_point",
c99626092efca3 drivers/thermal/thermal_core.c Dan Carpenter          2023-10-07   834  		 dev->id);
975f8c5653acba drivers/thermal/thermal_sys.c  Sergey Senozhatsky     2010-04-06   835  	sysfs_attr_init(&dev->attr.attr);
203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui              2008-01-17   836  	dev->attr.attr.name = dev->attr_name;
203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui              2008-01-17   837  	dev->attr.attr.mode = 0444;
33e678d47d1f3e drivers/thermal/thermal_core.c Viresh Kumar           2018-04-03   838  	dev->attr.show = trip_point_show;
203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui              2008-01-17   839  	result = device_create_file(&tz->device, &dev->attr);
203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui              2008-01-17   840  	if (result)
203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui              2008-01-17   841  		goto remove_symbol_link;
203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui              2008-01-17   842  
c99626092efca3 drivers/thermal/thermal_core.c Dan Carpenter          2023-10-07   843  	snprintf(dev->weight_attr_name, sizeof(dev->weight_attr_name),
c99626092efca3 drivers/thermal/thermal_core.c Dan Carpenter          2023-10-07   844  		 "cdev%d_weight", dev->id);
db91651311c8b8 drivers/thermal/thermal_core.c Javi Merino            2015-02-18   845  	sysfs_attr_init(&dev->weight_attr.attr);
db91651311c8b8 drivers/thermal/thermal_core.c Javi Merino            2015-02-18   846  	dev->weight_attr.attr.name = dev->weight_attr_name;
db91651311c8b8 drivers/thermal/thermal_core.c Javi Merino            2015-02-18   847  	dev->weight_attr.attr.mode = S_IWUSR | S_IRUGO;
33e678d47d1f3e drivers/thermal/thermal_core.c Viresh Kumar           2018-04-03   848  	dev->weight_attr.show = weight_show;
33e678d47d1f3e drivers/thermal/thermal_core.c Viresh Kumar           2018-04-03   849  	dev->weight_attr.store = weight_store;
db91651311c8b8 drivers/thermal/thermal_core.c Javi Merino            2015-02-18   850  	result = device_create_file(&tz->device, &dev->weight_attr);
db91651311c8b8 drivers/thermal/thermal_core.c Javi Merino            2015-02-18   851  	if (result)
db91651311c8b8 drivers/thermal/thermal_core.c Javi Merino            2015-02-18   852  		goto remove_trip_file;
db91651311c8b8 drivers/thermal/thermal_core.c Javi Merino            2015-02-18   853  
203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui              2008-01-17   854  	mutex_lock(&tz->lock);
f4a821ce6ed419 drivers/thermal/thermal_sys.c  Zhang Rui              2012-07-24   855  	mutex_lock(&cdev->lock);
b23e156c27ccc7 drivers/thermal/thermal_core.c Rafael J. Wysocki      2024-07-30   856  	list_for_each_entry(instance, &td->thermal_instances, trip_node) {
b23e156c27ccc7 drivers/thermal/thermal_core.c Rafael J. Wysocki      2024-07-30   857  		if (instance->cdev == cdev) {
203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui              2008-01-17   858  			result = -EEXIST;
203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui              2008-01-17   859  			break;
203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui              2008-01-17   860  		}
b5e4ae620b0627 drivers/thermal/thermal_sys.c  Zhang Rui              2012-06-27   861  	if (!result) {
cddf31b3b293fd drivers/thermal/thermal_sys.c  Zhang Rui              2012-06-27  @862  		list_add_tail(&dev->tz_node, &tz->thermal_instances);
b5e4ae620b0627 drivers/thermal/thermal_sys.c  Zhang Rui              2012-06-27   863  		list_add_tail(&dev->cdev_node, &cdev->thermal_instances);
4511f7166a2deb drivers/thermal/thermal_core.c Chen Yu                2015-10-30   864  		atomic_set(&tz->need_update, 1);
a8c959402d4dd6 drivers/thermal/thermal_core.c Lukasz Luba            2023-12-20   865  
a8c959402d4dd6 drivers/thermal/thermal_core.c Lukasz Luba            2023-12-20   866  		thermal_governor_update_tz(tz, THERMAL_TZ_BIND_CDEV);
b5e4ae620b0627 drivers/thermal/thermal_sys.c  Zhang Rui              2012-06-27   867  	}
f4a821ce6ed419 drivers/thermal/thermal_sys.c  Zhang Rui              2012-07-24   868  	mutex_unlock(&cdev->lock);
203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui              2008-01-17   869  	mutex_unlock(&tz->lock);
203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui              2008-01-17   870  
203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui              2008-01-17   871  	if (!result)
203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui              2008-01-17   872  		return 0;
203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui              2008-01-17   873  
db91651311c8b8 drivers/thermal/thermal_core.c Javi Merino            2015-02-18   874  	device_remove_file(&tz->device, &dev->weight_attr);
db91651311c8b8 drivers/thermal/thermal_core.c Javi Merino            2015-02-18   875  remove_trip_file:
203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui              2008-01-17   876  	device_remove_file(&tz->device, &dev->attr);
203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui              2008-01-17   877  remove_symbol_link:
203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui              2008-01-17   878  	sysfs_remove_link(&tz->device.kobj, dev->name);
b31ef8285b19ec drivers/thermal/thermal_core.c Matthew Wilcox         2016-12-21   879  release_ida:
5a5b7d8d541684 drivers/thermal/thermal_core.c keliu                  2022-05-27   880  	ida_free(&tz->ida, dev->id);
203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui              2008-01-17   881  free_mem:
203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui              2008-01-17   882  	kfree(dev);
203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui              2008-01-17   883  	return result;
203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui              2008-01-17   884  }
d069ed6b752f91 drivers/thermal/thermal_core.c Rafael J. Wysocki      2023-09-21   885  EXPORT_SYMBOL_GPL(thermal_bind_cdev_to_trip);
d069ed6b752f91 drivers/thermal/thermal_core.c Rafael J. Wysocki      2023-09-21   886  
d069ed6b752f91 drivers/thermal/thermal_core.c Rafael J. Wysocki      2023-09-21   887  int thermal_zone_bind_cooling_device(struct thermal_zone_device *tz,
d069ed6b752f91 drivers/thermal/thermal_core.c Rafael J. Wysocki      2023-09-21   888  				     int trip_index,
d069ed6b752f91 drivers/thermal/thermal_core.c Rafael J. Wysocki      2023-09-21   889  				     struct thermal_cooling_device *cdev,
d069ed6b752f91 drivers/thermal/thermal_core.c Rafael J. Wysocki      2023-09-21   890  				     unsigned long upper, unsigned long lower,
d069ed6b752f91 drivers/thermal/thermal_core.c Rafael J. Wysocki      2023-09-21   891  				     unsigned int weight)
d069ed6b752f91 drivers/thermal/thermal_core.c Rafael J. Wysocki      2023-09-21   892  {
d069ed6b752f91 drivers/thermal/thermal_core.c Rafael J. Wysocki      2023-09-21   893  	if (trip_index < 0 || trip_index >= tz->num_trips)
d069ed6b752f91 drivers/thermal/thermal_core.c Rafael J. Wysocki      2023-09-21   894  		return -EINVAL;
d069ed6b752f91 drivers/thermal/thermal_core.c Rafael J. Wysocki      2023-09-21   895  
daeeb032f42d06 drivers/thermal/thermal_core.c Rafael J. Wysocki      2024-04-02   896  	return thermal_bind_cdev_to_trip(tz, &tz->trips[trip_index].trip, cdev,
d069ed6b752f91 drivers/thermal/thermal_core.c Rafael J. Wysocki      2023-09-21   897  					 upper, lower, weight);
d069ed6b752f91 drivers/thermal/thermal_core.c Rafael J. Wysocki      2023-09-21   898  }
910cb1e34d2fb8 drivers/thermal/thermal_core.c Eduardo Valentin       2013-04-23   899  EXPORT_SYMBOL_GPL(thermal_zone_bind_cooling_device);
203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui              2008-01-17   900  
203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui              2008-01-17   901  /**
d069ed6b752f91 drivers/thermal/thermal_core.c Rafael J. Wysocki      2023-09-21   902   * thermal_unbind_cdev_from_trip - unbind a cooling device from a thermal zone.
9892e5dc56f185 drivers/thermal/thermal_core.c Eduardo Valentin       2013-04-23   903   * @tz:		pointer to a struct thermal_zone_device.
d069ed6b752f91 drivers/thermal/thermal_core.c Rafael J. Wysocki      2023-09-21   904   * @trip:	trip point the cooling devices is associated with in this zone.
9892e5dc56f185 drivers/thermal/thermal_core.c Eduardo Valentin       2013-04-23   905   * @cdev:	pointer to a struct thermal_cooling_device.
543a956140e1f5 drivers/thermal/thermal.c      Len Brown              2008-02-07   906   *
9892e5dc56f185 drivers/thermal/thermal_core.c Eduardo Valentin       2013-04-23   907   * This interface function unbind a thermal cooling device from the certain
9892e5dc56f185 drivers/thermal/thermal_core.c Eduardo Valentin       2013-04-23   908   * trip point of a thermal zone device.
543a956140e1f5 drivers/thermal/thermal.c      Len Brown              2008-02-07   909   * This function is usually called in the thermal zone device .unbind callback.
9892e5dc56f185 drivers/thermal/thermal_core.c Eduardo Valentin       2013-04-23   910   *
9892e5dc56f185 drivers/thermal/thermal_core.c Eduardo Valentin       2013-04-23   911   * Return: 0 on success, the proper error value otherwise.
203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui              2008-01-17   912   */
d069ed6b752f91 drivers/thermal/thermal_core.c Rafael J. Wysocki      2023-09-21   913  int thermal_unbind_cdev_from_trip(struct thermal_zone_device *tz,
b23e156c27ccc7 drivers/thermal/thermal_core.c Rafael J. Wysocki      2024-07-30   914  				  struct thermal_trip *trip,
203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui              2008-01-17   915  				  struct thermal_cooling_device *cdev)
203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui              2008-01-17   916  {
b23e156c27ccc7 drivers/thermal/thermal_core.c Rafael J. Wysocki      2024-07-30   917  	struct thermal_trip_desc *td = trip_to_trip_desc(trip);
b81b6ba3d9ac5f drivers/thermal/thermal_sys.c  Zhang Rui              2012-06-27   918  	struct thermal_instance *pos, *next;
203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui              2008-01-17   919  
203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui              2008-01-17   920  	mutex_lock(&tz->lock);
f4a821ce6ed419 drivers/thermal/thermal_sys.c  Zhang Rui              2012-07-24   921  	mutex_lock(&cdev->lock);
b23e156c27ccc7 drivers/thermal/thermal_core.c Rafael J. Wysocki      2024-07-30   922  	list_for_each_entry_safe(pos, next, &td->thermal_instances, trip_node) {
b23e156c27ccc7 drivers/thermal/thermal_core.c Rafael J. Wysocki      2024-07-30   923  		if (pos->cdev == cdev) {
b23e156c27ccc7 drivers/thermal/thermal_core.c Rafael J. Wysocki      2024-07-30   924  			list_del(&pos->trip_node);
b5e4ae620b0627 drivers/thermal/thermal_sys.c  Zhang Rui              2012-06-27   925  			list_del(&pos->cdev_node);
a8c959402d4dd6 drivers/thermal/thermal_core.c Lukasz Luba            2023-12-20   926  
a8c959402d4dd6 drivers/thermal/thermal_core.c Lukasz Luba            2023-12-20   927  			thermal_governor_update_tz(tz, THERMAL_TZ_UNBIND_CDEV);
a8c959402d4dd6 drivers/thermal/thermal_core.c Lukasz Luba            2023-12-20   928  
f4a821ce6ed419 drivers/thermal/thermal_sys.c  Zhang Rui              2012-07-24   929  			mutex_unlock(&cdev->lock);
203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui              2008-01-17   930  			mutex_unlock(&tz->lock);
203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui              2008-01-17   931  			goto unbind;
203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui              2008-01-17   932  		}
203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui              2008-01-17   933  	}
f4a821ce6ed419 drivers/thermal/thermal_sys.c  Zhang Rui              2012-07-24   934  	mutex_unlock(&cdev->lock);
203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui              2008-01-17   935  	mutex_unlock(&tz->lock);
203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui              2008-01-17   936  
203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui              2008-01-17   937  	return -ENODEV;
203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui              2008-01-17   938  
203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui              2008-01-17   939  unbind:
528464eaa46ae1 drivers/thermal/thermal_core.c Viresh Kumar           2015-07-23   940  	device_remove_file(&tz->device, &pos->weight_attr);
203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui              2008-01-17   941  	device_remove_file(&tz->device, &pos->attr);
203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui              2008-01-17   942  	sysfs_remove_link(&tz->device.kobj, pos->name);
5a5b7d8d541684 drivers/thermal/thermal_core.c keliu                  2022-05-27   943  	ida_free(&tz->ida, pos->id);
203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui              2008-01-17   944  	kfree(pos);
203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui              2008-01-17   945  	return 0;
203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui              2008-01-17   946  }
d069ed6b752f91 drivers/thermal/thermal_core.c Rafael J. Wysocki      2023-09-21   947  EXPORT_SYMBOL_GPL(thermal_unbind_cdev_from_trip);
d069ed6b752f91 drivers/thermal/thermal_core.c Rafael J. Wysocki      2023-09-21   948  
d069ed6b752f91 drivers/thermal/thermal_core.c Rafael J. Wysocki      2023-09-21   949  int thermal_zone_unbind_cooling_device(struct thermal_zone_device *tz,
d069ed6b752f91 drivers/thermal/thermal_core.c Rafael J. Wysocki      2023-09-21   950  				       int trip_index,
d069ed6b752f91 drivers/thermal/thermal_core.c Rafael J. Wysocki      2023-09-21   951  				       struct thermal_cooling_device *cdev)
d069ed6b752f91 drivers/thermal/thermal_core.c Rafael J. Wysocki      2023-09-21   952  {
d069ed6b752f91 drivers/thermal/thermal_core.c Rafael J. Wysocki      2023-09-21   953  	if (trip_index < 0 || trip_index >= tz->num_trips)
d069ed6b752f91 drivers/thermal/thermal_core.c Rafael J. Wysocki      2023-09-21   954  		return -EINVAL;
d069ed6b752f91 drivers/thermal/thermal_core.c Rafael J. Wysocki      2023-09-21   955  
daeeb032f42d06 drivers/thermal/thermal_core.c Rafael J. Wysocki      2024-04-02   956  	return thermal_unbind_cdev_from_trip(tz, &tz->trips[trip_index].trip, cdev);
d069ed6b752f91 drivers/thermal/thermal_core.c Rafael J. Wysocki      2023-09-21   957  }
910cb1e34d2fb8 drivers/thermal/thermal_core.c Eduardo Valentin       2013-04-23   958  EXPORT_SYMBOL_GPL(thermal_zone_unbind_cooling_device);
203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui              2008-01-17   959  
203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui              2008-01-17  @960  static void thermal_release(struct device *dev)
203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui              2008-01-17   961  {
203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui              2008-01-17   962  	struct thermal_zone_device *tz;
203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui              2008-01-17   963  	struct thermal_cooling_device *cdev;
203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui              2008-01-17   964  
caca8b803520b0 drivers/thermal/thermal_sys.c  Joe Perches            2012-03-21   965  	if (!strncmp(dev_name(dev), "thermal_zone",
caca8b803520b0 drivers/thermal/thermal_sys.c  Joe Perches            2012-03-21   966  		     sizeof("thermal_zone") - 1)) {
203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui              2008-01-17   967  		tz = to_thermal_zone(dev);
6a6cd25b58dc8c drivers/thermal/thermal_core.c Christophe Jaillet     2017-08-08   968  		thermal_zone_destroy_device_groups(tz);
d35f29ed9d11cc drivers/thermal/thermal_core.c Guenter Roeck          2022-11-10   969  		mutex_destroy(&tz->lock);
4649620d9404d3 drivers/thermal/thermal_core.c Rafael J. Wysocki      2023-12-08   970  		complete(&tz->removal);
732e4c8db99cb3 drivers/thermal/thermal_core.c durgadoss.r@intel.com  2013-10-02   971  	} else if (!strncmp(dev_name(dev), "cooling_device",
732e4c8db99cb3 drivers/thermal/thermal_core.c durgadoss.r@intel.com  2013-10-02   972  			    sizeof("cooling_device") - 1)) {
203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui              2008-01-17   973  		cdev = to_cooling_device(dev);
e398421fd03cf7 drivers/thermal/thermal_core.c Viresh Kumar           2023-01-18   974  		thermal_cooling_device_destroy_sysfs(cdev);
57a427c81c322c drivers/thermal/thermal_core.c Christophe JAILLET     2024-01-05   975  		kfree_const(cdev->type);
e398421fd03cf7 drivers/thermal/thermal_core.c Viresh Kumar           2023-01-18   976  		ida_free(&thermal_cdev_ida, cdev->id);
203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui              2008-01-17   977  		kfree(cdev);
203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui              2008-01-17   978  	}
203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui              2008-01-17   979  }
203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui              2008-01-17   980  
9e0a9be24bdd61 drivers/thermal/thermal_core.c Rafael J. Wysocki      2023-01-23   981  static struct class *thermal_class;
203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui              2008-01-17   982  
4b0d3c2d3b60cf drivers/thermal/thermal_core.c Eduardo Valentin       2016-11-07   983  static inline
4b0d3c2d3b60cf drivers/thermal/thermal_core.c Eduardo Valentin       2016-11-07  @984  void print_bind_err_msg(struct thermal_zone_device *tz,
f502ab84401341 drivers/thermal/thermal_core.c Eduardo Valentin       2016-11-07   985  			struct thermal_cooling_device *cdev, int ret)
f502ab84401341 drivers/thermal/thermal_core.c Eduardo Valentin       2016-11-07   986  {
f502ab84401341 drivers/thermal/thermal_core.c Eduardo Valentin       2016-11-07   987  	dev_err(&tz->device, "binding zone %s with cdev %s failed:%d\n",
f502ab84401341 drivers/thermal/thermal_core.c Eduardo Valentin       2016-11-07   988  		tz->type, cdev->type, ret);
f502ab84401341 drivers/thermal/thermal_core.c Eduardo Valentin       2016-11-07   989  }
f502ab84401341 drivers/thermal/thermal_core.c Eduardo Valentin       2016-11-07   990  
203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui              2008-01-17   991  /**
a116b5d44f1445 drivers/thermal/thermal_core.c Eduardo Valentin       2013-09-26   992   * __thermal_cooling_device_register() - register a new thermal cooling device
a116b5d44f1445 drivers/thermal/thermal_core.c Eduardo Valentin       2013-09-26   993   * @np:		a pointer to a device tree node.
203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui              2008-01-17   994   * @type:	the thermal cooling device type.
203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui              2008-01-17   995   * @devdata:	device private data.
203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui              2008-01-17   996   * @ops:		standard thermal cooling devices callbacks.
3a6eccb35219a7 drivers/thermal/thermal_core.c Eduardo Valentin       2013-04-23   997   *
3a6eccb35219a7 drivers/thermal/thermal_core.c Eduardo Valentin       2013-04-23   998   * This interface function adds a new thermal cooling device (fan/processor/...)
3a6eccb35219a7 drivers/thermal/thermal_core.c Eduardo Valentin       2013-04-23   999   * to /sys/class/thermal/ folder as cooling_device[0-*]. It tries to bind itself
3a6eccb35219a7 drivers/thermal/thermal_core.c Eduardo Valentin       2013-04-23  1000   * to all the thermal zone devices registered at the same time.
a116b5d44f1445 drivers/thermal/thermal_core.c Eduardo Valentin       2013-09-26  1001   * It also gives the opportunity to link the cooling device to a device tree
a116b5d44f1445 drivers/thermal/thermal_core.c Eduardo Valentin       2013-09-26  1002   * node, so that it can be bound to a thermal zone created out of device tree.
3a6eccb35219a7 drivers/thermal/thermal_core.c Eduardo Valentin       2013-04-23  1003   *
3a6eccb35219a7 drivers/thermal/thermal_core.c Eduardo Valentin       2013-04-23  1004   * Return: a pointer to the created struct thermal_cooling_device or an
3a6eccb35219a7 drivers/thermal/thermal_core.c Eduardo Valentin       2013-04-23  1005   * ERR_PTR. Caller must check return value with IS_ERR*() helpers.
203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui              2008-01-17  1006   */
a116b5d44f1445 drivers/thermal/thermal_core.c Eduardo Valentin       2013-09-26  1007  static struct thermal_cooling_device *
a116b5d44f1445 drivers/thermal/thermal_core.c Eduardo Valentin       2013-09-26 @1008  __thermal_cooling_device_register(struct device_node *np,
f991de53a8abef drivers/thermal/thermal_core.c Jean-Francois Dagenais 2019-04-18  1009  				  const char *type, void *devdata,
caca8b803520b0 drivers/thermal/thermal_sys.c  Joe Perches            2012-03-21  1010  				  const struct thermal_cooling_device_ops *ops)
203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui              2008-01-17  1011  {
203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui              2008-01-17  1012  	struct thermal_cooling_device *cdev;
4511f7166a2deb drivers/thermal/thermal_core.c Chen Yu                2015-10-30  1013  	struct thermal_zone_device *pos = NULL;
31a0fa0019b022 drivers/thermal/thermal_core.c Rafael J. Wysocki      2024-04-25  1014  	unsigned long current_state;
0a5c26712f963f drivers/thermal/thermal_core.c Ziyang Xuan            2021-10-15  1015  	int id, ret;
203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui              2008-01-17  1016  
203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui              2008-01-17  1017  	if (!ops || !ops->get_max_state || !ops->get_cur_state ||
203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui              2008-01-17  1018  	    !ops->set_cur_state)
3e6fda5c115982 drivers/thermal/thermal.c      Thomas Sujith          2008-02-15  1019  		return ERR_PTR(-EINVAL);
203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui              2008-01-17  1020  
9e0a9be24bdd61 drivers/thermal/thermal_core.c Rafael J. Wysocki      2023-01-23  1021  	if (!thermal_class)
9e0a9be24bdd61 drivers/thermal/thermal_core.c Rafael J. Wysocki      2023-01-23  1022  		return ERR_PTR(-ENODEV);
9e0a9be24bdd61 drivers/thermal/thermal_core.c Rafael J. Wysocki      2023-01-23  1023  
95e3ed1513494a drivers/thermal/thermal_core.c Eduardo Valentin       2016-11-07  1024  	cdev = kzalloc(sizeof(*cdev), GFP_KERNEL);
203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui              2008-01-17  1025  	if (!cdev)
3e6fda5c115982 drivers/thermal/thermal.c      Thomas Sujith          2008-02-15  1026  		return ERR_PTR(-ENOMEM);
203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui              2008-01-17  1027  
5a5b7d8d541684 drivers/thermal/thermal_core.c keliu                  2022-05-27  1028  	ret = ida_alloc(&thermal_cdev_ida, GFP_KERNEL);
58483761810087 drivers/thermal/thermal_core.c Daniel Lezcano         2021-03-14  1029  	if (ret < 0)
58483761810087 drivers/thermal/thermal_core.c Daniel Lezcano         2021-03-14  1030  		goto out_kfree_cdev;
58483761810087 drivers/thermal/thermal_core.c Daniel Lezcano         2021-03-14  1031  	cdev->id = ret;
0a5c26712f963f drivers/thermal/thermal_core.c Ziyang Xuan            2021-10-15  1032  	id = ret;
58483761810087 drivers/thermal/thermal_core.c Daniel Lezcano         2021-03-14  1033  
57a427c81c322c drivers/thermal/thermal_core.c Christophe JAILLET     2024-01-05  1034  	cdev->type = kstrdup_const(type ? type : "", GFP_KERNEL);
58483761810087 drivers/thermal/thermal_core.c Daniel Lezcano         2021-03-14  1035  	if (!cdev->type) {
58483761810087 drivers/thermal/thermal_core.c Daniel Lezcano         2021-03-14  1036  		ret = -ENOMEM;
58483761810087 drivers/thermal/thermal_core.c Daniel Lezcano         2021-03-14  1037  		goto out_ida_remove;
203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui              2008-01-17  1038  	}
203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui              2008-01-17  1039  
f4a821ce6ed419 drivers/thermal/thermal_sys.c  Zhang Rui              2012-07-24  1040  	mutex_init(&cdev->lock);
b5e4ae620b0627 drivers/thermal/thermal_sys.c  Zhang Rui              2012-06-27  1041  	INIT_LIST_HEAD(&cdev->thermal_instances);
a116b5d44f1445 drivers/thermal/thermal_core.c Eduardo Valentin       2013-09-26  1042  	cdev->np = np;
203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui              2008-01-17  1043  	cdev->ops = ops;
5ca0cce5622bf4 drivers/thermal/thermal_core.c Ni Wade                2014-02-17  1044  	cdev->updated = false;
9e0a9be24bdd61 drivers/thermal/thermal_core.c Rafael J. Wysocki      2023-01-23  1045  	cdev->device.class = thermal_class;
203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui              2008-01-17  1046  	cdev->devdata = devdata;
c408b3d1d9bbc7 drivers/thermal/thermal_core.c Viresh Kumar           2022-10-17  1047  
e49a1e1ee078ae drivers/thermal/thermal_core.c Dan Carpenter          2022-10-28  1048  	ret = cdev->ops->get_max_state(cdev, &cdev->max_state);
e398421fd03cf7 drivers/thermal/thermal_core.c Viresh Kumar           2023-01-18  1049  	if (ret)
e398421fd03cf7 drivers/thermal/thermal_core.c Viresh Kumar           2023-01-18  1050  		goto out_cdev_type;
c408b3d1d9bbc7 drivers/thermal/thermal_core.c Viresh Kumar           2022-10-17  1051  
1af89dedc8a580 drivers/thermal/thermal_core.c Rafael J. Wysocki      2024-06-06  1052  	/*
1af89dedc8a580 drivers/thermal/thermal_core.c Rafael J. Wysocki      2024-06-06  1053  	 * The cooling device's current state is only needed for debug
1af89dedc8a580 drivers/thermal/thermal_core.c Rafael J. Wysocki      2024-06-06  1054  	 * initialization below, so a failure to get it does not cause
1af89dedc8a580 drivers/thermal/thermal_core.c Rafael J. Wysocki      2024-06-06  1055  	 * the entire cooling device initialization to fail.  However,
1af89dedc8a580 drivers/thermal/thermal_core.c Rafael J. Wysocki      2024-06-06  1056  	 * the debug will not work for the device if its initial state
1af89dedc8a580 drivers/thermal/thermal_core.c Rafael J. Wysocki      2024-06-06  1057  	 * cannot be determined and drivers are responsible for ensuring
1af89dedc8a580 drivers/thermal/thermal_core.c Rafael J. Wysocki      2024-06-06  1058  	 * that this will not happen.
1af89dedc8a580 drivers/thermal/thermal_core.c Rafael J. Wysocki      2024-06-06  1059  	 */
31a0fa0019b022 drivers/thermal/thermal_core.c Rafael J. Wysocki      2024-04-25  1060  	ret = cdev->ops->get_cur_state(cdev, &current_state);
31a0fa0019b022 drivers/thermal/thermal_core.c Rafael J. Wysocki      2024-04-25  1061  	if (ret)
1af89dedc8a580 drivers/thermal/thermal_core.c Rafael J. Wysocki      2024-06-06  1062  		current_state = ULONG_MAX;
31a0fa0019b022 drivers/thermal/thermal_core.c Rafael J. Wysocki      2024-04-25  1063  
8ea229511e06f9 drivers/thermal/thermal_core.c Viresh Kumar           2018-04-02  1064  	thermal_cooling_device_setup_sysfs(cdev);
6c54b7bc8a31ce drivers/thermal/thermal_core.c Viresh Kumar           2023-01-18  1065  
4748f9687caaee drivers/thermal/thermal_core.c Yang Yingliang         2022-11-15  1066  	ret = dev_set_name(&cdev->device, "cooling_device%d", cdev->id);
e398421fd03cf7 drivers/thermal/thermal_core.c Viresh Kumar           2023-01-18  1067  	if (ret)
e398421fd03cf7 drivers/thermal/thermal_core.c Viresh Kumar           2023-01-18  1068  		goto out_cooling_dev;
6c54b7bc8a31ce drivers/thermal/thermal_core.c Viresh Kumar           2023-01-18  1069  
58483761810087 drivers/thermal/thermal_core.c Daniel Lezcano         2021-03-14  1070  	ret = device_register(&cdev->device);
e398421fd03cf7 drivers/thermal/thermal_core.c Viresh Kumar           2023-01-18  1071  	if (ret) {
e398421fd03cf7 drivers/thermal/thermal_core.c Viresh Kumar           2023-01-18  1072  		/* thermal_release() handles rest of the cleanup */
e398421fd03cf7 drivers/thermal/thermal_core.c Viresh Kumar           2023-01-18  1073  		put_device(&cdev->device);
e398421fd03cf7 drivers/thermal/thermal_core.c Viresh Kumar           2023-01-18  1074  		return ERR_PTR(ret);
e398421fd03cf7 drivers/thermal/thermal_core.c Viresh Kumar           2023-01-18  1075  	}
203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui              2008-01-17  1076  
1af89dedc8a580 drivers/thermal/thermal_core.c Rafael J. Wysocki      2024-06-06  1077  	if (current_state <= cdev->max_state)
31a0fa0019b022 drivers/thermal/thermal_core.c Rafael J. Wysocki      2024-04-25  1078  		thermal_debug_cdev_add(cdev, current_state);
31a0fa0019b022 drivers/thermal/thermal_core.c Rafael J. Wysocki      2024-04-25  1079  
7e8ee1e9d7561f drivers/thermal/thermal_sys.c  Durgadoss R            2012-09-18  1080  	/* Add 'this' new cdev to the global cdev list */
203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui              2008-01-17  1081  	mutex_lock(&thermal_list_lock);
cd246fa969ec9f drivers/thermal/thermal_core.c Rafael J. Wysocki      2023-03-22  1082  
203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui              2008-01-17  1083  	list_add(&cdev->node, &thermal_cdev_list);
203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui              2008-01-17  1084  
7e8ee1e9d7561f drivers/thermal/thermal_sys.c  Durgadoss R            2012-09-18  1085  	/* Update binding information for 'this' new cdev */
922099c0c7a013 drivers/thermal/thermal_core.c Rafael J. Wysocki      2024-07-30  1086  	list_for_each_entry(pos, &thermal_tz_list, node) {
922099c0c7a013 drivers/thermal/thermal_core.c Rafael J. Wysocki      2024-07-30  1087  		if (pos->ops.bind) {
922099c0c7a013 drivers/thermal/thermal_core.c Rafael J. Wysocki      2024-07-30  1088  			ret = pos->ops.bind(pos, cdev);
922099c0c7a013 drivers/thermal/thermal_core.c Rafael J. Wysocki      2024-07-30  1089  			if (ret)
922099c0c7a013 drivers/thermal/thermal_core.c Rafael J. Wysocki      2024-07-30  1090  				print_bind_err_msg(pos, cdev, ret);
922099c0c7a013 drivers/thermal/thermal_core.c Rafael J. Wysocki      2024-07-30  1091  		}
922099c0c7a013 drivers/thermal/thermal_core.c Rafael J. Wysocki      2024-07-30  1092  	}
7e8ee1e9d7561f drivers/thermal/thermal_sys.c  Durgadoss R            2012-09-18  1093  
4511f7166a2deb drivers/thermal/thermal_core.c Chen Yu                2015-10-30  1094  	list_for_each_entry(pos, &thermal_tz_list, node)
4511f7166a2deb drivers/thermal/thermal_core.c Chen Yu                2015-10-30  1095  		if (atomic_cmpxchg(&pos->need_update, 1, 0))
0e70f466fb910a drivers/thermal/thermal_core.c Srinivas Pandruvada    2016-08-26  1096  			thermal_zone_device_update(pos,
0e70f466fb910a drivers/thermal/thermal_core.c Srinivas Pandruvada    2016-08-26  1097  						   THERMAL_EVENT_UNSPECIFIED);
cd246fa969ec9f drivers/thermal/thermal_core.c Rafael J. Wysocki      2023-03-22  1098  
4511f7166a2deb drivers/thermal/thermal_core.c Chen Yu                2015-10-30  1099  	mutex_unlock(&thermal_list_lock);
4511f7166a2deb drivers/thermal/thermal_core.c Chen Yu                2015-10-30  1100  
203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui              2008-01-17  1101  	return cdev;
58483761810087 drivers/thermal/thermal_core.c Daniel Lezcano         2021-03-14  1102  
e398421fd03cf7 drivers/thermal/thermal_core.c Viresh Kumar           2023-01-18  1103  out_cooling_dev:
98a160e898c0f4 drivers/thermal/thermal_core.c Yang Yingliang         2022-05-11  1104  	thermal_cooling_device_destroy_sysfs(cdev);
e398421fd03cf7 drivers/thermal/thermal_core.c Viresh Kumar           2023-01-18  1105  out_cdev_type:
57a427c81c322c drivers/thermal/thermal_core.c Christophe JAILLET     2024-01-05  1106  	kfree_const(cdev->type);
58483761810087 drivers/thermal/thermal_core.c Daniel Lezcano         2021-03-14  1107  out_ida_remove:
5a5b7d8d541684 drivers/thermal/thermal_core.c keliu                  2022-05-27  1108  	ida_free(&thermal_cdev_ida, id);
58483761810087 drivers/thermal/thermal_core.c Daniel Lezcano         2021-03-14  1109  out_kfree_cdev:
d44616c6cc3e35 drivers/thermal/thermal_core.c Daniel Lezcano         2021-03-19  1110  	kfree(cdev);
58483761810087 drivers/thermal/thermal_core.c Daniel Lezcano         2021-03-14  1111  	return ERR_PTR(ret);
203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui              2008-01-17  1112  }
a116b5d44f1445 drivers/thermal/thermal_core.c Eduardo Valentin       2013-09-26  1113  

:::::: The code at line 862 was first introduced by commit
:::::: cddf31b3b293fd20358ea506f22445611425811f Thermal: Rename thermal_instance.node to thermal_instance.tz_node.

:::::: TO: Zhang Rui <rui.zhang@intel.com>
:::::: CC: Zhang Rui <rui.zhang@intel.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

