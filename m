Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 424D36D5947
	for <lists+linux-acpi@lfdr.de>; Tue,  4 Apr 2023 09:17:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233573AbjDDHRI (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 4 Apr 2023 03:17:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233352AbjDDHRH (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 4 Apr 2023 03:17:07 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F28E21FCB;
        Tue,  4 Apr 2023 00:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680592626; x=1712128626;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=0GAiw+Kt1h6raWI1YzFMq5fFZ6Qe6qc5kiUP1AxeJ1o=;
  b=YoOWUWFR9MJitOl8YcJgqIv4TJp1w+3n7D2YiLv9K+jovzHMIkHCSQf7
   38rXH3FByCWvAfa1tEFWpLfBVuACQaqt6Fg0ss8o5/vVV7zAgM4tcnAqA
   1plB9rjnuNli58RcHw38wRyZOxT+1kh8iF2d9hbHFC0g9dVIIUwMh6HdT
   E8QlK4jZptPmV27wVyAY58gOW/5qpZQ1/y725DRqpqbdX1WD0+a9ZsKqs
   aTfXyjZ79n4hw1ggzxtvmWIj1jG4j23PctF/sFF6FUEOtoar3jEqbVwh9
   yAwfvEL0whpxZ3xggtzZPhTv/Sj2moWdgNECGF4iedOSTK9X2w6iOdS/5
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10669"; a="369925396"
X-IronPort-AV: E=Sophos;i="5.98,317,1673942400"; 
   d="scan'208";a="369925396"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2023 00:17:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10669"; a="755535054"
X-IronPort-AV: E=Sophos;i="5.98,317,1673942400"; 
   d="scan'208";a="755535054"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 04 Apr 2023 00:16:59 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pjauZ-000PJx-0R;
        Tue, 04 Apr 2023 07:16:59 +0000
Date:   Tue, 04 Apr 2023 15:16:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD REGRESSION
 d26f8f17a7c10cb922870a72e09166c628166a16
Message-ID: <642bcede.0npEWY0aQzbqyZg/%lkp@intel.com>
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
branch HEAD: d26f8f17a7c10cb922870a72e09166c628166a16  Merge branch 'thermal-next' into bleeding-edge

Error/Warning: (recently discovered and may have been fixed)

drivers/ata/pata_ixp4xx_cf.c:254:46: error: invalid use of undefined type 'struct device_node'
drivers/ata/pata_ixp4xx_cf.c:258:15: error: implicit declaration of function 'of_property_read_u32_index'; did you mean 'fwnode_property_read_u32_array'? [-Werror=implicit-function-declaration]
drivers/ata/pata_ixp4xx_cf.c:294:34: error: array type has incomplete element type 'struct of_device_id'
drivers/fpga/lattice-sysconfig-spi.c:146:35: error: implicit declaration of function 'of_match_ptr' [-Werror=implicit-function-declaration]
drivers/fpga/lattice-sysconfig-spi.c:146:35: error: initializer element is not constant
drivers/virtio/virtio_mmio.c:492:13: error: implicit declaration of function 'of_property_read_bool'; did you mean 'fwnode_property_read_bool'? [-Werror=implicit-function-declaration]
drivers/virtio/virtio_mmio.c:492:6: error: call to undeclared function 'of_property_read_bool'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]

Unverified Error/Warning (likely false positive, please contact us if interested):

drivers/perf/alibaba_uncore_drw_pmu.c:758:36: error: array type has incomplete element type 'struct acpi_device_id'
drivers/perf/arm_dmc620_pmu.c:711:36: error: array type has incomplete element type 'struct acpi_device_id'

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- alpha-allyesconfig
|   |-- drivers-ata-pata_ixp4xx_cf.c:error:array-type-has-incomplete-element-type-struct-of_device_id
|   |-- drivers-ata-pata_ixp4xx_cf.c:error:implicit-declaration-of-function-of_property_read_u32_index
|   |-- drivers-ata-pata_ixp4xx_cf.c:error:invalid-use-of-undefined-type-struct-device_node
|   |-- drivers-fpga-lattice-sysconfig-spi.c:error:implicit-declaration-of-function-of_match_ptr
|   |-- drivers-fpga-lattice-sysconfig-spi.c:error:initializer-element-is-not-constant
|   |-- drivers-perf-alibaba_uncore_drw_pmu.c:error:array-type-has-incomplete-element-type-struct-acpi_device_id
|   |-- drivers-perf-arm_dmc620_pmu.c:error:array-type-has-incomplete-element-type-struct-acpi_device_id
|   `-- drivers-virtio-virtio_mmio.c:error:implicit-declaration-of-function-of_property_read_bool
|-- arc-allyesconfig
|   |-- drivers-ata-pata_ixp4xx_cf.c:error:array-type-has-incomplete-element-type-struct-of_device_id
|   |-- drivers-ata-pata_ixp4xx_cf.c:error:implicit-declaration-of-function-of_property_read_u32_index
|   |-- drivers-ata-pata_ixp4xx_cf.c:error:invalid-use-of-undefined-type-struct-device_node
|   |-- drivers-fpga-lattice-sysconfig-spi.c:error:implicit-declaration-of-function-of_match_ptr
|   |-- drivers-fpga-lattice-sysconfig-spi.c:error:initializer-element-is-not-constant
|   |-- drivers-perf-alibaba_uncore_drw_pmu.c:error:array-type-has-incomplete-element-type-struct-acpi_device_id
|   |-- drivers-perf-arm_dmc620_pmu.c:error:array-type-has-incomplete-element-type-struct-acpi_device_id
|   `-- drivers-virtio-virtio_mmio.c:error:implicit-declaration-of-function-of_property_read_bool
|-- arc-randconfig-r043-20230403
|   `-- drivers-virtio-virtio_mmio.c:error:implicit-declaration-of-function-of_property_read_bool
|-- arm-allmodconfig
|   |-- drivers-ata-pata_ixp4xx_cf.c:error:array-type-has-incomplete-element-type-struct-of_device_id
|   |-- drivers-ata-pata_ixp4xx_cf.c:error:implicit-declaration-of-function-of_property_read_u32_index
|   |-- drivers-ata-pata_ixp4xx_cf.c:error:invalid-use-of-undefined-type-struct-device_node
|   |-- drivers-fpga-lattice-sysconfig-spi.c:error:implicit-declaration-of-function-of_match_ptr
|   |-- drivers-fpga-lattice-sysconfig-spi.c:error:initializer-element-is-not-constant
|   |-- drivers-perf-alibaba_uncore_drw_pmu.c:error:array-type-has-incomplete-element-type-struct-acpi_device_id
|   |-- drivers-perf-arm_dmc620_pmu.c:error:array-type-has-incomplete-element-type-struct-acpi_device_id
|   `-- drivers-virtio-virtio_mmio.c:error:implicit-declaration-of-function-of_property_read_bool
|-- arm-allyesconfig
|   |-- drivers-ata-pata_ixp4xx_cf.c:error:array-type-has-incomplete-element-type-struct-of_device_id
|   |-- drivers-ata-pata_ixp4xx_cf.c:error:implicit-declaration-of-function-of_property_read_u32_index
|   |-- drivers-ata-pata_ixp4xx_cf.c:error:invalid-use-of-undefined-type-struct-device_node
|   |-- drivers-fpga-lattice-sysconfig-spi.c:error:implicit-declaration-of-function-of_match_ptr
|   |-- drivers-fpga-lattice-sysconfig-spi.c:error:initializer-element-is-not-constant
|   |-- drivers-perf-alibaba_uncore_drw_pmu.c:error:array-type-has-incomplete-element-type-struct-acpi_device_id
|   |-- drivers-perf-arm_dmc620_pmu.c:error:array-type-has-incomplete-element-type-struct-acpi_device_id
|   `-- drivers-virtio-virtio_mmio.c:error:implicit-declaration-of-function-of_property_read_bool
|-- arm-defconfig
|   `-- drivers-virtio-virtio_mmio.c:error:implicit-declaration-of-function-of_property_read_bool
|-- arm64-allyesconfig
|   |-- drivers-ata-pata_ixp4xx_cf.c:error:implicit-declaration-of-function-of_property_read_u32_index
|   |-- drivers-ata-pata_ixp4xx_cf.c:error:invalid-use-of-undefined-type-struct-device_node
|   |-- drivers-fpga-lattice-sysconfig-spi.c:error:implicit-declaration-of-function-of_match_ptr
|   |-- drivers-fpga-lattice-sysconfig-spi.c:error:initializer-element-is-not-constant
|   `-- drivers-virtio-virtio_mmio.c:error:implicit-declaration-of-function-of_property_read_bool
|-- arm64-defconfig
|   `-- drivers-virtio-virtio_mmio.c:error:implicit-declaration-of-function-of_property_read_bool
|-- csky-buildonly-randconfig-r002-20230403
|   `-- drivers-virtio-virtio_mmio.c:error:implicit-declaration-of-function-of_property_read_bool
clang_recent_errors
|-- arm-randconfig-r046-20230403
|   `-- drivers-virtio-virtio_mmio.c:error:call-to-undeclared-function-of_property_read_bool-ISO-C99-and-later-do-not-support-implicit-function-declarations
|-- arm64-buildonly-randconfig-r003-20230403
|   `-- drivers-virtio-virtio_mmio.c:error:call-to-undeclared-function-of_property_read_bool-ISO-C99-and-later-do-not-support-implicit-function-declarations
|-- hexagon-buildonly-randconfig-r004-20230403
|   `-- drivers-virtio-virtio_mmio.c:error:call-to-undeclared-function-of_property_read_bool-ISO-C99-and-later-do-not-support-implicit-function-declarations
`-- hexagon-randconfig-r016-20230403
    `-- drivers-virtio-virtio_mmio.c:error:call-to-undeclared-function-of_property_read_bool-ISO-C99-and-later-do-not-support-implicit-function-declarations

elapsed time: 722m

configs tested: 106
configs skipped: 4

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r034-20230403   gcc  
arc                  randconfig-r043-20230403   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r046-20230403   clang
arm64                            allyesconfig   gcc  
arm64        buildonly-randconfig-r003-20230403   clang
arm64                               defconfig   gcc  
arm64                randconfig-r004-20230403   clang
csky         buildonly-randconfig-r002-20230403   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r033-20230403   gcc  
hexagon      buildonly-randconfig-r004-20230403   clang
hexagon              randconfig-r006-20230403   clang
hexagon              randconfig-r016-20230403   clang
hexagon              randconfig-r035-20230403   clang
hexagon              randconfig-r041-20230403   clang
hexagon              randconfig-r045-20230403   clang
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-a001-20230403   clang
i386                 randconfig-a002-20230403   clang
i386                 randconfig-a003-20230403   clang
i386                 randconfig-a004-20230403   clang
i386                 randconfig-a005-20230403   clang
i386                 randconfig-a006-20230403   clang
i386                 randconfig-a011-20230403   gcc  
i386                 randconfig-a012-20230403   gcc  
i386                 randconfig-a013-20230403   gcc  
i386                 randconfig-a014-20230403   gcc  
i386                 randconfig-a015-20230403   gcc  
i386                 randconfig-a016-20230403   gcc  
i386                 randconfig-r015-20230403   gcc  
i386                 randconfig-r022-20230403   gcc  
i386                 randconfig-r036-20230403   clang
ia64                             allmodconfig   gcc  
ia64         buildonly-randconfig-r006-20230403   gcc  
ia64                                defconfig   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k         buildonly-randconfig-r005-20230403   gcc  
m68k                                defconfig   gcc  
microblaze           randconfig-r023-20230403   gcc  
microblaze           randconfig-r024-20230403   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
nios2                               defconfig   gcc  
openrisc             randconfig-r013-20230403   gcc  
openrisc             randconfig-r025-20230403   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r003-20230403   gcc  
parisc               randconfig-r014-20230403   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc              randconfig-r005-20230403   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r021-20230403   gcc  
riscv                randconfig-r042-20230403   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r012-20230403   gcc  
s390                 randconfig-r044-20230403   gcc  
sh                               allmodconfig   gcc  
sh                   randconfig-r011-20230403   gcc  
sh                   randconfig-r031-20230403   gcc  
sparc        buildonly-randconfig-r001-20230403   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r001-20230403   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230403   clang
x86_64               randconfig-a002-20230403   clang
x86_64               randconfig-a003-20230403   clang
x86_64               randconfig-a004-20230403   clang
x86_64               randconfig-a005-20230403   clang
x86_64               randconfig-a006-20230403   clang
x86_64               randconfig-a011-20230403   gcc  
x86_64               randconfig-a012-20230403   gcc  
x86_64               randconfig-a013-20230403   gcc  
x86_64               randconfig-a014-20230403   gcc  
x86_64               randconfig-a015-20230403   gcc  
x86_64               randconfig-a016-20230403   gcc  
x86_64               randconfig-r026-20230403   gcc  
x86_64               randconfig-r032-20230403   clang
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
