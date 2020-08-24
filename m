Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C1FD250BC7
	for <lists+linux-acpi@lfdr.de>; Tue, 25 Aug 2020 00:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbgHXWnd (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 24 Aug 2020 18:43:33 -0400
Received: from mga05.intel.com ([192.55.52.43]:8912 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726519AbgHXWnd (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 24 Aug 2020 18:43:33 -0400
IronPort-SDR: RUe4osnl3R3xgafqKqB2ls1fotA4n6WI/CTV8KOMJbpev2rfUSmBuQZWO2x0r6Gmrsd4GuxfON
 LpYIaC1cl08Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9723"; a="240820237"
X-IronPort-AV: E=Sophos;i="5.76,350,1592895600"; 
   d="scan'208";a="240820237"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2020 15:43:31 -0700
IronPort-SDR: u1z/xUe4j8gQH4MrgrR5Hjd0ZcbIll/5oUuA4A5mS3WiKExfjpS3DpTTBSZb9/kctskQ9hOfMj
 UUQ/JgpRM0XA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,350,1592895600"; 
   d="scan'208";a="474102761"
Received: from lkp-server01.sh.intel.com (HELO c420d4f0765f) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 24 Aug 2020 15:43:30 -0700
Received: from kbuild by c420d4f0765f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kALBZ-0000Xs-Kp; Mon, 24 Aug 2020 22:43:29 +0000
Date:   Tue, 25 Aug 2020 06:42:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [pm:bleeding-edge] BUILD SUCCESS
 f5eba0ea1052daba08e3fcf50be669b13fd7953d
Message-ID: <5f444257.SkK/XdWlJtDhiWH9%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git  bleeding-edge
branch HEAD: f5eba0ea1052daba08e3fcf50be669b13fd7953d  Merge branch 'pm-cpufreq' into linux-next

elapsed time: 726m

configs tested: 84
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
xtensa                         virt_defconfig
powerpc                      mgcoge_defconfig
ia64                          tiger_defconfig
sh                        dreamcast_defconfig
xtensa                           alldefconfig
xtensa                generic_kc705_defconfig
powerpc                      ppc64e_defconfig
arm                            xcep_defconfig
mips                      pistachio_defconfig
mips                        vocore2_defconfig
h8300                     edosk2674_defconfig
mips                            ar7_defconfig
c6x                        evmc6472_defconfig
c6x                        evmc6474_defconfig
sh                          sdk7780_defconfig
sh                          r7785rp_defconfig
arm                             rpc_defconfig
h8300                    h8300h-sim_defconfig
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
powerpc                             defconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a002-20200824
i386                 randconfig-a004-20200824
i386                 randconfig-a005-20200824
i386                 randconfig-a003-20200824
i386                 randconfig-a006-20200824
i386                 randconfig-a001-20200824
x86_64               randconfig-a015-20200824
x86_64               randconfig-a016-20200824
x86_64               randconfig-a012-20200824
x86_64               randconfig-a014-20200824
x86_64               randconfig-a011-20200824
x86_64               randconfig-a013-20200824
i386                 randconfig-a013-20200824
i386                 randconfig-a012-20200824
i386                 randconfig-a011-20200824
i386                 randconfig-a016-20200824
i386                 randconfig-a015-20200824
i386                 randconfig-a014-20200824
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
