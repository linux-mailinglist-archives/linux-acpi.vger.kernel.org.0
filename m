Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C5B2253B78
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Aug 2020 03:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbgH0Bhg (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 26 Aug 2020 21:37:36 -0400
Received: from mga12.intel.com ([192.55.52.136]:41677 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726784AbgH0Bhf (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 26 Aug 2020 21:37:35 -0400
IronPort-SDR: h48TaLE4d2+zniE4rq3go7DBy/qqQOgioP81jW4A+Y/5UvNOdS/yArCICIGFYLGz/+BrG91NcA
 PRSGKNSwSRug==
X-IronPort-AV: E=McAfee;i="6000,8403,9725"; a="135956593"
X-IronPort-AV: E=Sophos;i="5.76,358,1592895600"; 
   d="scan'208";a="135956593"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2020 18:37:34 -0700
IronPort-SDR: 5XFhXibLbpkIMpHcBNhIumgI44vHd78teNWOrHXR9SBkGjZKV8PLc/lfyrkmsvt1GmVYtyc/aB
 9zaRozIYYY4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,358,1592895600"; 
   d="scan'208";a="337009847"
Received: from lkp-server01.sh.intel.com (HELO 4f455964fc6c) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 26 Aug 2020 18:37:32 -0700
Received: from kbuild by 4f455964fc6c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kB6r6-0001o5-21; Thu, 27 Aug 2020 01:37:32 +0000
Date:   Thu, 27 Aug 2020 09:36:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [pm:bleeding-edge] BUILD SUCCESS
 fe784821d630f71eee1f431f10e08518db42dc02
Message-ID: <5f470e37.8DkUgOSXArNPoJai%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git  bleeding-edge
branch HEAD: fe784821d630f71eee1f431f10e08518db42dc02  Merge branch 'pm-sleep' into linux-next

elapsed time: 720m

configs tested: 171
configs skipped: 9

The following configs have been built successfully.
More configs may be tested in the coming days.

arm                                 defconfig
arm64                            allyesconfig
arm                              allyesconfig
arm                              allmodconfig
arm64                               defconfig
mips                      fuloong2e_defconfig
arm                          pxa910_defconfig
arc                          axs103_defconfig
mips                        workpad_defconfig
mips                        maltaup_defconfig
sh                   rts7751r2dplus_defconfig
arm                        oxnas_v6_defconfig
sh                        edosk7705_defconfig
arm                         ebsa110_defconfig
m68k                          sun3x_defconfig
mips                       capcella_defconfig
openrisc                    or1ksim_defconfig
mips                      maltaaprp_defconfig
powerpc                     pseries_defconfig
arm                        mvebu_v7_defconfig
c6x                        evmc6472_defconfig
arm                       multi_v4t_defconfig
arm                          simpad_defconfig
sh                          lboxre2_defconfig
arm                            zeus_defconfig
m68k                            q40_defconfig
arm                              zx_defconfig
mips                        jmr3927_defconfig
sh                        sh7757lcr_defconfig
mips                      malta_kvm_defconfig
mips                           jazz_defconfig
arm                        multi_v5_defconfig
riscv                            allmodconfig
m68k                         apollo_defconfig
sh                ecovec24-romimage_defconfig
sh                        apsh4ad0a_defconfig
arm                       spear13xx_defconfig
arm                        trizeps4_defconfig
m68k                       m5249evb_defconfig
arm                         palmz72_defconfig
m68k                          multi_defconfig
arc                                 defconfig
powerpc                    adder875_defconfig
sh                           se7751_defconfig
powerpc                          g5_defconfig
mips                     loongson1c_defconfig
ia64                          tiger_defconfig
mips                         cobalt_defconfig
sh                           se7722_defconfig
sh                   sh7770_generic_defconfig
mips                         tb0226_defconfig
powerpc                     skiroot_defconfig
x86_64                              defconfig
c6x                        evmc6474_defconfig
mips                malta_kvm_guest_defconfig
sh                          sdk7780_defconfig
sh                         apsh4a3a_defconfig
mips                           mtx1_defconfig
powerpc                          alldefconfig
arm                         lpc18xx_defconfig
sh                          urquell_defconfig
mips                         bigsur_defconfig
ia64                            zx1_defconfig
arm                      integrator_defconfig
powerpc                 mpc8272_ads_defconfig
arm                          ixp4xx_defconfig
sparc                       sparc64_defconfig
arm                          iop32x_defconfig
arm                           tegra_defconfig
arm                            mps2_defconfig
arm                            qcom_defconfig
sh                          kfr2r09_defconfig
mips                          rb532_defconfig
arm                            dove_defconfig
mips                          ath25_defconfig
powerpc                         wii_defconfig
m68k                        stmark2_defconfig
sh                                  defconfig
arc                    vdk_hs38_smp_defconfig
arc                             nps_defconfig
arm                  colibri_pxa270_defconfig
mips                         rt305x_defconfig
xtensa                generic_kc705_defconfig
ia64                        generic_defconfig
x86_64                           alldefconfig
arm                          pxa3xx_defconfig
sh                             sh03_defconfig
mips                 decstation_r4k_defconfig
arc                     nsimosci_hs_defconfig
mips                malta_qemu_32r6_defconfig
mips                         mpc30x_defconfig
arm                          collie_defconfig
arc                 nsimosci_hs_smp_defconfig
xtensa                          iss_defconfig
arm                         lubbock_defconfig
powerpc                  storcenter_defconfig
ia64                      gensparse_defconfig
arm                           viper_defconfig
mips                        bcm47xx_defconfig
sh                            shmin_defconfig
sh                     sh7710voipgw_defconfig
mips                  cavium_octeon_defconfig
nios2                         10m50_defconfig
arm                            mmp2_defconfig
m68k                       m5275evb_defconfig
m68k                           sun3_defconfig
sh                          sdk7786_defconfig
mips                       rbtx49xx_defconfig
sh                  sh7785lcr_32bit_defconfig
arm                         orion5x_defconfig
sh                           se7206_defconfig
sh                          r7785rp_defconfig
arm                           h5000_defconfig
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
powerpc                             defconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a002-20200826
i386                 randconfig-a004-20200826
i386                 randconfig-a003-20200826
i386                 randconfig-a005-20200826
i386                 randconfig-a006-20200826
i386                 randconfig-a001-20200826
x86_64               randconfig-a015-20200826
x86_64               randconfig-a016-20200826
x86_64               randconfig-a012-20200826
x86_64               randconfig-a014-20200826
x86_64               randconfig-a011-20200826
x86_64               randconfig-a013-20200826
i386                 randconfig-a013-20200826
i386                 randconfig-a012-20200826
i386                 randconfig-a011-20200826
i386                 randconfig-a016-20200826
i386                 randconfig-a015-20200826
i386                 randconfig-a014-20200826
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                               rhel-8.3
x86_64                                  kexec

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
