Return-Path: <linux-acpi+bounces-3357-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B5C9850823
	for <lists+linux-acpi@lfdr.de>; Sun, 11 Feb 2024 09:41:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA2631F219A2
	for <lists+linux-acpi@lfdr.de>; Sun, 11 Feb 2024 08:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21E1259141;
	Sun, 11 Feb 2024 08:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bMSQm0j5"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB06266A7;
	Sun, 11 Feb 2024 08:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707640859; cv=none; b=DHa3YgpJJMIoGDLLK017v0SBkgQ5EqjzXiNGqkZxNgiAiE+9PHEuVUan8LY25l9GBqS9XG/NaBBY30DDXW3hMTfaZqiihE4Xn8KkfYgKbECyk01fWY1NYaTmh1MuA9fxFZW5+ulkDr2qrAjIW3cKzqCGJrtWb9k25Ck0TYojECo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707640859; c=relaxed/simple;
	bh=DOZoQMVJudY5xOMVrMgK/IsAxz6Av8w9q2VvGcpD2KI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=cD3uqPHyhbcMxXy/zK99+z3MCblO/QK3/iz1l2Pw+cA1lxxEVj1xW9tv5MVVLq0GWzS4wePtKAHtH7axBOWCJakzPTvQUqi783Ix/MZ17HfxO67Z+3x97Ux6kGTVqtdfJWHNMn7ZldHVPIC3WG4rBjEhTb0SQb4pP9j7TASzUpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bMSQm0j5; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707640857; x=1739176857;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=DOZoQMVJudY5xOMVrMgK/IsAxz6Av8w9q2VvGcpD2KI=;
  b=bMSQm0j59gF7Op8yPiwlTH+Gnb54/L76LltEa/1d8qmtRQJYPwNzCkqh
   AzWgINWmu/Wk3t4nbFgAVVF8pDUJBuUb4LaTFd+fPi8IgRlIqzpYis4tb
   3BGmbvp2i0ryesCV9aY0DgE9f2f3OnnwsykFPhx/AkmjXebY8PyMsePT8
   YXJSNcPTlEwne1HcNSjlcdwXd/suXjfIUpR/eC/ETtqMXT6w7aDg9Mb8D
   SxIy+fUaM3fc2Za//C2rcl/lDVaAHWW1xjk6QyGGcjn4Bff/71T6O2tNP
   x7IOYh89eYV762aDABqR1aPjL5fJN4ltvmbuGYT3oNb1r4Eu7Mw8NIl11
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10980"; a="1764019"
X-IronPort-AV: E=Sophos;i="6.05,260,1701158400"; 
   d="scan'208";a="1764019"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2024 00:40:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,260,1701158400"; 
   d="scan'208";a="6968075"
Received: from lkp-server01.sh.intel.com (HELO 01f0647817ea) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 11 Feb 2024 00:40:54 -0800
Received: from kbuild by 01f0647817ea with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rZ5ON-0006Ss-2W;
	Sun, 11 Feb 2024 08:40:51 +0000
Date: Sun, 11 Feb 2024 16:40:34 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: oe-kbuild-all@lists.linux.dev, linux-acpi@vger.kernel.org,
	devel@acpica.org, linux-pm@vger.kernel.org,
	Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
Subject: [rafael-pm:bleeding-edge 74/80]
 drivers/thermal/thermal_core.c:1230:13: warning: the comparison will always
 evaluate as 'true' for the address of 'trips' will never be NULL
Message-ID: <202402111655.cJxMGZeM-lkp@intel.com>
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
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20240211/202402111655.cJxMGZeM-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240211/202402111655.cJxMGZeM-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402111655.cJxMGZeM-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/thermal/thermal_core.c: In function 'thermal_zone_get_crit_temp':
>> drivers/thermal/thermal_core.c:1230:13: warning: the comparison will always evaluate as 'true' for the address of 'trips' will never be NULL [-Waddress]
    1230 |         if (!tz->trips)
         |             ^
   In file included from drivers/thermal/thermal_core.c:18:
   include/linux/thermal.h:205:29: note: 'trips' declared here
     205 |         struct thermal_trip trips[] __counted_by(num_trips);
         |                             ^~~~~
--
   drivers/thermal/thermal_trip.c: In function '__thermal_zone_get_trip':
>> drivers/thermal/thermal_trip.c:125:20: warning: the comparison will always evaluate as 'true' for the address of 'trips' will never be NULL [-Waddress]
     125 |         if (!tz || !tz->trips || trip_id < 0 || trip_id >= tz->num_trips || !trip)
         |                    ^
   In file included from drivers/thermal/thermal_core.h:13,
                    from drivers/thermal/thermal_trip.c:10:
   include/linux/thermal.h:205:29: note: 'trips' declared here
     205 |         struct thermal_trip trips[] __counted_by(num_trips);
         |                             ^~~~~


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

