Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54C78749347
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Jul 2023 03:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232772AbjGFBtP (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 5 Jul 2023 21:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232414AbjGFBtO (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 5 Jul 2023 21:49:14 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C596BE57;
        Wed,  5 Jul 2023 18:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688608153; x=1720144153;
  h=date:from:to:cc:subject:message-id;
  bh=KT+VrNFE/65metzet1vk6UwWZvC6hTgkwPe8DonGFZY=;
  b=MP/5haTgg0ChFh+HN21fBnyK6+l/7K7izug/I8AaHcHEYW3qKqKg7gsB
   T35XJtmyBGuXCBXEpuH8Mu7tKLFQ25SJ1A1E18FjPEW5SFYEmuu47ZWNt
   if1idmwwN76BGR82wYN+9eErHd+VpSo1paIyOWMY6k+UewuzmOue/Kwie
   uWlu796uJg4O46JXbGZr04uhZnJ0ppJ1ZsL7gGC2NBoFvtBbovw7mbWav
   g1YdAsoVCAi8Ta2Y6CQBmqnlOoqzmKrtqwj1UAKYblCIMTXWhxn9okWxp
   12oPWM5O99UAe+oRIZjGIhKUHfJYzgeM9P/Llk7xW08AiyeKjXWJWbEFu
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="366054543"
X-IronPort-AV: E=Sophos;i="6.01,184,1684825200"; 
   d="scan'208";a="366054543"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2023 18:49:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="784740612"
X-IronPort-AV: E=Sophos;i="6.01,184,1684825200"; 
   d="scan'208";a="784740612"
Received: from lkp-server01.sh.intel.com (HELO c544d7fc5005) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 05 Jul 2023 18:49:11 -0700
Received: from kbuild by c544d7fc5005 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qHE7K-0000xR-35;
        Thu, 06 Jul 2023 01:49:10 +0000
Date:   Thu, 06 Jul 2023 09:48:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-acpi@vger.kernel.org, devel@acpica.org,
        linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 bd9bb08847da3b1eba2ea8cebf514d9287e7f4fb
Message-ID: <202307060950.o1vOEQl4-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: bd9bb08847da3b1eba2ea8cebf514d9287e7f4fb  Merge branches 'acpi-scan' and 'acpi-bus' into linux-next

elapsed time: 722m

configs tested: 178
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r003-20230705   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r014-20230705   gcc  
arc                  randconfig-r026-20230705   gcc  
arc                  randconfig-r043-20230705   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                         at91_dt_defconfig   gcc  
arm                          collie_defconfig   clang
arm                                 defconfig   clang
arm                                 defconfig   gcc  
arm                       imx_v4_v5_defconfig   clang
arm                   milbeaut_m10v_defconfig   clang
arm                            mmp2_defconfig   clang
arm                         mv78xx0_defconfig   clang
arm                          pxa168_defconfig   clang
arm                  randconfig-r005-20230705   clang
arm                  randconfig-r035-20230705   clang
arm                  randconfig-r046-20230705   gcc  
arm                         s5pv210_defconfig   clang
arm                           sama7_defconfig   clang
arm                         socfpga_defconfig   clang
arm                    vt8500_v6_v7_defconfig   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r023-20230705   clang
arm64                randconfig-r024-20230705   clang
csky                                defconfig   gcc  
csky                 randconfig-r002-20230705   gcc  
csky                 randconfig-r016-20230705   gcc  
csky                 randconfig-r036-20230705   gcc  
hexagon              randconfig-r013-20230705   clang
hexagon              randconfig-r041-20230705   clang
hexagon              randconfig-r045-20230705   clang
i386                             allyesconfig   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230705   gcc  
i386         buildonly-randconfig-r005-20230705   gcc  
i386         buildonly-randconfig-r006-20230705   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230705   gcc  
i386                 randconfig-i002-20230705   gcc  
i386                 randconfig-i003-20230705   gcc  
i386                 randconfig-i004-20230705   gcc  
i386                 randconfig-i005-20230705   gcc  
i386                 randconfig-i006-20230705   gcc  
i386                 randconfig-i011-20230705   clang
i386                 randconfig-i012-20230705   clang
i386                 randconfig-i013-20230705   clang
i386                 randconfig-i014-20230705   clang
i386                 randconfig-i015-20230705   clang
i386                 randconfig-i016-20230705   clang
i386                 randconfig-r004-20230705   gcc  
i386                 randconfig-r031-20230705   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r006-20230705   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                        m5272c3_defconfig   gcc  
m68k                        m5407c3_defconfig   gcc  
m68k                          multi_defconfig   gcc  
m68k                        mvme147_defconfig   gcc  
m68k                 randconfig-r011-20230705   gcc  
microblaze           randconfig-r001-20230705   gcc  
microblaze           randconfig-r021-20230705   gcc  
microblaze           randconfig-r036-20230705   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                            ar7_defconfig   gcc  
mips                     cu1000-neo_defconfig   clang
mips                           ip32_defconfig   gcc  
mips                          malta_defconfig   clang
mips                      maltasmvp_defconfig   gcc  
mips                        qi_lb60_defconfig   clang
mips                 randconfig-r005-20230705   clang
mips                 randconfig-r024-20230705   gcc  
mips                       rbtx49xx_defconfig   clang
nios2                               defconfig   gcc  
nios2                randconfig-r015-20230705   gcc  
nios2                randconfig-r023-20230705   gcc  
openrisc             randconfig-r022-20230705   gcc  
openrisc             randconfig-r031-20230705   gcc  
openrisc                 simple_smp_defconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r014-20230705   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          g5_defconfig   clang
powerpc                    ge_imp3a_defconfig   clang
powerpc                     kilauea_defconfig   clang
powerpc                   lite5200b_defconfig   clang
powerpc                  mpc885_ads_defconfig   clang
powerpc                      ppc44x_defconfig   clang
powerpc                      ppc64e_defconfig   clang
powerpc              randconfig-r025-20230705   clang
powerpc              randconfig-r034-20230705   gcc  
powerpc                    socrates_defconfig   clang
powerpc                 xes_mpc85xx_defconfig   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                    nommu_virt_defconfig   clang
riscv                randconfig-r012-20230705   clang
riscv                randconfig-r032-20230705   gcc  
riscv                randconfig-r034-20230705   gcc  
riscv                randconfig-r042-20230705   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r021-20230705   clang
s390                 randconfig-r035-20230705   gcc  
s390                 randconfig-r044-20230705   clang
sh                               allmodconfig   gcc  
sh                             espt_defconfig   gcc  
sh                          r7785rp_defconfig   gcc  
sh                   randconfig-r004-20230705   gcc  
sh                   randconfig-r006-20230705   gcc  
sh                           sh2007_defconfig   gcc  
sh                        sh7785lcr_defconfig   gcc  
sh                            shmin_defconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r016-20230705   gcc  
sparc                randconfig-r032-20230705   gcc  
sparc                randconfig-r033-20230705   gcc  
sparc                       sparc32_defconfig   gcc  
sparc64                             defconfig   gcc  
sparc64              randconfig-r013-20230705   gcc  
sparc64              randconfig-r022-20230705   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r001-20230705   clang
um                   randconfig-r003-20230705   clang
um                   randconfig-r015-20230705   gcc  
um                   randconfig-r026-20230705   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230705   gcc  
x86_64       buildonly-randconfig-r002-20230705   gcc  
x86_64       buildonly-randconfig-r003-20230705   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-r011-20230705   clang
x86_64               randconfig-r012-20230705   clang
x86_64               randconfig-x001-20230705   clang
x86_64               randconfig-x002-20230705   clang
x86_64               randconfig-x003-20230705   clang
x86_64               randconfig-x004-20230705   clang
x86_64               randconfig-x005-20230705   clang
x86_64               randconfig-x006-20230705   clang
x86_64               randconfig-x011-20230705   gcc  
x86_64               randconfig-x012-20230705   gcc  
x86_64               randconfig-x013-20230705   gcc  
x86_64               randconfig-x014-20230705   gcc  
x86_64               randconfig-x015-20230705   gcc  
x86_64               randconfig-x016-20230705   gcc  
x86_64                           rhel-8.3-bpf   gcc  
x86_64                          rhel-8.3-func   gcc  
x86_64                    rhel-8.3-kselftests   gcc  
x86_64                         rhel-8.3-kunit   gcc  
x86_64                           rhel-8.3-kvm   gcc  
x86_64                           rhel-8.3-ltp   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                           alldefconfig   gcc  
xtensa                    smp_lx200_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
