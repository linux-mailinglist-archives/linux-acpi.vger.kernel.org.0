Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B26950CCE4
	for <lists+linux-acpi@lfdr.de>; Sat, 23 Apr 2022 20:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236495AbiDWSfb (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 23 Apr 2022 14:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235771AbiDWSf3 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 23 Apr 2022 14:35:29 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75EB11240CD;
        Sat, 23 Apr 2022 11:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650738749; x=1682274749;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=NLI6B+T+c6KcSRFcOjCP4njvCPoWm8EpOmyLtcT4jLI=;
  b=mSZ+e72DTGydYzwgiFSjaA4RSsWAYJbatAPSZ+RHmOW352blXoy7TDkf
   qgppa+D4DBhG4sEx+qcvIzm012pLeJ6NHgXLrLvuVJWzfz3FMfjc0/fEy
   aB4krKoxkbvl+r3g4r2OxnLHGLbFCSJ+KxbcBNoCLX/wFAqZWKX8la411
   ZW2GCS8A+fn+bHkvQcChRJ3rmcX8D2G3M6J0Duv7Bt0AsXrH7fBigWB36
   CfP6zazl6sYivRBn/5H38FxVk/X1cQMeCOsiV1MXUWOpl+0fS/dX3Dac8
   2enBOQjJ5crY/QmfnGFqBKkKI/tyASVEyE9drCKZfSKVMFsemnJaxeb2o
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10326"; a="245503653"
X-IronPort-AV: E=Sophos;i="5.90,284,1643702400"; 
   d="scan'208";a="245503653"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2022 11:32:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,284,1643702400"; 
   d="scan'208";a="531384294"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 23 Apr 2022 11:32:26 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1niKYT-0000LG-Es;
        Sat, 23 Apr 2022 18:32:25 +0000
Date:   Sun, 24 Apr 2022 02:32:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     kbuild-all@lists.01.org, linux-acpi@vger.kernel.org,
        devel@acpica.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge 7/20] WARNING: modpost:
 vmlinux.o(.exit.text+0xe120): Section mismatch in reference from the
 function hsr_netlink_exit() to the variable .init.text:.L0
Message-ID: <202204240259.PyW8hsJz-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
head:   f23bedef4354b1e8a69a25d8c9c1201e6d8e8762
commit: 989108f9dfffcaebab87d8b37aa7d4d9d10d2745 [7/20] Merge branch 'devprop' into linux-next
config: riscv-buildonly-randconfig-r002-20220421 (https://download.01.org/0day-ci/archive/20220424/202204240259.PyW8hsJz-lkp@intel.com/config)
compiler: riscv32-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/commit/?id=989108f9dfffcaebab87d8b37aa7d4d9d10d2745
        git remote add rafael-pm https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
        git fetch --no-tags rafael-pm bleeding-edge
        git checkout 989108f9dfffcaebab87d8b37aa7d4d9d10d2745
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>, old ones prefixed by <<):

>> WARNING: modpost: vmlinux.o(.exit.text+0xe120): Section mismatch in reference from the function hsr_netlink_exit() to the variable .init.text:.L0
The function __exit hsr_netlink_exit() references
a variable __init .L0 .
This is often seen when error handling in the exit function
uses functionality in the init path.
The fix is often to remove the __init annotation of
.L0 so it may be used outside an init section.
--
>> WARNING: modpost: vmlinux.o(__ex_table+0x1260): Section mismatch in reference from the variable .L0 to the variable .rodata:_entry.30
FATAL: modpost: extable_entry size hasn't been discovered!
--
>> WARNING: modpost: vmlinux.o(.text+0x1697378): Section mismatch in reference from the function btintel_send_intel_reset() to the variable .exit.text:.L0
The function btintel_send_intel_reset() references a variable in an exit section.
Often the variable .L0 has valid usage outside the exit section
and the fix is to remove the __exit annotation of .L0 .
--
>> WARNING: modpost: vmlinux.o(.text+0x1bf6234): Section mismatch in reference from the function sctp_sched_ops_register() to the variable .init.text:.L0
The function sctp_sched_ops_register() references
the variable __init .L0 .
This is often because sctp_sched_ops_register lacks a __init
annotation or the annotation of .L0 is wrong.
--
>> WARNING: modpost: vmlinux.o(.text+0x1bf627c): Section mismatch in reference from the function sctp_sched_set_sched() to the variable .init.text:.L0
The function sctp_sched_set_sched() references
the variable __init .L0 .
This is often because sctp_sched_set_sched lacks a __init
annotation or the annotation of .L0 is wrong.
--
>> WARNING: modpost: vmlinux.o(.text+0x1bf640c): Section mismatch in reference from the function sctp_sched_get_sched() to the variable .init.text:.L0
The function sctp_sched_get_sched() references
the variable __init .L0 .
This is often because sctp_sched_get_sched lacks a __init
annotation or the annotation of .L0 is wrong.

Note: the below error/warnings can be found in parent commit:
<< WARNING: modpost: vmlinux.o(.text+0x66d448): Section mismatch in reference from the function nilfs_segbuf_free() to the variable .exit.text:.LVL12
<< WARNING: modpost: vmlinux.o(.text+0x15a8b7c): Section mismatch in reference from the function bch_keybuf_init() to the variable .init.text:.LVL52
<< WARNING: modpost: vmlinux.o(.text+0x1aa0df0): Section mismatch in reference from the function ping_seq_stop() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0x1aa2298): Section mismatch in reference from the function ping_common_sendmsg() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0x1aa2e08): Section mismatch in reference from the function ping_proc_exit() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0x1aeca5c): Section mismatch in reference from the function x25_limit_facilities() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(__ex_table+0x1260): Section mismatch in reference from the variable .L0 to the variable .debug_loc:.LLST136
<< WARNING: modpost: vmlinux.o(.text+0x66d448): Section mismatch in reference from the function nilfs_segbuf_free() to the variable .exit.text:.LVL12
<< WARNING: modpost: vmlinux.o(.text+0x15a8b7c): Section mismatch in reference from the function bch_keybuf_init() to the variable .init.text:.LVL52
<< WARNING: modpost: vmlinux.o(.text+0x1aa0df0): Section mismatch in reference from the function ping_seq_stop() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0x1aa2298): Section mismatch in reference from the function ping_common_sendmsg() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0x1aa2e08): Section mismatch in reference from the function ping_proc_exit() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0x1aeca5c): Section mismatch in reference from the function x25_limit_facilities() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(__ex_table+0x1260): Section mismatch in reference from the variable .L0 to the variable .debug_loc:.LLST136
<< WARNING: modpost: vmlinux.o(.text+0x66d448): Section mismatch in reference from the function nilfs_segbuf_free() to the variable .exit.text:.LVL12
<< WARNING: modpost: vmlinux.o(.text+0x15a8b7c): Section mismatch in reference from the function bch_keybuf_init() to the variable .init.text:.LVL52
<< WARNING: modpost: vmlinux.o(.text+0x1aa0df0): Section mismatch in reference from the function ping_seq_stop() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0x1aa2298): Section mismatch in reference from the function ping_common_sendmsg() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0x1aa2e08): Section mismatch in reference from the function ping_proc_exit() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0x1aeca5c): Section mismatch in reference from the function x25_limit_facilities() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(__ex_table+0x1260): Section mismatch in reference from the variable .L0 to the variable .debug_loc:.LLST136
<< WARNING: modpost: vmlinux.o(.text+0x66d448): Section mismatch in reference from the function nilfs_segbuf_free() to the variable .exit.text:.LVL12
<< WARNING: modpost: vmlinux.o(.text+0x15a8b7c): Section mismatch in reference from the function bch_keybuf_init() to the variable .init.text:.LVL52
<< WARNING: modpost: vmlinux.o(.text+0x1aa0df0): Section mismatch in reference from the function ping_seq_stop() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0x1aa2298): Section mismatch in reference from the function ping_common_sendmsg() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0x1aa2e08): Section mismatch in reference from the function ping_proc_exit() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0x1aeca5c): Section mismatch in reference from the function x25_limit_facilities() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(__ex_table+0x1260): Section mismatch in reference from the variable .L0 to the variable .debug_loc:.LLST136
<< WARNING: modpost: vmlinux.o(.text+0x66d448): Section mismatch in reference from the function nilfs_segbuf_free() to the variable .exit.text:.LVL12
<< WARNING: modpost: vmlinux.o(.text+0x15a8b7c): Section mismatch in reference from the function bch_keybuf_init() to the variable .init.text:.LVL52
<< WARNING: modpost: vmlinux.o(.text+0x1aa0df0): Section mismatch in reference from the function ping_seq_stop() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0x1aa2298): Section mismatch in reference from the function ping_common_sendmsg() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0x1aa2e08): Section mismatch in reference from the function ping_proc_exit() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0x1aeca5c): Section mismatch in reference from the function x25_limit_facilities() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(__ex_table+0x1260): Section mismatch in reference from the variable .L0 to the variable .debug_loc:.LLST136
<< WARNING: modpost: vmlinux.o(.text+0x66d448): Section mismatch in reference from the function nilfs_segbuf_free() to the variable .exit.text:.LVL12
<< WARNING: modpost: vmlinux.o(.text+0x15a8b7c): Section mismatch in reference from the function bch_keybuf_init() to the variable .init.text:.LVL52
<< WARNING: modpost: vmlinux.o(.text+0x1aa0df0): Section mismatch in reference from the function ping_seq_stop() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0x1aa2298): Section mismatch in reference from the function ping_common_sendmsg() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0x1aa2e08): Section mismatch in reference from the function ping_proc_exit() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0x1aeca5c): Section mismatch in reference from the function x25_limit_facilities() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(__ex_table+0x1260): Section mismatch in reference from the variable .L0 to the variable .debug_loc:.LLST136

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
