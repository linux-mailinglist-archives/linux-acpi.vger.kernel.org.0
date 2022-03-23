Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6C104E49E0
	for <lists+linux-acpi@lfdr.de>; Wed, 23 Mar 2022 01:01:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240824AbiCWADQ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 22 Mar 2022 20:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiCWADQ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 22 Mar 2022 20:03:16 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6EF91FA65;
        Tue, 22 Mar 2022 17:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647993707; x=1679529707;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=hHzBe8U8IturRswb/6WWXu+XslqPIXQ8Eg5k/VP6cek=;
  b=lGERXUwijxh5Vext6JVI8RagkfKoVVPAHidzEg9IjPu4IrL8L5/2pSVo
   4F1ZcN/zobHv0Gp7ihcxBA2ACI5M0kn5I3VMGdxhxYbo2ZEhws0vA4hvg
   U0sMvBROSuDzimI4mH0KR8QDSpEhCRZe/1fbJcLZeKfItQqdog9hgp4Ds
   1/zktR4sSJpKkceek4NYjd95c+MeFBt0vAN/rPOw/T+LhQg7pjA8bcak5
   zOg9HwTn6inRKqYhwSYa9vVMl6JgxCNTXae2hG++VpJLwTBcnilXDcpXw
   e9/KhrJaFxpy4tmg6RS1EuPlRrP0C/HIYCGuLLXwknhBhEsleTCIfeLRN
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10294"; a="245457501"
X-IronPort-AV: E=Sophos;i="5.90,203,1643702400"; 
   d="scan'208";a="245457501"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2022 17:01:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,203,1643702400"; 
   d="scan'208";a="583490886"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 22 Mar 2022 17:01:35 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nWoRT-000JQp-8I; Wed, 23 Mar 2022 00:01:35 +0000
Date:   Wed, 23 Mar 2022 08:01:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 81bbf3bb3aecb62a539f57a1d81381f0f95ff6ec
Message-ID: <623a6343.pZi+FzcShn3ZsUU6%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 81bbf3bb3aecb62a539f57a1d81381f0f95ff6ec  Merge branch 'pm-opp' into linux-next

elapsed time: 727m

configs tested: 200
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                          randconfig-c001
s390                             allmodconfig
m68k                             allmodconfig
m68k                             allyesconfig
powerpc                          allmodconfig
powerpc                          allyesconfig
s390                             allyesconfig
i386                 randconfig-c001-20220321
mips                 randconfig-c004-20220320
arm                        shmobile_defconfig
ia64                          tiger_defconfig
ia64                         bigsur_defconfig
arm                         nhk8815_defconfig
arm                        keystone_defconfig
h8300                               defconfig
powerpc                 mpc85xx_cds_defconfig
sparc                       sparc32_defconfig
sh                          polaris_defconfig
i386                                defconfig
sh                          rsk7201_defconfig
h8300                     edosk2674_defconfig
mips                       capcella_defconfig
sh                             shx3_defconfig
sh                        sh7757lcr_defconfig
arm                        multi_v7_defconfig
sh                           se7780_defconfig
arm                             pxa_defconfig
nios2                            alldefconfig
arm                       aspeed_g5_defconfig
sh                  sh7785lcr_32bit_defconfig
arm                         at91_dt_defconfig
xtensa                    xip_kc705_defconfig
m68k                        m5407c3_defconfig
mips                 decstation_r4k_defconfig
h8300                            allyesconfig
m68k                          sun3x_defconfig
powerpc                     taishan_defconfig
arc                          axs101_defconfig
mips                     decstation_defconfig
powerpc                     tqm8548_defconfig
parisc                           allyesconfig
mips                         tb0226_defconfig
powerpc                 canyonlands_defconfig
sh                            hp6xx_defconfig
mips                      maltasmvp_defconfig
powerpc                   motionpro_defconfig
sh                        sh7763rdp_defconfig
arc                           tb10x_defconfig
parisc64                            defconfig
arc                 nsimosci_hs_smp_defconfig
sh                               j2_defconfig
ia64                                defconfig
powerpc                 mpc837x_rdb_defconfig
powerpc64                           defconfig
powerpc                       maple_defconfig
arm                        clps711x_defconfig
arm                            qcom_defconfig
arc                      axs103_smp_defconfig
xtensa                          iss_defconfig
sh                         microdev_defconfig
sh                              ul2_defconfig
um                                  defconfig
nios2                         3c120_defconfig
arm                         lpc18xx_defconfig
sparc                            alldefconfig
m68k                        mvme16x_defconfig
openrisc                 simple_smp_defconfig
mips                         cobalt_defconfig
powerpc                 mpc834x_itx_defconfig
sh                             sh03_defconfig
sh                        edosk7705_defconfig
arm                         vf610m4_defconfig
powerpc                     rainier_defconfig
arm                         s3c6400_defconfig
powerpc                  storcenter_defconfig
sh                        sh7785lcr_defconfig
arm                            hisi_defconfig
arc                        nsimosci_defconfig
nios2                            allyesconfig
sh                            titan_defconfig
arm                         assabet_defconfig
sh                           se7619_defconfig
arm                        trizeps4_defconfig
arm                       omap2plus_defconfig
mips                         db1xxx_defconfig
mips                           xway_defconfig
parisc                generic-64bit_defconfig
arm                           viper_defconfig
nds32                               defconfig
m68k                        mvme147_defconfig
powerpc                    sam440ep_defconfig
sh                                  defconfig
xtensa                       common_defconfig
riscv                            allmodconfig
arm                  randconfig-c002-20220321
arm                  randconfig-c002-20220320
arm                  randconfig-c002-20220322
ia64                             allmodconfig
ia64                             allyesconfig
m68k                                defconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a016-20220321
x86_64               randconfig-a011-20220321
x86_64               randconfig-a012-20220321
x86_64               randconfig-a013-20220321
x86_64               randconfig-a014-20220321
x86_64               randconfig-a015-20220321
i386                 randconfig-a015-20220321
i386                 randconfig-a016-20220321
i386                 randconfig-a013-20220321
i386                 randconfig-a012-20220321
i386                 randconfig-a014-20220321
i386                 randconfig-a011-20220321
arc                  randconfig-r043-20220320
riscv                randconfig-r042-20220321
s390                 randconfig-r044-20220321
arc                  randconfig-r043-20220321
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
x86_64                    rhel-8.3-kselftests
x86_64                           allyesconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                                  kexec

clang tested configs:
x86_64                        randconfig-c007
mips                 randconfig-c004-20220320
arm                  randconfig-c002-20220320
powerpc              randconfig-c003-20220320
riscv                randconfig-c006-20220320
i386                          randconfig-c001
arm                  randconfig-c002-20220322
powerpc              randconfig-c003-20220322
riscv                randconfig-c006-20220322
s390                 randconfig-c005-20220322
mips                 randconfig-c004-20220322
powerpc                    gamecube_defconfig
mips                        maltaup_defconfig
hexagon                          alldefconfig
powerpc                     mpc5200_defconfig
arm                         orion5x_defconfig
powerpc                     akebono_defconfig
arm                         lpc32xx_defconfig
powerpc                          allyesconfig
powerpc                 mpc8272_ads_defconfig
arm                        neponset_defconfig
arm                          moxart_defconfig
arm64                            allyesconfig
arm                        mvebu_v5_defconfig
powerpc                        fsp2_defconfig
arm                     am200epdkit_defconfig
hexagon                             defconfig
x86_64               randconfig-a001-20220321
x86_64               randconfig-a003-20220321
x86_64               randconfig-a005-20220321
x86_64               randconfig-a004-20220321
x86_64               randconfig-a002-20220321
x86_64               randconfig-a006-20220321
i386                 randconfig-a001-20220321
i386                 randconfig-a006-20220321
i386                 randconfig-a003-20220321
i386                 randconfig-a005-20220321
i386                 randconfig-a004-20220321
i386                 randconfig-a002-20220321
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
riscv                randconfig-r042-20220320
hexagon              randconfig-r045-20220321
hexagon              randconfig-r045-20220320
hexagon              randconfig-r041-20220321
hexagon              randconfig-r041-20220320
riscv                randconfig-r042-20220322
hexagon              randconfig-r045-20220322
hexagon              randconfig-r041-20220322
s390                 randconfig-r044-20220320

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
