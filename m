Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BE7E296A2C
	for <lists+linux-acpi@lfdr.de>; Fri, 23 Oct 2020 09:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S375668AbgJWHTd (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 23 Oct 2020 03:19:33 -0400
Received: from mga03.intel.com ([134.134.136.65]:4264 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S375667AbgJWHTd (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 23 Oct 2020 03:19:33 -0400
IronPort-SDR: U26DqdRpAYXC+56II940KWAhOjNkTYKAHe4Woqkm9i3OC7VlZHNX9FRDivLldL5siSYaCE3AEp
 TJjUNpa+C2yA==
X-IronPort-AV: E=McAfee;i="6000,8403,9782"; a="167734205"
X-IronPort-AV: E=Sophos;i="5.77,407,1596524400"; 
   d="scan'208";a="167734205"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2020 00:19:29 -0700
IronPort-SDR: DvYSmXdukfQKAyWVRhDnd+YKXcw0fvlY6zxQcX2JrQZY04BIfRjElkp3/idLmziCXYhM3AXKQt
 e/Tc+6K3cGEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,407,1596524400"; 
   d="scan'208";a="302675193"
Received: from lkp-server01.sh.intel.com (HELO 1f55bd7cde4b) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 23 Oct 2020 00:19:27 -0700
Received: from kbuild by 1f55bd7cde4b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kVrME-00006P-QZ; Fri, 23 Oct 2020 07:19:26 +0000
Date:   Fri, 23 Oct 2020 15:19:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [pm:bleeding-edge] BUILD SUCCESS
 54e1ca2a19234787050e494833aad6800f8ee645
Message-ID: <5f9283f3.us5z+Md+hkmv4U8n%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git  bleeding-edge
branch HEAD: 54e1ca2a19234787050e494833aad6800f8ee645  Merge branch 'acpi-utils' into linux-next

elapsed time: 720m

configs tested: 136
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                         lpc18xx_defconfig
arc                        vdk_hs38_defconfig
mips                      bmips_stb_defconfig
powerpc                      katmai_defconfig
mips                         cobalt_defconfig
powerpc                 mpc837x_mds_defconfig
mips                          ath79_defconfig
um                            kunit_defconfig
powerpc                     ppa8548_defconfig
powerpc                     akebono_defconfig
powerpc                     tqm8541_defconfig
sh                          kfr2r09_defconfig
powerpc                     tqm8555_defconfig
powerpc                      ppc40x_defconfig
mips                      malta_kvm_defconfig
arm                             mxs_defconfig
arc                        nsim_700_defconfig
powerpc                      ppc44x_defconfig
mips                         db1xxx_defconfig
sparc64                             defconfig
sh                           se7343_defconfig
h8300                               defconfig
sh                           se7780_defconfig
arm                            zeus_defconfig
sh                           se7722_defconfig
mips                     decstation_defconfig
arm                      jornada720_defconfig
sh                          lboxre2_defconfig
arm                           efm32_defconfig
sh                      rts7751r2d1_defconfig
i386                             alldefconfig
powerpc                    klondike_defconfig
arm                            pleb_defconfig
xtensa                              defconfig
arm                    vt8500_v6_v7_defconfig
powerpc                     redwood_defconfig
sh                             sh03_defconfig
sparc64                          alldefconfig
sh                     magicpanelr2_defconfig
arm                       aspeed_g4_defconfig
arm                          moxart_defconfig
mips                           jazz_defconfig
arm                          lpd270_defconfig
mips                            ar7_defconfig
riscv                    nommu_virt_defconfig
powerpc                      acadia_defconfig
sh                              ul2_defconfig
mips                  cavium_octeon_defconfig
xtensa                    xip_kc705_defconfig
m68k                        m5407c3_defconfig
sh                             espt_defconfig
arm                        realview_defconfig
arm                           spitz_defconfig
sh                               alldefconfig
m68k                        mvme16x_defconfig
mips                           rs90_defconfig
powerpc                     mpc512x_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
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
i386                 randconfig-a002-20201023
i386                 randconfig-a005-20201023
i386                 randconfig-a003-20201023
i386                 randconfig-a001-20201023
i386                 randconfig-a006-20201023
i386                 randconfig-a004-20201023
i386                 randconfig-a002-20201022
i386                 randconfig-a005-20201022
i386                 randconfig-a003-20201022
i386                 randconfig-a001-20201022
i386                 randconfig-a006-20201022
i386                 randconfig-a004-20201022
x86_64               randconfig-a011-20201022
x86_64               randconfig-a013-20201022
x86_64               randconfig-a016-20201022
x86_64               randconfig-a015-20201022
x86_64               randconfig-a012-20201022
x86_64               randconfig-a014-20201022
i386                 randconfig-a016-20201022
i386                 randconfig-a014-20201022
i386                 randconfig-a015-20201022
i386                 randconfig-a012-20201022
i386                 randconfig-a013-20201022
i386                 randconfig-a011-20201022
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a001-20201022
x86_64               randconfig-a002-20201022
x86_64               randconfig-a003-20201022
x86_64               randconfig-a006-20201022
x86_64               randconfig-a004-20201022
x86_64               randconfig-a005-20201022

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
