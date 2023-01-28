Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04CE867FABC
	for <lists+linux-acpi@lfdr.de>; Sat, 28 Jan 2023 21:11:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233622AbjA1ULy (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 28 Jan 2023 15:11:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjA1ULx (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Jan 2023 15:11:53 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B631FBBB6;
        Sat, 28 Jan 2023 12:11:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674936712; x=1706472712;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=C0vYzBhnHLrVidsn2DZnaESQN6GVH604MRNYiAfdw6g=;
  b=LNPVFglTZLRhTZbBbF3J5u7x2qfbsqquzcFAwokzlp0RcMdaThBZw/6I
   onYAXaKheZ6yQ4jxrXdRoS1goELXABbRHfRxTZy8N0sTHSFGx5R4ZaVq1
   XFG4vttdz02L013CEdsJpFwswJZnJX6R1/mKqcrmnwP4SOhxxR3dMUW4X
   IjyJY/qljBzo5xtUPlNEsPiiRsdPWrNO3BdArk1LXN0AtTbDYvZ609oVM
   JsgpHeViAbGz4sjEkWSU60mIz9uBu7d+MlKr3nIMqcib2z9FlUO10yg4i
   jOCJRXSebTc5LxQsWg90J7/z1ZhLociy6VR8FtEUj4ex38c3jEhXjy8zx
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10604"; a="413550613"
X-IronPort-AV: E=Sophos;i="5.97,254,1669104000"; 
   d="scan'208";a="413550613"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2023 12:11:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10604"; a="806203156"
X-IronPort-AV: E=Sophos;i="5.97,254,1669104000"; 
   d="scan'208";a="806203156"
Received: from lkp-server01.sh.intel.com (HELO ffa7f14d1d0f) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 28 Jan 2023 12:11:50 -0800
Received: from kbuild by ffa7f14d1d0f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pLrYE-000148-0R;
        Sat, 28 Jan 2023 20:11:50 +0000
Date:   Sun, 29 Jan 2023 04:11:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 628c61874ffd18b2ac7596523a60d3a4b3a0e567
Message-ID: <63d5815d.e6tYrSeKVbsRdO+a%lkp@intel.com>
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
branch HEAD: 628c61874ffd18b2ac7596523a60d3a4b3a0e567  Merge branch 'thermal-intel' into linux-next

elapsed time: 1085m

configs tested: 65
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                            allnoconfig
um                             i386_defconfig
um                           x86_64_defconfig
alpha                             allnoconfig
i386                              allnoconfig
arm                               allnoconfig
arc                               allnoconfig
arc                                 defconfig
alpha                               defconfig
i386                                defconfig
powerpc                           allnoconfig
x86_64                              defconfig
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
x86_64                               rhel-8.3
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
s390                                defconfig
s390                             allmodconfig
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                           allyesconfig
sh                               allmodconfig
s390                             allyesconfig
mips                             allyesconfig
powerpc                          allmodconfig
i386                             allyesconfig
arm                                 defconfig
arm                              allyesconfig
arm64                            allyesconfig
ia64                             allmodconfig
x86_64                           rhel-8.3-bpf
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
arm                        realview_defconfig
arm                           tegra_defconfig
arm                        shmobile_defconfig
powerpc                     pq2fads_defconfig
xtensa                       common_defconfig
powerpc              randconfig-c003-20230123
i386                 randconfig-c001-20230123

clang tested configs:
riscv                randconfig-r042-20230129
hexagon              randconfig-r041-20230129
hexagon              randconfig-r045-20230129
s390                 randconfig-r044-20230129
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64               randconfig-a013-20230123
x86_64               randconfig-a011-20230123
x86_64               randconfig-a016-20230123
x86_64               randconfig-a012-20230123
x86_64               randconfig-a015-20230123
x86_64               randconfig-a014-20230123
x86_64                          rhel-8.3-rust

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
