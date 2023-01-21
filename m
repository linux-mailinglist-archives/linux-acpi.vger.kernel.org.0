Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ABAE676427
	for <lists+linux-acpi@lfdr.de>; Sat, 21 Jan 2023 07:27:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbjAUG1F (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 21 Jan 2023 01:27:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjAUG1F (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 21 Jan 2023 01:27:05 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CF5A72C13;
        Fri, 20 Jan 2023 22:27:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674282424; x=1705818424;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=XSDJ6F7b1SxjTwC2VfM7toe9bd8SPZ736wTeydGfVzQ=;
  b=cuwFoX/oFqRwYdFI32JnwMWAULVEpZ9hyWryn9/3ktHR/m7WIorpuuk7
   d62Nx9od6X7bu5DTY3mZ5i0vh6OhffSVQ3H7MrZxHtjUT8Vg9GwDrNCIw
   JdW+6gCqfCRcnHIliXBd+eYtQmsdbVcQ7zJSXlQ/BR6Bxi9kU1UF8qcNx
   qjMP8261VEXJ906AP6Abj+41LXN9u9s+vPAtwDFgTlTCDftX3Yg1OkoQM
   eM86bUTgw11cwch16kPYo9fhWwK/7d/P3SeLdubhP+d/lAaifetPFv7uY
   FwmI2eyNRVeC+v1kcfXBs8BPWoaC50hKrMJp+IIpQ0xkum5+y0C9siPwE
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10596"; a="388123424"
X-IronPort-AV: E=Sophos;i="5.97,234,1669104000"; 
   d="scan'208";a="388123424"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2023 22:27:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10596"; a="660847253"
X-IronPort-AV: E=Sophos;i="5.97,234,1669104000"; 
   d="scan'208";a="660847253"
Received: from lkp-server01.sh.intel.com (HELO 5646d64e7320) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 20 Jan 2023 22:27:00 -0800
Received: from kbuild by 5646d64e7320 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pJ7LA-0003fI-0M;
        Sat, 21 Jan 2023 06:27:00 +0000
Date:   Sat, 21 Jan 2023 14:26:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 3665611ff946c2576bfad0327fc0f8e26773eb01
Message-ID: <63cb8597.ACbnUXBijUW+bX34%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 3665611ff946c2576bfad0327fc0f8e26773eb01  Merge branch 'acpica' into bleeding-edge

elapsed time: 722m

configs tested: 67
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
s390                                defconfig
um                             i386_defconfig
x86_64                            allnoconfig
um                           x86_64_defconfig
s390                             allyesconfig
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
powerpc                           allnoconfig
sh                               allmodconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
alpha                            allyesconfig
mips                             allyesconfig
x86_64                    rhel-8.3-kselftests
arc                               allnoconfig
x86_64                         rhel-8.3-kunit
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-bpf
alpha                             allnoconfig
i386                                defconfig
i386                              allnoconfig
arm                               allnoconfig
arm                  randconfig-r046-20230119
arc                  randconfig-r043-20230119
powerpc                          allmodconfig
x86_64                              defconfig
x86_64                               rhel-8.3
arm                                 defconfig
x86_64                        randconfig-a002
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                           allyesconfig
ia64                             allmodconfig
arm64                            allyesconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a015
arm                              allyesconfig
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
i386                             allyesconfig
riscv                             allnoconfig

clang tested configs:
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                          rhel-8.3-rust
hexagon              randconfig-r045-20230119
hexagon              randconfig-r041-20230119
s390                 randconfig-r044-20230119
riscv                randconfig-r042-20230119
x86_64                        randconfig-a014
x86_64                        randconfig-a001
x86_64                        randconfig-a012
x86_64                        randconfig-a003
x86_64                        randconfig-a005
x86_64                        randconfig-a016
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
