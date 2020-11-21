Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64A5E2BC211
	for <lists+linux-acpi@lfdr.de>; Sat, 21 Nov 2020 21:32:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728402AbgKUUaz (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 21 Nov 2020 15:30:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:28787 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728511AbgKUUaz (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Sat, 21 Nov 2020 15:30:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605990653;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qIFpuxY58mNlSwyojr2EBGs0nBeW01lQD7+vcwPzDfk=;
        b=SWzVfoZ6zNLlOkk9fJwK0aNxLZvRXbCRBDT6GO0Gs/49hx4LchCIIzu0+hEE6sYb+Rkjy0
        k81cOs8bRfd+zeJ3TcGXGN6FJ8CsidKrXhWCw9s34JB2bI/BvckyEHQBONsajgNw9BprTZ
        cHNulgCFbqpsrQR4QcktdoriAK00ZhM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-522-WQ4DSXzMN_2V04SP7tlOfA-1; Sat, 21 Nov 2020 15:30:51 -0500
X-MC-Unique: WQ4DSXzMN_2V04SP7tlOfA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C0CDD803F41;
        Sat, 21 Nov 2020 20:30:50 +0000 (UTC)
Received: from x1.localdomain (ovpn-112-24.ams2.redhat.com [10.36.112.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D164818E4F;
        Sat, 21 Nov 2020 20:30:49 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org
Subject: [PATCH 5/7] ACPI: scan: Add support for deferring adding devices to the second scan phase based on the _DEP list
Date:   Sat, 21 Nov 2020 21:30:38 +0100
Message-Id: <20201121203040.146252-6-hdegoede@redhat.com>
In-Reply-To: <20201121203040.146252-1-hdegoede@redhat.com>
References: <20201121203040.146252-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The current solution, of deferring adding of some devices because they
need access during the OpRegions of other devices while they are added,
is not very generic.

And support for making the decision to defer adding a device based on
its _DEP list, instead of the device's HID being in a fixed list of HIDs
to defer, which should be a more generic way to deal with this.

Since this is likely to cause issues on some hardware, this new method will
only be used if the new acpi.defer_scan_based_on_dep kernel commandline
option is set to 1.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/scan.c | 45 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 44 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 407c8536568b..9927036bfe77 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -31,6 +31,11 @@ extern struct acpi_device *acpi_root;
 
 #define INVALID_ACPI_HANDLE	((acpi_handle)empty_zero_page)
 
+static int defer_scan_based_on_dep = -1;
+module_param(defer_scan_based_on_dep, int, 0444);
+MODULE_PARM_DESC(defer_scan_based_on_dep,
+	"Use new scan-scheme deferring addition of devices with non empty _DEP list (-1=auto, 0=no, 1=yes)");
+
 static const char *dummy_hid = "device";
 
 static LIST_HEAD(acpi_dep_list);
@@ -1657,11 +1662,45 @@ void acpi_device_add_finalize(struct acpi_device *device)
 
 static bool acpi_should_defer_add(acpi_handle handle, struct acpi_device_info *info)
 {
+	struct acpi_handle_list dep_devices;
+	acpi_status status;
+	int i;
+
 	if (!acpi_check_defer_add || !info)
 		return false;
 
-	if (acpi_info_matches_hids(info, acpi_defer_add_hids))
+	if (!defer_scan_based_on_dep)
+		return acpi_info_matches_hids(info, acpi_defer_add_hids);
+
+	/*
+	 * We check for _ADR here to avoid deferring the adding of the following:
+	 * 1. PCI devices
+	 * 2. ACPI nodes describing USB ports
+	 * Note checking for _ADR catches more then just these cases...
+	 */
+	if (info->valid & ACPI_VALID_ADR)
+		return false;
+
+	status = acpi_evaluate_reference(handle, "_DEP", NULL, &dep_devices);
+	if (ACPI_FAILURE(status))
+		return false;
+
+	for (i = 0; i < dep_devices.count; i++) {
+		struct acpi_device_info *dep_info;
+		bool ignore;
+
+		status = acpi_get_object_info(dep_devices.handles[i], &dep_info);
+		if (ACPI_FAILURE(status))
+			continue;
+
+		ignore = acpi_info_matches_hids(dep_info, acpi_ignore_dep_hids);
+		kfree(dep_info);
+
+		if (ignore)
+			continue;
+
 		return true;
+	}
 
 	return false;
 }
@@ -2251,6 +2290,10 @@ int __init acpi_scan_init(void)
 	struct acpi_table_stao *stao_ptr;
 	struct acpi_deferred_dev *deferred_dev, *tmp;
 
+	/* Currently no devices are known which need _dep based scan deferral */
+	if (defer_scan_based_on_dep == -1)
+		defer_scan_based_on_dep = 0;
+
 	acpi_pci_root_init();
 	acpi_pci_link_init();
 	acpi_processor_init();
-- 
2.28.0

