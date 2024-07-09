Return-Path: <linux-acpi+bounces-6833-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1B4E92C666
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Jul 2024 01:08:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C1AB283808
	for <lists+linux-acpi@lfdr.de>; Tue,  9 Jul 2024 23:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A4A2156674;
	Tue,  9 Jul 2024 23:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ezr3iZDr"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB901420A8;
	Tue,  9 Jul 2024 23:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720566526; cv=none; b=MS/2n3oA3BOE+naR53/VGrl2HX50eHc2sPJMRcCCvb34hq+mOlXAse0+ljKaOBm8BRwi/0SqX22tK0YdE292iLvZltpTpUBlMcUdohmxZcXSEbkuJ0FyJ2y6mXPrmSJFE0dkA0iVMaNPha5+rKzsw3+mLgripgfnttzkBsAKAR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720566526; c=relaxed/simple;
	bh=cNtPCsXpegbZHe34ASEf5jaMB+nDOKdd5xsGxoFawNA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=F6U1i2EuuLZa6VPBvwHWG1Keq4dsOFAmjSWHjX5gGxhMqFA/J7xbiWTbfAB6XhzeeAiq2XHCqxzFE7lfJlv1y8McfbxrAUDEzN9lRRwtG5uLCcx2EoETBp2rr1RXbUgXz7ivCD2/Q7bwXJ455v3FvZSscrL6UnHrHdA62TQdwhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ezr3iZDr; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720566524; x=1752102524;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=cNtPCsXpegbZHe34ASEf5jaMB+nDOKdd5xsGxoFawNA=;
  b=Ezr3iZDrtbmaKUEwNCDHkb3OqA7wO2FSRaIynlGdTb8BSvFbSnXiUpfa
   j/oxGVhL/h/l/Qc9Ks5KT5nvFYBUpYV0k+4/pgijTr4aQnIr5xeGPB5wW
   BFFNbw9NMAhtCy++9zh5I8ax4w1Me7hW3tle67cDI4V+irh6ylHUWWk7R
   zDjdeYM40EaQgalwPnYYZ6UPvtd63oWnUpgi0i1uFwKvQmmcKwmzNWx35
   yLqmGMTjUZJRuCfC3g9LAkTABikPrepBQMia60EmFqPzBjnF2OTmKKVjH
   1wY+0CNEqDwklYHXTOXMby5GO/sXkQ/0KrN2QWHspkiYAlbvzuyCp0BX8
   Q==;
X-CSE-ConnectionGUID: zNpxlb21TYeANds3PM4Evg==
X-CSE-MsgGUID: 3tTvOWNUT1ugv1DPB0PWug==
X-IronPort-AV: E=McAfee;i="6700,10204,11128"; a="21675828"
X-IronPort-AV: E=Sophos;i="6.09,196,1716274800"; 
   d="scan'208";a="21675828"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2024 16:08:43 -0700
X-CSE-ConnectionGUID: 7SgoeVKzTViHXU+M14B96g==
X-CSE-MsgGUID: sacxh7KrRqekArwXSWl8iQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,196,1716274800"; 
   d="scan'208";a="48106741"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 09 Jul 2024 16:08:42 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sRJwt-000XCp-2J;
	Tue, 09 Jul 2024 23:08:39 +0000
Date: Wed, 10 Jul 2024 07:08:28 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: oe-kbuild-all@lists.linux.dev, linux-acpi@vger.kernel.org,
	devel@acpica.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge 179/184]
 drivers/thermal/imx_thermal.c:385:26: error: initialization of 'int
 (*)(struct thermal_zone_device *, const struct thermal_trip *, int)' from
 incompatible pointer type 'int (*)(struct thermal_zone_device *, int,  int)'
Message-ID: <202407100628.3zCKg3YO-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
head:   87efced4091268c3ec327c53829b5e375be155dd
commit: fac8bf59e782ac74bb54d8427581f725bba8a769 [179/184] thermal: trip: Pass trip pointer to .set_trip_temp() thermal zone callback
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20240710/202407100628.3zCKg3YO-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240710/202407100628.3zCKg3YO-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407100628.3zCKg3YO-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

>> drivers/thermal/imx_thermal.c:385:26: error: initialization of 'int (*)(struct thermal_zone_device *, const struct thermal_trip *, int)' from incompatible pointer type 'int (*)(struct thermal_zone_device *, int,  int)' [-Werror=incompatible-pointer-types]
     385 |         .set_trip_temp = imx_set_trip_temp,
         |                          ^~~~~~~~~~~~~~~~~
   drivers/thermal/imx_thermal.c:385:26: note: (near initialization for 'imx_tz_ops.set_trip_temp')
   cc1: some warnings being treated as errors
--
   drivers/thermal/tegra/soctherm.c: In function 'tegra_thermctl_set_trip_temp':
>> drivers/thermal/tegra/soctherm.c:592:13: warning: unused variable 'ret' [-Wunused-variable]
     592 |         int ret;
         |             ^~~


vim +385 drivers/thermal/imx_thermal.c

ca3de46b508090 Shawn Guo             2013-06-24  379  
cbb07bb35de6eb Eduardo Valentin      2014-01-06  380  static struct thermal_zone_device_ops imx_tz_ops = {
ca3de46b508090 Shawn Guo             2013-06-24  381  	.bind = imx_bind,
ca3de46b508090 Shawn Guo             2013-06-24  382  	.unbind = imx_unbind,
ca3de46b508090 Shawn Guo             2013-06-24  383  	.get_temp = imx_get_temp,
f5e50bf4d3ef0a Andrzej Pietrasiewicz 2020-06-29  384  	.change_mode = imx_change_mode,
017e51420cc440 Philipp Zabel         2013-08-01 @385  	.set_trip_temp = imx_set_trip_temp,
ca3de46b508090 Shawn Guo             2013-06-24  386  };
ca3de46b508090 Shawn Guo             2013-06-24  387  

:::::: The code at line 385 was first introduced by commit
:::::: 017e51420cc44098308b00dffd9d4e514ddf40f3 thermal: imx: dynamic passive and SoC specific critical trip points

:::::: TO: Philipp Zabel <p.zabel@pengutronix.de>
:::::: CC: Zhang Rui <rui.zhang@intel.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

