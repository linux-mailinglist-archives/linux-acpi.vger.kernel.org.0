Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BFF546E9B5
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Dec 2021 15:15:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbhLIOTJ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 9 Dec 2021 09:19:09 -0500
Received: from mga11.intel.com ([192.55.52.93]:54470 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230048AbhLIOTJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 9 Dec 2021 09:19:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639059336; x=1670595336;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=TNEoRCxsKXNcqbZCE4vLzgzs/Z/e8wYP8mBV7XNyxig=;
  b=VAOoxsINwsbZfQqc1COScyqDOHNjftPFZIci3kYlIEjxG/vsTO/vGuWq
   Pdb1Av612LkmJfINMjXk6Fgi54xE45MfeR4wztMqo2VYKcIJWNIpEXjZy
   Kq8ddrFZPbixC8iOhIMpXjbLIrxCq4Nlc1QSgI8xKdngYIn534FLLVYHO
   XmyH2ateNXr2WLg8edgeEYkRswxEaRi9NaqJFckqjLSwpK0njP8dNsNoa
   R14gREeq4bxUxuVN0NWQMOTHHrNBle+BG4sR9u3xhOiTyiuCWp6uXWdnc
   fGjYFtua+9T2Wdartulr31y9Orys4owZUQzqt9m11LWwqcazcpySpQYpi
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10192"; a="235614648"
X-IronPort-AV: E=Sophos;i="5.88,192,1635231600"; 
   d="scan'208";a="235614648"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2021 06:15:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,192,1635231600"; 
   d="scan'208";a="543605050"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 09 Dec 2021 06:15:28 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mvKCl-000206-VN; Thu, 09 Dec 2021 14:15:27 +0000
Date:   Thu, 09 Dec 2021 22:14:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 00824f47707e07b3f937d9a37fe7166d2174e4a1
Message-ID: <61b20f4d.tuXteFo3I0VuFk0X%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 00824f47707e07b3f937d9a37fe7166d2174e4a1  Merge branch 'acpi-pm' into bleeding-edge

elapsed time: 1348m

configs tested: 103
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm                              allyesconfig
arm                              allmodconfig
arm64                               defconfig
arm64                            allyesconfig
i386                 randconfig-c001-20211209
sh                        edosk7760_defconfig
sh                        sh7763rdp_defconfig
csky                             alldefconfig
arc                        nsim_700_defconfig
mips                          rm200_defconfig
arm                        keystone_defconfig
mips                      loongson3_defconfig
xtensa                  nommu_kc705_defconfig
powerpc                       ebony_defconfig
powerpc                        fsp2_defconfig
powerpc                      ppc6xx_defconfig
mips                       rbtx49xx_defconfig
arc                              alldefconfig
openrisc                 simple_smp_defconfig
powerpc                 mpc8272_ads_defconfig
powerpc                   lite5200b_defconfig
parisc                generic-32bit_defconfig
arm                  randconfig-c002-20211207
ia64                                defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
m68k                                defconfig
nds32                             allnoconfig
nios2                               defconfig
arc                              allyesconfig
csky                                defconfig
alpha                               defconfig
nds32                               defconfig
alpha                            allyesconfig
nios2                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
h8300                            allyesconfig
xtensa                           allyesconfig
parisc                              defconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
s390                             allyesconfig
i386                                defconfig
i386                              debian-10.3
i386                   debian-10.3-kselftests
sparc                            allyesconfig
i386                             allyesconfig
sparc                               defconfig
mips                             allmodconfig
mips                             allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
powerpc                          allyesconfig
i386                 randconfig-a001-20211207
i386                 randconfig-a005-20211207
i386                 randconfig-a002-20211207
i386                 randconfig-a003-20211207
i386                 randconfig-a006-20211207
i386                 randconfig-a004-20211207
x86_64               randconfig-a011-20211208
arc                  randconfig-r043-20211207
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              defconfig
x86_64                                  kexec
x86_64                               rhel-8.3
x86_64                           allyesconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests

clang tested configs:
x86_64               randconfig-a011-20211209
x86_64               randconfig-a013-20211209
x86_64               randconfig-a015-20211209
x86_64               randconfig-a012-20211209
x86_64               randconfig-a014-20211209
x86_64               randconfig-a016-20211209
i386                 randconfig-a013-20211207
i386                 randconfig-a011-20211207
i386                 randconfig-a014-20211207
i386                 randconfig-a012-20211207
i386                 randconfig-a015-20211207
i386                 randconfig-a016-20211207
hexagon              randconfig-r045-20211207
s390                 randconfig-r044-20211207
hexagon              randconfig-r041-20211207
riscv                randconfig-r042-20211207
x86_64               randconfig-a001-20211208
x86_64               randconfig-a002-20211208
x86_64               randconfig-a004-20211208
x86_64               randconfig-a003-20211208
x86_64               randconfig-a005-20211208
x86_64               randconfig-a006-20211208

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
