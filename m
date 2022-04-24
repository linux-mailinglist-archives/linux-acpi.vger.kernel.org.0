Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E64650D00A
	for <lists+linux-acpi@lfdr.de>; Sun, 24 Apr 2022 08:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235941AbiDXG07 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 24 Apr 2022 02:26:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238362AbiDXG06 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 24 Apr 2022 02:26:58 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0339D17BF96;
        Sat, 23 Apr 2022 23:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650781438; x=1682317438;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=YliaMT8TR9bAjexxNV1yfpqeWdYHjrzqiH1zJqBnqwo=;
  b=fd8OLwrKKCe8lPKDU/4a7J3DEjJKSelpNArYIbisgMKl0zHhnaeA3A60
   3ks/3cxu3yuXXIdCVnzNciLrQ2HlJYCIGDYAWRkt00Pi55ghmV1As7stD
   IRrEs+2TnbcgUbtyqDaHxEG8x/aZf+f2cIw8ldGv6JpwSw19jUcrmzbee
   etzj3LJ7gnMn69mrA0ZnOnnYSvnNDYDRg8FZyhVePugiB5cLu8GiXBsCg
   +iFRivsNJ64dS7VXtJkJaxwqAUOZLpyrucu19aEglpPDmkHgxp6ht2E1r
   V9JWtvMB8f9mC+VB/7l8BwIoR1FzNVDSfQAi9VMuGBq1pqyJPgWb/ZO+1
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10326"; a="262599459"
X-IronPort-AV: E=Sophos;i="5.90,285,1643702400"; 
   d="scan'208";a="262599459"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2022 23:23:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,285,1643702400"; 
   d="scan'208";a="729176177"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 23 Apr 2022 23:23:53 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1niVey-00017L-R4;
        Sun, 24 Apr 2022 06:23:52 +0000
Date:   Sun, 24 Apr 2022 14:23:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     kbuild-all@lists.01.org, linux-acpi@vger.kernel.org,
        devel@acpica.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge 8/20] WARNING: modpost:
 vmlinux.o(.text+0xfdc8e4): Section mismatch in reference from the function
 component_compare_dev_name() to the variable .exit.text:.LFB4478
Message-ID: <202204241452.pAvKt2JP-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
head:   f23bedef4354b1e8a69a25d8c9c1201e6d8e8762
commit: 9d66f8243f05815087050993644c46a71ffc3d04 [8/20] Merge branches 'thermal-int340x' and 'thermal-misc' into linux-next
config: riscv-buildonly-randconfig-r002-20220421 (https://download.01.org/0day-ci/archive/20220424/202204241452.pAvKt2JP-lkp@intel.com/config)
compiler: riscv32-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/commit/?id=9d66f8243f05815087050993644c46a71ffc3d04
        git remote add rafael-pm https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
        git fetch --no-tags rafael-pm bleeding-edge
        git checkout 9d66f8243f05815087050993644c46a71ffc3d04
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>, old ones prefixed by <<):

>> WARNING: modpost: vmlinux.o(.text+0xfdc8e4): Section mismatch in reference from the function component_compare_dev_name() to the variable .exit.text:.LFB4478
The function component_compare_dev_name() references a variable in an exit section.
Often the variable .LFB4478 has valid usage outside the exit section
and the fix is to remove the __exit annotation of .LFB4478.
--
>> WARNING: modpost: vmlinux.o(.text+0x15ff5e0): Section mismatch in reference from the function dm_stats_init() to the variable .init.text:.L0
The function dm_stats_init() references
the variable __init .L0 .
This is often because dm_stats_init lacks a __init
annotation or the annotation of .L0 is wrong.
--
>> WARNING: modpost: vmlinux.o(.text+0x1bf624c): Section mismatch in reference from the function sctp_sched_ops_init() to the variable .init.text:.L0
The function sctp_sched_ops_init() references
the variable __init .L0 .
This is often because sctp_sched_ops_init lacks a __init
annotation or the annotation of .L0 is wrong.

Note: the below error/warnings can be found in parent commit:
<< WARNING: modpost: vmlinux.o(.text+0xcb5b08): Section mismatch in reference from the function pci_sriov_resource_alignment() to the function .init.text:sm501fb_driver_init()
<< WARNING: modpost: vmlinux.o(.text+0xfdc8e4): Section mismatch in reference from the function component_compare_dev_name() to the variable .exit.text:.LFE4478
<< WARNING: modpost: vmlinux.o(.exit.text+0xe120): Section mismatch in reference from the function hsr_netlink_exit() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(__ex_table+0x1260): Section mismatch in reference from the variable .L0 to the variable .rodata:_entry.30
<< WARNING: modpost: vmlinux.o(.text+0x1697378): Section mismatch in reference from the function btintel_send_intel_reset() to the variable .exit.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0x1a9f788): Section mismatch in reference from the function fib_free_table() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0x1bf6234): Section mismatch in reference from the function sctp_sched_ops_register() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0x1bf627c): Section mismatch in reference from the function sctp_sched_set_sched() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0x1bf640c): Section mismatch in reference from the function sctp_sched_get_sched() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0xcb5b08): Section mismatch in reference from the function pci_sriov_resource_alignment() to the function .init.text:sm501fb_driver_init()
<< WARNING: modpost: vmlinux.o(.text+0xfdc8e4): Section mismatch in reference from the function component_compare_dev_name() to the variable .exit.text:.LFE4478
<< WARNING: modpost: vmlinux.o(.exit.text+0xe120): Section mismatch in reference from the function hsr_netlink_exit() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(__ex_table+0x1260): Section mismatch in reference from the variable .L0 to the variable .rodata:_entry.30
<< WARNING: modpost: vmlinux.o(.text+0x1697378): Section mismatch in reference from the function btintel_send_intel_reset() to the variable .exit.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0x1a9f788): Section mismatch in reference from the function fib_free_table() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0x1bf6234): Section mismatch in reference from the function sctp_sched_ops_register() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0x1bf627c): Section mismatch in reference from the function sctp_sched_set_sched() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0x1bf640c): Section mismatch in reference from the function sctp_sched_get_sched() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0xcb5b08): Section mismatch in reference from the function pci_sriov_resource_alignment() to the function .init.text:sm501fb_driver_init()
<< WARNING: modpost: vmlinux.o(.text+0xfdc8e4): Section mismatch in reference from the function component_compare_dev_name() to the variable .exit.text:.LFE4478
<< WARNING: modpost: vmlinux.o(.exit.text+0xe120): Section mismatch in reference from the function hsr_netlink_exit() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(__ex_table+0x1260): Section mismatch in reference from the variable .L0 to the variable .rodata:_entry.30
<< WARNING: modpost: vmlinux.o(.text+0x1697378): Section mismatch in reference from the function btintel_send_intel_reset() to the variable .exit.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0x1a9f788): Section mismatch in reference from the function fib_free_table() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0x1bf6234): Section mismatch in reference from the function sctp_sched_ops_register() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0x1bf627c): Section mismatch in reference from the function sctp_sched_set_sched() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0x1bf640c): Section mismatch in reference from the function sctp_sched_get_sched() to the variable .init.text:.L0

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
