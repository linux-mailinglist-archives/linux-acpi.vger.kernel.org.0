Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD492047F4
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Jun 2020 05:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731118AbgFWDas (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 22 Jun 2020 23:30:48 -0400
Received: from mga01.intel.com ([192.55.52.88]:37359 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731041AbgFWDar (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 22 Jun 2020 23:30:47 -0400
IronPort-SDR: e97n6scrqdZTvJTgMfHz8Bt2afu+BgbfyFoUx4kgsJvzm3xg6+FTflNUwhM52wjswMIuu8Ol/N
 zplhYS823BMw==
X-IronPort-AV: E=McAfee;i="6000,8403,9660"; a="162028084"
X-IronPort-AV: E=Sophos;i="5.75,269,1589266800"; 
   d="scan'208";a="162028084"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2020 20:30:46 -0700
IronPort-SDR: gUeYtFDqiFigNyzgQ7a/un72k0V6ut8TjWK+DuNbEceZjv/+9UgKOpXIRZ8WJcw7ZKTZlxDPZN
 QlWzesx8hexw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,269,1589266800"; 
   d="scan'208";a="263178407"
Received: from lkp-server01.sh.intel.com (HELO f484c95e4fd1) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 22 Jun 2020 20:30:44 -0700
Received: from kbuild by f484c95e4fd1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jnZdz-0000aY-SD; Tue, 23 Jun 2020 03:30:43 +0000
Date:   Tue, 23 Jun 2020 11:30:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [pm:bleeding-edge] BUILD SUCCESS
 0d62e7bd3feab497ce3b148fc279e393bf4ba775
Message-ID: <5ef17739.gydh2Go6Jo2RR0f5%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git  bleeding-edge
branch HEAD: 0d62e7bd3feab497ce3b148fc279e393bf4ba775  Merge branch 'acpi-sysfs-next' into bleeding-edge

elapsed time: 726m

configs tested: 107
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

arm64                            allyesconfig
arm64                               defconfig
arm64                            allmodconfig
arm64                             allnoconfig
arm                                 defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                               allnoconfig
mips                malta_kvm_guest_defconfig
arm                         s3c6400_defconfig
xtensa                           alldefconfig
sh                  sh7785lcr_32bit_defconfig
xtensa                    xip_kc705_defconfig
arm                        keystone_defconfig
arm                       versatile_defconfig
m68k                            mac_defconfig
sh                           sh2007_defconfig
i386                             allyesconfig
i386                                defconfig
i386                              debian-10.3
i386                              allnoconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                              allnoconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                              allnoconfig
m68k                           sun3_defconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
nios2                            allyesconfig
openrisc                            defconfig
c6x                              allyesconfig
c6x                               allnoconfig
openrisc                         allyesconfig
nds32                               defconfig
nds32                             allnoconfig
csky                             allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
h8300                            allmodconfig
xtensa                              defconfig
arc                                 defconfig
arc                              allyesconfig
sh                               allmodconfig
sh                                allnoconfig
microblaze                        allnoconfig
mips                             allyesconfig
mips                              allnoconfig
mips                             allmodconfig
parisc                            allnoconfig
parisc                              defconfig
parisc                           allyesconfig
parisc                           allmodconfig
powerpc                             defconfig
powerpc                          allyesconfig
powerpc                          rhel-kconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a006-20200622
i386                 randconfig-a002-20200622
i386                 randconfig-a003-20200622
i386                 randconfig-a001-20200622
i386                 randconfig-a005-20200622
i386                 randconfig-a004-20200622
x86_64               randconfig-a004-20200622
x86_64               randconfig-a002-20200622
x86_64               randconfig-a003-20200622
x86_64               randconfig-a005-20200622
x86_64               randconfig-a001-20200622
x86_64               randconfig-a006-20200622
i386                 randconfig-a013-20200622
i386                 randconfig-a016-20200622
i386                 randconfig-a012-20200622
i386                 randconfig-a014-20200622
i386                 randconfig-a015-20200622
i386                 randconfig-a011-20200622
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
s390                             allyesconfig
s390                              allnoconfig
s390                             allmodconfig
s390                                defconfig
sparc                            allyesconfig
sparc                               defconfig
sparc64                             defconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
sparc64                          allmodconfig
um                               allmodconfig
um                                allnoconfig
um                               allyesconfig
um                                  defconfig
x86_64                               rhel-7.6
x86_64                    rhel-7.6-kselftests
x86_64                               rhel-8.3
x86_64                                  kexec
x86_64                                   rhel
x86_64                         rhel-7.2-clear
x86_64                                    lkp
x86_64                              fedora-25

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
