Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FD7B744418
	for <lists+linux-acpi@lfdr.de>; Fri, 30 Jun 2023 23:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231743AbjF3VuK (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 30 Jun 2023 17:50:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232434AbjF3VuE (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 30 Jun 2023 17:50:04 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 430874487;
        Fri, 30 Jun 2023 14:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688161798; x=1719697798;
  h=date:from:to:cc:subject:message-id;
  bh=rMeyFEGrHjR57hjXU6kaw8u73sgbFZPOjTAa8fI8+H4=;
  b=jrIAwVH7CAwEvsYJZWmSbBb61GxiWWNUmRJKdXogsYFHWcm4edqvVyIf
   KlsmFyGiXQKrYplOaleYYU9l3j0Ae3e6uNZEKNGz0VwN+DL5kBsO07P2O
   n4ggET/eFzCePoiFLp6HVScJLVZl3wgLfJY108pt8lJGVJvyjOuOun2kn
   UnGleVakwqQtNS8XFQ54htw7GfXhqJ8+2UFsERe89svzaYo4yBfGANE/z
   6Eu59iXGAREv9HQ5wUzTpg+8AA5c5qo85pMcfAbCg/IMBEZEHJttUboQ8
   tztCkVxmea2UCI7j3EZ/N6bAgpNYlxEv3pVL3pz7WknPGlsKYufvIyzUV
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10757"; a="342834649"
X-IronPort-AV: E=Sophos;i="6.01,172,1684825200"; 
   d="scan'208";a="342834649"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2023 14:49:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10757"; a="891899075"
X-IronPort-AV: E=Sophos;i="6.01,172,1684825200"; 
   d="scan'208";a="891899075"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 30 Jun 2023 14:49:45 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qFLzs-000FPl-2Q;
        Fri, 30 Jun 2023 21:49:44 +0000
Date:   Sat, 01 Jul 2023 05:49:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-acpi@vger.kernel.org, devel@acpica.org,
        linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 0d729b90fbbeba7c7c7a7c4b0477f736f34d5327
Message-ID: <202307010539.p4mfcqK8-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 0d729b90fbbeba7c7c7a7c4b0477f736f34d5327  Merge branch 'pm-cpufreq' into bleeding-edge

elapsed time: 722m

configs tested: 107
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r002-20230629   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r004-20230629   gcc  
arc                  randconfig-r016-20230630   gcc  
arc                  randconfig-r043-20230630   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r046-20230630   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r013-20230630   gcc  
hexagon              randconfig-r006-20230629   clang
hexagon              randconfig-r014-20230630   clang
hexagon              randconfig-r041-20230630   clang
hexagon              randconfig-r045-20230630   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230629   gcc  
i386         buildonly-randconfig-r005-20230629   gcc  
i386         buildonly-randconfig-r006-20230629   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230629   gcc  
i386                 randconfig-i002-20230629   gcc  
i386                 randconfig-i003-20230629   gcc  
i386                 randconfig-i004-20230629   gcc  
i386                 randconfig-i005-20230629   gcc  
i386                 randconfig-i006-20230629   gcc  
i386                 randconfig-i011-20230629   clang
i386                 randconfig-i012-20230629   clang
i386                 randconfig-i013-20230629   clang
i386                 randconfig-i014-20230629   clang
i386                 randconfig-i015-20230629   clang
i386                 randconfig-i016-20230629   clang
i386                 randconfig-r034-20230630   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r011-20230630   gcc  
loongarch            randconfig-r015-20230630   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r003-20230629   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r026-20230630   gcc  
mips                 randconfig-r031-20230630   clang
mips                 randconfig-r035-20230630   clang
nios2                               defconfig   gcc  
openrisc             randconfig-r033-20230630   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r012-20230630   gcc  
parisc               randconfig-r032-20230630   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc              randconfig-r022-20230630   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r042-20230630   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r005-20230629   gcc  
s390                 randconfig-r044-20230630   clang
sh                               allmodconfig   gcc  
sh                   randconfig-r036-20230630   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc64              randconfig-r021-20230630   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230629   gcc  
x86_64       buildonly-randconfig-r002-20230629   gcc  
x86_64       buildonly-randconfig-r003-20230629   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-r001-20230629   gcc  
x86_64               randconfig-r023-20230630   clang
x86_64               randconfig-x001-20230629   clang
x86_64               randconfig-x002-20230629   clang
x86_64               randconfig-x003-20230629   clang
x86_64               randconfig-x004-20230629   clang
x86_64               randconfig-x005-20230629   clang
x86_64               randconfig-x006-20230629   clang
x86_64               randconfig-x011-20230629   gcc  
x86_64               randconfig-x012-20230629   gcc  
x86_64               randconfig-x013-20230629   gcc  
x86_64               randconfig-x014-20230629   gcc  
x86_64               randconfig-x015-20230629   gcc  
x86_64               randconfig-x016-20230629   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
