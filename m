Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E25756D2E83
	for <lists+linux-acpi@lfdr.de>; Sat,  1 Apr 2023 08:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231667AbjDAGKV (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 1 Apr 2023 02:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjDAGKV (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 1 Apr 2023 02:10:21 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E57A9EFA4;
        Fri, 31 Mar 2023 23:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680329419; x=1711865419;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=HOtQD7ZPfsOf7TOI69bCnNRQYpD2YQR1BygyIIRe10c=;
  b=hevScNG/h36+DUlMkGS9l4d9KlX+/bLMx9tFk+iLXjJ7kr19Z4iGkPWZ
   IyGT/c2YTb+Vh4Hq5o5moiZeY80MN2+OUJz5y7cUnhD6dHa1m1tkNmIl/
   KvHtCB7VXI3rC5LtVFOagVgX7VRL2H8qmpzYSHkF0cSdCejvpgT1yf5Qa
   137BanT7qO40yVXagZg9Wt5FrhP86j4Oh2cu+rraUUtTH7561bTEo6kTf
   fbf1lBi3PUNkyJFkUv8pQEMJ5Nc7BU6lVp9mt76we5tjk6a9jJq27c6f7
   iokbGqaNeYRNQvm4vRpsan4VQwklTmLClZkDELxNOO/e4TXqzPF/0sIaa
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10666"; a="330180584"
X-IronPort-AV: E=Sophos;i="5.98,308,1673942400"; 
   d="scan'208";a="330180584"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2023 23:10:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10666"; a="1015084021"
X-IronPort-AV: E=Sophos;i="5.98,308,1673942400"; 
   d="scan'208";a="1015084021"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 31 Mar 2023 23:10:17 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1piURM-000MYG-2N;
        Sat, 01 Apr 2023 06:10:16 +0000
Date:   Sat, 01 Apr 2023 14:10:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD REGRESSION
 56fb1399ba81f8f6db1e9d667538fc0210660e55
Message-ID: <6427cac6.vwLpuevHHkfpERh1%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 56fb1399ba81f8f6db1e9d667538fc0210660e55  Merge branches 'acpi-sbs', 'acpi-thermal', 'acpi-misc' and 'acpi-tables' into linux-next

Error/Warning: (recently discovered and may have been fixed)

drivers/ata/pata_ixp4xx_cf.c:254:46: error: invalid use of undefined type 'struct device_node'
drivers/ata/pata_ixp4xx_cf.c:258:15: error: implicit declaration of function 'of_property_read_u32_index'; did you mean 'fwnode_property_read_u32_array'? [-Werror=implicit-function-declaration]
drivers/fpga/lattice-sysconfig-spi.c:146:35: error: implicit declaration of function 'of_match_ptr' [-Werror=implicit-function-declaration]
drivers/fpga/lattice-sysconfig-spi.c:146:35: error: initializer element is not constant
drivers/virtio/virtio_mmio.c:492:13: error: implicit declaration of function 'of_property_read_bool'; did you mean 'fwnode_property_read_bool'? [-Werror=implicit-function-declaration]

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- arc-randconfig-r043-20230329
|   |-- drivers-fpga-lattice-sysconfig-spi.c:error:implicit-declaration-of-function-of_match_ptr
|   `-- drivers-fpga-lattice-sysconfig-spi.c:error:initializer-element-is-not-constant
|-- csky-randconfig-r004-20230329
|   `-- drivers-virtio-virtio_mmio.c:error:implicit-declaration-of-function-of_property_read_bool
|-- loongarch-allyesconfig
|   |-- drivers-fpga-lattice-sysconfig-spi.c:error:implicit-declaration-of-function-of_match_ptr
|   `-- drivers-fpga-lattice-sysconfig-spi.c:error:initializer-element-is-not-constant
|-- mips-allyesconfig
|   |-- drivers-fpga-lattice-sysconfig-spi.c:error:implicit-declaration-of-function-of_match_ptr
|   `-- drivers-fpga-lattice-sysconfig-spi.c:error:initializer-element-is-not-constant
`-- sh-allmodconfig
    |-- drivers-ata-pata_ixp4xx_cf.c:error:implicit-declaration-of-function-of_property_read_u32_index
    `-- drivers-ata-pata_ixp4xx_cf.c:error:invalid-use-of-undefined-type-struct-device_node

elapsed time: 723m

configs tested: 166
configs skipped: 6

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r002-20230329   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r015-20230329   gcc  
alpha                randconfig-r016-20230329   gcc  
alpha                randconfig-r036-20230329   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r005-20230329   gcc  
arc                  randconfig-r033-20230329   gcc  
arc                  randconfig-r043-20230329   gcc  
arc                  randconfig-r043-20230331   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm          buildonly-randconfig-r003-20230329   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r001-20230329   clang
arm                  randconfig-r002-20230329   clang
arm                  randconfig-r003-20230329   clang
arm                  randconfig-r026-20230329   gcc  
arm                  randconfig-r034-20230329   clang
arm                  randconfig-r035-20230329   clang
arm                  randconfig-r046-20230329   gcc  
arm                  randconfig-r046-20230331   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r001-20230329   gcc  
arm64                randconfig-r025-20230329   clang
arm64                randconfig-r036-20230329   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r004-20230329   gcc  
csky                 randconfig-r034-20230329   gcc  
hexagon      buildonly-randconfig-r002-20230329   clang
hexagon              randconfig-r041-20230329   clang
hexagon              randconfig-r041-20230331   clang
hexagon              randconfig-r045-20230329   clang
hexagon              randconfig-r045-20230331   clang
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                          randconfig-a001   gcc  
i386                          randconfig-a002   clang
i386                          randconfig-a003   gcc  
i386                          randconfig-a004   clang
i386                          randconfig-a005   gcc  
i386                          randconfig-a006   clang
i386                          randconfig-a011   clang
i386                          randconfig-a012   gcc  
i386                          randconfig-a013   clang
i386                          randconfig-a014   gcc  
i386                          randconfig-a015   clang
i386                          randconfig-a016   gcc  
ia64                             allmodconfig   gcc  
ia64         buildonly-randconfig-r001-20230329   gcc  
ia64         buildonly-randconfig-r003-20230329   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r002-20230329   gcc  
ia64                 randconfig-r012-20230329   gcc  
ia64                 randconfig-r023-20230329   gcc  
ia64                 randconfig-r025-20230329   gcc  
ia64                 randconfig-r033-20230329   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch    buildonly-randconfig-r004-20230329   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r002-20230330   gcc  
loongarch            randconfig-r005-20230330   gcc  
loongarch            randconfig-r013-20230329   gcc  
loongarch            randconfig-r021-20230329   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r001-20230330   gcc  
m68k                 randconfig-r004-20230329   gcc  
m68k                 randconfig-r013-20230329   gcc  
m68k                 randconfig-r014-20230329   gcc  
m68k                 randconfig-r031-20230329   gcc  
microblaze   buildonly-randconfig-r005-20230329   gcc  
microblaze   buildonly-randconfig-r006-20230329   gcc  
microblaze           randconfig-r023-20230329   gcc  
microblaze           randconfig-r024-20230329   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r012-20230329   gcc  
mips                 randconfig-r036-20230329   clang
nios2                               defconfig   gcc  
nios2                randconfig-r004-20230330   gcc  
nios2                randconfig-r011-20230329   gcc  
nios2                randconfig-r031-20230329   gcc  
nios2                randconfig-r033-20230329   gcc  
nios2                randconfig-r035-20230329   gcc  
openrisc     buildonly-randconfig-r002-20230331   gcc  
openrisc             randconfig-r006-20230330   gcc  
openrisc             randconfig-r022-20230329   gcc  
openrisc             randconfig-r034-20230329   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r003-20230330   gcc  
parisc               randconfig-r006-20230329   gcc  
parisc               randconfig-r015-20230329   gcc  
parisc               randconfig-r022-20230329   gcc  
parisc               randconfig-r025-20230329   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc      buildonly-randconfig-r004-20230331   gcc  
powerpc              randconfig-r003-20230329   gcc  
powerpc              randconfig-r032-20230329   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv        buildonly-randconfig-r004-20230329   clang
riscv        buildonly-randconfig-r006-20230329   clang
riscv                               defconfig   gcc  
riscv                randconfig-r006-20230329   gcc  
riscv                randconfig-r016-20230329   clang
riscv                randconfig-r021-20230329   clang
riscv                randconfig-r032-20230329   gcc  
riscv                randconfig-r035-20230329   gcc  
riscv                randconfig-r042-20230329   clang
riscv                randconfig-r042-20230331   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390         buildonly-randconfig-r006-20230331   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r005-20230329   gcc  
s390                 randconfig-r026-20230329   clang
s390                 randconfig-r044-20230329   clang
s390                 randconfig-r044-20230331   gcc  
sh                               allmodconfig   gcc  
sh           buildonly-randconfig-r005-20230329   gcc  
sh                   randconfig-r005-20230329   gcc  
sh                   randconfig-r014-20230329   gcc  
sh                   randconfig-r024-20230329   gcc  
sparc        buildonly-randconfig-r001-20230329   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r004-20230329   gcc  
sparc                randconfig-r006-20230329   gcc  
sparc                randconfig-r022-20230329   gcc  
sparc64      buildonly-randconfig-r001-20230331   gcc  
sparc64              randconfig-r002-20230329   gcc  
sparc64              randconfig-r003-20230329   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                        randconfig-a001   clang
x86_64                        randconfig-a002   gcc  
x86_64                        randconfig-a003   clang
x86_64                        randconfig-a004   gcc  
x86_64                        randconfig-a005   clang
x86_64                        randconfig-a006   gcc  
x86_64                        randconfig-a011   gcc  
x86_64                        randconfig-a012   clang
x86_64                        randconfig-a013   gcc  
x86_64                        randconfig-a014   clang
x86_64                        randconfig-a015   gcc  
x86_64                        randconfig-a016   clang
x86_64                               rhel-8.3   gcc  
xtensa       buildonly-randconfig-r003-20230331   gcc  
xtensa               randconfig-r026-20230329   gcc  
xtensa               randconfig-r031-20230329   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
