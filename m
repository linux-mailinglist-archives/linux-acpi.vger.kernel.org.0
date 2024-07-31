Return-Path: <linux-acpi+bounces-7173-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5F72943813
	for <lists+linux-acpi@lfdr.de>; Wed, 31 Jul 2024 23:35:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C1E51F21E22
	for <lists+linux-acpi@lfdr.de>; Wed, 31 Jul 2024 21:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B1EF16C861;
	Wed, 31 Jul 2024 21:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FrpUch9u"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D62B1BC4E;
	Wed, 31 Jul 2024 21:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722461705; cv=none; b=Pc1G/FHzc+joNrLVsm6DZWLLyVb7mlegAdwGO+Hjpp++LgYSFmR/iLyc4ustftBMPNd4+XvB3k6iL2C3PkAryHzcZvSapJrBDXDjgyETW0TA43I9IDejQ4lIgKy1eDG/Swrt++TnmSkNHe9H/8c0CEWuWUDNwTyKVWEAw7/fDCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722461705; c=relaxed/simple;
	bh=GPBpyX6Iwj5T9fSMwzuKrXlmvryk8yZ5plubimLDpUo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=K8ssuJko8pQ/EMKMN7EgV7HRSGbKUbQ6GbhqSRPN0UiUAdARYRW8aDmBKgwPoamJgwIqbYqXoqbemNXzBhj2u+Q5RPFoCaFoAVgZOkTJRcRt192G/yqvifcLfEsMgyATLb7tg12tRDmgXgSLYHgDv98DvVtqS4TyshmLAqm1xfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FrpUch9u; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722461704; x=1753997704;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=GPBpyX6Iwj5T9fSMwzuKrXlmvryk8yZ5plubimLDpUo=;
  b=FrpUch9u9/wsCEfYyoYvdhWYGTfij6xRLdvDuLEl7N4v5BWmKNwMFmI2
   yVKzPgipCV/YEWEPcOVt7C2rmPSrS9W0HmpPipKgxqHXLS5wcH9mSsLk6
   WR4nVrfrSh38Y+kl5y2TFNq9y9wwLhnmCP5+t8QfBnDxAqjaSBKbF7JnV
   IhtJouDN+YwQNYbKArcdZt01IxCZje6yhOD0VJiH5pGHoe+ZlSM1pe8Ra
   3UIaFC+Ya3dM3yTzU7zWUNkHYDJSiEwI+++4cLl5JiCXKsl9j7lYQpPZL
   SzWO943e3cTGDWqLbv97D/iuMI3cE4PnzP9YYqCiYCCOt2OoNa7TZ/34L
   A==;
X-CSE-ConnectionGUID: Jfdx6en6TSq0ZxV/Ng3ONQ==
X-CSE-MsgGUID: fyWCbMi4T7uAXCwYlKEcsg==
X-IronPort-AV: E=McAfee;i="6700,10204,11150"; a="31032892"
X-IronPort-AV: E=Sophos;i="6.09,251,1716274800"; 
   d="scan'208";a="31032892"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2024 14:35:03 -0700
X-CSE-ConnectionGUID: 22waPod2RNmuFnVBhEXmqA==
X-CSE-MsgGUID: tRMwOEsjTYOVNjt8Nx9YLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,251,1716274800"; 
   d="scan'208";a="59864183"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 31 Jul 2024 14:35:02 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sZGyI-000uq5-37;
	Wed, 31 Jul 2024 21:34:58 +0000
Date: Thu, 1 Aug 2024 05:34:02 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: oe-kbuild-all@lists.linux.dev, linux-acpi@vger.kernel.org,
	devel@acpica.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:thermal-core-testing 5/28]
 drivers/thermal/tegra/tegra30-tsensor.c:326:22: warning: unused variable 'i'
Message-ID: <202408010519.LbMLx3ZP-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-core-testing
head:   7fd1b071fe42b890c55ac5e735fb39d3d46c1e4d
commit: 52f97fa22ebcf77f8a19cb39932c3069f90c428d [5/28] thermal: tegra: Use thermal_zone_for_each_trip() for walking trip points
config: xtensa-allyesconfig (https://download.01.org/0day-ci/archive/20240801/202408010519.LbMLx3ZP-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240801/202408010519.LbMLx3ZP-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408010519.LbMLx3ZP-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/thermal/tegra/tegra30-tsensor.c: In function 'tegra_tsensor_get_hw_channel_trips':
>> drivers/thermal/tegra/tegra30-tsensor.c:326:22: warning: unused variable 'i' [-Wunused-variable]
     326 |         unsigned int i;
         |                      ^


vim +/i +326 drivers/thermal/tegra/tegra30-tsensor.c

52f97fa22ebcf7 Rafael J. Wysocki 2024-07-29  322  
3747e4263ff6d6 Dmitry Osipenko   2021-06-16  323  static void tegra_tsensor_get_hw_channel_trips(struct thermal_zone_device *tzd,
e45ebb38c6b589 Rafael J. Wysocki 2024-07-29  324  					       struct trip_temps *temps)
3747e4263ff6d6 Dmitry Osipenko   2021-06-16  325  {
3747e4263ff6d6 Dmitry Osipenko   2021-06-16 @326  	unsigned int i;
3747e4263ff6d6 Dmitry Osipenko   2021-06-16  327  
3747e4263ff6d6 Dmitry Osipenko   2021-06-16  328  	/*
3747e4263ff6d6 Dmitry Osipenko   2021-06-16  329  	 * 90C is the maximal critical temperature of all Tegra30 SoC variants,
3747e4263ff6d6 Dmitry Osipenko   2021-06-16  330  	 * use it for the default trip if unspecified in a device-tree.
3747e4263ff6d6 Dmitry Osipenko   2021-06-16  331  	 */
e45ebb38c6b589 Rafael J. Wysocki 2024-07-29  332  	temps->hot_trip  = 85000;
e45ebb38c6b589 Rafael J. Wysocki 2024-07-29  333  	temps->crit_trip = 90000;
3747e4263ff6d6 Dmitry Osipenko   2021-06-16  334  
52f97fa22ebcf7 Rafael J. Wysocki 2024-07-29  335  	thermal_zone_for_each_trip(tzd, tegra_tsensor_get_trips_cb, temps);
3747e4263ff6d6 Dmitry Osipenko   2021-06-16  336  
3747e4263ff6d6 Dmitry Osipenko   2021-06-16  337  	/* clamp hardware trips to the calibration limits */
e45ebb38c6b589 Rafael J. Wysocki 2024-07-29  338  	temps->hot_trip = clamp(temps->hot_trip, 25000, 90000);
3747e4263ff6d6 Dmitry Osipenko   2021-06-16  339  
3747e4263ff6d6 Dmitry Osipenko   2021-06-16  340  	/*
3747e4263ff6d6 Dmitry Osipenko   2021-06-16  341  	 * Kernel will perform a normal system shut down if it will
3747e4263ff6d6 Dmitry Osipenko   2021-06-16  342  	 * see that critical temperature is breached, hence set the
3747e4263ff6d6 Dmitry Osipenko   2021-06-16  343  	 * hardware limit by 5C higher in order to allow system to
3747e4263ff6d6 Dmitry Osipenko   2021-06-16  344  	 * shut down gracefully before sending signal to the Power
3747e4263ff6d6 Dmitry Osipenko   2021-06-16  345  	 * Management controller.
3747e4263ff6d6 Dmitry Osipenko   2021-06-16  346  	 */
e45ebb38c6b589 Rafael J. Wysocki 2024-07-29  347  	temps->crit_trip = clamp(temps->crit_trip + 5000, 25000, 90000);
3747e4263ff6d6 Dmitry Osipenko   2021-06-16  348  }
3747e4263ff6d6 Dmitry Osipenko   2021-06-16  349  

:::::: The code at line 326 was first introduced by commit
:::::: 3747e4263ff6d6085507a32946f8236c62dd2495 thermal/drivers/tegra: Add driver for Tegra30 thermal sensor

:::::: TO: Dmitry Osipenko <digetx@gmail.com>
:::::: CC: Daniel Lezcano <daniel.lezcano@linaro.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

