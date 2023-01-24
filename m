Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2F506795E4
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Jan 2023 11:59:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233356AbjAXK7A (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 24 Jan 2023 05:59:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232276AbjAXK6y (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 24 Jan 2023 05:58:54 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBB511556D
        for <linux-acpi@vger.kernel.org>; Tue, 24 Jan 2023 02:58:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674557884;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jySLIWS2h5rKJtHTCH1hoVWqm+NJ+BPV3XYnT9jEpPQ=;
        b=WABlzlATJ45cXcKYofvFUSjrd410Y2otXCgt+bc6QWwpyNQc2NIQMrzfq56pBLbMG7tEVI
        wMS3VXPb7M8CP+IWufb9CV3SpqQ06Up1RDJqvLKkxWR5ixiBC/ivfEpPvvdgYH6O8yhvjc
        k5fselr78KCT7r1I97G+wdXDoGhEcrM=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-648-H5rENg7tMK69VekcjEhjqA-1; Tue, 24 Jan 2023 05:58:00 -0500
X-MC-Unique: H5rENg7tMK69VekcjEhjqA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4322A1C0519E;
        Tue, 24 Jan 2023 10:58:00 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.195.52])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AF2F940444C3;
        Tue, 24 Jan 2023 10:57:58 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Lukas Wunner <lukas@wunner.de>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andy@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, Len Brown <lenb@kernel.org>,
        Emmanouil Kouroupakis <kartebi@gmail.com>,
        Aditya Garg <gargaditya08@live.com>,
        Orlando Chamberlain <orlandoch.dev@gmail.com>,
        linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: [PATCH v2 2/3] platform/x86: apple-gmux: Add apple_gmux_detect() helper
Date:   Tue, 24 Jan 2023 11:57:53 +0100
Message-Id: <20230124105754.62167-3-hdegoede@redhat.com>
In-Reply-To: <20230124105754.62167-1-hdegoede@redhat.com>
References: <20230124105754.62167-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Add a new (static inline) apple_gmux_detect() helper to apple-gmux.h
which can be used for gmux detection instead of apple_gmux_present().

The latter is not really reliable since an ACPI device with a HID
of APP000B is present on some devices without a gmux at all, as well
as on devices with a newer (unsupported) MMIO based gmux model.

This causes apple_gmux_present() to return false-positives on
a number of different Apple laptop models.

This new helper uses the same probing as the actual apple-gmux
driver, so that it does not return false positives.

To avoid code duplication the gmux_probe() function of the actual
driver is also moved over to using the new apple_gmux_detect() helper.

This avoids false positives (vs _HID + IO region detection) on:

MacBookPro5,4
https://pastebin.com/8Xjq7RhS

MacBookPro8,1
https://linux-hardware.org/?probe=e513cfbadb&log=dmesg

MacBookPro9,2
https://bugzilla.kernel.org/attachment.cgi?id=278961

MacBookPro10,2
https://lkml.org/lkml/2014/9/22/657

MacBookPro11,2
https://forums.fedora-fr.org/viewtopic.php?id=70142

MacBookPro11,4
https://raw.githubusercontent.com/im-0/investigate-card-reader-suspend-problem-on-mbp11.4/master/test-16/dmesg

Fixes: 21245df307cb ("ACPI: video: Add Apple GMUX brightness control detection")
Link: https://lore.kernel.org/platform-driver-x86/20230123113750.462144-1-hdegoede@redhat.com/
Reported-by: Emmanouil Kouroupakis <kartebi@gmail.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
- Fix leaking of adev reference returned by acpi_dev_get_first_match_dev()
  (Reported-by: Andy Shevchenko <andy.shevchenko@gmail.com>)
- Add list of known affected Apple models (Lukas Wunner)
- Add Reported-by and Link tags
---
 drivers/platform/x86/apple-gmux.c | 70 +++++++------------------
 include/linux/apple-gmux.h        | 86 ++++++++++++++++++++++++++++++-
 2 files changed, 102 insertions(+), 54 deletions(-)

diff --git a/drivers/platform/x86/apple-gmux.c b/drivers/platform/x86/apple-gmux.c
index a0af01f6a0fd..9333f82cfa8a 100644
--- a/drivers/platform/x86/apple-gmux.c
+++ b/drivers/platform/x86/apple-gmux.c
@@ -226,23 +226,6 @@ static void gmux_write32(struct apple_gmux_data *gmux_data, int port,
 		gmux_pio_write32(gmux_data, port, val);
 }
 
-static bool gmux_is_indexed(struct apple_gmux_data *gmux_data)
-{
-	u16 val;
-
-	outb(0xaa, gmux_data->iostart + 0xcc);
-	outb(0x55, gmux_data->iostart + 0xcd);
-	outb(0x00, gmux_data->iostart + 0xce);
-
-	val = inb(gmux_data->iostart + 0xcc) |
-		(inb(gmux_data->iostart + 0xcd) << 8);
-
-	if (val == 0x55aa)
-		return true;
-
-	return false;
-}
-
 /**
  * DOC: Backlight control
  *
@@ -582,60 +565,43 @@ static int gmux_probe(struct pnp_dev *pnp, const struct pnp_device_id *id)
 	int ret = -ENXIO;
 	acpi_status status;
 	unsigned long long gpe;
+	bool indexed = false;
+	u32 version;
 
 	if (apple_gmux_data)
 		return -EBUSY;
 
+	if (!apple_gmux_detect(pnp, &indexed)) {
+		pr_info("gmux device not present\n");
+		return -ENODEV;
+	}
+
 	gmux_data = kzalloc(sizeof(*gmux_data), GFP_KERNEL);
 	if (!gmux_data)
 		return -ENOMEM;
 	pnp_set_drvdata(pnp, gmux_data);
 
 	res = pnp_get_resource(pnp, IORESOURCE_IO, 0);
-	if (!res) {
-		pr_err("Failed to find gmux I/O resource\n");
-		goto err_free;
-	}
-
 	gmux_data->iostart = res->start;
 	gmux_data->iolen = resource_size(res);
 
-	if (gmux_data->iolen < GMUX_MIN_IO_LEN) {
-		pr_err("gmux I/O region too small (%lu < %u)\n",
-		       gmux_data->iolen, GMUX_MIN_IO_LEN);
-		goto err_free;
-	}
-
 	if (!request_region(gmux_data->iostart, gmux_data->iolen,
 			    "Apple gmux")) {
 		pr_err("gmux I/O already in use\n");
 		goto err_free;
 	}
 
-	/*
-	 * Invalid version information may indicate either that the gmux
-	 * device isn't present or that it's a new one that uses indexed
-	 * io
-	 */
-
-	ver_major = gmux_read8(gmux_data, GMUX_PORT_VERSION_MAJOR);
-	ver_minor = gmux_read8(gmux_data, GMUX_PORT_VERSION_MINOR);
-	ver_release = gmux_read8(gmux_data, GMUX_PORT_VERSION_RELEASE);
-	if (ver_major == 0xff && ver_minor == 0xff && ver_release == 0xff) {
-		if (gmux_is_indexed(gmux_data)) {
-			u32 version;
-			mutex_init(&gmux_data->index_lock);
-			gmux_data->indexed = true;
-			version = gmux_read32(gmux_data,
-				GMUX_PORT_VERSION_MAJOR);
-			ver_major = (version >> 24) & 0xff;
-			ver_minor = (version >> 16) & 0xff;
-			ver_release = (version >> 8) & 0xff;
-		} else {
-			pr_info("gmux device not present\n");
-			ret = -ENODEV;
-			goto err_release;
-		}
+	if (indexed) {
+		mutex_init(&gmux_data->index_lock);
+		gmux_data->indexed = true;
+		version = gmux_read32(gmux_data, GMUX_PORT_VERSION_MAJOR);
+		ver_major = (version >> 24) & 0xff;
+		ver_minor = (version >> 16) & 0xff;
+		ver_release = (version >> 8) & 0xff;
+	} else {
+		ver_major = gmux_read8(gmux_data, GMUX_PORT_VERSION_MAJOR);
+		ver_minor = gmux_read8(gmux_data, GMUX_PORT_VERSION_MINOR);
+		ver_release = gmux_read8(gmux_data, GMUX_PORT_VERSION_RELEASE);
 	}
 	pr_info("Found gmux version %d.%d.%d [%s]\n", ver_major, ver_minor,
 		ver_release, (gmux_data->indexed ? "indexed" : "classic"));
diff --git a/include/linux/apple-gmux.h b/include/linux/apple-gmux.h
index 80efaaf89e07..1f68b49bcd68 100644
--- a/include/linux/apple-gmux.h
+++ b/include/linux/apple-gmux.h
@@ -8,6 +8,8 @@
 #define LINUX_APPLE_GMUX_H
 
 #include <linux/acpi.h>
+#include <linux/io.h>
+#include <linux/pnp.h>
 
 #define GMUX_ACPI_HID "APP000B"
 
@@ -35,14 +37,89 @@
 #define GMUX_MIN_IO_LEN			(GMUX_PORT_BRIGHTNESS + 4)
 
 #if IS_ENABLED(CONFIG_APPLE_GMUX)
+static inline bool apple_gmux_is_indexed(unsigned long iostart)
+{
+	u16 val;
+
+	outb(0xaa, iostart + 0xcc);
+	outb(0x55, iostart + 0xcd);
+	outb(0x00, iostart + 0xce);
+
+	val = inb(iostart + 0xcc) | (inb(iostart + 0xcd) << 8);
+	if (val == 0x55aa)
+		return true;
+
+	return false;
+}
 
 /**
- * apple_gmux_present() - detect if gmux is built into the machine
+ * apple_gmux_detect() - detect if gmux is built into the machine
+ *
+ * @pnp_dev:     Device to probe or NULL to use the first matching device
+ * @indexed_ret: Returns (by reference) if the gmux is indexed or not
+ *
+ * Detect if a supported gmux device is present by actually probing it.
+ * This avoids the false positives returned on some models by
+ * apple_gmux_present().
+ *
+ * Return: %true if a supported gmux ACPI device is detected and the kernel
+ * was configured with CONFIG_APPLE_GMUX, %false otherwise.
+ */
+static inline bool apple_gmux_detect(struct pnp_dev *pnp_dev, bool *indexed_ret)
+{
+	u8 ver_major, ver_minor, ver_release;
+	struct device *dev = NULL;
+	struct acpi_device *adev;
+	struct resource *res;
+	bool indexed = false;
+	bool ret = false;
+
+	if (!pnp_dev) {
+		adev = acpi_dev_get_first_match_dev(GMUX_ACPI_HID, NULL, -1);
+		if (!adev)
+			return false;
+
+		dev = get_device(acpi_get_first_physical_node(adev));
+		acpi_dev_put(adev);
+		if (!dev)
+			return false;
+
+		pnp_dev = to_pnp_dev(dev);
+	}
+
+	res = pnp_get_resource(pnp_dev, IORESOURCE_IO, 0);
+	if (!res || resource_size(res) < GMUX_MIN_IO_LEN)
+		goto out;
+
+	/*
+	 * Invalid version information may indicate either that the gmux
+	 * device isn't present or that it's a new one that uses indexed io.
+	 */
+	ver_major = inb(res->start + GMUX_PORT_VERSION_MAJOR);
+	ver_minor = inb(res->start + GMUX_PORT_VERSION_MINOR);
+	ver_release = inb(res->start + GMUX_PORT_VERSION_RELEASE);
+	if (ver_major == 0xff && ver_minor == 0xff && ver_release == 0xff) {
+		indexed = apple_gmux_is_indexed(res->start);
+		if (!indexed)
+			goto out;
+	}
+
+	if (indexed_ret)
+		*indexed_ret = indexed;
+
+	ret = true;
+out:
+	put_device(dev);
+	return ret;
+}
+
+/**
+ * apple_gmux_present() - check if gmux ACPI device is present
  *
  * Drivers may use this to activate quirks specific to dual GPU MacBook Pros
  * and Mac Pros, e.g. for deferred probing, runtime pm and backlight.
  *
- * Return: %true if gmux is present and the kernel was configured
+ * Return: %true if gmux ACPI device is present and the kernel was configured
  * with CONFIG_APPLE_GMUX, %false otherwise.
  */
 static inline bool apple_gmux_present(void)
@@ -57,6 +134,11 @@ static inline bool apple_gmux_present(void)
 	return false;
 }
 
+static inline bool apple_gmux_detect(struct pnp_dev *pnp_dev, bool *indexed_ret)
+{
+	return false;
+}
+
 #endif /* !CONFIG_APPLE_GMUX */
 
 #endif /* LINUX_APPLE_GMUX_H */
-- 
2.39.0

