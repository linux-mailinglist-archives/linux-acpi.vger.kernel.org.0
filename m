Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD762A0C61
	for <lists+linux-acpi@lfdr.de>; Fri, 30 Oct 2020 18:26:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbgJ3R0J (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 30 Oct 2020 13:26:09 -0400
Received: from mga05.intel.com ([192.55.52.43]:12895 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726860AbgJ3R0I (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 30 Oct 2020 13:26:08 -0400
IronPort-SDR: lnae59p5d2hxlTs+cmOnTh4MQaeYCdvjsQuP3HyvpwOEeKuMpH9OsSVze6KICG4qx04tMtEhy7
 UsRPq0UeupbA==
X-IronPort-AV: E=McAfee;i="6000,8403,9790"; a="253346914"
X-IronPort-AV: E=Sophos;i="5.77,434,1596524400"; 
   d="scan'208";a="253346914"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2020 10:26:08 -0700
IronPort-SDR: TW7n57B/MhdQtA3Ryo4oqesPvn7yu1B2kFKdLo/ypy26wji5PRg1wqeM4s3g6pqM7+aPR0qNXy
 YBMPhQw0zJag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,434,1596524400"; 
   d="scan'208";a="362506798"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 30 Oct 2020 10:26:06 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 9B81C638; Fri, 30 Oct 2020 19:26:03 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH v3 6/6] ACPI: watchdog: Replace open coded variant of resource_union()
Date:   Fri, 30 Oct 2020 19:25:56 +0200
Message-Id: <20201030172556.21686-7-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201030172556.21686-1-andriy.shevchenko@linux.intel.com>
References: <20201030172556.21686-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Since we have resource_union() helper, let's utilize it here.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
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

