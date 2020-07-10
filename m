Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8342121ACD4
	for <lists+linux-acpi@lfdr.de>; Fri, 10 Jul 2020 04:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbgGJCDw (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 9 Jul 2020 22:03:52 -0400
Received: from mga14.intel.com ([192.55.52.115]:8851 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726433AbgGJCDw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 9 Jul 2020 22:03:52 -0400
IronPort-SDR: CR77XXQuu6K7V/jYt1knDYKazOotBf5xfog2+G/u8CvAHZwLvHPb2sdS4OrSI1KJ9kxp3t02mV
 AEEEDQ+8s7wA==
X-IronPort-AV: E=McAfee;i="6000,8403,9677"; a="147228218"
X-IronPort-AV: E=Sophos;i="5.75,334,1589266800"; 
   d="scan'208";a="147228218"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2020 19:03:51 -0700
IronPort-SDR: 77DD6ETSzlocT+oir0d+ZxMHRXyysrjp2hkL4nyOVg/ig8ToH9aGwYGF3KbSw7vecdbap4poVy
 K1cRIVtJvPDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,334,1589266800"; 
   d="scan'208";a="389328611"
Received: from lkp-server02.sh.intel.com (HELO d197edaadf32) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 09 Jul 2020 19:03:48 -0700
Received: from kbuild by d197edaadf32 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jtiOB-00000n-CL; Fri, 10 Jul 2020 02:03:47 +0000
Date:   Fri, 10 Jul 2020 10:03:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [pm:bleeding-edge] BUILD SUCCESS
 9d981feccfcf0782dbb65652bab5c757dd562dc6
Message-ID: <5f07cc6b.kX/LcFO0yrxzk81m%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git  bleeding-edge
branch HEAD: 9d981feccfcf0782dbb65652bab5c757dd562dc6  Merge branch 'powercap' into bleeding-edge

elapsed time: 741m

configs tested: 107
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

arm                                 defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                               allnoconfig
arm64                            allyesconfig
arm64                               defconfig
arm64                            allmodconfig
arm64                             allnoconfig
parisc                generic-64bit_defconfig
arm                      footbridge_defconfig
mips                    maltaup_xpa_defconfig
powerpc                    gamecube_defconfig
m68k                          hp300_defconfig
powerpc                  mpc866_ads_defconfig
powerpc64                           defconfig
um                             i386_defconfig
openrisc                         allyesconfig
sh                        edosk7705_defconfig
i386                              allnoconfig
i386                             allyesconfig
i386                                defconfig
i386                              debian-10.3
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
i386                 randconfig-a002-20200709
i386                 randconfig-a001-20200709
i386                 randconfig-a006-20200709
i386                 randconfig-a005-20200709
i386                 randconfig-a004-20200709
i386                 randconfig-a003-20200709
x86_64               randconfig-a012-20200709
x86_64               randconfig-a016-20200709
x86_64               randconfig-a011-20200709
x86_64               randconfig-a014-20200709
x86_64               randconfig-a013-20200709
x86_64               randconfig-a015-20200709
i386                 randconfig-a011-20200709
i386                 randconfig-a015-20200709
i386                 randconfig-a014-20200709
i386                 randconfig-a016-20200709
i386                 randconfig-a012-20200709
i386                 randconfig-a013-20200709
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
