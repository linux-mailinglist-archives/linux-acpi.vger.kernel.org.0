Return-Path: <linux-acpi+bounces-17369-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3067EBA58ED
	for <lists+linux-acpi@lfdr.de>; Sat, 27 Sep 2025 06:38:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2BC6623410
	for <lists+linux-acpi@lfdr.de>; Sat, 27 Sep 2025 04:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3136221DAC;
	Sat, 27 Sep 2025 04:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vq486mDy"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E54717A310;
	Sat, 27 Sep 2025 04:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758947904; cv=none; b=B9PJun8yW+DdW4TANyR/7ZAHgeEXGM+pDcEIN8XiGD1JKFEj2esauc2axw7NrOkOeCzq4ZCLdqT7IKHQqVcW3RVNrz0vfm89H8OXsLEpmZF19ddxdK+PAxJJKkBtc7D2c7apR9Us12zHp7S5ZxV7jO9YiNi5q+hwxdTKO8CG38Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758947904; c=relaxed/simple;
	bh=Ml6qdQ+jE48I66+8v4t80wL43dmskcbpk6RZ6I2w/es=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L0AjTUJVPf0cMPVUUpzoaXPKfciD5R2yHW4VkrPGF+dArGUugyXbjr/LEIXXnvKJcQTZCOxjItxWnYkjiSntS9cC38Xk00O9NItNy/D44m4bgolEmCNRJtO2kOItr+ISGN9UOk7eAdmMiR1Um9+sst5vE8EOZ0JQpMdMgbcq1ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vq486mDy; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758947903; x=1790483903;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Ml6qdQ+jE48I66+8v4t80wL43dmskcbpk6RZ6I2w/es=;
  b=Vq486mDyhEM1jxdEp4zHzu6SoKw4xEXh6NN78qgkDAtzqTafbKLrEh3l
   E6UDNwHe6zraOoOgISiSykJR3fuRRJQ0snSaqF50wKsXlYiMwniSJoD9v
   VRwX4N8sgZTmZ1D4/5ixeSnuEQ/KQHmCjPyev/3UB4NLYRbkAN5pNl0uC
   XnCNbzVebhXk5JgT6Ex10B+XvyiQVLXywVBIPJmE4iem961Phzmh67eGZ
   IPgCp8DpQIGRnYPoTh1FtnYjpvJ+8uYLFQSkNsFOdAH0TPM7yb1nstePG
   hWXmlL4NBUYytGSPgZwzwyKfEGF/YcLIBJxeRgqCVv5wex0j/WnyZs2mj
   w==;
X-CSE-ConnectionGUID: WjRf+AJKS1m1wuauuf+QyA==
X-CSE-MsgGUID: f3NOcJD8Qaueir3wn+VaEA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="65089979"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="65089979"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2025 21:38:22 -0700
X-CSE-ConnectionGUID: jaVL+GgSSR2fZ9qRa2mWhg==
X-CSE-MsgGUID: 3F0XLbOETBqHwXik2VrKDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,296,1751266800"; 
   d="scan'208";a="181784248"
Received: from lkp-server02.sh.intel.com (HELO 84c55410ccf6) ([10.239.97.151])
  by orviesa003.jf.intel.com with ESMTP; 26 Sep 2025 21:38:14 -0700
Received: from kbuild by 84c55410ccf6 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v2MhI-0006nD-0v;
	Sat, 27 Sep 2025 04:38:12 +0000
Date: Sat, 27 Sep 2025 12:37:14 +0800
From: kernel test robot <lkp@intel.com>
To: Ricardo Ribalda <ribalda@chromium.org>,
	Hans de Goede <hansg@kernel.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>,
	Hans Verkuil <hverkuil@xs4all.nl>
Cc: oe-kbuild-all@lists.linux.dev, linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev,
	Ricardo Ribalda <ribalda@chromium.org>
Subject: Re: [PATCH v3 03/12] media: v4l: fwnode: Support ACPI's _PLD for
 v4l2_fwnode_device_parse
Message-ID: <202509271249.8fIMriJh-lkp@intel.com>
References: <20250926-uvc-orientation-v3-3-6dc2fa5b4220@chromium.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250926-uvc-orientation-v3-3-6dc2fa5b4220@chromium.org>

Hi Ricardo,

kernel test robot noticed the following build errors:

[auto build test ERROR on afb100a5ea7a13d7e6937dcd3b36b19dc6cc9328]

url:    https://github.com/intel-lab-lkp/linux/commits/Ricardo-Ribalda/media-uvcvideo-Always-set-default_value/20250926-211524
base:   afb100a5ea7a13d7e6937dcd3b36b19dc6cc9328
patch link:    https://lore.kernel.org/r/20250926-uvc-orientation-v3-3-6dc2fa5b4220%40chromium.org
patch subject: [PATCH v3 03/12] media: v4l: fwnode: Support ACPI's _PLD for v4l2_fwnode_device_parse
config: arm-randconfig-004-20250927 (https://download.01.org/0day-ci/archive/20250927/202509271249.8fIMriJh-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 10.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250927/202509271249.8fIMriJh-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509271249.8fIMriJh-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/printk.h:623,
                    from include/asm-generic/bug.h:22,
                    from arch/arm/include/asm/bug.h:60,
                    from include/linux/bug.h:5,
                    from include/linux/thread_info.h:13,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/arm/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:79,
                    from include/linux/spinlock.h:56,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:7,
                    from include/linux/slab.h:16,
                    from include/linux/resource_ext.h:11,
                    from include/linux/acpi.h:13,
                    from drivers/media/v4l2-core/v4l2-fwnode.c:17:
   drivers/media/v4l2-core/v4l2-fwnode.c: In function 'v4l2_fwnode_device_parse_acpi':
>> include/linux/acpi.h:1268:26: error: implicit declaration of function '__acpi_handle_debug'; did you mean 'acpi_handle_debug'? [-Werror=implicit-function-declaration]
    1268 |  _dynamic_func_call(fmt, __acpi_handle_debug,   \
         |                          ^~~~~~~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:224:3: note: in definition of macro '__dynamic_func_call_cls'
     224 |   func(&id, ##__VA_ARGS__);   \
         |   ^~~~
   include/linux/dynamic_debug.h:250:2: note: in expansion of macro '_dynamic_func_call_cls'
     250 |  _dynamic_func_call_cls(_DPRINTK_CLASS_DFLT, fmt, func, ##__VA_ARGS__)
         |  ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/acpi.h:1268:2: note: in expansion of macro '_dynamic_func_call'
    1268 |  _dynamic_func_call(fmt, __acpi_handle_debug,   \
         |  ^~~~~~~~~~~~~~~~~~
   drivers/media/v4l2-core/v4l2-fwnode.c:821:3: note: in expansion of macro 'acpi_handle_debug'
     821 |   acpi_handle_debug(ACPI_HANDLE(dev), "cannot obtain _PLD\n");
         |   ^~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +1268 include/linux/acpi.h

45fef5b88d1f2f Bjørn Mork       2014-05-22  1240  
fbfddae696572e Toshi Kani       2012-11-21  1241  /*
fbfddae696572e Toshi Kani       2012-11-21  1242   * acpi_handle_<level>: Print message with ACPI prefix and object path
fbfddae696572e Toshi Kani       2012-11-21  1243   *
fbfddae696572e Toshi Kani       2012-11-21  1244   * These interfaces acquire the global namespace mutex to obtain an object
fbfddae696572e Toshi Kani       2012-11-21  1245   * path.  In interrupt context, it shows the object path as <n/a>.
fbfddae696572e Toshi Kani       2012-11-21  1246   */
fbfddae696572e Toshi Kani       2012-11-21  1247  #define acpi_handle_emerg(handle, fmt, ...)				\
fbfddae696572e Toshi Kani       2012-11-21  1248  	acpi_handle_printk(KERN_EMERG, handle, fmt, ##__VA_ARGS__)
fbfddae696572e Toshi Kani       2012-11-21  1249  #define acpi_handle_alert(handle, fmt, ...)				\
fbfddae696572e Toshi Kani       2012-11-21  1250  	acpi_handle_printk(KERN_ALERT, handle, fmt, ##__VA_ARGS__)
fbfddae696572e Toshi Kani       2012-11-21  1251  #define acpi_handle_crit(handle, fmt, ...)				\
fbfddae696572e Toshi Kani       2012-11-21  1252  	acpi_handle_printk(KERN_CRIT, handle, fmt, ##__VA_ARGS__)
fbfddae696572e Toshi Kani       2012-11-21  1253  #define acpi_handle_err(handle, fmt, ...)				\
fbfddae696572e Toshi Kani       2012-11-21  1254  	acpi_handle_printk(KERN_ERR, handle, fmt, ##__VA_ARGS__)
fbfddae696572e Toshi Kani       2012-11-21  1255  #define acpi_handle_warn(handle, fmt, ...)				\
fbfddae696572e Toshi Kani       2012-11-21  1256  	acpi_handle_printk(KERN_WARNING, handle, fmt, ##__VA_ARGS__)
fbfddae696572e Toshi Kani       2012-11-21  1257  #define acpi_handle_notice(handle, fmt, ...)				\
fbfddae696572e Toshi Kani       2012-11-21  1258  	acpi_handle_printk(KERN_NOTICE, handle, fmt, ##__VA_ARGS__)
fbfddae696572e Toshi Kani       2012-11-21  1259  #define acpi_handle_info(handle, fmt, ...)				\
fbfddae696572e Toshi Kani       2012-11-21  1260  	acpi_handle_printk(KERN_INFO, handle, fmt, ##__VA_ARGS__)
fbfddae696572e Toshi Kani       2012-11-21  1261  
45fef5b88d1f2f Bjørn Mork       2014-05-22  1262  #if defined(DEBUG)
fbfddae696572e Toshi Kani       2012-11-21  1263  #define acpi_handle_debug(handle, fmt, ...)				\
fbfddae696572e Toshi Kani       2012-11-21  1264  	acpi_handle_printk(KERN_DEBUG, handle, fmt, ##__VA_ARGS__)
fbfddae696572e Toshi Kani       2012-11-21  1265  #else
45fef5b88d1f2f Bjørn Mork       2014-05-22  1266  #if defined(CONFIG_DYNAMIC_DEBUG)
45fef5b88d1f2f Bjørn Mork       2014-05-22  1267  #define acpi_handle_debug(handle, fmt, ...)				\
f1ebe04f5ba2f4 Rasmus Villemoes 2019-03-07 @1268  	_dynamic_func_call(fmt, __acpi_handle_debug,			\
f1ebe04f5ba2f4 Rasmus Villemoes 2019-03-07  1269  			   handle, pr_fmt(fmt), ##__VA_ARGS__)
45fef5b88d1f2f Bjørn Mork       2014-05-22  1270  #else
fbfddae696572e Toshi Kani       2012-11-21  1271  #define acpi_handle_debug(handle, fmt, ...)				\
fbfddae696572e Toshi Kani       2012-11-21  1272  ({									\
fbfddae696572e Toshi Kani       2012-11-21  1273  	if (0)								\
fbfddae696572e Toshi Kani       2012-11-21  1274  		acpi_handle_printk(KERN_DEBUG, handle, fmt, ##__VA_ARGS__); \
fbfddae696572e Toshi Kani       2012-11-21  1275  	0;								\
fbfddae696572e Toshi Kani       2012-11-21  1276  })
fbfddae696572e Toshi Kani       2012-11-21  1277  #endif
45fef5b88d1f2f Bjørn Mork       2014-05-22  1278  #endif
fbfddae696572e Toshi Kani       2012-11-21  1279  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

