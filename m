Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F03E8ED13
	for <lists+linux-acpi@lfdr.de>; Tue, 30 Apr 2019 00:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729660AbfD2W5h convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Mon, 29 Apr 2019 18:57:37 -0400
Received: from mga07.intel.com ([134.134.136.100]:27939 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729601AbfD2W5g (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 29 Apr 2019 18:57:36 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Apr 2019 15:57:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,411,1549958400"; 
   d="scan'208";a="135479266"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
  by orsmga007.jf.intel.com with ESMTP; 29 Apr 2019 15:57:36 -0700
Received: from fmsmsx154.amr.corp.intel.com (10.18.116.70) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Mon, 29 Apr 2019 15:57:35 -0700
Received: from fmsmsx126.amr.corp.intel.com ([169.254.1.19]) by
 FMSMSX154.amr.corp.intel.com ([169.254.6.159]) with mapi id 14.03.0415.000;
 Mon, 29 Apr 2019 15:57:35 -0700
From:   "Brown, Len" <len.brown@intel.com>
To:     lkp <lkp@intel.com>
CC:     "kbuild-all@01.org" <kbuild-all@01.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: RE: [RFC PATCH acpi] x86 topology: calculate_max_logical_die() can
 be static
Thread-Topic: [RFC PATCH acpi] x86 topology: calculate_max_logical_die() can
 be static
Thread-Index: AQHU/t5h8p8eks/FckSC3JIq5+D2L6ZTv/LA
Date:   Mon, 29 Apr 2019 22:57:34 +0000
Message-ID: <1A7043D5F58CCB44A599DFD55ED4C9485C5F20A2@FMSMSX126.amr.corp.intel.com>
References: <201904300624.FRc2x66b%lkp@intel.com>
 <20190429225256.GA9491@lkp-kbuild15>
In-Reply-To: <20190429225256.GA9491@lkp-kbuild15>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMGE2OTQ2NzktZmM1Zi00MjIyLWI2NjQtZDRlNDQ1NDFhNmIwIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiR21XbGVXV1wvSGEzSXEyUUF4M0Y0RzdFQkh2MEVHbGJcL0ZxaUdJa3RsSFRxU1dXUGlITGJmT2gxdFExcG1pXC9PbyJ9
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-originating-ip: [10.1.200.107]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

This can be ignored -- as it was a temporary routine in my branch, which no longer exists in the latest.

Thanks,
-Len


-----Original Message-----
From: lkp 
Sent: Monday, April 29, 2019 6:53 PM
To: Brown, Len <len.brown@intel.com>
Cc: kbuild-all@01.org; linux-pm@vger.kernel.org; linux-acpi@vger.kernel.org
Subject: [RFC PATCH acpi] x86 topology: calculate_max_logical_die() can be static


Fixes: ae18cd4e0b58 ("x86 topology: create topology_max_die_per_package")
Signed-off-by: kbuild test robot <lkp@intel.com>
---
 smpboot.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c index f6c9c98..ff03d325 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1414,7 +1414,7 @@ void __init calculate_max_logical_packages(void)
 	__max_logical_packages = DIV_ROUND_UP(total_cpus, ncpus);
 	pr_info("Max logical packages: %u\n", __max_logical_packages);  } -void __init calculate_max_logical_die(void)
+static void __init calculate_max_logical_die(void)
 {
 	struct cpuinfo_x86 *c = &cpu_data(0);
 
