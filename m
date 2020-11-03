Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26BA82A58CC
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Nov 2020 22:55:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731670AbgKCVy5 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 3 Nov 2020 16:54:57 -0500
Received: from mga09.intel.com ([134.134.136.24]:6426 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730977AbgKCUpO (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 3 Nov 2020 15:45:14 -0500
IronPort-SDR: 7pj/4XkEfzeWdg7KYuOVTJ4IDsZDRPuTQ0IfVNjNHKZV+a/jqMJfAtiibtGco6uC/vwVHCUT75
 VRUmC/cg56cg==
X-IronPort-AV: E=McAfee;i="6000,8403,9794"; a="169259816"
X-IronPort-AV: E=Sophos;i="5.77,448,1596524400"; 
   d="scan'208";a="169259816"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2020 12:45:13 -0800
IronPort-SDR: SzOhlsCjMXhvOzb4ueUaFyBYNBQZt8i2BNuu7DBjgPm2mahRZOJvimtm5dprQy1eRiysMmOi7u
 KTQAKf2TwNeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,448,1596524400"; 
   d="scan'208";a="363163837"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 03 Nov 2020 12:45:11 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id E5BE115E; Tue,  3 Nov 2020 22:45:10 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-acpi@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH v6 4/7] resource: Introduce resource_intersection() for overlapping resources
Date:   Tue,  3 Nov 2020 22:45:07 +0200
Message-Id: <20201103204510.19154-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201103204510.19154-1-andriy.shevchenko@linux.intel.com>
References: <20201103204510.19154-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

There will be at least one user that can utilize new helper.
Provide the helper for future user and for wider use.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Hanjun Guo <guohanjun@huawei.com>
Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 include/linux/ioport.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/ioport.h b/include/linux/ioport.h
index 40320eb5bc0e..ece1a8db309c 100644
--- a/include/linux/ioport.h
+++ b/include/linux/ioport.h
@@ -236,6 +236,16 @@ static inline bool resource_overlaps(struct resource *r1, struct resource *r2)
        return r1->start <= r2->end && r1->end >= r2->start;
 }
 
+static inline bool
+resource_intersection(struct resource *r1, struct resource *r2, struct resource *r)
+{
+	if (!resource_overlaps(r1, r2))
+		return false;
+	r->start = max(r1->start, r2->start);
+	r->end = min(r1->end, r2->end);
+	return true;
+}
+
 static inline bool
 resource_union(struct resource *r1, struct resource *r2, struct resource *r)
 {
-- 
2.28.0

