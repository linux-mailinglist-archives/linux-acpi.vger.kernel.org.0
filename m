Return-Path: <linux-acpi+bounces-21467-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SPikFf0oqmmQMQEAu9opvQ
	(envelope-from <linux-acpi+bounces-21467-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Fri, 06 Mar 2026 02:08:13 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0681621A21B
	for <lists+linux-acpi@lfdr.de>; Fri, 06 Mar 2026 02:08:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 72DF8301FFB8
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Mar 2026 01:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E28972FD1A1;
	Fri,  6 Mar 2026 01:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XWUrdSQi"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BCA82F12D4;
	Fri,  6 Mar 2026 01:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772759201; cv=none; b=aMygMXvZQnesNc/EoxIFe1+1KtMlPJmzi/QfudwRpt8b4rWUXLDGy1Hbz+tBw/BsJvLKwBLa63Nq/tM2CWRaVje/EvRZWEHVtOYIKHp4zZIOvSR1sjMXIkk+GhEGC8yBlHeCa1uSr/q25nz5heAoXruf2HfMmAzXQ7r++TSUaVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772759201; c=relaxed/simple;
	bh=/3UzXOX7nYsk0ycjPDcHwDC51rQGido5I13QEdeIfH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dc/R/XyZs0RgpTuTty2KXC14aVgn3rdg5fI0hiLv0pbN0BXmSad0G1ggF45mfht1/WromIVv1ueCwj5c3X6kRq0LxjVtMOIMGKQkCvaIlqnp0chkSBYHUwW7VLFGbN5vPvocdX+hqhemZim15axfQUdjFVdAoFZEDKzama/J2X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XWUrdSQi; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772759201; x=1804295201;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/3UzXOX7nYsk0ycjPDcHwDC51rQGido5I13QEdeIfH8=;
  b=XWUrdSQiVf11AJe0g1236y/1ZSCpdG+E5pbZucqeUg56FPbrEvRcBvGX
   Vges25oan8P8p4la9iHY3wlrzTZX/uJzH/nKrVl/+I7oqNm5HhdbuPVee
   U4XYy8ptpdrV0by9ztjYpA7HXU+DISs6bjKRWJd9dL6Q09VUUCpeDTpnQ
   bbGAVNJ/HveRpJx9hp/TB8xnajH+wB6pujGIPJ5bdwyEOK5YH4yBSrwct
   VHiMmYOrl4Rc2Tvzmc0hxQ9bR+9917V4mQBvgXiR33B2WvtRAv96Kgsh1
   araXI4w0JVEEeBpnxfopYMPabqtRE3d/3V06ITEQ9F3q5YePQ51yTaQBS
   Q==;
X-CSE-ConnectionGUID: ftmJPMyZQzqmYY/8rYLIhw==
X-CSE-MsgGUID: B6/Qz+/ITZCB+TAaJYYNZw==
X-IronPort-AV: E=McAfee;i="6800,10657,11720"; a="73779493"
X-IronPort-AV: E=Sophos;i="6.23,104,1770624000"; 
   d="scan'208";a="73779493"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2026 17:06:40 -0800
X-CSE-ConnectionGUID: Fb6imYfYRdyyNHiSGLSlLg==
X-CSE-MsgGUID: fmZ26AOZSoCSufqFWdsyZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,104,1770624000"; 
   d="scan'208";a="218805096"
Received: from lkp-server01.sh.intel.com (HELO 058beb05654c) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 05 Mar 2026 17:06:34 -0800
Received: from kbuild by 058beb05654c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vyJe9-0000000009N-2EjF;
	Fri, 06 Mar 2026 01:06:29 +0000
Date: Fri, 6 Mar 2026 09:06:24 +0800
From: kernel test robot <lkp@intel.com>
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Frank Rowand <frowand.list@gmail.com>,
	Mika Westerberg <westeri@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Janusz Krzysztofik <jmkrzyszt@gmail.com>,
	Tony Lindgren <tony@atomide.com>,
	Russell King <linux@armlinux.org.uk>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-omap@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH 2/6] gpio: move hogs into GPIO core
Message-ID: <202603060850.dUlmPBav-lkp@intel.com>
References: <20260305-gpio-hog-fwnode-v1-2-97d7df6bbd17@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260305-gpio-hog-fwnode-v1-2-97d7df6bbd17@oss.qualcomm.com>
X-Rspamd-Queue-Id: 0681621A21B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21467-lists,linux-acpi=lfdr.de];
	FREEMAIL_TO(0.00)[oss.qualcomm.com,kernel.org,glider.be,gmail.com,linux.intel.com,iki.fi,atomide.com,armlinux.org.uk,lwn.net,linuxfoundation.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-acpi@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-0.995];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-acpi,renesas];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[01.org:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:dkim,intel.com:email,intel.com:mid]
X-Rspamd-Action: no action

Hi Bartosz,

kernel test robot noticed the following build warnings:

[auto build test WARNING on c025f6cf4209e1542ec2afebe49f42bbaf1a5c7b]

url:    https://github.com/intel-lab-lkp/linux/commits/Bartosz-Golaszewski/gpio-of-clear-OF_POPULATED-on-hog-nodes-in-remove-path/20260305-175735
base:   c025f6cf4209e1542ec2afebe49f42bbaf1a5c7b
patch link:    https://lore.kernel.org/r/20260305-gpio-hog-fwnode-v1-2-97d7df6bbd17%40oss.qualcomm.com
patch subject: [PATCH 2/6] gpio: move hogs into GPIO core
config: loongarch-allnoconfig (https://download.01.org/0day-ci/archive/20260306/202603060850.dUlmPBav-lkp@intel.com/config)
compiler: clang version 23.0.0git (https://github.com/llvm/llvm-project c32caeec8158d634bb71ab8911a6031248b9fc47)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260306/202603060850.dUlmPBav-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603060850.dUlmPBav-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/gpio/gpiolib.c:981:10: warning: variable 'ret' is uninitialized when used here [-Wuninitialized]
     981 |                 return ret;
         |                        ^~~
   drivers/gpio/gpiolib.c:971:9: note: initialize the variable 'ret' to silence this warning
     971 |         int ret, argc;
         |                ^
         |                 = 0
   1 warning generated.


vim +/ret +981 drivers/gpio/gpiolib.c

   962	
   963	int gpiochip_add_hog(struct gpio_chip *gc, struct fwnode_handle *fwnode)
   964	{
   965		struct fwnode_handle *gc_node = dev_fwnode(&gc->gpiodev->dev);
   966		struct of_phandle_args gpiospec;
   967		enum gpiod_flags dflags;
   968		struct gpio_desc *desc;
   969		unsigned long lflags;
   970		const char *name;
   971		int ret, argc;
   972		u32 gpios[3]; /* We support up to three-cell bindings. */
   973		u32 cells;
   974	
   975		lflags = GPIO_LOOKUP_FLAGS_DEFAULT;
   976		dflags = GPIOD_ASIS;
   977		name = NULL;
   978	
   979		argc = fwnode_property_count_u32(fwnode, "gpios");
   980		if (argc < 0)
 > 981			return ret;
   982		if (argc > 3)
   983			return -EINVAL;
   984	
   985		ret = fwnode_property_read_u32_array(fwnode, "gpios", gpios, argc);
   986		if (ret < 0)
   987			return ret;
   988	
   989		if (is_of_node(fwnode)) {
   990			/*
   991			 * OF-nodes need some additional special handling for
   992			 * translating of devicetree flags.
   993			 */
   994			ret = fwnode_property_read_u32(gc_node, "#gpio-cells", &cells);
   995			if (ret)
   996				return ret;
   997			if (cells && argc != cells)
   998				return -EINVAL;
   999	
  1000			memset(&gpiospec, 0, sizeof(gpiospec));
  1001			gpiospec.np = to_of_node(fwnode);
  1002			gpiospec.args_count = argc;
  1003			memcpy(&gpiospec.args, gpios, argc * sizeof(u32));
  1004	
  1005			ret = of_gpiochip_get_lflags(gc, &gpiospec, &lflags);
  1006			if (ret)
  1007				return ret;
  1008		} else {
  1009			/*
  1010			 * GPIO_ACTIVE_LOW is currently the only lookup flag
  1011			 * supported for non-OF firmware nodes.
  1012			 */
  1013			if (gpios[1])
  1014				lflags |= GPIO_ACTIVE_LOW;
  1015		}
  1016	
  1017		if (fwnode_property_present(fwnode, "input"))
  1018			dflags |= GPIOD_IN;
  1019		else if (fwnode_property_present(fwnode, "output-low"))
  1020			dflags |= GPIOD_OUT_LOW;
  1021		else if (fwnode_property_present(fwnode, "output-high"))
  1022			dflags |= GPIOD_OUT_HIGH;
  1023		else
  1024			return -EINVAL;
  1025	
  1026		fwnode_property_read_string(fwnode, "line-name", &name);
  1027	
  1028		desc = gpiochip_get_desc(gc, gpios[0]);
  1029		if (IS_ERR(desc))
  1030			return PTR_ERR(desc);
  1031	
  1032		ret = gpiod_hog(desc, name, lflags, dflags);
  1033		if (ret)
  1034			return ret;
  1035	
  1036		return 0;
  1037	}
  1038	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

