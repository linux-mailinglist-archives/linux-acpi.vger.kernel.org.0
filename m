Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C99E76BD45
	for <lists+linux-acpi@lfdr.de>; Tue,  1 Aug 2023 21:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231851AbjHATFs (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 1 Aug 2023 15:05:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232130AbjHATFo (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 1 Aug 2023 15:05:44 -0400
Received: from mgamail.intel.com (unknown [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F8C426AA;
        Tue,  1 Aug 2023 12:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690916742; x=1722452742;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=bmmv7g91iuvGMRkGYqWBD/4SO1ZP67D/MvMKTH62ssk=;
  b=fcV0wRgYFKoMAzgfwI23V3SFExISunjVgZC2BGp4Tpmo/ybW2NXm7mRe
   W6+7XA+s28c46EIe+oxNrtcQNEhbACg0AGBafQ0bND/wccSdCKtcow7dW
   fKxF8hxA3eXfOLpLEUsgfPD1/+FS/GcEwYgWa1r64fIapqvgYw1djnqxK
   7Cvy+VVolpiGedoYTTz3xd7pZNnetR9OEMJIZcvw/+MlO8Xrtq89B6yJp
   qo/Skd4FMfltgjwYZM+QVCw3l1m7L2iK8hoSqXML9jHzv3joW6u2OvROn
   GjgAa75hcPBGkMR2BHAocAZaaiUo6Abrw8iABI4xxxmWBET87AtG3l50c
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="372120141"
X-IronPort-AV: E=Sophos;i="6.01,248,1684825200"; 
   d="scan'208";a="372120141"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2023 12:05:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="818905991"
X-IronPort-AV: E=Sophos;i="6.01,248,1684825200"; 
   d="scan'208";a="818905991"
Received: from lkp-server01.sh.intel.com (HELO d1ccc7e87e8f) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 01 Aug 2023 12:05:39 -0700
Received: from kbuild by d1ccc7e87e8f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qQugd-0000XX-0P;
        Tue, 01 Aug 2023 19:05:39 +0000
Date:   Wed, 2 Aug 2023 03:05:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     oe-kbuild-all@lists.linux.dev, linux-acpi@vger.kernel.org,
        devel@acpica.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge 72/86] drivers/acpi/thermal.c:1028:32:
 warning: variable 'result' set but not used
Message-ID: <202308020253.WHEHp60K-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
head:   57fb4aeb308cdc2169b440c112bcbbbbdc7b6cc5
commit: dabc621a311007d78bfcf60f8125c5e8c33ded7b [72/86] ACPI: thermal: Drop enabled flag from struct acpi_thermal_active
config: x86_64-defconfig (https://download.01.org/0day-ci/archive/20230802/202308020253.WHEHp60K-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230802/202308020253.WHEHp60K-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308020253.WHEHp60K-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/acpi/thermal.c: In function 'acpi_thermal_resume':
>> drivers/acpi/thermal.c:1028:32: warning: variable 'result' set but not used [-Wunused-but-set-variable]
    1028 |         int i, j, power_state, result;
         |                                ^~~~~~


vim +/result +1028 drivers/acpi/thermal.c

a59ffb2062df3a Aaron Lu            2014-03-04  1024  
167cffb646aa4a Rafael J. Wysocki   2012-06-27  1025  static int acpi_thermal_resume(struct device *dev)
74ce1468128e29 Konstantin Karasyov 2006-05-08  1026  {
167cffb646aa4a Rafael J. Wysocki   2012-06-27  1027  	struct acpi_thermal *tz;
b1028c545ced13 Konstantin Karasyov 2007-02-16 @1028  	int i, j, power_state, result;
b1028c545ced13 Konstantin Karasyov 2007-02-16  1029  
167cffb646aa4a Rafael J. Wysocki   2012-06-27  1030  	if (!dev)
d550d98d331737 Patrick Mochel      2006-06-27  1031  		return -EINVAL;
74ce1468128e29 Konstantin Karasyov 2006-05-08  1032  
167cffb646aa4a Rafael J. Wysocki   2012-06-27  1033  	tz = acpi_driver_data(to_acpi_device(dev));
167cffb646aa4a Rafael J. Wysocki   2012-06-27  1034  	if (!tz)
167cffb646aa4a Rafael J. Wysocki   2012-06-27  1035  		return -EINVAL;
74ce1468128e29 Konstantin Karasyov 2006-05-08  1036  
bed936f7eab946 Konstantin Karasyov 2006-07-10  1037  	for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE; i++) {
7266c88cbaa3de Rafael J. Wysocki   2023-06-04  1038  		if (!tz->trips.active[i].valid)
b1028c545ced13 Konstantin Karasyov 2007-02-16  1039  			break;
52ce50498c6f43 Rafael J. Wysocki   2022-10-04  1040  
b1028c545ced13 Konstantin Karasyov 2007-02-16  1041  		for (j = 0; j < tz->trips.active[i].devices.count; j++) {
488a76c5260619 Rafael J. Wysocki   2010-11-25  1042  			result = acpi_bus_update_power(
488a76c5260619 Rafael J. Wysocki   2010-11-25  1043  					tz->trips.active[i].devices.handles[j],
488a76c5260619 Rafael J. Wysocki   2010-11-25  1044  					&power_state);
bed936f7eab946 Konstantin Karasyov 2006-07-10  1045  		}
bed936f7eab946 Konstantin Karasyov 2006-07-10  1046  	}
bed936f7eab946 Konstantin Karasyov 2006-07-10  1047  
81b704d3e4674e Rafael J. Wysocki   2021-01-14  1048  	acpi_queue_thermal_check(tz);
74ce1468128e29 Konstantin Karasyov 2006-05-08  1049  
74ce1468128e29 Konstantin Karasyov 2006-05-08  1050  	return AE_OK;
74ce1468128e29 Konstantin Karasyov 2006-05-08  1051  }
607d265fc1ab06 Rafael J. Wysocki   2023-06-04  1052  #else
607d265fc1ab06 Rafael J. Wysocki   2023-06-04  1053  #define acpi_thermal_suspend	NULL
607d265fc1ab06 Rafael J. Wysocki   2023-06-04  1054  #define acpi_thermal_resume	NULL
9069240480e24a Rafael J. Wysocki   2012-08-09  1055  #endif
607d265fc1ab06 Rafael J. Wysocki   2023-06-04  1056  static SIMPLE_DEV_PM_OPS(acpi_thermal_pm, acpi_thermal_suspend, acpi_thermal_resume);
607d265fc1ab06 Rafael J. Wysocki   2023-06-04  1057  

:::::: The code at line 1028 was first introduced by commit
:::::: b1028c545ced13590dd9a9a8086543aef26c7187 ACPI: fix fan after resume from S3

:::::: TO: Konstantin Karasyov <konstantin.a.karasyov@intel.com>
:::::: CC: Len Brown <len.brown@intel.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
