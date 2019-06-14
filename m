Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 920C54666D
	for <lists+linux-acpi@lfdr.de>; Fri, 14 Jun 2019 19:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727179AbfFNRys (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 14 Jun 2019 13:54:48 -0400
Received: from foss.arm.com ([217.140.110.172]:39262 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727204AbfFNRyr (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 14 Jun 2019 13:54:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1A41D3EF;
        Fri, 14 Jun 2019 10:54:47 -0700 (PDT)
Received: from en101.cambridge.arm.com (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 327DB3F718;
        Fri, 14 Jun 2019 10:54:46 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        suzuki.poulose@arm.com, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org
Subject: [PATCH v2 03/28] acpi: utils: Cleanup acpi_dev_match_cb
Date:   Fri, 14 Jun 2019 18:53:58 +0100
Message-Id: <1560534863-15115-4-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1560534863-15115-1-git-send-email-suzuki.poulose@arm.com>
References: <1560534863-15115-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The prototype of bus_find_device() will be unified with that of
class_find_device() subsequently, but for this purpose the callback
functions passed to it need to take (const void *) as the second
argument.  Consequently, they cannot modify the memory pointed to by
that argument which currently is not the case for acpi_dev_match_cb().
However, acpi_dev_match_cb() really need not modify the "match" object
passed to it, because acpi_dev_get_first_match_dev() which uses it via
bus_find_device() can easily convert the result of bus_find_device()
into the pointer to return.

For this reason, update acpi_dev_match_cb() to avoid the redundant
memory updates.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
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

