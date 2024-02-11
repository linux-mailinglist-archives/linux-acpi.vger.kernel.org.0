Return-Path: <linux-acpi+bounces-3355-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 356648507C7
	for <lists+linux-acpi@lfdr.de>; Sun, 11 Feb 2024 05:41:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EFE8AB23E39
	for <lists+linux-acpi@lfdr.de>; Sun, 11 Feb 2024 04:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C32E28E7;
	Sun, 11 Feb 2024 04:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IsyQ/sBY"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30676168A8;
	Sun, 11 Feb 2024 04:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707626452; cv=none; b=i3y7YPFoU3XsOsZJ+5kZ5lSIVOcPOvEy3+HRmMmYDbf1jDBqZhiwjFTpFiFBr/KmuxOKwuK4mM5wrsm1CKsIan2jJ3yBPlVNusKUDYBHFIgbUcGpUFOaf/RFxLs6T8/jHv5XX7dWx1UzT/I8lbRK9qojskPjrSCWhSVLJxh+NKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707626452; c=relaxed/simple;
	bh=CownNAVPfNsIPeF32dr33D4llG6r8gmboNGzmlzbGtQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ZFdRHqxdoLYfK6UTntqwtOtLfu/XhVrZf5woxFVBzejy5cFt0M2Obr5NtON7ET98Qqqait+Pw2UgILKjZ5659p8QNhfZYj1ADxC4BzMfRlEvBHsv80MkfICL77Gyjvceoo1X5J/lGYRjR7HR67Z2ippTVVXuxwH5GCyvpEOVVHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IsyQ/sBY; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707626449; x=1739162449;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=CownNAVPfNsIPeF32dr33D4llG6r8gmboNGzmlzbGtQ=;
  b=IsyQ/sBYk6FRbDPFDIfRKSb485fnnKEGc/DPIPX+4/Kt+z4q5mQKBeUo
   qGJsZuKHck2PIKNebCNzyDQOzDr1+vg/MFqH4oRwi12lJCwIb/z432SCp
   NkImpaqKVnOI3NWAgo3JAGJrUfSVfOKo4ZHBBLt6eZnMI3lVbON0F9bIf
   BQTsoZCIBjHqH+A1WVyUTLMmpMgEFss6+xcMKnxN6XDLOvn2iwsMZgQ5Y
   ho31huRTw50ejr6hNc+7ig5MbmWTL1dvnbOtAtNwRls7ds3gfU5fjAkIE
   DUx2SAr0qIc1tLXeA+fnH5j2HLZs4NwylT1xACr1WCNsXA4BZEbeKrGXO
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10980"; a="12334777"
X-IronPort-AV: E=Sophos;i="6.05,260,1701158400"; 
   d="scan'208";a="12334777"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2024 20:40:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,260,1701158400"; 
   d="scan'208";a="33364385"
Received: from lkp-server01.sh.intel.com (HELO 01f0647817ea) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 10 Feb 2024 20:40:47 -0800
Received: from kbuild by 01f0647817ea with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rZ1e0-0006KI-1m;
	Sun, 11 Feb 2024 04:40:44 +0000
Date: Sun, 11 Feb 2024 12:40:00 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: oe-kbuild-all@lists.linux.dev, linux-acpi@vger.kernel.org,
	devel@acpica.org, linux-pm@vger.kernel.org,
	Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
Subject: drivers/thermal/thermal_of.c:487:24: warning: returning 'long int'
 from a function with return type 'struct thermal_zone_device *' makes
 pointer from integer without a cast
Message-ID: <202402111258.zSHkL26j-lkp@intel.com>
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
commit: af0c508eaaf052006a183dab9c3a2994615942d1 thermal: core: Store zone ops in struct thermal_zone_device
date:   13 hours ago
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20240211/202402111258.zSHkL26j-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240211/202402111258.zSHkL26j-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402111258.zSHkL26j-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/thermal/thermal_of.c: In function 'thermal_of_zone_register':
>> drivers/thermal/thermal_of.c:487:24: warning: returning 'long int' from a function with return type 'struct thermal_zone_device *' makes pointer from integer without a cast [-Wint-conversion]
     487 |                 return PTR_ERR(np);
         |                        ^~~~~~~~~~~
   drivers/thermal/thermal_of.c:493:24: warning: returning 'long int' from a function with return type 'struct thermal_zone_device *' makes pointer from integer without a cast [-Wint-conversion]
     493 |                 return PTR_ERR(trips);
         |                        ^~~~~~~~~~~~~~


vim +487 drivers/thermal/thermal_of.c

   449	
   450	/**
   451	 * thermal_of_zone_register - Register a thermal zone with device node
   452	 * sensor
   453	 *
   454	 * The thermal_of_zone_register() parses a device tree given a device
   455	 * node sensor and identifier. It searches for the thermal zone
   456	 * associated to the couple sensor/id and retrieves all the thermal
   457	 * zone properties and registers new thermal zone with those
   458	 * properties.
   459	 *
   460	 * @sensor: A device node pointer corresponding to the sensor in the device tree
   461	 * @id: An integer as sensor identifier
   462	 * @data: A private data to be stored in the thermal zone dedicated private area
   463	 * @ops: A set of thermal sensor ops
   464	 *
   465	 * Return: a valid thermal zone structure pointer on success.
   466	 * 	- EINVAL: if the device tree thermal description is malformed
   467	 *	- ENOMEM: if one structure can not be allocated
   468	 *	- Other negative errors are returned by the underlying called functions
   469	 */
   470	static struct thermal_zone_device *thermal_of_zone_register(struct device_node *sensor, int id, void *data,
   471								    const struct thermal_zone_device_ops *ops)
   472	{
   473		struct thermal_zone_device_ops of_ops = *ops;
   474		struct thermal_zone_device *tz;
   475		struct thermal_trip *trips;
   476		struct thermal_zone_params tzp = {};
   477		struct device_node *np;
   478		const char *action;
   479		int delay, pdelay;
   480		int ntrips;
   481		int ret;
   482	
   483		np = of_thermal_zone_find(sensor, id);
   484		if (IS_ERR(np)) {
   485			if (PTR_ERR(np) != -ENODEV)
   486				pr_err("Failed to find thermal zone for %pOFn id=%d\n", sensor, id);
 > 487			return PTR_ERR(np);
   488		}
   489	
   490		trips = thermal_of_trips_init(np, &ntrips);
   491		if (IS_ERR(trips)) {
   492			pr_err("Failed to find trip points for %pOFn id=%d\n", sensor, id);
   493			return PTR_ERR(trips);
   494		}
   495	
   496		ret = thermal_of_monitor_init(np, &delay, &pdelay);
   497		if (ret) {
   498			pr_err("Failed to initialize monitoring delays from %pOFn\n", np);
   499			goto out_kfree_trips;
   500		}
   501	
   502		thermal_of_parameters_init(np, &tzp);
   503	
   504		of_ops.bind = thermal_of_bind;
   505		of_ops.unbind = thermal_of_unbind;
   506	
   507		ret = of_property_read_string(np, "critical-action", &action);
   508		if (!ret)
   509			if (!of_ops.critical && !strcasecmp(action, "reboot"))
   510				of_ops.critical = thermal_zone_device_critical_reboot;
   511	
   512		tz = thermal_zone_device_register_with_trips(np->name, trips, ntrips,
   513							     data, &of_ops, &tzp,
   514							     pdelay, delay);
   515		if (IS_ERR(tz)) {
   516			ret = PTR_ERR(tz);
   517			pr_err("Failed to register thermal zone %pOFn: %d\n", np, ret);
   518			goto out_kfree_trips;
   519		}
   520	
   521		ret = thermal_zone_device_enable(tz);
   522		if (ret) {
   523			pr_err("Failed to enabled thermal zone '%s', id=%d: %d\n",
   524			       tz->type, tz->id, ret);
   525			thermal_of_zone_unregister(tz);
   526			return ERR_PTR(ret);
   527		}
   528	
   529		return tz;
   530	
   531	out_kfree_trips:
   532		kfree(trips);
   533	
   534		return ERR_PTR(ret);
   535	}
   536	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

