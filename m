Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61571719E4
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Jul 2019 16:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729547AbfGWODz (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 23 Jul 2019 10:03:55 -0400
Received: from mga12.intel.com ([192.55.52.136]:4893 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727349AbfGWODy (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 23 Jul 2019 10:03:54 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Jul 2019 07:03:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,299,1559545200"; 
   d="scan'208";a="344749449"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 23 Jul 2019 07:03:46 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1hpvOM-0005dZ-C1; Tue, 23 Jul 2019 22:03:46 +0800
Date:   Tue, 23 Jul 2019 22:03:37 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Tri Vo <trong@android.com>
Cc:     kbuild-all@01.org, linux-acpi@vger.kernel.org, devel@acpica.org,
        linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [pm:bleeding-edge 21/23] drivers/base/power/wakeup_stats.c:143:1-3:
 WARNING: PTR_ERR_OR_ZERO can be used
Message-ID: <201907232235.iRDGgF0x%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree:   https://kernel.googlesource.com/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
head:   14b99dcec44e7bca9f01e042002f57e9f0dda133
commit: 0b050f7fb8a1e45c72ca945bac2821a59d4a0101 [21/23] PM / wakeup: show wakeup sources stats in sysfs

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>


coccinelle warnings: (new ones prefixed by >>)

>> drivers/base/power/wakeup_stats.c:143:1-3: WARNING: PTR_ERR_OR_ZERO can be used

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
