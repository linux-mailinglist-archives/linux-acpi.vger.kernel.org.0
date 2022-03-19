Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54CD54DE587
	for <lists+linux-acpi@lfdr.de>; Sat, 19 Mar 2022 04:51:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240431AbiCSDwX (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 18 Mar 2022 23:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234154AbiCSDwV (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 18 Mar 2022 23:52:21 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 639962D6569;
        Fri, 18 Mar 2022 20:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647661861; x=1679197861;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=+TmYVIGlhVXaNPcUldyOUpJF3OhtFXTt08+/fCIhGeY=;
  b=Z6OybHgO/XJiu+VSgFeJGGwMq2HSXBocE/9JvjHL+HS0p0fOnLmxUhqe
   qZkFj4eqFpHb0qckCY5gcNiFl8ASAcC1KeYECIma9rVAyUSplzcBVm6iE
   xwOcF67pVGgiUdl3GoYxgLmpZIQGBEK8O5t+BjtvER9IYREtdvsorp+Yg
   fDfLBSk7XNtH/w5Pt7dacu7BIwKF/v4UWTiMBmYnNSUgAP0ktFYUPdn/K
   2Ow6s0koHC1TjCeDSq99TCPptiKg2zC/BTFpr8VrRl5O1OW76hggloJXX
   Z/qk00Qs9n2/zkAYBY3MQhClF0Ghi+yB8gqngJvllAp/sVpQITQHa7Cci
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10290"; a="320478156"
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; 
   d="scan'208";a="320478156"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 20:51:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; 
   d="scan'208";a="542185691"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 18 Mar 2022 20:50:59 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nVQ7G-000FWT-Hj; Sat, 19 Mar 2022 03:50:58 +0000
Date:   Sat, 19 Mar 2022 11:50:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 c4869334ceaf0b0d33b2b606a68221a486d4c7d6
Message-ID: <62355312.hQxP5XF68qZlNBcI%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: c4869334ceaf0b0d33b2b606a68221a486d4c7d6  Merge branch 'pm-docs-next' into bleeding-edge

elapsed time: 817m

configs tested: 119
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm                              allmodconfig
arm                              allyesconfig
arm64                               defconfig
arm64                            allyesconfig
i386                          randconfig-c001
powerpc                      tqm8xx_defconfig
mips                            ar7_defconfig
sh                         microdev_defconfig
sh                          polaris_defconfig
arm                          exynos_defconfig
arm                          iop32x_defconfig
sh                           se7343_defconfig
mips                         tb0226_defconfig
powerpc                     ep8248e_defconfig
sh                           se7619_defconfig
ia64                             alldefconfig
powerpc                       maple_defconfig
mips                      maltasmvp_defconfig
arm                  randconfig-c002-20220318
arm                  randconfig-c002-20220317
ia64                                defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
csky                                defconfig
alpha                               defconfig
nds32                               defconfig
alpha                            allyesconfig
nios2                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
h8300                            allyesconfig
xtensa                           allyesconfig
parisc                              defconfig
s390                                defconfig
parisc64                            defconfig
s390                             allmodconfig
s390                             allyesconfig
parisc                           allyesconfig
i386                             allyesconfig
i386                              debian-10.3
i386                   debian-10.3-kselftests
i386                                defconfig
sparc                            allyesconfig
sparc                               defconfig
nds32                             allnoconfig
nios2                               defconfig
arc                              allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
powerpc                          allyesconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a002
x86_64                        randconfig-a004
i386                          randconfig-a003
i386                          randconfig-a001
i386                          randconfig-a005
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
arc                  randconfig-r043-20220318
riscv                randconfig-r042-20220317
arc                  randconfig-r043-20220317
s390                 randconfig-r044-20220317
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                                  kexec
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                    rhel-8.3-kselftests

clang tested configs:
arm                  randconfig-c002-20220318
x86_64                        randconfig-c007
s390                 randconfig-c005-20220317
s390                 randconfig-c005-20220318
arm                  randconfig-c002-20220317
mips                 randconfig-c004-20220318
mips                 randconfig-c004-20220317
riscv                randconfig-c006-20220318
powerpc              randconfig-c003-20220318
powerpc              randconfig-c003-20220317
i386                          randconfig-c001
riscv                randconfig-c006-20220317
arm                   milbeaut_m10v_defconfig
powerpc                        icon_defconfig
arm                         orion5x_defconfig
mips                           mtx1_defconfig
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
hexagon              randconfig-r045-20220318
hexagon              randconfig-r041-20220318
hexagon              randconfig-r041-20220317
s390                 randconfig-r044-20220318
hexagon              randconfig-r045-20220317
riscv                randconfig-r042-20220318

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
