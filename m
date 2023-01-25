Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A95A567AF0A
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Jan 2023 10:59:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233965AbjAYJ7B (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 25 Jan 2023 04:59:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbjAYJ7A (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 25 Jan 2023 04:59:00 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78DBD4997B;
        Wed, 25 Jan 2023 01:58:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674640736; x=1706176736;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=+anlwynG1paGsjavBdn2ta5mXew30jOhzLYN5tUMxgw=;
  b=V1iq6QzujFxEZ/zHiQu8exQLdolD+EOmEYcbb1FSh0Ex/pdpjl5RQ1HG
   +uCLgz4PZwKdXZpC6fqk0jU8KNxvihWHLIhNV8ECLZADNMAnq9D7xag5a
   3AXDXBHShtUc7WnwZIl/jssUoczLpQG5pi4qzc2EDDhrnipQJ5QgsAe0M
   oEPZmEJyj3Y0dxcdTCxVbY/YQuaJGkNK6cNYPQOcjCCx9zfEsPUIUudbL
   BWt5J46vUCsRazOB430eNYF70Riv8BH2j4wiKv+DSPfsh++o0MNDjqQsz
   yX4BoRrp0Ig+cCmHiFLdKXbk0kearVQjBupoJAWF6rBgvHMtmJ/yY5gHj
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10600"; a="391025673"
X-IronPort-AV: E=Sophos;i="5.97,245,1669104000"; 
   d="scan'208";a="391025673"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2023 01:58:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10600"; a="907828782"
X-IronPort-AV: E=Sophos;i="5.97,245,1669104000"; 
   d="scan'208";a="907828782"
Received: from lkp-server01.sh.intel.com (HELO 5646d64e7320) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 25 Jan 2023 01:58:53 -0800
Received: from kbuild by 5646d64e7320 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pKcYO-0007Dk-37;
        Wed, 25 Jan 2023 09:58:52 +0000
Date:   Wed, 25 Jan 2023 17:58:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 561b75628983188ea131d1830bc08d633ce5f5bb
Message-ID: <63d0fd54.Azin3S7jE+phXA2m%lkp@intel.com>
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
branch HEAD: 561b75628983188ea131d1830bc08d633ce5f5bb  Merge branch 'thermal/bleeding-edge' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux into bleeding-edge

elapsed time: 720m

configs tested: 66
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                            allnoconfig
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
s390                                defconfig
s390                             allyesconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              defconfig
powerpc                           allnoconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig
alpha                             allnoconfig
i386                              allnoconfig
arm                               allnoconfig
arc                               allnoconfig
i386                                defconfig
arc                  randconfig-r043-20230123
arm                                 defconfig
arm                  randconfig-r046-20230123
arm64                            allyesconfig
sh                               allmodconfig
arm                              allyesconfig
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
ia64                             allmodconfig
i386                 randconfig-a004-20230123
x86_64                           rhel-8.3-kvm
i386                 randconfig-a003-20230123
x86_64                    rhel-8.3-kselftests
i386                 randconfig-a002-20230123
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-bpf
i386                 randconfig-a001-20230123
i386                 randconfig-a006-20230123
i386                 randconfig-a005-20230123
x86_64               randconfig-a002-20230123
x86_64               randconfig-a001-20230123
x86_64               randconfig-a004-20230123
x86_64               randconfig-a003-20230123
i386                             allyesconfig
x86_64               randconfig-a006-20230123
x86_64               randconfig-a005-20230123
mips                             allyesconfig
powerpc                          allmodconfig
m68k                             allyesconfig
alpha                            allyesconfig
m68k                             allmodconfig
arc                              allyesconfig

clang tested configs:
hexagon              randconfig-r041-20230123
hexagon              randconfig-r045-20230123
s390                 randconfig-r044-20230123
x86_64               randconfig-a013-20230123
riscv                randconfig-r042-20230123
x86_64               randconfig-a011-20230123
x86_64               randconfig-a012-20230123
x86_64               randconfig-a016-20230123
x86_64               randconfig-a015-20230123
x86_64               randconfig-a014-20230123
x86_64                          rhel-8.3-rust
i386                 randconfig-a012-20230123
i386                 randconfig-a013-20230123
i386                 randconfig-a011-20230123
i386                 randconfig-a014-20230123
i386                 randconfig-a016-20230123
i386                 randconfig-a015-20230123

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
