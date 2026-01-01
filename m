Return-Path: <linux-acpi+bounces-19923-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 30D57CED8A8
	for <lists+linux-acpi@lfdr.de>; Fri, 02 Jan 2026 00:13:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 00FA930053F7
	for <lists+linux-acpi@lfdr.de>; Thu,  1 Jan 2026 23:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F546274FDB;
	Thu,  1 Jan 2026 23:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eQzCSCnk"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86092276051;
	Thu,  1 Jan 2026 23:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767309234; cv=none; b=Pd6vFH7oaZNVmykB6sHJpaaIptE0Hw90Ls8U5Czhpan0raDBZoE4VaWUTT0OT1f/nZKStL+plWAbHkvt46sUwOf+JnOMO8QTVlwvv87I3IZeHxP8n6rn/Am3IpK65+KGUgPBaK6OWMKgctJ5HYc3RNuJ1sSuKG6d3axbWoWa8cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767309234; c=relaxed/simple;
	bh=BlyLm3NmpTrYxgMqg5Q/NzPd9R2YS0UWZXglNmkIs1o=;
	h=Date:From:To:Cc:Subject:Message-ID; b=MmXl539G/h81jk8Yl1mMTzbfrJplEZn5cwENku3XWlVRf2+oFvDZ4Ml9aAMo5XPZoIdQsxSJcKLrnyCVFamiCCukL3zxtHEOls2e5lngjvu2BklqALbcLWc4Lck8lZXeJn0SRRi3SUXkUuKCRY98r/vNJUS/zp8b9pZq2xYijrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eQzCSCnk; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767309232; x=1798845232;
  h=date:from:to:cc:subject:message-id;
  bh=BlyLm3NmpTrYxgMqg5Q/NzPd9R2YS0UWZXglNmkIs1o=;
  b=eQzCSCnk77Ej5fKx3cN/zdoOEjulxas0qRptr/erCYgYcmNIHcbWN6ud
   3t3QBCf2MXj9m5/sMSEZbyMdFElftn21DT7UKGNtbvHB7uXG4ykAFgqv+
   3qCoiKMx89Tv6DatXxJAYeTX66UounbtS/xA4wb3OBkmM8Y17cuGqx++T
   eHmFG38ftZCQoEXydSXvw9BbWMa6SjutGEan+dQxRRdzMi5QpQeDTom6i
   XyhDqXRC4s6RhWfz6KTAux7c0JoKe2lv7ERR46YdAU5dAv6Ij/lVhkUx2
   YiiQR7TXiTI8IFW6WJOhu8rzDeg4wG9vyPR4xG/sTqs7+Z7EWqoK9TD6G
   Q==;
X-CSE-ConnectionGUID: izQ2yEhPSGGEDUcY4IC1xA==
X-CSE-MsgGUID: l8RCXrSeTZ66M9sE327owg==
X-IronPort-AV: E=McAfee;i="6800,10657,11658"; a="68984410"
X-IronPort-AV: E=Sophos;i="6.21,195,1763452800"; 
   d="scan'208";a="68984410"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jan 2026 15:13:51 -0800
X-CSE-ConnectionGUID: pY317pyMSGybr0usksZRNw==
X-CSE-MsgGUID: VnstpXTfSUeSgsTXVGiRhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,195,1763452800"; 
   d="scan'208";a="201335415"
Received: from lkp-server01.sh.intel.com (HELO c9aa31daaa89) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 01 Jan 2026 15:13:49 -0800
Received: from kbuild by c9aa31daaa89 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vbRrW-00000000237-2qrP;
	Thu, 01 Jan 2026 23:13:46 +0000
Date: Fri, 02 Jan 2026 07:13:44 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: oe-kbuild-all@lists.linux.dev, linux-acpi@vger.kernel.org,
 linux-pm@vger.kernel.org
Subject: [rafael-pm:pm-runtime-cleanup 24/25]
 drivers/clk/tegra/clk-device.c:178:9: error: expected declaration specifiers
 before 'return'
Message-ID: <202601020744.pPLXze8k-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-runtime-cleanup
head:   e853e6ed1e01eb6846357d4692bf6131e218837e
commit: a7e9532f30c77611ad48560b165326ce96e6e8dc [24/25] clk: tegra: Discard pm_runtime_put() return value
config: arm64-defconfig (https://download.01.org/0day-ci/archive/20260102/202601020744.pPLXze8k-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260102/202601020744.pPLXze8k-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601020744.pPLXze8k-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/clk/tegra/clk-device.c: In function 'tegra_clock_suspend':
>> drivers/clk/tegra/clk-device.c:178:9: error: expected declaration specifiers before 'return'
     178 |         return pm_runtime_resume_and_get(dev);
         |         ^~~~~~
>> drivers/clk/tegra/clk-device.c:179:1: error: expected declaration specifiers before '}' token
     179 | }
         | ^
>> drivers/clk/tegra/clk-device.c:182:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     182 | {
         | ^
>> drivers/clk/tegra/clk-device.c:187:32: error: storage class specified for parameter 'tegra_clock_pm'
     187 | static const struct dev_pm_ops tegra_clock_pm = {
         |                                ^~~~~~~~~~~~~~
>> drivers/clk/tegra/clk-device.c:187:21: error: parameter 'tegra_clock_pm' is initialized
     187 | static const struct dev_pm_ops tegra_clock_pm = {
         |                     ^~~~~~~~~~
   In file included from include/linux/kernel.h:36,
                    from include/linux/clk.h:13,
                    from drivers/clk/tegra/clk-device.c:3:
>> drivers/clk/tegra/clk-device.c:188:54: error: 'tegra_clock_resume' undeclared (first use in this function); did you mean 'tegra_clk_osc_resume'?
     188 |         SET_SYSTEM_SLEEP_PM_OPS(tegra_clock_suspend, tegra_clock_resume)
         |                                                      ^~~~~~~~~~~~~~~~~~
   include/linux/util_macros.h:136:44: note: in definition of macro 'PTR_IF'
     136 | #define PTR_IF(cond, ptr)       ((cond) ? (ptr) : NULL)
         |                                            ^~~
   include/linux/pm.h:316:19: note: in expansion of macro 'pm_sleep_ptr'
     316 |         .resume = pm_sleep_ptr(resume_fn), \
         |                   ^~~~~~~~~~~~
   include/linux/pm.h:345:9: note: in expansion of macro 'SYSTEM_SLEEP_PM_OPS'
     345 |         SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn)
         |         ^~~~~~~~~~~~~~~~~~~
   drivers/clk/tegra/clk-device.c:188:9: note: in expansion of macro 'SET_SYSTEM_SLEEP_PM_OPS'
     188 |         SET_SYSTEM_SLEEP_PM_OPS(tegra_clock_suspend, tegra_clock_resume)
         |         ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/clk/tegra/clk-device.c:188:54: note: each undeclared identifier is reported only once for each function it appears in
     188 |         SET_SYSTEM_SLEEP_PM_OPS(tegra_clock_suspend, tegra_clock_resume)
         |                                                      ^~~~~~~~~~~~~~~~~~
   include/linux/util_macros.h:136:44: note: in definition of macro 'PTR_IF'
     136 | #define PTR_IF(cond, ptr)       ((cond) ? (ptr) : NULL)
         |                                            ^~~
   include/linux/pm.h:316:19: note: in expansion of macro 'pm_sleep_ptr'
     316 |         .resume = pm_sleep_ptr(resume_fn), \
         |                   ^~~~~~~~~~~~
   include/linux/pm.h:345:9: note: in expansion of macro 'SYSTEM_SLEEP_PM_OPS'
     345 |         SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn)
         |         ^~~~~~~~~~~~~~~~~~~
   drivers/clk/tegra/clk-device.c:188:9: note: in expansion of macro 'SET_SYSTEM_SLEEP_PM_OPS'
     188 |         SET_SYSTEM_SLEEP_PM_OPS(tegra_clock_suspend, tegra_clock_resume)
         |         ^~~~~~~~~~~~~~~~~~~~~~~
>> drivers/clk/tegra/clk-device.c:191:34: error: storage class specified for parameter 'tegra_clock_match'
     191 | static const struct of_device_id tegra_clock_match[] = {
         |                                  ^~~~~~~~~~~~~~~~~
>> drivers/clk/tegra/clk-device.c:191:21: error: parameter 'tegra_clock_match' is initialized
     191 | static const struct of_device_id tegra_clock_match[] = {
         |                     ^~~~~~~~~~~~
>> drivers/clk/tegra/clk-device.c:191:56: error: variable-sized object may not be initialized except with an empty initializer
     191 | static const struct of_device_id tegra_clock_match[] = {
         |                                                        ^
   drivers/clk/tegra/clk-device.c:192:9: warning: braces around scalar initializer
     192 |         { .compatible = "nvidia,tegra20-sclk" },
         |         ^
   drivers/clk/tegra/clk-device.c:192:9: note: (near initialization for 'tegra_clock_match')
>> drivers/clk/tegra/clk-device.c:192:11: error: field name not in record or union initializer
     192 |         { .compatible = "nvidia,tegra20-sclk" },
         |           ^
   drivers/clk/tegra/clk-device.c:192:11: note: (near initialization for 'tegra_clock_match')
>> drivers/clk/tegra/clk-device.c:192:25: error: initialization of 'const struct of_device_id *' from incompatible pointer type 'char *' [-Wincompatible-pointer-types]
     192 |         { .compatible = "nvidia,tegra20-sclk" },
         |                         ^~~~~~~~~~~~~~~~~~~~~
   drivers/clk/tegra/clk-device.c:192:25: note: (near initialization for 'tegra_clock_match')
   drivers/clk/tegra/clk-device.c:193:9: warning: braces around scalar initializer
     193 |         { .compatible = "nvidia,tegra30-sclk" },
         |         ^
   drivers/clk/tegra/clk-device.c:193:9: note: (near initialization for 'tegra_clock_match')
   drivers/clk/tegra/clk-device.c:193:11: error: field name not in record or union initializer
     193 |         { .compatible = "nvidia,tegra30-sclk" },
         |           ^
   drivers/clk/tegra/clk-device.c:193:11: note: (near initialization for 'tegra_clock_match')
   drivers/clk/tegra/clk-device.c:193:25: error: initialization of 'const struct of_device_id *' from incompatible pointer type 'char *' [-Wincompatible-pointer-types]
     193 |         { .compatible = "nvidia,tegra30-sclk" },
         |                         ^~~~~~~~~~~~~~~~~~~~~
   drivers/clk/tegra/clk-device.c:193:25: note: (near initialization for 'tegra_clock_match')
   drivers/clk/tegra/clk-device.c:193:9: warning: excess elements in scalar initializer
     193 |         { .compatible = "nvidia,tegra30-sclk" },
         |         ^
   drivers/clk/tegra/clk-device.c:193:9: note: (near initialization for 'tegra_clock_match')
   drivers/clk/tegra/clk-device.c:194:9: warning: braces around scalar initializer
     194 |         { .compatible = "nvidia,tegra30-pllc" },
         |         ^
   drivers/clk/tegra/clk-device.c:194:9: note: (near initialization for 'tegra_clock_match')
   drivers/clk/tegra/clk-device.c:194:11: error: field name not in record or union initializer
     194 |         { .compatible = "nvidia,tegra30-pllc" },
         |           ^
   drivers/clk/tegra/clk-device.c:194:11: note: (near initialization for 'tegra_clock_match')
   drivers/clk/tegra/clk-device.c:194:25: error: initialization of 'const struct of_device_id *' from incompatible pointer type 'char *' [-Wincompatible-pointer-types]
     194 |         { .compatible = "nvidia,tegra30-pllc" },
         |                         ^~~~~~~~~~~~~~~~~~~~~
   drivers/clk/tegra/clk-device.c:194:25: note: (near initialization for 'tegra_clock_match')
   drivers/clk/tegra/clk-device.c:194:9: warning: excess elements in scalar initializer
     194 |         { .compatible = "nvidia,tegra30-pllc" },
         |         ^
   drivers/clk/tegra/clk-device.c:194:9: note: (near initialization for 'tegra_clock_match')
   drivers/clk/tegra/clk-device.c:195:9: warning: braces around scalar initializer
     195 |         { .compatible = "nvidia,tegra30-plle" },
         |         ^
   drivers/clk/tegra/clk-device.c:195:9: note: (near initialization for 'tegra_clock_match')
   drivers/clk/tegra/clk-device.c:195:11: error: field name not in record or union initializer
     195 |         { .compatible = "nvidia,tegra30-plle" },
         |           ^
   drivers/clk/tegra/clk-device.c:195:11: note: (near initialization for 'tegra_clock_match')
   drivers/clk/tegra/clk-device.c:195:25: error: initialization of 'const struct of_device_id *' from incompatible pointer type 'char *' [-Wincompatible-pointer-types]
     195 |         { .compatible = "nvidia,tegra30-plle" },
         |                         ^~~~~~~~~~~~~~~~~~~~~
   drivers/clk/tegra/clk-device.c:195:25: note: (near initialization for 'tegra_clock_match')
   drivers/clk/tegra/clk-device.c:195:9: warning: excess elements in scalar initializer
     195 |         { .compatible = "nvidia,tegra30-plle" },
         |         ^
   drivers/clk/tegra/clk-device.c:195:9: note: (near initialization for 'tegra_clock_match')
   drivers/clk/tegra/clk-device.c:196:9: warning: braces around scalar initializer
     196 |         { .compatible = "nvidia,tegra30-pllm" },
         |         ^
   drivers/clk/tegra/clk-device.c:196:9: note: (near initialization for 'tegra_clock_match')
   drivers/clk/tegra/clk-device.c:196:11: error: field name not in record or union initializer
     196 |         { .compatible = "nvidia,tegra30-pllm" },
         |           ^
   drivers/clk/tegra/clk-device.c:196:11: note: (near initialization for 'tegra_clock_match')
   drivers/clk/tegra/clk-device.c:196:25: error: initialization of 'const struct of_device_id *' from incompatible pointer type 'char *' [-Wincompatible-pointer-types]
     196 |         { .compatible = "nvidia,tegra30-pllm" },
         |                         ^~~~~~~~~~~~~~~~~~~~~
   drivers/clk/tegra/clk-device.c:196:25: note: (near initialization for 'tegra_clock_match')
   drivers/clk/tegra/clk-device.c:196:9: warning: excess elements in scalar initializer
     196 |         { .compatible = "nvidia,tegra30-pllm" },
         |         ^
   drivers/clk/tegra/clk-device.c:196:9: note: (near initialization for 'tegra_clock_match')
   drivers/clk/tegra/clk-device.c:197:9: warning: braces around scalar initializer
     197 |         { }
         |         ^
   drivers/clk/tegra/clk-device.c:197:9: note: (near initialization for 'tegra_clock_match')
   drivers/clk/tegra/clk-device.c:197:9: warning: excess elements in scalar initializer
   drivers/clk/tegra/clk-device.c:197:9: note: (near initialization for 'tegra_clock_match')
>> drivers/clk/tegra/clk-device.c:200:31: error: storage class specified for parameter 'tegra_clock_driver'
     200 | static struct platform_driver tegra_clock_driver = {
         |                               ^~~~~~~~~~~~~~~~~~
>> drivers/clk/tegra/clk-device.c:200:15: error: parameter 'tegra_clock_driver' is initialized
     200 | static struct platform_driver tegra_clock_driver = {
         |               ^~~~~~~~~~~~~~~
   In file included from include/linux/device.h:32,
                    from include/linux/platform_device.h:13,
                    from drivers/clk/tegra/clk-device.c:7:
>> include/linux/device/driver.h:286:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     286 | { \
         | ^
   include/linux/platform_device.h:305:9: note: in expansion of macro 'builtin_driver'
     305 |         builtin_driver(__platform_driver, platform_driver_register)
         |         ^~~~~~~~~~~~~~
   drivers/clk/tegra/clk-device.c:209:1: note: in expansion of macro 'builtin_platform_driver'
     209 | builtin_platform_driver(tegra_clock_driver);
         | ^~~~~~~~~~~~~~~~~~~~~~~
   In file included from <command-line>:
>> include/linux/compiler.h:168:17: error: storage class specified for parameter '__UNIQUE_ID_addressable_tegra_clock_driver_init_431'
     168 |         __PASTE(__UNIQUE_ID_,                                   \
         |                 ^~~~~~~~~~~~
   include/linux/compiler_types.h:15:24: note: in definition of macro '___PASTE'
      15 | #define ___PASTE(a, b) a##b
         |                        ^
   include/linux/compiler.h:168:9: note: in expansion of macro '__PASTE'
     168 |         __PASTE(__UNIQUE_ID_,                                   \
         |         ^~~~~~~
   include/linux/compiler.h:284:9: note: in expansion of macro '__UNIQUE_ID'
     284 |         __UNIQUE_ID(__PASTE(addressable_, sym)) = (void *)(uintptr_t)&sym;
         |         ^~~~~~~~~~~
   include/linux/compiler.h:287:9: note: in expansion of macro '___ADDRESSABLE'
     287 |         ___ADDRESSABLE(sym, __section(".discard.addressable"))
         |         ^~~~~~~~~~~~~~
   include/linux/init.h:251:9: note: in expansion of macro '__ADDRESSABLE'
     251 |         __ADDRESSABLE(fn)
         |         ^~~~~~~~~~~~~
   include/linux/init.h:256:9: note: in expansion of macro '__define_initcall_stub'
     256 |         __define_initcall_stub(__stub, fn)                      \
         |         ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/init.h:269:9: note: in expansion of macro '____define_initcall'
     269 |         ____define_initcall(fn,                                 \
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/init.h:275:9: note: in expansion of macro '__unique_initcall'
     275 |         __unique_initcall(fn, id, __sec, __initcall_id(fn))
         |         ^~~~~~~~~~~~~~~~~
   include/linux/init.h:277:35: note: in expansion of macro '___define_initcall'
     277 | #define __define_initcall(fn, id) ___define_initcall(fn, id, .initcall##id)
         |                                   ^~~~~~~~~~~~~~~~~~
   include/linux/init.h:306:41: note: in expansion of macro '__define_initcall'
     306 | #define device_initcall(fn)             __define_initcall(fn, 6)
         |                                         ^~~~~~~~~~~~~~~~~
   include/linux/device/driver.h:289:1: note: in expansion of macro 'device_initcall'
     289 | device_initcall(__driver##_init);
         | ^~~~~~~~~~~~~~~
   include/linux/platform_device.h:305:9: note: in expansion of macro 'builtin_driver'
     305 |         builtin_driver(__platform_driver, platform_driver_register)
         |         ^~~~~~~~~~~~~~
   drivers/clk/tegra/clk-device.c:209:1: note: in expansion of macro 'builtin_platform_driver'
     209 | builtin_platform_driver(tegra_clock_driver);
         | ^~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/device/driver.h:286:1: error: parameter '__UNIQUE_ID_addressable_tegra_clock_driver_init_431' is initialized
     286 | { \
         | ^
   include/linux/platform_device.h:305:9: note: in expansion of macro 'builtin_driver'
     305 |         builtin_driver(__platform_driver, platform_driver_register)
         |         ^~~~~~~~~~~~~~
   drivers/clk/tegra/clk-device.c:209:1: note: in expansion of macro 'builtin_platform_driver'
     209 | builtin_platform_driver(tegra_clock_driver);
         | ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/device/driver.h:286:1: warning: 'used' attribute ignored [-Wattributes]
     286 | { \
         | ^
   include/linux/platform_device.h:305:9: note: in expansion of macro 'builtin_driver'
     305 |         builtin_driver(__platform_driver, platform_driver_register)
         |         ^~~~~~~~~~~~~~
   drivers/clk/tegra/clk-device.c:209:1: note: in expansion of macro 'builtin_platform_driver'
     209 | builtin_platform_driver(tegra_clock_driver);
         | ^~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/compiler.h:168:17: error: section attribute not allowed for '__UNIQUE_ID_addressable_tegra_clock_driver_init_431'
     168 |         __PASTE(__UNIQUE_ID_,                                   \
         |                 ^~~~~~~~~~~~
   include/linux/compiler_types.h:15:24: note: in definition of macro '___PASTE'
      15 | #define ___PASTE(a, b) a##b
         |                        ^
   include/linux/compiler.h:168:9: note: in expansion of macro '__PASTE'
     168 |         __PASTE(__UNIQUE_ID_,                                   \
         |         ^~~~~~~
   include/linux/compiler.h:284:9: note: in expansion of macro '__UNIQUE_ID'
     284 |         __UNIQUE_ID(__PASTE(addressable_, sym)) = (void *)(uintptr_t)&sym;
         |         ^~~~~~~~~~~
   include/linux/compiler.h:287:9: note: in expansion of macro '___ADDRESSABLE'
     287 |         ___ADDRESSABLE(sym, __section(".discard.addressable"))
         |         ^~~~~~~~~~~~~~
   include/linux/init.h:251:9: note: in expansion of macro '__ADDRESSABLE'
     251 |         __ADDRESSABLE(fn)
         |         ^~~~~~~~~~~~~
   include/linux/init.h:256:9: note: in expansion of macro '__define_initcall_stub'
     256 |         __define_initcall_stub(__stub, fn)                      \
         |         ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/init.h:269:9: note: in expansion of macro '____define_initcall'
     269 |         ____define_initcall(fn,                                 \
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/init.h:275:9: note: in expansion of macro '__unique_initcall'
     275 |         __unique_initcall(fn, id, __sec, __initcall_id(fn))
         |         ^~~~~~~~~~~~~~~~~
   include/linux/init.h:277:35: note: in expansion of macro '___define_initcall'
     277 | #define __define_initcall(fn, id) ___define_initcall(fn, id, .initcall##id)
         |                                   ^~~~~~~~~~~~~~~~~~
   include/linux/init.h:306:41: note: in expansion of macro '__define_initcall'
     306 | #define device_initcall(fn)             __define_initcall(fn, 6)
         |                                         ^~~~~~~~~~~~~~~~~
   include/linux/device/driver.h:289:1: note: in expansion of macro 'device_initcall'
     289 | device_initcall(__driver##_init);
         | ^~~~~~~~~~~~~~~
   include/linux/platform_device.h:305:9: note: in expansion of macro 'builtin_driver'
     305 |         builtin_driver(__platform_driver, platform_driver_register)
         |         ^~~~~~~~~~~~~~
   drivers/clk/tegra/clk-device.c:209:1: note: in expansion of macro 'builtin_platform_driver'
     209 | builtin_platform_driver(tegra_clock_driver);
         | ^~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/err.h:5,
                    from include/linux/clk.h:12:
>> drivers/clk/tegra/clk-device.c:209:25: error: 'tegra_clock_driver_init' undeclared (first use in this function); did you mean 'tegra_clock_driver'?
     209 | builtin_platform_driver(tegra_clock_driver);
         |                         ^~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:284:71: note: in definition of macro '___ADDRESSABLE'
     284 |         __UNIQUE_ID(__PASTE(addressable_, sym)) = (void *)(uintptr_t)&sym;
         |                                                                       ^~~
   include/linux/init.h:251:9: note: in expansion of macro '__ADDRESSABLE'
     251 |         __ADDRESSABLE(fn)
         |         ^~~~~~~~~~~~~
   include/linux/init.h:256:9: note: in expansion of macro '__define_initcall_stub'
     256 |         __define_initcall_stub(__stub, fn)                      \
         |         ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/init.h:269:9: note: in expansion of macro '____define_initcall'
     269 |         ____define_initcall(fn,                                 \
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/init.h:275:9: note: in expansion of macro '__unique_initcall'
     275 |         __unique_initcall(fn, id, __sec, __initcall_id(fn))
         |         ^~~~~~~~~~~~~~~~~
   include/linux/init.h:277:35: note: in expansion of macro '___define_initcall'
     277 | #define __define_initcall(fn, id) ___define_initcall(fn, id, .initcall##id)
         |                                   ^~~~~~~~~~~~~~~~~~
   include/linux/init.h:306:41: note: in expansion of macro '__define_initcall'
     306 | #define device_initcall(fn)             __define_initcall(fn, 6)
         |                                         ^~~~~~~~~~~~~~~~~
   include/linux/device/driver.h:289:1: note: in expansion of macro 'device_initcall'
     289 | device_initcall(__driver##_init);
         | ^~~~~~~~~~~~~~~
   include/linux/platform_device.h:305:9: note: in expansion of macro 'builtin_driver'
     305 |         builtin_driver(__platform_driver, platform_driver_register)
         |         ^~~~~~~~~~~~~~
   drivers/clk/tegra/clk-device.c:209:1: note: in expansion of macro 'builtin_platform_driver'
     209 | builtin_platform_driver(tegra_clock_driver);
         | ^~~~~~~~~~~~~~~~~~~~~~~
   In file included from arch/arm64/include/asm/alternative.h:9,
                    from arch/arm64/include/asm/lse.h:14,
                    from arch/arm64/include/asm/cmpxchg.h:14,
                    from arch/arm64/include/asm/atomic.h:16,
                    from include/linux/atomic.h:7,
                    from include/asm-generic/bitops/atomic.h:5,
                    from arch/arm64/include/asm/bitops.h:25,
                    from include/linux/bitops.h:67,
                    from include/linux/kernel.h:23:
>> include/linux/init.h:257:9: error: expected declaration specifiers before 'asm'
     257 |         asm(".section   \"" __sec "\", \"a\"            \n"     \
         |         ^~~
   include/linux/init.h:269:9: note: in expansion of macro '____define_initcall'
     269 |         ____define_initcall(fn,                                 \
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/init.h:275:9: note: in expansion of macro '__unique_initcall'
     275 |         __unique_initcall(fn, id, __sec, __initcall_id(fn))
         |         ^~~~~~~~~~~~~~~~~
   include/linux/init.h:277:35: note: in expansion of macro '___define_initcall'
     277 | #define __define_initcall(fn, id) ___define_initcall(fn, id, .initcall##id)
         |                                   ^~~~~~~~~~~~~~~~~~
   include/linux/init.h:306:41: note: in expansion of macro '__define_initcall'
     306 | #define device_initcall(fn)             __define_initcall(fn, 6)
         |                                         ^~~~~~~~~~~~~~~~~
   include/linux/device/driver.h:289:1: note: in expansion of macro 'device_initcall'
     289 | device_initcall(__driver##_init);
         | ^~~~~~~~~~~~~~~
   include/linux/platform_device.h:305:9: note: in expansion of macro 'builtin_driver'
     305 |         builtin_driver(__platform_driver, platform_driver_register)
         |         ^~~~~~~~~~~~~~
   drivers/clk/tegra/clk-device.c:209:1: note: in expansion of macro 'builtin_platform_driver'
     209 | builtin_platform_driver(tegra_clock_driver);
         | ^~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/container_of.h:5,
                    from include/linux/kernel.h:22:
>> include/linux/build_bug.h:78:41: error: expected declaration specifiers before '_Static_assert'
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                         ^~~~~~~~~~~~~~
   include/linux/build_bug.h:77:34: note: in expansion of macro '__static_assert'
      77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
         |                                  ^~~~~~~~~~~~~~~
   include/linux/init.h:261:9: note: in expansion of macro 'static_assert'
     261 |         static_assert(__same_type(initcall_t, &fn));
         |         ^~~~~~~~~~~~~
   include/linux/init.h:269:9: note: in expansion of macro '____define_initcall'
     269 |         ____define_initcall(fn,                                 \
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/init.h:275:9: note: in expansion of macro '__unique_initcall'
     275 |         __unique_initcall(fn, id, __sec, __initcall_id(fn))
         |         ^~~~~~~~~~~~~~~~~
   include/linux/init.h:277:35: note: in expansion of macro '___define_initcall'
     277 | #define __define_initcall(fn, id) ___define_initcall(fn, id, .initcall##id)
         |                                   ^~~~~~~~~~~~~~~~~~
   include/linux/init.h:306:41: note: in expansion of macro '__define_initcall'
     306 | #define device_initcall(fn)             __define_initcall(fn, 6)
         |                                         ^~~~~~~~~~~~~~~~~
   include/linux/device/driver.h:289:1: note: in expansion of macro 'device_initcall'
     289 | device_initcall(__driver##_init);
         | ^~~~~~~~~~~~~~~
   include/linux/platform_device.h:305:9: note: in expansion of macro 'builtin_driver'
     305 |         builtin_driver(__platform_driver, platform_driver_register)
         |         ^~~~~~~~~~~~~~
   drivers/clk/tegra/clk-device.c:209:1: note: in expansion of macro 'builtin_platform_driver'
     209 | builtin_platform_driver(tegra_clock_driver);
         | ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/device/driver.h:289:33: error: expected declaration specifiers before ';' token
     289 | device_initcall(__driver##_init);
         |                                 ^
   include/linux/platform_device.h:305:9: note: in expansion of macro 'builtin_driver'
     305 |         builtin_driver(__platform_driver, platform_driver_register)
         |         ^~~~~~~~~~~~~~
   drivers/clk/tegra/clk-device.c:209:1: note: in expansion of macro 'builtin_platform_driver'
     209 | builtin_platform_driver(tegra_clock_driver);
         | ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/clk/tegra/clk-device.c:209:44: error: expected declaration specifiers before ';' token
     209 | builtin_platform_driver(tegra_clock_driver);
         |                                            ^
   drivers/clk/tegra/clk-device.c:177:19: error: old-style parameter declarations in prototyped function definition
     177 | static inline int tegra_clock_suspend(struct device *dev)
         |                   ^~~~~~~~~~~~~~~~~~~
   drivers/clk/tegra/clk-device.c:210: error: expected '{' at end of input
   drivers/clk/tegra/clk-device.c:209:44: warning: no return statement in function returning non-void [-Wreturn-type]
     209 | builtin_platform_driver(tegra_clock_driver);
         |                                            ^


vim +/return +178 drivers/clk/tegra/clk-device.c

   169	
   170	/*
   171	 * Tegra GENPD driver enables clocks during NOIRQ phase. It can't be done
   172	 * for clocks served by this driver because runtime PM is unavailable in
   173	 * NOIRQ phase. We will keep clocks resumed during suspend to mitigate this
   174	 * problem. In practice this makes no difference from a power management
   175	 * perspective since voltage is kept at a nominal level during suspend anyways.
   176	 */
 > 177	static inline int tegra_clock_suspend(struct device *dev)
 > 178		return pm_runtime_resume_and_get(dev);
 > 179	}
   180	
   181	static inline int tegra_clock_resume(struct device *dev)
 > 182	{
   183		pm_runtime_put(dev);
   184		return 0;
   185	}
   186	
 > 187	static const struct dev_pm_ops tegra_clock_pm = {
 > 188		SET_SYSTEM_SLEEP_PM_OPS(tegra_clock_suspend, tegra_clock_resume)
   189	};
   190	
 > 191	static const struct of_device_id tegra_clock_match[] = {
 > 192		{ .compatible = "nvidia,tegra20-sclk" },
   193		{ .compatible = "nvidia,tegra30-sclk" },
   194		{ .compatible = "nvidia,tegra30-pllc" },
   195		{ .compatible = "nvidia,tegra30-plle" },
   196		{ .compatible = "nvidia,tegra30-pllm" },
   197		{ }
   198	};
   199	
 > 200	static struct platform_driver tegra_clock_driver = {
   201		.driver = {
   202			.name = "tegra-clock",
   203			.of_match_table = tegra_clock_match,
   204			.pm = &tegra_clock_pm,
   205			.suppress_bind_attrs = true,
   206		},
   207		.probe = tegra_clock_probe,
   208	};
 > 209	builtin_platform_driver(tegra_clock_driver);

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

