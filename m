Return-Path: <linux-acpi+bounces-7556-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D37E95092B
	for <lists+linux-acpi@lfdr.de>; Tue, 13 Aug 2024 17:31:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF24DB2491F
	for <lists+linux-acpi@lfdr.de>; Tue, 13 Aug 2024 15:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 041731A01DB;
	Tue, 13 Aug 2024 15:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fLzv5Gnx"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D0819D886;
	Tue, 13 Aug 2024 15:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723563096; cv=none; b=XptNOO2vubxVQ8hvgxJUyCgFTvT+m3XdcQbIEeJkvQmkusPRPYb3ruBkw2+PJ24ML3OX6LF5/JB9uU20KicoAaSftieZiiHU9s4TUoWufzhGmfiGS0AGP8YQWrV82s1RL0qkndM/UugimoDc1/947Tx77/B+27xHDm4MXLFOJ4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723563096; c=relaxed/simple;
	bh=2D5MLlwqy83hI+9CIsIBf24jGbY27cmhAGq9DW9iT/s=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=DJHphq5nmaVbhFrG3ddwFDhL6P+1vG6P4ET5DABHc/ijaFMKhymG4kzhDrO3hdwAhsh6wTxFw5MWwslcHJnL32V3AuEnAU4WIrYy8UrXMgxkndPj7A9e9GIuQeltLbU27aw4F+ayquiMafYK1pYL1hBmkfWRSjqunlpMZOK3jBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fLzv5Gnx; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723563095; x=1755099095;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=2D5MLlwqy83hI+9CIsIBf24jGbY27cmhAGq9DW9iT/s=;
  b=fLzv5GnxxCM0X7PwrfLkC2RGZW2YiZV5kAd7PcfS/7G8xO5Zknga1q93
   nmtLf22ojdDC7oG2uOssBBpmy59gQqRQeRkmuGefwWrhS6+87oAGY7Thg
   PkCIzZNXMdNJ45PS3vdfXr/g2ndiNrpHoDv1cawRJtL5esBDbkZhWnJjk
   plfnG/4FPpABV7lz5S+pyjakR+MlHF6+12wiv+lKDhhlo/fEPj9hz8Qal
   +DPGjaROcth74LLwaRe3zXWdxA9tj3KdZFTuNuRqyrKiv5nNnAfW36L6D
   Wx80y/lThf/XgYN1K6Jgk0/TkDY/QYGbo6kw56l2+ZNCHE2osTvqCTB3R
   w==;
X-CSE-ConnectionGUID: TPhoe3isQBu11giSdVTa/w==
X-CSE-MsgGUID: 43Gpj0KGShq8xi7UEroJ8w==
X-IronPort-AV: E=McAfee;i="6700,10204,11163"; a="25599226"
X-IronPort-AV: E=Sophos;i="6.09,286,1716274800"; 
   d="scan'208";a="25599226"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 08:31:34 -0700
X-CSE-ConnectionGUID: rGcoqeHES+CqKnpPwm8AQQ==
X-CSE-MsgGUID: s/h0F1SDQKmqnqYbA6jmkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,286,1716274800"; 
   d="scan'208";a="63640137"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 13 Aug 2024 08:31:30 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sdtUd-0000Y2-2R;
	Tue, 13 Aug 2024 15:31:27 +0000
Date: Tue, 13 Aug 2024 23:30:52 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: oe-kbuild-all@lists.linux.dev, linux-acpi@vger.kernel.org,
	devel@acpica.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge 84/99]
 drivers/thermal/thermal_core.c:1012:13: error: invalid storage class for
 function 'thermal_zone_cdev_binding'
Message-ID: <202408132357.AhdAtHMM-lkp@intel.com>
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
commit: 314fb95573c3ab521dfe3a72e1171ce337db20d6 [84/99] thermal: core: Introduce .should_bind() thermal zone callback
config: x86_64-defconfig (https://download.01.org/0day-ci/archive/20240813/202408132357.AhdAtHMM-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240813/202408132357.AhdAtHMM-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408132357.AhdAtHMM-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/thermal/thermal_core.c: In function 'thermal_bind_cdev_to_trip':
   drivers/thermal/thermal_core.c:862:37: error: 'struct thermal_instance' has no member named 'tz_node'; did you mean 'trip_node'?
     862 |                 list_add_tail(&dev->tz_node, &tz->thermal_instances);
         |                                     ^~~~~~~
         |                                     trip_node
   drivers/thermal/thermal_core.c:862:49: error: 'struct thermal_zone_device' has no member named 'thermal_instances'
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
   drivers/thermal/thermal_core.c:906:19: error: non-static declaration of 'thermal_zone_bind_cooling_device' follows static declaration
     906 | EXPORT_SYMBOL_GPL(thermal_zone_bind_cooling_device);
         |                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/export.h:56:28: note: in definition of macro '__EXPORT_SYMBOL'
      56 |         extern typeof(sym) sym;                                 \
         |                            ^~~
   include/linux/export.h:69:41: note: in expansion of macro '_EXPORT_SYMBOL'
      69 | #define EXPORT_SYMBOL_GPL(sym)          _EXPORT_SYMBOL(sym, "GPL")
         |                                         ^~~~~~~~~~~~~~
   drivers/thermal/thermal_core.c:906:1: note: in expansion of macro 'EXPORT_SYMBOL_GPL'
     906 | EXPORT_SYMBOL_GPL(thermal_zone_bind_cooling_device);
         | ^~~~~~~~~~~~~~~~~
   drivers/thermal/thermal_core.c:886:5: note: previous definition of 'thermal_zone_bind_cooling_device' with type 'int(struct thermal_zone_device *, int,  struct thermal_cooling_device *, long unsigned int,  long unsigned int,  unsigned int)'
     886 | int thermal_zone_bind_cooling_device(struct thermal_zone_device *tz,
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
   drivers/thermal/thermal_core.c:953:19: error: non-static declaration of 'thermal_unbind_cdev_from_trip' follows static declaration
     953 | EXPORT_SYMBOL_GPL(thermal_unbind_cdev_from_trip);
         |                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/export.h:56:28: note: in definition of macro '__EXPORT_SYMBOL'
      56 |         extern typeof(sym) sym;                                 \
         |                            ^~~
   include/linux/export.h:69:41: note: in expansion of macro '_EXPORT_SYMBOL'
      69 | #define EXPORT_SYMBOL_GPL(sym)          _EXPORT_SYMBOL(sym, "GPL")
         |                                         ^~~~~~~~~~~~~~
   drivers/thermal/thermal_core.c:953:1: note: in expansion of macro 'EXPORT_SYMBOL_GPL'
     953 | EXPORT_SYMBOL_GPL(thermal_unbind_cdev_from_trip);
         | ^~~~~~~~~~~~~~~~~
   drivers/thermal/thermal_core.c:920:5: note: previous definition of 'thermal_unbind_cdev_from_trip' with type 'int(struct thermal_zone_device *, struct thermal_trip *, struct thermal_cooling_device *)'
     920 | int thermal_unbind_cdev_from_trip(struct thermal_zone_device *tz,
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
   drivers/thermal/thermal_core.c:972:19: error: non-static declaration of 'thermal_zone_unbind_cooling_device' follows static declaration
     972 | EXPORT_SYMBOL_GPL(thermal_zone_unbind_cooling_device);
         |                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/export.h:56:28: note: in definition of macro '__EXPORT_SYMBOL'
      56 |         extern typeof(sym) sym;                                 \
         |                            ^~~
   include/linux/export.h:69:41: note: in expansion of macro '_EXPORT_SYMBOL'
      69 | #define EXPORT_SYMBOL_GPL(sym)          _EXPORT_SYMBOL(sym, "GPL")
         |                                         ^~~~~~~~~~~~~~
   drivers/thermal/thermal_core.c:972:1: note: in expansion of macro 'EXPORT_SYMBOL_GPL'
     972 | EXPORT_SYMBOL_GPL(thermal_zone_unbind_cooling_device);
         | ^~~~~~~~~~~~~~~~~
   drivers/thermal/thermal_core.c:955:5: note: previous definition of 'thermal_zone_unbind_cooling_device' with type 'int(struct thermal_zone_device *, int,  struct thermal_cooling_device *)'
     955 | int thermal_zone_unbind_cooling_device(struct thermal_zone_device *tz,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/thermal/thermal_core.c:974:13: error: invalid storage class for function 'thermal_release'
     974 | static void thermal_release(struct device *dev)
         |             ^~~~~~~~~~~~~~~
   drivers/thermal/thermal_core.c:998:6: error: invalid storage class for function 'print_bind_err_msg'
     998 | void print_bind_err_msg(struct thermal_zone_device *tz,
         |      ^~~~~~~~~~~~~~~~~~
>> drivers/thermal/thermal_core.c:1012:13: error: invalid storage class for function 'thermal_zone_cdev_binding'
    1012 | static void thermal_zone_cdev_binding(struct thermal_zone_device *tz,
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/thermal/thermal_core.c:1071:1: error: invalid storage class for function '__thermal_cooling_device_register'
    1071 | __thermal_cooling_device_register(struct device_node *np,
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
   drivers/thermal/thermal_core.c:1191:19: error: non-static declaration of 'thermal_cooling_device_register' follows static declaration
    1191 | EXPORT_SYMBOL_GPL(thermal_cooling_device_register);
         |                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/export.h:56:28: note: in definition of macro '__EXPORT_SYMBOL'
      56 |         extern typeof(sym) sym;                                 \
         |                            ^~~
   include/linux/export.h:69:41: note: in expansion of macro '_EXPORT_SYMBOL'
      69 | #define EXPORT_SYMBOL_GPL(sym)          _EXPORT_SYMBOL(sym, "GPL")
         |                                         ^~~~~~~~~~~~~~
   drivers/thermal/thermal_core.c:1191:1: note: in expansion of macro 'EXPORT_SYMBOL_GPL'
    1191 | EXPORT_SYMBOL_GPL(thermal_cooling_device_register);
         | ^~~~~~~~~~~~~~~~~
   drivers/thermal/thermal_core.c:1186:1: note: previous definition of 'thermal_cooling_device_register' with type 'struct thermal_cooling_device *(const char *, void *, const struct thermal_cooling_device_ops *)'
    1186 | thermal_cooling_device_register(const char *type, void *devdata,
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
   drivers/thermal/thermal_core.c:1215:19: error: non-static declaration of 'thermal_of_cooling_device_register' follows static declaration
    1215 | EXPORT_SYMBOL_GPL(thermal_of_cooling_device_register);
         |                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/export.h:56:28: note: in definition of macro '__EXPORT_SYMBOL'
      56 |         extern typeof(sym) sym;                                 \
         |                            ^~~
   include/linux/export.h:69:41: note: in expansion of macro '_EXPORT_SYMBOL'
      69 | #define EXPORT_SYMBOL_GPL(sym)          _EXPORT_SYMBOL(sym, "GPL")
         |                                         ^~~~~~~~~~~~~~
   drivers/thermal/thermal_core.c:1215:1: note: in expansion of macro 'EXPORT_SYMBOL_GPL'
    1215 | EXPORT_SYMBOL_GPL(thermal_of_cooling_device_register);
         | ^~~~~~~~~~~~~~~~~
   drivers/thermal/thermal_core.c:1209:1: note: previous definition of 'thermal_of_cooling_device_register' with type 'struct thermal_cooling_device *(struct device_node *, const char *, void *, const struct thermal_cooling_device_ops *)'
    1209 | thermal_of_cooling_device_register(struct device_node *np,
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/thermal/thermal_core.c:1217:13: error: invalid storage class for function 'thermal_cooling_device_release'
    1217 | static void thermal_cooling_device_release(struct device *dev, void *res)
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
   drivers/thermal/thermal_core.c:1264:19: error: non-static declaration of 'devm_thermal_of_cooling_device_register' follows static declaration
    1264 | EXPORT_SYMBOL_GPL(devm_thermal_of_cooling_device_register);
         |                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/export.h:56:28: note: in definition of macro '__EXPORT_SYMBOL'
      56 |         extern typeof(sym) sym;                                 \
         |                            ^~~
   include/linux/export.h:69:41: note: in expansion of macro '_EXPORT_SYMBOL'
      69 | #define EXPORT_SYMBOL_GPL(sym)          _EXPORT_SYMBOL(sym, "GPL")
         |                                         ^~~~~~~~~~~~~~
   drivers/thermal/thermal_core.c:1264:1: note: in expansion of macro 'EXPORT_SYMBOL_GPL'
    1264 | EXPORT_SYMBOL_GPL(devm_thermal_of_cooling_device_register);
         | ^~~~~~~~~~~~~~~~~
   drivers/thermal/thermal_core.c:1241:1: note: previous definition of 'devm_thermal_of_cooling_device_register' with type 'struct thermal_cooling_device *(struct device *, struct device_node *, const char *, void *, const struct thermal_cooling_device_ops *)'
    1241 | devm_thermal_of_cooling_device_register(struct device *dev,
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/thermal/thermal_core.c:1266:13: error: invalid storage class for function 'thermal_cooling_device_present'
    1266 | static bool thermal_cooling_device_present(struct thermal_cooling_device *cdev)
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
   drivers/thermal/thermal_core.c:1349:19: error: non-static declaration of 'thermal_cooling_device_update' follows static declaration
    1349 | EXPORT_SYMBOL_GPL(thermal_cooling_device_update);
         |                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/export.h:56:28: note: in definition of macro '__EXPORT_SYMBOL'
      56 |         extern typeof(sym) sym;                                 \
         |                            ^~~
   include/linux/export.h:69:41: note: in expansion of macro '_EXPORT_SYMBOL'
      69 | #define EXPORT_SYMBOL_GPL(sym)          _EXPORT_SYMBOL(sym, "GPL")
         |                                         ^~~~~~~~~~~~~~
   drivers/thermal/thermal_core.c:1349:1: note: in expansion of macro 'EXPORT_SYMBOL_GPL'
    1349 | EXPORT_SYMBOL_GPL(thermal_cooling_device_update);
         | ^~~~~~~~~~~~~~~~~
   drivers/thermal/thermal_core.c:1288:6: note: previous definition of 'thermal_cooling_device_update' with type 'void(struct thermal_cooling_device *)'
    1288 | void thermal_cooling_device_update(struct thermal_cooling_device *cdev)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/thermal/thermal_core.c:1351:13: error: invalid storage class for function 'thermal_zone_cdev_unbinding'
    1351 | static void thermal_zone_cdev_unbinding(struct thermal_zone_device *tz,
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/linkage.h:7,
                    from arch/x86/include/asm/cache.h:5,
                    from include/linux/cache.h:6,
                    from arch/x86/include/asm/current.h:10,
                    from include/linux/sched.h:12,
                    from include/linux/ratelimit.h:6,
                    from include/linux/dev_printk.h:16,
                    from include/linux/device.h:15,
                    from drivers/thermal/thermal_core.c:12:
   drivers/thermal/thermal_core.c:1406:19: error: non-static declaration of 'thermal_cooling_device_unregister' follows static declaration
    1406 | EXPORT_SYMBOL_GPL(thermal_cooling_device_unregister);
         |                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/export.h:56:28: note: in definition of macro '__EXPORT_SYMBOL'
      56 |         extern typeof(sym) sym;                                 \
         |                            ^~~
   include/linux/export.h:69:41: note: in expansion of macro '_EXPORT_SYMBOL'
      69 | #define EXPORT_SYMBOL_GPL(sym)          _EXPORT_SYMBOL(sym, "GPL")
         |                                         ^~~~~~~~~~~~~~
   drivers/thermal/thermal_core.c:1406:1: note: in expansion of macro 'EXPORT_SYMBOL_GPL'
    1406 | EXPORT_SYMBOL_GPL(thermal_cooling_device_unregister);
         | ^~~~~~~~~~~~~~~~~
   drivers/thermal/thermal_core.c:1380:6: note: previous definition of 'thermal_cooling_device_unregister' with type 'void(struct thermal_cooling_device *)'
    1380 | void thermal_cooling_device_unregister(struct thermal_cooling_device *cdev)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/thermal/thermal_core.c:1408:13: error: invalid storage class for function 'thermal_set_delay_jiffies'
    1408 | static void thermal_set_delay_jiffies(unsigned long *delay_jiffies, int delay_ms)
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
   drivers/thermal/thermal_core.c:1439:19: error: non-static declaration of 'thermal_zone_get_crit_temp' follows static declaration
    1439 | EXPORT_SYMBOL_GPL(thermal_zone_get_crit_temp);
         |                   ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/export.h:56:28: note: in definition of macro '__EXPORT_SYMBOL'
      56 |         extern typeof(sym) sym;                                 \
         |                            ^~~
   include/linux/export.h:69:41: note: in expansion of macro '_EXPORT_SYMBOL'
      69 | #define EXPORT_SYMBOL_GPL(sym)          _EXPORT_SYMBOL(sym, "GPL")
         |                                         ^~~~~~~~~~~~~~
   drivers/thermal/thermal_core.c:1439:1: note: in expansion of macro 'EXPORT_SYMBOL_GPL'
    1439 | EXPORT_SYMBOL_GPL(thermal_zone_get_crit_temp);
         | ^~~~~~~~~~~~~~~~~
   drivers/thermal/thermal_core.c:1415:5: note: previous definition of 'thermal_zone_get_crit_temp' with type 'int(struct thermal_zone_device *, int *)'
    1415 | int thermal_zone_get_crit_temp(struct thermal_zone_device *tz, int *temp)
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
   drivers/thermal/thermal_core.c:1641:19: error: non-static declaration of 'thermal_zone_device_register_with_trips' follows static declaration
    1641 | EXPORT_SYMBOL_GPL(thermal_zone_device_register_with_trips);
         |                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/export.h:56:28: note: in definition of macro '__EXPORT_SYMBOL'
      56 |         extern typeof(sym) sym;                                 \
         |                            ^~~
   include/linux/export.h:69:41: note: in expansion of macro '_EXPORT_SYMBOL'
      69 | #define EXPORT_SYMBOL_GPL(sym)          _EXPORT_SYMBOL(sym, "GPL")
         |                                         ^~~~~~~~~~~~~~
   drivers/thermal/thermal_core.c:1641:1: note: in expansion of macro 'EXPORT_SYMBOL_GPL'
    1641 | EXPORT_SYMBOL_GPL(thermal_zone_device_register_with_trips);
         | ^~~~~~~~~~~~~~~~~
   drivers/thermal/thermal_core.c:1466:1: note: previous definition of 'thermal_zone_device_register_with_trips' with type 'struct thermal_zone_device *(const char *, const struct thermal_trip *, int,  void *, const struct thermal_zone_device_ops *, const struct thermal_zone_params *, unsigned int,  unsigned int)'
    1466 | thermal_zone_device_register_with_trips(const char *type,
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
   drivers/thermal/thermal_core.c:1652:19: error: non-static declaration of 'thermal_tripless_zone_device_register' follows static declaration
    1652 | EXPORT_SYMBOL_GPL(thermal_tripless_zone_device_register);
         |                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/export.h:56:28: note: in definition of macro '__EXPORT_SYMBOL'
      56 |         extern typeof(sym) sym;                                 \
         |                            ^~~
   include/linux/export.h:69:41: note: in expansion of macro '_EXPORT_SYMBOL'
      69 | #define EXPORT_SYMBOL_GPL(sym)          _EXPORT_SYMBOL(sym, "GPL")
         |                                         ^~~~~~~~~~~~~~
   drivers/thermal/thermal_core.c:1652:1: note: in expansion of macro 'EXPORT_SYMBOL_GPL'
    1652 | EXPORT_SYMBOL_GPL(thermal_tripless_zone_device_register);
         | ^~~~~~~~~~~~~~~~~
   drivers/thermal/thermal_core.c:1643:29: note: previous definition of 'thermal_tripless_zone_device_register' with type 'struct thermal_zone_device *(const char *, void *, const struct thermal_zone_device_ops *, const struct thermal_zone_params *)'
    1643 | struct thermal_zone_device *thermal_tripless_zone_device_register(


vim +/thermal_zone_cdev_binding +1012 drivers/thermal/thermal_core.c

  1011	
> 1012	static void thermal_zone_cdev_binding(struct thermal_zone_device *tz,
  1013					      struct thermal_cooling_device *cdev)
  1014	{
  1015		struct thermal_trip_desc *td;
  1016		int ret;
  1017	
  1018		/*
  1019		 * Old-style binding. The .bind() callback is expected to call
  1020		 * thermal_bind_cdev_to_trip() under the thermal zone lock.
  1021		 */
  1022		if (tz->ops.bind) {
  1023			ret = tz->ops.bind(tz, cdev);
  1024			if (ret)
  1025				print_bind_err_msg(tz, NULL, cdev, ret);
  1026	
  1027			return;
  1028		}
  1029	
  1030		if (!tz->ops.should_bind)
  1031			return;
  1032	
  1033		mutex_lock(&tz->lock);
  1034	
  1035		for_each_trip_desc(tz, td) {
  1036			struct thermal_trip *trip = &td->trip;
  1037			struct cooling_spec c = {
  1038				.upper = THERMAL_NO_LIMIT,
  1039				.lower = THERMAL_NO_LIMIT,
  1040				.weight = THERMAL_WEIGHT_DEFAULT
  1041			};
  1042	
  1043			if (tz->ops.should_bind(tz, trip, cdev, &c)) {
  1044				ret = thermal_bind_cdev_to_trip(tz, trip, cdev, c.upper,
  1045								c.lower, c.weight);
  1046				if (ret)
  1047					print_bind_err_msg(tz, trip, cdev, ret);
  1048			}
  1049		}
  1050	
  1051		mutex_unlock(&tz->lock);
  1052	}
  1053	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

