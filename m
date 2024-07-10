Return-Path: <linux-acpi+bounces-6834-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3945A92C7ED
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Jul 2024 03:25:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A6BC1C21FF8
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Jul 2024 01:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00E874404;
	Wed, 10 Jul 2024 01:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l8+MnV0A"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F87610FF;
	Wed, 10 Jul 2024 01:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720574737; cv=none; b=R7pPyJb7kzVXw6oI0uDxwA8GrumiSV7BfeG9TmBi2yNnboPN15jPQW2TMLpiw8S/UajMcMr2cEcZdh99ZthpANQi6AXwCt3KiX3i4DKGqKB70MCOPY2kyNcv4Wyh0YAS2qnouVF9d9NpIocYaENh7fB254eBuGrL0QHw9zFbdAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720574737; c=relaxed/simple;
	bh=kZm1sT7nWrDSzIOlLZ3soMLEol9aGiCB3UvnqOj+7jY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=jkHNEY1OqHJYXxfnZ9OYs1H7vGpfsFH64aQ9HtTkcsZfFKnn5w/uaSQkHGhDHQpqSGl8Oser9zej2CO6Zr1/lZuNyxo6GETs8+Wbw/MTBfoVYPT8aFLTif0qwa5X2MvXRGfNQ0uP685F0Rpte2XEwg/eVgnP2gn6qxeE+Mj255c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l8+MnV0A; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720574736; x=1752110736;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=kZm1sT7nWrDSzIOlLZ3soMLEol9aGiCB3UvnqOj+7jY=;
  b=l8+MnV0AHzBU36PcuUEQuhc3O6E9D14ci2enT9Q0MKoY11ltOOwUYQ2M
   J2FeR+sVucsD2rexLY0vNWS3MVMnDM/4297oBkDCUQZv0L8fp8sgwvNRY
   X98gyZhNuHLK7P1l0FPG6EWVrVEPpXAid7L9D0ZPqFi53rD/zrKHQJn7s
   OAKiyeuAzKcYqZLnuNEpBv4sZP3VkWEgOexGGLHL6oxN5bdTAgrgDk8wn
   HeGRfPpdEOfo+68g6qZNvGtHH36Zwq2030UZXxz2Zf8bDqsZvzw9El0B0
   F4wCatBwuxjiRo5STlhWiRAC7gQpfTHkPpOXrjoP5IEWpBGBCnSVq+vdW
   w==;
X-CSE-ConnectionGUID: gNxa7hfMRiOyeGDmE4YOzw==
X-CSE-MsgGUID: J+FDh+AJT5CvMkI9kSHlLw==
X-IronPort-AV: E=McAfee;i="6700,10204,11128"; a="18007198"
X-IronPort-AV: E=Sophos;i="6.09,196,1716274800"; 
   d="scan'208";a="18007198"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2024 18:25:35 -0700
X-CSE-ConnectionGUID: jBKqCJ0wRsKfSBUNNcnD/g==
X-CSE-MsgGUID: y87zk1jbSMqdWMawiFXa/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,196,1716274800"; 
   d="scan'208";a="48014106"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 09 Jul 2024 18:25:00 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sRM4m-000XKM-2h;
	Wed, 10 Jul 2024 01:24:56 +0000
Date: Wed, 10 Jul 2024 09:24:45 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: oe-kbuild-all@lists.linux.dev, linux-acpi@vger.kernel.org,
	devel@acpica.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge 179/184]
 drivers/thermal/intel/intel_quark_dts_thermal.c:258:16: error: expected ':'
 before 'return'
Message-ID: <202407100927.FM8ya0gq-lkp@intel.com>
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
config: i386-allmodconfig (https://download.01.org/0day-ci/archive/20240710/202407100927.FM8ya0gq-lkp@intel.com/config)
compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240710/202407100927.FM8ya0gq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407100927.FM8ya0gq-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   drivers/thermal/intel/intel_quark_dts_thermal.c: In function 'sys_set_trip_temp':
>> drivers/thermal/intel/intel_quark_dts_thermal.c:258:16: error: expected ':' before 'return'
     258 |         default
         |                ^
         |                :
     259 |                 return -EINVAL;
         |                 ~~~~~~
>> drivers/thermal/intel/intel_quark_dts_thermal.c:251:9: warning: enumeration value 'THERMAL_TRIP_ACTIVE' not handled in switch [-Wswitch]
     251 |         switch (trip->type) {
         |         ^~~~~~
>> drivers/thermal/intel/intel_quark_dts_thermal.c:251:9: warning: enumeration value 'THERMAL_TRIP_PASSIVE' not handled in switch [-Wswitch]


vim +258 drivers/thermal/intel/intel_quark_dts_thermal.c

   244	
   245	static inline int sys_set_trip_temp(struct thermal_zone_device *tzd,
   246					    const struct thermal_trip *trip,
   247					    int temp)
   248	{
   249		unsigned int trip_index;
   250	
 > 251		switch (trip->type) {
   252		case THERMAL_TRIP_HOT:
   253			trip_index = QRK_DTS_ID_TP_HOT;
   254			break;
   255		case THERMAL_TRIP_CRITICAL:
   256			trip_index = QRK_DTS_ID_TP_CRITICAL;
   257			break;
 > 258		default
   259			return -EINVAL;
   260		}
   261	
   262		return update_trip_temp(thermal_zone_device_priv(tzd), trip_index, temp);
   263	}
   264	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

