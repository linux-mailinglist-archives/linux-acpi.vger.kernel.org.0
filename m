Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07CEA427B96
	for <lists+linux-acpi@lfdr.de>; Sat,  9 Oct 2021 18:06:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbhJIQIJ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 9 Oct 2021 12:08:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46389 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229823AbhJIQIG (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 9 Oct 2021 12:08:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633795568;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ed1NHeUzStfgTIm7XeGod1x5IuJGGIpyusFfY/zT3KI=;
        b=HK1wjOH7GaDzI8uorHWD6mdjPTrfi4ZZvjLcNqM1eOz7Zj/qoWh7F9Xe0JSLg0OzxUkbf9
        VZZ2I7ca4Z2kjbgBoEtjmgf9C4bJjX9vCFNqqCB+dOAm9UTAmvd9ssJXWBF9dbVQuwgdhU
        Lpc2vcmXFYAVUkFLdgpa+Z2imdyv1Nk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-433-8yA73chPMYGRfF-Abtqgfg-1; Sat, 09 Oct 2021 12:06:07 -0400
X-MC-Unique: 8yA73chPMYGRfF-Abtqgfg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4F9765721E;
        Sat,  9 Oct 2021 16:06:05 +0000 (UTC)
Received: from x1.localdomain.com (unknown [10.39.192.7])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2BC725C1BB;
        Sat,  9 Oct 2021 16:06:02 +0000 (UTC)
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
Subject: [PATCH v2 02/13] ACPI: honor dependencies for devices with a _DEP pointing to an INT3472 device
Date:   Sat,  9 Oct 2021 18:05:37 +0200
Message-Id: <20211009160548.306550-3-hdegoede@redhat.com>
In-Reply-To: <20211009160548.306550-1-hdegoede@redhat.com>
References: <20211009160548.306550-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The clk and regulator frameworks expect clk/regulator consumer-devices
to have info about the consumed clks/regulators described in the device's
fw_node.

To work around cases where this info is not present in the firmware tables,
which is often the case on x86/ACPI devices, both frameworks allow the
provider-driver to attach info about consumers to the clks/regulators
when registering these.

This causes problems with the probe ordering wrt drivers for consumers
of these clks/regulators. Since the lookups are only registered when the
provider-driver binds, trying to get these clks/regulators before then
results in a -ENOENT error for clks and a dummy regulator for regulators.

One case where we hit this issue is camera sensors such as e.g. the OV8865
sensor found on the Microsoft Surface Go. The sensor uses clks, regulators
and GPIOs provided by a TPS68470 PMIC which is described in an INT3472
ACPI device. There is special platform code handling this and setting
platform_data with the necessary consumer info on the MFD cells
instantiated for the PMIC under: drivers/platform/x86/intel/int3472.

For this to work properly the ov8865 driver must not bind to the i2c-client
for the OV8865 sensor until after the TPS68470 PMIC gpio, regulator and
clk MFD cells have all been fully setup.

The OV8865 on the Microsoft Surface Go is just one example, all X86
devices using the Intel IPU3 camera block found on recent Intel SoCs
have similar issues where there is an INT3472 HID ACPI-device which
describes the clks and regulators and the driver for this INT3472 device
must be fully initialized before the sensor driver (any sensor driver)
binds for things to work properly.

On these devices the ACPI nodes describing the sensors all have a _DEP
dependency on the matching INT3472 ACPI device (there is one per sensor).

This allows solving the probe-ordering problem by making ACPI-devices
honor the _DEP dependencies (like we already do for batteries) when they
have a dependency on an INT3472 device.

Note the matching is done on there being a _DEP on an INT3472 device,
rather then matching on the HID of the sensor device itself to avoid
having to maintain an ever growing list of HIDs of sensors which need
the honor_dep behavior.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/scan.c     | 16 ++++++++++++++--
 include/acpi/acpi_bus.h |  1 +
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 4e0a946b35ed..976724540197 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -796,6 +796,12 @@ static const char * const acpi_ignore_dep_ids[] = {
 	NULL
 };
 
+/* List of HIDs for which we honor deps of matching ACPI devs, when checking _DEP lists. */
+static const char * const acpi_honor_dep_ids[] = {
+	"INT3472", /* Camera sensor PMIC / clk and regulator info */
+	NULL
+};
+
 static struct acpi_device *acpi_bus_get_parent(acpi_handle handle)
 {
 	struct acpi_device *device = NULL;
@@ -1761,8 +1767,12 @@ static void acpi_scan_dep_init(struct acpi_device *adev)
 		adev->honor_deps = true;
 
 	list_for_each_entry(dep, &acpi_dep_list, node) {
-		if (dep->consumer == adev->handle)
+		if (dep->consumer == adev->handle) {
+			if (dep->honor_dep)
+				adev->honor_deps = true;
+
 			adev->dep_unmet++;
+		}
 	}
 }
 
@@ -1966,7 +1976,7 @@ static u32 acpi_scan_check_dep(acpi_handle handle, bool check_dep)
 	for (count = 0, i = 0; i < dep_devices.count; i++) {
 		struct acpi_device_info *info;
 		struct acpi_dep_data *dep;
-		bool skip;
+		bool skip, honor_dep;
 
 		status = acpi_get_object_info(dep_devices.handles[i], &info);
 		if (ACPI_FAILURE(status)) {
@@ -1975,6 +1985,7 @@ static u32 acpi_scan_check_dep(acpi_handle handle, bool check_dep)
 		}
 
 		skip = acpi_info_matches_ids(info, acpi_ignore_dep_ids);
+		honor_dep = acpi_info_matches_ids(info, acpi_honor_dep_ids);
 		kfree(info);
 
 		if (skip)
@@ -1988,6 +1999,7 @@ static u32 acpi_scan_check_dep(acpi_handle handle, bool check_dep)
 
 		dep->supplier = dep_devices.handles[i];
 		dep->consumer = handle;
+		dep->honor_dep = honor_dep;
 
 		mutex_lock(&acpi_dep_list_lock);
 		list_add_tail(&dep->node , &acpi_dep_list);
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 0ba344a5f4f8..b6fb050e77bb 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -284,6 +284,7 @@ struct acpi_dep_data {
 	struct list_head node;
 	acpi_handle supplier;
 	acpi_handle consumer;
+	bool honor_dep;
 };
 
 /* Performance Management */
-- 
2.31.1

