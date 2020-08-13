Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FEAF243E8B
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Aug 2020 19:57:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726192AbgHMR5d (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 13 Aug 2020 13:57:33 -0400
Received: from mga12.intel.com ([192.55.52.136]:7942 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726167AbgHMR5d (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 13 Aug 2020 13:57:33 -0400
IronPort-SDR: ezOJPpHTdLrGnVkaaUJHpWqcFDzZSHGcSF2IvY8NyMHHCPSowe9NaOVYOzFaVLvqvE4NuZcY0K
 PNwcetBt7gXg==
X-IronPort-AV: E=McAfee;i="6000,8403,9712"; a="133815475"
X-IronPort-AV: E=Sophos;i="5.76,309,1592895600"; 
   d="scan'208";a="133815475"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2020 10:57:32 -0700
IronPort-SDR: 8SejSHGFkAMGV2hia6m0PHuYzTYxatw34lyB72LdUBimHJmhvJV4hcTZyTG3JZm3oxPEa/eHU5
 u1YAFycxiDVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,309,1592895600"; 
   d="scan'208";a="470308891"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 13 Aug 2020 10:57:31 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 6609536B; Thu, 13 Aug 2020 20:57:30 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 4/7] resource: Introduce resource_intersection() for overlapping resources
Date:   Thu, 13 Aug 2020 20:57:26 +0300
Message-Id: <20200813175729.15088-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200813175729.15088-1-andriy.shevchenko@linux.intel.com>
References: <20200813175729.15088-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

There will be at least one user that can utilize new helper.
Provide the helper for future user and for wider use.

Deliberately avoid min()/max() macro as they are still parts of
kernel.h which is quite a burden to be included here in order
to avoid circular dependencies.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/ioport.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/ioport.h b/include/linux/ioport.h
index c98df0ec7422..1d5ab2e7f9eb 100644
--- a/include/linux/ioport.h
+++ b/include/linux/ioport.h
@@ -232,6 +232,16 @@ static inline bool resource_overlaps(struct resource *r1, struct resource *r2)
        return (r1->start <= r2->end && r1->end >= r2->start);
 }
 
+static inline bool
+resource_intersection(struct resource *r1, struct resource *r2, struct resource *r)
+{
+	if (!resource_overlaps(r1, r2))
+		return false;
+	r->start = r1->start > r2->start ? r1->start : r2->start;
+	r->end = r1->end < r2->end ? r1->end : r2->end;
+	return true;
+}
+
 static inline bool
 resource_union(struct resource *r1, struct resource *r2, struct resource *r)
 {
-- 
2.28.0

