Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F3E2635F54
	for <lists+linux-acpi@lfdr.de>; Wed, 23 Nov 2022 14:24:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237699AbiKWNXz (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 23 Nov 2022 08:23:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237827AbiKWNXf (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 23 Nov 2022 08:23:35 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9819B5E9E0;
        Wed, 23 Nov 2022 05:04:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669208658; x=1700744658;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=gVy0+k2cvIs3bkI9e8x0s5+bWCHzyHimI7w22Ds6fNE=;
  b=P2GbHeZLU96ThIvEV1QUZoLL4HGn/FcIXOO6IbM9mDH9GNZODmSfoSNZ
   WVVqZ4oeq6bjFQVZ1ydGtpMLB8s7ex62V71UBsNet1+YSnfIbEZGYd2qV
   kPAy8CgSkLvbSK4Nm3ZZmfic9Bak2dRdJAlMe48tfBB74hac+k1O4aMic
   +SHSRhB1aAlPe/Vhi+NlUWPKDVtolF0MQry/prx1m0XS/M3CkFZw10VeB
   /TxVWPDXoumZ9zqZvmsYJnlBqz0TDyhCQMo5RbWeWQFqZ8UgJrAtcyVI9
   /A10cV2whDwBupsrHGRCBL8M31pOsdmzssXzagRVAKp/0QscNtJIccgrN
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="297421645"
X-IronPort-AV: E=Sophos;i="5.96,187,1665471600"; 
   d="scan'208";a="297421645"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2022 05:04:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="747783081"
X-IronPort-AV: E=Sophos;i="5.96,187,1665471600"; 
   d="scan'208";a="747783081"
Received: from lkp-server01.sh.intel.com (HELO 64a2d449c951) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 23 Nov 2022 05:04:16 -0800
Received: from kbuild by 64a2d449c951 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oxpQF-0002kp-2T;
        Wed, 23 Nov 2022 13:04:15 +0000
Date:   Wed, 23 Nov 2022 21:04:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 611bfa6eb1e00510c7f77ac569929d470984366a
Message-ID: <637e1a44.N+12p42AZlppk/ie%lkp@intel.com>
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
branch HEAD: 611bfa6eb1e00510c7f77ac569929d470984366a  Merge branches 'thermal-core' and 'thermal-intel' into linux-next

elapsed time: 990m

configs tested: 87
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
s390                                defconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
s390                             allyesconfig
sh                               allmodconfig
i386                              allnoconfig
arc                               allnoconfig
alpha                             allnoconfig
arm                               allnoconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
i386                 randconfig-a011-20221121
i386                 randconfig-a013-20221121
i386                 randconfig-a012-20221121
i386                 randconfig-a014-20221121
i386                 randconfig-a016-20221121
i386                 randconfig-a015-20221121
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                               rhel-8.3
x86_64                           allyesconfig
x86_64               randconfig-a012-20221121
x86_64               randconfig-a011-20221121
x86_64               randconfig-a013-20221121
x86_64               randconfig-a014-20221121
i386                                defconfig
x86_64               randconfig-a016-20221121
x86_64               randconfig-a015-20221121
ia64                             allmodconfig
m68k                             allyesconfig
alpha                            allyesconfig
arc                  randconfig-r043-20221121
arc                              allyesconfig
riscv                randconfig-r042-20221121
s390                 randconfig-r044-20221121
i386                             allyesconfig
arm                          simpad_defconfig
powerpc                  iss476-smp_defconfig
sh                             espt_defconfig
arc                    vdk_hs38_smp_defconfig
x86_64                            allnoconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
m68k                             allmodconfig
arm                                 defconfig
arc                  randconfig-r043-20221120
arm64                            allyesconfig
arm                              allyesconfig
i386                          randconfig-c001
powerpc                 mpc837x_mds_defconfig
sh                         microdev_defconfig
arm                           sunxi_defconfig
sh                           se7780_defconfig
sh                         ap325rxa_defconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func

clang tested configs:
hexagon              randconfig-r041-20221121
x86_64               randconfig-a004-20221121
hexagon              randconfig-r045-20221121
i386                 randconfig-a001-20221121
x86_64               randconfig-a001-20221121
i386                 randconfig-a003-20221121
i386                 randconfig-a002-20221121
x86_64               randconfig-a003-20221121
x86_64               randconfig-a002-20221121
x86_64               randconfig-a005-20221121
x86_64               randconfig-a006-20221121
i386                 randconfig-a004-20221121
i386                 randconfig-a005-20221121
i386                 randconfig-a006-20221121
powerpc                 mpc832x_rdb_defconfig
mips                     cu1000-neo_defconfig
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
powerpc                     tqm5200_defconfig
powerpc                        fsp2_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
