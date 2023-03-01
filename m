Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7B976A6B2F
	for <lists+linux-acpi@lfdr.de>; Wed,  1 Mar 2023 11:58:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbjCAK6V (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 1 Mar 2023 05:58:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbjCAK6S (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 1 Mar 2023 05:58:18 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9BE6199DD;
        Wed,  1 Mar 2023 02:58:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677668296; x=1709204296;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=mUQT0lCw3o7DsJGEc0FuMpCukS+bnk0PTEmCUUh2KDc=;
  b=m8MNDGNb3D922yW2iCGbUy/h+q8U1cN0l051sQo2l3dGVcIcPa8uJAJU
   L/o6ByCO4wtCM4BqkzBPdGTclZQa/T2rq2uNKyKnfL4tBnZwX8bKbZmdy
   KN9w83kspMr5KX+rA8toeDLD/GhfazbH/+++EO5AXwGjiyr+jTftJgUsi
   NiYXJ8DMENHtjlt/8XFPH3yxvxlASzmfEOQKmK48FaQF/eJ9GYjLxzNm/
   jVvcSfUrSZ7a4M3mzBgQKzlUrZ0R3DtvVUbnwAjSDqtL8n7ZO2e95CoZV
   WtJ8/EkbNtGf44RZ+/XanSacYtOZPU5QbWO1LTulhSi7uiEaM7Gls+3Qf
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="336672391"
X-IronPort-AV: E=Sophos;i="5.98,224,1673942400"; 
   d="scan'208";a="336672391"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 02:58:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="817517698"
X-IronPort-AV: E=Sophos;i="5.98,224,1673942400"; 
   d="scan'208";a="817517698"
Received: from lkp-server01.sh.intel.com (HELO 3895f5c55ead) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 01 Mar 2023 02:58:14 -0800
Received: from kbuild by 3895f5c55ead with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pXKA2-000669-0y;
        Wed, 01 Mar 2023 10:58:14 +0000
Date:   Wed, 01 Mar 2023 18:57:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 020c69c7d16fa3fafeaf05b78967e71baf96154a
Message-ID: <63ff2f8c.r+g/ChcFCDwBVDZw%lkp@intel.com>
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
branch HEAD: 020c69c7d16fa3fafeaf05b78967e71baf96154a  Merge branch 'powercap' into bleeding-edge

elapsed time: 832m

configs tested: 140
configs skipped: 12

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r004-20230227   gcc  
alpha        buildonly-randconfig-r006-20230227   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r025-20230228   gcc  
alpha                randconfig-r032-20230226   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r004-20230227   gcc  
arc                  randconfig-r034-20230226   gcc  
arc                  randconfig-r043-20230226   gcc  
arc                  randconfig-r043-20230227   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r026-20230226   gcc  
arm                  randconfig-r046-20230226   gcc  
arm                  randconfig-r046-20230227   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r011-20230227   gcc  
csky                 randconfig-r016-20230227   gcc  
csky                 randconfig-r022-20230228   gcc  
csky                 randconfig-r023-20230227   gcc  
csky                 randconfig-r031-20230227   gcc  
csky                 randconfig-r035-20230227   gcc  
hexagon      buildonly-randconfig-r006-20230226   clang
hexagon              randconfig-r041-20230226   clang
hexagon              randconfig-r041-20230227   clang
hexagon              randconfig-r045-20230226   clang
hexagon              randconfig-r045-20230227   clang
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r002-20230227   clang
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-a001-20230227   clang
i386                 randconfig-a002-20230227   clang
i386                 randconfig-a003-20230227   clang
i386                 randconfig-a004-20230227   clang
i386                 randconfig-a005-20230227   clang
i386                 randconfig-a006-20230227   clang
i386                 randconfig-a011-20230227   gcc  
i386                 randconfig-a012-20230227   gcc  
i386                 randconfig-a013-20230227   gcc  
i386                 randconfig-a014-20230227   gcc  
i386                 randconfig-a015-20230227   gcc  
i386                 randconfig-a016-20230227   gcc  
i386                 randconfig-r022-20230227   gcc  
ia64                             allmodconfig   gcc  
ia64                                defconfig   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch    buildonly-randconfig-r002-20230226   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r014-20230226   gcc  
loongarch            randconfig-r034-20230227   gcc  
m68k                             allmodconfig   gcc  
m68k         buildonly-randconfig-r005-20230226   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r012-20230226   gcc  
m68k                 randconfig-r014-20230227   gcc  
m68k                 randconfig-r024-20230227   gcc  
m68k                 randconfig-r036-20230226   gcc  
microblaze           randconfig-r036-20230227   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips         buildonly-randconfig-r001-20230226   clang
mips                 randconfig-r005-20230226   clang
mips                 randconfig-r021-20230226   gcc  
mips                 randconfig-r023-20230228   gcc  
mips                 randconfig-r025-20230227   clang
mips                 randconfig-r035-20230226   clang
nios2                               defconfig   gcc  
nios2                randconfig-r025-20230226   gcc  
openrisc     buildonly-randconfig-r003-20230226   gcc  
openrisc             randconfig-r004-20230226   gcc  
openrisc             randconfig-r011-20230226   gcc  
parisc       buildonly-randconfig-r003-20230227   gcc  
parisc       buildonly-randconfig-r004-20230226   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r001-20230227   gcc  
parisc               randconfig-r015-20230226   gcc  
parisc               randconfig-r024-20230226   gcc  
parisc               randconfig-r026-20230228   gcc  
parisc               randconfig-r031-20230226   gcc  
parisc               randconfig-r033-20230227   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc              randconfig-r021-20230227   gcc  
powerpc              randconfig-r021-20230228   clang
powerpc              randconfig-r032-20230227   clang
powerpc              randconfig-r033-20230226   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r042-20230226   clang
riscv                randconfig-r042-20230227   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r024-20230228   clang
s390                 randconfig-r026-20230227   gcc  
s390                 randconfig-r044-20230226   clang
s390                 randconfig-r044-20230227   gcc  
sh                               allmodconfig   gcc  
sh                   randconfig-r003-20230227   gcc  
sh                   randconfig-r012-20230227   gcc  
sh                   randconfig-r013-20230227   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r023-20230226   gcc  
sparc64              randconfig-r003-20230226   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230227   clang
x86_64               randconfig-a002-20230227   clang
x86_64               randconfig-a003-20230227   clang
x86_64               randconfig-a004-20230227   clang
x86_64               randconfig-a005-20230227   clang
x86_64               randconfig-a006-20230227   clang
x86_64               randconfig-a011-20230227   gcc  
x86_64               randconfig-a012-20230227   gcc  
x86_64               randconfig-a013-20230227   gcc  
x86_64               randconfig-a014-20230227   gcc  
x86_64               randconfig-a015-20230227   gcc  
x86_64               randconfig-a016-20230227   gcc  
x86_64               randconfig-r015-20230227   gcc  
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r002-20230226   gcc  
xtensa               randconfig-r016-20230226   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
