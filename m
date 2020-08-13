Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4904E243E8D
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Aug 2020 19:57:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbgHMR5e (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 13 Aug 2020 13:57:34 -0400
Received: from mga03.intel.com ([134.134.136.65]:39968 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726174AbgHMR5d (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 13 Aug 2020 13:57:33 -0400
IronPort-SDR: TqGGyF+naqm5Vn+QdiDAXeyZsd3K4wZv8NCjzdDufYpx/Ln9UnuW4F20wzyMMaq6Eyjzoyltkt
 lBtg+8x0Sjew==
X-IronPort-AV: E=McAfee;i="6000,8403,9712"; a="154257234"
X-IronPort-AV: E=Sophos;i="5.76,309,1592895600"; 
   d="scan'208";a="154257234"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2020 10:57:32 -0700
IronPort-SDR: YMKk51Vgro667vDwnJ9Krrmqfc2347QxKDJgtaP0PVMR1NFDXL03nm7sxWlbPduZuNTaNty487
 C4GJNm2Cxc9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,309,1592895600"; 
   d="scan'208";a="495943934"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 13 Aug 2020 10:57:31 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 55815163; Thu, 13 Aug 2020 20:57:30 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 2/7] resource: Group resource_overlaps() with other inline helpers
Date:   Thu, 13 Aug 2020 20:57:24 +0300
Message-Id: <20200813175729.15088-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200813175729.15088-1-andriy.shevchenko@linux.intel.com>
References: <20200813175729.15088-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

For better maintenance group resource_overlaps() with other inline helpers.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/ioport.h | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/include/linux/ioport.h b/include/linux/ioport.h
index 6c2b06fe8beb..0193987b9968 100644
--- a/include/linux/ioport.h
+++ b/include/linux/ioport.h
@@ -226,6 +226,11 @@ static inline bool resource_contains(struct resource *r1, struct resource *r2)
 	return r1->start <= r2->start && r1->end >= r2->end;
 }
 
+/* True if any part of r1 overlaps r2 */
+static inline bool resource_overlaps(struct resource *r1, struct resource *r2)
+{
+       return (r1->start <= r2->end && r1->end >= r2->start);
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

