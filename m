Return-Path: <linux-acpi+bounces-3321-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B0DF84F8A3
	for <lists+linux-acpi@lfdr.de>; Fri,  9 Feb 2024 16:33:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9EA3EB24FFC
	for <lists+linux-acpi@lfdr.de>; Fri,  9 Feb 2024 15:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 495DE76036;
	Fri,  9 Feb 2024 15:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="azHGWNjl"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEAA66F06C;
	Fri,  9 Feb 2024 15:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707492817; cv=none; b=iczNdy8DnLImbVzMmPOnvg5pnBAIHqCzjGn4T30OoNHoy/5YnFlsz6ok4daRkaRiN5aVZwLVEhNd9MSYBLpKCOiwDHoqhjcrOYqZMkExh0GxAdmGxIbrkPlmuLC+zmLzPuH9RgLe8nvk7oGKIGAkeKTwnsDLZ0B6/jMglkRtY6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707492817; c=relaxed/simple;
	bh=/uOgL0L6lHM/X3uPQJuyG37nIHjtd74huS+zuipAY6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=PzxC1j+z4JqJo7xFNCxZ4L1CgyPeqGilaKE5EC6JCdLW9r2bvj0bZi1eb/GzDmgqNbVAtwX3FWiOvQKEixQBQL5shRJOjxWyWmG2WqCiniUZwBn2sS7PpzL70lzwQFGOY4Fez0Yr+Tlf0nFZenxu7EgktcHBMEJuw1tFZXtd/ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=azHGWNjl; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707492814; x=1739028814;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=/uOgL0L6lHM/X3uPQJuyG37nIHjtd74huS+zuipAY6Q=;
  b=azHGWNjlD1dowvcJa7reAXZh14KdaSGOENE79tip/pgDDhU9HTAQSOjl
   BwPN8sP+wuCVEB18HSkRePL9DZwRBwoLp8Fxr/vT6e46EZtQEb4fVixK8
   p3vnrPnyKBcOe0SUxFCyvYheGVAZUQ8mNXRElZXnvW7bhFCCBB6rwqH11
   d/uYN+ppKCnDtHs3MRdqWgO9VPYosWljS4ZIkGArPkYaFDSx0KA+S0zMe
   Q+cyhw0Ym0dLDW4qsxNZVK4S2wpG/Hf7HWlmk2e13rhKQ2Z03BKb6INDl
   mX+JdjA+PYZq0il9hPlM4Y8mYM5xmGRpg8xg03W+Hw6elq0mUtBGUJtl9
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10979"; a="5296851"
X-IronPort-AV: E=Sophos;i="6.05,257,1701158400"; 
   d="scan'208";a="5296851"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 07:33:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10979"; a="825170553"
X-IronPort-AV: E=Sophos;i="6.05,257,1701158400"; 
   d="scan'208";a="825170553"
Received: from lkp-server01.sh.intel.com (HELO 01f0647817ea) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 09 Feb 2024 07:33:29 -0800
Received: from kbuild by 01f0647817ea with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rYSsZ-0004pt-17;
	Fri, 09 Feb 2024 15:33:27 +0000
Date: Fri, 9 Feb 2024 23:33:09 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: oe-kbuild-all@lists.linux.dev, linux-acpi@vger.kernel.org,
	devel@acpica.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge 65/77]
 drivers/thermal/intel/intel_quark_dts_thermal.c:353:17: error: 'trips'
 undeclared
Message-ID: <202402092329.W4VIvzU0-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
head:   2bc44535ed4f6a6013ec53b505c4c381e166f0ce
commit: fdb07e113a91652cc3adf07a8e1ca7da3445f493 [65/77] thermal: intel: Set THERMAL_TRIP_WRITABLE_TEMP directly
config: i386-allmodconfig (https://download.01.org/0day-ci/archive/20240209/202402092329.W4VIvzU0-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240209/202402092329.W4VIvzU0-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402092329.W4VIvzU0-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/thermal/intel/intel_quark_dts_thermal.c: In function 'alloc_soc_dts':
>> drivers/thermal/intel/intel_quark_dts_thermal.c:353:17: error: 'trips' undeclared (first use in this function)
     353 |                 trips[QRK_DTS_ID_TP_CRITICAL].flags |= THERMAL_TRIP_WRITABLE_TEMP;
         |                 ^~~~~
   drivers/thermal/intel/intel_quark_dts_thermal.c:353:17: note: each undeclared identifier is reported only once for each function it appears in


vim +/trips +353 drivers/thermal/intel/intel_quark_dts_thermal.c

   316	
   317	static struct soc_sensor_entry *alloc_soc_dts(void)
   318	{
   319		struct soc_sensor_entry *aux_entry;
   320		int err;
   321		u32 out;
   322	
   323		aux_entry = kzalloc(sizeof(*aux_entry), GFP_KERNEL);
   324		if (!aux_entry) {
   325			err = -ENOMEM;
   326			return ERR_PTR(-ENOMEM);
   327		}
   328	
   329		/* Check if DTS register is locked */
   330		err = iosf_mbi_read(QRK_MBI_UNIT_RMU, MBI_REG_READ,
   331				    QRK_DTS_REG_OFFSET_LOCK, &out);
   332		if (err)
   333			goto err_ret;
   334	
   335		aux_entry->locked = !!(out & QRK_DTS_LOCK_BIT);
   336	
   337		/* Store DTS default state if DTS registers are not locked */
   338		if (!aux_entry->locked) {
   339			/* Store DTS default enable for restore on exit */
   340			err = iosf_mbi_read(QRK_MBI_UNIT_RMU, MBI_REG_READ,
   341					    QRK_DTS_REG_OFFSET_ENABLE,
   342					    &aux_entry->store_dts_enable);
   343			if (err)
   344				goto err_ret;
   345	
   346			/* Store DTS default PTPS register for restore on exit */
   347			err = iosf_mbi_read(QRK_MBI_UNIT_RMU, MBI_REG_READ,
   348					    QRK_DTS_REG_OFFSET_PTPS,
   349					    &aux_entry->store_ptps);
   350			if (err)
   351				goto err_ret;
   352	
 > 353			trips[QRK_DTS_ID_TP_CRITICAL].flags |= THERMAL_TRIP_WRITABLE_TEMP;
   354			trips[QRK_DTS_ID_TP_HOT].flags |= THERMAL_TRIP_WRITABLE_TEMP;
   355		}
   356	
   357		aux_entry->trips[QRK_DTS_ID_TP_CRITICAL].temperature = get_trip_temp(QRK_DTS_ID_TP_CRITICAL);
   358		aux_entry->trips[QRK_DTS_ID_TP_CRITICAL].type = THERMAL_TRIP_CRITICAL;
   359	
   360		aux_entry->trips[QRK_DTS_ID_TP_HOT].temperature = get_trip_temp(QRK_DTS_ID_TP_HOT);
   361		aux_entry->trips[QRK_DTS_ID_TP_HOT].type = THERMAL_TRIP_HOT;
   362	
   363		aux_entry->tzone = thermal_zone_device_register_with_trips("quark_dts",
   364									   aux_entry->trips,
   365									   QRK_MAX_DTS_TRIPS,
   366									   0, aux_entry,
   367									   &tzone_ops,
   368									   NULL, 0, polling_delay);
   369		if (IS_ERR(aux_entry->tzone)) {
   370			err = PTR_ERR(aux_entry->tzone);
   371			goto err_ret;
   372		}
   373	
   374		err = thermal_zone_device_enable(aux_entry->tzone);
   375		if (err)
   376			goto err_aux_status;
   377	
   378		return aux_entry;
   379	
   380	err_aux_status:
   381		thermal_zone_device_unregister(aux_entry->tzone);
   382	err_ret:
   383		kfree(aux_entry);
   384		return ERR_PTR(err);
   385	}
   386	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

