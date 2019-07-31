Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E617D7C411
	for <lists+linux-acpi@lfdr.de>; Wed, 31 Jul 2019 15:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727512AbfGaNxJ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 31 Jul 2019 09:53:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:20003 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726592AbfGaNxI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 31 Jul 2019 09:53:08 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CCEAB3079B62;
        Wed, 31 Jul 2019 13:53:08 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-117-240.ams2.redhat.com [10.36.117.240])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2C5081001959;
        Wed, 31 Jul 2019 13:53:07 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-acpi@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v1] drivers/acpi/scan.c: Document why we don't need the device_hotplug_lock
Date:   Wed, 31 Jul 2019 15:53:06 +0200
Message-Id: <20190731135306.31524-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Wed, 31 Jul 2019 13:53:08 +0000 (UTC)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Let's document why the lock is not needed in acpi_scan_init(), right now
this is not really obvious.

Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---

@Andrew, can you drop "drivers/acpi/scan.c: acquire device_hotplug_lock in
acpi_scan_init()" and add this patch instead? Thanks

---
 drivers/acpi/scan.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 0e28270b0fd8..8444af6cd514 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -2204,6 +2204,12 @@ int __init acpi_scan_init(void)
 	acpi_gpe_apply_masked_gpes();
 	acpi_update_all_gpes();
 
+	/*
+	 * Although we call__add_memory() that is documented to require the
+	 * device_hotplug_lock, it is not necessary here because this is an
+	 * early code when userspace or any other code path cannot trigger
+	 * hotplug/hotunplug operations.
+	 */
 	mutex_lock(&acpi_scan_lock);
 	/*
 	 * Enumerate devices in the ACPI namespace.
-- 
2.21.0

