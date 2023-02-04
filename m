Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2616A68AA7C
	for <lists+linux-acpi@lfdr.de>; Sat,  4 Feb 2023 15:08:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233657AbjBDOIy (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 4 Feb 2023 09:08:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233602AbjBDOIu (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 4 Feb 2023 09:08:50 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3285836FC6;
        Sat,  4 Feb 2023 06:08:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675519728; x=1707055728;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=/aD9cjyUFI+LzMyeRYqGwo1f2SsDqINK3vbOF2GNhDg=;
  b=UjrwsvEwWq3Mj2YPcHUcmYXwdLut9wjRxcF1B+iJmqScFwaoNuTmYA8m
   IHmfv3+Dkt60efYqlLj2vlqlNesbVZnUoHl7arM85OmNGrJLQf+H6T3vW
   zEGgbgmmctFhU0K4DTGBqhsKi6V2UjLME0e7JYNVoWmKrT+hzd8nk5lsY
   96FeiE/fWIvAMbuVj2UWpc9GbXgjoauYtWZUB4o5Rzdlh9Bu91y4Br5a2
   gEN6VTtaikEO937+Fl58oS3OkWrjCq37CE3ySnW74qZzyxth9lhKw6etq
   AJnYcIB3f6AZ0WcbdKwk7od3v5ueO9IZeBLNE784emAeQY9VNdxYrHQL8
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10610"; a="309280549"
X-IronPort-AV: E=Sophos;i="5.97,272,1669104000"; 
   d="scan'208";a="309280549"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2023 06:08:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10610"; a="616007583"
X-IronPort-AV: E=Sophos;i="5.97,272,1669104000"; 
   d="scan'208";a="616007583"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 04 Feb 2023 06:08:45 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pOJDh-0001LQ-0Q;
        Sat, 04 Feb 2023 14:08:45 +0000
Date:   Sat, 04 Feb 2023 22:08:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 6c08dffbc02b6d339abcebb393bbadbf81c560ed
Message-ID: <63de66e1.w58GEM7uEW+FVDYQ%lkp@intel.com>
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
branch HEAD: 6c08dffbc02b6d339abcebb393bbadbf81c560ed  Merge branch 'pm-cpufreq' into bleeding-edge

elapsed time: 979m

configs tested: 67
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                            allnoconfig
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
s390                                defconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a002
m68k                             allyesconfig
arc                               allnoconfig
arc                              allyesconfig
s390                             allyesconfig
alpha                            allyesconfig
alpha                             allnoconfig
i386                              allnoconfig
arm                               allnoconfig
x86_64                        randconfig-a006
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
ia64                             allmodconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                           rhel-8.3-bpf
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
riscv                randconfig-r042-20230204
arc                  randconfig-r043-20230204
s390                 randconfig-r044-20230204
i386                          randconfig-a001
x86_64                        randconfig-a013
i386                          randconfig-a003
x86_64                        randconfig-a011
x86_64                        randconfig-a015
i386                          randconfig-a005
i386                                defconfig
i386                          randconfig-a014
i386                             allyesconfig
i386                          randconfig-a012
i386                          randconfig-a016
riscv                             allnoconfig
m68k                             allmodconfig
arm                                 defconfig
arm64                            allyesconfig
arm                              allyesconfig

clang tested configs:
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
x86_64                          rhel-8.3-rust
hexagon              randconfig-r041-20230204
arm                  randconfig-r046-20230204
hexagon              randconfig-r045-20230204
x86_64                        randconfig-a014
i386                          randconfig-a002
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a016
i386                          randconfig-a006
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
