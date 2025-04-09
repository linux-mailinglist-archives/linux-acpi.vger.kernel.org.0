Return-Path: <linux-acpi+bounces-12929-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B54A83282
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Apr 2025 22:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E79C01B63E81
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Apr 2025 20:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C4ED233718;
	Wed,  9 Apr 2025 20:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nen5rwmR"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336C121A44D;
	Wed,  9 Apr 2025 20:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744231079; cv=none; b=newB6XfVldrUlc+ZLF9nx5z6tCECx66/Ft4TpO3rH1tlMv3SGmHVVb4VqJdJNM8ppinWnrS0T49B//y8r7zDzF7NU6wMjZ5TH3JO2goUz3tsaZHQQDyIE/YBaCqpaUoLgKkggIWJLAOQHJwLmuXsOHBJ/PHaDzUUk4M+OUdk+B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744231079; c=relaxed/simple;
	bh=CAXSpAZiU5+MxLAENDKgnjCho9fYHTnR7g++cHgS9+8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=dUAmNPlofSQpQxRqaPztfQs3OQdsJ+yaAEhKQhnzvRSjz58gXeZeCQJBuE3LKRao3hEjWkHRDQuD0J/7D9tzHBbcsZmya4/CAd/Rr6XHcdJ+gnV0hQowDRph1NOcsPVGT5Q960QCHbeNEvaWjwwKLSFurD9bRfGOIoEwNIarQqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Nen5rwmR; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744231076; x=1775767076;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=CAXSpAZiU5+MxLAENDKgnjCho9fYHTnR7g++cHgS9+8=;
  b=Nen5rwmRJtbq+0g20VUUia7XoQ2CquEKHqF4Y1FJyFxna8I9+LWB+m45
   nZ9oD2e0/CdqhXTB3vcEuJVOPf7zumEOY0QKwh641U9mM/YdXDQtHR7hJ
   yB/EiNyxSqLt4hL6mOsD4L87r1B2osqX7QVQgPdTbOQHVeXPDn5FAExmQ
   bUicv2Lzom35d1QcXRDMttu8kJGKaTvUYDFCIkPxuPkNfXf0lNwESAfs7
   hlVuDmbhkoRTkChuvBaG9Px948RbtSdHPhP3txSGzwO6s6IiDl+IEyho1
   HkZJasNlDsWkDWOSDZAtR1oL8sLNFXuGyM0hDeCwKFNDD89AvI0KSoEwt
   A==;
X-CSE-ConnectionGUID: kZ6bm1opT1uFaGs1pZPBoQ==
X-CSE-MsgGUID: J95eXg7oRByKh/2sQc/cYw==
X-IronPort-AV: E=McAfee;i="6700,10204,11399"; a="45440845"
X-IronPort-AV: E=Sophos;i="6.15,201,1739865600"; 
   d="scan'208";a="45440845"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 13:37:53 -0700
X-CSE-ConnectionGUID: fFAD0BZaRO2bCpUgFFRSjQ==
X-CSE-MsgGUID: tiNd9zcCTiO9agSiYdASag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,201,1739865600"; 
   d="scan'208";a="132829360"
Received: from lkp-server01.sh.intel.com (HELO b207828170a5) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 09 Apr 2025 13:37:51 -0700
Received: from kbuild by b207828170a5 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u2cBB-0009I7-0X;
	Wed, 09 Apr 2025 20:37:49 +0000
Date: Thu, 10 Apr 2025 04:36:55 +0800
From: kernel test robot <lkp@intel.com>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-acpi@vger.kernel.org, devel@acpica.org,
	linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [rafael-pm:bleeding-edge 46/52]
 drivers/pinctrl/pinctrl-amd.c:1213:26: error: use of undeclared identifier
 'pinctrl_amd_s2idle_dev_ops'
Message-ID: <202504100420.88UPkUTU-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
head:   089d4e79e2c932faef79e0061cb874000f755009
commit: 179db1909c5c4b5300cce626507b0f843f7d2cc2 [46/52] pinctrl: amd: Add an LPS0 check() callback
config: x86_64-buildonly-randconfig-001-20250409 (https://download.01.org/0day-ci/archive/20250410/202504100420.88UPkUTU-lkp@intel.com/config)
compiler: clang version 20.1.2 (https://github.com/llvm/llvm-project 58df0ef89dd64126512e4ee27b4ac3fd8ddf6247)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250410/202504100420.88UPkUTU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202504100420.88UPkUTU-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/pinctrl/pinctrl-amd.c:1213:26: error: use of undeclared identifier 'pinctrl_amd_s2idle_dev_ops'
    1213 |         acpi_register_lps0_dev(&pinctrl_amd_s2idle_dev_ops);
         |                                 ^
   drivers/pinctrl/pinctrl-amd.c:1234:28: error: use of undeclared identifier 'pinctrl_amd_s2idle_dev_ops'
    1234 |         acpi_unregister_lps0_dev(&pinctrl_amd_s2idle_dev_ops);
         |                                   ^
   2 errors generated.


vim +/pinctrl_amd_s2idle_dev_ops +1213 drivers/pinctrl/pinctrl-amd.c

  1153	
  1154		gpio_dev->pdev = pdev;
  1155		gpio_dev->gc.get_direction	= amd_gpio_get_direction;
  1156		gpio_dev->gc.direction_input	= amd_gpio_direction_input;
  1157		gpio_dev->gc.direction_output	= amd_gpio_direction_output;
  1158		gpio_dev->gc.get			= amd_gpio_get_value;
  1159		gpio_dev->gc.set			= amd_gpio_set_value;
  1160		gpio_dev->gc.set_config		= amd_gpio_set_config;
  1161		gpio_dev->gc.dbg_show		= amd_gpio_dbg_show;
  1162	
  1163		gpio_dev->gc.base		= -1;
  1164		gpio_dev->gc.label			= pdev->name;
  1165		gpio_dev->gc.owner			= THIS_MODULE;
  1166		gpio_dev->gc.parent			= &pdev->dev;
  1167		gpio_dev->gc.ngpio			= resource_size(res) / 4;
  1168	
  1169		gpio_dev->hwbank_num = gpio_dev->gc.ngpio / 64;
  1170		gpio_dev->groups = kerncz_groups;
  1171		gpio_dev->ngroups = ARRAY_SIZE(kerncz_groups);
  1172	
  1173		amd_pinctrl_desc.name = dev_name(&pdev->dev);
  1174		amd_get_iomux_res(gpio_dev);
  1175		gpio_dev->pctrl = devm_pinctrl_register(&pdev->dev, &amd_pinctrl_desc,
  1176							gpio_dev);
  1177		if (IS_ERR(gpio_dev->pctrl)) {
  1178			dev_err(&pdev->dev, "Couldn't register pinctrl driver\n");
  1179			return PTR_ERR(gpio_dev->pctrl);
  1180		}
  1181	
  1182		/* Disable and mask interrupts */
  1183		amd_gpio_irq_init(gpio_dev);
  1184	
  1185		girq = &gpio_dev->gc.irq;
  1186		gpio_irq_chip_set_chip(girq, &amd_gpio_irqchip);
  1187		/* This will let us handle the parent IRQ in the driver */
  1188		girq->parent_handler = NULL;
  1189		girq->num_parents = 0;
  1190		girq->parents = NULL;
  1191		girq->default_type = IRQ_TYPE_NONE;
  1192		girq->handler = handle_simple_irq;
  1193	
  1194		ret = gpiochip_add_data(&gpio_dev->gc, gpio_dev);
  1195		if (ret)
  1196			return ret;
  1197	
  1198		ret = gpiochip_add_pin_range(&gpio_dev->gc, dev_name(&pdev->dev),
  1199					0, 0, gpio_dev->gc.ngpio);
  1200		if (ret) {
  1201			dev_err(&pdev->dev, "Failed to add pin range\n");
  1202			goto out2;
  1203		}
  1204	
  1205		ret = devm_request_irq(&pdev->dev, gpio_dev->irq, amd_gpio_irq_handler,
  1206				       IRQF_SHARED | IRQF_COND_ONESHOT, KBUILD_MODNAME, gpio_dev);
  1207		if (ret)
  1208			goto out2;
  1209	
  1210		platform_set_drvdata(pdev, gpio_dev);
  1211		acpi_register_wakeup_handler(gpio_dev->irq, amd_gpio_check_wake, gpio_dev);
  1212	#ifdef CONFIG_ACPI
> 1213		acpi_register_lps0_dev(&pinctrl_amd_s2idle_dev_ops);
  1214	#endif
  1215	
  1216		dev_dbg(&pdev->dev, "amd gpio driver loaded\n");
  1217		return ret;
  1218	
  1219	out2:
  1220		gpiochip_remove(&gpio_dev->gc);
  1221	
  1222		return ret;
  1223	}
  1224	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

