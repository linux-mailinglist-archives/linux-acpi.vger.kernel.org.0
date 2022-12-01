Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C369F63F011
	for <lists+linux-acpi@lfdr.de>; Thu,  1 Dec 2022 13:01:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbiLAMBa (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 1 Dec 2022 07:01:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbiLAMB2 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 1 Dec 2022 07:01:28 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9B889793E;
        Thu,  1 Dec 2022 04:01:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669896087; x=1701432087;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=GfIiJBr3rgkLbVVlt2Amfmbman0nvV3Uioq9A1ZnpGY=;
  b=WT6rOO29aEDFJxED3uQWX64HMsR9erYroSRjv5VNh+9zpFGtiKhLnouA
   ZQ0xeKRsDNxz31MyOm+LM0gBYqRcgvnYQ98U1+UV+2km+zG1CaEYzM/Hz
   x3Hl1FB98www6IP6hwxyJU98ZBhvvsoKhVhCI3VuXcajt9cuLP/iZITXZ
   iqBVv7sqUQ8lnwiV5Lo7J0t/tODhdxv2il8/2p8z1n4m3kHfESc1ivaKW
   /M1+f76L7IFhhAhAjQmOvW+yee0LQZffzHZJHD4NTCCOAXnfB31iio1Ei
   8hurXfbVLB/kWj8foRS06+y9tw8Ry3smdEG9LDkfnmt9EFb7I8tZDcikU
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="299034181"
X-IronPort-AV: E=Sophos;i="5.96,209,1665471600"; 
   d="scan'208";a="299034181"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2022 04:01:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="644617684"
X-IronPort-AV: E=Sophos;i="5.96,209,1665471600"; 
   d="scan'208";a="644617684"
Received: from lkp-server01.sh.intel.com (HELO 64a2d449c951) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 01 Dec 2022 04:01:24 -0800
Received: from kbuild by 64a2d449c951 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1p0iFn-000CWX-1d;
        Thu, 01 Dec 2022 12:01:23 +0000
Date:   Thu, 01 Dec 2022 20:01:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS WITH WARNING
 3a412a9c62334b8d9327b3759548d22cca3effe3
Message-ID: <6388978a.9d+LHb1cp7RaFrtk%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 3a412a9c62334b8d9327b3759548d22cca3effe3  Merge branch 'pm-cpufreq' into bleeding-edge

Warning reports:

https://lore.kernel.org/oe-kbuild-all/202212011201.ZdXxc4K3-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202212011819.GxYjfhWJ-lkp@intel.com

Warning: (recently discovered and may have been fixed)

include/linux/kern_levels.h:5:25: warning: format '%llx' expects argument of type 'long long unsigned int', but argument 2 has type 'unsigned int' [-Wformat=]
kernel/power/snapshot.c:2267:7: warning: format specifies type 'unsigned long long' but the argument has type 'phys_addr_t' (aka 'unsigned int') [-Wformat]

Warning ids grouped by kconfigs:

gcc_recent_errors
|-- arm-allyesconfig
|   `-- include-linux-kern_levels.h:warning:format-llx-expects-argument-of-type-long-long-unsigned-int-but-argument-has-type-unsigned-int
`-- mips-allyesconfig
    `-- include-linux-kern_levels.h:warning:format-llx-expects-argument-of-type-long-long-unsigned-int-but-argument-has-type-unsigned-int
clang_recent_errors
|-- i386-randconfig-a011-20221128
|   `-- kernel-power-snapshot.c:warning:format-specifies-type-unsigned-long-long-but-the-argument-has-type-phys_addr_t-(aka-unsigned-int-)
`-- powerpc-randconfig-r013-20221128
    `-- kernel-power-snapshot.c:warning:format-specifies-type-unsigned-long-long-but-the-argument-has-type-phys_addr_t-(aka-unsigned-int-)

elapsed time: 838m

configs tested: 62
configs skipped: 2

gcc tested configs:
arm                                 defconfig
arc                               allnoconfig
alpha                             allnoconfig
i386                              allnoconfig
arm                               allnoconfig
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
x86_64                           rhel-8.3-syz
s390                                defconfig
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
um                           x86_64_defconfig
um                             i386_defconfig
s390                             allyesconfig
powerpc                           allnoconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
sh                               allmodconfig
mips                             allyesconfig
powerpc                          allmodconfig
x86_64                               rhel-8.3
arc                  randconfig-r043-20221128
ia64                             allmodconfig
x86_64                           allyesconfig
i386                 randconfig-a002-20221128
i386                 randconfig-a003-20221128
i386                 randconfig-a001-20221128
x86_64                        randconfig-a015
x86_64                        randconfig-a013
i386                 randconfig-a005-20221128
x86_64                        randconfig-a011
i386                 randconfig-a004-20221128
i386                 randconfig-a006-20221128
i386                                defconfig
x86_64               randconfig-a002-20221128
x86_64               randconfig-a001-20221128
x86_64               randconfig-a003-20221128
x86_64               randconfig-a004-20221128
x86_64               randconfig-a005-20221128
i386                             allyesconfig
x86_64               randconfig-a006-20221128
arm64                            allyesconfig
arm                              allyesconfig

clang tested configs:
hexagon              randconfig-r045-20221128
riscv                randconfig-r042-20221128
hexagon              randconfig-r041-20221128
s390                 randconfig-r044-20221128
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64                        randconfig-a012
i386                 randconfig-a012-20221128
i386                 randconfig-a011-20221128
i386                 randconfig-a013-20221128
i386                 randconfig-a015-20221128
i386                 randconfig-a014-20221128
i386                 randconfig-a016-20221128

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
