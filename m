Return-Path: <linux-acpi+bounces-6249-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B998FF765
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Jun 2024 23:59:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2D761F23F1C
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Jun 2024 21:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2408213AD1D;
	Thu,  6 Jun 2024 21:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C+9s1X2l"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6752313A3F3;
	Thu,  6 Jun 2024 21:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717711177; cv=none; b=KaspIdpvBljy2Of+bFfQEbvyTeqLuqyhj7axD+GjsfVNaxvrinvRgYaOPep/J3z0LywkkAyTY1onZSb7FvAJ2aIBSy5N0E4bApeN7qd/Z++dClmoZWSDPulF719phxlzRF4xlF5TxhikADHNvY+Zx1PfxnPdQQpQCwRGqSrROvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717711177; c=relaxed/simple;
	bh=wvUJH258XBnoPR4hL72RaVBEkAQOyVNRDzLmK0dHgP0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Ms+pXKwg/7dVsx8Sh+2iMF+s54YDKaDidOONtBg93XmHw3hGjOfTIe1d8+zszPFVoWQihssKBvjxr1TGLVbPa5n89XhmVvM2MR/529BmR20DWwZn5tGH1G7ZLYNq8PcHFScir7e10HljgaCWp7nAtsovJ4sxY5QdAOUFwxwdPxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C+9s1X2l; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717711175; x=1749247175;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=wvUJH258XBnoPR4hL72RaVBEkAQOyVNRDzLmK0dHgP0=;
  b=C+9s1X2lemO9w9vrTpQyFtF8PIwfTBuAkLSMex7sQvjGRa6++YUlLyKB
   1KPYVD47MQJz23sblFIVReyluSqZz1Sf1lfmgHkiMaOqMni1yB2W+lwtW
   o1gJI6G3rew6OT8/sWUMearcU0GtZ+xDs+bMFhM+7rwXzdVeD3vL30wXd
   1mibJfU/RrwGf9dl7m8+xVQXA9YxeQXk5bh+6ROgkjCaIko549xHs4Ec1
   j8sLtqdMcB7AgdJTQ2eC0FztYt5C0fZwMHudcYno84l7j0OT9+LRufsru
   1VQsDVtGaQm4HY2E7mg41a74MVhrLe5NHt+OLgHjgL0ej2qVc85+el/NS
   g==;
X-CSE-ConnectionGUID: I0/TiT47SN6UDsDOTx74iA==
X-CSE-MsgGUID: JEiu9H2pQx+vN0auZS9wYQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11095"; a="14367722"
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="14367722"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2024 14:59:34 -0700
X-CSE-ConnectionGUID: Mkwn1ORASxeJQGTAdTs/Zw==
X-CSE-MsgGUID: 9JwsXYUGQDqe+7lwgXcqyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="42545073"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by fmviesa005.fm.intel.com with ESMTP; 06 Jun 2024 14:59:32 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sFL8r-0003mE-2G;
	Thu, 06 Jun 2024 21:59:29 +0000
Date: Fri, 7 Jun 2024 05:58:57 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-acpi@vger.kernel.org, devel@acpica.org,
	linux-pm@vger.kernel.org
Subject: [rafael-pm:thermal-core-testing 15/19]
 drivers/thermal/thermal_trip.c:80: warning: expecting prototype for
 __thermal_zone_set_trips(). Prototype was for thermal_zone_set_trips()
 instead
Message-ID: <202406070545.l4cZkyKT-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-core-testing
head:   6e0a68e98f310000edb1e4aa178257d4bc3509f8
commit: 60f7b1c6e1b5722b8ac2958ec6c57c5cec9ef9c7 [15/19] thermal: trip: Rename __thermal_zone_set_trips() to thermal_zone_set_trips()
config: riscv-defconfig (https://download.01.org/0day-ci/archive/20240607/202406070545.l4cZkyKT-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project d7d2d4f53fc79b4b58e8d8d08151b577c3699d4a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240607/202406070545.l4cZkyKT-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406070545.l4cZkyKT-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/thermal/thermal_trip.c:80: warning: expecting prototype for __thermal_zone_set_trips(). Prototype was for thermal_zone_set_trips() instead


vim +80 drivers/thermal/thermal_trip.c

5b8de18ee9027c Daniel Lezcano    2023-01-23   63  
5b8de18ee9027c Daniel Lezcano    2023-01-23   64  /**
5b8de18ee9027c Daniel Lezcano    2023-01-23   65   * __thermal_zone_set_trips - Computes the next trip points for the driver
5b8de18ee9027c Daniel Lezcano    2023-01-23   66   * @tz: a pointer to a thermal zone device structure
5b8de18ee9027c Daniel Lezcano    2023-01-23   67   *
5b8de18ee9027c Daniel Lezcano    2023-01-23   68   * The function computes the next temperature boundaries by browsing
5b8de18ee9027c Daniel Lezcano    2023-01-23   69   * the trip points. The result is the closer low and high trip points
5b8de18ee9027c Daniel Lezcano    2023-01-23   70   * to the current temperature. These values are passed to the backend
5b8de18ee9027c Daniel Lezcano    2023-01-23   71   * driver to let it set its own notification mechanism (usually an
5b8de18ee9027c Daniel Lezcano    2023-01-23   72   * interrupt).
5b8de18ee9027c Daniel Lezcano    2023-01-23   73   *
5b8de18ee9027c Daniel Lezcano    2023-01-23   74   * This function must be called with tz->lock held. Both tz and tz->ops
5b8de18ee9027c Daniel Lezcano    2023-01-23   75   * must be valid pointers.
5b8de18ee9027c Daniel Lezcano    2023-01-23   76   *
5b8de18ee9027c Daniel Lezcano    2023-01-23   77   * It does not return a value
5b8de18ee9027c Daniel Lezcano    2023-01-23   78   */
60f7b1c6e1b572 Rafael J. Wysocki 2024-05-28   79  void thermal_zone_set_trips(struct thermal_zone_device *tz)
5b8de18ee9027c Daniel Lezcano    2023-01-23  @80  {
daeeb032f42d06 Rafael J. Wysocki 2024-04-02   81  	const struct thermal_trip_desc *td;
5b8de18ee9027c Daniel Lezcano    2023-01-23   82  	int low = -INT_MAX, high = INT_MAX;
0c0c4740c9d266 Rafael J. Wysocki 2023-12-04   83  	int ret;
5b8de18ee9027c Daniel Lezcano    2023-01-23   84  
5b8de18ee9027c Daniel Lezcano    2023-01-23   85  	lockdep_assert_held(&tz->lock);
5b8de18ee9027c Daniel Lezcano    2023-01-23   86  
698a1eb1f75eb6 Rafael J. Wysocki 2024-02-22   87  	if (!tz->ops.set_trips)
5b8de18ee9027c Daniel Lezcano    2023-01-23   88  		return;
5b8de18ee9027c Daniel Lezcano    2023-01-23   89  
daeeb032f42d06 Rafael J. Wysocki 2024-04-02   90  	for_each_trip_desc(tz, td) {
daeeb032f42d06 Rafael J. Wysocki 2024-04-02   91  		const struct thermal_trip *trip = &td->trip;
5b8de18ee9027c Daniel Lezcano    2023-01-23   92  		int trip_low;
5b8de18ee9027c Daniel Lezcano    2023-01-23   93  
0c0c4740c9d266 Rafael J. Wysocki 2023-12-04   94  		trip_low = trip->temperature - trip->hysteresis;
5b8de18ee9027c Daniel Lezcano    2023-01-23   95  
f67cf45deedb11 Daniel Lezcano    2024-03-25   96  		if (trip_low < tz->temperature && trip_low > low)
5b8de18ee9027c Daniel Lezcano    2023-01-23   97  			low = trip_low;
5b8de18ee9027c Daniel Lezcano    2023-01-23   98  
0c0c4740c9d266 Rafael J. Wysocki 2023-12-04   99  		if (trip->temperature > tz->temperature &&
f67cf45deedb11 Daniel Lezcano    2024-03-25  100  		    trip->temperature < high)
0c0c4740c9d266 Rafael J. Wysocki 2023-12-04  101  			high = trip->temperature;
5b8de18ee9027c Daniel Lezcano    2023-01-23  102  	}
5b8de18ee9027c Daniel Lezcano    2023-01-23  103  
5b8de18ee9027c Daniel Lezcano    2023-01-23  104  	/* No need to change trip points */
5b8de18ee9027c Daniel Lezcano    2023-01-23  105  	if (tz->prev_low_trip == low && tz->prev_high_trip == high)
5b8de18ee9027c Daniel Lezcano    2023-01-23  106  		return;
5b8de18ee9027c Daniel Lezcano    2023-01-23  107  
5b8de18ee9027c Daniel Lezcano    2023-01-23  108  	tz->prev_low_trip = low;
5b8de18ee9027c Daniel Lezcano    2023-01-23  109  	tz->prev_high_trip = high;
5b8de18ee9027c Daniel Lezcano    2023-01-23  110  
5b8de18ee9027c Daniel Lezcano    2023-01-23  111  	dev_dbg(&tz->device,
5b8de18ee9027c Daniel Lezcano    2023-01-23  112  		"new temperature boundaries: %d < x < %d\n", low, high);
5b8de18ee9027c Daniel Lezcano    2023-01-23  113  
5b8de18ee9027c Daniel Lezcano    2023-01-23  114  	/*
5b8de18ee9027c Daniel Lezcano    2023-01-23  115  	 * Set a temperature window. When this window is left the driver
5b8de18ee9027c Daniel Lezcano    2023-01-23  116  	 * must inform the thermal core via thermal_zone_device_update.
5b8de18ee9027c Daniel Lezcano    2023-01-23  117  	 */
698a1eb1f75eb6 Rafael J. Wysocki 2024-02-22  118  	ret = tz->ops.set_trips(tz, low, high);
5b8de18ee9027c Daniel Lezcano    2023-01-23  119  	if (ret)
5b8de18ee9027c Daniel Lezcano    2023-01-23  120  		dev_err(&tz->device, "Failed to set trips: %d\n", ret);
5b8de18ee9027c Daniel Lezcano    2023-01-23  121  }
5b8de18ee9027c Daniel Lezcano    2023-01-23  122  

:::::: The code at line 80 was first introduced by commit
:::::: 5b8de18ee9027c647db4c1905f7fd0550d17d67a thermal/core: Move the thermal trip code to a dedicated file

:::::: TO: Daniel Lezcano <daniel.lezcano@linaro.org>
:::::: CC: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

