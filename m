Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEB535A3AD8
	for <lists+linux-acpi@lfdr.de>; Sun, 28 Aug 2022 04:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231172AbiH1CJb (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 27 Aug 2022 22:09:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiH1CJa (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 27 Aug 2022 22:09:30 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E56854DB55;
        Sat, 27 Aug 2022 19:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661652569; x=1693188569;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=sp0ThocBG4EzI3XMXy93MNtL6tu6JPFUfULdMgcnG4E=;
  b=V1OkU+C8tUUzXLeWh/Jr1oSmBVgeWzHcwkI6Qw/5KLSCIZHErErXZtV1
   FAkpjofC2jiq5//+iFLxMwEL0CMh11MdIqc0u7X2Q2sz80pptR7KWGSC1
   zJKz2UnLxS4iLBko2LHuLplulVfuJL4wKeY7HkduPog8Ogb73eI4Wx4ou
   J3MY0aEhmhT2a7ctpEeS4l+oFqptn78wryKJCKQ7xQQOxNgBdpmG9+Ztf
   qiQ7Co3SAQxjgiKKZ/OMhZLgpGTNrPFSUMqZ2QquXLRlElvqHPo8MGU+7
   AuOB23Mbkiomfa2Q4eABTp/po25NgjI3NlhPMWNgTsS9t2tSZre2D9QG2
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10452"; a="277718991"
X-IronPort-AV: E=Sophos;i="5.93,269,1654585200"; 
   d="scan'208";a="277718991"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2022 19:09:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,269,1654585200"; 
   d="scan'208";a="561836618"
Received: from lkp-server01.sh.intel.com (HELO fc16deae1c42) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 27 Aug 2022 19:09:27 -0700
Received: from kbuild by fc16deae1c42 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oS7jr-0000hH-02;
        Sun, 28 Aug 2022 02:09:27 +0000
Date:   Sun, 28 Aug 2022 10:09:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 99ab2f21bfd615a8ba701b2ba16aa5024e94c2d4
Message-ID: <630ace53.oXgM0yYrPlAxuQNl%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 99ab2f21bfd615a8ba701b2ba16aa5024e94c2d4  Merge branches 'acpi-cppc', 'acpi-osi' and 'acpi-bus' into bleeding-edge

elapsed time: 722m

configs tested: 102
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
loongarch                         allnoconfig
arc                               allnoconfig
um                             i386_defconfig
alpha                             allnoconfig
riscv                             allnoconfig
csky                              allnoconfig
um                           x86_64_defconfig
arc                                 defconfig
x86_64                              defconfig
alpha                               defconfig
powerpc                           allnoconfig
i386                                defconfig
loongarch                           defconfig
csky                                defconfig
i386                          debian-10.3-kvm
sparc                               defconfig
arm                                 defconfig
x86_64                               rhel-8.3
i386                          randconfig-a014
riscv                    nommu_virt_defconfig
sh                               allmodconfig
x86_64                        randconfig-a004
arc                          axs101_defconfig
arm                              allyesconfig
parisc                              defconfig
x86_64                           allyesconfig
mips                             allyesconfig
riscv                          rv32_defconfig
x86_64                                  kexec
x86_64                        randconfig-a013
m68k                             allmodconfig
m68k                         amcore_defconfig
i386                        debian-10.3-kunit
x86_64                        randconfig-a011
ia64                             alldefconfig
arm64                            allyesconfig
s390                                defconfig
sh                          landisk_defconfig
m68k                        stmark2_defconfig
alpha                            allyesconfig
powerpc                          allmodconfig
xtensa                       common_defconfig
i386                   debian-10.3-kselftests
microblaze                          defconfig
x86_64                        randconfig-a002
i386                          randconfig-a012
s390                             allmodconfig
i386                          randconfig-a016
x86_64                        randconfig-a015
m68k                        m5307c3_defconfig
i386                              debian-10.3
i386                         debian-10.3-func
arc                              allyesconfig
riscv                    nommu_k210_defconfig
nios2                               defconfig
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                        randconfig-a006
parisc64                            defconfig
x86_64                           rhel-8.3-kvm
nios2                            allyesconfig
m68k                             allyesconfig
sparc                            allyesconfig
s390                             allyesconfig
i386                             allyesconfig
x86_64                    rhel-8.3-kselftests
parisc                           allyesconfig
xtensa                           allyesconfig
powerpc                      makalu_defconfig
x86_64                           rhel-8.3-syz
sh                         microdev_defconfig
arm                              allmodconfig
arm64                               defconfig
i386                          randconfig-c001
sh                               j2_defconfig
m68k                                defconfig
ia64                                defconfig
arc                  randconfig-r043-20220828
ia64                             allmodconfig
s390                 randconfig-r044-20220828
riscv                randconfig-r042-20220828
ia64                             allyesconfig
mips                             allmodconfig

clang tested configs:
i386                          randconfig-a013
mips                        maltaup_defconfig
arm                           sama7_defconfig
powerpc                      walnut_defconfig
i386                          randconfig-a011
x86_64                        randconfig-a016
powerpc                      obs600_defconfig
x86_64                        randconfig-a012
x86_64                        randconfig-a005
x86_64                        randconfig-a014
i386                          randconfig-a015
powerpc                  mpc885_ads_defconfig
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-k001
arm                          ixp4xx_defconfig
mips                  cavium_octeon_defconfig
hexagon              randconfig-r041-20220828
hexagon              randconfig-r045-20220828

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
