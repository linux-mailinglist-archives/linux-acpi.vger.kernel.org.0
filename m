Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76933ED04
	for <lists+linux-acpi@lfdr.de>; Tue, 30 Apr 2019 00:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729687AbfD2Wx2 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 29 Apr 2019 18:53:28 -0400
Received: from mga17.intel.com ([192.55.52.151]:8228 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729601AbfD2Wx0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 29 Apr 2019 18:53:26 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Apr 2019 15:53:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,411,1549958400"; 
   d="scan'208";a="146811952"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 29 Apr 2019 15:53:25 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1hLF9I-0000m4-He; Tue, 30 Apr 2019 06:53:24 +0800
Date:   Tue, 30 Apr 2019 06:52:55 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Len Brown <len.brown@intel.com>
Cc:     kbuild-all@01.org, linux-pm@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: [acpi:x86 15/18] arch/x86/kernel/smpboot.c:1417:13: sparse: sparse:
 symbol 'calculate_max_logical_die' was not declared. Should it be static?
Message-ID: <201904300624.FRc2x66b%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux.git x86
head:   c1878269c84ce9814256651fb46c284cf372a444
commit: ae18cd4e0b58f2e077ea6b767547fc811da5b327 [15/18] x86 topology: create topology_max_die_per_package
reproduce:
        # apt-get install sparse
        git checkout ae18cd4e0b58f2e077ea6b767547fc811da5b327
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> arch/x86/kernel/smpboot.c:1417:13: sparse: sparse: symbol 'calculate_max_logical_die' was not declared. Should it be static?

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
