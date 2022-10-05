Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE4945F500F
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Oct 2022 09:02:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbiJEHCD (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 5 Oct 2022 03:02:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbiJEHCC (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 5 Oct 2022 03:02:02 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EEBD6CF43;
        Wed,  5 Oct 2022 00:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664953321; x=1696489321;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=AJ7ixBozYaycEaVpvF0s2Vu8NVpTQl0khy4R+AEjEcM=;
  b=Kgjcc7sgdjITDaQ89LPGRAKE526fKf5vDebl22gOSj4HwQ4y1Ec6zH/7
   q+GJUTMNHxV3jkwnnuGfBPlXNHrYvpjHdlXCIKuAmRFafgQH+cTpglXQ4
   sgJW+S8usx/Ysq6XGKe4CO7GGoJj/EvmwmZmUmMmQco79DjqN0ozIoNwN
   WeVi/FKm37Wgq+YSM9ADLDvO1mAsMk5AIAVfSKGgR8I9AximJerQ7ovmn
   ghxZ3X5EGNJbd4oP5Uwx7gQ3Pu+AyeNFCDllHuahPR9175SMaaj6unC3F
   rolGxlr0beIabNS1QJoH88n6y7iGZKKLHV3vte8ksam0YpSbf1uYFO7FE
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10490"; a="290342883"
X-IronPort-AV: E=Sophos;i="5.95,159,1661842800"; 
   d="scan'208";a="290342883"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2022 00:02:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10490"; a="601928264"
X-IronPort-AV: E=Sophos;i="5.95,159,1661842800"; 
   d="scan'208";a="601928264"
Received: from lkp-server01.sh.intel.com (HELO d4f44333118a) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 05 Oct 2022 00:01:59 -0700
Received: from kbuild by d4f44333118a with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ofyPm-00010f-2l;
        Wed, 05 Oct 2022 07:01:58 +0000
Date:   Wed, 05 Oct 2022 15:01:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 5bf0ef249e8750233e1a19c5d45724a7fcbed2e7
Message-ID: <633d2bd5.OuzscAmXVyRw+SIQ%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 5bf0ef249e8750233e1a19c5d45724a7fcbed2e7  Merge branch 'pm-core' into bleeding-edge

elapsed time: 725m

configs tested: 29
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              defconfig
x86_64                               rhel-8.3
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
s390                                defconfig
x86_64                           allyesconfig
s390                             allyesconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
m68k                             allyesconfig
powerpc                          allmodconfig
mips                             allyesconfig
powerpc                           allnoconfig
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
i386                                defconfig
x86_64                           rhel-8.3-kvm
sh                               allmodconfig
ia64                             allmodconfig
i386                             allyesconfig
arm                                 defconfig
arm64                            allyesconfig
arm                              allyesconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
