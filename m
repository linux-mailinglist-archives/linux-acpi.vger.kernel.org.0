Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F45FBD2D0
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Sep 2019 21:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437158AbfIXThr (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 24 Sep 2019 15:37:47 -0400
Received: from mga14.intel.com ([192.55.52.115]:27981 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437287AbfIXThq (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 24 Sep 2019 15:37:46 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Sep 2019 12:37:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,545,1559545200"; 
   d="scan'208";a="201009978"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 24 Sep 2019 12:37:43 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id B5A22E3; Tue, 24 Sep 2019 22:37:42 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-acpi@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 1/6] ACPI / utils: Describe function parameters in kernel-doc
Date:   Tue, 24 Sep 2019 22:37:34 +0300
Message-Id: <20190924193739.86133-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190924193739.86133-1-andriy.shevchenko@linux.intel.com>
References: <20190924193739.86133-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Kernel documentation script complains that some of the function parameters
are not described:

drivers/acpi/utils.c:462: warning: Function parameter or member 'handle' not described in 'acpi_handle_path'
drivers/acpi/utils.c:484: warning: Function parameter or member 'level' not described in 'acpi_handle_printk'
drivers/acpi/utils.c:484: warning: Function parameter or member 'handle' not described in 'acpi_handle_printk'
drivers/acpi/utils.c:484: warning: Function parameter or member 'fmt' not described in 'acpi_handle_printk'
drivers/acpi/utils.c:513: warning: Function parameter or member 'descriptor' not described in '__acpi_handle_debug'
drivers/acpi/utils.c:513: warning: Function parameter or member 'handle' not described in '__acpi_handle_debug'
drivers/acpi/utils.c:513: warning: Function parameter or member 'fmt' not described in '__acpi_handle_debug'

Describe function parameters where it's appropriate.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/acpi/utils.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/acpi/utils.c b/drivers/acpi/utils.c
index e3974a8f8fd4..dbd1c4cfd7d1 100644
--- a/drivers/acpi/utils.c
+++ b/drivers/acpi/utils.c
@@ -455,6 +455,7 @@ EXPORT_SYMBOL(acpi_evaluate_ost);
 
 /**
  * acpi_handle_path: Return the object path of handle
+ * @handle: ACPI device handle
  *
  * Caller must free the returned buffer
  */
@@ -473,6 +474,9 @@ static char *acpi_handle_path(acpi_handle handle)
 
 /**
  * acpi_handle_printk: Print message with ACPI prefix and object path
+ * @level: log level
+ * @handle: ACPI device handle
+ * @fmt: format string
  *
  * This function is called through acpi_handle_<level> macros and prints
  * a message with ACPI prefix and object path.  This function acquires
@@ -501,6 +505,9 @@ EXPORT_SYMBOL(acpi_handle_printk);
 #if defined(CONFIG_DYNAMIC_DEBUG)
 /**
  * __acpi_handle_debug: pr_debug with ACPI prefix and object path
+ * @descriptor: Dynamic Debug descriptor
+ * @handle: ACPI device handle
+ * @fmt: format string
  *
  * This function is called through acpi_handle_debug macro and debug
  * prints a message with ACPI prefix and object path. This function
-- 
2.23.0

