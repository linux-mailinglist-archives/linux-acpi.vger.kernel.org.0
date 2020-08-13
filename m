Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7673A243E8F
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Aug 2020 19:57:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbgHMR5g (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 13 Aug 2020 13:57:36 -0400
Received: from mga12.intel.com ([192.55.52.136]:7942 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726174AbgHMR5e (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 13 Aug 2020 13:57:34 -0400
IronPort-SDR: RPfRPBNX0PC5UkwRcmbLLvimjPDwnDD5Elystl3N/JbYUWm9o4gE6shoXJ+GHKYhQB/1l/mJYH
 lLOjnMh/aqsg==
X-IronPort-AV: E=McAfee;i="6000,8403,9712"; a="133815483"
X-IronPort-AV: E=Sophos;i="5.76,309,1592895600"; 
   d="scan'208";a="133815483"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2020 10:57:34 -0700
IronPort-SDR: xoa7E9yiKkM7cB256GgJK+Ha8N8dc2ik5Djyjpt3WFPQODOuUDAaA1MXqWy2+kKe4WKBLe6cVI
 v+WUo0Q4iw6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,309,1592895600"; 
   d="scan'208";a="495474442"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 13 Aug 2020 10:57:33 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 83DFE411; Thu, 13 Aug 2020 20:57:30 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH v1 7/7] ACPI: watchdog: Replace open coded variant of resource_union()
Date:   Thu, 13 Aug 2020 20:57:29 +0300
Message-Id: <20200813175729.15088-7-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200813175729.15088-1-andriy.shevchenko@linux.intel.com>
References: <20200813175729.15088-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Since we have resource_union() helper, let's utilize it here.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/acpi/acpi_watchdog.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/acpi/acpi_watchdog.c b/drivers/acpi/acpi_watchdog.c
index 5c1e9ea43123..ca28183f4d13 100644
--- a/drivers/acpi/acpi_watchdog.c
+++ b/drivers/acpi/acpi_watchdog.c
@@ -151,11 +151,7 @@ void __init acpi_watchdog_init(void)
 		found = false;
 		resource_list_for_each_entry(rentry, &resource_list) {
 			if (rentry->res->flags == res.flags &&
-			    resource_overlaps(rentry->res, &res)) {
-				if (res.start < rentry->res->start)
-					rentry->res->start = res.start;
-				if (res.end > rentry->res->end)
-					rentry->res->end = res.end;
+			    resource_union(rentry->res, &res, rentry->res)) {
 				found = true;
 				break;
 			}
-- 
2.28.0

