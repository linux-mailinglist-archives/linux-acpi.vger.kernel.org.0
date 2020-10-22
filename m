Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1261A2956D0
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Oct 2020 05:32:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2444015AbgJVDcB (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 21 Oct 2020 23:32:01 -0400
Received: from mga04.intel.com ([192.55.52.120]:3314 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2443991AbgJVDcB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 21 Oct 2020 23:32:01 -0400
IronPort-SDR: RNxXdYcu2/3gc4U6NsmomHheXSIvqjLzAYQhKyJD7Z9zOWBI7chzs5OzI/quUxsPP5SDUQN3iA
 zoWdOuyQIe8Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9781"; a="164872709"
X-IronPort-AV: E=Sophos;i="5.77,403,1596524400"; 
   d="scan'208";a="164872709"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2020 20:32:00 -0700
IronPort-SDR: DUnhtbEx70I9G1Oq6EFRSo0dnJfAAPUXF0LJnLKPFRi8hBeY8QFPXxARBaxswp1CuN/OvR36jO
 7yvPOn8b6cSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,403,1596524400"; 
   d="scan'208";a="316584427"
Received: from lkp-server02.sh.intel.com (HELO 911c2f167757) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 21 Oct 2020 20:31:58 -0700
Received: from kbuild by 911c2f167757 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kVRKX-0000Fh-BO; Thu, 22 Oct 2020 03:31:57 +0000
Date:   Thu, 22 Oct 2020 11:31:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [pm:bleeding-edge] BUILD SUCCESS
 3b1afc4e84bf23d1eae93594fc52591e73519f96
Message-ID: <5f90fd28.0YpCulG29qn9NDli%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git  bleeding-edge
branch HEAD: 3b1afc4e84bf23d1eae93594fc52591e73519f96  Merge branch 'pm-core' into linux-next

elapsed time: 721m

configs tested: 136
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm                              allyesconfig
arm                              allmodconfig
arm64                               defconfig
powerpc                   motionpro_defconfig
powerpc                   bluestone_defconfig
arm                        neponset_defconfig
powerpc                      ppc64e_defconfig
powerpc                     sbc8548_defconfig
mips                    maltaup_xpa_defconfig
powerpc                     mpc5200_defconfig
powerpc                    gamecube_defconfig
arm                           tegra_defconfig
sh                             shx3_defconfig
um                            kunit_defconfig
sh                        edosk7705_defconfig
arm                       mainstone_defconfig
arm                        spear6xx_defconfig
arm                            dove_defconfig
arm                            mps2_defconfig
arm                        multi_v7_defconfig
sh                           se7721_defconfig
powerpc                      mgcoge_defconfig
sh                          r7785rp_defconfig
m68k                       bvme6000_defconfig
microblaze                    nommu_defconfig
powerpc                    amigaone_defconfig
arm                            xcep_defconfig
powerpc                     sequoia_defconfig
mips                        vocore2_defconfig
mips                           ip22_defconfig
powerpc                         ps3_defconfig
sh                         ap325rxa_defconfig
mips                        maltaup_defconfig
powerpc                     stx_gp3_defconfig
mips                      malta_kvm_defconfig
powerpc                    mvme5100_defconfig
arm                             rpc_defconfig
arm                     am200epdkit_defconfig
arm                         hackkit_defconfig
sh                ecovec24-romimage_defconfig
arm                           u8500_defconfig
openrisc                 simple_smp_defconfig
arm                             pxa_defconfig
xtensa                    xip_kc705_defconfig
mips                        qi_lb60_defconfig
ia64                            zx1_defconfig
xtensa                  cadence_csp_defconfig
arm                    vt8500_v6_v7_defconfig
powerpc                  mpc866_ads_defconfig
sh                          urquell_defconfig
arm                          gemini_defconfig
powerpc                     tqm8548_defconfig
alpha                               defconfig
sh                            hp6xx_defconfig
sh                   rts7751r2dplus_defconfig
sh                          lboxre2_defconfig
powerpc                 mpc836x_rdk_defconfig
mips                          rm200_defconfig
powerpc                      cm5200_defconfig
parisc                generic-32bit_defconfig
sh                             sh03_defconfig
c6x                                 defconfig
powerpc                          g5_defconfig
m68k                        m5272c3_defconfig
xtensa                           alldefconfig
powerpc                     ksi8560_defconfig
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
x86_64               randconfig-a001-20201021
x86_64               randconfig-a002-20201021
x86_64               randconfig-a003-20201021
x86_64               randconfig-a006-20201021
x86_64               randconfig-a005-20201021
x86_64               randconfig-a004-20201021
i386                 randconfig-a002-20201021
i386                 randconfig-a005-20201021
i386                 randconfig-a003-20201021
i386                 randconfig-a001-20201021
i386                 randconfig-a006-20201021
i386                 randconfig-a004-20201021
i386                 randconfig-a016-20201021
i386                 randconfig-a014-20201021
i386                 randconfig-a015-20201021
i386                 randconfig-a013-20201021
i386                 randconfig-a012-20201021
i386                 randconfig-a011-20201021
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
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
x86_64               randconfig-a011-20201021
x86_64               randconfig-a013-20201021
x86_64               randconfig-a016-20201021
x86_64               randconfig-a015-20201021
x86_64               randconfig-a012-20201021
x86_64               randconfig-a014-20201021

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
