Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A23CE2A58CB
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Nov 2020 22:55:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731557AbgKCVy4 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 3 Nov 2020 16:54:56 -0500
Received: from mga02.intel.com ([134.134.136.20]:3847 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730978AbgKCUpO (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 3 Nov 2020 15:45:14 -0500
IronPort-SDR: wBjM/IAle7pJc8aBkjxK4hz6pseF944dSxpfqW5lZHD4w5lB+2OG4TohT32DLlrmfihIrDvowU
 MFgwuwiNXbYw==
X-IronPort-AV: E=McAfee;i="6000,8403,9794"; a="156110736"
X-IronPort-AV: E=Sophos;i="5.77,448,1596524400"; 
   d="scan'208";a="156110736"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2020 12:45:13 -0800
IronPort-SDR: Nne6t/swK0df5+2pckCVT1Tlndv1PIN1jkIH2VFhgj0d+odQPT7EWIuwU+DQhTS9Ub4gmaBpDl
 EdxvcNgKc+DA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,448,1596524400"; 
   d="scan'208";a="426459436"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 03 Nov 2020 12:45:11 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id CC6FF14B; Tue,  3 Nov 2020 22:45:10 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-acpi@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH v6 2/7] resource: Group resource_overlaps() with other inline helpers
Date:   Tue,  3 Nov 2020 22:45:05 +0200
Message-Id: <20201103204510.19154-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201103204510.19154-1-andriy.shevchenko@linux.intel.com>
References: <20201103204510.19154-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

For better maintenance group resource_overlaps() with other inline helpers.
While at it, drop extra parentheses.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Hanjun Guo <guohanjun@huawei.com>
Tested-by: Hanjun Guo <guohanjun@huawei.com>
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

