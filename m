Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DF8B61218D
	for <lists+linux-acpi@lfdr.de>; Sat, 29 Oct 2022 10:45:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbiJ2IpY (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 29 Oct 2022 04:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiJ2IpX (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 29 Oct 2022 04:45:23 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E1BA196EDA;
        Sat, 29 Oct 2022 01:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667033122; x=1698569122;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=eW0l4vh1EvfKw92JbwHaOUTwKitW3szL0V4i8boU3XA=;
  b=Ac2xxlAJfe+Vqd682Zv8vlGKm5/cR4sWd6lE+RE4kfgMYMA6mvEwed+L
   69RnPhC7j8KLbqhg2Gdd2XeHbGONoqPaAWybx1PNcDEqTmEQ66qtByycP
   eEK9gguDefnc+meCpzdqc+ph4LItDpUlrmUNp/YN1UnOoCBbOB8ayVtfA
   Ux/tyBMsO/2Wa1YbbpHEcjGW4/KkXMP3XBPh2AKu1Yn3O3i3dZq0ASM02
   Fh5du9Fh3S2/hw3mdDHzRQg8MHZPQoARgfHNBoMKgmuaorOdiqpv/1BXw
   oCvDWo5zPGvM/A6FDJ9PPgUh+ECyDqp6IYptIlvdQUj3oag9GiF9tLWG+
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10514"; a="307377191"
X-IronPort-AV: E=Sophos;i="5.95,223,1661842800"; 
   d="scan'208";a="307377191"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2022 01:45:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10514"; a="610998755"
X-IronPort-AV: E=Sophos;i="5.95,223,1661842800"; 
   d="scan'208";a="610998755"
Received: from lkp-server02.sh.intel.com (HELO b6d29c1a0365) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 29 Oct 2022 01:45:19 -0700
Received: from kbuild by b6d29c1a0365 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oohSx-000Apg-0i;
        Sat, 29 Oct 2022 08:45:19 +0000
Date:   Sat, 29 Oct 2022 16:44:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD REGRESSION
 8e9079a14a87adc267d8fef9bf420af3a8d84d60
Message-ID: <635ce7ff.ONljMpQ4l0Y8sJBX%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 8e9079a14a87adc267d8fef9bf420af3a8d84d60  Merge branch 'thermal-intel' into bleeding-edge

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
|-- loongarch-buildonly-randconfig-r002-20221029
|   |-- drivers-irqchip-irq-loongarch-cpu.c:error:passing-argument-of-eiointc_acpi_init-from-incompatible-pointer-type
|   |-- drivers-irqchip-irq-loongarch-cpu.c:error:passing-argument-of-liointc_acpi_init-from-incompatible-pointer-type
|   |-- drivers-irqchip-irq-loongson-eiointc.c:error:conflicting-types-for-eiointc_acpi_init-have-int(struct-irq_domain-struct-acpi_madt_eio_pic-)
|   |-- drivers-irqchip-irq-loongson-eiointc.c:error:passing-argument-of-pch_msi_acpi_init-from-incompatible-pointer-type
|   |-- drivers-irqchip-irq-loongson-eiointc.c:error:passing-argument-of-pch_pic_acpi_init-from-incompatible-pointer-type
|   |-- drivers-irqchip-irq-loongson-liointc.c:error:conflicting-types-for-liointc_acpi_init-have-int(struct-irq_domain-struct-acpi_madt_lio_pic-)
|   |-- drivers-irqchip-irq-loongson-pch-lpc.c:error:conflicting-types-for-pch_lpc_acpi_init-have-int(struct-irq_domain-struct-acpi_madt_lpc_pic-)
|   |-- drivers-irqchip-irq-loongson-pch-pic.c:error:conflicting-types-for-pch_pic_acpi_init-have-int(struct-irq_domain-struct-acpi_madt_bio_pic-)
|   `-- drivers-irqchip-irq-loongson-pch-pic.c:error:passing-argument-of-pch_lpc_acpi_init-from-incompatible-pointer-type
|-- loongarch-buildonly-randconfig-r003-20221029
|   |-- arch-loongarch-include-asm-acpi.h:error:redeclaration-of-enum-acpi_madt_bio_pic_version
|   |-- arch-loongarch-include-asm-acpi.h:error:redeclaration-of-enum-acpi_madt_core_pic_version
|   |-- arch-loongarch-include-asm-acpi.h:error:redeclaration-of-enum-acpi_madt_eio_pic_version

elapsed time: 832m

configs tested: 62
configs skipped: 2

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
i386                          randconfig-a001
powerpc                           allnoconfig
i386                          randconfig-a003
arc                                 defconfig
i386                          randconfig-a005
csky                              allnoconfig
arc                               allnoconfig
alpha                               defconfig
alpha                             allnoconfig
riscv                             allnoconfig
s390                                defconfig
s390                             allmodconfig
x86_64                              defconfig
i386                                defconfig
s390                             allyesconfig
x86_64                               rhel-8.3
x86_64                        randconfig-a013
arc                  randconfig-r043-20221028
x86_64                           allyesconfig
x86_64                        randconfig-a002
sh                               allmodconfig
x86_64                        randconfig-a011
x86_64                           rhel-8.3-syz
x86_64                          rhel-8.3-func
ia64                             allmodconfig
arm                                 defconfig
i386                          randconfig-a014
mips                             allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                         rhel-8.3-kunit
riscv                randconfig-r042-20221028
x86_64                        randconfig-a015
x86_64                           rhel-8.3-kvm
powerpc                          allmodconfig
x86_64                        randconfig-a006
s390                 randconfig-r044-20221028
arc                              allyesconfig
i386                          randconfig-a012
x86_64                        randconfig-a004
alpha                            allyesconfig
i386                             allyesconfig
i386                          randconfig-a016
arm64                            allyesconfig
arm                              allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig

clang tested configs:
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
hexagon              randconfig-r041-20221028
i386                          randconfig-a013
hexagon              randconfig-r045-20221028
i386                          randconfig-a015
x86_64                        randconfig-a012
x86_64                        randconfig-a001
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a011
x86_64                        randconfig-a003
x86_64                        randconfig-a005

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
