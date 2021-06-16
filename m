Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE04D3AA200
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Jun 2021 19:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbhFPRFl (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 16 Jun 2021 13:05:41 -0400
Received: from mga17.intel.com ([192.55.52.151]:36038 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230083AbhFPRFl (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 16 Jun 2021 13:05:41 -0400
IronPort-SDR: Ue6br+JenzEDpsF/bDzszt7OYmC/bql69gBygdJrJpcv7fEL8pZWjREN6yUzPTbmKc2ZZnNBgN
 63NiF38n5B5Q==
X-IronPort-AV: E=McAfee;i="6200,9189,10016"; a="186595887"
X-IronPort-AV: E=Sophos;i="5.83,278,1616482800"; 
   d="scan'208";a="186595887"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2021 10:03:32 -0700
IronPort-SDR: 3MBqYwvAMaTb3vMfR2V0+pqHDukKnKrJl+zaQYzza/0CZ00jJJ82fMHaVZ6bekW9mm9Ex3romh
 MoBp43QogE9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,278,1616482800"; 
   d="scan'208";a="640070353"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 16 Jun 2021 10:03:30 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 5761C580; Wed, 16 Jun 2021 20:03:54 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Subject: [PATCH v1 6/7] ACPI: sysfs: Remove tailing return statement in void functions
Date:   Wed, 16 Jun 2021 20:03:37 +0300
Message-Id: <20210616170338.23057-6-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210616170338.23057-1-andriy.shevchenko@linux.intel.com>
References: <20210616170338.23057-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The tail return statement is redundant in void functions. Remove it.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/acpi/sysfs.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/acpi/sysfs.c b/drivers/acpi/sysfs.c
index 231aaa8b6c2c..5474563d72b8 100644
--- a/drivers/acpi/sysfs.c
+++ b/drivers/acpi/sysfs.c
@@ -577,8 +577,6 @@ static void delete_gpe_attr_array(void)
 		kfree(counter_attrs);
 	}
 	kfree(all_attrs);
-
-	return;
 }
 
 static void gpe_count(u32 gpe_number)
@@ -593,8 +591,6 @@ static void gpe_count(u32 gpe_number)
 	else
 		all_counters[num_gpes + ACPI_NUM_FIXED_EVENTS +
 			     COUNT_ERROR].count++;
-
-	return;
 }
 
 static void fixed_event_count(u32 event_number)
@@ -607,8 +603,6 @@ static void fixed_event_count(u32 event_number)
 	else
 		all_counters[num_gpes + ACPI_NUM_FIXED_EVENTS +
 			     COUNT_ERROR].count++;
-
-	return;
 }
 
 static void acpi_global_event_handler(u32 event_type, acpi_handle device,
@@ -903,7 +897,6 @@ void acpi_irq_stats_init(void)
 
 fail:
 	delete_gpe_attr_array();
-	return;
 }
 
 static void __exit interrupt_stats_exit(void)
@@ -911,8 +904,6 @@ static void __exit interrupt_stats_exit(void)
 	sysfs_remove_group(acpi_kobj, &interrupt_stats_attr_group);
 
 	delete_gpe_attr_array();
-
-	return;
 }
 
 static ssize_t pm_profile_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
-- 
2.30.2

