Return-Path: <linux-acpi+bounces-7170-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35E83943538
	for <lists+linux-acpi@lfdr.de>; Wed, 31 Jul 2024 19:59:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DECFD2829F5
	for <lists+linux-acpi@lfdr.de>; Wed, 31 Jul 2024 17:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96C3B3C482;
	Wed, 31 Jul 2024 17:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CU+kmXz2"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401563BBF2;
	Wed, 31 Jul 2024 17:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722448740; cv=none; b=Djt+fi+HMmoeQJCynGpEnUwIvcxRbA3ISzboWk/VS4eBx2xIq+v7QRXgZaKgiuRJkKMNVUGxZW8diXg0O3QgEZ4JjH2KkWChRwWgP/9SnPVd3aVGlFNKlcbHOOlRE07SV5RCci70wuwqt6FeDXaar8JJMEvlAQR3+4vrK9GjhFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722448740; c=relaxed/simple;
	bh=dB7F/4syqFoBtfnHnfAcCoqz1SCvMHO7LE6eT6nWs8k=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=of5z88sDhLZPSxyub7VMJ100DaoFPLP1J0KkwHQsWaRYkiP4r1JSEmOmul/B1uaUCF3JVwzh8LgeISOKB317OfsYfTHqq8COy7W3qLY+9s9D96LWkf+zEi13UwEjYzX4kyfUulrgDfyeFZDLkZQ7WdJVyyuUESPE5lAoDb+xvqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CU+kmXz2; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722448737; x=1753984737;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=dB7F/4syqFoBtfnHnfAcCoqz1SCvMHO7LE6eT6nWs8k=;
  b=CU+kmXz2rHpo7j6li3Sy6zd/IWR31xFTQxypM84eIiYs2C3y89474DKU
   x+f7VFFiAgNIR3C/ZfqLJ790LyQNqiGBVFyJXKHmvoF27D45+AEqzsJN2
   uIt5RQF7pmkr5lflCQquLvfkWQnfnc0YoC+jDVaUDDoBdyhh+KNQ2hWtr
   CpmJP+K2UZOi7zNgC5FG/bmXooGRop2uOfBCE0lIcb5Z1xqaTWvIymlxO
   ocbko7KMJyeqklYRUlBJHidureKH6aMWisIVGENoELZ8Wa/lVpniJWRnv
   gaskZ8U7OyHP1DifhBC0I0YRSZoiNLfbZO7SPk2Al0jqhFq76gMfpCund
   g==;
X-CSE-ConnectionGUID: J+hr+wXzR5efQAo2Z7Bw6Q==
X-CSE-MsgGUID: Om8RP5CqRnefmgd3rmUNVw==
X-IronPort-AV: E=McAfee;i="6700,10204,11150"; a="31740429"
X-IronPort-AV: E=Sophos;i="6.09,251,1716274800"; 
   d="scan'208";a="31740429"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2024 10:58:57 -0700
X-CSE-ConnectionGUID: FRgKMhlLTLmy2XlLt6TbCQ==
X-CSE-MsgGUID: Pp9NSZCPQ5Gi81tiM8ndgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,251,1716274800"; 
   d="scan'208";a="59597255"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 31 Jul 2024 10:58:55 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sZDbA-000ugm-25;
	Wed, 31 Jul 2024 17:58:52 +0000
Date: Thu, 1 Aug 2024 01:58:32 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: oe-kbuild-all@lists.linux.dev, linux-acpi@vger.kernel.org,
	devel@acpica.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:thermal-core-testing 2/28]
 drivers/thermal/hisi_thermal.c:484:29: warning: unused variable 'trip'
Message-ID: <202408010134.hozVfGEo-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-core-testing
head:   c213ec5d265075e670b175f577fc30f12c2bf093
commit: 09a7303648169c6d8c5f2608b0764a7095a15c21 [2/28] thermal: hisi: Use thermal_zone_for_each_trip() in hisi_thermal_register_sensor()
config: xtensa-allyesconfig (https://download.01.org/0day-ci/archive/20240801/202408010134.hozVfGEo-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240801/202408010134.hozVfGEo-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408010134.hozVfGEo-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/thermal/hisi_thermal.c: In function 'hisi_thermal_register_sensor':
>> drivers/thermal/hisi_thermal.c:484:29: warning: unused variable 'trip' [-Wunused-variable]
     484 |         struct thermal_trip trip;
         |                             ^~~~
>> drivers/thermal/hisi_thermal.c:483:18: warning: unused variable 'i' [-Wunused-variable]
     483 |         int ret, i;
         |                  ^


vim +/trip +484 drivers/thermal/hisi_thermal.c

09a7303648169c Rafael J. Wysocki 2024-07-29  479  
9a5238a9c6c33d kongxinwei        2015-05-20  480  static int hisi_thermal_register_sensor(struct platform_device *pdev,
a160a465297362 Kevin Wangtao     2017-10-22  481  					struct hisi_thermal_sensor *sensor)
9a5238a9c6c33d kongxinwei        2015-05-20  482  {
9a5238a9c6c33d kongxinwei        2015-05-20 @483  	int ret, i;
68a306cc839718 Daniel Lezcano    2022-10-03 @484  	struct thermal_trip trip;
9a5238a9c6c33d kongxinwei        2015-05-20  485  
5ee7811e9afa4f Daniel Lezcano    2022-08-05  486  	sensor->tzd = devm_thermal_of_zone_register(&pdev->dev,
49e778d1c750d5 Daniel Lezcano    2018-09-25  487  						    sensor->id, sensor,
81d7cb7946f03d Daniel Lezcano    2017-10-19  488  						    &hisi_of_thermal_ops);
9a5238a9c6c33d kongxinwei        2015-05-20  489  	if (IS_ERR(sensor->tzd)) {
9a5238a9c6c33d kongxinwei        2015-05-20  490  		ret = PTR_ERR(sensor->tzd);
439dc96811739a Leo Yan           2016-03-29  491  		sensor->tzd = NULL;
9a5238a9c6c33d kongxinwei        2015-05-20  492  		dev_err(&pdev->dev, "failed to register sensor id %d: %d\n",
9a5238a9c6c33d kongxinwei        2015-05-20  493  			sensor->id, ret);
9a5238a9c6c33d kongxinwei        2015-05-20  494  		return ret;
9a5238a9c6c33d kongxinwei        2015-05-20  495  	}
9a5238a9c6c33d kongxinwei        2015-05-20  496  
09a7303648169c Rafael J. Wysocki 2024-07-29  497  	thermal_zone_for_each_trip(sensor->tzd, hisi_trip_walk_cb, sensor);
9a5238a9c6c33d kongxinwei        2015-05-20  498  
9a5238a9c6c33d kongxinwei        2015-05-20  499  	return 0;
9a5238a9c6c33d kongxinwei        2015-05-20  500  }
9a5238a9c6c33d kongxinwei        2015-05-20  501  

:::::: The code at line 484 was first introduced by commit
:::::: 68a306cc839718d1875b46ebf73c25c8fa7f704a thermal/drivers/hisi: Use generic thermal_zone_get_trip() function

:::::: TO: Daniel Lezcano <daniel.lezcano@linaro.org>
:::::: CC: Daniel Lezcano <daniel.lezcano@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

