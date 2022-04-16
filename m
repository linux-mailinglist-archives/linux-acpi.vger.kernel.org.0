Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C59855032FB
	for <lists+linux-acpi@lfdr.de>; Sat, 16 Apr 2022 07:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356698AbiDPAHN (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 15 Apr 2022 20:07:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356693AbiDPAHM (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 15 Apr 2022 20:07:12 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DDA3220CB;
        Fri, 15 Apr 2022 17:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650067482; x=1681603482;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=HSZPWAGVL0OCHmyMupnEy3BzizzwkFnuvdX77ziaNz8=;
  b=Ir16WKRlr25IdrMClswg0mvskXKBc9Xze0wVjOu9EPCldeo/clF7gspc
   lRoSANgqz2sUlb75uNMj5hq6Frd7DFiTK9PtyFeNehTf0hm2uIYvO4w9O
   k9te6B4JQEND67dMLEVWKMiiy0A6GLflK5Wsb1cplq8GLsKm3Y1LaxL07
   T2Yk7lF1f/ZD8IA79tBLokSHNsobPPHMRddO/EtZvfRePYXCHM/jsT7U1
   S1CVf9+r5UgKFwh/+D9ny09DeWrG1YGJ5FC+/SqGIDQIXVV2lT3voB6b/
   dX/8FVoJpUMEFsrz33bCGAf5gjJn3Ycy5AG00q0miTlWJXE2sbovD3tkK
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10318"; a="262712083"
X-IronPort-AV: E=Sophos;i="5.90,264,1643702400"; 
   d="scan'208";a="262712083"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2022 17:04:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,264,1643702400"; 
   d="scan'208";a="509115384"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 15 Apr 2022 17:04:40 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nfVvb-0002Yz-JJ;
        Sat, 16 Apr 2022 00:04:39 +0000
Date:   Sat, 16 Apr 2022 08:04:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 5675fd487f2b221a27a44f6ac78bdb2e5f235052
Message-ID: <625a0814.ppOYLNShBLe1ZHKS%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
branch HEAD: 5675fd487f2b221a27a44f6ac78bdb2e5f235052  Merge branch 'thermal-misc' into linux-next

elapsed time: 1802m

configs tested: 185
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                               defconfig
arm64                            allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
powerpc              randconfig-c003-20220415
powerpc              randconfig-c003-20220414
sh                   secureedge5410_defconfig
powerpc                   motionpro_defconfig
arc                     haps_hs_smp_defconfig
arc                          axs103_defconfig
m68k                        stmark2_defconfig
arm                         lpc18xx_defconfig
mips                     loongson1b_defconfig
arm                        spear6xx_defconfig
sh                         ecovec24_defconfig
powerpc                 mpc837x_mds_defconfig
powerpc                      cm5200_defconfig
sparc                       sparc64_defconfig
sh                          rsk7264_defconfig
mips                           xway_defconfig
xtensa                       common_defconfig
powerpc                     taishan_defconfig
arc                           tb10x_defconfig
m68k                           sun3_defconfig
arm                       imx_v6_v7_defconfig
sh                               j2_defconfig
powerpc64                           defconfig
powerpc                      bamboo_defconfig
microblaze                          defconfig
sparc                            allyesconfig
arm                          pxa910_defconfig
arm                         lubbock_defconfig
arm                           tegra_defconfig
ia64                                defconfig
powerpc                         wii_defconfig
arc                        vdk_hs38_defconfig
mips                           jazz_defconfig
sh                           se7724_defconfig
arm                           imxrt_defconfig
arm                            mps2_defconfig
arm                             rpc_defconfig
sh                   sh7770_generic_defconfig
powerpc                 mpc834x_mds_defconfig
arm                          lpd270_defconfig
powerpc                        warp_defconfig
i386                                defconfig
powerpc                       eiger_defconfig
arm                       multi_v4t_defconfig
powerpc                     mpc83xx_defconfig
sh                        sh7757lcr_defconfig
mips                      maltasmvp_defconfig
sh                                  defconfig
alpha                            allyesconfig
mips                            gpr_defconfig
riscv             nommu_k210_sdcard_defconfig
powerpc64                        alldefconfig
arm                     eseries_pxa_defconfig
sh                   sh7724_generic_defconfig
powerpc                 mpc85xx_cds_defconfig
sh                           se7722_defconfig
i386                             alldefconfig
powerpc                      ppc6xx_defconfig
x86_64                              defconfig
arm                         axm55xx_defconfig
arm                          pxa3xx_defconfig
alpha                            alldefconfig
powerpc                     ep8248e_defconfig
arc                        nsim_700_defconfig
xtensa                  cadence_csp_defconfig
xtensa                  nommu_kc705_defconfig
sh                         microdev_defconfig
mips                         bigsur_defconfig
m68k                          atari_defconfig
sh                           se7712_defconfig
mips                     decstation_defconfig
s390                          debug_defconfig
um                                  defconfig
powerpc                     tqm8555_defconfig
s390                                defconfig
sh                           se7343_defconfig
sh                          rsk7269_defconfig
arm                  randconfig-c002-20220414
x86_64                        randconfig-c001
arm                  randconfig-c002-20220415
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
nios2                               defconfig
arc                              allyesconfig
alpha                               defconfig
csky                                defconfig
nios2                            allyesconfig
h8300                            allyesconfig
xtensa                           allyesconfig
arc                                 defconfig
sh                               allmodconfig
s390                             allmodconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
s390                             allyesconfig
sparc                               defconfig
i386                             allyesconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
powerpc                          allyesconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
riscv                randconfig-r042-20220415
arc                  randconfig-r043-20220415
s390                 randconfig-r044-20220415
arc                  randconfig-r043-20220414
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
riscv                            allmodconfig
riscv                            allyesconfig
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                          rhel-8.3-func
x86_64                                  kexec
x86_64                           allyesconfig
x86_64                         rhel-8.3-kunit
x86_64                               rhel-8.3

clang tested configs:
x86_64                        randconfig-c007
powerpc              randconfig-c003-20220414
arm                  randconfig-c002-20220414
i386                          randconfig-c001
riscv                randconfig-c006-20220414
mips                      malta_kvm_defconfig
powerpc                    gamecube_defconfig
hexagon                             defconfig
mips                         tb0287_defconfig
x86_64                           allyesconfig
mips                           ip28_defconfig
arm                           omap1_defconfig
arm                            dove_defconfig
powerpc                      acadia_defconfig
powerpc                 mpc8313_rdb_defconfig
riscv                             allnoconfig
powerpc                     kmeter1_defconfig
arm                       mainstone_defconfig
mips                       rbtx49xx_defconfig
arm                      tct_hammer_defconfig
powerpc                     tqm5200_defconfig
arm                        multi_v5_defconfig
mips                           mtx1_defconfig
arm                        spear3xx_defconfig
arm                       aspeed_g4_defconfig
powerpc                    ge_imp3a_defconfig
powerpc                      obs600_defconfig
arm                        vexpress_defconfig
arm                          collie_defconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
riscv                randconfig-r042-20220414
hexagon              randconfig-r041-20220414
hexagon              randconfig-r045-20220414
s390                 randconfig-r044-20220414

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
