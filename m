Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3E10620A03
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Nov 2022 08:21:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233364AbiKHHVu (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 8 Nov 2022 02:21:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232494AbiKHHVt (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 8 Nov 2022 02:21:49 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4005A2C65D;
        Mon,  7 Nov 2022 23:21:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667892108; x=1699428108;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=ozmWKOpbtMluBcUwPcsPX3yBBT8fWQ8JP9v0SLL3JiI=;
  b=lBHfddtlJ+XyZl9BDAZeoBBMRcryyBqN4cdt4uzn00gHyyIKtkL7jw3B
   0diUkH84YQ+0P3s+72ixx4A9scc/SAccrkD6PydSn/Ml3PNG7Nw2MmCli
   1t15zroURGgrIZVuq6t8LnoEL5yB6xFcJl+aSw6Q/QuxdGIjzAT7CIROf
   +zU4Gjj00Ux0XRWa4jfRDZBo+al8flk5zQ+98/TZxxCPRELnSYdNv2lGr
   GGR2fsW7wbr4Tvrdnqaezmw11Jgjs5SLBYl/7HAncu7va9z+8e7VtzRc4
   1lvAh3XlrCJVFF8WXdmD1+PdY6g4iFxEDHwsPIIE6Ck8SguxWlM9d4L8d
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="298141956"
X-IronPort-AV: E=Sophos;i="5.96,147,1665471600"; 
   d="scan'208";a="298141956"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2022 23:21:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="587275578"
X-IronPort-AV: E=Sophos;i="5.96,147,1665471600"; 
   d="scan'208";a="587275578"
Received: from lkp-server01.sh.intel.com (HELO e783503266e8) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 07 Nov 2022 23:21:46 -0800
Received: from kbuild by e783503266e8 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1osIvZ-0000Ac-1i;
        Tue, 08 Nov 2022 07:21:45 +0000
Date:   Tue, 08 Nov 2022 12:43:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 ef614051a953a2de0c3b962e6baf3637c5a9d63a
Message-ID: <6369de85.BAsgluCtUoYpKBUD%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: ef614051a953a2de0c3b962e6baf3637c5a9d63a  Merge branches 'thermal-core' and 'thermal-intel' into linux-next

elapsed time: 721m

configs tested: 107
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
s390                                defconfig
s390                             allmodconfig
arc                                 defconfig
alpha                               defconfig
s390                             allyesconfig
arc                               allnoconfig
alpha                             allnoconfig
um                           x86_64_defconfig
um                             i386_defconfig
arc                  randconfig-r043-20221107
powerpc                           allnoconfig
powerpc                          allmodconfig
mips                             allyesconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
sh                               allmodconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
m68k                             allyesconfig
x86_64                              defconfig
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                               rhel-8.3
x86_64                           allyesconfig
x86_64               randconfig-a001-20221107
x86_64               randconfig-a003-20221107
x86_64               randconfig-a002-20221107
x86_64               randconfig-a005-20221107
x86_64               randconfig-a004-20221107
i386                                defconfig
x86_64               randconfig-a006-20221107
arm64                            allyesconfig
arm                                 defconfig
ia64                             allmodconfig
i386                 randconfig-c001-20221107
powerpc                      bamboo_defconfig
sh                           se7721_defconfig
sh                           se7705_defconfig
sh                     sh7710voipgw_defconfig
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
powerpc                        warp_defconfig
microblaze                          defconfig
m68k                        stmark2_defconfig
powerpc                      pasemi_defconfig
i386                             allyesconfig
arm                              allyesconfig
i386                 randconfig-a001-20221107
i386                 randconfig-a006-20221107
i386                 randconfig-a003-20221107
i386                 randconfig-a002-20221107
i386                 randconfig-a005-20221107
i386                 randconfig-a004-20221107
powerpc                    adder875_defconfig
parisc                              defconfig
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
arm                            hisi_defconfig
mips                        bcm47xx_defconfig
sh                        edosk7760_defconfig
m68k                         apollo_defconfig
sh                            shmin_defconfig
riscv                            allmodconfig
powerpc                       holly_defconfig
sparc                            allyesconfig
powerpc                      ppc6xx_defconfig
xtensa                    smp_lx200_defconfig
xtensa                              defconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func

clang tested configs:
hexagon              randconfig-r041-20221107
s390                 randconfig-r044-20221107
riscv                randconfig-r042-20221107
hexagon              randconfig-r045-20221107
x86_64               randconfig-a014-20221107
x86_64               randconfig-a015-20221107
x86_64               randconfig-a013-20221107
x86_64               randconfig-a012-20221107
x86_64               randconfig-a011-20221107
x86_64               randconfig-a016-20221107
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
mips                      malta_kvm_defconfig
powerpc                     mpc512x_defconfig
hexagon              randconfig-r041-20221108
hexagon              randconfig-r045-20221108
i386                 randconfig-a013-20221107
i386                 randconfig-a011-20221107
arm                       netwinder_defconfig
mips                   sb1250_swarm_defconfig
powerpc                 mpc8313_rdb_defconfig
powerpc                    gamecube_defconfig
i386                 randconfig-a015-20221107
i386                 randconfig-a016-20221107
i386                 randconfig-a014-20221107
i386                 randconfig-a012-20221107
i386                          randconfig-a002
i386                          randconfig-a004
x86_64               randconfig-k001-20221107
i386                          randconfig-a006
x86_64                        randconfig-k001

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
