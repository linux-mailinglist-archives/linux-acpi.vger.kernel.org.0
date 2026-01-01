Return-Path: <linux-acpi+bounces-19922-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 81320CED5AB
	for <lists+linux-acpi@lfdr.de>; Thu, 01 Jan 2026 22:11:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 507C73005B96
	for <lists+linux-acpi@lfdr.de>; Thu,  1 Jan 2026 21:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2719B2F3C1F;
	Thu,  1 Jan 2026 21:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RwWHf2JD"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C962F12A3;
	Thu,  1 Jan 2026 21:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767301913; cv=none; b=pdghpOrVwrDfl6b2ix/ZM+6XC8LFCRQLBEeKMOB4uVeeIKhApsx0ciHqMOZzDbmNkkE1naRM/eVACbA7KLESI1iDfw/kddSatbkzQO7VtFTy4a1xtbQwl246xZGDhOeSSJ1OJG3gu6v1zaJtisIfVvYewHtu70oeQnxq/i3T6zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767301913; c=relaxed/simple;
	bh=vc/wJto/dWtIjOq6E33FXCGNnvt87+XlrE2Qx6uHMPY=;
	h=Date:From:To:Cc:Subject:Message-ID; b=CGAHUMdyZvKZZJhrCGreZuXcxNGgipIJvibvRtx7VbAl5FcQhJTaGnBwgqAj8oEY8xOq2NjBhhvxEzN8ocId4axykYZjSu7ySJn7mRPUfYjVAHyh2qL5NU3B5TnoI/uYOEAHBKUi/rKQj4WrYEiDgavDS2iNUUZ+LvwNllBY/S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RwWHf2JD; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767301910; x=1798837910;
  h=date:from:to:cc:subject:message-id;
  bh=vc/wJto/dWtIjOq6E33FXCGNnvt87+XlrE2Qx6uHMPY=;
  b=RwWHf2JDnqY8NoTIg+M3SHjCWlPDHvIcTXWN9MyImcJ17YWe6mimKkUN
   GBEwI8dGMe4KEND3+r2pMl3D+TPfA9ujkf3ebjR2GUc2UBuUgy52zlxSj
   jx2L+Ewlar8Dp1I1aaSGwWIYCTMGAtTEnt/HApmt/18+EL0g7HIJf085t
   OmixQFVmgpY6M98WAjiMOrRsHShz+jDQiyEmifKduJY/3TlK1S9/a3I3+
   3sKCjsT17QOjaHxiBDTMO6YRLos3HvfMuCO89Fdb5EgpmIg/q43UjQWwp
   s6bnZbYJ0YNGU8ngxqF8F/GPsQ+LdCcWuS299LC8PPWTNLj2Dpnuk/KYD
   Q==;
X-CSE-ConnectionGUID: +3dH5pqgTvyvCl/tq+G/Dw==
X-CSE-MsgGUID: Rkjd10okQICdeIP42XsU5g==
X-IronPort-AV: E=McAfee;i="6800,10657,11658"; a="79940518"
X-IronPort-AV: E=Sophos;i="6.21,195,1763452800"; 
   d="scan'208";a="79940518"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jan 2026 13:11:50 -0800
X-CSE-ConnectionGUID: wibfCvyrRZ69m2sng2+cZA==
X-CSE-MsgGUID: Lf7P8fhMRrO5pGfVhr2m3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,195,1763452800"; 
   d="scan'208";a="201945671"
Received: from lkp-server01.sh.intel.com (HELO c9aa31daaa89) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 01 Jan 2026 13:11:48 -0800
Received: from kbuild by c9aa31daaa89 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vbPxR-0000000022D-3xeP;
	Thu, 01 Jan 2026 21:11:45 +0000
Date: Fri, 02 Jan 2026 05:10:59 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: oe-kbuild-all@lists.linux.dev, linux-acpi@vger.kernel.org,
 linux-pm@vger.kernel.org
Subject: [rafael-pm:pm-runtime-cleanup 24/25]
 drivers/clk/tegra/clk-device.c:192:9: warning: braces around scalar
 initializer
Message-ID: <202601020555.YQwJ94nC-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-runtime-cleanup
head:   e853e6ed1e01eb6846357d4692bf6131e218837e
commit: a7e9532f30c77611ad48560b165326ce96e6e8dc [24/25] clk: tegra: Discard pm_runtime_put() return value
config: arm64-defconfig (https://download.01.org/0day-ci/archive/20260102/202601020555.YQwJ94nC-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260102/202601020555.YQwJ94nC-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601020555.YQwJ94nC-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/clk/tegra/clk-device.c: In function 'tegra_clock_suspend':
   drivers/clk/tegra/clk-device.c:178:9: error: expected declaration specifiers before 'return'
     178 |         return pm_runtime_resume_and_get(dev);
         |         ^~~~~~
   drivers/clk/tegra/clk-device.c:179:1: error: expected declaration specifiers before '}' token
     179 | }
         | ^
   drivers/clk/tegra/clk-device.c:182:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     182 | {
         | ^
   drivers/clk/tegra/clk-device.c:187:32: error: storage class specified for parameter 'tegra_clock_pm'
     187 | static const struct dev_pm_ops tegra_clock_pm = {
         |                                ^~~~~~~~~~~~~~
   drivers/clk/tegra/clk-device.c:187:21: error: parameter 'tegra_clock_pm' is initialized
     187 | static const struct dev_pm_ops tegra_clock_pm = {
         |                     ^~~~~~~~~~
   In file included from include/linux/kernel.h:36,
                    from include/linux/clk.h:13,
                    from drivers/clk/tegra/clk-device.c:3:
   drivers/clk/tegra/clk-device.c:188:54: error: 'tegra_clock_resume' undeclared (first use in this function); did you mean 'tegra_clk_osc_resume'?
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
   drivers/clk/tegra/clk-device.c:191:34: error: storage class specified for parameter 'tegra_clock_match'
     191 | static const struct of_device_id tegra_clock_match[] = {
         |                                  ^~~~~~~~~~~~~~~~~
   drivers/clk/tegra/clk-device.c:191:21: error: parameter 'tegra_clock_match' is initialized
     191 | static const struct of_device_id tegra_clock_match[] = {
         |                     ^~~~~~~~~~~~
   drivers/clk/tegra/clk-device.c:191:56: error: variable-sized object may not be initialized except with an empty initializer
     191 | static const struct of_device_id tegra_clock_match[] = {
         |                                                        ^
>> drivers/clk/tegra/clk-device.c:192:9: warning: braces around scalar initializer
     192 |         { .compatible = "nvidia,tegra20-sclk" },
         |         ^
   drivers/clk/tegra/clk-device.c:192:9: note: (near initialization for 'tegra_clock_match')
   drivers/clk/tegra/clk-device.c:192:11: error: field name not in record or union initializer
     192 |         { .compatible = "nvidia,tegra20-sclk" },
         |           ^
   drivers/clk/tegra/clk-device.c:192:11: note: (near initialization for 'tegra_clock_match')
   drivers/clk/tegra/clk-device.c:192:25: error: initialization of 'const struct of_device_id *' from incompatible pointer type 'char *' [-Wincompatible-pointer-types]
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
>> drivers/clk/tegra/clk-device.c:193:9: warning: excess elements in scalar initializer
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
   drivers/clk/tegra/clk-device.c:200:31: error: storage class specified for parameter 'tegra_clock_driver'
     200 | static struct platform_driver tegra_clock_driver = {
         |                               ^~~~~~~~~~~~~~~~~~
   drivers/clk/tegra/clk-device.c:200:15: error: parameter 'tegra_clock_driver' is initialized
     200 | static struct platform_driver tegra_clock_driver = {
         |               ^~~~~~~~~~~~~~~
   In file included from include/linux/device.h:32,
                    from include/linux/platform_device.h:13,
                    from drivers/clk/tegra/clk-device.c:7:
   include/linux/device/driver.h:286:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     286 | { \
         | ^
   include/linux/platform_device.h:305:9: note: in expansion of macro 'builtin_driver'
     305 |         builtin_driver(__platform_driver, platform_driver_register)
         |         ^~~~~~~~~~~~~~
   drivers/clk/tegra/clk-device.c:209:1: note: in expansion of macro 'builtin_platform_driver'
     209 | builtin_platform_driver(tegra_clock_driver);
         | ^~~~~~~~~~~~~~~~~~~~~~~
   In file included from <command-line>:
   include/linux/compiler.h:168:17: error: storage class specified for parameter '__UNIQUE_ID_addressable_tegra_clock_driver_init_431'
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
   include/linux/device/driver.h:286:1: error: parameter '__UNIQUE_ID_addressable_tegra_clock_driver_init_431' is initialized
     286 | { \
         | ^
   include/linux/platform_device.h:305:9: note: in expansion of macro 'builtin_driver'
     305 |         builtin_driver(__platform_driver, platform_driver_register)
         |         ^~~~~~~~~~~~~~
   drivers/clk/tegra/clk-device.c:209:1: note: in expansion of macro 'builtin_platform_driver'
     209 | builtin_platform_driver(tegra_clock_driver);
         | ^~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/device/driver.h:286:1: warning: 'used' attribute ignored [-Wattributes]
     286 | { \
         | ^
   include/linux/platform_device.h:305:9: note: in expansion of macro 'builtin_driver'
     305 |         builtin_driver(__platform_driver, platform_driver_register)
         |         ^~~~~~~~~~~~~~
   drivers/clk/tegra/clk-device.c:209:1: note: in expansion of macro 'builtin_platform_driver'
     209 | builtin_platform_driver(tegra_clock_driver);
         | ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:168:17: error: section attribute not allowed for '__UNIQUE_ID_addressable_tegra_clock_driver_init_431'
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
   drivers/clk/tegra/clk-device.c:209:25: error: 'tegra_clock_driver_init' undeclared (first use in this function); did you mean 'tegra_clock_driver'?
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
   include/linux/init.h:257:9: error: expected declaration specifiers before 'asm'
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
   include/linux/build_bug.h:78:41: error: expected declaration specifiers before '_Static_assert'
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
>> drivers/clk/tegra/clk-device.c:209:44: warning: no return statement in function returning non-void [-Wreturn-type]
     209 | builtin_platform_driver(tegra_clock_driver);
         |                                            ^


vim +192 drivers/clk/tegra/clk-device.c

b1bc04a2ac5b15 Dmitry Osipenko 2021-12-01  190  
b1bc04a2ac5b15 Dmitry Osipenko 2021-12-01  191  static const struct of_device_id tegra_clock_match[] = {
b1bc04a2ac5b15 Dmitry Osipenko 2021-12-01 @192  	{ .compatible = "nvidia,tegra20-sclk" },
b1bc04a2ac5b15 Dmitry Osipenko 2021-12-01 @193  	{ .compatible = "nvidia,tegra30-sclk" },
b1bc04a2ac5b15 Dmitry Osipenko 2021-12-01  194  	{ .compatible = "nvidia,tegra30-pllc" },
b1bc04a2ac5b15 Dmitry Osipenko 2021-12-01  195  	{ .compatible = "nvidia,tegra30-plle" },
b1bc04a2ac5b15 Dmitry Osipenko 2021-12-01  196  	{ .compatible = "nvidia,tegra30-pllm" },
b1bc04a2ac5b15 Dmitry Osipenko 2021-12-01  197  	{ }
b1bc04a2ac5b15 Dmitry Osipenko 2021-12-01  198  };
b1bc04a2ac5b15 Dmitry Osipenko 2021-12-01  199  
b1bc04a2ac5b15 Dmitry Osipenko 2021-12-01  200  static struct platform_driver tegra_clock_driver = {
b1bc04a2ac5b15 Dmitry Osipenko 2021-12-01  201  	.driver = {
b1bc04a2ac5b15 Dmitry Osipenko 2021-12-01  202  		.name = "tegra-clock",
b1bc04a2ac5b15 Dmitry Osipenko 2021-12-01  203  		.of_match_table = tegra_clock_match,
b1bc04a2ac5b15 Dmitry Osipenko 2021-12-01  204  		.pm = &tegra_clock_pm,
b1bc04a2ac5b15 Dmitry Osipenko 2021-12-01  205  		.suppress_bind_attrs = true,
b1bc04a2ac5b15 Dmitry Osipenko 2021-12-01  206  	},
b1bc04a2ac5b15 Dmitry Osipenko 2021-12-01  207  	.probe = tegra_clock_probe,
b1bc04a2ac5b15 Dmitry Osipenko 2021-12-01  208  };
b1bc04a2ac5b15 Dmitry Osipenko 2021-12-01 @209  builtin_platform_driver(tegra_clock_driver);

:::::: The code at line 192 was first introduced by commit
:::::: b1bc04a2ac5b15e0b681228376664671fc2f2017 clk: tegra: Support runtime PM and power domain

:::::: TO: Dmitry Osipenko <digetx@gmail.com>
:::::: CC: Thierry Reding <treding@nvidia.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

