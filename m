Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CC2A11E1C2
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Dec 2019 11:14:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725793AbfLMKOU (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 13 Dec 2019 05:14:20 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:47430 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfLMKOU (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 13 Dec 2019 05:14:20 -0500
Received: from 79.184.255.82.ipv4.supernova.orange.pl (79.184.255.82) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.320)
 id 1493cb71bb9257ac; Fri, 13 Dec 2019 11:14:16 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>
Subject: Fwd: [pm:bleeding-edge] BUILD REGRESSION 208501f6808a1dc0205904ed84cac99da01bbf70
Date:   Fri, 13 Dec 2019 11:14:16 +0100
Message-ID: <1860961.FledB3ecnK@kreacher>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="nextPart2290796.7JNuTAB27y"
Content-Transfer-Encoding: 7Bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.

--nextPart2290796.7JNuTAB27y
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Dmitry,

Unfortunately, this report was sent directly to me without any CCs to
mailing lists.

This is a tree with the v9 of the last patch from the software nodes series
merged.

Cheers,
Rafael

--nextPart2290796.7JNuTAB27y
Content-Type: message/rfc822
Content-Disposition: inline; filename="forwarded message"
Content-Description: kbuild test robot <lkp@intel.com>: [pm:bleeding-edge] BUILD REGRESSION 208501f6808a1dc0205904ed84cac99da01bbf70

Return-Path: <lkp@intel.com>
Received: from mga06.intel.com (134.134.136.31) (HELO mga06.intel.com) by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.320) id 875d1634946306b8; Tue, 10 Dec 2019 06:19:06 +0100
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58]) by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Dec 2019 21:18:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,298,1571727600"; d="scan'208";a="210333394"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150]) by fmsmga008.fm.intel.com with ESMTP; 09 Dec 2019 21:18:58 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89) (envelope-from <lkp@intel.com>) id 1ieXvG-0001Vl-Fm; Tue, 10 Dec 2019 13:18:58 +0800
Date: Tue, 10 Dec 2019 13:18:25 +0800
From: kbuild test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [pm:bleeding-edge] BUILD REGRESSION 208501f6808a1dc0205904ed84cac99da01bbf70
Message-ID: <5def2aa1.16zIafxV7no6yvho%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git  bleeding-edge
branch HEAD: 208501f6808a1dc0205904ed84cac99da01bbf70  Merge branch 'acpi-pm' into bleeding-edge

Regressions in current branch:

drivers/base/test/property-entry-test.c:214:1: warning: the frame size of 2784 bytes is larger than 2048 bytes [-Wframe-larger-than=]
drivers/base/test/property-entry-test.c:214:1: warning: the frame size of 3128 bytes is larger than 2048 bytes [-Wframe-larger-than=]
drivers/base/test/property-entry-test.c:214:1: warning: the frame size of 3136 bytes is larger than 2048 bytes [-Wframe-larger-than=]

Error ids grouped by kconfigs:

recent_errors
|-- arm-allmodconfig
|   `-- drivers-base-test-property-entry-test.c:warning:the-frame-size-of-bytes-is-larger-than-bytes
|-- i386-allmodconfig
|   `-- drivers-base-test-property-entry-test.c:warning:the-frame-size-of-bytes-is-larger-than-bytes
`-- mips-allmodconfig
    `-- drivers-base-test-property-entry-test.c:warning:the-frame-size-of-bytes-is-larger-than-bytes

elapsed time: 352m

configs tested: 98

xtensa                       common_defconfig
openrisc                    or1ksim_defconfig
nios2                         3c120_defconfig
xtensa                          iss_defconfig
c6x                        evmc6678_defconfig
c6x                              allyesconfig
nios2                         10m50_defconfig
openrisc                 simple_smp_defconfig
arm                         at91_dt_defconfig
arm64                               defconfig
arm                        multi_v5_defconfig
arm64                            allyesconfig
arm                               allnoconfig
arm                           efm32_defconfig
arm                           sunxi_defconfig
arm64                             allnoconfig
arm64                            allmodconfig
arm                          exynos_defconfig
arm                        shmobile_defconfig
arm                        multi_v7_defconfig
sh                               allmodconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                                allnoconfig
sh                            titan_defconfig
s390                              allnoconfig
s390                          debug_defconfig
s390                             allmodconfig
s390                                defconfig
arm                              allmodconfig
i386                              allnoconfig
i386                                defconfig
i386                             alldefconfig
parisc                        c3000_defconfig
parisc                         b180_defconfig
parisc                              defconfig
parisc                            allnoconfig
um                           x86_64_defconfig
um                             i386_defconfig
um                                  defconfig
ia64                             allmodconfig
ia64                              allnoconfig
ia64                                defconfig
ia64                             alldefconfig
sparc64                          allmodconfig
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
arc                  randconfig-a001-20191210
ia64                 randconfig-a001-20191210
sparc                randconfig-a001-20191210
arm64                randconfig-a001-20191210
arm                  randconfig-a001-20191210
x86_64                                    lkp
x86_64                                   rhel
x86_64                               rhel-7.6
x86_64                              fedora-25
x86_64                                  kexec
m68k                          multi_defconfig
m68k                       m5475evb_defconfig
h8300                    h8300h-sim_defconfig
h8300                     edosk2674_defconfig
m68k                           sun3_defconfig
h8300                       h8s-sim_defconfig
m68k                             allmodconfig
riscv                             allnoconfig
riscv                               defconfig
nds32                               defconfig
alpha                               defconfig
csky                                defconfig
nds32                             allnoconfig
sh                   randconfig-a001-20191209
csky                 randconfig-a001-20191209
s390                 randconfig-a001-20191209
xtensa               randconfig-a001-20191209
openrisc             randconfig-a001-20191209
i386                 randconfig-d001-20191209
x86_64               randconfig-d001-20191209
i386                 randconfig-d002-20191209
x86_64               randconfig-d003-20191209
i386                 randconfig-d003-20191209
x86_64               randconfig-d002-20191209
arc                              allyesconfig
microblaze                    nommu_defconfig
microblaze                      mmu_defconfig
arc                                 defconfig
powerpc                           allnoconfig
mips                             allmodconfig
mips                           32r2_defconfig
mips                      malta_kvm_defconfig
mips                         64r6el_defconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
c6x                  randconfig-a001-20191209
sparc64              randconfig-a001-20191209
h8300                randconfig-a001-20191209
microblaze           randconfig-a001-20191209
nios2                randconfig-a001-20191209

---
0-DAY kernel test infrastructure                 Open Source Technology Center
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation

--nextPart2290796.7JNuTAB27y--



