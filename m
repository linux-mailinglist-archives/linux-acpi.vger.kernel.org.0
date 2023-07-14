Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3762752E8F
	for <lists+linux-acpi@lfdr.de>; Fri, 14 Jul 2023 03:32:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232513AbjGNBcU (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 13 Jul 2023 21:32:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232607AbjGNBcT (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 13 Jul 2023 21:32:19 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B771A2D64;
        Thu, 13 Jul 2023 18:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689298338; x=1720834338;
  h=date:from:to:cc:subject:message-id;
  bh=Z+0Xz8Udys6vlPvL5l4WNCN/2V5y7RuPZVfWZOdYDPU=;
  b=l201CRgfJFw86mGifLkUEuI4OUbjm20N+ZIUAypph8v014HxWNCyx1ZH
   BMd3+IaVJNsIoftGbxiufSvt16AkrB1VLfvHCsOqOyTflInUxTjsXfcfs
   fPXaDAOqBdzZjkjqNBGt04FaexFAo++NC2mUPcQ3nY25cXqEoowZph9J3
   5PfBCgOY703VtDWUsE8Dq6vptuv/x+C/y/7m7I3iBJ/rvtmgvsX7zkSIt
   2Ey1Wrz4RZ/bg02hTN32DTinoNjJwm0f77eu5un9BfeawcHHKtknDaLfH
   ufEppShrogRoA7dmjuVJ0exVQ7klPjGJt9Nz6rkNKrMN8Tk02lwWX14Ye
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="362826185"
X-IronPort-AV: E=Sophos;i="6.01,204,1684825200"; 
   d="scan'208";a="362826185"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2023 18:32:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="968840115"
X-IronPort-AV: E=Sophos;i="6.01,204,1684825200"; 
   d="scan'208";a="968840115"
Received: from lkp-server01.sh.intel.com (HELO c544d7fc5005) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 13 Jul 2023 18:32:15 -0700
Received: from kbuild by c544d7fc5005 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qK7fL-000725-0O;
        Fri, 14 Jul 2023 01:32:15 +0000
Date:   Fri, 14 Jul 2023 09:32:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-acpi@vger.kernel.org, devel@acpica.org,
        linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 998829ca60f7d9d396281f6c1276bf991ab8068d
Message-ID: <202307140909.CBTrLEUk-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 998829ca60f7d9d396281f6c1276bf991ab8068d  Merge branch 'thermal-core' into linux-next

elapsed time: 722m

configs tested: 175
configs skipped: 12

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r011-20230713   gcc  
alpha                randconfig-r012-20230713   gcc  
alpha                randconfig-r021-20230713   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                        nsimosci_defconfig   gcc  
arc                  randconfig-r004-20230713   gcc  
arc                  randconfig-r006-20230713   gcc  
arc                  randconfig-r021-20230713   gcc  
arc                  randconfig-r024-20230713   gcc  
arc                  randconfig-r032-20230713   gcc  
arc                  randconfig-r043-20230713   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                       aspeed_g5_defconfig   gcc  
arm                     davinci_all_defconfig   clang
arm                                 defconfig   gcc  
arm                      jornada720_defconfig   gcc  
arm                            qcom_defconfig   gcc  
arm                  randconfig-r001-20230713   gcc  
arm                  randconfig-r003-20230713   gcc  
arm                  randconfig-r005-20230713   gcc  
arm                  randconfig-r033-20230713   gcc  
arm                  randconfig-r046-20230713   clang
arm                           sunxi_defconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r011-20230713   gcc  
arm64                randconfig-r032-20230713   clang
csky                                defconfig   gcc  
csky                 randconfig-r006-20230713   gcc  
csky                 randconfig-r012-20230713   gcc  
csky                 randconfig-r013-20230713   gcc  
csky                 randconfig-r025-20230713   gcc  
csky                 randconfig-r031-20230713   gcc  
csky                 randconfig-r032-20230713   gcc  
hexagon              randconfig-r001-20230713   clang
hexagon              randconfig-r023-20230713   clang
hexagon              randconfig-r041-20230713   clang
hexagon              randconfig-r045-20230713   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230713   clang
i386         buildonly-randconfig-r005-20230713   clang
i386         buildonly-randconfig-r006-20230713   clang
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230713   clang
i386                 randconfig-i002-20230713   clang
i386                 randconfig-i003-20230713   clang
i386                 randconfig-i004-20230713   clang
i386                 randconfig-i005-20230713   clang
i386                 randconfig-i006-20230713   clang
i386                 randconfig-i011-20230713   gcc  
i386                 randconfig-i012-20230713   gcc  
i386                 randconfig-i013-20230713   gcc  
i386                 randconfig-i014-20230713   gcc  
i386                 randconfig-i015-20230713   gcc  
i386                 randconfig-i016-20230713   gcc  
i386                 randconfig-r023-20230713   gcc  
i386                 randconfig-r025-20230713   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r001-20230713   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r003-20230713   gcc  
m68k                 randconfig-r016-20230713   gcc  
microblaze           randconfig-r002-20230713   gcc  
microblaze           randconfig-r031-20230713   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                            gpr_defconfig   gcc  
mips                           ip22_defconfig   clang
mips                      maltasmvp_defconfig   gcc  
mips                 randconfig-r015-20230713   clang
mips                 randconfig-r035-20230713   gcc  
mips                          rm200_defconfig   clang
mips                           rs90_defconfig   clang
nios2                               defconfig   gcc  
nios2                randconfig-r011-20230713   gcc  
nios2                randconfig-r034-20230713   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r024-20230713   gcc  
parisc               randconfig-r026-20230713   gcc  
parisc               randconfig-r036-20230713   gcc  
parisc64                            defconfig   gcc  
powerpc                     akebono_defconfig   clang
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                     asp8347_defconfig   gcc  
powerpc                      chrp32_defconfig   gcc  
powerpc                          g5_defconfig   clang
powerpc                 mpc8313_rdb_defconfig   clang
powerpc                  mpc866_ads_defconfig   clang
powerpc              randconfig-r014-20230713   gcc  
powerpc              randconfig-r035-20230713   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv             nommu_k210_sdcard_defconfig   gcc  
riscv                randconfig-r002-20230713   clang
riscv                randconfig-r003-20230713   clang
riscv                randconfig-r005-20230713   clang
riscv                randconfig-r015-20230713   gcc  
riscv                randconfig-r016-20230713   gcc  
riscv                randconfig-r021-20230713   gcc  
riscv                randconfig-r042-20230713   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r034-20230713   clang
s390                 randconfig-r044-20230713   gcc  
s390                       zfcpdump_defconfig   gcc  
sh                               allmodconfig   gcc  
sh                                  defconfig   gcc  
sh                   randconfig-r002-20230713   gcc  
sh                   randconfig-r014-20230713   gcc  
sh                           se7722_defconfig   gcc  
sh                        sh7763rdp_defconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r024-20230713   gcc  
sparc64                             defconfig   gcc  
sparc64              randconfig-r013-20230713   gcc  
sparc64              randconfig-r033-20230713   gcc  
sparc64              randconfig-r034-20230713   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r031-20230713   gcc  
um                   randconfig-r036-20230713   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230713   clang
x86_64       buildonly-randconfig-r002-20230713   clang
x86_64       buildonly-randconfig-r003-20230713   clang
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-r012-20230713   gcc  
x86_64               randconfig-r026-20230713   gcc  
x86_64               randconfig-r036-20230713   clang
x86_64               randconfig-x001-20230713   gcc  
x86_64               randconfig-x002-20230713   gcc  
x86_64               randconfig-x003-20230713   gcc  
x86_64               randconfig-x004-20230713   gcc  
x86_64               randconfig-x005-20230713   gcc  
x86_64               randconfig-x006-20230713   gcc  
x86_64               randconfig-x011-20230713   clang
x86_64               randconfig-x012-20230713   clang
x86_64               randconfig-x013-20230713   clang
x86_64               randconfig-x014-20230713   clang
x86_64               randconfig-x015-20230713   clang
x86_64               randconfig-x016-20230713   clang
x86_64                           rhel-8.3-bpf   gcc  
x86_64                          rhel-8.3-func   gcc  
x86_64                    rhel-8.3-kselftests   gcc  
x86_64                         rhel-8.3-kunit   gcc  
x86_64                           rhel-8.3-ltp   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r005-20230713   gcc  
xtensa               randconfig-r014-20230713   gcc  
xtensa               randconfig-r016-20230713   gcc  
xtensa               randconfig-r022-20230713   gcc  
xtensa               randconfig-r025-20230713   gcc  
xtensa                    xip_kc705_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
