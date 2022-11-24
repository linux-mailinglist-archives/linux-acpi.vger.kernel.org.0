Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE89663755E
	for <lists+linux-acpi@lfdr.de>; Thu, 24 Nov 2022 10:40:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbiKXJkJ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 24 Nov 2022 04:40:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiKXJkH (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 24 Nov 2022 04:40:07 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A51B6122954;
        Thu, 24 Nov 2022 01:40:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669282805; x=1700818805;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=tBsRip1ybo+bmkgsgqnM9YexcOV4mKtEojxs1KBi+Eg=;
  b=IG2LBE/XYm/3q9wMyn4p07ueh35yOd4zEASWfvHocuvoR6h2flOoUjig
   MgGSeuinebLEeU+r6vssxBN3SDXJWNE53Zbhs4unHibbbqEy1umCTTFzM
   EmqoLxgQMr1U8ccsDJgwcfrLUDIh4QXQJrBjBiwLqvFywe9sNkWwHY4V7
   20hNmFnMfoTg1i3LgqyzJ/VtHkMfoz8FscofcvsWBtFPPJVks2u3tbWI8
   EQ00Qa9LD4AyV8Kfz/mAmLie+OzNJDnnF6qCAtygAXean6p//2cjBV8LW
   9B2Y6Me5Yo5ZrcOjRMYugB2SB94ExInL44ex1Zcq68h1fiakV9I1FghbT
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="297623060"
X-IronPort-AV: E=Sophos;i="5.96,190,1665471600"; 
   d="scan'208";a="297623060"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2022 01:40:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="784574061"
X-IronPort-AV: E=Sophos;i="5.96,190,1665471600"; 
   d="scan'208";a="784574061"
Received: from lkp-server01.sh.intel.com (HELO 64a2d449c951) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 24 Nov 2022 01:40:03 -0800
Received: from kbuild by 64a2d449c951 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oy8iA-0003iX-1M;
        Thu, 24 Nov 2022 09:40:02 +0000
Date:   Thu, 24 Nov 2022 17:39:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 666c2722497d7c679ade03e0500b55464914209a
Message-ID: <637f3bce.3t8BO6DYn4Ri89Tu%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 666c2722497d7c679ade03e0500b55464914209a  Merge branch 'thermal-intel' into bleeding-edge

elapsed time: 827m

configs tested: 62
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
alpha                             allnoconfig
i386                              allnoconfig
arm                               allnoconfig
arc                               allnoconfig
powerpc                           allnoconfig
um                             i386_defconfig
arc                                 defconfig
um                           x86_64_defconfig
alpha                               defconfig
s390                                defconfig
sh                               allmodconfig
s390                             allmodconfig
mips                             allyesconfig
powerpc                          allmodconfig
s390                             allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
x86_64                           rhel-8.3-kvm
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-syz
m68k                             allyesconfig
ia64                             allmodconfig
i386                 randconfig-a011-20221121
i386                 randconfig-a013-20221121
i386                 randconfig-a012-20221121
i386                 randconfig-a014-20221121
i386                 randconfig-a016-20221121
i386                 randconfig-a015-20221121
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
i386                                defconfig
arc                  randconfig-r043-20221124
x86_64                              defconfig
i386                          randconfig-a001
i386                          randconfig-a003
i386                             allyesconfig
x86_64                               rhel-8.3
i386                          randconfig-a005
x86_64                           allyesconfig
arm                                 defconfig
arm                              allyesconfig
arm64                            allyesconfig

clang tested configs:
x86_64                        randconfig-a012
x86_64                        randconfig-a016
x86_64                        randconfig-a014
x86_64               randconfig-a004-20221121
x86_64               randconfig-a001-20221121
x86_64               randconfig-a003-20221121
x86_64               randconfig-a002-20221121
x86_64               randconfig-a005-20221121
x86_64               randconfig-a006-20221121
hexagon              randconfig-r041-20221124
riscv                randconfig-r042-20221124
hexagon              randconfig-r045-20221124
s390                 randconfig-r044-20221124
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
