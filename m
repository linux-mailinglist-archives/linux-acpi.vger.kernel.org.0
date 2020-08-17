Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66740246CF6
	for <lists+linux-acpi@lfdr.de>; Mon, 17 Aug 2020 18:38:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388847AbgHQQiD (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 17 Aug 2020 12:38:03 -0400
Received: from mga11.intel.com ([192.55.52.93]:33118 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731212AbgHQQhP (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 17 Aug 2020 12:37:15 -0400
IronPort-SDR: 4rqTdCYmMbAFQM9nC3KDgm6wQoHu5HiIhZfakyPPvfsgrtotPBgg0U7RVrTDUT4ZlFmsLlg8h1
 gFcZXlqrVrVA==
X-IronPort-AV: E=McAfee;i="6000,8403,9716"; a="152384833"
X-IronPort-AV: E=Sophos;i="5.76,324,1592895600"; 
   d="scan'208";a="152384833"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2020 09:36:52 -0700
IronPort-SDR: 6B84GQZZDmQsQbfxOHVj8n4Yz9idpXy12F6Hy7YJvRdrQFvDlowwYcuIhI8weEl6kZY1ZL9rBf
 iGUpFh8h/qSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,324,1592895600"; 
   d="scan'208";a="497066758"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 17 Aug 2020 09:36:48 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id DC1291C5; Mon, 17 Aug 2020 19:36:47 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 5/8] resource: Introduce resource_intersection() for overlapping resources
Date:   Mon, 17 Aug 2020 19:36:44 +0300
Message-Id: <20200817163647.48982-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817163647.48982-1-andriy.shevchenko@linux.intel.com>
References: <20200817163647.48982-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

There will be at least one user that can utilize new helper.
Provide the helper for future user and for wider use.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: reused min/max (Rafael)
 include/linux/ioport.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/ioport.h b/include/linux/ioport.h
index a7d50b9a3406..b4c3ca229f66 100644
--- a/include/linux/ioport.h
+++ b/include/linux/ioport.h
@@ -233,6 +233,16 @@ static inline bool resource_overlaps(struct resource *r1, struct resource *r2)
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

