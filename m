Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FFCB5F7534
	for <lists+linux-acpi@lfdr.de>; Fri,  7 Oct 2022 10:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbiJGIVV (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 7 Oct 2022 04:21:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiJGIVU (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 7 Oct 2022 04:21:20 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D9D1ACA32;
        Fri,  7 Oct 2022 01:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665130879; x=1696666879;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=nIFSOQ0AeD8J+eyw5v6soPd9iUsTxrc8o6p2KfkLkDI=;
  b=SFzG4oYx+n5mggLP7fzD7lStd9HbNB+ARtzRqHiaOd3BnjMs3a0JMdX7
   RUcCGjp50c6kEiTlSBJvQpNtIhMV65tSEaVDOSgdbE85QN/2QC21lmz9k
   o8Dm7QRVirLpOpoCUelF8VfdxdFCjRekx+HAPVIlFKn+ZZoPqFCaymNF7
   Kv55O9o6DYP3Ilxrtz7lAuI3PINQdBTKHUwnVwz8igdsQ2LDPOMIksX51
   xqKBrTn9AfOnRGAzxzp4gQuIk2FopV8PqCV3YliyKpkmlz50BtWg+Fkql
   TTDuK3j3pBIA8X7mUGU0pMTLAuhRBVLOt8XNaOtc1wg4/dzA1bLtSOIUk
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10492"; a="305263814"
X-IronPort-AV: E=Sophos;i="5.95,166,1661842800"; 
   d="scan'208";a="305263814"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2022 01:21:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10492"; a="800226070"
X-IronPort-AV: E=Sophos;i="5.95,166,1661842800"; 
   d="scan'208";a="800226070"
Received: from lkp-server01.sh.intel.com (HELO 3c15167049b7) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 07 Oct 2022 01:21:16 -0700
Received: from kbuild by 3c15167049b7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ogibb-0000vn-2V;
        Fri, 07 Oct 2022 08:21:15 +0000
Date:   Fri, 07 Oct 2022 16:20:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 fa158c045ecf464a6b553980e461db469dc0392f
Message-ID: <633fe141.cfECPPSqPYg7Z/F8%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: fa158c045ecf464a6b553980e461db469dc0392f  Merge branch 'acpi-thermal' into linux-next

elapsed time: 725m

configs tested: 123
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
powerpc                           allnoconfig
arc                                 defconfig
um                             i386_defconfig
s390                             allmodconfig
um                           x86_64_defconfig
alpha                               defconfig
s390                                defconfig
x86_64                              defconfig
sh                               allmodconfig
x86_64                               rhel-8.3
x86_64               randconfig-a011-20221003
s390                             allyesconfig
mips                             allyesconfig
x86_64               randconfig-a012-20221003
i386                                defconfig
x86_64                           rhel-8.3-syz
powerpc                          allmodconfig
x86_64               randconfig-a013-20221003
x86_64                         rhel-8.3-kunit
x86_64                           allyesconfig
x86_64                           rhel-8.3-kvm
i386                 randconfig-a011-20221003
x86_64               randconfig-a015-20221003
i386                 randconfig-a012-20221003
arc                  randconfig-r043-20221006
x86_64                          rhel-8.3-func
x86_64               randconfig-a014-20221003
i386                 randconfig-a013-20221003
x86_64               randconfig-a016-20221003
arm                                 defconfig
i386                 randconfig-a015-20221003
x86_64                    rhel-8.3-kselftests
i386                 randconfig-a016-20221003
i386                 randconfig-a014-20221003
i386                             allyesconfig
arm                              allyesconfig
arm64                            allyesconfig
m68k                             allmodconfig
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
alpha                            allyesconfig
arc                              allyesconfig
ia64                             allmodconfig
m68k                             allyesconfig
powerpc                  iss476-smp_defconfig
sparc                            alldefconfig
m68k                        stmark2_defconfig
mips                        bcm47xx_defconfig
sparc64                             defconfig
mips                      loongson3_defconfig
microblaze                          defconfig
arm64                            alldefconfig
openrisc                    or1ksim_defconfig
powerpc                        warp_defconfig
powerpc                      makalu_defconfig
csky                             alldefconfig
arc                      axs103_smp_defconfig
mips                            gpr_defconfig
i386                          randconfig-c001
powerpc                 mpc85xx_cds_defconfig
powerpc                      tqm8xx_defconfig
nios2                            alldefconfig
sh                            migor_defconfig
powerpc                     tqm8555_defconfig
powerpc                       eiger_defconfig
sh                           se7619_defconfig
m68k                          hp300_defconfig
arm                        keystone_defconfig
sh                           se7751_defconfig
sh                         ap325rxa_defconfig
mips                          rb532_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
nios2                         3c120_defconfig
powerpc                  storcenter_defconfig
powerpc                     mpc83xx_defconfig
mips                  maltasmvp_eva_defconfig
mips                         rt305x_defconfig
xtensa                         virt_defconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
powerpc                    adder875_defconfig
powerpc                      pcm030_defconfig
riscv                            allmodconfig
mips                       bmips_be_defconfig
sh                              ul2_defconfig
arc                          axs101_defconfig
xtensa                              defconfig
openrisc                 simple_smp_defconfig
parisc                           allyesconfig
arm                      integrator_defconfig
parisc64                            defconfig

clang tested configs:
hexagon              randconfig-r045-20221006
hexagon              randconfig-r041-20221006
riscv                randconfig-r042-20221006
s390                 randconfig-r044-20221006
i386                 randconfig-a003-20221003
i386                 randconfig-a002-20221003
i386                 randconfig-a001-20221003
i386                 randconfig-a004-20221003
i386                 randconfig-a005-20221003
i386                 randconfig-a006-20221003
hexagon              randconfig-r041-20221003
hexagon              randconfig-r045-20221003
x86_64               randconfig-a003-20221003
x86_64               randconfig-a005-20221003
x86_64               randconfig-a001-20221003
x86_64               randconfig-a004-20221003
x86_64               randconfig-a002-20221003
x86_64               randconfig-a006-20221003
x86_64                        randconfig-k001
arm                       cns3420vb_defconfig
powerpc                   microwatt_defconfig
mips                malta_qemu_32r6_defconfig
powerpc                      obs600_defconfig
arm                          collie_defconfig
powerpc                 xes_mpc85xx_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
