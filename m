Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83C4A2A35A8
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Nov 2020 22:00:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726020AbgKBVA2 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 2 Nov 2020 16:00:28 -0500
Received: from mga11.intel.com ([192.55.52.93]:8786 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725833AbgKBVA2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 2 Nov 2020 16:00:28 -0500
IronPort-SDR: wsbWtstLOXIsb/9eK2/qbFyOW4dMBISPZmP1Z1wCCPLCMFWihMltnj/UcxWBlhf2uErGuC480e
 BjElN+l495kg==
X-IronPort-AV: E=McAfee;i="6000,8403,9793"; a="165447779"
X-IronPort-AV: E=Sophos;i="5.77,445,1596524400"; 
   d="scan'208";a="165447779"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2020 13:00:28 -0800
IronPort-SDR: gQDYPevJNS+SGJ8mq5x5nTjbq+NHjMkijqCS9Bf8bisOr63vpCkwqIafRc2tulGA8LnDm9UhSw
 RP8CKe+y3iLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,445,1596524400"; 
   d="scan'208";a="528149404"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 02 Nov 2020 13:00:26 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id DC8691F5; Mon,  2 Nov 2020 23:00:25 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-acpi@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH v4 4/6] resource: Introduce resource_intersection() for overlapping resources
Date:   Mon,  2 Nov 2020 23:00:23 +0200
Message-Id: <20201102210025.53520-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201102210025.53520-1-andriy.shevchenko@linux.intel.com>
References: <20201102210025.53520-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

There will be at least one user that can utilize new helper.
Provide the helper for future user and for wider use.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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

