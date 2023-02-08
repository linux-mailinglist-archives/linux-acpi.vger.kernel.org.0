Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2404768EA2B
	for <lists+linux-acpi@lfdr.de>; Wed,  8 Feb 2023 09:49:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbjBHItC (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 8 Feb 2023 03:49:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbjBHItA (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 8 Feb 2023 03:49:00 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E641D457CF;
        Wed,  8 Feb 2023 00:48:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675846139; x=1707382139;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=VWAdscYA026WDG+uTuShMIHtJETF9TVgLCsDEURJfMQ=;
  b=UrgbU66cr8tWuBo6dEnGDkdFePfhCmu2EULhfDp9k3KPtYPr6DOzcRDe
   fHDfbVInU0UYsqPMXqN7lVOyjhVbEQxEIMKSTDjnqkQHteZdwzKbZYhbX
   TRRmCtR28VATdjIrW2Wn94drGPh8GHjIM21TEcNafoaRDEPrrBHckyR3S
   wqnPj0aUzWeaau7SFOa9XM5IpzYch9A9zPKzw5ICQtVpjdA1AK+w3LIDJ
   KlqUJsTwvtDn+atvfOI9KuFMCDNkK5iPA9IXBqv48OWsehkdG1RXvl8K6
   KE+XMIY6klA3xSWwjF8jzW8MW4NeYDeqYgyxlvVBzIpsZLpZEUSeuD174
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="327441663"
X-IronPort-AV: E=Sophos;i="5.97,280,1669104000"; 
   d="scan'208";a="327441663"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 00:48:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="735857144"
X-IronPort-AV: E=Sophos;i="5.97,280,1669104000"; 
   d="scan'208";a="735857144"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 08 Feb 2023 00:48:58 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pPg8P-0004Ky-26;
        Wed, 08 Feb 2023 08:48:57 +0000
Date:   Wed, 08 Feb 2023 16:48:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 c1b84754ab99a2c591d64da339f6e9fbb63ce238
Message-ID: <63e361e3.tqYzCWjL1Q92TgCB%lkp@intel.com>
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
branch HEAD: c1b84754ab99a2c591d64da339f6e9fbb63ce238  Merge branch 'thermal-intel' into bleeding-edge

elapsed time: 725m

configs tested: 72
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                               allnoconfig
alpha                             allnoconfig
i386                              allnoconfig
arm                               allnoconfig
x86_64                            allnoconfig
arc                                 defconfig
powerpc                           allnoconfig
alpha                               defconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                           rhel-8.3-bpf
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                              defconfig
arm                                 defconfig
s390                                defconfig
s390                             allmodconfig
sh                               allmodconfig
x86_64                               rhel-8.3
arm64                            allyesconfig
powerpc                          allmodconfig
mips                             allyesconfig
s390                             allyesconfig
arm                              allyesconfig
x86_64                           allyesconfig
i386                 randconfig-a013-20230206
i386                 randconfig-a011-20230206
i386                 randconfig-a014-20230206
i386                 randconfig-a012-20230206
i386                                defconfig
ia64                             allmodconfig
i386                 randconfig-a015-20230206
i386                 randconfig-a016-20230206
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
x86_64               randconfig-a014-20230206
riscv                randconfig-r042-20230204
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
x86_64               randconfig-a013-20230206
s390                 randconfig-r044-20230206
x86_64               randconfig-a011-20230206
x86_64               randconfig-a015-20230206
arc                  randconfig-r043-20230204
arc                  randconfig-r043-20230206
x86_64               randconfig-a012-20230206
x86_64               randconfig-a016-20230206
s390                 randconfig-r044-20230204
riscv                randconfig-r042-20230206
i386                             allyesconfig

clang tested configs:
x86_64               randconfig-a002-20230206
x86_64               randconfig-a004-20230206
x86_64               randconfig-a003-20230206
x86_64               randconfig-a001-20230206
x86_64               randconfig-a005-20230206
x86_64               randconfig-a006-20230206
x86_64                          rhel-8.3-rust
hexagon              randconfig-r045-20230206
hexagon              randconfig-r041-20230206
hexagon              randconfig-r041-20230204
arm                  randconfig-r046-20230204
arm                  randconfig-r046-20230206
hexagon              randconfig-r045-20230204
i386                 randconfig-a002-20230206
i386                 randconfig-a004-20230206
i386                 randconfig-a001-20230206
i386                 randconfig-a003-20230206
i386                 randconfig-a005-20230206
i386                 randconfig-a006-20230206

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
