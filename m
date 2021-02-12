Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2F2931A065
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Feb 2021 15:14:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231904AbhBLON2 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 12 Feb 2021 09:13:28 -0500
Received: from mga14.intel.com ([192.55.52.115]:4382 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231750AbhBLONY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 12 Feb 2021 09:13:24 -0500
IronPort-SDR: RtZfwxiB4cyNtQBKV0LyoI7HJthurOn7kxeGcqKK1JQbRqz6gtmJy5E12ik7min4COTLnJ4IbP
 kSooBpqpWKig==
X-IronPort-AV: E=McAfee;i="6000,8403,9892"; a="181641294"
X-IronPort-AV: E=Sophos;i="5.81,173,1610438400"; 
   d="scan'208";a="181641294"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2021 06:11:36 -0800
IronPort-SDR: fdZi9Is9zDoFuvVACcYLLsXuyWGUu1DQvaboUa5Qdf4UKezz2IOrraZ8A9G/PO7Q2lkWmBCyAY
 TOK6teBi/klQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,173,1610438400"; 
   d="scan'208";a="490978163"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 12 Feb 2021 06:11:35 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id A93D435E; Fri, 12 Feb 2021 16:11:34 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Subject: [PATCH v2 4/5] ACPI: property: Satisfy kernel doc validator (part 2)
Date:   Fri, 12 Feb 2021 16:11:20 +0200
Message-Id: <20210212141121.62115-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210212141121.62115-1-andriy.shevchenko@linux.intel.com>
References: <20210212141121.62115-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

CHECK   drivers/acpi/property.c
 warning: Function parameter or member '__fwnode' not described in 'acpi_graph_get_remote_endpoint'
 warning: Excess function parameter 'fwnode' description in 'acpi_graph_get_remote_endpoint'
 warning: Excess function parameter 'endpoint' description in 'acpi_graph_get_remote_endpoint'

Fixes: 0ef7478639c5 ("ACPI: property: Make the ACPI graph API private")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/acpi/property.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index ab4d7c734b0d..e312ebaed8db 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -1212,8 +1212,7 @@ static struct fwnode_handle *acpi_graph_get_child_prop_value(
 
 /**
  * acpi_graph_get_remote_endpoint - Parses and returns remote end of an endpoint
- * @fwnode: Endpoint firmware node pointing to a remote device
- * @endpoint: Firmware node of remote endpoint is filled here if not %NULL
+ * @__fwnode: Endpoint firmware node pointing to a remote device
  *
  * Returns the remote endpoint corresponding to @__fwnode. NULL on error.
  */
-- 
2.30.0

