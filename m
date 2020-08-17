Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DAB9246EAE
	for <lists+linux-acpi@lfdr.de>; Mon, 17 Aug 2020 19:34:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730990AbgHQReo (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 17 Aug 2020 13:34:44 -0400
Received: from mga06.intel.com ([134.134.136.31]:23599 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388836AbgHQQhF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 17 Aug 2020 12:37:05 -0400
IronPort-SDR: sBF6xmG1Wh2PjXyAt2mkZdqfIgdAJY2O3i/zWTrLlzkAbWsHNeENjhP6RIHtiV25BL1ktLe148
 SjzMO/8dXtLw==
X-IronPort-AV: E=McAfee;i="6000,8403,9716"; a="216269414"
X-IronPort-AV: E=Sophos;i="5.76,324,1592895600"; 
   d="scan'208";a="216269414"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2020 09:36:50 -0700
IronPort-SDR: 0a7X71AIyKEjGs9pxieGT1FrAULlRxfCVkdGBJlK7FinaXfsaDlBVEvF7A7IxLZCb3wBeAKHGX
 jdxO+LjN5VAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,324,1592895600"; 
   d="scan'208";a="496536716"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 17 Aug 2020 09:36:48 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id C95FE1A3; Mon, 17 Aug 2020 19:36:47 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 3/8] resource: Group resource_overlaps() with other inline helpers
Date:   Mon, 17 Aug 2020 19:36:42 +0300
Message-Id: <20200817163647.48982-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817163647.48982-1-andriy.shevchenko@linux.intel.com>
References: <20200817163647.48982-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

For better maintenance group resource_overlaps() with other inline helpers.
While at it, drop extra parentheses.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: dropped parentheses (Rafael)
 include/linux/ioport.h | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/include/linux/ioport.h b/include/linux/ioport.h
index 6c2b06fe8beb..50fed618d3fb 100644
--- a/include/linux/ioport.h
+++ b/include/linux/ioport.h
@@ -226,6 +226,11 @@ static inline bool resource_contains(struct resource *r1, struct resource *r2)
 	return r1->start <= r2->start && r1->end >= r2->end;
 }
 
+/* True if any part of r1 overlaps r2 */
+static inline bool resource_overlaps(struct resource *r1, struct resource *r2)
+{
+       return r1->start <= r2->end && r1->end >= r2->start;
+}
 
 /* Convenience shorthand with allocation */
 #define request_region(start,n,name)		__request_region(&ioport_resource, (start), (n), (name), 0)
@@ -291,12 +296,6 @@ extern int
 walk_iomem_res_desc(unsigned long desc, unsigned long flags, u64 start, u64 end,
 		    void *arg, int (*func)(struct resource *, void *));
 
-/* True if any part of r1 overlaps r2 */
-static inline bool resource_overlaps(struct resource *r1, struct resource *r2)
-{
-       return (r1->start <= r2->end && r1->end >= r2->start);
-}
-
 struct resource *devm_request_free_mem_region(struct device *dev,
 		struct resource *base, unsigned long size);
 struct resource *request_free_mem_region(struct resource *base,
-- 
2.28.0

