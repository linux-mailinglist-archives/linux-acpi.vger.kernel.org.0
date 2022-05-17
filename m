Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5265F529B5A
	for <lists+linux-acpi@lfdr.de>; Tue, 17 May 2022 09:48:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239285AbiEQHsQ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 17 May 2022 03:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240333AbiEQHsP (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 17 May 2022 03:48:15 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8469A4476B;
        Tue, 17 May 2022 00:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652773694; x=1684309694;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=qVIpKTaKVVZpRK2k3PZiIKe0MQF+IrOdNEK5O+jBR8I=;
  b=AyD4jbLwFt+HFhcsWntNmNMPXzeFW94Ehi6I8ANxm+xM172NXoLo/QOO
   rEU/0JbVn9SKo2+o/wfYRHtuEy5tA6JRH+f3iTi6wzDYIBYpiq700s2ja
   DncAqzHaDupTawnv7S0NbfD4Et9DVmK8eG++GqE9dFPDk+ws4tsrBE+nV
   Mj+GFz9uTfzTs7WQ9aPuOgo8pyQWCADNFSmnUQu7H40xi3mkmniiS2iAG
   qKTSORZaOlEiiuxfeibQzDrDE7NzIhNBkcoNMkDneekqlDuPB1sexAy03
   3TWXCZJACmZfd8KEE/LCMYjU2Ou1/QnO8ONC1E6XTHt5g/vLkBd6JIqln
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10349"; a="269924085"
X-IronPort-AV: E=Sophos;i="5.91,232,1647327600"; 
   d="scan'208";a="269924085"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2022 00:48:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,232,1647327600"; 
   d="scan'208";a="660496147"
Received: from lkp-server02.sh.intel.com (HELO 242b25809ac7) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 17 May 2022 00:48:12 -0700
Received: from kbuild by 242b25809ac7 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nqrwB-0000jd-PE;
        Tue, 17 May 2022 07:48:11 +0000
Date:   Tue, 17 May 2022 15:47:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 6b601767c503e2488f8e4ce6ce06ad67573797dd
Message-ID: <6283530e.S0T7WGEIa66R66vL%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 6b601767c503e2488f8e4ce6ce06ad67573797dd  Merge branch 'thermal-int340x-fixes' into linux-next

elapsed time: 848m

configs tested: 93
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                              allmodconfig
arm                              allyesconfig
arm64                            allyesconfig
arm                                 defconfig
arm64                               defconfig
i386                 randconfig-c001-20220516
sh                           se7780_defconfig
sh                           se7705_defconfig
powerpc                     sequoia_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
alpha                               defconfig
csky                                defconfig
alpha                            allyesconfig
nios2                            allyesconfig
sh                               allmodconfig
arc                                 defconfig
h8300                            allyesconfig
xtensa                           allyesconfig
parisc                              defconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
s390                             allyesconfig
parisc64                            defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
i386                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
nios2                               defconfig
arc                              allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
powerpc                          allyesconfig
x86_64               randconfig-a012-20220516
x86_64               randconfig-a011-20220516
x86_64               randconfig-a013-20220516
x86_64               randconfig-a014-20220516
x86_64               randconfig-a016-20220516
x86_64               randconfig-a015-20220516
i386                 randconfig-a014-20220516
i386                 randconfig-a011-20220516
i386                 randconfig-a013-20220516
i386                 randconfig-a015-20220516
i386                 randconfig-a012-20220516
i386                 randconfig-a016-20220516
arc                  randconfig-r043-20220516
riscv                randconfig-r042-20220516
s390                 randconfig-r044-20220516
riscv                             allnoconfig
riscv                            allyesconfig
riscv                            allmodconfig
riscv                    nommu_k210_defconfig
riscv                          rv32_defconfig
riscv                    nommu_virt_defconfig
riscv                               defconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                                  kexec
x86_64                          rhel-8.3-func
x86_64                               rhel-8.3
x86_64                         rhel-8.3-kunit
x86_64                    rhel-8.3-kselftests
x86_64                           rhel-8.3-syz

clang tested configs:
mips                  cavium_octeon_defconfig
powerpc                 mpc836x_mds_defconfig
powerpc                   microwatt_defconfig
powerpc                     akebono_defconfig
powerpc                    mvme5100_defconfig
i386                 randconfig-a005-20220516
i386                 randconfig-a003-20220516
i386                 randconfig-a001-20220516
i386                 randconfig-a004-20220516
i386                 randconfig-a006-20220516
i386                 randconfig-a002-20220516
hexagon              randconfig-r045-20220516
hexagon              randconfig-r041-20220516
x86_64               randconfig-a002-20220516
x86_64               randconfig-a001-20220516
x86_64               randconfig-a003-20220516
x86_64               randconfig-a005-20220516
x86_64               randconfig-a004-20220516
x86_64               randconfig-a006-20220516

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
