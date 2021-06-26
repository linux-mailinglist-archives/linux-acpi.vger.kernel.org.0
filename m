Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 685873B4CD7
	for <lists+linux-acpi@lfdr.de>; Sat, 26 Jun 2021 07:28:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229462AbhFZFa5 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 26 Jun 2021 01:30:57 -0400
Received: from mga14.intel.com ([192.55.52.115]:58145 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229451AbhFZFa5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sat, 26 Jun 2021 01:30:57 -0400
IronPort-SDR: 6Fv/kf8pv4pIpS9uWlCiS4vpwQH2zphRgXPLkXRSucBVoVcUHBrKUGOV1QvGSNs4Z0v7LqP0Pv
 BWypZWV4iHuA==
X-IronPort-AV: E=McAfee;i="6200,9189,10026"; a="207590720"
X-IronPort-AV: E=Sophos;i="5.83,300,1616482800"; 
   d="scan'208";a="207590720"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2021 22:28:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,300,1616482800"; 
   d="scan'208";a="482039688"
Received: from lkp-server01.sh.intel.com (HELO 4aae0cb4f5b5) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 25 Jun 2021 22:28:31 -0700
Received: from kbuild by 4aae0cb4f5b5 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lx0rm-0007aY-Kk; Sat, 26 Jun 2021 05:28:30 +0000
Date:   Sat, 26 Jun 2021 13:27:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [pm:bleeding-edge] BUILD SUCCESS
 33842e66a789d1e4aa9d0379c1f5f43fd4cc4ae7
Message-ID: <60d6badc.pqat5jqqO2/O9QRD%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 33842e66a789d1e4aa9d0379c1f5f43fd4cc4ae7  Merge branch 'pm-devfreq' into linux-next

elapsed time: 727m

configs tested: 161
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
mips                  maltasmvp_eva_defconfig
mips                         db1xxx_defconfig
sh                        apsh4ad0a_defconfig
mips                         tb0226_defconfig
powerpc                           allnoconfig
mips                        bcm47xx_defconfig
powerpc                     skiroot_defconfig
microblaze                          defconfig
powerpc                 mpc836x_mds_defconfig
sh                          rsk7201_defconfig
s390                          debug_defconfig
powerpc                 mpc832x_mds_defconfig
arc                            hsdk_defconfig
arc                           tb10x_defconfig
ia64                            zx1_defconfig
powerpc                         ps3_defconfig
powerpc                      mgcoge_defconfig
sh                        sh7785lcr_defconfig
sh                           se7721_defconfig
sh                        edosk7705_defconfig
arm                          pxa3xx_defconfig
arm                          moxart_defconfig
arm                           u8500_defconfig
arm                         palmz72_defconfig
powerpc                 mpc834x_mds_defconfig
i386                             alldefconfig
x86_64                              defconfig
arm                             ezx_defconfig
arm                           sunxi_defconfig
mips                        workpad_defconfig
powerpc                    ge_imp3a_defconfig
mips                         tb0219_defconfig
powerpc                      pasemi_defconfig
sh                             shx3_defconfig
arm                            zeus_defconfig
arc                          axs101_defconfig
sh                          landisk_defconfig
ia64                          tiger_defconfig
sh                        dreamcast_defconfig
arm                         s3c6400_defconfig
mips                      pic32mzda_defconfig
powerpc                mpc7448_hpc2_defconfig
powerpc                     tqm8560_defconfig
arc                     nsimosci_hs_defconfig
arm                         hackkit_defconfig
mips                     cu1830-neo_defconfig
powerpc                 xes_mpc85xx_defconfig
m68k                       m5275evb_defconfig
powerpc                     pq2fads_defconfig
arm                         vf610m4_defconfig
m68k                            mac_defconfig
microblaze                      mmu_defconfig
arm                        trizeps4_defconfig
arm                        cerfcube_defconfig
riscv                          rv32_defconfig
arm                             pxa_defconfig
m68k                         amcore_defconfig
sh                           sh2007_defconfig
arm                           viper_defconfig
powerpc                  mpc866_ads_defconfig
powerpc                    adder875_defconfig
mips                      malta_kvm_defconfig
arm                         orion5x_defconfig
mips                           ip27_defconfig
sh                               j2_defconfig
powerpc                     mpc83xx_defconfig
x86_64                            allnoconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
x86_64               randconfig-a002-20210625
x86_64               randconfig-a001-20210625
x86_64               randconfig-a005-20210625
x86_64               randconfig-a003-20210625
x86_64               randconfig-a004-20210625
x86_64               randconfig-a006-20210625
i386                 randconfig-a002-20210625
i386                 randconfig-a001-20210625
i386                 randconfig-a003-20210625
i386                 randconfig-a006-20210625
i386                 randconfig-a005-20210625
i386                 randconfig-a004-20210625
x86_64               randconfig-a012-20210622
x86_64               randconfig-a016-20210622
x86_64               randconfig-a015-20210622
x86_64               randconfig-a014-20210622
x86_64               randconfig-a013-20210622
x86_64               randconfig-a011-20210622
i386                 randconfig-a011-20210625
i386                 randconfig-a014-20210625
i386                 randconfig-a013-20210625
i386                 randconfig-a015-20210625
i386                 randconfig-a012-20210625
i386                 randconfig-a016-20210625
i386                 randconfig-a011-20210622
i386                 randconfig-a014-20210622
i386                 randconfig-a013-20210622
i386                 randconfig-a015-20210622
i386                 randconfig-a012-20210622
i386                 randconfig-a016-20210622
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
um                            kunit_defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-b001-20210625
x86_64               randconfig-b001-20210622
x86_64               randconfig-a002-20210626
x86_64               randconfig-a001-20210626
x86_64               randconfig-a005-20210626
x86_64               randconfig-a003-20210626
x86_64               randconfig-a004-20210626
x86_64               randconfig-a006-20210626
x86_64               randconfig-a002-20210622
x86_64               randconfig-a001-20210622
x86_64               randconfig-a005-20210622
x86_64               randconfig-a003-20210622
x86_64               randconfig-a004-20210622
x86_64               randconfig-a006-20210622

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
