Return-Path: <linux-acpi+bounces-3389-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF65850D01
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Feb 2024 04:05:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 605F01F2457E
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Feb 2024 03:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA4351841;
	Mon, 12 Feb 2024 03:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V86Z2Lje"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E336E3C0B;
	Mon, 12 Feb 2024 03:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707707123; cv=none; b=XjhiaAUQvZk1ANhVAI5rFYJNItHGzl5VpXt+TADFkd9VxNc6aHBBV6EAqeM7+PHPpuR8yIMcatk/wSznmlovKOrcGoTlH6YqEUJYXlGO5fidspHgjrNHoAc9Uw5XJaqcK8uyy6iIrbMsznSRD1rPAcYQbLlL3gsTFF36bQtdOl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707707123; c=relaxed/simple;
	bh=LJbwCQG5s8jn4AXP4+jfliDtKiD27kZfUu6R0S9TAOE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=HUqC0u9DIlPqiB8QNxQehFbX8OAT1gl2q9WrglElIDR5D3qK9dZZMHN7qqaWyjK8VRZ+y3B/CRrOismirp24aftznZCMqfsBEA/6Wl8KNNjAJ9Wyi2R1N71N6xMiYROck2grSEfSY2TdfLockVns9ZB05azXuCnDRTEu4zd5blQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V86Z2Lje; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707707121; x=1739243121;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=LJbwCQG5s8jn4AXP4+jfliDtKiD27kZfUu6R0S9TAOE=;
  b=V86Z2Lje0lnbpo5ybalhwbuJ4u3TIA+zv9BYOg9YqB0/BDw2BmHpw1JJ
   SmOFQko+198dk+mcxk5qWFjzgbx9u3hoa7xlRV8UPgc/dlITYM5FLECmC
   OJo9eXB+wPxedW6LCgxST77pVt/zzANYoSoNCFhDeK/8LHtk9JRst9aXw
   aMBWaRYyvTNlmKzYWKji+rLzLRgKL2P1pTQKBiY82cTa5luhMAFd1f244
   ocX9aZ4biSqSnpWMphUpLag3PnUiTidnhHkIwY8xYp3vePE3ZXj8EPLT9
   2Az8A3EdZVyjlwBxypkScgebveut5D4ylDfhrcx6jyZ9Q86dHysaYmTWl
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10981"; a="1545421"
X-IronPort-AV: E=Sophos;i="6.05,261,1701158400"; 
   d="scan'208";a="1545421"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2024 19:05:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,261,1701158400"; 
   d="scan'208";a="2867686"
Received: from lkp-server01.sh.intel.com (HELO 01f0647817ea) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 11 Feb 2024 19:05:19 -0800
Received: from kbuild by 01f0647817ea with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rZMdA-0006sk-1j;
	Mon, 12 Feb 2024 03:05:16 +0000
Date: Mon, 12 Feb 2024 11:04:37 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: oe-kbuild-all@lists.linux.dev, linux-acpi@vger.kernel.org,
	devel@acpica.org, linux-pm@vger.kernel.org,
	Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
Subject: [rafael-pm:bleeding-edge 77/80]
 drivers/thermal/thermal_of.c:487:9-16: WARNING: ERR_CAST can be used with np
Message-ID: <202402121043.uk6ySvwU-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
head:   f48788def3dc3b44ce2aed41c78692873b23030d
commit: cced01e7b1ef041514785f311601fa0897eb186e [77/80] thermal: core: Store zone ops in struct thermal_zone_device
config: x86_64-randconfig-101-20240212 (https://download.01.org/0day-ci/archive/20240212/202402121043.uk6ySvwU-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402121043.uk6ySvwU-lkp@intel.com/

cocci warnings: (new ones prefixed by >>)
>> drivers/thermal/thermal_of.c:487:9-16: WARNING: ERR_CAST can be used with np
>> drivers/thermal/thermal_of.c:493:9-16: WARNING: ERR_CAST can be used with trips

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
 > 487			return ERR_PTR(PTR_ERR(np));
   488		}
   489	
   490		trips = thermal_of_trips_init(np, &ntrips);
   491		if (IS_ERR(trips)) {
   492			pr_err("Failed to find trip points for %pOFn id=%d\n", sensor, id);
 > 493			return ERR_PTR(PTR_ERR(trips));
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

