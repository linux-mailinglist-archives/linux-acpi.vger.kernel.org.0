Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3916A589797
	for <lists+linux-acpi@lfdr.de>; Thu,  4 Aug 2022 07:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232030AbiHDF5o (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 4 Aug 2022 01:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiHDF5n (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 4 Aug 2022 01:57:43 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A618561101;
        Wed,  3 Aug 2022 22:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659592662; x=1691128662;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=UJtDYisSJYVkIc7KkmYBVx56YXX5cQRrBtgW7DWgphA=;
  b=gfVfBYNPHwoS40qymZ5EUeZfNFvzcRQHpBCNWanGgXSORmBJN5V9frcm
   RoWa2lBGDCoC8S2/78vNl1CFrCj2ysionPH2m93kE0ouB5d7rzibifEgx
   PBA/1q00EhBcq8XJQ8j3V+SwN25Ph1z4MYMTgMLvK+dTCzl3B0x76mP9Y
   sKOibG3Gu6v0UOhEOelwn3PMAjMNrNkY1t5sA8I4X6IEqM7tPtiHlVKwn
   vyLNlpcKpJQGru3MVTGndRhxafE+YG0BkFPHE9nNCG3R1kkhIuB52nTQ4
   jxMwvMAVJGDGbIGcAkIM23ZiBLCJIj8ojcb1D2WpJXDP/5RYCYFFxrokd
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10428"; a="287408636"
X-IronPort-AV: E=Sophos;i="5.93,214,1654585200"; 
   d="scan'208";a="287408636"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2022 22:57:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,214,1654585200"; 
   d="scan'208";a="578936265"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 03 Aug 2022 22:57:40 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oJTrX-000I4p-3A;
        Thu, 04 Aug 2022 05:57:39 +0000
Date:   Thu, 04 Aug 2022 13:57:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 32a88f1a1f50b790374b13137ff6bef2505c4cbb
Message-ID: <62eb5fc0.WCoz2aoQ6X10LSIJ%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 32a88f1a1f50b790374b13137ff6bef2505c4cbb  Merge branch 'thermal-tools' into bleeding-edge

elapsed time: 717m

configs tested: 52
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
arc                              allyesconfig
alpha                            allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                  randconfig-r043-20220803
riscv                randconfig-r042-20220803
s390                 randconfig-r044-20220803
i386                                defconfig
i386                             allyesconfig
x86_64                        randconfig-a002
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                        randconfig-a004
x86_64                        randconfig-a006
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
i386                          randconfig-a001
i386                          randconfig-a003
x86_64                         rhel-8.3-kunit
i386                          randconfig-a005
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
arm                                 defconfig
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
x86_64                        randconfig-a013
x86_64                        randconfig-a011
arm64                            allyesconfig
powerpc                           allnoconfig
arm                              allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
mips                             allyesconfig
x86_64                        randconfig-a015

clang tested configs:
hexagon              randconfig-r041-20220803
hexagon              randconfig-r045-20220803
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
x86_64                        randconfig-a012
x86_64                        randconfig-a016
x86_64                        randconfig-a014

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
