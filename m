Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8432A233FFC
	for <lists+linux-acpi@lfdr.de>; Fri, 31 Jul 2020 09:32:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731629AbgGaHcR (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 31 Jul 2020 03:32:17 -0400
Received: from mga11.intel.com ([192.55.52.93]:54108 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731560AbgGaHcR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 31 Jul 2020 03:32:17 -0400
IronPort-SDR: 4+TuDbzBxczJI9veoqDDgXioF/dlaHw2gHqZeWb/HIYH+lnFzZcreSPr6CDoj7UxsGFKU5sAwe
 5GzH5Ar19uFQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9698"; a="149569575"
X-IronPort-AV: E=Sophos;i="5.75,417,1589266800"; 
   d="scan'208";a="149569575"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2020 00:32:15 -0700
IronPort-SDR: +nUl9EM4FpqMaXI9kosk4hQ5eO8b4A/7exNMNeS/Ko6sPoId+ajjntrO3gzlmsw3RppFhNDo6Y
 6zoSi7kuTWVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,417,1589266800"; 
   d="scan'208";a="304864548"
Received: from lkp-server02.sh.intel.com (HELO d4d86dd808e0) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 31 Jul 2020 00:32:13 -0700
Received: from kbuild by d4d86dd808e0 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k1PWX-0000TR-0E; Fri, 31 Jul 2020 07:32:13 +0000
Date:   Fri, 31 Jul 2020 15:31:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [pm:bleeding-edge] BUILD SUCCESS WITH WARNING
 97987ea7f86a35284fd54efc7412db246f178666
Message-ID: <5f23c8ea.PWJ3lFt9FGpnoBxp%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git  bleeding-edge
branch HEAD: 97987ea7f86a35284fd54efc7412db246f178666  Merge branch 'pm-devfreq' into linux-next

Warning in current branch:

drivers/acpi/processor_idle.c:666:4: warning: 'return' with no value, in function returning non-void [-Wreturn-type]

Warning ids grouped by kconfigs:

recent_errors
|-- i386-allyesconfig
|   `-- drivers-acpi-processor_idle.c:warning:return-with-no-value-in-function-returning-non-void
|-- i386-defconfig
|   `-- drivers-acpi-processor_idle.c:warning:return-with-no-value-in-function-returning-non-void
|-- i386-randconfig-a011-20200731
|   `-- drivers-acpi-processor_idle.c:warning:return-with-no-value-in-function-returning-non-void
|-- i386-randconfig-a012-20200731
|   `-- drivers-acpi-processor_idle.c:warning:return-with-no-value-in-function-returning-non-void
|-- i386-randconfig-a013-20200731
|   `-- drivers-acpi-processor_idle.c:warning:return-with-no-value-in-function-returning-non-void
|-- i386-randconfig-a014-20200731
|   `-- drivers-acpi-processor_idle.c:warning:return-with-no-value-in-function-returning-non-void
|-- i386-randconfig-a015-20200731
|   `-- drivers-acpi-processor_idle.c:warning:return-with-no-value-in-function-returning-non-void
|-- i386-randconfig-a016-20200731
|   `-- drivers-acpi-processor_idle.c:warning:return-with-no-value-in-function-returning-non-void
|-- i386-randconfig-c001-20200730
|   `-- drivers-acpi-processor_idle.c:warning:return-with-no-value-in-function-returning-non-void
|-- i386-randconfig-r003-20200730
|   `-- drivers-acpi-processor_idle.c:warning:return-with-no-value-in-function-returning-non-void
|-- ia64-allmodconfig
|   `-- drivers-acpi-processor_idle.c:warning:return-with-no-value-in-function-returning-non-void
|-- ia64-allyesconfig
|   `-- drivers-acpi-processor_idle.c:warning:return-with-no-value-in-function-returning-non-void
|-- ia64-defconfig
|   `-- drivers-acpi-processor_idle.c:warning:return-with-no-value-in-function-returning-non-void
|-- ia64-randconfig-r025-20200730
|   `-- drivers-acpi-processor_idle.c:warning:return-with-no-value-in-function-returning-non-void
|-- x86_64-allmodconfig
|   `-- drivers-acpi-processor_idle.c:warning:return-with-no-value-in-function-returning-non-void
|-- x86_64-allyesconfig
|   `-- drivers-acpi-processor_idle.c:warning:return-with-no-value-in-function-returning-non-void
|-- x86_64-defconfig
|   `-- drivers-acpi-processor_idle.c:warning:return-with-no-value-in-function-returning-non-void
|-- x86_64-kexec
|   `-- drivers-acpi-processor_idle.c:warning:return-with-no-value-in-function-returning-non-void
|-- x86_64-rhel
|   `-- drivers-acpi-processor_idle.c:warning:return-with-no-value-in-function-returning-non-void
|-- x86_64-rhel-7.6-kselftests
|   `-- drivers-acpi-processor_idle.c:warning:return-with-no-value-in-function-returning-non-void
`-- x86_64-rhel-8.3
    `-- drivers-acpi-processor_idle.c:warning:return-with-no-value-in-function-returning-non-void

elapsed time: 840m

configs tested: 66
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
i386                 randconfig-a005-20200731
i386                 randconfig-a004-20200731
i386                 randconfig-a006-20200731
i386                 randconfig-a002-20200731
i386                 randconfig-a001-20200731
i386                 randconfig-a003-20200731
x86_64               randconfig-a015-20200731
x86_64               randconfig-a014-20200731
x86_64               randconfig-a016-20200731
x86_64               randconfig-a012-20200731
x86_64               randconfig-a013-20200731
x86_64               randconfig-a011-20200731
i386                 randconfig-a016-20200731
i386                 randconfig-a012-20200731
i386                 randconfig-a014-20200731
i386                 randconfig-a015-20200731
i386                 randconfig-a011-20200731
i386                 randconfig-a013-20200731
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
