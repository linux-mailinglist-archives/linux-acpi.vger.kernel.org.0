Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 155A63AA209
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Jun 2021 19:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231207AbhFPRFt (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 16 Jun 2021 13:05:49 -0400
Received: from mga02.intel.com ([134.134.136.20]:16774 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230437AbhFPRFn (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 16 Jun 2021 13:05:43 -0400
IronPort-SDR: 8/mvV6td6JXY8OBcDGCsgBK2M0kqdJuq7fcZtWgyruD+1SOvYl0EHO2sDEw3sPjHrm+13dAonq
 FwwvwsY1JN2g==
X-IronPort-AV: E=McAfee;i="6200,9189,10016"; a="193340170"
X-IronPort-AV: E=Sophos;i="5.83,278,1616482800"; 
   d="scan'208";a="193340170"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2021 10:03:34 -0700
IronPort-SDR: 5mpxZZ83PgRKTg1E5w3hlsFbLkQjxMEmtZbAhtpuso5B+naWrqyYgNyNJPgTyIEg6x1RHy8PH0
 7k17hrxztmdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,278,1616482800"; 
   d="scan'208";a="404638841"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 16 Jun 2021 10:03:30 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 354D6431; Wed, 16 Jun 2021 20:03:54 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Subject: [PATCH v1 3/7] ACPI: sysfs: Unify pattern of memory allocations
Date:   Wed, 16 Jun 2021 20:03:34 +0300
Message-Id: <20210616170338.23057-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210616170338.23057-1-andriy.shevchenko@linux.intel.com>
References: <20210616170338.23057-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Use the form of foo = kmalloc(sizeof(*foo)) everywhere in order to
unify pattern of memory allocations.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/acpi/sysfs.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/sysfs.c b/drivers/acpi/sysfs.c
index 44e50c36e70a..efb8c2dfa9cb 100644
--- a/drivers/acpi/sysfs.c
+++ b/drivers/acpi/sysfs.c
@@ -388,8 +388,7 @@ acpi_status acpi_sysfs_table_handler(u32 event, void *table, void *context)
 
 	switch (event) {
 	case ACPI_TABLE_EVENT_INSTALL:
-		table_attr =
-		    kzalloc(sizeof(struct acpi_table_attr), GFP_KERNEL);
+		table_attr = kzalloc(sizeof(*table_attr), GFP_KERNEL);
 		if (!table_attr)
 			return AE_NO_MEMORY;
 
@@ -846,13 +845,11 @@ void acpi_irq_stats_init(void)
 	num_gpes = acpi_current_gpe_count;
 	num_counters = num_gpes + ACPI_NUM_FIXED_EVENTS + NUM_COUNTERS_EXTRA;
 
-	all_attrs = kcalloc(num_counters + 1, sizeof(struct attribute *),
-			    GFP_KERNEL);
+	all_attrs = kcalloc(num_counters + 1, sizeof(*all_attrs), GFP_KERNEL);
 	if (all_attrs == NULL)
 		return;
 
-	all_counters = kcalloc(num_counters, sizeof(struct event_counter),
-			       GFP_KERNEL);
+	all_counters = kcalloc(num_counters, sizeof(*all_counters), GFP_KERNEL);
 	if (all_counters == NULL)
 		goto fail;
 
@@ -860,8 +857,7 @@ void acpi_irq_stats_init(void)
 	if (ACPI_FAILURE(status))
 		goto fail;
 
-	counter_attrs = kcalloc(num_counters, sizeof(struct kobj_attribute),
-				GFP_KERNEL);
+	counter_attrs = kcalloc(num_counters, sizeof(*counter_attrs), GFP_KERNEL);
 	if (counter_attrs == NULL)
 		goto fail;
 
-- 
2.30.2

