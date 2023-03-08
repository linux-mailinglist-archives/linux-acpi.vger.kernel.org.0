Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F4FC6AFCB3
	for <lists+linux-acpi@lfdr.de>; Wed,  8 Mar 2023 03:08:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbjCHCIj (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 7 Mar 2023 21:08:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjCHCIi (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 7 Mar 2023 21:08:38 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B4B29CFC5;
        Tue,  7 Mar 2023 18:08:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678241317; x=1709777317;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=euw1JxOpQ4cEDDGLnYCAJMG/fMN0vHcUnwEdv529RM0=;
  b=SPKccx4ABRvTnr87yQaCnhLFIwJfoB1JA8NM5LDrTG/6LI4iHY9cUJoF
   jEwXzIq5symHy5N6yA72zR88duft5kuCPDzMOBh+rcYZlnpUFyKFezOTI
   w6WQlC9ao0LaO6qiF3OzTyheg1KLEUBbbh2t1JwzJAE79EYZhcREJAcxd
   dkWmLbuzhANYehFxiv+iwPIDWRo9DfL+z4rzFpYf+k5U+fSV8eE88CzS+
   cTVtA1wsBVPyudMp8LOdAdrNLqgWhhauaehn4HHR+X6R84oK1k1+PhVa8
   l3wfThaU+ajhDce2EmwRFbkp3ipcUiixrs+yyXJXfxFqK7cTSVIoqL9xN
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="398610555"
X-IronPort-AV: E=Sophos;i="5.98,242,1673942400"; 
   d="scan'208";a="398610555"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2023 18:08:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="654177179"
X-IronPort-AV: E=Sophos;i="5.98,242,1673942400"; 
   d="scan'208";a="654177179"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 07 Mar 2023 18:08:32 -0800
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pZjEF-0001mn-1n;
        Wed, 08 Mar 2023 02:08:31 +0000
Date:   Wed, 08 Mar 2023 10:07:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 d3caac5bcd2bb98089874783d08ecacab54498bb
Message-ID: <6407edf4.a7i0muZqIvjC4HIt%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: d3caac5bcd2bb98089874783d08ecacab54498bb  Merge branch 'acpi-x86' into bleeding-edge

elapsed time: 726m

configs tested: 133
configs skipped: 13

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r012-20230305   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc          buildonly-randconfig-r004-20230305   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r002-20230305   gcc  
arc                  randconfig-r013-20230305   gcc  
arc                  randconfig-r015-20230306   gcc  
arc                  randconfig-r043-20230305   gcc  
arc                  randconfig-r043-20230306   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r001-20230306   clang
arm                  randconfig-r005-20230306   clang
arm                  randconfig-r011-20230306   gcc  
arm                  randconfig-r046-20230305   clang
arm                  randconfig-r046-20230306   gcc  
arm64                            allyesconfig   gcc  
arm64        buildonly-randconfig-r003-20230306   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r024-20230306   clang
arm64                randconfig-r036-20230305   clang
csky                                defconfig   gcc  
hexagon              randconfig-r032-20230305   clang
hexagon              randconfig-r033-20230306   clang
hexagon              randconfig-r041-20230305   clang
hexagon              randconfig-r041-20230306   clang
hexagon              randconfig-r045-20230305   clang
hexagon              randconfig-r045-20230306   clang
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r001-20230306   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-a001-20230306   gcc  
i386                 randconfig-a002-20230306   gcc  
i386                 randconfig-a003-20230306   gcc  
i386                 randconfig-a004-20230306   gcc  
i386                 randconfig-a005-20230306   gcc  
i386                 randconfig-a006-20230306   gcc  
i386                 randconfig-a011-20230306   clang
i386                 randconfig-a012-20230306   clang
i386                 randconfig-a013-20230306   clang
i386                 randconfig-a014-20230306   clang
i386                 randconfig-a015-20230306   clang
i386                 randconfig-a016-20230306   clang
i386                 randconfig-r032-20230306   gcc  
ia64                             allmodconfig   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r014-20230305   gcc  
ia64                 randconfig-r031-20230305   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r022-20230305   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r023-20230306   gcc  
m68k                 randconfig-r026-20230305   gcc  
microblaze           randconfig-r016-20230306   gcc  
microblaze           randconfig-r022-20230306   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r036-20230306   clang
nios2                               defconfig   gcc  
nios2                randconfig-r002-20230306   gcc  
nios2                randconfig-r014-20230306   gcc  
openrisc     buildonly-randconfig-r002-20230306   gcc  
openrisc             randconfig-r026-20230306   gcc  
openrisc             randconfig-r033-20230305   gcc  
parisc       buildonly-randconfig-r002-20230305   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r023-20230305   gcc  
parisc               randconfig-r024-20230305   gcc  
parisc               randconfig-r025-20230306   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc              randconfig-r004-20230306   gcc  
powerpc              randconfig-r025-20230305   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r011-20230305   gcc  
riscv                randconfig-r016-20230305   gcc  
riscv                randconfig-r042-20230305   gcc  
riscv                randconfig-r042-20230306   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390         buildonly-randconfig-r005-20230306   clang
s390         buildonly-randconfig-r006-20230305   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r021-20230305   gcc  
s390                 randconfig-r044-20230305   gcc  
s390                 randconfig-r044-20230306   clang
sh                               allmodconfig   gcc  
sh                   randconfig-r001-20230305   gcc  
sh                   randconfig-r021-20230306   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r003-20230306   gcc  
sparc                randconfig-r031-20230306   gcc  
sparc64      buildonly-randconfig-r003-20230305   gcc  
sparc64              randconfig-r004-20230305   gcc  
sparc64              randconfig-r006-20230305   gcc  
sparc64              randconfig-r015-20230305   gcc  
sparc64              randconfig-r034-20230305   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r006-20230306   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230306   gcc  
x86_64               randconfig-a002-20230306   gcc  
x86_64               randconfig-a003-20230306   gcc  
x86_64               randconfig-a004-20230306   gcc  
x86_64               randconfig-a005-20230306   gcc  
x86_64               randconfig-a006-20230306   gcc  
x86_64               randconfig-a011-20230306   clang
x86_64               randconfig-a012-20230306   clang
x86_64               randconfig-a013-20230306   clang
x86_64               randconfig-a014-20230306   clang
x86_64               randconfig-a015-20230306   clang
x86_64               randconfig-a016-20230306   clang
x86_64               randconfig-r035-20230306   gcc  
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
