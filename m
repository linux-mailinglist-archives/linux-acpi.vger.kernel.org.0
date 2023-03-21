Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08E716C3DA0
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Mar 2023 23:20:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbjCUWUB (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 21 Mar 2023 18:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbjCUWUA (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 21 Mar 2023 18:20:00 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9FB01E9CA;
        Tue, 21 Mar 2023 15:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679437199; x=1710973199;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=KkKXJs01d6aNUn4ec8jm1yRJxeI+Isjz4/G3GmiRxUM=;
  b=kZtJcxdm18TXS6rmU4n/5GWIdzjfzmK/KoYgiwpIhbYsYYuCnjIOIm1t
   0BCo94dJ5Acl4+sm60LBQ0ED34jBxWI98irmjUiH9sGRPy3xQmfBejYrv
   nw16vf9CUjve6r5jEDkuTfnW8FhNuU4nCIGoMLLYBsOTgdo/ZjZwbjXsu
   FobYpIJs7bl0681taqWIDJh5KCauJCybEPxpliUzJaWEoXFT1n4avhmMq
   +Fm0SY9yTSW+8GDydEZh768VOg3Uf1TjMRNqlhzWXqukaDUuTn5KT2GsO
   n9xBuYdIeZ659ILFVSyUKU4U0Sy3O8mDQsWQaZqmSCZS4u5jh9P5LcDVG
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="327449632"
X-IronPort-AV: E=Sophos;i="5.98,279,1673942400"; 
   d="scan'208";a="327449632"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2023 15:19:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="714166500"
X-IronPort-AV: E=Sophos;i="5.98,279,1673942400"; 
   d="scan'208";a="714166500"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 21 Mar 2023 15:19:57 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pekKh-000CTa-2u;
        Tue, 21 Mar 2023 22:19:56 +0000
Date:   Wed, 22 Mar 2023 06:19:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-acpi@vger.kernel.org, devel@acpica.org,
        linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>
Subject: [rafael-pm:bleeding-edge 43/45]
 drivers/thermal/thermal_sysfs.c:717:6: warning: variable 'ret' is used
 uninitialized whenever 'if' condition is true
Message-ID: <202303220652.Yhopf8F0-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
head:   98fe6903f79cffbb0f271369f62f4e5fea0e978c
commit: 9b3fc1c6ba14f12e819e9d44c72013a1da58c0d9 [43/45] thermal: core: Introduce thermal_cooling_device_update()
config: i386-randconfig-a001-20230320 (https://download.01.org/0day-ci/archive/20230322/202303220652.Yhopf8F0-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/commit/?id=9b3fc1c6ba14f12e819e9d44c72013a1da58c0d9
        git remote add rafael-pm https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
        git fetch --no-tags rafael-pm bleeding-edge
        git checkout 9b3fc1c6ba14f12e819e9d44c72013a1da58c0d9
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/thermal/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303220652.Yhopf8F0-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/thermal/thermal_sysfs.c:717:6: warning: variable 'ret' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
           if (!stats)
               ^~~~~~
   drivers/thermal/thermal_sysfs.c:727:9: note: uninitialized use occurs here
           return ret;
                  ^~~
   drivers/thermal/thermal_sysfs.c:717:2: note: remove the 'if' if its condition is always false
           if (!stats)
           ^~~~~~~~~~~
   drivers/thermal/thermal_sysfs.c:712:9: note: initialize the variable 'ret' to silence this warning
           int ret;
                  ^
                   = 0
   1 warning generated.


vim +717 drivers/thermal/thermal_sysfs.c

   706	
   707	static ssize_t total_trans_show(struct device *dev,
   708					struct device_attribute *attr, char *buf)
   709	{
   710		struct thermal_cooling_device *cdev = to_cooling_device(dev);
   711		struct cooling_dev_stats *stats;
   712		int ret;
   713	
   714		mutex_lock(&cdev->lock);
   715	
   716		stats = cdev->stats;
 > 717		if (!stats)
   718			goto unlock;
   719	
   720		spin_lock(&stats->lock);
   721		ret = sprintf(buf, "%u\n", stats->total_trans);
   722		spin_unlock(&stats->lock);
   723	
   724	unlock:
   725		mutex_unlock(&cdev->lock);
   726	
   727		return ret;
   728	}
   729	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
