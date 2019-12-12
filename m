Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 941C211D996
	for <lists+linux-acpi@lfdr.de>; Thu, 12 Dec 2019 23:40:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731118AbfLLWjd (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 12 Dec 2019 17:39:33 -0500
Received: from mga12.intel.com ([192.55.52.136]:37853 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730707AbfLLWjc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 12 Dec 2019 17:39:32 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Dec 2019 14:39:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,307,1571727600"; 
   d="scan'208";a="220787489"
Received: from gayuk-dev-mach.sc.intel.com ([10.3.79.172])
  by fmsmga001.fm.intel.com with ESMTP; 12 Dec 2019 14:39:32 -0800
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
Subject: [PATCH v1 3/4] platform/x86: intel-hid: Add new Tiger Lake hardware ID to support HID driver
Date:   Thu, 12 Dec 2019 14:37:19 -0800
Message-Id: <4354f2f0e3bdf24497c2791ac02dcbc659c4f076.1576189376.git.gayatri.kammela@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1576189376.git.gayatri.kammela@intel.com>
References: <cover.1576189376.git.gayatri.kammela@intel.com>
In-Reply-To: <cover.1576189376.git.gayatri.kammela@intel.com>
References: <cover.1576189376.git.gayatri.kammela@intel.com>
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
index ef6d4bd77b1a..3ce423c11a88 100644
--- a/drivers/platform/x86/intel-hid.c
+++ b/drivers/platform/x86/intel-hid.c
@@ -20,6 +20,7 @@ MODULE_AUTHOR("Alex Hung");
 
 static const struct acpi_device_id intel_hid_ids[] = {
 	{"INT33D5", 0},
+	{"INT1051", 0},
 	{"", 0},
 };
 
-- 
2.17.1

