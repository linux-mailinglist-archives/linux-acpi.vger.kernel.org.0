Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C64262A35B4
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Nov 2020 22:01:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbgKBVAn (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 2 Nov 2020 16:00:43 -0500
Received: from mga07.intel.com ([134.134.136.100]:25781 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726392AbgKBVA3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 2 Nov 2020 16:00:29 -0500
IronPort-SDR: Sdn5DtlSGsZrvAHR6NIgr0aj+KiZukDZandxJO0hW1YOLpymdI7S4V90n77FNMwt/EmIKqU5BC
 DEPQ5ndeY0GA==
X-IronPort-AV: E=McAfee;i="6000,8403,9793"; a="233120541"
X-IronPort-AV: E=Sophos;i="5.77,445,1596524400"; 
   d="scan'208";a="233120541"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2020 13:00:28 -0800
IronPort-SDR: vS8xqHfsrKqzXlMcO8TTympxFHvz47n5wdMNdurV9Cr8dn8P4g9bc92+N2GvEBvDhD/Sjx8ZUW
 Ag04ouSDt+CA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,445,1596524400"; 
   d="scan'208";a="362734814"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 02 Nov 2020 13:00:26 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id C537E15C; Mon,  2 Nov 2020 23:00:25 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-acpi@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH v4 2/6] resource: Group resource_overlaps() with other inline helpers
Date:   Mon,  2 Nov 2020 23:00:21 +0200
Message-Id: <20201102210025.53520-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201102210025.53520-1-andriy.shevchenko@linux.intel.com>
References: <20201102210025.53520-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

For better maintenance group resource_overlaps() with other inline helpers.
While at it, drop extra parentheses.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
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

