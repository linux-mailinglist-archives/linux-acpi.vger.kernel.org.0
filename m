Return-Path: <linux-acpi+bounces-3446-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A354F852B59
	for <lists+linux-acpi@lfdr.de>; Tue, 13 Feb 2024 09:40:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 296BD1F23F16
	for <lists+linux-acpi@lfdr.de>; Tue, 13 Feb 2024 08:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 571F91865B;
	Tue, 13 Feb 2024 08:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="budt7rGV"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C7D18654;
	Tue, 13 Feb 2024 08:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707813634; cv=none; b=OOfUYlhwHA3zwie6eDMhOpRWjwpgZulSs1smMUZxN+ZFHNgQClLg6Xk0PKq/obSUh5FouW5nrEa6pHB53wtbjOZ1XaseOLWZACBwA5+cv3ixTotfQ3LWdrYWcJJtY+OXMzVFoUMLJosH/0VDiNDpyEz6xz026TEIVs9VF+Usj1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707813634; c=relaxed/simple;
	bh=tp6cuJikOwkd/uSEFgy8YwwuuKYIxq5a+om5uZQlL4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=EdAzcdT5qnb1DNDieJ83J6q8evvOjoGOKwgynrCjvZKwGLGwMb/0xi8XAbdIZh4vE4Tjhn+VtJF2bRqXWYhqekpMZKnDVNl0zpigJETRTLN2i7KyDlYIyNPnet8rLGmmC2YAMfH5XodfPYeeS6iZoracNOvGF7jhkcWcdapP268=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=budt7rGV; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707813632; x=1739349632;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=tp6cuJikOwkd/uSEFgy8YwwuuKYIxq5a+om5uZQlL4Q=;
  b=budt7rGV0S4HkKFZhordGePSWd3OhJXdRARaE/9yhf+uKqZD9GCfzS0L
   j3njW6KUXL5RJ0eR16ZdkTr/2ob6xrX1cyo8acrM2nSolaOGfwmczfqYh
   ObTDooMY9EbJ+26Tw2kngGkUHeLiUgkQBCbNGrMoq3Rm7/3bEV72fGmgq
   Bp2BnT1VJidy/3Dzzn1AI5UcNp20a0MNscAlA9ExQgRflih/HTMUEvKI9
   aTuzu0diQILsUcdM/o6P/dCb9Pjig0SssPuqVZPXEeOsik65PX1rJeBxC
   c8j8qxrWRjqIOI3P5PjhGLwTvpkpnq6XCK+scs3iWgh2B1gzxojguQykR
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="19224856"
X-IronPort-AV: E=Sophos;i="6.06,156,1705392000"; 
   d="scan'208";a="19224856"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2024 00:40:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,156,1705392000"; 
   d="scan'208";a="3146864"
Received: from lkp-server01.sh.intel.com (HELO 01f0647817ea) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 13 Feb 2024 00:40:30 -0800
Received: from kbuild by 01f0647817ea with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rZoL5-0007c6-18;
	Tue, 13 Feb 2024 08:40:27 +0000
Date: Tue, 13 Feb 2024 16:39:32 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: oe-kbuild-all@lists.linux.dev, linux-acpi@vger.kernel.org,
	devel@acpica.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge 76/104]
 drivers/thermal/intel/intel_pch_thermal.c:235:52: warning: passing argument
 2 of 'pch_wpt_add_acpi_psv_trip' makes integer from pointer without a cast
Message-ID: <202402131654.p66Sf4bH-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
head:   536723ad19c051cec0b5fa9793100f26c70b28d0
commit: 8c6e2196a852052fa1696cfe86d1da366f725b19 [76/104] thermal: intel: Discard trip tables after zone registration
config: i386-buildonly-randconfig-003-20240213 (https://download.01.org/0day-ci/archive/20240213/202402131654.p66Sf4bH-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240213/202402131654.p66Sf4bH-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402131654.p66Sf4bH-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/thermal/intel/intel_pch_thermal.c: In function 'intel_pch_thermal_probe':
>> drivers/thermal/intel/intel_pch_thermal.c:235:52: warning: passing argument 2 of 'pch_wpt_add_acpi_psv_trip' makes integer from pointer without a cast [-Wint-conversion]
     235 |         nr_trips += pch_wpt_add_acpi_psv_trip(ptd, &ptd_trips[nr_trips]);
         |                                                    ^~~~~~~~~~~~~~~~~~~~
         |                                                    |
         |                                                    struct thermal_trip *
   drivers/thermal/intel/intel_pch_thermal.c:114:74: note: expected 'int' but argument is of type 'struct thermal_trip *'
     114 | static int pch_wpt_add_acpi_psv_trip(struct pch_thermal_device *ptd, int trip)
         |                                                                      ~~~~^~~~


vim +/pch_wpt_add_acpi_psv_trip +235 drivers/thermal/intel/intel_pch_thermal.c

   158	
   159	static int intel_pch_thermal_probe(struct pci_dev *pdev,
   160					   const struct pci_device_id *id)
   161	{
   162		struct thermal_trip ptd_trips[PCH_MAX_TRIPS] = { 0 };
   163		enum pch_board_ids board_id = id->driver_data;
   164		struct pch_thermal_device *ptd;
   165		int nr_trips = 0;
   166		u16 trip_temp;
   167		u8 tsel;
   168		int err;
   169	
   170		ptd = devm_kzalloc(&pdev->dev, sizeof(*ptd), GFP_KERNEL);
   171		if (!ptd)
   172			return -ENOMEM;
   173	
   174		pci_set_drvdata(pdev, ptd);
   175		ptd->pdev = pdev;
   176	
   177		err = pci_enable_device(pdev);
   178		if (err) {
   179			dev_err(&pdev->dev, "failed to enable pci device\n");
   180			return err;
   181		}
   182	
   183		err = pci_request_regions(pdev, driver_name);
   184		if (err) {
   185			dev_err(&pdev->dev, "failed to request pci region\n");
   186			goto error_disable;
   187		}
   188	
   189		ptd->hw_base = pci_ioremap_bar(pdev, 0);
   190		if (!ptd->hw_base) {
   191			err = -ENOMEM;
   192			dev_err(&pdev->dev, "failed to map mem base\n");
   193			goto error_release;
   194		}
   195	
   196		/* Check if BIOS has already enabled thermal sensor */
   197		if (WPT_TSEL_ETS & readb(ptd->hw_base + WPT_TSEL)) {
   198			ptd->bios_enabled = true;
   199			goto read_trips;
   200		}
   201	
   202		tsel = readb(ptd->hw_base + WPT_TSEL);
   203		/*
   204		 * When TSEL's Policy Lock-Down bit is 1, TSEL become RO.
   205		 * If so, thermal sensor cannot enable. Bail out.
   206		 */
   207		if (tsel & WPT_TSEL_PLDB) {
   208			dev_err(&ptd->pdev->dev, "Sensor can't be enabled\n");
   209			err = -ENODEV;
   210			goto error_cleanup;
   211		}
   212	
   213		writeb(tsel|WPT_TSEL_ETS, ptd->hw_base + WPT_TSEL);
   214		if (!(WPT_TSEL_ETS & readb(ptd->hw_base + WPT_TSEL))) {
   215			dev_err(&ptd->pdev->dev, "Sensor can't be enabled\n");
   216			err = -ENODEV;
   217			goto error_cleanup;
   218		}
   219	
   220	read_trips:
   221		trip_temp = readw(ptd->hw_base + WPT_CTT);
   222		trip_temp &= 0x1FF;
   223		if (trip_temp) {
   224			ptd_trips[nr_trips].temperature = GET_WPT_TEMP(trip_temp);
   225			ptd_trips[nr_trips++].type = THERMAL_TRIP_CRITICAL;
   226		}
   227	
   228		trip_temp = readw(ptd->hw_base + WPT_PHL);
   229		trip_temp &= 0x1FF;
   230		if (trip_temp) {
   231			ptd_trips[nr_trips].temperature = GET_WPT_TEMP(trip_temp);
   232			ptd_trips[nr_trips++].type = THERMAL_TRIP_HOT;
   233		}
   234	
 > 235		nr_trips += pch_wpt_add_acpi_psv_trip(ptd, &ptd_trips[nr_trips]);
   236	
   237		ptd->tzd = thermal_zone_device_register_with_trips(board_names[board_id],
   238								   ptd_trips, nr_trips,
   239								   ptd, &tzd_ops,
   240								   NULL, 0, 0);
   241		if (IS_ERR(ptd->tzd)) {
   242			dev_err(&pdev->dev, "Failed to register thermal zone %s\n",
   243				board_names[board_id]);
   244			err = PTR_ERR(ptd->tzd);
   245			goto error_cleanup;
   246		}
   247		err = thermal_zone_device_enable(ptd->tzd);
   248		if (err)
   249			goto err_unregister;
   250	
   251		return 0;
   252	
   253	err_unregister:
   254		thermal_zone_device_unregister(ptd->tzd);
   255	error_cleanup:
   256		iounmap(ptd->hw_base);
   257	error_release:
   258		pci_release_regions(pdev);
   259	error_disable:
   260		pci_disable_device(pdev);
   261		dev_err(&pdev->dev, "pci device failed to probe\n");
   262		return err;
   263	}
   264	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

