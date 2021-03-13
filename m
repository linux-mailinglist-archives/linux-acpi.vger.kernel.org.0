Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB355339C83
	for <lists+linux-acpi@lfdr.de>; Sat, 13 Mar 2021 08:17:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbhCMHQN (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 13 Mar 2021 02:16:13 -0500
Received: from mga11.intel.com ([192.55.52.93]:12270 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230309AbhCMHPx (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sat, 13 Mar 2021 02:15:53 -0500
IronPort-SDR: 2ndo3m4rVYs3omNgsRasE97SPIb4w2Fc+6hHQ/iNVJBmhfspvR6lZwZurXNG4G5QvOvGMp32n9
 M+lkVDCdHb/Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9921"; a="185568146"
X-IronPort-AV: E=Sophos;i="5.81,245,1610438400"; 
   d="scan'208";a="185568146"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2021 23:15:53 -0800
IronPort-SDR: n+xzo1uxc/WbYHxcN01yEu/1HoU7YFgnsohc1aMoSj3cHu/zHOEZAK3se6ZBAnjZ+juVuWM5KV
 VbqTWSqeZxgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,245,1610438400"; 
   d="scan'208";a="387572143"
Received: from lkp-server02.sh.intel.com (HELO ce64c092ff93) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 12 Mar 2021 23:15:51 -0800
Received: from kbuild by ce64c092ff93 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lKyV4-0001tu-Ms; Sat, 13 Mar 2021 07:15:50 +0000
Date:   Sat, 13 Mar 2021 15:15:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [pm:bleeding-edge] BUILD SUCCESS
 42326a293954f11eadf31161b8315bf6dc2279da
Message-ID: <604c6680.9ASwrqJeUl3Ji5mc%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 42326a293954f11eadf31161b8315bf6dc2279da  Merge branch 'pm-opp' into linux-next

elapsed time: 722m

configs tested: 125
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
h8300                       h8s-sim_defconfig
arm                       imx_v4_v5_defconfig
powerpc                     tqm8541_defconfig
m68k                       m5475evb_defconfig
powerpc64                        alldefconfig
arm                             mxs_defconfig
h8300                     edosk2674_defconfig
sh                 kfr2r09-romimage_defconfig
arm                          iop32x_defconfig
arm                          badge4_defconfig
arc                    vdk_hs38_smp_defconfig
riscv                             allnoconfig
powerpc                 mpc85xx_cds_defconfig
sh                                  defconfig
powerpc64                           defconfig
xtensa                          iss_defconfig
sh                            hp6xx_defconfig
sh                     sh7710voipgw_defconfig
xtensa                         virt_defconfig
m68k                        m5407c3_defconfig
csky                             alldefconfig
sh                           sh2007_defconfig
sh                          r7785rp_defconfig
mips                    maltaup_xpa_defconfig
arm                         assabet_defconfig
arm                          ixp4xx_defconfig
arm                          pxa168_defconfig
m68k                          hp300_defconfig
powerpc                 linkstation_defconfig
powerpc                      walnut_defconfig
csky                                defconfig
powerpc                         ps3_defconfig
arm                         axm55xx_defconfig
arm                          moxart_defconfig
sh                             shx3_defconfig
mips                           gcw0_defconfig
m68k                             alldefconfig
sh                             espt_defconfig
powerpc                       eiger_defconfig
arm                          simpad_defconfig
xtensa                  cadence_csp_defconfig
arm                       imx_v6_v7_defconfig
mips                          malta_defconfig
mips                        jmr3927_defconfig
mips                       capcella_defconfig
m68k                       bvme6000_defconfig
nios2                         10m50_defconfig
sparc                       sparc64_defconfig
arc                           tb10x_defconfig
mips                         tb0226_defconfig
mips                     cu1830-neo_defconfig
riscv                            allyesconfig
sh                        edosk7705_defconfig
m68k                                defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
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
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a001-20210312
i386                 randconfig-a005-20210312
i386                 randconfig-a002-20210312
i386                 randconfig-a003-20210312
i386                 randconfig-a004-20210312
i386                 randconfig-a006-20210312
x86_64               randconfig-a011-20210312
x86_64               randconfig-a016-20210312
x86_64               randconfig-a013-20210312
x86_64               randconfig-a014-20210312
x86_64               randconfig-a015-20210312
x86_64               randconfig-a012-20210312
i386                 randconfig-a013-20210312
i386                 randconfig-a016-20210312
i386                 randconfig-a011-20210312
i386                 randconfig-a015-20210312
i386                 randconfig-a014-20210312
i386                 randconfig-a012-20210312
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a001-20210312
x86_64               randconfig-a003-20210312
x86_64               randconfig-a002-20210312
x86_64               randconfig-a004-20210312
x86_64               randconfig-a006-20210312
x86_64               randconfig-a005-20210312

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
