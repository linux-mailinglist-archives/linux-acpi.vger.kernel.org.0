Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F4495B4C45
	for <lists+linux-acpi@lfdr.de>; Sun, 11 Sep 2022 08:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbiIKGCm (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 11 Sep 2022 02:02:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbiIKGCl (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 11 Sep 2022 02:02:41 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CF4528E3A;
        Sat, 10 Sep 2022 23:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662876161; x=1694412161;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=X3nGh2deOmHXffMmBLBZLiWJ36kF5JOTAJZQciA1cg8=;
  b=n/EDAmfiUdXOxMoNDromksGNixPvu20Ovag7jHV87K7wsd/dlJtF/rzE
   5U5BMtJYxcCFev+fuGomrf9NEuwUO6DoUqtzjgkQqRB46YBXuvOKBp51b
   lHEYCBBVD9oYWhuGt/AzZOmlJn5WA6MJKk5gQiG9Cpy03L6WAPrg8ULlh
   rA73/leD0g4er3wXoVudWsIQfneQsL3l0ecDm0cwxtzZ5cq2DcJEa8THx
   QkK3HHhHmxNiionHbiPi4uijLgGvuU+JCrAw76qd60+96bH3k+PrdUJbM
   Pdnqb/GyMBOeLzXLS892nMzpH7Pq7HOBLX/ptfnHeF3m47wHbwAhAA/MP
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10466"; a="383992869"
X-IronPort-AV: E=Sophos;i="5.93,307,1654585200"; 
   d="scan'208";a="383992869"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2022 23:02:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,307,1654585200"; 
   d="scan'208";a="758039261"
Received: from lkp-server02.sh.intel.com (HELO 4011df4f4fd3) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 10 Sep 2022 23:02:39 -0700
Received: from kbuild by 4011df4f4fd3 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oXG3C-00012t-2V;
        Sun, 11 Sep 2022 06:02:38 +0000
Date:   Sun, 11 Sep 2022 14:02:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 58968b7be786652f48f712147e6f71831cfe684e
Message-ID: <631d79e8.yiStyYaa6aEvt0eJ%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 58968b7be786652f48f712147e6f71831cfe684e  Merge branch 'pm-cpufreq' into bleeding-edge

elapsed time: 723m

configs tested: 53
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                        randconfig-a002
i386                          randconfig-a001
x86_64                        randconfig-a004
i386                          randconfig-a003
x86_64                        randconfig-a006
i386                          randconfig-a005
x86_64                           allyesconfig
um                             i386_defconfig
um                           x86_64_defconfig
i386                                defconfig
arc                              allyesconfig
arc                  randconfig-r043-20220911
alpha                            allyesconfig
i386                          randconfig-a014
s390                 randconfig-r044-20220911
riscv                randconfig-r042-20220911
i386                          randconfig-a012
i386                          randconfig-a016
i386                             allyesconfig
x86_64                        randconfig-a013
m68k                             allyesconfig
powerpc                           allnoconfig
x86_64                        randconfig-a011
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
powerpc                          allmodconfig
m68k                             allmodconfig
x86_64                           rhel-8.3-kvm
x86_64                        randconfig-a015
x86_64                    rhel-8.3-kselftests
arm                                 defconfig
mips                             allyesconfig
x86_64                           rhel-8.3-syz
sh                               allmodconfig
ia64                             allmodconfig
arm                              allyesconfig
arm64                            allyesconfig

clang tested configs:
x86_64                        randconfig-a001
x86_64                        randconfig-a003
i386                          randconfig-a002
i386                          randconfig-a004
x86_64                        randconfig-a005
i386                          randconfig-a006
hexagon              randconfig-r041-20220911
i386                          randconfig-a013
hexagon              randconfig-r045-20220911
i386                          randconfig-a011
i386                          randconfig-a015
x86_64                        randconfig-a016
x86_64                        randconfig-a012
x86_64                        randconfig-a014

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
