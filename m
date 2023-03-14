Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6D346B8957
	for <lists+linux-acpi@lfdr.de>; Tue, 14 Mar 2023 05:13:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbjCNENi (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 14 Mar 2023 00:13:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjCNENh (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 14 Mar 2023 00:13:37 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA118D519;
        Mon, 13 Mar 2023 21:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678767196; x=1710303196;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=WIwUtHV9vGBN11kkS5CVfHXS580CQFo/4QS174df/04=;
  b=Lx2cah5JE1N4NOYZ0Zp6hm0Uh1OhDWOxdauiJtOr58fj809CaA8Cs8R2
   scr3WxA7s42h8ShZ8BX+PYvcv+uf3EkpNqYW86Q4QVVwo3UwgzIufvWDQ
   dqL7OAoGXgu/LNVFzn2QW1KRrsDvTQU/67vpnjH6NitXbEJnd4So8ai4q
   rGHy277E5OnB8+dCCQrrqkjPmfSkucLNkH3nMPejEJ6BTE+kUhTh1jxZH
   1tm1HcdmvPeNzqA5hl5qBvkVwN3kVtbbNaqVlovgMN4OLcVO776aqCzNx
   ZQRs5wzL+uptNvOQPAfooq1V4Zqq9KHWlnwpFOIQDWTiUgVubb+3BG5G0
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="338872563"
X-IronPort-AV: E=Sophos;i="5.98,258,1673942400"; 
   d="scan'208";a="338872563"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2023 21:13:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="1008249329"
X-IronPort-AV: E=Sophos;i="5.98,258,1673942400"; 
   d="scan'208";a="1008249329"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 13 Mar 2023 21:13:14 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pbw2D-0006WC-14;
        Tue, 14 Mar 2023 04:13:13 +0000
Date:   Tue, 14 Mar 2023 12:12:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 d64b2bdbf6274ec9d924b31de316b819d6916ab0
Message-ID: <640ff431.lPjqB2V9ixBp3ezA%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: d64b2bdbf6274ec9d924b31de316b819d6916ab0  Merge branches 'acpi-docs', 'acpi-video' and 'acpi-x86' into linux-next

elapsed time: 734m

configs tested: 131
configs skipped: 9

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r011-20230313   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r003-20230312   gcc  
arc                  randconfig-r016-20230312   gcc  
arc                  randconfig-r022-20230313   gcc  
arc                  randconfig-r024-20230312   gcc  
arc                  randconfig-r043-20230312   gcc  
arc                  randconfig-r043-20230313   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm          buildonly-randconfig-r003-20230312   clang
arm                                 defconfig   gcc  
arm                  randconfig-r046-20230312   clang
arm                  randconfig-r046-20230313   gcc  
arm64                            allyesconfig   gcc  
arm64        buildonly-randconfig-r001-20230312   clang
arm64                               defconfig   gcc  
arm64                randconfig-r012-20230312   gcc  
arm64                randconfig-r014-20230312   gcc  
arm64                randconfig-r015-20230313   clang
arm64                randconfig-r023-20230312   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r015-20230312   gcc  
csky                 randconfig-r022-20230312   gcc  
csky                 randconfig-r031-20230313   gcc  
hexagon      buildonly-randconfig-r001-20230313   clang
hexagon              randconfig-r006-20230312   clang
hexagon              randconfig-r024-20230313   clang
hexagon              randconfig-r041-20230312   clang
hexagon              randconfig-r041-20230313   clang
hexagon              randconfig-r045-20230312   clang
hexagon              randconfig-r045-20230313   clang
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r006-20230313   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-a001-20230313   gcc  
i386                 randconfig-a002-20230313   gcc  
i386                 randconfig-a003-20230313   gcc  
i386                 randconfig-a004-20230313   gcc  
i386                 randconfig-a005-20230313   gcc  
i386                 randconfig-a006-20230313   gcc  
i386                 randconfig-a011-20230313   clang
i386                 randconfig-a012-20230313   clang
i386                 randconfig-a013-20230313   clang
i386                 randconfig-a014-20230313   clang
i386                 randconfig-a015-20230313   clang
i386                 randconfig-a016-20230313   clang
i386                 randconfig-r032-20230313   gcc  
ia64                             allmodconfig   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r011-20230312   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r002-20230312   gcc  
loongarch            randconfig-r002-20230313   gcc  
m68k                             allmodconfig   gcc  
m68k         buildonly-randconfig-r004-20230313   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r001-20230313   gcc  
microblaze   buildonly-randconfig-r002-20230313   gcc  
microblaze           randconfig-r025-20230312   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips         buildonly-randconfig-r002-20230312   gcc  
mips                 randconfig-r004-20230312   gcc  
mips                 randconfig-r005-20230313   clang
mips                 randconfig-r014-20230313   gcc  
mips                 randconfig-r021-20230312   clang
nios2                               defconfig   gcc  
nios2                randconfig-r013-20230312   gcc  
nios2                randconfig-r023-20230313   gcc  
nios2                randconfig-r036-20230313   gcc  
openrisc             randconfig-r013-20230313   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r005-20230312   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc              randconfig-r004-20230313   gcc  
powerpc              randconfig-r026-20230312   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r042-20230312   gcc  
riscv                randconfig-r042-20230313   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r044-20230312   gcc  
s390                 randconfig-r044-20230313   clang
sh                               allmodconfig   gcc  
sh                   randconfig-r021-20230313   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r033-20230313   gcc  
sparc                randconfig-r035-20230313   gcc  
sparc64              randconfig-r012-20230313   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230313   gcc  
x86_64               randconfig-a002-20230313   gcc  
x86_64               randconfig-a003-20230313   gcc  
x86_64               randconfig-a004-20230313   gcc  
x86_64               randconfig-a005-20230313   gcc  
x86_64               randconfig-a006-20230313   gcc  
x86_64               randconfig-a011-20230313   clang
x86_64               randconfig-a012-20230313   clang
x86_64               randconfig-a013-20230313   clang
x86_64               randconfig-a014-20230313   clang
x86_64               randconfig-a015-20230313   clang
x86_64               randconfig-a016-20230313   clang
x86_64               randconfig-r006-20230313   gcc  
x86_64               randconfig-r025-20230313   clang
x86_64                               rhel-8.3   gcc  
xtensa       buildonly-randconfig-r005-20230312   gcc  
xtensa       buildonly-randconfig-r006-20230312   gcc  
xtensa               randconfig-r001-20230312   gcc  
xtensa               randconfig-r016-20230313   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
