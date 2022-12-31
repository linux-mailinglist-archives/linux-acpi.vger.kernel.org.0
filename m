Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9048865A308
	for <lists+linux-acpi@lfdr.de>; Sat, 31 Dec 2022 08:12:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbiLaHMD (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 31 Dec 2022 02:12:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiLaHMC (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 31 Dec 2022 02:12:02 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E49F313E88;
        Fri, 30 Dec 2022 23:12:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672470721; x=1704006721;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=VyRpn98ajmqsDLFNKgzhw6Kyh+FK3ES9kzF/3gDLdCo=;
  b=mQO3FICUHWJoZ+BwSt0e/CKCDZ93fJ4AA8ImvFyxkRfGiSPzUaMtJKQF
   CyekYit9tA7mkbDqYNVVftGB5/Tr8arrhEd0Iv8vglD7Wtj/LMNvBk6/r
   8Z9Yk0xlEsvXW6pBUaCGJYs7KvsYQN3PbMWiFwYjdnaIeQC/e3e1KTf8b
   c/GlT7H+BphlMQkAppyLUh46sEndxPKFem3Nj7AHEy4jLSmpSTE149zzd
   Zuok/C0Uj1NpfI4a2qF37tb0RiNcsh4DjUEApuWI4s/qSdywejQxJ42Pr
   X0BCq4DCeMfZSyDZDrWLYSTElCzDJGlwxwDUsp7azEymUPvbME135Q/rg
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10576"; a="383588360"
X-IronPort-AV: E=Sophos;i="5.96,289,1665471600"; 
   d="scan'208";a="383588360"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Dec 2022 23:12:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10576"; a="717348012"
X-IronPort-AV: E=Sophos;i="5.96,289,1665471600"; 
   d="scan'208";a="717348012"
Received: from lkp-server01.sh.intel.com (HELO b5d47979f3ad) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 30 Dec 2022 23:11:59 -0800
Received: from kbuild by b5d47979f3ad with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pBW2B-000N6W-0S;
        Sat, 31 Dec 2022 07:11:59 +0000
Date:   Sat, 31 Dec 2022 15:11:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 89c98a1b8faa98d47b5fc8697a1e97baeb894a28
Message-ID: <63afe0b0.jmDOykJFwOqA4bZz%lkp@intel.com>
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
branch HEAD: 89c98a1b8faa98d47b5fc8697a1e97baeb894a28  Merge branch 'thermal-intel-next' into bleeding-edge

elapsed time: 726m

configs tested: 79
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                           rhel-8.3-bpf
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
i386                                defconfig
x86_64                              defconfig
um                             i386_defconfig
arc                                 defconfig
i386                 randconfig-a012-20221226
ia64                             allmodconfig
s390                             allmodconfig
um                           x86_64_defconfig
i386                 randconfig-a011-20221226
arm                                 defconfig
i386                 randconfig-a013-20221226
alpha                               defconfig
i386                 randconfig-a014-20221226
s390                                defconfig
i386                 randconfig-a016-20221226
x86_64                          rhel-8.3-func
i386                 randconfig-a015-20221226
x86_64                    rhel-8.3-kselftests
i386                             allyesconfig
arc                               allnoconfig
x86_64                               rhel-8.3
alpha                             allnoconfig
i386                              allnoconfig
arm                               allnoconfig
s390                             allyesconfig
arm                              allyesconfig
powerpc                           allnoconfig
x86_64               randconfig-a014-20221226
sh                               allmodconfig
mips                             allyesconfig
arm64                            allyesconfig
x86_64               randconfig-a013-20221226
x86_64               randconfig-a011-20221226
powerpc                          allmodconfig
alpha                            allyesconfig
m68k                             allyesconfig
x86_64               randconfig-a012-20221226
x86_64                           allyesconfig
x86_64               randconfig-a015-20221226
m68k                             allmodconfig
x86_64               randconfig-a016-20221226
arc                              allyesconfig
arm                  randconfig-r046-20221225
arc                  randconfig-r043-20221225
arc                  randconfig-r043-20221227
arm                  randconfig-r046-20221227
arc                  randconfig-r043-20221226
riscv                randconfig-r042-20221226
s390                 randconfig-r044-20221226
riscv                             allnoconfig
x86_64                            allnoconfig

clang tested configs:
x86_64                          rhel-8.3-rust
x86_64               randconfig-a002-20221226
x86_64               randconfig-a003-20221226
x86_64               randconfig-a001-20221226
i386                 randconfig-a004-20221226
x86_64               randconfig-a004-20221226
x86_64               randconfig-a006-20221226
x86_64               randconfig-a005-20221226
i386                 randconfig-a001-20221226
i386                 randconfig-a003-20221226
i386                 randconfig-a002-20221226
i386                 randconfig-a006-20221226
i386                 randconfig-a005-20221226
hexagon              randconfig-r045-20221225
riscv                randconfig-r042-20221227
hexagon              randconfig-r041-20221225
s390                 randconfig-r044-20221227
hexagon              randconfig-r041-20221227
hexagon              randconfig-r041-20221226
arm                  randconfig-r046-20221226
s390                 randconfig-r044-20221225
hexagon              randconfig-r045-20221226
riscv                randconfig-r042-20221225
hexagon              randconfig-r045-20221227

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
