Return-Path: <linux-acpi+bounces-21342-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6As6BJZ7qGmHuwAAu9opvQ
	(envelope-from <linux-acpi+bounces-21342-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Wed, 04 Mar 2026 19:36:06 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DC79206735
	for <lists+linux-acpi@lfdr.de>; Wed, 04 Mar 2026 19:36:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ACCBF30D8DCD
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Mar 2026 18:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDF263D3CEA;
	Wed,  4 Mar 2026 18:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DRRA4Mrh"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ABEE23C4FF;
	Wed,  4 Mar 2026 18:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772648816; cv=none; b=M0vcodW/v6FXSbeUtwZjgMO623/SdJOPAU+0WWycL/sSHRUWP/jWgmr5bUlk5heD02f6YlGyZIHPHnHzhngz+CV2r3PYiBvIVdkJBZnD3am6APB3/xceVoj39Sjij8UDmDKS6y6Mx4KJTmokY6MfMPvdY3mGD8i9bkSucyg+zpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772648816; c=relaxed/simple;
	bh=RNdaGRBiui5MrWYZBw9+X22zHG/EpW6gEJ1x1SeG5Dk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iU2juID/x9iDV/9Mly8YITfxj1cO4Rp/yl4bTo0+woWJyaYmC3C7IWZkoHsCeTqSA13sjxZaA252n9jxQJCptOfCUIlChEtlFQ68agTqTs6HoRDWhz7nJR7s9H5eNllboN7wnd5v7ADvNG9os717pncIDtdIIq3JD4S0PqZEyeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DRRA4Mrh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04EA1C4CEF7;
	Wed,  4 Mar 2026 18:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772648816;
	bh=RNdaGRBiui5MrWYZBw9+X22zHG/EpW6gEJ1x1SeG5Dk=;
	h=From:To:Cc:Subject:Date:From;
	b=DRRA4MrhrzX6muP8H3zWLDvlghmwKTMaceB3FNEiqG5/6jPfjyIV2cs08BsqMgJGI
	 +VzYdoimFpzBb6A/eYajBnpOo+3xJPN2JwGhtDoqxk/zSyR1hla2FFD4BEa69Wy8Sw
	 3PtlwHgVER8NalXef9BvEM+Yow2KH5ZvI8CU+1/ZHXZgfMpeIMKX7u88cssBM8NK0A
	 iNhjAJneibOSYDhIFIYBLFHJlPlcEZ/AnLxRhwgckNY1vu+0cMynY9ZKlgj1evrQuH
	 K9r0vjH+vXVxvhBfdjs8Dmxk6OgoG6dsMmdm31zXger+j4JaYQ2YJybH0W13ZPJjl3
	 1ir6eMSXpMnwA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Luca Tettamanti <kronos.it@gmail.com>, linux-hwmon@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>
Subject:
 [PATCH v1] hwmon: (asus_atk0110) Convert ACPI driver to a platform one
Date: Wed, 04 Mar 2026 19:26:52 +0100
Message-ID: <3691136.iIbC2pHGDl@rafael.j.wysocki>
Organization: Linux Kernel Development
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 9DC79206735
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	CTE_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21342-lists,linux-acpi=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-acpi@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-acpi];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,rafael.j.wysocki:mid,intel.com:email]
X-Rspamd-Action: no action

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

In all cases in which a struct acpi_driver is used for binding a driver
to an ACPI device object, a corresponding platform device is created by
the ACPI core and that device is regarded as a proper representation of
underlying hardware.  Accordingly, a struct platform_driver should be
used by driver code to bind to that device.  There are multiple reasons
why drivers should not bind directly to ACPI device objects [1].

Overall, it is better to bind drivers to platform devices than to their
ACPI companions, so convert the asus_atk0110 ACPI driver to a platform
one.

After this change, the subordinate hwmon device will be registered under
the platform device used for driver binding and messages will be printed
relative to that device instead of its ACPI companion.

While this is not expected to alter functionality, it changes sysfs
layout and so it will be visible to user space.

Link: https://lore.kernel.org/all/2396510.ElGaqSPkdT@rafael.j.wysocki/ [1]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/hwmon/asus_atk0110.c | 92 ++++++++++++++++++------------------
 1 file changed, 46 insertions(+), 46 deletions(-)

diff --git a/drivers/hwmon/asus_atk0110.c b/drivers/hwmon/asus_atk0110.c
index c80350e499e9..5688ff5f7c28 100644
--- a/drivers/hwmon/asus_atk0110.c
+++ b/drivers/hwmon/asus_atk0110.c
@@ -17,6 +17,7 @@
 #include <linux/jiffies.h>
 #include <linux/err.h>
 #include <linux/acpi.h>
+#include <linux/platform_device.h>
 #include <linux/string_choices.h>
 
 #define ATK_HID "ATK0110"
@@ -107,7 +108,7 @@ enum atk_pack_member {
 struct atk_data {
 	struct device *hwmon_dev;
 	acpi_handle atk_handle;
-	struct acpi_device *acpi_dev;
+	struct device *dev;
 
 	bool old_interface;
 
@@ -187,18 +188,17 @@ struct atk_acpi_input_buf {
 	u32 param2;
 };
 
-static int atk_add(struct acpi_device *device);
-static void atk_remove(struct acpi_device *device);
+static int atk_probe(struct platform_device *pdev);
+static void atk_remove(struct platform_device *pdev);
 static void atk_print_sensor(struct atk_data *data, union acpi_object *obj);
 static int atk_read_value(struct atk_sensor_data *sensor, u64 *value);
 
-static struct acpi_driver atk_driver = {
-	.name	= ATK_HID,
-	.class	= "hwmon",
-	.ids	= atk_ids,
-	.ops	= {
-		.add	= atk_add,
-		.remove	= atk_remove,
+static struct platform_driver atk_driver = {
+	.probe = atk_probe,
+	.remove = atk_remove,
+	.driver = {
+		.name = ATK_HID,
+		.acpi_match_table = atk_ids,
 	},
 };
 
@@ -327,7 +327,7 @@ static union acpi_object *atk_get_pack_member(struct atk_data *data,
  */
 static int validate_hwmon_pack(struct atk_data *data, union acpi_object *obj)
 {
-	struct device *dev = &data->acpi_dev->dev;
+	struct device *dev = data->dev;
 	union acpi_object *tmp;
 	bool old_if = data->old_interface;
 	int const expected_size = old_if ? _HWMON_OLD_PACK_SIZE :
@@ -422,7 +422,7 @@ static char const *atk_sensor_type(union acpi_object *flags)
 static void atk_print_sensor(struct atk_data *data, union acpi_object *obj)
 {
 #ifdef DEBUG
-	struct device *dev = &data->acpi_dev->dev;
+	struct device *dev = data->dev;
 	union acpi_object *flags;
 	union acpi_object *name;
 	union acpi_object *limit1;
@@ -449,7 +449,7 @@ static void atk_print_sensor(struct atk_data *data, union acpi_object *obj)
 static int atk_read_value_old(struct atk_sensor_data *sensor, u64 *value)
 {
 	struct atk_data *data = sensor->data;
-	struct device *dev = &data->acpi_dev->dev;
+	struct device *dev = data->dev;
 	struct acpi_object_list params;
 	union acpi_object id;
 	acpi_status status;
@@ -487,7 +487,7 @@ static int atk_read_value_old(struct atk_sensor_data *sensor, u64 *value)
 
 static union acpi_object *atk_ggrp(struct atk_data *data, u16 mux)
 {
-	struct device *dev = &data->acpi_dev->dev;
+	struct device *dev = data->dev;
 	struct acpi_buffer buf;
 	acpi_status ret;
 	struct acpi_object_list params;
@@ -523,7 +523,7 @@ static union acpi_object *atk_ggrp(struct atk_data *data, u16 mux)
 
 static union acpi_object *atk_gitm(struct atk_data *data, u64 id)
 {
-	struct device *dev = &data->acpi_dev->dev;
+	struct device *dev = data->dev;
 	struct atk_acpi_input_buf buf;
 	union acpi_object tmp;
 	struct acpi_object_list params;
@@ -565,7 +565,7 @@ static union acpi_object *atk_gitm(struct atk_data *data, u64 id)
 static union acpi_object *atk_sitm(struct atk_data *data,
 		struct atk_acpi_input_buf *buf)
 {
-	struct device *dev = &data->acpi_dev->dev;
+	struct device *dev = data->dev;
 	struct acpi_object_list params;
 	union acpi_object tmp;
 	struct acpi_buffer ret;
@@ -602,7 +602,7 @@ static union acpi_object *atk_sitm(struct atk_data *data,
 static int atk_read_value_new(struct atk_sensor_data *sensor, u64 *value)
 {
 	struct atk_data *data = sensor->data;
-	struct device *dev = &data->acpi_dev->dev;
+	struct device *dev = data->dev;
 	union acpi_object *obj;
 	struct atk_acpi_ret_buffer *buf;
 	int err = 0;
@@ -819,7 +819,7 @@ static void atk_debugfs_cleanup(struct atk_data *data)
 
 static int atk_add_sensor(struct atk_data *data, union acpi_object *obj)
 {
-	struct device *dev = &data->acpi_dev->dev;
+	struct device *dev = data->dev;
 	union acpi_object *flags;
 	union acpi_object *name;
 	union acpi_object *limit1;
@@ -937,7 +937,7 @@ static int atk_add_sensor(struct atk_data *data, union acpi_object *obj)
 
 static int atk_enumerate_old_hwmon(struct atk_data *data)
 {
-	struct device *dev = &data->acpi_dev->dev;
+	struct device *dev = data->dev;
 	struct acpi_buffer buf;
 	union acpi_object *pack;
 	acpi_status status;
@@ -1012,7 +1012,7 @@ static int atk_enumerate_old_hwmon(struct atk_data *data)
 
 static int atk_ec_present(struct atk_data *data)
 {
-	struct device *dev = &data->acpi_dev->dev;
+	struct device *dev = data->dev;
 	union acpi_object *pack;
 	union acpi_object *ec;
 	int ret;
@@ -1058,7 +1058,7 @@ static int atk_ec_present(struct atk_data *data)
 
 static int atk_ec_enabled(struct atk_data *data)
 {
-	struct device *dev = &data->acpi_dev->dev;
+	struct device *dev = data->dev;
 	union acpi_object *obj;
 	struct atk_acpi_ret_buffer *buf;
 	int err;
@@ -1084,7 +1084,7 @@ static int atk_ec_enabled(struct atk_data *data)
 
 static int atk_ec_ctl(struct atk_data *data, int enable)
 {
-	struct device *dev = &data->acpi_dev->dev;
+	struct device *dev = data->dev;
 	union acpi_object *obj;
 	struct atk_acpi_input_buf sitm;
 	struct atk_acpi_ret_buffer *ec_ret;
@@ -1113,7 +1113,7 @@ static int atk_ec_ctl(struct atk_data *data, int enable)
 
 static int atk_enumerate_new_hwmon(struct atk_data *data)
 {
-	struct device *dev = &data->acpi_dev->dev;
+	struct device *dev = data->dev;
 	union acpi_object *pack;
 	int err;
 	int i;
@@ -1155,7 +1155,7 @@ static int atk_enumerate_new_hwmon(struct atk_data *data)
 
 static int atk_init_attribute_groups(struct atk_data *data)
 {
-	struct device *dev = &data->acpi_dev->dev;
+	struct device *dev = data->dev;
 	struct atk_sensor_data *s;
 	struct attribute **attrs;
 	int i = 0;
@@ -1181,7 +1181,7 @@ static int atk_init_attribute_groups(struct atk_data *data)
 
 static int atk_register_hwmon(struct atk_data *data)
 {
-	struct device *dev = &data->acpi_dev->dev;
+	struct device *dev = data->dev;
 
 	dev_dbg(dev, "registering hwmon device\n");
 	data->hwmon_dev = hwmon_device_register_with_groups(dev, "atk0110",
@@ -1193,7 +1193,7 @@ static int atk_register_hwmon(struct atk_data *data)
 
 static int atk_probe_if(struct atk_data *data)
 {
-	struct device *dev = &data->acpi_dev->dev;
+	struct device *dev = data->dev;
 	acpi_handle ret;
 	acpi_status status;
 	int err = 0;
@@ -1266,7 +1266,7 @@ static int atk_probe_if(struct atk_data *data)
 	return err;
 }
 
-static int atk_add(struct acpi_device *device)
+static int atk_probe(struct platform_device *pdev)
 {
 	acpi_status ret;
 	int err;
@@ -1274,14 +1274,14 @@ static int atk_add(struct acpi_device *device)
 	union acpi_object *obj;
 	struct atk_data *data;
 
-	dev_dbg(&device->dev, "adding...\n");
+	dev_dbg(&pdev->dev, "adding...\n");
 
-	data = devm_kzalloc(&device->dev, sizeof(*data), GFP_KERNEL);
+	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
-	data->acpi_dev = device;
-	data->atk_handle = device->handle;
+	data->dev = &pdev->dev;
+	data->atk_handle = ACPI_HANDLE(&pdev->dev);
 	INIT_LIST_HEAD(&data->sensor_list);
 	data->disable_ec = false;
 
@@ -1289,13 +1289,13 @@ static int atk_add(struct acpi_device *device)
 	ret = acpi_evaluate_object_typed(data->atk_handle, BOARD_ID, NULL,
 			&buf, ACPI_TYPE_PACKAGE);
 	if (ret != AE_OK) {
-		dev_dbg(&device->dev, "atk: method MBIF not found\n");
+		dev_dbg(&pdev->dev, "atk: method MBIF not found\n");
 	} else {
 		obj = buf.pointer;
 		if (obj->package.count >= 2) {
 			union acpi_object *id = &obj->package.elements[1];
 			if (id->type == ACPI_TYPE_STRING)
-				dev_dbg(&device->dev, "board ID = %s\n",
+				dev_dbg(&pdev->dev, "board ID = %s\n",
 					id->string.pointer);
 		}
 		ACPI_FREE(buf.pointer);
@@ -1303,21 +1303,21 @@ static int atk_add(struct acpi_device *device)
 
 	err = atk_probe_if(data);
 	if (err) {
-		dev_err(&device->dev, "No usable hwmon interface detected\n");
+		dev_err(&pdev->dev, "No usable hwmon interface detected\n");
 		goto out;
 	}
 
 	if (data->old_interface) {
-		dev_dbg(&device->dev, "Using old hwmon interface\n");
+		dev_dbg(&pdev->dev, "Using old hwmon interface\n");
 		err = atk_enumerate_old_hwmon(data);
 	} else {
-		dev_dbg(&device->dev, "Using new hwmon interface\n");
+		dev_dbg(&pdev->dev, "Using new hwmon interface\n");
 		err = atk_enumerate_new_hwmon(data);
 	}
 	if (err < 0)
 		goto out;
 	if (err == 0) {
-		dev_info(&device->dev,
+		dev_info(&pdev->dev,
 			 "No usable sensor detected, bailing out\n");
 		err = -ENODEV;
 		goto out;
@@ -1332,7 +1332,8 @@ static int atk_add(struct acpi_device *device)
 
 	atk_debugfs_init(data);
 
-	device->driver_data = data;
+	platform_set_drvdata(pdev, data);
+
 	return 0;
 out:
 	if (data->disable_ec)
@@ -1340,12 +1341,11 @@ static int atk_add(struct acpi_device *device)
 	return err;
 }
 
-static void atk_remove(struct acpi_device *device)
+static void atk_remove(struct platform_device *pdev)
 {
-	struct atk_data *data = device->driver_data;
-	dev_dbg(&device->dev, "removing...\n");
+	struct atk_data *data = platform_get_drvdata(pdev);
 
-	device->driver_data = NULL;
+	dev_dbg(&pdev->dev, "removing...\n");
 
 	atk_debugfs_cleanup(data);
 
@@ -1353,7 +1353,7 @@ static void atk_remove(struct acpi_device *device)
 
 	if (data->disable_ec) {
 		if (atk_ec_ctl(data, 0))
-			dev_err(&device->dev, "Failed to disable EC\n");
+			dev_err(&pdev->dev, "Failed to disable EC\n");
 	}
 }
 
@@ -1370,16 +1370,16 @@ static int __init atk0110_init(void)
 	if (dmi_check_system(atk_force_new_if))
 		new_if = true;
 
-	ret = acpi_bus_register_driver(&atk_driver);
+	ret = platform_driver_register(&atk_driver);
 	if (ret)
-		pr_info("acpi_bus_register_driver failed: %d\n", ret);
+		pr_info("platform_driver_register failed: %d\n", ret);
 
 	return ret;
 }
 
 static void __exit atk0110_exit(void)
 {
-	acpi_bus_unregister_driver(&atk_driver);
+	platform_driver_unregister(&atk_driver);
 }
 
 module_init(atk0110_init);
-- 
2.51.0





