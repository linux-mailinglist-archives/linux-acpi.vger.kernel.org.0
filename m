Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 875BC619241
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Nov 2022 08:56:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbiKDH4G (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 4 Nov 2022 03:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiKDH4G (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 4 Nov 2022 03:56:06 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A8B0DFAD;
        Fri,  4 Nov 2022 00:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667548562; x=1699084562;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=8YVAUnj+ZQ8o3nJoilJCafFnXKrXY54F6O7QfZw0yDM=;
  b=Q8DcVTuyD5SbeB2YJlFno+w1A3Fdc5kC0PNkCm3nhoID0oMbYCi/w03v
   fi/Pz7EeidmjzhZ7tCj7l35KNAjwds5Ss2B7XmcwpaO0h624zTf8KAhKc
   kbl2rh0W6fuH+URwtFxm38V4os/Er6NlsOmNIt1DwoFKTCy4oC/3bd6I1
   XTEqR7z5Y2XeYULNdfpIkjyj021GjFTxnrZqroeyKNBelvKOly54OaTuy
   JaIZDdyYKZTEQAO9DOTqNwF1gKiFRp0kOC7GpAWUJvxeYNLwbmQNvFw7x
   rAI0EHyFIrg4SutFQ7gUxh1OKlW0mJ8a14dyhLXDugrfdnpMQVeTH1lyy
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="308620237"
X-IronPort-AV: E=Sophos;i="5.96,136,1665471600"; 
   d="scan'208";a="308620237"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2022 00:56:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="724265184"
X-IronPort-AV: E=Sophos;i="5.96,136,1665471600"; 
   d="scan'208";a="724265184"
Received: from lkp-server02.sh.intel.com (HELO b6d29c1a0365) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 04 Nov 2022 00:56:00 -0700
Received: from kbuild by b6d29c1a0365 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oqrYW-000Gk7-17;
        Fri, 04 Nov 2022 07:56:00 +0000
Date:   Fri, 04 Nov 2022 15:55:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 3f69d2d820f43e844f775fa86f7d6e40b8596dd4
Message-ID: <6364c57c.wraN9ddDLVGxvm+1%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 3f69d2d820f43e844f775fa86f7d6e40b8596dd4  Merge branch 'acpi-scan' into bleeding-edge

elapsed time: 720m

configs tested: 60
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
arc                                 defconfig
um                           x86_64_defconfig
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
alpha                               defconfig
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
i386                                defconfig
ia64                             allmodconfig
arc                  randconfig-r043-20221102
riscv                randconfig-r042-20221102
x86_64                              defconfig
alpha                             allnoconfig
s390                                defconfig
s390                             allmodconfig
x86_64                           rhel-8.3-syz
arc                               allnoconfig
i386                          randconfig-a014
s390                 randconfig-r044-20221102
x86_64                               rhel-8.3
x86_64                        randconfig-a002
i386                          randconfig-a012
x86_64                         rhel-8.3-kunit
m68k                             allmodconfig
arm                                 defconfig
x86_64                           rhel-8.3-kvm
x86_64                           allyesconfig
x86_64                        randconfig-a013
s390                             allyesconfig
i386                          randconfig-a016
x86_64                        randconfig-a011
arc                              allyesconfig
powerpc                          allmodconfig
x86_64                        randconfig-a004
alpha                            allyesconfig
mips                             allyesconfig
arm64                            allyesconfig
m68k                             allyesconfig
x86_64                        randconfig-a015
arm                              allyesconfig
i386                             allyesconfig
powerpc                           allnoconfig
x86_64                        randconfig-a006
sh                               allmodconfig

clang tested configs:
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
hexagon              randconfig-r041-20221102
hexagon              randconfig-r045-20221102
i386                          randconfig-a013
i386                          randconfig-a011
x86_64                        randconfig-a014
x86_64                        randconfig-a001
x86_64                        randconfig-a003
i386                          randconfig-a015
x86_64                        randconfig-a016
x86_64                        randconfig-a012
x86_64                        randconfig-a005

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
