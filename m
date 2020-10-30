Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FB662A0C59
	for <lists+linux-acpi@lfdr.de>; Fri, 30 Oct 2020 18:26:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbgJ3R0G (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 30 Oct 2020 13:26:06 -0400
Received: from mga17.intel.com ([192.55.52.151]:49683 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726674AbgJ3R0F (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 30 Oct 2020 13:26:05 -0400
IronPort-SDR: qvAS1HWVHCwe0Vi/zWMjm/0nKqBPhtniyY4QsKZr3nth5c4tkbKmO0fDaGn4PD5Mw0WCMVzb7l
 Zg1n2hs84Lmw==
X-IronPort-AV: E=McAfee;i="6000,8403,9790"; a="148495147"
X-IronPort-AV: E=Sophos;i="5.77,434,1596524400"; 
   d="scan'208";a="148495147"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2020 10:26:05 -0700
IronPort-SDR: 2aKRZ8RWwsakl6D6tiif2Vyas9OK7CnbS1qYfuCYHDw1KVxy/6brKIsmRYaUmHMlnRbskOQY2q
 gtcFDyZO26EA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,434,1596524400"; 
   d="scan'208";a="356654231"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 30 Oct 2020 10:26:04 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 7F5604E1; Fri, 30 Oct 2020 19:26:03 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v3 4/6] resource: Introduce resource_intersection() for overlapping resources
Date:   Fri, 30 Oct 2020 19:25:54 +0200
Message-Id: <20201030172556.21686-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201030172556.21686-1-andriy.shevchenko@linux.intel.com>
References: <20201030172556.21686-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

There will be at least one user that can utilize new helper.
Provide the helper for future user and for wider use.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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

