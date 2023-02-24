Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEF9B6A16FF
	for <lists+linux-acpi@lfdr.de>; Fri, 24 Feb 2023 08:18:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbjBXHSp (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 24 Feb 2023 02:18:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjBXHSo (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 24 Feb 2023 02:18:44 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F5721589A;
        Thu, 23 Feb 2023 23:18:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677223123; x=1708759123;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=zYbshPl/lsCnWUmVhR/K96jzGok99c8lvegV+Z/ET1s=;
  b=AzuhrLEKdKP5DVfhO1yaQcCxe0HJoIx5hqkWL9lMxmsvKyvh1SokT/0B
   JkYM7XYbijEkOi7nmnko/lmqLg1Z6VTW2TMBTOpUDWQVn8WAWGtx8qoDB
   aMEP/kZxGFq70gNpDY4uxdhOBnEaxdYnpBDPHFpzZtgY3NTxWJbk8ToJc
   3Y/NzWXshRaIh1NnKjCmTzLzpgNIa/dKWZLipETyvTA1psL3cpaQM7Vp0
   fvVbK++enyhHh3Wk0vc/3Romw18THPvtiH6+m12ayb/ClRFpe4ZXa53mC
   gQ2egkUN7Zt43TFXaOPkHJoNEx4Sd/KvXQl0R2CVH6vX95UWnZhI9z2Hl
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10630"; a="334834613"
X-IronPort-AV: E=Sophos;i="5.97,322,1669104000"; 
   d="scan'208";a="334834613"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2023 23:18:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10630"; a="815637525"
X-IronPort-AV: E=Sophos;i="5.97,322,1669104000"; 
   d="scan'208";a="815637525"
Received: from lkp-server01.sh.intel.com (HELO 3895f5c55ead) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 23 Feb 2023 23:18:40 -0800
Received: from kbuild by 3895f5c55ead with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pVSLo-0002E5-0m;
        Fri, 24 Feb 2023 07:18:40 +0000
Date:   Fri, 24 Feb 2023 15:18:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 56b49cc1d126d558bb976785deb9eeff3160fb47
Message-ID: <63f864be.JL6UtBJ/6VvtU055%lkp@intel.com>
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
branch HEAD: 56b49cc1d126d558bb976785deb9eeff3160fb47  Merge branch 'powercap' into bleeding-edge

elapsed time: 720m

configs tested: 24
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
clang                                   alpha   defconfig
gcc                                       arc   defconfig
gcc                                       arm   defconfig
gcc                                     arm64   defconfig
gcc                                      csky   defconfig
gcc                                      i386   defconfig
gcc                                      ia64   defconfig
gcc                                 loongarch   defconfig
gcc                                      m68k   defconfig
gcc                                      m68k   m5249evb_defconfig
gcc                                      mips   ip32_defconfig
gcc                                     nios2   defconfig
gcc                                    parisc   defconfig
gcc                                  parisc64   defconfig
gcc                                     riscv   defconfig
gcc                                     riscv   rv32_defconfig
gcc                                      s390   defconfig
gcc                                        sh   microdev_defconfig
gcc                                        sh   r7780mp_defconfig
gcc                                     sparc   defconfig
gcc                                     sparc   sparc32_defconfig
gcc                                        um   i386_defconfig
gcc                                        um   x86_64_defconfig
gcc                                    x86_64   defconfig
gcc                                                  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
