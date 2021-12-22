Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F26CE47CC73
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Dec 2021 06:21:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbhLVFVi (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 22 Dec 2021 00:21:38 -0500
Received: from mga07.intel.com ([134.134.136.100]:38764 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229493AbhLVFVh (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 22 Dec 2021 00:21:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640150497; x=1671686497;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=VwNmXX+4BJ1AN/HJF6sCMc+Q1DizaL01l6oxT4tLGYQ=;
  b=L5qaunZYRO48bph0vAZFitKD2fY7W2HiAGT0+w6G9Qzfgb4Shu0SYJjY
   KjDnz+VTf2IaNYHKX4fJCkkr+uk3H0p75J1Njs2Ha1uvMV4TD1qgE+I2k
   CAgvRLrUWABFnJGGSq3zpgjIPxpf8e1h6BOPORI5eiZgSQ6nrpmdni+35
   DyO4f+F6JP/lbnh3JMIxGIIstOCvMaSFDMc2vtlhOOefiWszNJiwRS0Lg
   jKNRIchzq1obU6vhtEikBNOfMKzYMpVlFJQsojh6GurdT8n4330Y9NK08
   mUFyKXqOqEkrh04P9Bia09RYfic7n9HGUOMW8tlCfUanxkm6bNmMrBevH
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10205"; a="303918093"
X-IronPort-AV: E=Sophos;i="5.88,225,1635231600"; 
   d="scan'208";a="303918093"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2021 21:21:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,225,1635231600"; 
   d="scan'208";a="617014112"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 21 Dec 2021 21:21:35 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mzu4E-00009I-VD; Wed, 22 Dec 2021 05:21:34 +0000
Date:   Wed, 22 Dec 2021 13:21:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 bd982f30deb7baab86095fc89f33954f10dcc387
Message-ID: <61c2b5c5.9H1FqZT2VbxijcVs%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: bd982f30deb7baab86095fc89f33954f10dcc387  Merge branches 'thermal-tools' and 'thermal-int340x' into linux-next

elapsed time: 722m

configs tested: 137
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                               defconfig
arm                                 defconfig
arm64                            allyesconfig
arm                              allyesconfig
arm                              allmodconfig
arm                       imx_v4_v5_defconfig
arm                          exynos_defconfig
riscv                               defconfig
powerpc                 mpc837x_mds_defconfig
arm                          pxa910_defconfig
mips                        bcm63xx_defconfig
sh                             espt_defconfig
mips                     loongson1c_defconfig
arm                        realview_defconfig
powerpc                  storcenter_defconfig
sh                        edosk7705_defconfig
arm                         cm_x300_defconfig
mips                malta_qemu_32r6_defconfig
sh                           se7712_defconfig
m68k                       m5275evb_defconfig
powerpc                      ppc44x_defconfig
arm                              alldefconfig
mips                         rt305x_defconfig
mips                           gcw0_defconfig
mips                       bmips_be_defconfig
powerpc                     skiroot_defconfig
mips                      maltaaprp_defconfig
arm                          ixp4xx_defconfig
mips                      bmips_stb_defconfig
sh                            shmin_defconfig
um                               alldefconfig
nds32                             allnoconfig
sh                           se7206_defconfig
mips                        jmr3927_defconfig
mips                       capcella_defconfig
powerpc                 canyonlands_defconfig
sh                        dreamcast_defconfig
mips                           ci20_defconfig
m68k                            q40_defconfig
powerpc                   lite5200b_defconfig
arm                          pcm027_defconfig
powerpc                      katmai_defconfig
arm                         assabet_defconfig
arm                             pxa_defconfig
powerpc                     pseries_defconfig
m68k                          sun3x_defconfig
sparc64                             defconfig
powerpc                     tqm8540_defconfig
um                                  defconfig
sh                          urquell_defconfig
sh                         microdev_defconfig
arm                            mps2_defconfig
sh                         ecovec24_defconfig
arm                      jornada720_defconfig
arm                            zeus_defconfig
powerpc                    amigaone_defconfig
s390                             alldefconfig
powerpc                     mpc83xx_defconfig
openrisc                    or1ksim_defconfig
sh                           se7721_defconfig
arm                  randconfig-c002-20211220
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
nios2                               defconfig
arc                              allyesconfig
nds32                               defconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
nios2                            allyesconfig
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
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a001-20211220
x86_64               randconfig-a003-20211220
x86_64               randconfig-a005-20211220
x86_64               randconfig-a006-20211220
x86_64               randconfig-a004-20211220
x86_64               randconfig-a002-20211220
i386                 randconfig-a006-20211220
i386                 randconfig-a004-20211220
i386                 randconfig-a002-20211220
i386                 randconfig-a003-20211220
i386                 randconfig-a005-20211220
i386                 randconfig-a001-20211220
arc                  randconfig-r043-20211220
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a013-20211220
x86_64               randconfig-a015-20211220
x86_64               randconfig-a014-20211220
x86_64               randconfig-a012-20211220
x86_64               randconfig-a011-20211220
x86_64               randconfig-a016-20211220
i386                 randconfig-a012-20211220
i386                 randconfig-a011-20211220
i386                 randconfig-a014-20211220
i386                 randconfig-a016-20211220
i386                 randconfig-a015-20211220
i386                 randconfig-a013-20211220
hexagon              randconfig-r041-20211220
hexagon              randconfig-r045-20211220
riscv                randconfig-r042-20211220
s390                 randconfig-r044-20211220

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
