Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C99568CFDD
	for <lists+linux-acpi@lfdr.de>; Tue,  7 Feb 2023 07:57:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjBGG5s (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 7 Feb 2023 01:57:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjBGG5r (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 7 Feb 2023 01:57:47 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 521F2222F1;
        Mon,  6 Feb 2023 22:57:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675753066; x=1707289066;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=v9gdSWkXD/byI0aHL2myY7VyOo9xeNCbyQXYWq1oG1U=;
  b=HRrGm8BjVFscrnbhnxMiXaHhMHJwjpijgaVcZpThGtxOKdKuPiDO5RXX
   xAFQobi+Ao0xR5yt6RbbuSUPRiCqGpP8Drxj/0TxxMjdvR3roNwoqWNwP
   GpHycpqYreczyFdoMJEilJz1gKA2lCVbtHUG+3iAoC5Nb9vy47vvEsLIc
   9ZmA4vL15RFbVvjvofBbCzTrAMNRtvG2RAA14MOX7/8LdqDeEYYmuIKpU
   TPlZPH8cRAkoDGaKoEKeJ8rK9d/l9tvt4tx/nGWrrubXJpgmdhBY07x2j
   Pdgk8EdA2z4btMv42HZIcuSLpezDdCVv0dL3tYq2Lr6YtmMq65iTAufSs
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="415645319"
X-IronPort-AV: E=Sophos;i="5.97,278,1669104000"; 
   d="scan'208";a="415645319"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 22:57:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="697152313"
X-IronPort-AV: E=Sophos;i="5.97,278,1669104000"; 
   d="scan'208";a="697152313"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 06 Feb 2023 22:57:44 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pPHvD-0003EJ-1u;
        Tue, 07 Feb 2023 06:57:43 +0000
Date:   Tue, 07 Feb 2023 14:57:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 dcf0f94e28915d8dc7d174be2554edf87c3d655f
Message-ID: <63e1f659.Z66hIz6D4ZuSnKWP%lkp@intel.com>
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
branch HEAD: dcf0f94e28915d8dc7d174be2554edf87c3d655f  Merge branch 'acpi-video' into bleeding-edge

elapsed time: 730m

configs tested: 110
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
x86_64                            allnoconfig
um                           x86_64_defconfig
powerpc                           allnoconfig
alpha                            allyesconfig
m68k                             allmodconfig
mips                         db1xxx_defconfig
m68k                             allyesconfig
arc                              allyesconfig
arc                                 defconfig
sh                          rsk7269_defconfig
alpha                               defconfig
i386                                defconfig
sh                               allmodconfig
alpha                             allnoconfig
i386                              allnoconfig
arc                               allnoconfig
arm                               allnoconfig
x86_64                              defconfig
s390                             allmodconfig
mips                             allyesconfig
ia64                             allmodconfig
x86_64                               rhel-8.3
powerpc                          allmodconfig
i386                 randconfig-a011-20230206
x86_64                           rhel-8.3-syz
i386                 randconfig-a014-20230206
x86_64                         rhel-8.3-kunit
x86_64                           allyesconfig
i386                 randconfig-a012-20230206
i386                 randconfig-a016-20230206
s390                                defconfig
x86_64                           rhel-8.3-kvm
x86_64               randconfig-a013-20230206
x86_64               randconfig-a011-20230206
x86_64                    rhel-8.3-kselftests
x86_64               randconfig-a012-20230206
i386                 randconfig-a013-20230206
x86_64               randconfig-a014-20230206
i386                 randconfig-a015-20230206
x86_64                          rhel-8.3-func
s390                             allyesconfig
sh                         ecovec24_defconfig
x86_64                           rhel-8.3-bpf
x86_64               randconfig-a015-20230206
x86_64               randconfig-a016-20230206
i386                             allyesconfig
arm                                 defconfig
riscv                    nommu_k210_defconfig
mips                           jazz_defconfig
sh                          r7780mp_defconfig
um                               alldefconfig
xtensa                  nommu_kc705_defconfig
arm64                            allyesconfig
parisc                           allyesconfig
arm                           h3600_defconfig
arm                              allyesconfig
arc                     nsimosci_hs_defconfig
sh                                  defconfig
s390                 randconfig-r044-20230206
xtensa                              defconfig
arc                  randconfig-r043-20230205
arm                            hisi_defconfig
arm                  randconfig-r046-20230205
arc                  randconfig-r043-20230206
riscv                randconfig-r042-20230206
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                          randconfig-c001
x86_64                        randconfig-a006
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
riscv                             allnoconfig
riscv                    nommu_virt_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
riscv                          rv32_defconfig

clang tested configs:
mips                       rbtx49xx_defconfig
arm                         lpc32xx_defconfig
riscv                            alldefconfig
arm                           sama7_defconfig
x86_64               randconfig-a001-20230206
x86_64               randconfig-a005-20230206
powerpc                 mpc832x_mds_defconfig
powerpc                      ppc44x_defconfig
x86_64               randconfig-a006-20230206
x86_64               randconfig-a002-20230206
x86_64               randconfig-a004-20230206
x86_64               randconfig-a003-20230206
arm                       aspeed_g4_defconfig
x86_64                          rhel-8.3-rust
hexagon                             defconfig
i386                 randconfig-a005-20230206
i386                 randconfig-a004-20230206
i386                 randconfig-a001-20230206
i386                 randconfig-a002-20230206
i386                 randconfig-a003-20230206
i386                 randconfig-a006-20230206
hexagon              randconfig-r041-20230205
riscv                randconfig-r042-20230205
hexagon              randconfig-r045-20230206
hexagon              randconfig-r041-20230206
arm                  randconfig-r046-20230206
s390                 randconfig-r044-20230205
hexagon              randconfig-r045-20230205
x86_64                        randconfig-k001
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
