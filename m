Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31E081E3F0B
	for <lists+linux-acpi@lfdr.de>; Wed, 27 May 2020 12:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729844AbgE0Kc3 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 27 May 2020 06:32:29 -0400
Received: from mga05.intel.com ([192.55.52.43]:19762 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728930AbgE0Kc3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 27 May 2020 06:32:29 -0400
IronPort-SDR: /bRv1tMuHfIms/3R/Ge7C+7TORWO0ZwPsUq+Ocf8JQPidDY6QwGV98WdzytmQXbAWpaZyB0OcG
 TJCf17U6n/Lg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2020 03:32:29 -0700
IronPort-SDR: dZG3PcYY/W3GkNcEuDtFHcEQkBJK6zp+IuvNBRuf8ovrabxKhxdmJSc/krZknkjCzLZuJAAVQK
 A2Mg2joCpcHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,441,1583222400"; 
   d="scan'208";a="284761056"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 27 May 2020 03:32:27 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jdtMI-000Hjv-JG; Wed, 27 May 2020 18:32:26 +0800
Date:   Wed, 27 May 2020 18:31:47 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [pm:bleeding-edge] BUILD SUCCESS
 e14ff33f1ff98f45d4bc39c136cb4c6b97828f2f
Message-ID: <5ece4193.2xwFVVIvNID8th7c%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git  bleeding-edge
branch HEAD: e14ff33f1ff98f45d4bc39c136cb4c6b97828f2f  Merge branch 'pm-core' into bleeding-edge

elapsed time: 1536m

configs tested: 100
configs skipped: 3

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
arm                         s3c6400_defconfig
m68k                             allmodconfig
arm                           spitz_defconfig
xtensa                          iss_defconfig
i386                             allyesconfig
i386                                defconfig
i386                              debian-10.3
i386                              allnoconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                              allnoconfig
ia64                             allyesconfig
m68k                              allnoconfig
m68k                           sun3_defconfig
m68k                                defconfig
m68k                             allyesconfig
csky                             allyesconfig
alpha                               defconfig
alpha                            allyesconfig
nds32                               defconfig
nds32                             allnoconfig
csky                                defconfig
xtensa                           allyesconfig
h8300                            allyesconfig
h8300                            allmodconfig
xtensa                              defconfig
nios2                               defconfig
nios2                            allyesconfig
openrisc                            defconfig
c6x                              allyesconfig
c6x                               allnoconfig
openrisc                         allyesconfig
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
i386                 randconfig-a001-20200526
i386                 randconfig-a004-20200526
i386                 randconfig-a003-20200526
i386                 randconfig-a006-20200526
i386                 randconfig-a002-20200526
i386                 randconfig-a005-20200526
i386                 randconfig-a013-20200526
i386                 randconfig-a015-20200526
i386                 randconfig-a012-20200526
i386                 randconfig-a011-20200526
i386                 randconfig-a016-20200526
i386                 randconfig-a014-20200526
x86_64               randconfig-a006-20200527
x86_64               randconfig-a002-20200527
x86_64               randconfig-a005-20200527
x86_64               randconfig-a003-20200527
x86_64               randconfig-a004-20200527
x86_64               randconfig-a001-20200527
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
s390                             allyesconfig
s390                              allnoconfig
s390                             allmodconfig
s390                                defconfig
sparc64                             defconfig
sparc64                          allyesconfig
sparc                            allyesconfig
sparc                               defconfig
sparc64                           allnoconfig
sparc64                          allmodconfig
um                               allmodconfig
um                                allnoconfig
um                               allyesconfig
um                                  defconfig
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
