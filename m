Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B2594D192D
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Mar 2022 14:30:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233184AbiCHNb0 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 8 Mar 2022 08:31:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233134AbiCHNbZ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 8 Mar 2022 08:31:25 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65B9A43AD2;
        Tue,  8 Mar 2022 05:30:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646746229; x=1678282229;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=G0hKG25g9et/AdWP/FKZ/bsA5yCXu3qpFDQrW0hJLhc=;
  b=lWruxgiuMdw53B6eFOOcLv/+1qqSpPLZep1xmRMGtF79dKclOj4yll93
   c4jt6CtHaNsK/tnKvDxh8oCj7LQ5SVfg1Zfsf65cxaS0do0Hi8qfv6wlN
   7CDJfsxTPBnI1FtxgzctmDyFtXbv5Z0r0ttf1dchug6MSm6olhtSp2Qba
   KxkQrQdfJGcDRd47ZNvmk1hjSF7WYMTwPi3wT3J4XwukhVIUKnqhu18NM
   K6QIG4xbQ7jEUfsoPyJKz6lR+3arZe/e2yZ17Q12WETm+pE9156XQTtIN
   FbyZNxKxCky2gkmjQ7asvidpDkCnhswfrYzneJv9Ipuaeq+9uKKL2wqz3
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10279"; a="341112480"
X-IronPort-AV: E=Sophos;i="5.90,164,1643702400"; 
   d="scan'208";a="341112480"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 05:30:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,164,1643702400"; 
   d="scan'208";a="687918823"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 08 Mar 2022 05:30:24 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nRZuy-0001SQ-0K; Tue, 08 Mar 2022 13:30:24 +0000
Date:   Tue, 08 Mar 2022 21:29:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 e8f79f1bdea6a6a50337fe86e79e651a699352ca
Message-ID: <62275a57.3dDihesTVN0ZrdNn%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: e8f79f1bdea6a6a50337fe86e79e651a699352ca  Merge branch 'acpica' into bleeding-edge

elapsed time: 990m

configs tested: 107
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm                              allmodconfig
arm                              allyesconfig
arm64                               defconfig
arm64                            allyesconfig
i386                 randconfig-c001-20220307
arm                      footbridge_defconfig
alpha                            alldefconfig
m68k                           sun3_defconfig
sh                           se7722_defconfig
sh                          urquell_defconfig
arm                         nhk8815_defconfig
powerpc                      ep88xc_defconfig
arm                         assabet_defconfig
arm                          simpad_defconfig
m68k                       m5475evb_defconfig
powerpc                     taishan_defconfig
arm                           viper_defconfig
powerpc                      arches_defconfig
arm                  randconfig-c002-20220308
arm                  randconfig-c002-20220307
ia64                                defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
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
nds32                             allnoconfig
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig
s390                             allmodconfig
s390                                defconfig
parisc                           allyesconfig
s390                             allyesconfig
i386                             allyesconfig
i386                              debian-10.3
i386                   debian-10.3-kselftests
i386                                defconfig
sparc                               defconfig
sparc                            allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
powerpc                          allyesconfig
i386                 randconfig-a003-20220307
i386                 randconfig-a001-20220307
i386                 randconfig-a004-20220307
i386                 randconfig-a002-20220307
i386                 randconfig-a005-20220307
i386                 randconfig-a006-20220307
x86_64                        randconfig-a015
x86_64               randconfig-a003-20220307
x86_64               randconfig-a001-20220307
x86_64               randconfig-a002-20220307
x86_64               randconfig-a006-20220307
x86_64               randconfig-a004-20220307
x86_64               randconfig-a005-20220307
riscv                randconfig-r042-20220308
arc                  randconfig-r043-20220307
arc                  randconfig-r043-20220308
s390                 randconfig-r044-20220308
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
riscv                    nommu_virt_defconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                                  kexec
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit

clang tested configs:
arm                   milbeaut_m10v_defconfig
mips                      maltaaprp_defconfig
arm                         shannon_defconfig
mips                     loongson1c_defconfig
powerpc                        fsp2_defconfig
x86_64                        randconfig-a016
i386                 randconfig-a013-20220307
i386                 randconfig-a012-20220307
i386                 randconfig-a011-20220307
i386                 randconfig-a016-20220307
i386                 randconfig-a015-20220307
i386                 randconfig-a014-20220307
hexagon              randconfig-r041-20220307
riscv                randconfig-r042-20220307
s390                 randconfig-r044-20220307
hexagon              randconfig-r045-20220308
hexagon              randconfig-r041-20220308
hexagon              randconfig-r045-20220307

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
