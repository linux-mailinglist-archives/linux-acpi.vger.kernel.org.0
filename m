Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38EB66F11A8
	for <lists+linux-acpi@lfdr.de>; Fri, 28 Apr 2023 08:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbjD1GN2 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 28 Apr 2023 02:13:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjD1GN1 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 28 Apr 2023 02:13:27 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DE6330C2;
        Thu, 27 Apr 2023 23:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682662405; x=1714198405;
  h=date:from:to:cc:subject:message-id;
  bh=BAaPH7y5+iPBx1JwEqtKlPx8zQzUomIWom+w6Gko5FE=;
  b=IMnNcL5LG11Vuk4h4N6S6BxR7+pA4ide58T4kiNytEYOlFQBpw2vSQ1m
   j2MZJihofL7IZgWwffcjQY4b1V2xJZ0/BCCC05OPKWhxIc38CU9LBLK2u
   sMzOUDBFbI/7vddpYiTwlTJEG2sMxh/az8SG6ClLQPz9d2RFtb2nWuh9i
   Mt2DX/FzuQpxy6c+Rjw+gwMauk9LkRQlcB3sAEi8Nx+rp6fVEViyUQG74
   qGAViu/95TS3Tbag2f3JQgsDaF0UG1w2w6f0w5kY43L9e9aV0WJb0pnpT
   nBp86yHqI5B5e/E1l7gpziUhci3rbREJb8NcTeja6f0tKum2Piw97ESE7
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="350568365"
X-IronPort-AV: E=Sophos;i="5.99,233,1677571200"; 
   d="scan'208";a="350568365"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2023 23:13:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="688699796"
X-IronPort-AV: E=Sophos;i="5.99,233,1677571200"; 
   d="scan'208";a="688699796"
Received: from lkp-server01.sh.intel.com (HELO 5bad9d2b7fcb) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 27 Apr 2023 23:13:21 -0700
Received: from kbuild by 5bad9d2b7fcb with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1psHM8-0000BH-2n;
        Fri, 28 Apr 2023 06:13:20 +0000
Date:   Fri, 28 Apr 2023 14:13:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-acpi@vger.kernel.org, devel@acpica.org,
        linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 26469b9b98dae99b8c10e8c046b89b39c68bdda3
Message-ID: <20230428061314.oPRsY%lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 26469b9b98dae99b8c10e8c046b89b39c68bdda3  Merge branch 'pm-cpuidle' into bleeding-edge

elapsed time: 723m

configs tested: 116
configs skipped: 11

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r034-20230427   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r025-20230427   gcc  
arc                  randconfig-r043-20230427   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                       omap2plus_defconfig   gcc  
arm                  randconfig-r004-20230427   clang
arm                  randconfig-r046-20230427   gcc  
arm                             rpc_defconfig   gcc  
arm                         vf610m4_defconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r003-20230427   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r006-20230427   gcc  
hexagon              randconfig-r041-20230427   clang
hexagon              randconfig-r045-20230427   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                          randconfig-a001   gcc  
i386                          randconfig-a002   clang
i386                          randconfig-a003   gcc  
i386                          randconfig-a004   clang
i386                          randconfig-a005   gcc  
i386                          randconfig-a006   clang
i386                          randconfig-a011   clang
i386                          randconfig-a012   gcc  
i386                          randconfig-a013   clang
i386                          randconfig-a014   gcc  
i386                          randconfig-a015   clang
i386                          randconfig-a016   gcc  
ia64                             allmodconfig   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r002-20230427   gcc  
ia64                 randconfig-r022-20230427   gcc  
ia64                 randconfig-r035-20230427   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k         buildonly-randconfig-r005-20230427   gcc  
m68k                                defconfig   gcc  
m68k                       m5475evb_defconfig   gcc  
microblaze           randconfig-r004-20230428   gcc  
microblaze           randconfig-r011-20230427   gcc  
microblaze           randconfig-r015-20230427   gcc  
microblaze           randconfig-r016-20230427   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                  cavium_octeon_defconfig   clang
mips                      fuloong2e_defconfig   gcc  
mips                      loongson3_defconfig   gcc  
nios2        buildonly-randconfig-r002-20230427   gcc  
nios2                               defconfig   gcc  
openrisc             randconfig-r001-20230428   gcc  
openrisc             randconfig-r005-20230428   gcc  
openrisc             randconfig-r031-20230427   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r024-20230427   gcc  
parisc               randconfig-r032-20230427   gcc  
parisc               randconfig-r033-20230427   gcc  
parisc64                            defconfig   gcc  
powerpc                    adder875_defconfig   gcc  
powerpc                     akebono_defconfig   clang
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                      arches_defconfig   gcc  
powerpc                    gamecube_defconfig   clang
powerpc                    ge_imp3a_defconfig   clang
powerpc                 mpc8272_ads_defconfig   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   clang
riscv                             allnoconfig   gcc  
riscv        buildonly-randconfig-r003-20230427   clang
riscv                               defconfig   gcc  
riscv                randconfig-r012-20230427   clang
riscv                randconfig-r013-20230427   clang
riscv                randconfig-r014-20230427   clang
riscv                randconfig-r042-20230427   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r001-20230427   gcc  
s390                 randconfig-r044-20230427   clang
sh                               allmodconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r006-20230428   gcc  
sparc64              randconfig-r021-20230427   gcc  
sparc64              randconfig-r026-20230427   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                        randconfig-a001   clang
x86_64                        randconfig-a002   gcc  
x86_64                        randconfig-a003   clang
x86_64                        randconfig-a004   gcc  
x86_64                        randconfig-a005   clang
x86_64                        randconfig-a006   gcc  
x86_64                        randconfig-a011   gcc  
x86_64                        randconfig-a012   clang
x86_64                        randconfig-a013   gcc  
x86_64                        randconfig-a014   clang
x86_64                        randconfig-a015   gcc  
x86_64                        randconfig-a016   clang
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r023-20230427   gcc  
xtensa                         virt_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
