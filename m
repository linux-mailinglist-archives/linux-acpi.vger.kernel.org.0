Return-Path: <linux-acpi+bounces-281-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 307347B2AFA
	for <lists+linux-acpi@lfdr.de>; Fri, 29 Sep 2023 06:31:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 1D4C61C20AC5
	for <lists+linux-acpi@lfdr.de>; Fri, 29 Sep 2023 04:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB17B881F
	for <lists+linux-acpi@lfdr.de>; Fri, 29 Sep 2023 04:31:01 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89298487
	for <linux-acpi@vger.kernel.org>; Fri, 29 Sep 2023 04:21:13 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32F1019F;
	Thu, 28 Sep 2023 21:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695961272; x=1727497272;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=3r2YmGaTrVcLyvB49o1L2XCBv1bFcjeaULvVJT0mEaA=;
  b=UECBjVoKmOK3I1Wh3PnqSIHf2IhhozgikzRFn+SqcWDZ8UJ+xHI+h5Uh
   v4YdWYU/T6Pzz4FOLfKzvKfUMYSbm0TBSkNwxFhvD+ESGNqsLXVZbRZeY
   pRq0Rc5UvOGpZUsezk2mH0iZ8nsC2sUOL8qrU1PsxCQr0csuPT1NWmKmK
   jGwVtCIT47nJUkT7ZpjGJ2KBzaYTn+Z5kKr2iwKpHAjWn9lZsL81H0k4A
   002Xv7jClZL1gNpHZQ5JKueUj3xVDgsARgjz082SiUdNgdu92b9vMg9HD
   Ensw/5yPw3S8J5K2F4HhrUkmsndzmvbu2B/xQpH0kWa9IVSU3wBMAyGiL
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="367291641"
X-IronPort-AV: E=Sophos;i="6.03,186,1694761200"; 
   d="scan'208";a="367291641"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 21:21:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="743329468"
X-IronPort-AV: E=Sophos;i="6.03,186,1694761200"; 
   d="scan'208";a="743329468"
Received: from lkp-server02.sh.intel.com (HELO c3b01524d57c) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 28 Sep 2023 21:21:09 -0700
Received: from kbuild by c3b01524d57c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qm4zz-0002Sk-1z;
	Fri, 29 Sep 2023 04:21:07 +0000
Date: Fri, 29 Sep 2023 12:21:05 +0800
From: kernel test robot <lkp@intel.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: oe-kbuild-all@lists.linux.dev, linux-acpi@vger.kernel.org,
	devel@acpica.org, linux-pm@vger.kernel.org,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [rafael-pm:bleeding-edge 48/94]
 drivers/thermal/amlogic_thermal.c:303:16: error: void value not ignored as
 it ought to be
Message-ID: <202309291214.Hjn3gJ94-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
	SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
head:   2cff74feed4a2a3a1c220e0ee2838b85b08d4999
commit: 88af8b66ffedcad8c5a1522f6a9c02bf8129a951 [48/94] thermal: amlogic: Convert to platform remove callback returning void
config: arm-randconfig-004-20230929 (https://download.01.org/0day-ci/archive/20230929/202309291214.Hjn3gJ94-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230929/202309291214.Hjn3gJ94-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309291214.Hjn3gJ94-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/thermal/amlogic_thermal.c: In function 'amlogic_thermal_suspend':
>> drivers/thermal/amlogic_thermal.c:303:16: error: void value not ignored as it ought to be
     303 |         return amlogic_thermal_disable(data);
         |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +303 drivers/thermal/amlogic_thermal.c

421eda108e6c63a Guillaume La Roque 2019-10-04  298  
421eda108e6c63a Guillaume La Roque 2019-10-04  299  static int __maybe_unused amlogic_thermal_suspend(struct device *dev)
421eda108e6c63a Guillaume La Roque 2019-10-04  300  {
421eda108e6c63a Guillaume La Roque 2019-10-04  301  	struct amlogic_thermal *data = dev_get_drvdata(dev);
421eda108e6c63a Guillaume La Roque 2019-10-04  302  
421eda108e6c63a Guillaume La Roque 2019-10-04 @303  	return amlogic_thermal_disable(data);
421eda108e6c63a Guillaume La Roque 2019-10-04  304  }
421eda108e6c63a Guillaume La Roque 2019-10-04  305  

:::::: The code at line 303 was first introduced by commit
:::::: 421eda108e6c63a72feb178c441bb769d4076836 thermal: amlogic: Add thermal driver to support G12 SoCs

:::::: TO: Guillaume La Roque <glaroque@baylibre.com>
:::::: CC: Daniel Lezcano <daniel.lezcano@linaro.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

