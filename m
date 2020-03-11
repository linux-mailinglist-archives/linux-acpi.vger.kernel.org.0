Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C858181171
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Mar 2020 08:08:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbgCKHI5 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 11 Mar 2020 03:08:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:33012 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726672AbgCKHI5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 11 Mar 2020 03:08:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 9477FABDC;
        Wed, 11 Mar 2020 07:08:55 +0000 (UTC)
From:   Takashi Iwai <tiwai@suse.de>
To:     linux-acpi@vger.kernel.org
Cc:     Zhang Rui <rui.zhang@intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Subject: [PATCH] ACPI: fan: Use scnprintf() for avoiding potential buffer overflow
Date:   Wed, 11 Mar 2020 08:08:51 +0100
Message-Id: <20200311070851.3731-1-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Since snprintf() returns the would-be-output size instead of the
actual output size, the succeeding calls may go beyond the given
buffer limit.  Fix it by replacing with scnprintf().

Also adjust the argument to really match with the actually remaining
buffer size.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 drivers/acpi/fan.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/acpi/fan.c b/drivers/acpi/fan.c
index aaf4e8f348cf..873e039ad4b7 100644
--- a/drivers/acpi/fan.c
+++ b/drivers/acpi/fan.c
@@ -276,29 +276,29 @@ static ssize_t show_state(struct device *dev, struct device_attribute *attr, cha
 	int count;
 
 	if (fps->control == 0xFFFFFFFF || fps->control > 100)
-		count = snprintf(buf, PAGE_SIZE, "not-defined:");
+		count = scnprintf(buf, PAGE_SIZE, "not-defined:");
 	else
-		count = snprintf(buf, PAGE_SIZE, "%lld:", fps->control);
+		count = scnprintf(buf, PAGE_SIZE, "%lld:", fps->control);
 
 	if (fps->trip_point == 0xFFFFFFFF || fps->trip_point > 9)
-		count += snprintf(&buf[count], PAGE_SIZE, "not-defined:");
+		count += scnprintf(&buf[count], PAGE_SIZE - count, "not-defined:");
 	else
-		count += snprintf(&buf[count], PAGE_SIZE, "%lld:", fps->trip_point);
+		count += scnprintf(&buf[count], PAGE_SIZE - count, "%lld:", fps->trip_point);
 
 	if (fps->speed == 0xFFFFFFFF)
-		count += snprintf(&buf[count], PAGE_SIZE, "not-defined:");
+		count += scnprintf(&buf[count], PAGE_SIZE - count, "not-defined:");
 	else
-		count += snprintf(&buf[count], PAGE_SIZE, "%lld:", fps->speed);
+		count += scnprintf(&buf[count], PAGE_SIZE - count, "%lld:", fps->speed);
 
 	if (fps->noise_level == 0xFFFFFFFF)
-		count += snprintf(&buf[count], PAGE_SIZE, "not-defined:");
+		count += scnprintf(&buf[count], PAGE_SIZE - count, "not-defined:");
 	else
-		count += snprintf(&buf[count], PAGE_SIZE, "%lld:", fps->noise_level * 100);
+		count += scnprintf(&buf[count], PAGE_SIZE - count, "%lld:", fps->noise_level * 100);
 
 	if (fps->power == 0xFFFFFFFF)
-		count += snprintf(&buf[count], PAGE_SIZE, "not-defined\n");
+		count += scnprintf(&buf[count], PAGE_SIZE - count, "not-defined\n");
 	else
-		count += snprintf(&buf[count], PAGE_SIZE, "%lld\n", fps->power);
+		count += scnprintf(&buf[count], PAGE_SIZE - count, "%lld\n", fps->power);
 
 	return count;
 }
-- 
2.16.4

