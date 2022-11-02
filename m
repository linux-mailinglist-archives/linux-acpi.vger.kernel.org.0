Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09AA1615765
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Nov 2022 03:12:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbiKBCMo (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 1 Nov 2022 22:12:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiKBCMn (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 1 Nov 2022 22:12:43 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42AED64F8;
        Tue,  1 Nov 2022 19:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667355161; x=1698891161;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=FaTjZIMPUaV+44T2HRH3XxAC84DB7PBPx2yckCzy/5s=;
  b=Kb1thNIIhftcmycJpwS/OydvPaNT48XvdfhjQrGvKH3loISBNy1mQHjJ
   p10i1lpuU7YAPqrBk9HFHk+wfdVfUWRfkSDjrRrA/mVySiRMvNz/afkjy
   GVgD6IAeQx7B7qIbViDy7HCuX4nwHESWOyC7HskhjBKTMOiYysC1K2Hj3
   lEb6zdZi7SegT3t44tX5Bh7t2AhUZ7yilssGYkD7+Vwr13SasnKdlXXZt
   aAlSMY9Ch+jYDh/cVR45RBTY2uGAOdHtILE0SdGA6sIEQRgaxwV7uRfmh
   6OQoCpeiawpL3FL/UtRfDlgGBt4NrGnxLZpxm75/gHJHt2cTlMf5T/itV
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="296730589"
X-IronPort-AV: E=Sophos;i="5.95,232,1661842800"; 
   d="scan'208";a="296730589"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2022 19:12:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="963346719"
X-IronPort-AV: E=Sophos;i="5.95,232,1661842800"; 
   d="scan'208";a="963346719"
Received: from lkp-server02.sh.intel.com (HELO b6d29c1a0365) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 01 Nov 2022 19:12:36 -0700
Received: from kbuild by b6d29c1a0365 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oq3F5-000EK9-3C;
        Wed, 02 Nov 2022 02:12:35 +0000
Date:   Wed, 02 Nov 2022 10:12:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD REGRESSION
 e0ac4f6ff9ff842b7c287cfa2deb27aadaa76bfb
Message-ID: <6361d1fa.2HklfKes1DjBoezb%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: e0ac4f6ff9ff842b7c287cfa2deb27aadaa76bfb  Merge branch 'acpica' into bleeding-edge

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202210291101.UBt5Vjis-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

arch/loongarch/include/asm/acpi.h:102:8: error: redefinition of 'struct acpi_madt_core_pic'
arch/loongarch/include/asm/acpi.h:112:8: error: redefinition of 'struct acpi_madt_lio_pic'
arch/loongarch/include/asm/acpi.h:123:8: error: redefinition of 'struct acpi_madt_eio_pic'
arch/loongarch/include/asm/acpi.h:133:8: error: redefinition of 'struct acpi_madt_ht_pic'
arch/loongarch/include/asm/acpi.h:143:8: error: redefinition of 'struct acpi_madt_bio_pic'
arch/loongarch/include/asm/acpi.h:154:8: error: redefinition of 'struct acpi_madt_msi_pic'
arch/loongarch/include/asm/acpi.h:164:8: error: redefinition of 'struct acpi_madt_lpc_pic'
arch/loongarch/include/asm/acpi.h:56:6: error: redeclaration of 'enum acpi_madt_core_pic_version'
arch/loongarch/include/asm/acpi.h:57:9: error: redeclaration of enumerator 'ACPI_MADT_CORE_PIC_VERSION_NONE'
arch/loongarch/include/asm/acpi.h:58:9: error: redeclaration of enumerator 'ACPI_MADT_CORE_PIC_VERSION_V1'
arch/loongarch/include/asm/acpi.h:59:9: error: redeclaration of enumerator 'ACPI_MADT_CORE_PIC_VERSION_RESERVED'
arch/loongarch/include/asm/acpi.h:62:6: error: redeclaration of 'enum acpi_madt_lio_pic_version'
arch/loongarch/include/asm/acpi.h:63:9: error: redeclaration of enumerator 'ACPI_MADT_LIO_PIC_VERSION_NONE'
arch/loongarch/include/asm/acpi.h:64:9: error: redeclaration of enumerator 'ACPI_MADT_LIO_PIC_VERSION_V1'
arch/loongarch/include/asm/acpi.h:65:9: error: redeclaration of enumerator 'ACPI_MADT_LIO_PIC_VERSION_RESERVED'
arch/loongarch/include/asm/acpi.h:68:6: error: redeclaration of 'enum acpi_madt_eio_pic_version'
arch/loongarch/include/asm/acpi.h:69:9: error: redeclaration of enumerator 'ACPI_MADT_EIO_PIC_VERSION_NONE'
arch/loongarch/include/asm/acpi.h:70:9: error: redeclaration of enumerator 'ACPI_MADT_EIO_PIC_VERSION_V1'
arch/loongarch/include/asm/acpi.h:71:9: error: redeclaration of enumerator 'ACPI_MADT_EIO_PIC_VERSION_RESERVED'
arch/loongarch/include/asm/acpi.h:74:6: error: redeclaration of 'enum acpi_madt_ht_pic_version'
arch/loongarch/include/asm/acpi.h:75:9: error: redeclaration of enumerator 'ACPI_MADT_HT_PIC_VERSION_NONE'
arch/loongarch/include/asm/acpi.h:76:9: error: redeclaration of enumerator 'ACPI_MADT_HT_PIC_VERSION_V1'
arch/loongarch/include/asm/acpi.h:77:9: error: redeclaration of enumerator 'ACPI_MADT_HT_PIC_VERSION_RESERVED'
arch/loongarch/include/asm/acpi.h:80:6: error: redeclaration of 'enum acpi_madt_bio_pic_version'
arch/loongarch/include/asm/acpi.h:81:9: error: redeclaration of enumerator 'ACPI_MADT_BIO_PIC_VERSION_NONE'
arch/loongarch/include/asm/acpi.h:82:9: error: redeclaration of enumerator 'ACPI_MADT_BIO_PIC_VERSION_V1'
arch/loongarch/include/asm/acpi.h:83:9: error: redeclaration of enumerator 'ACPI_MADT_BIO_PIC_VERSION_RESERVED'
arch/loongarch/include/asm/acpi.h:86:6: error: redeclaration of 'enum acpi_madt_msi_pic_version'
arch/loongarch/include/asm/acpi.h:87:9: error: redeclaration of enumerator 'ACPI_MADT_MSI_PIC_VERSION_NONE'
arch/loongarch/include/asm/acpi.h:88:9: error: redeclaration of enumerator 'ACPI_MADT_MSI_PIC_VERSION_V1'
arch/loongarch/include/asm/acpi.h:89:9: error: redeclaration of enumerator 'ACPI_MADT_MSI_PIC_VERSION_RESERVED'
arch/loongarch/include/asm/acpi.h:92:6: error: redeclaration of 'enum acpi_madt_lpc_pic_version'
arch/loongarch/include/asm/acpi.h:93:9: error: redeclaration of enumerator 'ACPI_MADT_LPC_PIC_VERSION_NONE'
arch/loongarch/include/asm/acpi.h:94:9: error: redeclaration of enumerator 'ACPI_MADT_LPC_PIC_VERSION_V1'
arch/loongarch/include/asm/acpi.h:95:9: error: redeclaration of enumerator 'ACPI_MADT_LPC_PIC_VERSION_RESERVED'
drivers/irqchip/irq-loongarch-cpu.c:101:46: error: passing argument 2 of 'liointc_acpi_init' from incompatible pointer type [-Werror=incompatible-pointer-types]
drivers/irqchip/irq-loongarch-cpu.c:110:46: error: passing argument 2 of 'eiointc_acpi_init' from incompatible pointer type [-Werror=incompatible-pointer-types]
drivers/irqchip/irq-loongson-eiointc.c:313:50: error: passing argument 2 of 'pch_pic_acpi_init' from incompatible pointer type [-Werror=incompatible-pointer-types]
drivers/irqchip/irq-loongson-eiointc.c:326:50: error: passing argument 2 of 'pch_msi_acpi_init' from incompatible pointer type [-Werror=incompatible-pointer-types]
drivers/irqchip/irq-loongson-eiointc.c:340:12: error: conflicting types for 'eiointc_acpi_init'; have 'int(struct irq_domain *, struct acpi_madt_eio_pic *)'
drivers/irqchip/irq-loongson-liointc.c:352:12: error: conflicting types for 'liointc_acpi_init'; have 'int(struct irq_domain *, struct acpi_madt_lio_pic *)'
drivers/irqchip/irq-loongson-pch-lpc.c:150:12: error: conflicting types for 'pch_lpc_acpi_init'; have 'int(struct irq_domain *, struct acpi_madt_lpc_pic *)'
drivers/irqchip/irq-loongson-pch-pic.c:334:63: error: passing argument 2 of 'pch_lpc_acpi_init' from incompatible pointer type [-Werror=incompatible-pointer-types]
drivers/irqchip/irq-loongson-pch-pic.c:344:12: error: conflicting types for 'pch_pic_acpi_init'; have 'int(struct irq_domain *, struct acpi_madt_bio_pic *)'

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- loongarch-allyesconfig
|   |-- arch-loongarch-include-asm-acpi.h:error:redeclaration-of-enum-acpi_madt_bio_pic_version
|   |-- arch-loongarch-include-asm-acpi.h:error:redeclaration-of-enum-acpi_madt_core_pic_version
|   |-- arch-loongarch-include-asm-acpi.h:error:redeclaration-of-enum-acpi_madt_eio_pic_version
|   |-- arch-loongarch-include-asm-acpi.h:error:redeclaration-of-enum-acpi_madt_ht_pic_version
|   |-- arch-loongarch-include-asm-acpi.h:error:redeclaration-of-enum-acpi_madt_lio_pic_version
|   |-- arch-loongarch-include-asm-acpi.h:error:redeclaration-of-enum-acpi_madt_lpc_pic_version
|   |-- arch-loongarch-include-asm-acpi.h:error:redeclaration-of-enum-acpi_madt_msi_pic_version
|   |-- arch-loongarch-include-asm-acpi.h:error:redeclaration-of-enumerator-ACPI_MADT_BIO_PIC_VERSION_NONE
|   |-- arch-loongarch-include-asm-acpi.h:error:redeclaration-of-enumerator-ACPI_MADT_BIO_PIC_VERSION_RESERVED
|   |-- arch-loongarch-include-asm-acpi.h:error:redeclaration-of-enumerator-ACPI_MADT_BIO_PIC_VERSION_V1
|   |-- arch-loongarch-include-asm-acpi.h:error:redeclaration-of-enumerator-ACPI_MADT_CORE_PIC_VERSION_NONE
|   |-- arch-loongarch-include-asm-acpi.h:error:redeclaration-of-enumerator-ACPI_MADT_CORE_PIC_VERSION_RESERVED
|   |-- arch-loongarch-include-asm-acpi.h:error:redeclaration-of-enumerator-ACPI_MADT_CORE_PIC_VERSION_V1
|   |-- arch-loongarch-include-asm-acpi.h:error:redeclaration-of-enumerator-ACPI_MADT_EIO_PIC_VERSION_NONE
|   |-- arch-loongarch-include-asm-acpi.h:error:redeclaration-of-enumerator-ACPI_MADT_EIO_PIC_VERSION_RESERVED
|   |-- arch-loongarch-include-asm-acpi.h:error:redeclaration-of-enumerator-ACPI_MADT_EIO_PIC_VERSION_V1
|   |-- arch-loongarch-include-asm-acpi.h:error:redeclaration-of-enumerator-ACPI_MADT_HT_PIC_VERSION_NONE
|   |-- arch-loongarch-include-asm-acpi.h:error:redeclaration-of-enumerator-ACPI_MADT_HT_PIC_VERSION_RESERVED
|   |-- arch-loongarch-include-asm-acpi.h:error:redeclaration-of-enumerator-ACPI_MADT_HT_PIC_VERSION_V1
|   |-- arch-loongarch-include-asm-acpi.h:error:redeclaration-of-enumerator-ACPI_MADT_LIO_PIC_VERSION_NONE
|   |-- arch-loongarch-include-asm-acpi.h:error:redeclaration-of-enumerator-ACPI_MADT_LIO_PIC_VERSION_RESERVED
|   |-- arch-loongarch-include-asm-acpi.h:error:redeclaration-of-enumerator-ACPI_MADT_LIO_PIC_VERSION_V1
|   |-- arch-loongarch-include-asm-acpi.h:error:redeclaration-of-enumerator-ACPI_MADT_LPC_PIC_VERSION_NONE
|   |-- arch-loongarch-include-asm-acpi.h:error:redeclaration-of-enumerator-ACPI_MADT_LPC_PIC_VERSION_RESERVED
|   |-- arch-loongarch-include-asm-acpi.h:error:redeclaration-of-enumerator-ACPI_MADT_LPC_PIC_VERSION_V1
|   |-- arch-loongarch-include-asm-acpi.h:error:redeclaration-of-enumerator-ACPI_MADT_MSI_PIC_VERSION_NONE
|   |-- arch-loongarch-include-asm-acpi.h:error:redeclaration-of-enumerator-ACPI_MADT_MSI_PIC_VERSION_RESERVED
|   |-- arch-loongarch-include-asm-acpi.h:error:redeclaration-of-enumerator-ACPI_MADT_MSI_PIC_VERSION_V1
|   |-- arch-loongarch-include-asm-acpi.h:error:redefinition-of-struct-acpi_madt_bio_pic
|   |-- arch-loongarch-include-asm-acpi.h:error:redefinition-of-struct-acpi_madt_core_pic
|   |-- arch-loongarch-include-asm-acpi.h:error:redefinition-of-struct-acpi_madt_eio_pic
|   |-- arch-loongarch-include-asm-acpi.h:error:redefinition-of-struct-acpi_madt_ht_pic
|   |-- arch-loongarch-include-asm-acpi.h:error:redefinition-of-struct-acpi_madt_lio_pic
|   |-- arch-loongarch-include-asm-acpi.h:error:redefinition-of-struct-acpi_madt_lpc_pic
|   `-- arch-loongarch-include-asm-acpi.h:error:redefinition-of-struct-acpi_madt_msi_pic
`-- loongarch-randconfig-r012-20221101
    |-- arch-loongarch-include-asm-acpi.h:error:redeclaration-of-enum-acpi_madt_bio_pic_version
    |-- arch-loongarch-include-asm-acpi.h:error:redeclaration-of-enum-acpi_madt_core_pic_version
    |-- arch-loongarch-include-asm-acpi.h:error:redeclaration-of-enum-acpi_madt_eio_pic_version
    |-- arch-loongarch-include-asm-acpi.h:error:redeclaration-of-enum-acpi_madt_ht_pic_version
    |-- arch-loongarch-include-asm-acpi.h:error:redeclaration-of-enum-acpi_madt_lio_pic_version
    |-- arch-loongarch-include-asm-acpi.h:error:redeclaration-of-enum-acpi_madt_lpc_pic_version
    |-- arch-loongarch-include-asm-acpi.h:error:redeclaration-of-enum-acpi_madt_msi_pic_version
    |-- arch-loongarch-include-asm-acpi.h:error:redeclaration-of-enumerator-ACPI_MADT_BIO_PIC_VERSION_NONE
    |-- arch-loongarch-include-asm-acpi.h:error:redeclaration-of-enumerator-ACPI_MADT_BIO_PIC_VERSION_RESERVED
    |-- arch-loongarch-include-asm-acpi.h:error:redeclaration-of-enumerator-ACPI_MADT_BIO_PIC_VERSION_V1
    |-- arch-loongarch-include-asm-acpi.h:error:redeclaration-of-enumerator-ACPI_MADT_CORE_PIC_VERSION_NONE
    |-- arch-loongarch-include-asm-acpi.h:error:redeclaration-of-enumerator-ACPI_MADT_CORE_PIC_VERSION_RESERVED
    |-- arch-loongarch-include-asm-acpi.h:error:redeclaration-of-enumerator-ACPI_MADT_CORE_PIC_VERSION_V1

elapsed time: 727m

configs tested: 62
configs skipped: 2

gcc tested configs:
arc                                 defconfig
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                    rhel-8.3-kselftests
alpha                               defconfig
x86_64                           rhel-8.3-kvm
powerpc                           allnoconfig
x86_64                              defconfig
um                             i386_defconfig
arm                                 defconfig
x86_64                          rhel-8.3-func
um                           x86_64_defconfig
x86_64                        randconfig-a015
s390                                defconfig
arm64                            allyesconfig
i386                                defconfig
arm                              allyesconfig
i386                          randconfig-a012
arc                               allnoconfig
x86_64                               rhel-8.3
arc                              allyesconfig
ia64                             allmodconfig
i386                          randconfig-a016
alpha                             allnoconfig
s390                             allmodconfig
alpha                            allyesconfig
x86_64                           allyesconfig
riscv                             allnoconfig
sh                               allmodconfig
arc                  randconfig-r043-20221101
csky                              allnoconfig
mips                             allyesconfig
i386                          randconfig-a014
m68k                             allmodconfig
powerpc                          allmodconfig
s390                             allyesconfig
m68k                             allyesconfig
i386                             allyesconfig

clang tested configs:
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64               randconfig-a003-20221031
x86_64                        randconfig-a012
x86_64               randconfig-a002-20221031
i386                 randconfig-a001-20221031
i386                 randconfig-a003-20221031
i386                 randconfig-a002-20221031
x86_64               randconfig-a001-20221031
i386                          randconfig-a013
x86_64               randconfig-a006-20221031
i386                          randconfig-a011
hexagon              randconfig-r041-20221101
i386                 randconfig-a004-20221031
i386                 randconfig-a006-20221031
x86_64               randconfig-a004-20221031
x86_64               randconfig-a005-20221031
i386                 randconfig-a005-20221031
i386                          randconfig-a015
hexagon              randconfig-r045-20221101
riscv                randconfig-r042-20221101
s390                 randconfig-r044-20221101

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
