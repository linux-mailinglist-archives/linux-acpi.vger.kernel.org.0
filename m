Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 702D9232B72
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Jul 2020 07:41:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728519AbgG3FlL (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 30 Jul 2020 01:41:11 -0400
Received: from mga18.intel.com ([134.134.136.126]:40501 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726133AbgG3FlL (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 30 Jul 2020 01:41:11 -0400
IronPort-SDR: +XxeZudkmWbqQ51b9a2wqtgY391ktq+U9Xe6jjCjMLZ8vEvRybIeZTcGp5cj/LTiwxz9r1FB6Q
 85nqOmTiW1fw==
X-IronPort-AV: E=McAfee;i="6000,8403,9697"; a="139076604"
X-IronPort-AV: E=Sophos;i="5.75,413,1589266800"; 
   d="scan'208";a="139076604"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2020 22:41:10 -0700
IronPort-SDR: PnLfqCgFEpyMbbtgqFEc4X4mTMYdL4HHMtU6yz5+D7BBfRLZZDtdxCb/ut5zWnCw34nuAPkC06
 iDwhL7nj0nTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,413,1589266800"; 
   d="scan'208";a="491007089"
Received: from lkp-server01.sh.intel.com (HELO aff35d61a1e5) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 29 Jul 2020 22:41:08 -0700
Received: from kbuild by aff35d61a1e5 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k11JT-00006A-M4; Thu, 30 Jul 2020 05:41:07 +0000
Date:   Thu, 30 Jul 2020 13:40:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [pm:bleeding-edge] BUILD SUCCESS WITH WARNING
 5bff8c754ebfc08b9cead967f38ebc0152d2076f
Message-ID: <5f225d61.YfXWCartLr/vi0w8%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git  bleeding-edge
branch HEAD: 5bff8c754ebfc08b9cead967f38ebc0152d2076f  Merge branch 'pm-cpufreq' into bleeding-edge

Warning in current branch:

drivers/acpi/processor_idle.c:667:4: warning: 'return' with no value, in function returning non-void [-Wreturn-type]

Warning ids grouped by kconfigs:

recent_errors
`-- ia64-randconfig-r024-20200729
    `-- drivers-acpi-processor_idle.c:warning:return-with-no-value-in-function-returning-non-void

elapsed time: 722m

configs tested: 48
configs skipped: 1

arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
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
