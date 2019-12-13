Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9919911EA09
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Dec 2019 19:17:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728769AbfLMSQ2 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 13 Dec 2019 13:16:28 -0500
Received: from mga09.intel.com ([134.134.136.24]:52404 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728693AbfLMSQ2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 13 Dec 2019 13:16:28 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Dec 2019 10:16:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,309,1571727600"; 
   d="scan'208";a="208536392"
Received: from gayuk-dev-mach.sc.intel.com ([10.3.79.172])
  by orsmga008.jf.intel.com with ESMTP; 13 Dec 2019 10:16:27 -0800
From:   Gayatri Kammela <gayatri.kammela@intel.com>
To:     linux-pm@vger.kernel.org
Cc:     platform-driver-x86@vger.kernel.org, alex.hung@canonical.com,
        linux-acpi@vger.kernel.org, lenb@kernel.org, rjw@rjwysocki.net,
        linux-kernel@vger.kernel.org, daniel.lezcano@linaro.org,
        amit.kucheria@verdurent.com, charles.d.prestopine@intel.com,
        dvhart@infradead.org, Gayatri Kammela <gayatri.kammela@intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@intel.com>
Subject: [PATCH v2 3/4] platform/x86: intel-hid: Add new Tiger Lake hardware ID to support HID driver
Date:   Fri, 13 Dec 2019 10:14:22 -0800
Message-Id: <a70a856e9a87c89ba92da514c1dda1f46f10b0de.1576260216.git.gayatri.kammela@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1576260216.git.gayatri.kammela@intel.com>
References: <cover.1576260216.git.gayatri.kammela@intel.com>
In-Reply-To: <cover.1576260216.git.gayatri.kammela@intel.com>
References: <cover.1576260216.git.gayatri.kammela@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Tiger Lake has a new unique hardware ID to support Intel's HID event
filter driver. Hence, add it.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@intel.com>
Signed-off-by: Gayatri Kammela <gayatri.kammela@intel.com>
---
 drivers/platform/x86/intel-hid.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/x86/intel-hid.c b/drivers/platform/x86/intel-hid.c
index ef6d4bd77b1a..43d590250228 100644
--- a/drivers/platform/x86/intel-hid.c
+++ b/drivers/platform/x86/intel-hid.c
@@ -19,6 +19,7 @@ MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Alex Hung");
 
 static const struct acpi_device_id intel_hid_ids[] = {
+	{"INT1051", 0},
 	{"INT33D5", 0},
 	{"", 0},
 };
-- 
2.17.1

