Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDDE8645051
	for <lists+linux-acpi@lfdr.de>; Wed,  7 Dec 2022 01:26:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbiLGA03 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 6 Dec 2022 19:26:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiLGA02 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 6 Dec 2022 19:26:28 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E472222;
        Tue,  6 Dec 2022 16:26:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670372787; x=1701908787;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=f33V8HoHTxDUm0G7TzqZXXfzZTT8wa5rS8tIQaoBp8I=;
  b=byRFmsFyt8wLy+iqlHQmbgKfTFjlojLrILqmm3kuLFgeKznf66yQug0X
   3XzJKymRwhkx5a4TEkZlGdu8Q5IKyN4bvk3X+XpXxaUHbrL9bjXcoALzQ
   8Gys+r7T5+aESoC9AYOh+b4tcET9XpefNYq/bNjLjsPIj0y69BMsD+smB
   Tb+xbJYFc1Mmi334R0ui3VyOpwL0QLnhV1Tt15lMuCXfoCS0pkfuyGb5n
   wUljHdV8kcdaMBRJC9BcsKcb+GP5f1PShVMon8qdRmSXJoiRRHDRLsv/9
   c46gATSNYqg3gYCgeWGtf3XKz3iVKdI4vzpI3a4oHH3DKX2w500dtGo4o
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10553"; a="296458906"
X-IronPort-AV: E=Sophos;i="5.96,223,1665471600"; 
   d="scan'208";a="296458906"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2022 16:26:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10553"; a="752856791"
X-IronPort-AV: E=Sophos;i="5.96,223,1665471600"; 
   d="scan'208";a="752856791"
Received: from lkp-server01.sh.intel.com (HELO b3c45e08cbc1) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 06 Dec 2022 16:26:25 -0800
Received: from kbuild by b3c45e08cbc1 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1p2iGX-0001N4-0L;
        Wed, 07 Dec 2022 00:26:25 +0000
Date:   Wed, 07 Dec 2022 08:26:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 eda97b8274b890cbd2d105beefa861378cf5f24f
Message-ID: <638fdda0.SXVTELHjXZvYj/8b%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: eda97b8274b890cbd2d105beefa861378cf5f24f  Merge branch 'acpi-fan' into bleeding-edge

elapsed time: 720m

configs tested: 64
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                           x86_64_defconfig
um                             i386_defconfig
i386                                defconfig
x86_64                              defconfig
i386                              allnoconfig
arm                               allnoconfig
arc                               allnoconfig
alpha                             allnoconfig
x86_64                          rhel-8.3-rust
i386                          randconfig-a001
arm                                 defconfig
x86_64                         rhel-8.3-kunit
i386                          randconfig-a003
x86_64                           rhel-8.3-kvm
x86_64                    rhel-8.3-kselftests
ia64                             allmodconfig
x86_64                           rhel-8.3-syz
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
arm                  randconfig-r046-20221206
arc                                 defconfig
arc                  randconfig-r043-20221206
i386                          randconfig-a005
s390                             allmodconfig
x86_64                           allyesconfig
alpha                               defconfig
s390                             allyesconfig
s390                                defconfig
x86_64                        randconfig-a013
x86_64                        randconfig-a011
arm64                            allyesconfig
arm                              allyesconfig
x86_64                        randconfig-a015
i386                             allyesconfig
m68k                             allyesconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a006
powerpc                           allnoconfig
sh                               allmodconfig
mips                             allyesconfig
powerpc                          allmodconfig
m68k                             allmodconfig
alpha                            allyesconfig
arc                              allyesconfig
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016

clang tested configs:
hexagon              randconfig-r041-20221206
i386                          randconfig-a002
hexagon              randconfig-r045-20221206
i386                          randconfig-a006
s390                 randconfig-r044-20221206
i386                          randconfig-a004
riscv                randconfig-r042-20221206
x86_64                        randconfig-a014
x86_64                        randconfig-a012
x86_64                        randconfig-a016
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
