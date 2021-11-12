Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F13ED44E093
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Nov 2021 03:55:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234496AbhKLC6A (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 11 Nov 2021 21:58:00 -0500
Received: from mga05.intel.com ([192.55.52.43]:47451 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229908AbhKLC6A (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 11 Nov 2021 21:58:00 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10165"; a="319266567"
X-IronPort-AV: E=Sophos;i="5.87,227,1631602800"; 
   d="scan'208";a="319266567"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2021 18:55:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,227,1631602800"; 
   d="scan'208";a="452931641"
Received: from lkp-server02.sh.intel.com (HELO c20d8bc80006) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 11 Nov 2021 18:55:08 -0800
Received: from kbuild by c20d8bc80006 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mlMiZ-000HWC-Fm; Fri, 12 Nov 2021 02:55:07 +0000
Date:   Fri, 12 Nov 2021 10:54:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 26af6e4926b029c54765aa53f89555b7c174e6fe
Message-ID: <618dd74d.ewdiNy0ixThEtb68%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 26af6e4926b029c54765aa53f89555b7c174e6fe  Merge branch 'pm-em' into bleeding-edge

elapsed time: 1755m

configs tested: 53
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                            allyesconfig
arm                                 defconfig
arm64                               defconfig
arm                              allmodconfig
arm                              allyesconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allmodconfig
m68k                             allyesconfig
nds32                               defconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
nios2                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
h8300                            allyesconfig
xtensa                           allyesconfig
parisc                              defconfig
parisc                           allyesconfig
s390                             allmodconfig
s390                                defconfig
s390                             allyesconfig
nds32                             allnoconfig
nios2                               defconfig
arc                              allyesconfig
i386                                defconfig
i386                              debian-10.3
sparc                            allyesconfig
sparc                               defconfig
i386                             allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
riscv                             allnoconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
