Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B71B285569
	for <lists+linux-acpi@lfdr.de>; Wed,  7 Oct 2020 02:24:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725996AbgJGAYT (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 6 Oct 2020 20:24:19 -0400
Received: from mga18.intel.com ([134.134.136.126]:49549 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725972AbgJGAYT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 6 Oct 2020 20:24:19 -0400
IronPort-SDR: lJoz8dcdhKoUtOTYgQNtYv6JBAa/scGRdKQgU0j2qbgVXMjuxFFAmgGbEL98FOxtQL2MAKDEjf
 cJc47r2kU6eQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9766"; a="152529400"
X-IronPort-AV: E=Sophos;i="5.77,344,1596524400"; 
   d="scan'208";a="152529400"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2020 17:24:18 -0700
IronPort-SDR: NMTZg32F7NvkC4D7dOgqVd4S+xJVP+9SG8OisfMBLeR723DBNdD1wSR0xxAx8jgx7J7iow7U3p
 N8EON07CyuuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,344,1596524400"; 
   d="scan'208";a="297240083"
Received: from lkp-server02.sh.intel.com (HELO b5ae2f167493) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 06 Oct 2020 17:24:16 -0700
Received: from kbuild by b5ae2f167493 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kPxFf-0001OQ-WF; Wed, 07 Oct 2020 00:24:16 +0000
Date:   Wed, 07 Oct 2020 08:23:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [pm:bleeding-edge] BUILD SUCCESS
 11f230e5015f5e7df85c2e72aa92281b7f8d6b34
Message-ID: <5f7d0a7f.jqKvfVVsmrSBmREm%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git  bleeding-edge
branch HEAD: 11f230e5015f5e7df85c2e72aa92281b7f8d6b34  Merge branch 'pm-sleep' into bleeding-edge

elapsed time: 720m

configs tested: 91
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
mips                  maltasmvp_eva_defconfig
m68k                        mvme16x_defconfig
sh                ecovec24-romimage_defconfig
ia64                        generic_defconfig
powerpc                      acadia_defconfig
mips                       bmips_be_defconfig
powerpc                 mpc8272_ads_defconfig
arm                        magician_defconfig
alpha                               defconfig
arm                         lpc32xx_defconfig
sh                           se7722_defconfig
sh                   secureedge5410_defconfig
m68k                        m5272c3_defconfig
powerpc                 mpc85xx_cds_defconfig
arm                             pxa_defconfig
sh                         ap325rxa_defconfig
powerpc                     powernv_defconfig
mips                     loongson1c_defconfig
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
x86_64               randconfig-a004-20201006
x86_64               randconfig-a002-20201006
x86_64               randconfig-a001-20201006
x86_64               randconfig-a005-20201006
x86_64               randconfig-a003-20201006
x86_64               randconfig-a006-20201006
i386                 randconfig-a006-20201005
i386                 randconfig-a005-20201005
i386                 randconfig-a001-20201005
i386                 randconfig-a004-20201005
i386                 randconfig-a003-20201005
i386                 randconfig-a002-20201005
x86_64               randconfig-a012-20201005
x86_64               randconfig-a015-20201005
x86_64               randconfig-a014-20201005
x86_64               randconfig-a013-20201005
x86_64               randconfig-a011-20201005
x86_64               randconfig-a016-20201005
i386                 randconfig-a014-20201005
i386                 randconfig-a015-20201005
i386                 randconfig-a013-20201005
i386                 randconfig-a016-20201005
i386                 randconfig-a011-20201005
i386                 randconfig-a012-20201005
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

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
