Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FDAC3FDA07
	for <lists+linux-acpi@lfdr.de>; Wed,  1 Sep 2021 15:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244331AbhIAM3w (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 1 Sep 2021 08:29:52 -0400
Received: from mga07.intel.com ([134.134.136.100]:35131 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244180AbhIAM3Y (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 1 Sep 2021 08:29:24 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10093"; a="282448397"
X-IronPort-AV: E=Sophos;i="5.84,369,1620716400"; 
   d="scan'208";a="282448397"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2021 05:27:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,369,1620716400"; 
   d="scan'208";a="690650862"
Received: from lkp-server01.sh.intel.com (HELO 4fbc2b3ce5aa) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 01 Sep 2021 05:27:56 -0700
Received: from kbuild by 4fbc2b3ce5aa with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mLPLP-0007tk-SE; Wed, 01 Sep 2021 12:27:55 +0000
Date:   Wed, 01 Sep 2021 20:27:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [pm:bleeding-edge] BUILD SUCCESS
 103d2fac60d07d241340ddcfdc1450896ac39e09
Message-ID: <612f71b3./Xh/8XiBI7cMyYx5%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 103d2fac60d07d241340ddcfdc1450896ac39e09  Merge branches 'pm-opp' and 'pm-cpufreq' into linux-next

elapsed time: 1434m

configs tested: 143
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20210831
mips                        workpad_defconfig
i386                             alldefconfig
powerpc                    mvme5100_defconfig
sh                            titan_defconfig
arm                           u8500_defconfig
powerpc                     redwood_defconfig
sparc                            alldefconfig
arc                           tb10x_defconfig
riscv             nommu_k210_sdcard_defconfig
arc                     nsimosci_hs_defconfig
arm                        trizeps4_defconfig
nds32                            alldefconfig
mips                           ip27_defconfig
powerpc                 xes_mpc85xx_defconfig
mips                           jazz_defconfig
arm                         vf610m4_defconfig
mips                      maltaaprp_defconfig
sh                           se7750_defconfig
powerpc                   lite5200b_defconfig
arm                            mmp2_defconfig
arm                             rpc_defconfig
csky                             alldefconfig
arc                                 defconfig
arm                         lpc32xx_defconfig
powerpc                       eiger_defconfig
mips                        nlm_xlp_defconfig
mips                           mtx1_defconfig
arm                   milbeaut_m10v_defconfig
powerpc                     tqm8560_defconfig
arm                           viper_defconfig
arm                         hackkit_defconfig
sh                                  defconfig
xtensa                       common_defconfig
xtensa                  nommu_kc705_defconfig
sh                          lboxre2_defconfig
powerpc                    sam440ep_defconfig
arm                         socfpga_defconfig
sh                        sh7757lcr_defconfig
s390                       zfcpdump_defconfig
powerpc               mpc834x_itxgp_defconfig
arm                             mxs_defconfig
arc                          axs101_defconfig
openrisc                         alldefconfig
mips                           ip32_defconfig
mips                        bcm63xx_defconfig
arc                        vdk_hs38_defconfig
m68k                        mvme16x_defconfig
sh                               j2_defconfig
arm                       versatile_defconfig
sh                            shmin_defconfig
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
powerpc                           allnoconfig
x86_64               randconfig-a005-20210831
x86_64               randconfig-a001-20210831
x86_64               randconfig-a003-20210831
x86_64               randconfig-a002-20210831
x86_64               randconfig-a004-20210831
x86_64               randconfig-a006-20210831
i386                 randconfig-a005-20210831
i386                 randconfig-a002-20210831
i386                 randconfig-a003-20210831
i386                 randconfig-a006-20210831
i386                 randconfig-a004-20210831
i386                 randconfig-a001-20210831
i386                 randconfig-a012-20210901
i386                 randconfig-a015-20210901
i386                 randconfig-a011-20210901
i386                 randconfig-a013-20210901
i386                 randconfig-a014-20210901
i386                 randconfig-a016-20210901
arc                  randconfig-r043-20210831
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
i386                 randconfig-c001-20210831
s390                 randconfig-c005-20210831
riscv                randconfig-c006-20210831
powerpc              randconfig-c003-20210831
mips                 randconfig-c004-20210831
arm                  randconfig-c002-20210831
x86_64               randconfig-c007-20210831
x86_64               randconfig-a014-20210831
x86_64               randconfig-a015-20210831
x86_64               randconfig-a013-20210831
x86_64               randconfig-a016-20210831
x86_64               randconfig-a012-20210831
x86_64               randconfig-a011-20210831
i386                 randconfig-a016-20210831
i386                 randconfig-a011-20210831
i386                 randconfig-a015-20210831
i386                 randconfig-a014-20210831
i386                 randconfig-a012-20210831
i386                 randconfig-a013-20210831
s390                 randconfig-r044-20210831
hexagon              randconfig-r041-20210831
hexagon              randconfig-r045-20210831
riscv                randconfig-r042-20210831

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
