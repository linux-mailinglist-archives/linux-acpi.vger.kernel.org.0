Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 199E51F00F8
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Jun 2020 22:31:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728130AbgFEUbE (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 5 Jun 2020 16:31:04 -0400
Received: from mga12.intel.com ([192.55.52.136]:19950 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727888AbgFEUbE (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 5 Jun 2020 16:31:04 -0400
IronPort-SDR: xMNEOeWJ9SU+AihKHHlrs0yTcSQri0aUklQZ4EveFvGwMudxVuAne+YKgdZCltq8GviiF61+lo
 GGYE2FCGgVQg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2020 13:31:03 -0700
IronPort-SDR: pwsKWOtCQmVoAe3oNneWMuF2iH8nJAWheywWnYTF+WEgsXGxw9eYjkF9gncwffGnz/HMBI0c7d
 Rmjxw3QrPy5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,477,1583222400"; 
   d="scan'208";a="446015406"
Received: from lkp-server02.sh.intel.com (HELO 85fa322b0eb2) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 05 Jun 2020 13:31:01 -0700
Received: from kbuild by 85fa322b0eb2 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jhIzU-0000Nd-Rw; Fri, 05 Jun 2020 20:31:00 +0000
Date:   Sat, 06 Jun 2020 04:29:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [pm:bleeding-edge] BUILD SUCCESS
 1e4a104be0a3afafbafc13bacc5f42007db8d43e
Message-ID: <5edaab47.BGrzd29tN8xz8E0X%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git  bleeding-edge
branch HEAD: 1e4a104be0a3afafbafc13bacc5f42007db8d43e  Merge branch 'pm-cpufreq' into bleeding-edge

elapsed time: 484m

configs tested: 97
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
nds32                               defconfig
nds32                             allnoconfig
csky                             allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
nios2                               defconfig
nios2                            allyesconfig
openrisc                            defconfig
c6x                              allyesconfig
c6x                               allnoconfig
openrisc                         allyesconfig
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
x86_64               randconfig-a002-20200605
x86_64               randconfig-a001-20200605
x86_64               randconfig-a006-20200605
x86_64               randconfig-a003-20200605
x86_64               randconfig-a004-20200605
x86_64               randconfig-a005-20200605
i386                 randconfig-a001-20200605
i386                 randconfig-a006-20200605
i386                 randconfig-a002-20200605
i386                 randconfig-a005-20200605
i386                 randconfig-a004-20200605
i386                 randconfig-a003-20200605
i386                 randconfig-a014-20200605
i386                 randconfig-a015-20200605
i386                 randconfig-a011-20200605
i386                 randconfig-a016-20200605
i386                 randconfig-a012-20200605
i386                 randconfig-a013-20200605
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
um                                  defconfig
um                               allyesconfig
x86_64                                   rhel
x86_64                               rhel-7.6
x86_64                    rhel-7.6-kselftests
x86_64                         rhel-7.2-clear
x86_64                                    lkp
x86_64                              fedora-25
x86_64                                  kexec

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
