Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE0116790CF
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Jan 2023 07:27:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231544AbjAXG1r (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 24 Jan 2023 01:27:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232675AbjAXG1q (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 24 Jan 2023 01:27:46 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B57A4C07;
        Mon, 23 Jan 2023 22:27:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674541665; x=1706077665;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=HA10miwnYpwZU0Y8NmoNkv0z+JH08TJTXcIoZzUSVYs=;
  b=GHD9Is7K4XVL7CIxA6fu0Uelq9jhAXpD85ruzyFrxyOgYhdhumo31s0+
   SyfJEoG9PdqhE5uze8LMPdThGRTbgvVhWE3qgiEAogjNUa6C04KyxHszs
   5dn/nU5obEqkLy69rj3kn38vdrSG0obZZ/Vc5oDOxkYQK1NCurl/IR3+K
   Cnu7/vOTi++XZRf1Y9nrdww4V3mhEyMsm0xQfnrfQN3ZTn0iKUG3dGRkd
   SpGrn+HCwb8S4qLS3vi4DUgW7NjBltJilK520N2lmcQlR8YI7WY21brdQ
   TdwNKWqd7T6rBGBJtkUEZWqfhr9uTiMsagZ4Nd3nT/QKFgGBqUYVWUmug
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="309813885"
X-IronPort-AV: E=Sophos;i="5.97,241,1669104000"; 
   d="scan'208";a="309813885"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2023 22:27:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="785960807"
X-IronPort-AV: E=Sophos;i="5.97,241,1669104000"; 
   d="scan'208";a="785960807"
Received: from lkp-server01.sh.intel.com (HELO 5646d64e7320) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 23 Jan 2023 22:27:43 -0800
Received: from kbuild by 5646d64e7320 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pKCmU-0006Ci-0n;
        Tue, 24 Jan 2023 06:27:42 +0000
Date:   Tue, 24 Jan 2023 14:27:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 a27056168dec62cbbb83eab4d609a60e182d912f
Message-ID: <63cf7a49.zZ40ZNRGtlqfYhln%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: a27056168dec62cbbb83eab4d609a60e182d912f  Merge branch 'thermal/bleeding-edge' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux into bleeding-edge

elapsed time: 724m

configs tested: 66
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
powerpc                           allnoconfig
x86_64                            allnoconfig
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
sh                               allmodconfig
s390                                defconfig
mips                             allyesconfig
powerpc                          allmodconfig
um                             i386_defconfig
s390                             allyesconfig
arc                  randconfig-r043-20230123
um                           x86_64_defconfig
arm                  randconfig-r046-20230123
x86_64                              defconfig
alpha                             allnoconfig
x86_64                          rhel-8.3-func
i386                              allnoconfig
i386                                defconfig
x86_64                    rhel-8.3-kselftests
arm                               allnoconfig
arc                               allnoconfig
x86_64                               rhel-8.3
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64               randconfig-a002-20230123
ia64                             allmodconfig
x86_64               randconfig-a001-20230123
m68k                             allmodconfig
x86_64               randconfig-a004-20230123
arc                              allyesconfig
i386                             allyesconfig
x86_64               randconfig-a003-20230123
x86_64                           rhel-8.3-bpf
alpha                            allyesconfig
x86_64               randconfig-a005-20230123
m68k                             allyesconfig
x86_64               randconfig-a006-20230123
x86_64                           allyesconfig
i386                 randconfig-a003-20230123
i386                 randconfig-a002-20230123
i386                 randconfig-a001-20230123
i386                 randconfig-a005-20230123
i386                 randconfig-a006-20230123
i386                 randconfig-a004-20230123
arm                                 defconfig
arm                              allyesconfig
arm64                            allyesconfig

clang tested configs:
hexagon              randconfig-r041-20230123
hexagon              randconfig-r045-20230123
s390                 randconfig-r044-20230123
riscv                randconfig-r042-20230123
x86_64                          rhel-8.3-rust
x86_64               randconfig-a013-20230123
x86_64               randconfig-a011-20230123
i386                 randconfig-a012-20230123
x86_64               randconfig-a012-20230123
i386                 randconfig-a013-20230123
x86_64               randconfig-a016-20230123
i386                 randconfig-a011-20230123
x86_64               randconfig-a015-20230123
i386                 randconfig-a014-20230123
x86_64               randconfig-a014-20230123
i386                 randconfig-a016-20230123
i386                 randconfig-a015-20230123

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
