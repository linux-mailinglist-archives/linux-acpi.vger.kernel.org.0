Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 397CA258833
	for <lists+linux-acpi@lfdr.de>; Tue,  1 Sep 2020 08:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbgIAG2r (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 1 Sep 2020 02:28:47 -0400
Received: from mga12.intel.com ([192.55.52.136]:9801 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726521AbgIAG2r (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 1 Sep 2020 02:28:47 -0400
IronPort-SDR: bxgH18P7yI+ZJZQeDSSgUO7wrUn0jZVeWCTePDWShz+zavyFtq21ZZhWtRezi/bxjkWaHbw5Z2
 WQTEhIjwm8/Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9730"; a="136634004"
X-IronPort-AV: E=Sophos;i="5.76,378,1592895600"; 
   d="scan'208";a="136634004"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2020 23:28:46 -0700
IronPort-SDR: Cw09YFFMzPZUArOH2X8NxLQHd6lpLpcf2jFhwd0GLi2fpln9mbUcSnRPRXqp58zNxEfI8wAodG
 cZOJELsUBb6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,378,1592895600"; 
   d="scan'208";a="301330694"
Received: from lkp-server02.sh.intel.com (HELO 713faec3b0e5) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 31 Aug 2020 23:28:44 -0700
Received: from kbuild by 713faec3b0e5 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kCzme-0000an-4B; Tue, 01 Sep 2020 06:28:44 +0000
Date:   Tue, 01 Sep 2020 14:28:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [pm:bleeding-edge] BUILD SUCCESS
 13f46f822831fb135644e4d61137fd4d53c9c0ad
Message-ID: <5f4dea05.kZCzYZ8bPsvFZiK6%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git  bleeding-edge
branch HEAD: 13f46f822831fb135644e4d61137fd4d53c9c0ad  cpufreq: intel_pstate: Free memory only when turning off

elapsed time: 725m

configs tested: 103
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                         s3c6400_defconfig
ia64                            zx1_defconfig
m68k                          sun3x_defconfig
sh                           se7751_defconfig
arm                           u8500_defconfig
parisc                generic-32bit_defconfig
m68k                        mvme147_defconfig
powerpc                          allmodconfig
m68k                         apollo_defconfig
sh                          r7785rp_defconfig
powerpc                     mpc83xx_defconfig
arm                            u300_defconfig
powerpc                      pmac32_defconfig
arc                                 defconfig
parisc                           allyesconfig
arm                            zeus_defconfig
m68k                          atari_defconfig
arm                        cerfcube_defconfig
sh                     sh7710voipgw_defconfig
mips                      malta_kvm_defconfig
sh                         microdev_defconfig
mips                      bmips_stb_defconfig
arm                            mps2_defconfig
sh                           se7750_defconfig
sh                           se7206_defconfig
nios2                            allyesconfig
sh                ecovec24-romimage_defconfig
nios2                               defconfig
arm                       imx_v6_v7_defconfig
mips                           rs90_defconfig
mips                           gcw0_defconfig
arm                         bcm2835_defconfig
arc                            hsdk_defconfig
arm                         s5pv210_defconfig
powerpc                         wii_defconfig
sh                        sh7757lcr_defconfig
powerpc                      tqm8xx_defconfig
nios2                            alldefconfig
powerpc                      ppc64e_defconfig
sh                               alldefconfig
arm                           stm32_defconfig
mips                        jmr3927_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
nds32                               defconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
powerpc                             defconfig
i386                 randconfig-a001-20200831
i386                 randconfig-a002-20200831
i386                 randconfig-a004-20200831
i386                 randconfig-a006-20200831
i386                 randconfig-a005-20200831
i386                 randconfig-a003-20200831
x86_64               randconfig-a012-20200831
x86_64               randconfig-a015-20200831
x86_64               randconfig-a014-20200831
x86_64               randconfig-a011-20200831
x86_64               randconfig-a016-20200831
x86_64               randconfig-a013-20200831
i386                 randconfig-a013-20200831
i386                 randconfig-a011-20200831
i386                 randconfig-a012-20200831
i386                 randconfig-a015-20200831
i386                 randconfig-a016-20200831
i386                 randconfig-a014-20200831
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
