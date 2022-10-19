Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65D506037AA
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Oct 2022 03:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbiJSBvQ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 18 Oct 2022 21:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiJSBvP (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 18 Oct 2022 21:51:15 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D75448F970;
        Tue, 18 Oct 2022 18:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666144274; x=1697680274;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=G4GLDL4SXF8Q7uQ4nuIndTPWq5ouLmk2XRjxP+wb2dk=;
  b=efYKxwv6KbtIR/yydIBIlht5nsPfM9rL5/RoOM+6ywTJkDQCw4rSaEA4
   LnJerT+AJWSSsD1kH0+ahh71zRvB2tw2lHwQPk15IG8Zn+1FZdCTOXexs
   LrgaWUbNWNnghKqcVqvC05J31kkoispV233D8ptjnttKAAzJjKx2cbs2C
   6qsRfBxDPwl9FYoZ5WBVqz+P2yEubX32HyZpgenT/Gk+fKGAzfDru+2NK
   bzkJawC7JpfwwzXEzfhMIaKoPgu2rQAFxT8cP/K0nCi9+xPnSMN9z32p+
   /RjpXfHCaDVvTyIk6IBgfGca5cavQ86VDovVGuMUwsXJJBa3u8R+Y7Mk6
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="305017714"
X-IronPort-AV: E=Sophos;i="5.95,194,1661842800"; 
   d="scan'208";a="305017714"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2022 18:51:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="629009901"
X-IronPort-AV: E=Sophos;i="5.95,194,1661842800"; 
   d="scan'208";a="629009901"
Received: from lkp-server01.sh.intel.com (HELO 8381f64adc98) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 18 Oct 2022 18:51:12 -0700
Received: from kbuild by 8381f64adc98 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1okyEi-0002Fd-0W;
        Wed, 19 Oct 2022 01:51:12 +0000
Date:   Wed, 19 Oct 2022 09:51:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 ba1b46e36fd7cae85e58325de9814fd9a594b4fe
Message-ID: <634f5808.tjazel2jfYuEqNTa%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: ba1b46e36fd7cae85e58325de9814fd9a594b4fe  Merge branch 'pm-cpufreq' into linux-next

elapsed time: 722m

configs tested: 145
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                           x86_64_defconfig
um                             i386_defconfig
arc                               allnoconfig
arc                                 defconfig
alpha                             allnoconfig
riscv                             allnoconfig
csky                              allnoconfig
alpha                               defconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
i386                             allyesconfig
i386                                defconfig
s390                                defconfig
s390                             allmodconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
s390                             allyesconfig
powerpc                         wii_defconfig
arm                            lart_defconfig
sh                   sh7770_generic_defconfig
arc                    vdk_hs38_smp_defconfig
arc                     nsimosci_hs_defconfig
m68k                             allmodconfig
arc                              allyesconfig
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
alpha                            allyesconfig
m68k                             allyesconfig
i386                          randconfig-a001
arc                  randconfig-r043-20221018
i386                          randconfig-a003
riscv                randconfig-r042-20221018
s390                 randconfig-r044-20221018
powerpc                           allnoconfig
mips                             allyesconfig
i386                          randconfig-a005
powerpc                          allmodconfig
sh                               allmodconfig
sh                           se7751_defconfig
m68k                       m5275evb_defconfig
powerpc                     pq2fads_defconfig
sh                   sh7724_generic_defconfig
ia64                          tiger_defconfig
microblaze                      mmu_defconfig
powerpc                      ppc6xx_defconfig
xtensa                  audio_kc705_defconfig
arc                           tb10x_defconfig
openrisc                 simple_smp_defconfig
i386                          randconfig-c001
sparc                             allnoconfig
powerpc                     tqm8541_defconfig
mips                  maltasmvp_eva_defconfig
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
powerpc                     stx_gp3_defconfig
powerpc                   currituck_defconfig
powerpc                 mpc834x_mds_defconfig
arm                        trizeps4_defconfig
powerpc                 linkstation_defconfig
m68k                        mvme16x_defconfig
ia64                                defconfig
arm                        mvebu_v7_defconfig
nios2                               defconfig
m68k                          amiga_defconfig
openrisc                         alldefconfig
arm                      jornada720_defconfig
ia64                             allmodconfig
arm                        cerfcube_defconfig
sh                  sh7785lcr_32bit_defconfig
arc                  randconfig-r043-20221017
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
arm                        spear6xx_defconfig
arm                         assabet_defconfig
mips                 decstation_r4k_defconfig
powerpc                      ep88xc_defconfig
arm                         lpc18xx_defconfig
arm                            mps2_defconfig
sh                          r7780mp_defconfig
arm                         axm55xx_defconfig
ia64                        generic_defconfig
arm                           tegra_defconfig
powerpc                      chrp32_defconfig
mips                         db1xxx_defconfig
powerpc                  storcenter_defconfig
powerpc                 canyonlands_defconfig
sh                          urquell_defconfig
m68k                                defconfig
sh                 kfr2r09-romimage_defconfig
s390                       zfcpdump_defconfig
openrisc                            defconfig
powerpc                     tqm8548_defconfig
openrisc                  or1klitex_defconfig
loongarch                           defconfig
loongarch                         allnoconfig
loongarch                        allmodconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20221018

clang tested configs:
x86_64                        randconfig-a005
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-c007
mips                 randconfig-c004-20221018
i386                          randconfig-c001
s390                 randconfig-c005-20221018
arm                  randconfig-c002-20221018
riscv                randconfig-c006-20221018
powerpc              randconfig-c003-20221018
x86_64                        randconfig-a014
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a016
hexagon              randconfig-r041-20221018
hexagon              randconfig-r045-20221018
i386                 randconfig-a013-20221017
i386                 randconfig-a015-20221017
i386                 randconfig-a016-20221017
i386                 randconfig-a011-20221017
i386                 randconfig-a014-20221017
i386                 randconfig-a012-20221017
x86_64                        randconfig-k001
arm                      tct_hammer_defconfig
riscv                             allnoconfig
arm                      pxa255-idp_defconfig
powerpc                 mpc832x_mds_defconfig
powerpc                      ppc44x_defconfig
mips                        maltaup_defconfig
arm                                 defconfig
mips                           rs90_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
