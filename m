Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 799B1243E94
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Aug 2020 19:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbgHMR5j (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 13 Aug 2020 13:57:39 -0400
Received: from mga01.intel.com ([192.55.52.88]:59185 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726174AbgHMR5h (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 13 Aug 2020 13:57:37 -0400
IronPort-SDR: UkzOc6y4E1e8l5s2gQYx8odCpcP50qwtNHvGEkD3iaa6Jva7VmQGYaQf0okeR7dq3UBWdlzWtX
 Gyy4Uy8omxbA==
X-IronPort-AV: E=McAfee;i="6000,8403,9712"; a="172337144"
X-IronPort-AV: E=Sophos;i="5.76,309,1592895600"; 
   d="scan'208";a="172337144"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2020 10:57:33 -0700
IronPort-SDR: 2uxO2NsFaBBl8UnqRQ3frtd2J8wYnbcBIczkZXRbjyHLznc7M/vxd4Snc6Lnzd1s4ccsKmhLsa
 aMbgVL9Qfb7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,309,1592895600"; 
   d="scan'208";a="278195282"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 13 Aug 2020 10:57:31 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 49CF2190; Thu, 13 Aug 2020 20:57:30 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/7] resource: Simplify region_intersects() by reducing conditionals
Date:   Thu, 13 Aug 2020 20:57:23 +0300
Message-Id: <20200813175729.15088-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Now we have for 'other' and 'type' variables

other	type	return
  0	  0	REGION_DISJOINT
  0	  x	REGION_INTERSECTS
  x	  0	REGION_DISJOINT
  x	  x	REGION_MIXED

Obviously it's easier to check 'type' for 0 first instead of
currently checked 'other'.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 kernel/resource.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/kernel/resource.c b/kernel/resource.c
index 841737bbda9e..70575a61bf20 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -554,13 +554,10 @@ int region_intersects(resource_size_t start, size_t size, unsigned long flags,
 	}
 	read_unlock(&resource_lock);
 
-	if (other == 0)
-		return type ? REGION_INTERSECTS : REGION_DISJOINT;
+	if (type == 0)
+		return REGION_DISJOINT;
 
-	if (type)
-		return REGION_MIXED;
-
-	return REGION_DISJOINT;
+	return (other == 0) ? REGION_INTERSECTS : REGION_MIXED;
 }
 EXPORT_SYMBOL_GPL(region_intersects);
 
-- 
2.28.0

