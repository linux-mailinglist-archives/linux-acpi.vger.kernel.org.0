Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2C4D246D26
	for <lists+linux-acpi@lfdr.de>; Mon, 17 Aug 2020 18:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387831AbgHQQr2 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 17 Aug 2020 12:47:28 -0400
Received: from mga06.intel.com ([134.134.136.31]:23599 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387578AbgHQQhy (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 17 Aug 2020 12:37:54 -0400
IronPort-SDR: TSTaWgNNzjVjCbAx8RsB+VT3baOlNvr6FVaPOfvteo3D0IvN0E6/FgWOUQNK+sw5jr6ztvC5W4
 HxuxbTt3x1+A==
X-IronPort-AV: E=McAfee;i="6000,8403,9716"; a="216269424"
X-IronPort-AV: E=Sophos;i="5.76,324,1592895600"; 
   d="scan'208";a="216269424"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2020 09:36:52 -0700
IronPort-SDR: jdE0bG+pSW6xLQQvICjklQJiEH9wHHr8evgnSKpVphavdaWgiKzCyKxkYnkHv1l6ZuW1nTEbYf
 g6muUiuwVvrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,324,1592895600"; 
   d="scan'208";a="328677919"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 17 Aug 2020 09:36:50 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 0AD0546E; Mon, 17 Aug 2020 19:36:48 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH v2 8/8] ACPI: watchdog: Replace open coded variant of resource_union()
Date:   Mon, 17 Aug 2020 19:36:47 +0300
Message-Id: <20200817163647.48982-8-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817163647.48982-1-andriy.shevchenko@linux.intel.com>
References: <20200817163647.48982-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Since we have resource_union() helper, let's utilize it here.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
v2: added Rb tag (Rafael)
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

