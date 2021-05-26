Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01969390F4C
	for <lists+linux-acpi@lfdr.de>; Wed, 26 May 2021 06:22:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231410AbhEZEYC (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 26 May 2021 00:24:02 -0400
Received: from mga04.intel.com ([192.55.52.120]:42270 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231136AbhEZEYB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 26 May 2021 00:24:01 -0400
IronPort-SDR: e5Z1pWJKHRlM0GhHRt7fXoweKnZ2Lj3lhq+GvgxskeSbQYwqzs6l6LWs4dcYdwK7706rilcD7J
 hlMmyOYMqUag==
X-IronPort-AV: E=McAfee;i="6200,9189,9995"; a="200475879"
X-IronPort-AV: E=Sophos;i="5.82,330,1613462400"; 
   d="scan'208";a="200475879"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2021 21:22:22 -0700
IronPort-SDR: rzhbPy/8jSg81YBmooCVyGpyoLtG9QcFXU4gNY/UZfVvY4/+7R+QC7UQH/35e6fBkdpuTSq4Bg
 /ZtKpqRi/HtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,330,1613462400"; 
   d="scan'208";a="476741903"
Received: from lkp-server02.sh.intel.com (HELO 1ec8406c5392) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 25 May 2021 21:22:19 -0700
Received: from kbuild by 1ec8406c5392 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lll3i-0001zt-Mt; Wed, 26 May 2021 04:22:18 +0000
Date:   Wed, 26 May 2021 12:21:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [pm:bleeding-edge] BUILD SUCCESS
 bf15f94bdcd8d77957c0649a2ea7e39705b699a1
Message-ID: <60adccde.eU4qaS478y+uc7ns%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: bf15f94bdcd8d77957c0649a2ea7e39705b699a1  Merge branch 'acpi-misc' into linux-next

elapsed time: 721m

configs tested: 252
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm                              allyesconfig
arm                              allmodconfig
arm64                               defconfig
arc                     haps_hs_smp_defconfig
sh                           se7751_defconfig
arm                           sunxi_defconfig
parisc                generic-64bit_defconfig
mips                     loongson1c_defconfig
arm                   milbeaut_m10v_defconfig
sh                        apsh4ad0a_defconfig
mips                          ath79_defconfig
arm                         cm_x300_defconfig
sh                   sh7724_generic_defconfig
sh                             sh03_defconfig
openrisc                            defconfig
x86_64                           alldefconfig
powerpc                     mpc83xx_defconfig
powerpc                  mpc866_ads_defconfig
mips                  maltasmvp_eva_defconfig
powerpc                     tqm8548_defconfig
powerpc                      ppc44x_defconfig
sh                           se7780_defconfig
arm                        spear3xx_defconfig
powerpc                      ppc40x_defconfig
sh                        dreamcast_defconfig
powerpc                     stx_gp3_defconfig
powerpc                     mpc512x_defconfig
powerpc                     ksi8560_defconfig
powerpc                     tqm5200_defconfig
sh                            titan_defconfig
csky                                defconfig
arm                       multi_v4t_defconfig
mips                           ip22_defconfig
m68k                             allyesconfig
powerpc                     redwood_defconfig
mips                        omega2p_defconfig
arm                            xcep_defconfig
powerpc                       eiger_defconfig
xtensa                generic_kc705_defconfig
arm                            mmp2_defconfig
powerpc                       ppc64_defconfig
um                               alldefconfig
mips                      loongson3_defconfig
mips                        nlm_xlp_defconfig
openrisc                  or1klitex_defconfig
powerpc                      walnut_defconfig
mips                         db1xxx_defconfig
mips                        maltaup_defconfig
arm                           spitz_defconfig
mips                  cavium_octeon_defconfig
powerpc                      obs600_defconfig
mips                            ar7_defconfig
sh                           se7712_defconfig
arm                          iop32x_defconfig
arc                              alldefconfig
powerpc                    ge_imp3a_defconfig
powerpc                     pq2fads_defconfig
arm                         at91_dt_defconfig
powerpc                       holly_defconfig
alpha                            alldefconfig
um                           x86_64_defconfig
arm                         s3c6400_defconfig
arc                        vdk_hs38_defconfig
arm                          pcm027_defconfig
arm                        mvebu_v5_defconfig
sh                          sdk7780_defconfig
arm                          pxa168_defconfig
sh                          lboxre2_defconfig
powerpc                      chrp32_defconfig
mips                malta_qemu_32r6_defconfig
m68k                          sun3x_defconfig
arm                        oxnas_v6_defconfig
powerpc                 mpc85xx_cds_defconfig
powerpc                    klondike_defconfig
powerpc                 mpc832x_mds_defconfig
mips                    maltaup_xpa_defconfig
arm                         orion5x_defconfig
mips                           ip28_defconfig
arm                    vt8500_v6_v7_defconfig
nds32                            alldefconfig
xtensa                         virt_defconfig
mips                     cu1830-neo_defconfig
xtensa                    xip_kc705_defconfig
powerpc                     taishan_defconfig
nios2                            alldefconfig
arm                      jornada720_defconfig
powerpc                 mpc8272_ads_defconfig
powerpc                     sbc8548_defconfig
sh                   sh7770_generic_defconfig
arm                     am200epdkit_defconfig
alpha                               defconfig
riscv                    nommu_k210_defconfig
powerpc                     tqm8541_defconfig
powerpc               mpc834x_itxgp_defconfig
mips                       capcella_defconfig
arm                            mps2_defconfig
nds32                               defconfig
powerpc64                           defconfig
powerpc                      bamboo_defconfig
mips                        bcm47xx_defconfig
arm                        spear6xx_defconfig
arm                        realview_defconfig
powerpc                  storcenter_defconfig
arm                           tegra_defconfig
arm                          pxa910_defconfig
mips                          rm200_defconfig
arm                            pleb_defconfig
sparc64                             defconfig
arm                           omap1_defconfig
mips                         mpc30x_defconfig
arm                            lart_defconfig
powerpc                     rainier_defconfig
powerpc                      ppc6xx_defconfig
sh                           se7750_defconfig
mips                      pic32mzda_defconfig
mips                         tb0219_defconfig
m68k                       m5249evb_defconfig
riscv                             allnoconfig
sh                           se7206_defconfig
arm                       cns3420vb_defconfig
powerpc                     sequoia_defconfig
sh                           se7619_defconfig
s390                                defconfig
m68k                            q40_defconfig
microblaze                          defconfig
arc                          axs101_defconfig
sh                           se7724_defconfig
parisc                generic-32bit_defconfig
arm                      tct_hammer_defconfig
xtensa                    smp_lx200_defconfig
m68k                          multi_defconfig
sh                           se7705_defconfig
m68k                        mvme16x_defconfig
arm                             rpc_defconfig
arc                            hsdk_defconfig
riscv             nommu_k210_sdcard_defconfig
mips                            e55_defconfig
sh                         microdev_defconfig
powerpc                        fsp2_defconfig
mips                          malta_defconfig
powerpc                         wii_defconfig
sh                               j2_defconfig
arm64                            alldefconfig
sh                   secureedge5410_defconfig
sh                        edosk7705_defconfig
powerpc                      tqm8xx_defconfig
powerpc                   currituck_defconfig
mips                          ath25_defconfig
um                               allyesconfig
powerpc                      pasemi_defconfig
arc                        nsim_700_defconfig
arm                            dove_defconfig
arc                     nsimosci_hs_defconfig
s390                          debug_defconfig
arm                       aspeed_g5_defconfig
mips                          rb532_defconfig
arm                        trizeps4_defconfig
m68k                          hp300_defconfig
x86_64                            allnoconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nios2                            allyesconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a005-20210526
x86_64               randconfig-a001-20210526
x86_64               randconfig-a006-20210526
x86_64               randconfig-a003-20210526
x86_64               randconfig-a004-20210526
x86_64               randconfig-a002-20210526
i386                 randconfig-a001-20210525
i386                 randconfig-a002-20210525
i386                 randconfig-a005-20210525
i386                 randconfig-a006-20210525
i386                 randconfig-a003-20210525
i386                 randconfig-a004-20210525
i386                 randconfig-a001-20210526
i386                 randconfig-a002-20210526
i386                 randconfig-a005-20210526
i386                 randconfig-a004-20210526
i386                 randconfig-a003-20210526
i386                 randconfig-a006-20210526
x86_64               randconfig-a013-20210525
x86_64               randconfig-a012-20210525
x86_64               randconfig-a014-20210525
x86_64               randconfig-a016-20210525
x86_64               randconfig-a015-20210525
x86_64               randconfig-a011-20210525
i386                 randconfig-a011-20210525
i386                 randconfig-a016-20210525
i386                 randconfig-a015-20210525
i386                 randconfig-a012-20210525
i386                 randconfig-a014-20210525
i386                 randconfig-a013-20210525
i386                 randconfig-a011-20210526
i386                 randconfig-a016-20210526
i386                 randconfig-a015-20210526
i386                 randconfig-a012-20210526
i386                 randconfig-a014-20210526
i386                 randconfig-a013-20210526
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                               allmodconfig
um                                allnoconfig
um                                  defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-b001-20210526
x86_64               randconfig-b001-20210525
x86_64               randconfig-a005-20210525
x86_64               randconfig-a006-20210525
x86_64               randconfig-a001-20210525
x86_64               randconfig-a003-20210525
x86_64               randconfig-a004-20210525
x86_64               randconfig-a002-20210525
x86_64               randconfig-a013-20210526
x86_64               randconfig-a012-20210526
x86_64               randconfig-a014-20210526
x86_64               randconfig-a016-20210526
x86_64               randconfig-a015-20210526
x86_64               randconfig-a011-20210526

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
