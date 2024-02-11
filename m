Return-Path: <linux-acpi+bounces-3354-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 389B48507A2
	for <lists+linux-acpi@lfdr.de>; Sun, 11 Feb 2024 03:55:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA2A12834FA
	for <lists+linux-acpi@lfdr.de>; Sun, 11 Feb 2024 02:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A774186F;
	Sun, 11 Feb 2024 02:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ddWc0zFl"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A80917F6;
	Sun, 11 Feb 2024 02:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707620150; cv=none; b=dhA9NZbqrPuKTDxIzDFUfTHsFRYi14G5vbe9VEx/B7OeaiGU/hDVKIgGF2fNcrX+KT2CzuCSFueBKJOt0/wGT4s4RatHJPJlG78OWqoWx70nSpAUHWaI4/apODLOmdx7JAGKkZ9MOzEjEY5aRxciHVfS+31SsMm8asXmtSKpdG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707620150; c=relaxed/simple;
	bh=0pltjj3IxO9UbP2Pe6j6DyDup+1kuC3uk42TIYuMDT8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=jCeXA52KLJFhEXyv5k1QdYc9rBnMOu6nvoW5UV+gafyQZkai8q5zniXmMZY6eog8Cqqmx7shomZRaTOkSeQOnEQW+Zqqnlf4WQ3T5iE86eAsLh9WB31dipLpJOf1lbCQbJ8f3s7V74/C7/X6LvAa5R5eCXcNnNYhluyi+6YF4M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ddWc0zFl; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707620148; x=1739156148;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=0pltjj3IxO9UbP2Pe6j6DyDup+1kuC3uk42TIYuMDT8=;
  b=ddWc0zFl6zav8PBifTllgMj8R/OopJuQv6UN0RB0OAPs5oifjHgCRz9i
   mpfSygtvD9ORMHeqjwBDxnVCEuHsHycXLIz5tNFv9jQPR+mvF/xIlNN/i
   UjHGkAzPs/QX8cMl5UatdoQVd7BuYiCkDvG8JDkV1U2wxlXR7qpiPQ4BA
   RJNmPtbseb9+lbM5cI1ow1khkUZAZj62gY22HmJtfA/IA/k0GG2b5V09z
   xDJUfSAMeShfARQxHLO+LZ8WYTP5SEznPpgsdSYiHwsTD7YzFwRdLQP+9
   6u79HS6czUSSMElqCO8kc/g/1RSJH1w7fDsqC5ofhq2IvYUmaMCJDBQPi
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10980"; a="12331133"
X-IronPort-AV: E=Sophos;i="6.05,260,1701158400"; 
   d="scan'208";a="12331133"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2024 18:55:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10980"; a="934762816"
X-IronPort-AV: E=Sophos;i="6.05,260,1701158400"; 
   d="scan'208";a="934762816"
Received: from lkp-server01.sh.intel.com (HELO 01f0647817ea) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 10 Feb 2024 18:55:45 -0800
Received: from kbuild by 01f0647817ea with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rZ00M-0006HC-2d;
	Sun, 11 Feb 2024 02:55:42 +0000
Date: Sun, 11 Feb 2024 10:55:01 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-acpi@vger.kernel.org, devel@acpica.org,
	linux-pm@vger.kernel.org,
	Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
Subject: [rafael-pm:bleeding-edge 74/80]
 drivers/thermal/thermal_core.c:1230:11: warning: address of array
 'tz->trips' will always evaluate to 'true'
Message-ID: <202402111049.8Q45bnyf-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
head:   1cc7a914a31bd41feb404b644539a007f99b4f00
commit: 888085f258b2e617bfc4548a9907b09f935efcbb [74/80] thermal: core: Store zone trips table in struct thermal_zone_device
config: arm-defconfig (https://download.01.org/0day-ci/archive/20240211/202402111049.8Q45bnyf-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project.git f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240211/202402111049.8Q45bnyf-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402111049.8Q45bnyf-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/thermal/thermal_core.c:1230:11: warning: address of array 'tz->trips' will always evaluate to 'true' [-Wpointer-bool-conversion]
           if (!tz->trips)
               ~~~~~^~~~~
   1 warning generated.
--
>> drivers/thermal/thermal_trip.c:125:18: warning: address of array 'tz->trips' will always evaluate to 'true' [-Wpointer-bool-conversion]
           if (!tz || !tz->trips || trip_id < 0 || trip_id >= tz->num_trips || !trip)
                      ~~~~~^~~~~
   1 warning generated.


vim +1230 drivers/thermal/thermal_core.c

e5f2cda61d068e Daniel Lezcano 2022-07-22  1222  
7c3d5c20dc169e Daniel Lezcano 2022-10-03  1223  int thermal_zone_get_crit_temp(struct thermal_zone_device *tz, int *temp)
7c3d5c20dc169e Daniel Lezcano 2022-10-03  1224  {
7c3d5c20dc169e Daniel Lezcano 2022-10-03  1225  	int i, ret = -EINVAL;
7c3d5c20dc169e Daniel Lezcano 2022-10-03  1226  
7c3d5c20dc169e Daniel Lezcano 2022-10-03  1227  	if (tz->ops->get_crit_temp)
7c3d5c20dc169e Daniel Lezcano 2022-10-03  1228  		return tz->ops->get_crit_temp(tz, temp);
7c3d5c20dc169e Daniel Lezcano 2022-10-03  1229  
7c3d5c20dc169e Daniel Lezcano 2022-10-03 @1230  	if (!tz->trips)
7c3d5c20dc169e Daniel Lezcano 2022-10-03  1231  		return -EINVAL;
7c3d5c20dc169e Daniel Lezcano 2022-10-03  1232  
7c3d5c20dc169e Daniel Lezcano 2022-10-03  1233  	mutex_lock(&tz->lock);
7c3d5c20dc169e Daniel Lezcano 2022-10-03  1234  
7c3d5c20dc169e Daniel Lezcano 2022-10-03  1235  	for (i = 0; i < tz->num_trips; i++) {
7c3d5c20dc169e Daniel Lezcano 2022-10-03  1236  		if (tz->trips[i].type == THERMAL_TRIP_CRITICAL) {
7c3d5c20dc169e Daniel Lezcano 2022-10-03  1237  			*temp = tz->trips[i].temperature;
7c3d5c20dc169e Daniel Lezcano 2022-10-03  1238  			ret = 0;
7c3d5c20dc169e Daniel Lezcano 2022-10-03  1239  			break;
7c3d5c20dc169e Daniel Lezcano 2022-10-03  1240  		}
7c3d5c20dc169e Daniel Lezcano 2022-10-03  1241  	}
7c3d5c20dc169e Daniel Lezcano 2022-10-03  1242  
7c3d5c20dc169e Daniel Lezcano 2022-10-03  1243  	mutex_unlock(&tz->lock);
7c3d5c20dc169e Daniel Lezcano 2022-10-03  1244  
7c3d5c20dc169e Daniel Lezcano 2022-10-03  1245  	return ret;
7c3d5c20dc169e Daniel Lezcano 2022-10-03  1246  }
7c3d5c20dc169e Daniel Lezcano 2022-10-03  1247  EXPORT_SYMBOL_GPL(thermal_zone_get_crit_temp);
7c3d5c20dc169e Daniel Lezcano 2022-10-03  1248  

:::::: The code at line 1230 was first introduced by commit
:::::: 7c3d5c20dc169e55064f7f38c1c56cfbc39ee5b2 thermal/core: Add a generic thermal_zone_get_trip() function

:::::: TO: Daniel Lezcano <daniel.lezcano@linaro.org>
:::::: CC: Daniel Lezcano <daniel.lezcano@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

