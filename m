Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C75D427B92
	for <lists+linux-acpi@lfdr.de>; Sat,  9 Oct 2021 18:06:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbhJIQIG (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 9 Oct 2021 12:08:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57885 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229722AbhJIQIF (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 9 Oct 2021 12:08:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633795567;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DG/aeffgcJAkMwlAnNO4h2rjvI5nUBG207miQ5G91Kw=;
        b=aUNivP+s2XRALLuki+ynXy/08im0wMwLgLfS4PNsC0qSN6n8KAUqvG0RPxhWR23CyQJG18
        r+sFWPy0D8L8IY9qUQYDKbrRZ5ruDIyB28nfM+1hL/s1VCG1FWSBBSbB8Hnkv0UgTFBniM
        qeF7Ct1sxx8x7dVaoRwwOdRHkgoTaWE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-455-5vuNI7mwPeynx4jqB6u6LQ-1; Sat, 09 Oct 2021 12:06:04 -0400
X-MC-Unique: 5vuNI7mwPeynx4jqB6u6LQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DB25D8145E5;
        Sat,  9 Oct 2021 16:06:01 +0000 (UTC)
Received: from x1.localdomain.com (unknown [10.39.192.7])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B358B5C1B4;
        Sat,  9 Oct 2021 16:05:58 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andy@infradead.org>,
        Daniel Scally <djrscally@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Kate Hsuan <hpa@redhat.com>, linux-media@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [PATCH v2 01/13] ACPI: Add a honor_deps flag to struct acpi_device
Date:   Sat,  9 Oct 2021 18:05:36 +0200
Message-Id: <20211009160548.306550-2-hdegoede@redhat.com>
In-Reply-To: <20211009160548.306550-1-hdegoede@redhat.com>
References: <20211009160548.306550-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

At the moment dependencies by _DEP are mostly ignored by the ACPI code,
other then acpi_bus_scan() instantiating all devices without _DEP-s before
instantiating devices with _DEP-s.

The on exception to this is ACPI battery devices for which _DEP-s are fully
honored.

Now another case has come-up where we want to honor the _DEP-s.
In preparation for this add a new honor_deps flag to struct acpi_device
and move the existing battery special-case over to this flag.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/bus.c      | 4 ++--
 drivers/acpi/scan.c     | 4 ++++
 include/acpi/acpi_bus.h | 1 +
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index fa923a929224..7dd6262ca488 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -103,8 +103,8 @@ int acpi_bus_get_status(struct acpi_device *device)
 		return 0;
 	}
 
-	/* Battery devices must have their deps met before calling _STA */
-	if (acpi_device_is_battery(device) && device->dep_unmet) {
+	/* If honor_deps is set, the deps must be met before calling _STA */
+	if (device->honor_deps && device->dep_unmet) {
 		acpi_set_device_status(device, 0);
 		return 0;
 	}
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 5b54c80b9d32..4e0a946b35ed 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1756,6 +1756,10 @@ static void acpi_scan_dep_init(struct acpi_device *adev)
 {
 	struct acpi_dep_data *dep;
 
+	/* Always honor the deps for battery devices */
+	if (acpi_device_is_battery(adev))
+		adev->honor_deps = true;
+
 	list_for_each_entry(dep, &acpi_dep_list, node) {
 		if (dep->consumer == adev->handle)
 			adev->dep_unmet++;
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 13d93371790e..0ba344a5f4f8 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -381,6 +381,7 @@ struct acpi_device {
 	struct device dev;
 	unsigned int physical_node_count;
 	unsigned int dep_unmet;
+	bool honor_deps;
 	struct list_head physical_node_list;
 	struct mutex physical_node_lock;
 	void (*remove)(struct acpi_device *);
-- 
2.31.1

