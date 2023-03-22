Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C92A46C43F8
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Mar 2023 08:24:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbjCVHYh (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 22 Mar 2023 03:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjCVHYh (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 22 Mar 2023 03:24:37 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3BE6EFBE;
        Wed, 22 Mar 2023 00:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679469875; x=1711005875;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=Dtw6udZHe+e210kHYks0SBi6Hmzea+jcif9jZw5iXGg=;
  b=a05Bg9ja+SCWBdw0F/kOMQXNiZjhDNTVrVBapjrJnX1AY6/NCRJwlhKz
   8YroHAOY5VWGuQw/HBhcFFgGHSmKpLCXxAar8+j3UZ1LMdxIlCk91KDMw
   /usC6rbfiSieONQXjGPmFpFLTvI6iI/4IvfIpO1ekb3h82uCuur2UNpL5
   U/Gm3XHWdgGpZ1+30Dfw/4c19aG53bKWBZ/Cn6OVnfFHWGYtCn6hy1Gak
   xRlNlrhMWSi+uTDUo7284Z1KaqmDALQVNQS/ZMZmPXkSd+rQx6+ateL3l
   J9C6A1rJUM88NCjSnC04wSsDDci/hI6aXx7ZKlfV8mLavv779lVjHDJsk
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="341503151"
X-IronPort-AV: E=Sophos;i="5.98,281,1673942400"; 
   d="scan'208";a="341503151"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2023 00:24:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="681802799"
X-IronPort-AV: E=Sophos;i="5.98,281,1673942400"; 
   d="scan'208";a="681802799"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 22 Mar 2023 00:24:25 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pespd-000D2W-12;
        Wed, 22 Mar 2023 07:24:25 +0000
Date:   Wed, 22 Mar 2023 15:24:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS WITH WARNING
 98fe6903f79cffbb0f271369f62f4e5fea0e978c
Message-ID: <641aad15.tdanh3QhJQGsno+V%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 98fe6903f79cffbb0f271369f62f4e5fea0e978c  Merge branch 'thermal-acpi' into bleeding-edge

Warning reports:

https://lore.kernel.org/oe-kbuild-all/202303220652.Yhopf8F0-lkp@intel.com

Warning: (recently discovered and may have been fixed)

drivers/thermal/thermal_sysfs.c:717:6: warning: variable 'ret' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]

Warning ids grouped by kconfigs:

clang_recent_errors
|-- i386-randconfig-a001-20230320
|   `-- drivers-thermal-thermal_sysfs.c:warning:variable-ret-is-used-uninitialized-whenever-if-condition-is-true
`-- x86_64-randconfig-a005-20230320
    `-- drivers-thermal-thermal_sysfs.c:warning:variable-ret-is-used-uninitialized-whenever-if-condition-is-true

elapsed time: 732m

configs tested: 108
configs skipped: 8

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r035-20230319   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc          buildonly-randconfig-r002-20230313   gcc  
arc          buildonly-randconfig-r004-20230313   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r006-20230319   gcc  
arc                  randconfig-r043-20230319   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r016-20230321   gcc  
arm                  randconfig-r046-20230319   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r001-20230319   gcc  
csky                 randconfig-r033-20230319   gcc  
hexagon              randconfig-r022-20230319   clang
hexagon              randconfig-r032-20230319   clang
hexagon              randconfig-r041-20230319   clang
hexagon              randconfig-r045-20230319   clang
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r003-20230313   gcc  
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
ia64         buildonly-randconfig-r006-20230312   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r014-20230321   gcc  
ia64                 randconfig-r036-20230319   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r005-20230319   gcc  
loongarch            randconfig-r031-20230319   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips         buildonly-randconfig-r004-20230312   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r015-20230321   gcc  
openrisc             randconfig-r012-20230321   gcc  
openrisc             randconfig-r024-20230319   gcc  
parisc       buildonly-randconfig-r005-20230313   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv        buildonly-randconfig-r001-20230312   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r002-20230319   gcc  
riscv                randconfig-r004-20230319   gcc  
riscv                randconfig-r042-20230319   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390         buildonly-randconfig-r006-20230313   clang
s390                                defconfig   gcc  
s390                 randconfig-r011-20230321   clang
s390                 randconfig-r021-20230319   clang
s390                 randconfig-r044-20230319   clang
sh                               allmodconfig   gcc  
sh           buildonly-randconfig-r005-20230312   gcc  
sh                   randconfig-r023-20230319   gcc  
sh                   randconfig-r034-20230319   gcc  
sparc                               defconfig   gcc  
sparc64              randconfig-r025-20230319   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230320   clang
x86_64               randconfig-a002-20230320   clang
x86_64               randconfig-a003-20230320   clang
x86_64               randconfig-a004-20230320   clang
x86_64               randconfig-a005-20230320   clang
x86_64               randconfig-a006-20230320   clang
x86_64                        randconfig-a011   gcc  
x86_64                        randconfig-a012   clang
x86_64                        randconfig-a013   gcc  
x86_64                        randconfig-a014   clang
x86_64                        randconfig-a015   gcc  
x86_64                        randconfig-a016   clang
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r003-20230319   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
