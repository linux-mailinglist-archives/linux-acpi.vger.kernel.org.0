Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B4E4643CBD
	for <lists+linux-acpi@lfdr.de>; Tue,  6 Dec 2022 06:38:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232543AbiLFFiw (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 6 Dec 2022 00:38:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiLFFiu (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 6 Dec 2022 00:38:50 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5A8EF32;
        Mon,  5 Dec 2022 21:38:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670305128; x=1701841128;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=Qb6x4KMmFv+kMSSIJXLwgNFFQDpONt0kydV1UpadZPI=;
  b=ZnytBrp6Qoo0Kmve4HZ35ZdLaq6J0wzQqO4ZMF5gc9yNIbkvPQys7Rli
   OKRlAGU6GprmwaodcRwdwWSzSyul0LBVtcxegL2gbxKjVm9q4MKLJBm/B
   RhVjjFssQawft61HYxX43Y3lS9B+Q1E7XkUd/7wYFNd6Bs1xGX1MwTl+5
   8e5ujaIGi5A4J9h6fFvcQLH5MrH3gKVJXRjrK0F5hQaQSnJ2T6FdeSggb
   7TvVnbGN0QLmRRG3LA4SbtsCiMVem5UlGOW+tijwzK8YoDY+jWTsWQGlg
   vYQwj0CHFZfvyY+sNrpMljqD0m09ddaXB92X2yu/ifZMW4DXxsDr4/o31
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10552"; a="314185292"
X-IronPort-AV: E=Sophos;i="5.96,220,1665471600"; 
   d="scan'208";a="314185292"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2022 21:38:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10552"; a="770606582"
X-IronPort-AV: E=Sophos;i="5.96,220,1665471600"; 
   d="scan'208";a="770606582"
Received: from lkp-server01.sh.intel.com (HELO b3c45e08cbc1) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 05 Dec 2022 21:38:45 -0800
Received: from kbuild by b3c45e08cbc1 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1p2QfF-0000d9-0t;
        Tue, 06 Dec 2022 05:38:45 +0000
Date:   Tue, 06 Dec 2022 13:37:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 fcb7e07f5d234133c36b3f511bbcdd518fbd5436
Message-ID: <638ed531.nt5TLSg2hKQs944Z%lkp@intel.com>
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
branch HEAD: fcb7e07f5d234133c36b3f511bbcdd518fbd5436  Merge branches 'pm-sleep' and 'pm-core' into bleeding-edge

elapsed time: 720m

configs tested: 63
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
i386                                defconfig
um                           x86_64_defconfig
um                             i386_defconfig
arc                                 defconfig
alpha                               defconfig
s390                             allmodconfig
s390                                defconfig
x86_64                              defconfig
powerpc                           allnoconfig
x86_64                    rhel-8.3-kselftests
ia64                             allmodconfig
x86_64                          rhel-8.3-func
x86_64                               rhel-8.3
arc                               allnoconfig
alpha                             allnoconfig
i386                              allnoconfig
arm                               allnoconfig
s390                             allyesconfig
i386                             allyesconfig
mips                             allyesconfig
arc                  randconfig-r043-20221205
powerpc                          allmodconfig
x86_64                           allyesconfig
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
riscv                randconfig-r042-20221205
sh                               allmodconfig
m68k                             allmodconfig
x86_64               randconfig-a011-20221205
x86_64               randconfig-a012-20221205
alpha                            allyesconfig
x86_64               randconfig-a013-20221205
x86_64               randconfig-a015-20221205
x86_64               randconfig-a016-20221205
s390                 randconfig-r044-20221205
arc                              allyesconfig
x86_64               randconfig-a014-20221205
arm                                 defconfig
m68k                             allyesconfig
i386                 randconfig-a014-20221205
i386                 randconfig-a012-20221205
i386                 randconfig-a015-20221205
i386                 randconfig-a011-20221205
i386                 randconfig-a013-20221205
i386                 randconfig-a016-20221205
arm                              allyesconfig
arm64                            allyesconfig

clang tested configs:
hexagon              randconfig-r045-20221205
x86_64               randconfig-a003-20221205
arm                  randconfig-r046-20221205
x86_64               randconfig-a004-20221205
x86_64               randconfig-a006-20221205
x86_64               randconfig-a005-20221205
hexagon              randconfig-r041-20221205
x86_64               randconfig-a001-20221205
x86_64               randconfig-a002-20221205
i386                 randconfig-a001-20221205
i386                 randconfig-a002-20221205
i386                 randconfig-a005-20221205
i386                 randconfig-a004-20221205
i386                 randconfig-a003-20221205
i386                 randconfig-a006-20221205

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
