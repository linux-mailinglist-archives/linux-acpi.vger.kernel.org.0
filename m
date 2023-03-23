Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4825C6C630E
	for <lists+linux-acpi@lfdr.de>; Thu, 23 Mar 2023 10:15:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbjCWJPY (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 23 Mar 2023 05:15:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjCWJPX (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 23 Mar 2023 05:15:23 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FAF0C1;
        Thu, 23 Mar 2023 02:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679562922; x=1711098922;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=b6rqFNC52piarpxOmD7Eups7KIrMwGmsquHzaNOdNaE=;
  b=lRDYVBwkH5jBt7WCO3oGaVOrSPAgQNOcUQ5fNDMQwaQdPmjfUX0EPb47
   y8N4ogVEEKMpNMDNZ7Lp1v3yxcvF0q40w36QJtVzjMQ9hwDv/5A3SjnnI
   cOIpKh6sJly/4K5E5xJz6hzJqvVbuibQNJAH9nfHFjPc2nnVW3LyLFKTK
   k959033rgSx9wYqoj6HPfX94teITjS/Blgpu5t1i0VNE5aJPmhxYwscG3
   DS0Dn4tte7fS2Vf7t87/pu8Qia7/MSNUnmi5OKyraEI0hiyvpGqL6KiyR
   pNootql2+6NxbUp8M9UGqYLp90mufuiG/HS84MMG3+b8wfPIb3Tm1tc3W
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="340976421"
X-IronPort-AV: E=Sophos;i="5.98,283,1673942400"; 
   d="scan'208";a="340976421"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2023 02:15:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="632323063"
X-IronPort-AV: E=Sophos;i="5.98,283,1673942400"; 
   d="scan'208";a="632323063"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 23 Mar 2023 02:15:20 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pfH2V-000ECo-12;
        Thu, 23 Mar 2023 09:15:19 +0000
Date:   Thu, 23 Mar 2023 17:14:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 68611940d0f307cff16552aa920496418935205c
Message-ID: <641c187e.A5OM6RNreWZFvW7P%lkp@intel.com>
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
branch HEAD: 68611940d0f307cff16552aa920496418935205c  Merge branch 'pm-cpufreq' into bleeding-edge

elapsed time: 823m

configs tested: 100
configs skipped: 10

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r002-20230322   gcc  
arc                  randconfig-r023-20230322   gcc  
arc                  randconfig-r024-20230322   gcc  
arc                  randconfig-r043-20230322   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r046-20230322   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r003-20230322   clang
arm64                randconfig-r004-20230322   clang
csky                                defconfig   gcc  
csky                 randconfig-r013-20230322   gcc  
csky                 randconfig-r035-20230322   gcc  
hexagon              randconfig-r011-20230322   clang
hexagon              randconfig-r015-20230322   clang
hexagon              randconfig-r041-20230322   clang
hexagon              randconfig-r045-20230322   clang
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
ia64                                defconfig   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch    buildonly-randconfig-r001-20230322   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r033-20230322   gcc  
m68k                             allmodconfig   gcc  
m68k         buildonly-randconfig-r003-20230322   gcc  
m68k                                defconfig   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips         buildonly-randconfig-r005-20230322   gcc  
mips                 randconfig-r006-20230322   gcc  
mips                 randconfig-r036-20230322   gcc  
nios2        buildonly-randconfig-r002-20230322   gcc  
nios2                               defconfig   gcc  
openrisc             randconfig-r026-20230322   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r012-20230322   gcc  
parisc               randconfig-r016-20230322   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r042-20230322   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r044-20230322   gcc  
sh                               allmodconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r001-20230322   gcc  
sparc64              randconfig-r031-20230322   gcc  
sparc64              randconfig-r034-20230322   gcc  
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
xtensa               randconfig-r032-20230322   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
