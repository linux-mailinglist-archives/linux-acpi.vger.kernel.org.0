Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32B7C6A27F5
	for <lists+linux-acpi@lfdr.de>; Sat, 25 Feb 2023 09:53:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229471AbjBYIxh (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 25 Feb 2023 03:53:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjBYIxg (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 25 Feb 2023 03:53:36 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B395511EBC;
        Sat, 25 Feb 2023 00:53:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677315215; x=1708851215;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=R1HVdYzAo8KnzWiYgUUNAeHRDy1Db+dymDOxtBCl7Uo=;
  b=Yqzmcm2u4jYHtqZE8NlFCrgdbTI3031NEqtX22HZA2sK1yvN94nYnmG4
   dPxra1l0pQK+MlqgY5a3z/X2wl6AAJDjXi4q6tYGl2YK/ZYg5WQHYQJ+j
   AXQykS81W+VeN4b5ADPXArd6DxQxbyO0FAzOY6TRDcgfyXIsA8IjRtNi5
   20gs8bEjspMjsP5nDKokZM54HGDqx5rlOvok7UM3iljo96awww8jZzLV1
   qGAK8GwsHKEownehL4yy3uxP6012jlvytVLUVVNaisPWEe+viJqOLd08F
   /PVV4kQ5BsUpifoNfroFeFg2kddrmfF/wr993wmwfDDFEtwknpNFR6YsN
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10631"; a="332336488"
X-IronPort-AV: E=Sophos;i="5.97,327,1669104000"; 
   d="scan'208";a="332336488"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2023 00:53:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10631"; a="622984918"
X-IronPort-AV: E=Sophos;i="5.97,327,1669104000"; 
   d="scan'208";a="622984918"
Received: from lkp-server01.sh.intel.com (HELO 3895f5c55ead) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 25 Feb 2023 00:53:24 -0800
Received: from kbuild by 3895f5c55ead with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pVqJ2-00034V-0E;
        Sat, 25 Feb 2023 08:53:24 +0000
Date:   Sat, 25 Feb 2023 16:52:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 243d50840e68a096cfe5e136232898cddacb4e9f
Message-ID: <63f9cc5a.stC8g3D270ijm7Y6%lkp@intel.com>
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
branch HEAD: 243d50840e68a096cfe5e136232898cddacb4e9f  Merge branches 'pm-cpufreq' and 'powercap' into linux-next

elapsed time: 925m

configs tested: 24
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                               defconfig   gcc  
arc                                 defconfig   gcc  
arm                                 defconfig   gcc  
arm64                               defconfig   gcc  
csky                                defconfig   gcc  
i386                                defconfig   gcc  
ia64                                defconfig   gcc  
loongarch                           defconfig   gcc  
m68k                         amcore_defconfig   gcc  
m68k                                defconfig   gcc  
microblaze                          defconfig   gcc  
mips                        bcm47xx_defconfig   gcc  
mips                           mtx1_defconfig   clang
nios2                               defconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
riscv                               defconfig   gcc  
riscv                          rv32_defconfig   gcc  
s390                                defconfig   gcc  
sh                           se7343_defconfig   gcc  
sparc                               defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                              defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
