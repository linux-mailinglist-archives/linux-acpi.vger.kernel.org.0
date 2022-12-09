Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A203647D84
	for <lists+linux-acpi@lfdr.de>; Fri,  9 Dec 2022 06:59:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbiLIF7K (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 9 Dec 2022 00:59:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbiLIF7J (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Dec 2022 00:59:09 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 309B77D09F;
        Thu,  8 Dec 2022 21:59:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670565548; x=1702101548;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=QESf2egMCQVXju0mFTHl09LLmsy4o3hxg5+UKynUVjQ=;
  b=HCoLhJquNWKjA0wKl1re1T7WZn81I8yuoBszPuQFBezx0Y90iegXJbrp
   jQ2nVi2XUuKaAFHbUwQr3fUjsnd7rAx6blytiag6p7y1ExjNWR1q5a6e9
   M47hNdMsU9g16OfIZ+KSwTlIJvY8Qe4NO74x9v8Ab7pcq9ZQTOcEPMlii
   w210HmIWo2eO3PrNQoNb6GOn4JQEXg7FExewEyU7FqD6G5XkG7OSStj2l
   UQ3bDnFGioXflaQLsbEVfL67EM8w7PlxBhe/o9US6LsujnAyqFyNKXJW5
   5CKS7G80WdGPmdH3TSlBYJAKG7p7YdI5aPjolPHzK+Na6aiRIwtv4Vv3b
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10555"; a="381694439"
X-IronPort-AV: E=Sophos;i="5.96,230,1665471600"; 
   d="scan'208";a="381694439"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2022 21:59:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10555"; a="597625267"
X-IronPort-AV: E=Sophos;i="5.96,230,1665471600"; 
   d="scan'208";a="597625267"
Received: from lkp-server01.sh.intel.com (HELO b5d47979f3ad) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 08 Dec 2022 21:59:06 -0800
Received: from kbuild by b5d47979f3ad with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1p3WPZ-0001fT-1q;
        Fri, 09 Dec 2022 05:59:05 +0000
Date:   Fri, 09 Dec 2022 13:58:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 5beb106cb8ca8bbec16f6594d777c38b89a03914
Message-ID: <6392ce98.SspClqVjuxkq7NYu%lkp@intel.com>
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
branch HEAD: 5beb106cb8ca8bbec16f6594d777c38b89a03914  Merge branch 'acpi-ec-next' into bleeding-edge

elapsed time: 727m

configs tested: 66
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                               allnoconfig
arc                                 defconfig
alpha                             allnoconfig
i386                              allnoconfig
arm                               allnoconfig
alpha                               defconfig
s390                                defconfig
powerpc                           allnoconfig
s390                             allmodconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              defconfig
sh                               allmodconfig
arm                  randconfig-r046-20221208
arc                  randconfig-r043-20221208
mips                             allyesconfig
powerpc                          allmodconfig
i386                                defconfig
x86_64                          rhel-8.3-rust
x86_64                               rhel-8.3
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
s390                             allyesconfig
ia64                             allmodconfig
x86_64                           allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
i386                             allyesconfig
alpha                            allyesconfig
arm                                 defconfig
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a015
m68k                             allyesconfig
i386                          randconfig-a014
x86_64                        randconfig-a006
i386                          randconfig-a012
i386                          randconfig-a016
i386                          randconfig-a001
i386                          randconfig-a003
arm64                            allyesconfig
arm                              allyesconfig
i386                          randconfig-a005
x86_64                            allnoconfig
riscv                             allnoconfig

clang tested configs:
hexagon              randconfig-r045-20221208
hexagon              randconfig-r041-20221208
riscv                randconfig-r042-20221208
s390                 randconfig-r044-20221208
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64                        randconfig-a012
i386                          randconfig-a013
x86_64                        randconfig-a001
x86_64                        randconfig-a003
i386                          randconfig-a011
x86_64                        randconfig-a005
i386                          randconfig-a015
i386                          randconfig-a004
i386                          randconfig-a002
i386                          randconfig-a006

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
