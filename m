Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEE7D606F1B
	for <lists+linux-acpi@lfdr.de>; Fri, 21 Oct 2022 07:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbiJUFHV (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 21 Oct 2022 01:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbiJUFHU (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 21 Oct 2022 01:07:20 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8094318148D;
        Thu, 20 Oct 2022 22:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666328839; x=1697864839;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=D3xnR8Ta/qivJr09BNvM6YZyIJkZqkj+4BajqQyNPvE=;
  b=fYVFhMQ2tzXLupMoDnZ9fTHazvKVvPVgwF2Xak0jss33BKCPJlVKX3/O
   Nxn9vkh71//M/LeF4t/hbFfHNpKWR2sFiLxfeBsb5rkz+hnQ0y+98cNQO
   enrDvOW7nYIG2qEZhpUEm0sIe9/dKcvfa3PVx8y9Qe/11995eZTDWxPdK
   qI6992Gc3LLgtEuddtIbE6nSyjA0wMvKKuhQBVVe1homKVV/jYvhVvuja
   gWzQmo9HvI4crOjqMf3FhEV5eTSxYdBHRmQa7DowlPTx3V5tw5AnpH9kG
   UeXXP9z96fPi0AiJYKjfWmFd8oReBm10LhHWZNAWVx1ic5D5UMo2ai58v
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="333484974"
X-IronPort-AV: E=Sophos;i="5.95,200,1661842800"; 
   d="scan'208";a="333484974"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2022 22:07:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="630280376"
X-IronPort-AV: E=Sophos;i="5.95,200,1661842800"; 
   d="scan'208";a="630280376"
Received: from lkp-server02.sh.intel.com (HELO b6d29c1a0365) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 20 Oct 2022 22:07:17 -0700
Received: from kbuild by b6d29c1a0365 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1olkFY-00028v-2D;
        Fri, 21 Oct 2022 05:07:16 +0000
Date:   Fri, 21 Oct 2022 13:06:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 89871b5c10a0504b364a83363f47a069578ae1f9
Message-ID: <635228db.9kJEbJMDHLjBWJst%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        LONGWORDS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 89871b5c10a0504b364a83363f47a069578ae1f9  Merge branch 'acpi-scan' into linux-next

elapsed time: 2003m

configs tested: 211
configs skipped: 8

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                               allnoconfig
alpha                             allnoconfig
csky                              allnoconfig
riscv                             allnoconfig
um                             i386_defconfig
um                           x86_64_defconfig
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
s390                                defconfig
x86_64                           rhel-8.3-kvm
x86_64                          rhel-8.3-func
s390                             allyesconfig
x86_64                    rhel-8.3-kselftests
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
arc                  randconfig-r043-20221018
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
m68k                             allyesconfig
riscv                randconfig-r042-20221018
x86_64                              defconfig
s390                 randconfig-r044-20221018
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                        randconfig-a004
i386                                defconfig
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
i386                          randconfig-a001
x86_64                        randconfig-a002
i386                          randconfig-a003
x86_64                        randconfig-a006
i386                          randconfig-a005
i386                             allyesconfig
arm                                 defconfig
sh                            titan_defconfig
arm                       aspeed_g5_defconfig
m68k                          amiga_defconfig
i386                          randconfig-c001
sh                        sh7763rdp_defconfig
mips                           gcw0_defconfig
openrisc                            defconfig
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
ia64                          tiger_defconfig
m68k                       m5475evb_defconfig
xtensa                              defconfig
powerpc                       maple_defconfig
arm                              allyesconfig
arm64                            allyesconfig
arm                          pxa3xx_defconfig
sparc64                          alldefconfig
m68k                       bvme6000_defconfig
xtensa                         virt_defconfig
powerpc                     sequoia_defconfig
arm                           h3600_defconfig
arm                         cm_x300_defconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
sh                        dreamcast_defconfig
sh                          kfr2r09_defconfig
mips                           ip32_defconfig
powerpc                     mpc83xx_defconfig
sh                          rsk7269_defconfig
s390                          debug_defconfig
m68k                           virt_defconfig
sh                     sh7710voipgw_defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20221020
arm                        keystone_defconfig
ia64                                defconfig
arm                  randconfig-c002-20221019
arc                  randconfig-r043-20221020
s390                 randconfig-r044-20221020
riscv                randconfig-r042-20221020
arm                        clps711x_defconfig
xtensa                           alldefconfig
arm                          exynos_defconfig
nios2                               defconfig
powerpc                      ppc6xx_defconfig
sh                   rts7751r2dplus_defconfig
powerpc                   currituck_defconfig
arm                           stm32_defconfig
powerpc                 mpc834x_itx_defconfig
openrisc                  or1klitex_defconfig
csky                                defconfig
sh                             shx3_defconfig
arc                        vdk_hs38_defconfig
arm                         assabet_defconfig
nios2                            alldefconfig
m68k                          sun3x_defconfig
openrisc                       virt_defconfig
xtensa                          iss_defconfig
arc                          axs101_defconfig
powerpc                   motionpro_defconfig
m68k                                defconfig
sparc                       sparc32_defconfig
arc                        nsimosci_defconfig
sh                           se7619_defconfig
arm                         s3c6400_defconfig
powerpc                     tqm8555_defconfig
nios2                            allyesconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
mips                 randconfig-c004-20221020
ia64                         bigsur_defconfig
m68k                        stmark2_defconfig
powerpc                      cm5200_defconfig
sh                ecovec24-romimage_defconfig
arm                      footbridge_defconfig
sh                     magicpanelr2_defconfig
arm                          gemini_defconfig
mips                  maltasmvp_eva_defconfig
loongarch                           defconfig
loongarch                         allnoconfig
loongarch                        allmodconfig
um                               alldefconfig
powerpc                  iss476-smp_defconfig
sh                         apsh4a3a_defconfig
powerpc                          allyesconfig
riscv                               defconfig
riscv                            allmodconfig
riscv                            allyesconfig
openrisc                         alldefconfig
powerpc                       holly_defconfig
sparc                               defconfig
xtensa                           allyesconfig
sparc                            allyesconfig
x86_64                                  kexec
m68k                         apollo_defconfig
sh                           se7712_defconfig
sparc                            alldefconfig
arm                          badge4_defconfig
arm                        oxnas_v6_defconfig
m68k                            q40_defconfig
powerpc                     tqm8541_defconfig
powerpc                      chrp32_defconfig
sh                           se7750_defconfig
sh                           se7343_defconfig
nios2                         10m50_defconfig
mips                           ci20_defconfig
m68k                        mvme147_defconfig
mips                       bmips_be_defconfig

clang tested configs:
hexagon              randconfig-r045-20221018
hexagon              randconfig-r041-20221018
s390                 randconfig-r044-20221019
hexagon              randconfig-r045-20221019
riscv                randconfig-r042-20221019
hexagon              randconfig-r041-20221019
x86_64                        randconfig-a014
x86_64                        randconfig-a005
i386                 randconfig-a011-20221017
i386                          randconfig-a002
x86_64                        randconfig-a001
i386                 randconfig-a013-20221017
x86_64                        randconfig-a016
x86_64                        randconfig-a003
i386                 randconfig-a012-20221017
i386                          randconfig-a006
i386                 randconfig-a014-20221017
x86_64                        randconfig-a012
i386                          randconfig-a004
i386                 randconfig-a016-20221017
i386                 randconfig-a015-20221017
powerpc                      pmac32_defconfig
powerpc                     tqm8540_defconfig
x86_64                        randconfig-k001
hexagon              randconfig-r041-20221020
hexagon              randconfig-r045-20221020
x86_64                        randconfig-c007
mips                 randconfig-c004-20221019
i386                          randconfig-c001
s390                 randconfig-c005-20221019
arm                  randconfig-c002-20221019
riscv                randconfig-c006-20221019
powerpc              randconfig-c003-20221019
arm                       mainstone_defconfig
powerpc                      obs600_defconfig
powerpc                     ksi8560_defconfig
powerpc                    gamecube_defconfig
mips                          ath79_defconfig
arm                         shannon_defconfig
mips                     cu1830-neo_defconfig
arm                          ep93xx_defconfig
powerpc                 mpc836x_rdk_defconfig
mips                       lemote2f_defconfig
powerpc                    socrates_defconfig
arm                         orion5x_defconfig
powerpc                     tqm8560_defconfig
powerpc                     kmeter1_defconfig
arm                           omap1_defconfig
mips                      malta_kvm_defconfig
arm                                 defconfig
arm                        magician_defconfig
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
arm                  colibri_pxa300_defconfig
mips                          ath25_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
