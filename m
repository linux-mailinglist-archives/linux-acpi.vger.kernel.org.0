Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E8B225A65F
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Sep 2020 09:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbgIBHVx (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 2 Sep 2020 03:21:53 -0400
Received: from mga12.intel.com ([192.55.52.136]:6613 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726130AbgIBHVw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 2 Sep 2020 03:21:52 -0400
IronPort-SDR: /hfAT/Jl8scjlII55hsj4ih4CbEvPIxscAG5RKmTtnG48DFCjHzt3GNJxqLzIiufLHP7cZasHW
 p9WQ1Hu05JJg==
X-IronPort-AV: E=McAfee;i="6000,8403,9731"; a="136853159"
X-IronPort-AV: E=Sophos;i="5.76,381,1592895600"; 
   d="scan'208";a="136853159"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2020 00:21:45 -0700
IronPort-SDR: Z7GrvDM/cBMVIzZ7UXbLoeVo/LJC8bEk/wyWGhczdy+INdp3kVqYq8gvUG1vvXTxc41o2dludi
 o+QA/X87ZDTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,381,1592895600"; 
   d="scan'208";a="405068649"
Received: from lkp-server02.sh.intel.com (HELO f0c22d07a430) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 02 Sep 2020 00:21:43 -0700
Received: from kbuild by f0c22d07a430 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kDN5S-000029-Sk; Wed, 02 Sep 2020 07:21:42 +0000
Date:   Wed, 02 Sep 2020 15:21:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [pm:bleeding-edge] BUILD SUCCESS
 7eada1ae101b2de8a32fb7125db0162b00965d48
Message-ID: <5f4f47f6.s2YfTcbKz+FOq38u%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git  bleeding-edge
branch HEAD: 7eada1ae101b2de8a32fb7125db0162b00965d48  Merge branch 'pm-cpufreq' into linux-next

elapsed time: 722m

configs tested: 159
configs skipped: 14

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
sh                           se7206_defconfig
mips                 pnx8335_stb225_defconfig
arm                            mmp2_defconfig
sh                           sh2007_defconfig
sh                        edosk7705_defconfig
mips                      bmips_stb_defconfig
sh                             espt_defconfig
mips                           rs90_defconfig
c6x                        evmc6474_defconfig
powerpc                           allnoconfig
arm                         shannon_defconfig
arm                     eseries_pxa_defconfig
arm                      footbridge_defconfig
riscv                             allnoconfig
sh                            migor_defconfig
sh                          rsk7264_defconfig
powerpc                      mgcoge_defconfig
sh                          r7780mp_defconfig
sh                           se7712_defconfig
sparc                       sparc64_defconfig
powerpc                             defconfig
arm                             pxa_defconfig
arm                          gemini_defconfig
microblaze                    nommu_defconfig
s390                       zfcpdump_defconfig
arm                        clps711x_defconfig
powerpc                    mvme5100_defconfig
sh                   sh7770_generic_defconfig
sh                           se7343_defconfig
arm                           efm32_defconfig
arm                        shmobile_defconfig
sh                         microdev_defconfig
arm                             rpc_defconfig
powerpc                      ppc40x_defconfig
powerpc                  mpc885_ads_defconfig
arm                       imx_v6_v7_defconfig
c6x                                 defconfig
ia64                         bigsur_defconfig
mips                        bcm63xx_defconfig
sh                          rsk7269_defconfig
ia64                                defconfig
sh                  sh7785lcr_32bit_defconfig
arm                         hackkit_defconfig
arm                        mvebu_v5_defconfig
xtensa                       common_defconfig
arm                            lart_defconfig
arm                      pxa255-idp_defconfig
arm                         mv78xx0_defconfig
arm                         s3c2410_defconfig
arm                              alldefconfig
riscv                    nommu_k210_defconfig
nios2                         3c120_defconfig
m68k                             alldefconfig
m68k                       m5475evb_defconfig
sh                ecovec24-romimage_defconfig
powerpc                  storcenter_defconfig
mips                         tb0287_defconfig
mips                     cu1000-neo_defconfig
mips                          malta_defconfig
powerpc                    gamecube_defconfig
mips                      malta_kvm_defconfig
m68k                       m5249evb_defconfig
x86_64                              defconfig
sh                          kfr2r09_defconfig
arm                       aspeed_g5_defconfig
m68k                        stmark2_defconfig
nds32                               defconfig
sh                          r7785rp_defconfig
mips                         tb0226_defconfig
xtensa                         virt_defconfig
mips                         tb0219_defconfig
arm                          moxart_defconfig
arc                              allyesconfig
arm                        magician_defconfig
nds32                            alldefconfig
mips                    maltaup_xpa_defconfig
arm                            dove_defconfig
powerpc                     mpc512x_defconfig
arm                            qcom_defconfig
mips                          rm200_defconfig
arc                         haps_hs_defconfig
powerpc                      ppc64e_defconfig
arm                          ixp4xx_defconfig
mips                         cobalt_defconfig
powerpc                       maple_defconfig
arm                          simpad_defconfig
sh                          rsk7201_defconfig
arm                         nhk8815_defconfig
mips                         bigsur_defconfig
arm                        realview_defconfig
mips                           ip28_defconfig
sh                          polaris_defconfig
m68k                            q40_defconfig
sparc                            allyesconfig
mips                 decstation_r4k_defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
nds32                             allnoconfig
c6x                              allyesconfig
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
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
x86_64               randconfig-a004-20200901
x86_64               randconfig-a006-20200901
x86_64               randconfig-a003-20200901
x86_64               randconfig-a005-20200901
x86_64               randconfig-a001-20200901
x86_64               randconfig-a002-20200901
i386                 randconfig-a004-20200901
i386                 randconfig-a005-20200901
i386                 randconfig-a006-20200901
i386                 randconfig-a002-20200901
i386                 randconfig-a001-20200901
i386                 randconfig-a003-20200901
i386                 randconfig-a016-20200901
i386                 randconfig-a015-20200901
i386                 randconfig-a011-20200901
i386                 randconfig-a013-20200901
i386                 randconfig-a014-20200901
i386                 randconfig-a012-20200901
riscv                            allyesconfig
riscv                               defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a013-20200901
x86_64               randconfig-a016-20200901
x86_64               randconfig-a011-20200901
x86_64               randconfig-a012-20200901
x86_64               randconfig-a015-20200901
x86_64               randconfig-a014-20200901

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
