Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 617C46920C5
	for <lists+linux-acpi@lfdr.de>; Fri, 10 Feb 2023 15:25:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231954AbjBJOZm (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 10 Feb 2023 09:25:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232285AbjBJOZl (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 10 Feb 2023 09:25:41 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CD8772DCE;
        Fri, 10 Feb 2023 06:25:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676039140; x=1707575140;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=H1SqrmLgHpUvGFFELx6jqQvyWcxoiuwisvwOptrdSDQ=;
  b=VbpJJ/V4aX/4qTKnJAV64XzJtovLhZRJwKwRMygnS6ERnXEB39G0Gbng
   YFb+yQTJ0/iQwIefSwZ2BXHllOaghLEcIfPRmNwhFpwQhkJ4vIkGgSOHa
   /4kCrZsoYvezPpcGUBRwGSnermXWntfZRLYV18ISKEC1bWZg8EtZkz6kr
   R8yY+0n5nuPhr/BRVwL39mnufLG09Ph3RsbxxfQxWj10V1ZcXy0/6hKrp
   IGsLLLJLepTRywiyMV41NMgF/vmmBd3rwJ937hEdaRuRmvps+EFBAYYPN
   MnDz96if1hx55tQ2xTtX/pJ2+rnwsh0IoCxccddY91DPHK60EA8AsqA7X
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="332568596"
X-IronPort-AV: E=Sophos;i="5.97,287,1669104000"; 
   d="scan'208";a="332568596"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2023 06:25:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="617897494"
X-IronPort-AV: E=Sophos;i="5.97,287,1669104000"; 
   d="scan'208";a="617897494"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 10 Feb 2023 06:25:37 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pQULI-0005q5-2V;
        Fri, 10 Feb 2023 14:25:36 +0000
Date:   Fri, 10 Feb 2023 22:25:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD REGRESSION
 ccf0090d0435abab1a8c84e595802e88ad90b357
Message-ID: <63e653cd.T/LKpgkWdE5RDfio%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,LONGWORDS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: ccf0090d0435abab1a8c84e595802e88ad90b357  Merge branch 'acpi-cppc' into bleeding-edge

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202302100849.6RI86Ten-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

arm-linux-gnueabi-ld: driver.c:(.text+0x214): undefined reference to `__aeabi_ldivmod'
arm-linux-gnueabi-ld: driver.c:(.text+0x370): undefined reference to `__aeabi_ldivmod'
driver.c:(.text+0x11c): undefined reference to `__aeabi_ldivmod'
driver.c:(.text+0x23a): undefined reference to `__divdi3'
driver.c:(.text+0x240): undefined reference to `__divdi3'
driver.c:(.text+0x281): undefined reference to `__divdi3'
driver.c:(.text+0x2e0): undefined reference to `__aeabi_ldivmod'
drivers/cpuidle/driver.c:187: undefined reference to `__divdi3'
ld.lld: error: undefined symbol: __udivdi3
ld: driver.c:(.text+0x266): undefined reference to `__divdi3'
ld: driver.c:(.text+0x2ac): undefined reference to `__divdi3'
ld: drivers/cpuidle/driver.c:194: undefined reference to `__divdi3'

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- arm-allmodconfig
|   |-- arm-linux-gnueabi-ld:driver.c:(.text):undefined-reference-to-__aeabi_ldivmod
|   `-- driver.c:(.text):undefined-reference-to-__aeabi_ldivmod
|-- arm-defconfig
|   |-- arm-linux-gnueabi-ld:driver.c:(.text):undefined-reference-to-__aeabi_ldivmod
|   `-- driver.c:(.text):undefined-reference-to-__aeabi_ldivmod
|-- i386-allyesconfig
|   |-- driver.c:(.text):undefined-reference-to-__divdi3
|   `-- ld:driver.c:(.text):undefined-reference-to-__divdi3
|-- i386-debian-10.3
|   |-- drivers-cpuidle-driver.c:undefined-reference-to-__divdi3
|   `-- ld:drivers-cpuidle-driver.c:undefined-reference-to-__divdi3
|-- i386-defconfig
|   |-- driver.c:(.text):undefined-reference-to-__divdi3
|   `-- ld:driver.c:(.text):undefined-reference-to-__divdi3
|-- i386-randconfig-a001
|   |-- drivers-cpuidle-driver.c:undefined-reference-to-__divdi3
|   `-- ld:drivers-cpuidle-driver.c:undefined-reference-to-__divdi3
|-- i386-randconfig-a014
|   |-- drivers-cpuidle-driver.c:undefined-reference-to-__divdi3
|   `-- ld:drivers-cpuidle-driver.c:undefined-reference-to-__divdi3
`-- riscv-rv32_defconfig
    `-- driver.c:(.text):undefined-reference-to-__divdi3
clang_recent_errors
`-- i386-randconfig-a004
    `-- ld.lld:error:undefined-symbol:__udivdi3

elapsed time: 1069m

configs tested: 79
configs skipped: 3

gcc tested configs:
powerpc                           allnoconfig
arc                                 defconfig
um                             i386_defconfig
alpha                               defconfig
um                           x86_64_defconfig
x86_64                            allnoconfig
s390                             allmodconfig
s390                                defconfig
arc                  randconfig-r043-20230209
arm                  randconfig-r046-20230209
x86_64                           rhel-8.3-bpf
ia64                             allmodconfig
s390                             allyesconfig
sh                               allmodconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                           rhel-8.3-syz
m68k                             allyesconfig
i386                          randconfig-a001
m68k                             allmodconfig
i386                          randconfig-a003
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
arc                              allyesconfig
mips                             allyesconfig
alpha                             allnoconfig
i386                          randconfig-a014
i386                              allnoconfig
arm                               allnoconfig
arc                               allnoconfig
powerpc                          allmodconfig
i386                          randconfig-a012
alpha                            allyesconfig
i386                          randconfig-a016
x86_64                           allyesconfig
i386                          randconfig-a005
i386                                defconfig
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
arm                                 defconfig
i386                             allyesconfig
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
arm                              allyesconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allmodconfig
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig
csky                                defconfig
sparc                               defconfig
x86_64                                  kexec
i386                              debian-10.3
m68k                                defconfig
ia64                                defconfig
loongarch                         allnoconfig
loongarch                           defconfig
loongarch                        allmodconfig
riscv                             allnoconfig
riscv                          rv32_defconfig
riscv                               defconfig
riscv                            allmodconfig
mips                             allmodconfig

clang tested configs:
hexagon              randconfig-r041-20230209
hexagon              randconfig-r045-20230209
s390                 randconfig-r044-20230209
riscv                randconfig-r042-20230209
i386                          randconfig-a013
i386                          randconfig-a002
i386                          randconfig-a011
i386                          randconfig-a004
i386                          randconfig-a015
i386                          randconfig-a006
x86_64                          rhel-8.3-rust
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
