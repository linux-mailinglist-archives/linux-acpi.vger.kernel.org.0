Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACC972A0C5E
	for <lists+linux-acpi@lfdr.de>; Fri, 30 Oct 2020 18:26:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbgJ3R0I (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 30 Oct 2020 13:26:08 -0400
Received: from mga01.intel.com ([192.55.52.88]:15562 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726674AbgJ3R0G (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 30 Oct 2020 13:26:06 -0400
IronPort-SDR: ZyMLDwfreBVyQ3i4xHsTGNoEt9MV9xqm7oyPN5/84MhsvRZxQSpTxT5noK8ZOMB8KiyTM5oakk
 MCaL1GwHF3Ow==
X-IronPort-AV: E=McAfee;i="6000,8403,9790"; a="186450273"
X-IronPort-AV: E=Sophos;i="5.77,434,1596524400"; 
   d="scan'208";a="186450273"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2020 10:26:05 -0700
IronPort-SDR: ZRfz/0t7Q76nTYzAiLW9NFgM31rMLPUU0W9C5gcRjF9sezjcfEl7M3Ghu7bvhEaxNsbYjbSj2d
 mmD4DDNP0ZMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,434,1596524400"; 
   d="scan'208";a="351935840"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 30 Oct 2020 10:26:04 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 639FB3CB; Fri, 30 Oct 2020 19:26:03 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v3 2/6] resource: Group resource_overlaps() with other inline helpers
Date:   Fri, 30 Oct 2020 19:25:52 +0200
Message-Id: <20201030172556.21686-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201030172556.21686-1-andriy.shevchenko@linux.intel.com>
References: <20201030172556.21686-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

For better maintenance group resource_overlaps() with other inline helpers.
While at it, drop extra parentheses.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/ioport.h | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/include/linux/ioport.h b/include/linux/ioport.h
index 5135d4b86cd6..df4581107536 100644
--- a/include/linux/ioport.h
+++ b/include/linux/ioport.h
@@ -229,6 +229,11 @@ static inline bool resource_contains(struct resource *r1, struct resource *r2)
 	return r1->start <= r2->start && r1->end >= r2->end;
 }
 
+/* True if any part of r1 overlaps r2 */
+static inline bool resource_overlaps(struct resource *r1, struct resource *r2)
+{
+       return r1->start <= r2->end && r1->end >= r2->start;
+}
 
 /* Convenience shorthand with allocation */
 #define request_region(start,n,name)		__request_region(&ioport_resource, (start), (n), (name), 0)
@@ -296,12 +301,6 @@ extern int
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

