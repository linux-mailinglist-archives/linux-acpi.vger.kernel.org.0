Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F2FD4C9F16
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Mar 2022 09:25:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239870AbiCBIZm (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 2 Mar 2022 03:25:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235656AbiCBIZl (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 2 Mar 2022 03:25:41 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D506B82C9;
        Wed,  2 Mar 2022 00:24:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646209498; x=1677745498;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=6I8oT6NdhDd+OFo/0z8u0+iNo81n4dyrY3t7EZvDNmI=;
  b=Fb8CgPaJZKKLYYqaTwrXUR+k0uDxlHPDy419eNKirkeYqs7wiFUF/jk4
   8DwCG9mmcbM3F7QtaDxHlDhe1C2vfQ4iYuWyR9XET8pHvp9SKCW80UOlY
   3GSx48Q6+hcuwKx9TctW8iJioadBLjMRfTMIijfY7932j+cdKPt47zIyp
   VUACecicAN2gn9sWOxHUJ+weHGBlt5r9vPZypdJFy6jsz5XPef58YX3bG
   YbwpsolkMZYmk7V0xvNWdja0BeVDh9FN1nXdn/BSVdvnjyHFnH2CrKfgN
   0fdYx7OW/RTcPz9h9lrryTTe1yZOW8O7fiGYIlfmBBy3tFDs1AsXiENZe
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10273"; a="339772921"
X-IronPort-AV: E=Sophos;i="5.90,148,1643702400"; 
   d="scan'208";a="339772921"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 00:24:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,148,1643702400"; 
   d="scan'208";a="508120119"
Received: from lkp-server02.sh.intel.com (HELO e9605edfa585) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 02 Mar 2022 00:24:54 -0800
Received: from kbuild by e9605edfa585 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nPKI1-0001Em-Tz; Wed, 02 Mar 2022 08:24:53 +0000
Date:   Wed, 02 Mar 2022 16:24:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS WITH WARNING
 f7307721a01f4f14d21c699b270a870370cf34b9
Message-ID: <621f29a5.tUuJmET0YwP81mTF%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: f7307721a01f4f14d21c699b270a870370cf34b9  Merge branch 'acpi-soc' into bleeding-edge

Warning reports:

https://lore.kernel.org/linux-acpi/202203020750.Uq6hGay2-lkp@intel.com
https://lore.kernel.org/llvm/202203020737.wa9uc4gW-lkp@intel.com

Warning:

arch/x86/kernel/acpi/boot.c:1476:8: warning: excess elements in array initializer [-Wexcess-initializers]
include/linux/mod_devicetable.h:587:25: warning: excess elements in array initializer

Unverified Warning (likely false positive, please contact us if interested):

arch/x86/kernel/acpi/boot.c:1394 (null)() error: buffer overflow '(acpi_dmi_table[6])->matches' 4 <= 4
arch/x86/kernel/acpi/boot.c:1476:22: sparse: sparse: excessive elements in array initializer

Warning ids grouped by kconfigs:

gcc_recent_errors
|-- i386-randconfig-a003
|   `-- include-linux-mod_devicetable.h:warning:excess-elements-in-array-initializer
|-- i386-randconfig-c001
|   `-- include-linux-mod_devicetable.h:warning:excess-elements-in-array-initializer
|-- i386-randconfig-s001
|   `-- include-linux-mod_devicetable.h:warning:excess-elements-in-array-initializer
|-- i386-randconfig-s002
|   |-- arch-x86-kernel-acpi-boot.c:sparse:sparse:excessive-elements-in-array-initializer
|   `-- include-linux-mod_devicetable.h:warning:excess-elements-in-array-initializer
|-- x86_64-allyesconfig
|   `-- include-linux-mod_devicetable.h:warning:excess-elements-in-array-initializer
|-- x86_64-kexec
|   `-- include-linux-mod_devicetable.h:warning:excess-elements-in-array-initializer
|-- x86_64-randconfig-a015
|   `-- include-linux-mod_devicetable.h:warning:excess-elements-in-array-initializer
|-- x86_64-randconfig-c002
|   `-- include-linux-mod_devicetable.h:warning:excess-elements-in-array-initializer
|-- x86_64-randconfig-m001
|   `-- arch-x86-kernel-acpi-boot.c-(null)()-error:buffer-overflow-(acpi_dmi_table-)-matches
|-- x86_64-rhel-8.3
|   `-- include-linux-mod_devicetable.h:warning:excess-elements-in-array-initializer
|-- x86_64-rhel-8.3-func
|   `-- include-linux-mod_devicetable.h:warning:excess-elements-in-array-initializer
|-- x86_64-rhel-8.3-kselftests
|   `-- include-linux-mod_devicetable.h:warning:excess-elements-in-array-initializer
`-- x86_64-rhel-8.3-kunit
    `-- include-linux-mod_devicetable.h:warning:excess-elements-in-array-initializer

clang_recent_errors
|-- i386-randconfig-a002
|   `-- arch-x86-kernel-acpi-boot.c:warning:excess-elements-in-array-initializer
|-- i386-randconfig-a011
|   `-- arch-x86-kernel-acpi-boot.c:warning:excess-elements-in-array-initializer
`-- x86_64-randconfig-a016
    `-- arch-x86-kernel-acpi-boot.c:warning:excess-elements-in-array-initializer

elapsed time: 724m

configs tested: 106
configs skipped: 3

gcc tested configs:
arm                                 defconfig
arm64                               defconfig
arm                              allmodconfig
arm64                            allyesconfig
arm                              allyesconfig
i386                          randconfig-c001
arm                            lart_defconfig
arm                            hisi_defconfig
h8300                            alldefconfig
sh                            titan_defconfig
arm                          iop32x_defconfig
m68k                          amiga_defconfig
arm                            pleb_defconfig
sh                        apsh4ad0a_defconfig
ia64                            zx1_defconfig
mips                      maltasmvp_defconfig
arm                         at91_dt_defconfig
sh                               alldefconfig
openrisc                            defconfig
arm                  randconfig-c002-20220301
ia64                                defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
nds32                             allnoconfig
nios2                               defconfig
arc                              allyesconfig
csky                                defconfig
alpha                               defconfig
nds32                               defconfig
nios2                            allyesconfig
alpha                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
xtensa                           allyesconfig
h8300                            allyesconfig
parisc                              defconfig
parisc64                            defconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
s390                             allyesconfig
i386                             allyesconfig
i386                              debian-10.3
i386                   debian-10.3-kselftests
sparc                               defconfig
i386                                defconfig
sparc                            allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
powerpc                          allyesconfig
i386                          randconfig-a003
i386                          randconfig-a001
i386                          randconfig-a005
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
x86_64                        randconfig-a006
x86_64                        randconfig-a002
x86_64                        randconfig-a004
arc                  randconfig-r043-20220301
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
riscv                    nommu_virt_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                                  kexec
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                    rhel-8.3-kselftests

clang tested configs:
arm                          imote2_defconfig
powerpc                      ppc64e_defconfig
arm                        mvebu_v5_defconfig
arm                         lpc32xx_defconfig
mips                     cu1830-neo_defconfig
arm                        spear3xx_defconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
hexagon              randconfig-r045-20220301
hexagon              randconfig-r041-20220301
s390                 randconfig-r044-20220301
riscv                randconfig-r042-20220301

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
