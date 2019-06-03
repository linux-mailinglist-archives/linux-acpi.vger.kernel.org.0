Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E0673341D
	for <lists+linux-acpi@lfdr.de>; Mon,  3 Jun 2019 17:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729296AbfFCPvj (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 3 Jun 2019 11:51:39 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:53778 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729282AbfFCPvh (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 3 Jun 2019 11:51:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1FE811A25;
        Mon,  3 Jun 2019 08:51:37 -0700 (PDT)
Received: from en101.cambridge.arm.com (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BDC213F246;
        Mon,  3 Jun 2019 08:51:35 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        suzuki.poulose@arm.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Subject: [RFC PATCH 26/57] drivers: acpi: Clean up acpi_dev_match_cb
Date:   Mon,  3 Jun 2019 16:49:52 +0100
Message-Id: <1559577023-558-27-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1559577023-558-1-git-send-email-suzuki.poulose@arm.com>
References: <1559577023-558-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

acpi_dev_match_cb match function modifies the "data" argument
to pass on a result which could be easily deduced from the result
of the bus_find_device() call at the caller site. Clean this
up in preparation to convert the "match" argument for bus_find_device.

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/acpi/utils.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/acpi/utils.c b/drivers/acpi/utils.c
index 7def63a..1391b63 100644
--- a/drivers/acpi/utils.c
+++ b/drivers/acpi/utils.c
@@ -725,8 +725,6 @@ bool acpi_dev_found(const char *hid)
 EXPORT_SYMBOL(acpi_dev_found);
 
 struct acpi_dev_match_info {
-	const char *dev_name;
-	struct acpi_device *adev;
 	struct acpi_device_id hid[2];
 	const char *uid;
 	s64 hrv;
@@ -746,9 +744,6 @@ static int acpi_dev_match_cb(struct device *dev, void *data)
 	    strcmp(adev->pnp.unique_id, match->uid)))
 		return 0;
 
-	match->dev_name = acpi_dev_name(adev);
-	match->adev = adev;
-
 	if (match->hrv == -1)
 		return 1;
 
@@ -818,7 +813,7 @@ acpi_dev_get_first_match_dev(const char *hid, const char *uid, s64 hrv)
 	match.hrv = hrv;
 
 	dev = bus_find_device(&acpi_bus_type, NULL, &match, acpi_dev_match_cb);
-	return dev ? match.adev : NULL;
+	return dev ? to_acpi_device(dev) : NULL;
 }
 EXPORT_SYMBOL(acpi_dev_get_first_match_dev);
 
-- 
2.7.4

