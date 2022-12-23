Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D3E3654C3A
	for <lists+linux-acpi@lfdr.de>; Fri, 23 Dec 2022 06:35:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbiLWFfH (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 23 Dec 2022 00:35:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiLWFfG (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 23 Dec 2022 00:35:06 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C89DB1E70C;
        Thu, 22 Dec 2022 21:35:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671773705; x=1703309705;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=F5f7tiaRqBjYfsL/wr5kV1pQmv9pBvpPgoaitR5jzfM=;
  b=HcdXl0ACk5ahzukzu1YzotKdmtevNZF3HOEppPKRHPjmOx527A5N2uU8
   bfl8QMFF+0YlRmbW4dDmPDV1IwG6KtJFvJsUHhxt8nulCW/BIzU/zLI0X
   Usl4zGiBEOiTv8mgkLOFETEqlrX7L2b4XBmBk7Ur9CAb4o7wHnLIUlwb0
   vCRgvqyIIUBz99pfhXTmMM/mzFkp69441faSkVv/xk4jvfYJH7DVG2Pok
   JdreLwltX1FyYeGybCjdSkmKnuVbH4pr5vVSkfQI7rNlsuZtqFSKQgO6b
   Fl/Y61ZhWjVCm3s+pUYh7iy0AkJItCZdtG8GhEsDIQUURoJwFP+3PjzVW
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10569"; a="320333855"
X-IronPort-AV: E=Sophos;i="5.96,267,1665471600"; 
   d="scan'208";a="320333855"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2022 21:35:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10569"; a="629734150"
X-IronPort-AV: E=Sophos;i="5.96,267,1665471600"; 
   d="scan'208";a="629734150"
Received: from lkp-server01.sh.intel.com (HELO b5d47979f3ad) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 22 Dec 2022 21:35:02 -0800
Received: from kbuild by b5d47979f3ad with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1p8ahx-000CRr-2a;
        Fri, 23 Dec 2022 05:35:01 +0000
Date:   Fri, 23 Dec 2022 13:34:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 482d9e126ceac54cfe602e731a11675e968af4e5
Message-ID: <63a53dff.+m4U90wjkcyPNdWS%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 482d9e126ceac54cfe602e731a11675e968af4e5  Merge branch 'acpi-pm' into bleeding-edge

elapsed time: 729m

configs tested: 67
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
i386                              allnoconfig
arc                               allnoconfig
alpha                             allnoconfig
arm                               allnoconfig
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
s390                                defconfig
s390                             allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
powerpc                           allnoconfig
x86_64                          rhel-8.3-func
alpha                            allyesconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
sh                               allmodconfig
m68k                             allmodconfig
arc                              allyesconfig
powerpc                          allmodconfig
mips                             allyesconfig
m68k                             allyesconfig
arc                  randconfig-r043-20221222
x86_64               randconfig-a003-20221219
x86_64               randconfig-a001-20221219
x86_64               randconfig-a004-20221219
s390                 randconfig-r044-20221222
ia64                             allmodconfig
x86_64               randconfig-a002-20221219
riscv                randconfig-r042-20221222
x86_64               randconfig-a005-20221219
x86_64               randconfig-a006-20221219
i386                 randconfig-a004-20221219
i386                 randconfig-a001-20221219
i386                 randconfig-a003-20221219
i386                 randconfig-a002-20221219
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-syz
i386                 randconfig-a005-20221219
i386                 randconfig-a006-20221219
x86_64                           rhel-8.3-bpf
x86_64                           rhel-8.3-kvm
arm                                 defconfig
arm                              allyesconfig
arm64                            allyesconfig
i386                                defconfig
x86_64                            allnoconfig
i386                             allyesconfig
riscv                             allnoconfig

clang tested configs:
x86_64                          rhel-8.3-rust
arm                  randconfig-r046-20221222
hexagon              randconfig-r041-20221222
hexagon              randconfig-r045-20221222
i386                 randconfig-a014-20221219
i386                 randconfig-a012-20221219
i386                 randconfig-a013-20221219
i386                 randconfig-a015-20221219
i386                 randconfig-a011-20221219
i386                 randconfig-a016-20221219
x86_64               randconfig-a011-20221219
x86_64               randconfig-a012-20221219
x86_64               randconfig-a014-20221219
x86_64               randconfig-a015-20221219
x86_64               randconfig-a016-20221219
x86_64               randconfig-a013-20221219

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
