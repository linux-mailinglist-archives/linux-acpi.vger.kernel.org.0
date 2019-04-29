Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF057ED01
	for <lists+linux-acpi@lfdr.de>; Tue, 30 Apr 2019 00:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729662AbfD2Wx0 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 29 Apr 2019 18:53:26 -0400
Received: from mga12.intel.com ([192.55.52.136]:42516 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729601AbfD2WxZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 29 Apr 2019 18:53:25 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Apr 2019 15:53:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,411,1549958400"; 
   d="scan'208";a="139921004"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 29 Apr 2019 15:53:24 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1hLF9H-0000Tq-KK; Tue, 30 Apr 2019 06:53:23 +0800
Date:   Tue, 30 Apr 2019 06:52:56 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Len Brown <len.brown@intel.com>
Cc:     kbuild-all@01.org, linux-pm@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: [RFC PATCH acpi] x86 topology: calculate_max_logical_die() can be
 static
Message-ID: <20190429225256.GA9491@lkp-kbuild15>
References: <201904300624.FRc2x66b%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201904300624.FRc2x66b%lkp@intel.com>
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


Fixes: ae18cd4e0b58 ("x86 topology: create topology_max_die_per_package")
Signed-off-by: kbuild test robot <lkp@intel.com>
---
 smpboot.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index f6c9c98..ff03d325 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1414,7 +1414,7 @@ void __init calculate_max_logical_packages(void)
 	__max_logical_packages = DIV_ROUND_UP(total_cpus, ncpus);
 	pr_info("Max logical packages: %u\n", __max_logical_packages);
 }
-void __init calculate_max_logical_die(void)
+static void __init calculate_max_logical_die(void)
 {
 	struct cpuinfo_x86 *c = &cpu_data(0);
 
