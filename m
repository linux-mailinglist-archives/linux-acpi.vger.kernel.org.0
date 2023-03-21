Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5538E6C2F69
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Mar 2023 11:48:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbjCUKsd (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 21 Mar 2023 06:48:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230401AbjCUKsa (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 21 Mar 2023 06:48:30 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1FD99029;
        Tue, 21 Mar 2023 03:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679395706; x=1710931706;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=ozkBxyLK7jmIpwekhGiHrLbDv0ojsvvroOPkxk7rBBI=;
  b=PjXptzBfCMdrcHxn7IzYYIelryQmOYSMK4iGW8XY47fFxKVuFDnMHw6A
   ZOvnfaz+q6cmOvnzDMjdCeesWpYTmPWLbgT7eYP/Z2VV3Ezfh7P5oc5dr
   0XTN+P+qrdBYBS5Frz053dO6441R/BNKb30u/P2o9Mu9gAgk/mxuCmRDy
   aQw1x+U0ddOHEB7zZIluoWlP57oBf+dn1pybo/dVnZnXu/KeVaHs5l6Iw
   VDXoxrtHr+mDd6YMPVFGMvf5CWBHlOsz1A+WwP8K30eEWiqnXubG09kBB
   Pgpj3YZaiNhhnrzISQjjH6itUOswuG4pXjnk9/2cQx8jGvvT1kIXeopdu
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="318559111"
X-IronPort-AV: E=Sophos;i="5.98,278,1673942400"; 
   d="scan'208";a="318559111"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2023 03:48:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="711759485"
X-IronPort-AV: E=Sophos;i="5.98,278,1673942400"; 
   d="scan'208";a="711759485"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 21 Mar 2023 03:48:24 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1peZXU-000Bp2-0E;
        Tue, 21 Mar 2023 10:48:24 +0000
Date:   Tue, 21 Mar 2023 18:48:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD REGRESSION
 226ec3112c6fa4db1188828f76319f7eb6eb85ee
Message-ID: <64198b60.bO+m9o5w+Hd8hcF3%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 226ec3112c6fa4db1188828f76319f7eb6eb85ee  Merge branch 'thermal/bleeding-edge' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux into bleeding-edge

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202303210729.DvRvIUla-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202303210858.dZnSlO11-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

drivers/acpi/processor_pdc.c:59:10: error: implicit declaration of function 'xen_processor_present' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
drivers/acpi/processor_pdc.c:59:24: error: implicit declaration of function 'xen_processor_present' [-Werror=implicit-function-declaration]

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- i386-allyesconfig
|   `-- drivers-acpi-processor_pdc.c:error:implicit-declaration-of-function-xen_processor_present
|-- i386-debian-10.3
|   `-- drivers-acpi-processor_pdc.c:error:implicit-declaration-of-function-xen_processor_present
|-- i386-defconfig
|   `-- drivers-acpi-processor_pdc.c:error:implicit-declaration-of-function-xen_processor_present
|-- i386-randconfig-a012
|   `-- drivers-acpi-processor_pdc.c:error:implicit-declaration-of-function-xen_processor_present
|-- i386-randconfig-a014
|   `-- drivers-acpi-processor_pdc.c:error:implicit-declaration-of-function-xen_processor_present
|-- i386-randconfig-a016
|   `-- drivers-acpi-processor_pdc.c:error:implicit-declaration-of-function-xen_processor_present
|-- ia64-allmodconfig
|   `-- drivers-acpi-processor_pdc.c:error:implicit-declaration-of-function-xen_processor_present
|-- ia64-allyesconfig
|   `-- drivers-acpi-processor_pdc.c:error:implicit-declaration-of-function-xen_processor_present
|-- ia64-buildonly-randconfig-r004-20230320
|   `-- drivers-acpi-processor_pdc.c:error:implicit-declaration-of-function-xen_processor_present
|-- ia64-defconfig
|   `-- drivers-acpi-processor_pdc.c:error:implicit-declaration-of-function-xen_processor_present
|-- ia64-randconfig-r033-20230319
|   `-- drivers-acpi-processor_pdc.c:error:implicit-declaration-of-function-xen_processor_present
|-- ia64-randconfig-r036-20230320
|   `-- drivers-acpi-processor_pdc.c:error:implicit-declaration-of-function-xen_processor_present
|-- x86_64-defconfig
|   `-- drivers-acpi-processor_pdc.c:error:implicit-declaration-of-function-xen_processor_present
|-- x86_64-kexec
|   `-- drivers-acpi-processor_pdc.c:error:implicit-declaration-of-function-xen_processor_present
|-- x86_64-randconfig-a011
|   `-- drivers-acpi-processor_pdc.c:error:implicit-declaration-of-function-xen_processor_present
|-- x86_64-randconfig-a013
|   `-- drivers-acpi-processor_pdc.c:error:implicit-declaration-of-function-xen_processor_present
|-- x86_64-randconfig-a015
|   `-- drivers-acpi-processor_pdc.c:error:implicit-declaration-of-function-xen_processor_present
`-- x86_64-rhel-8.3
    `-- drivers-acpi-processor_pdc.c:error:implicit-declaration-of-function-xen_processor_present
clang_recent_errors
|-- i386-randconfig-a001-20230320
|   `-- drivers-acpi-processor_pdc.c:error:implicit-declaration-of-function-xen_processor_present-is-invalid-in-C99-Werror-Wimplicit-function-declaration
|-- i386-randconfig-a002-20230320
|   `-- drivers-acpi-processor_pdc.c:error:implicit-declaration-of-function-xen_processor_present-is-invalid-in-C99-Werror-Wimplicit-function-declaration
|-- i386-randconfig-a003-20230320
|   `-- drivers-acpi-processor_pdc.c:error:implicit-declaration-of-function-xen_processor_present-is-invalid-in-C99-Werror-Wimplicit-function-declaration
|-- i386-randconfig-a004-20230320
|   `-- drivers-acpi-processor_pdc.c:error:implicit-declaration-of-function-xen_processor_present-is-invalid-in-C99-Werror-Wimplicit-function-declaration
|-- i386-randconfig-a005-20230320
|   `-- drivers-acpi-processor_pdc.c:error:implicit-declaration-of-function-xen_processor_present-is-invalid-in-C99-Werror-Wimplicit-function-declaration
|-- i386-randconfig-a006-20230320
|   `-- drivers-acpi-processor_pdc.c:error:implicit-declaration-of-function-xen_processor_present-is-invalid-in-C99-Werror-Wimplicit-function-declaration
|-- i386-randconfig-a011
|   `-- drivers-acpi-processor_pdc.c:error:implicit-declaration-of-function-xen_processor_present-is-invalid-in-C99-Werror-Wimplicit-function-declaration
|-- i386-randconfig-a013
|   `-- drivers-acpi-processor_pdc.c:error:implicit-declaration-of-function-xen_processor_present-is-invalid-in-C99-Werror-Wimplicit-function-declaration
|-- i386-randconfig-a015
|   `-- drivers-acpi-processor_pdc.c:error:implicit-declaration-of-function-xen_processor_present-is-invalid-in-C99-Werror-Wimplicit-function-declaration
|-- x86_64-randconfig-a012
|   `-- drivers-acpi-processor_pdc.c:error:implicit-declaration-of-function-xen_processor_present-is-invalid-in-C99-Werror-Wimplicit-function-declaration
|-- x86_64-randconfig-a014
|   `-- drivers-acpi-processor_pdc.c:error:implicit-declaration-of-function-xen_processor_present-is-invalid-in-C99-Werror-Wimplicit-function-declaration
|-- x86_64-randconfig-a016
|   `-- drivers-acpi-processor_pdc.c:error:implicit-declaration-of-function-xen_processor_present-is-invalid-in-C99-Werror-Wimplicit-function-declaration
`-- x86_64-randconfig-r032-20230320
    `-- drivers-acpi-processor_pdc.c:error:implicit-declaration-of-function-xen_processor_present-is-invalid-in-C99-Werror-Wimplicit-function-declaration

elapsed time: 727m

configs tested: 92
configs skipped: 6

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc          buildonly-randconfig-r002-20230320   gcc  
arc                                 defconfig   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm          buildonly-randconfig-r003-20230320   clang
arm                                 defconfig   gcc  
arm64                            allyesconfig   gcc  
arm64        buildonly-randconfig-r004-20230319   gcc  
arm64        buildonly-randconfig-r006-20230319   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r011-20230320   gcc  
arm64                randconfig-r016-20230320   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r035-20230320   gcc  
hexagon      buildonly-randconfig-r001-20230319   clang
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-a001-20230320   clang
i386                 randconfig-a002-20230320   clang
i386                 randconfig-a003-20230320   clang
i386                 randconfig-a004-20230320   clang
i386                 randconfig-a005-20230320   clang
i386                 randconfig-a006-20230320   clang
i386                          randconfig-a011   clang
i386                          randconfig-a012   gcc  
i386                          randconfig-a013   clang
i386                          randconfig-a014   gcc  
i386                          randconfig-a015   clang
i386                          randconfig-a016   gcc  
ia64                             allmodconfig   gcc  
ia64         buildonly-randconfig-r004-20230320   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r033-20230319   gcc  
ia64                 randconfig-r036-20230320   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k         buildonly-randconfig-r005-20230319   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r014-20230320   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips         buildonly-randconfig-r001-20230320   gcc  
mips         buildonly-randconfig-r002-20230319   clang
mips                 randconfig-r034-20230320   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r036-20230319   gcc  
openrisc             randconfig-r035-20230319   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390         buildonly-randconfig-r003-20230319   clang
s390         buildonly-randconfig-r006-20230320   gcc  
s390                                defconfig   gcc  
sh                               allmodconfig   gcc  
sh                   randconfig-r032-20230319   gcc  
sparc        buildonly-randconfig-r005-20230320   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r015-20230320   gcc  
sparc                randconfig-r031-20230319   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                        randconfig-a011   gcc  
x86_64                        randconfig-a012   clang
x86_64                        randconfig-a013   gcc  
x86_64                        randconfig-a014   clang
x86_64                        randconfig-a015   gcc  
x86_64                        randconfig-a016   clang
x86_64               randconfig-r032-20230320   clang
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r012-20230320   gcc  
xtensa               randconfig-r033-20230320   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
