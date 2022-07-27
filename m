Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C7E1582156
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Jul 2022 09:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbiG0HmD (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 27 Jul 2022 03:42:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiG0HmC (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 27 Jul 2022 03:42:02 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7781220193;
        Wed, 27 Jul 2022 00:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658907721; x=1690443721;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=d4iM8TIPJXWTotJ3yhXeNZkv/L1xvQZLzpOWaWEW7hM=;
  b=flpb5eHau/ePCFg5/C2OWT36flvPooUzeb7oGFGBGw+wpUvXqwK6ok4u
   BEfJnZmziJNq/yUqw7+S4l3FpooYzXQcp/XNLj+6RZ2seDYr3jR4mXW36
   Php80lb5I3gFlFV8lOdT0Ic53tZJ0MpaLjBfVeF/vHF+r5PtxKx9Vo/aY
   mv8ZyNdXG4+koRRQocncqRQTKhmrBrQKE6tS46U9rVIOnYeAPnIn0qrB5
   CcARw8rlZukLoBa8HRy0/iWN4fpPAYE3gu9ht4/euzYkcG043NZOlYCN/
   ejkHHRAKyt2ABp7n35K4gN5IdymkOZ5lXgOIgeDpI+RIXQUjx+wGaW5O/
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10420"; a="349874127"
X-IronPort-AV: E=Sophos;i="5.93,195,1654585200"; 
   d="scan'208";a="349874127"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2022 00:42:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,195,1654585200"; 
   d="scan'208";a="689777665"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 27 Jul 2022 00:41:59 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oGbg6-0008U4-0z;
        Wed, 27 Jul 2022 07:41:58 +0000
Date:   Wed, 27 Jul 2022 15:41:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 f11001f2dd7ec311162f0faaa6c2839f313cda41
Message-ID: <62e0ec2a.kV9Im9JHkpRPiLTo%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: f11001f2dd7ec311162f0faaa6c2839f313cda41  Merge branch 'powercap' into bleeding-edge

elapsed time: 724m

configs tested: 57
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm                              allyesconfig
ia64                             allmodconfig
arc                               allnoconfig
alpha                             allnoconfig
riscv                             allnoconfig
csky                              allnoconfig
powerpc                          allmodconfig
mips                             allyesconfig
powerpc                           allnoconfig
sh                               allmodconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
m68k                             allyesconfig
i386                                defconfig
i386                             allyesconfig
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
arc                  randconfig-r043-20220724
riscv                randconfig-r042-20220724
s390                 randconfig-r044-20220724
x86_64                        randconfig-a002
x86_64                        randconfig-a004
x86_64                        randconfig-a006
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                           rhel-8.3-kvm
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                    rhel-8.3-kselftests
x86_64                           rhel-8.3-syz
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig

clang tested configs:
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                        randconfig-a014
x86_64                        randconfig-a012
x86_64                        randconfig-a016
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
hexagon              randconfig-r041-20220724
hexagon              randconfig-r045-20220724
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
