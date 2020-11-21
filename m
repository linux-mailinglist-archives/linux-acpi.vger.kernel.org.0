Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AB692BC213
	for <lists+linux-acpi@lfdr.de>; Sat, 21 Nov 2020 21:32:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728511AbgKUUa6 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 21 Nov 2020 15:30:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29978 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728513AbgKUUa6 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Sat, 21 Nov 2020 15:30:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605990657;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dyjf7FFerAvyZSPO4iKB95U5xXwVD361EL2BnSebQWM=;
        b=d/+14aWHyBq2YdTSvFxfOuhuWLxrAvwPN0Xpbvyk01pdYbQmRLuVO+bGwZdMZTvjrbgOnn
        ljU+1Q/CyFaSWLPFU+r743+hxTO3cY3ezYt0m3sck7f+Qzm5b8fkZVmiWocoNKYREgsmu4
        SFJgHoTjyCqVm81AeWkQTPkmBVnM0lk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-21-ihjPTvcUNcyREoSM24Jdlg-1; Sat, 21 Nov 2020 15:30:53 -0500
X-MC-Unique: ihjPTvcUNcyREoSM24Jdlg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 094CF1005D6B;
        Sat, 21 Nov 2020 20:30:52 +0000 (UTC)
Received: from x1.localdomain (ovpn-112-24.ams2.redhat.com [10.36.112.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1734318E4F;
        Sat, 21 Nov 2020 20:30:50 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org
Subject: [PATCH 6/7] ACPI: scan: Fix battery devices not working with acpi.defer_scan_based_on_dep=1
Date:   Sat, 21 Nov 2020 21:30:39 +0100
Message-Id: <20201121203040.146252-7-hdegoede@redhat.com>
In-Reply-To: <20201121203040.146252-1-hdegoede@redhat.com>
References: <20201121203040.146252-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

When battery devices get added during the second step of the now 2 step
scan-process, then acpi_walk_dep_device_list() may have already been
called for some deps during the first step.

In this case acpi_device_dep_initialize() should not add these deps to
the acpi_dep_list; and it should not increase adev->dep_unmet.

Add a check for already registered (and bound to a driver) devices to
acpi_device_dep_initialize(). This fixes battery devices (which honor the
dep_unmet value) not working with acpi.defer_scan_based_on_dep=1.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/scan.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 9927036bfe77..44001610f6a4 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -17,6 +17,8 @@
 #include <linux/platform_data/x86/apple.h>
 #include <linux/pgtable.h>
 
+#include "acpica/accommon.h"
+#include "acpica/acnamesp.h"
 #include "internal.h"
 
 #define _COMPONENT		ACPI_BUS_COMPONENT
@@ -1935,7 +1937,10 @@ static void acpi_device_dep_initialize(struct acpi_device *adev)
 	}
 
 	for (i = 0; i < dep_devices.count; i++) {
+		struct acpi_device *dep_adev = NULL;
+		struct acpi_namespace_node *node;
 		struct acpi_device_info *info;
+		struct device *dep_dev;
 		int skip;
 
 		status = acpi_get_object_info(dep_devices.handles[i], &info);
@@ -1950,6 +1955,30 @@ static void acpi_device_dep_initialize(struct acpi_device *adev)
 		if (skip)
 			continue;
 
+		/*
+		 * Skip devices which already have a driver bound
+		 * and thus are already available for use.
+		 * We only need to do this during the second scan step,
+		 * when acpi_check_defer_add == false.
+		 */
+		if (!acpi_check_defer_add) {
+			/*
+			 * Cannot call acpi_bus_get_device here as we are called
+			 * with ACPI_MTX_NAMESPACE held.
+			 */
+			node = acpi_ns_validate_handle(dep_devices.handles[i]);
+			if (!node)
+				continue; /* Should never happen */
+
+			status = acpi_ns_get_attached_data(node, acpi_scan_drop_device,
+							   (void **)&dep_adev);
+			if (ACPI_SUCCESS(status) && dep_adev) {
+				dep_dev = acpi_get_first_physical_node(dep_adev);
+				if (dep_dev && dep_dev->driver)
+					continue;
+			}
+		}
+
 		dep = kzalloc(sizeof(struct acpi_dep_data), GFP_KERNEL);
 		if (!dep)
 			return;
-- 
2.28.0

