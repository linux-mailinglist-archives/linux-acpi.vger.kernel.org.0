Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 113934A54D1
	for <lists+linux-acpi@lfdr.de>; Tue,  1 Feb 2022 02:55:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232058AbiBABzW (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 31 Jan 2022 20:55:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232055AbiBABzW (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 31 Jan 2022 20:55:22 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C24DC06173B
        for <linux-acpi@vger.kernel.org>; Mon, 31 Jan 2022 17:55:22 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id q3-20020a638c43000000b0034c9c0fb2d2so9522822pgn.22
        for <linux-acpi@vger.kernel.org>; Mon, 31 Jan 2022 17:55:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=h5QhweEvP4Vj26uM1uNSyMDoUmF599Hmz7h4EF2607c=;
        b=Vfc1T5Lb3d9QZyphu+ylwyfeOb/m8kLCjd9fOh22SWhS+/pcKb24yfVBTw7h7DvT11
         4Airk12sVKSuqvJl/YQnf/zNFlCTAv4sEDWdNM7Z4tceitnhuPEeIzTJavt9nFj9QLnR
         QshsX/omsbF0+iwYL+HOpMsrq2Ovd/4MNn/N7UPpdVIKPMtZd/ekhHZ5UElsk8USG1sZ
         4aHFaAnW8mZnGZ/LjPftV+aejhWacVKKN48SgHJncgnidrGz+dhODATyjeM8n4hoTXZ/
         T4KSm95FfRAlJpa7p9OivjfIbEtNQGGBqoBdI2XY0sfIkIQ+vU01dG4ESbWAlzz3qbFw
         5/3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=h5QhweEvP4Vj26uM1uNSyMDoUmF599Hmz7h4EF2607c=;
        b=gN9ayfYltQvypHzf0Ud4ik6pi5ixBvig9hXD2Y/1uVRSa/j+zV4LzpA/HqdUyjto4b
         Avht896ERQ48p1G3fJSo49q/eo2tSwnf7wecibmJ8PODm0zqOb+Va5Q35lhqLTi02mVL
         Uatyxgm4rwsg1tRsr/6nwxzZixYt84PO8jRu6Ja3OFXc0vUzhycB5EQu6cyQoiSgeWeT
         iHuqv6yrVOibyH9F05MGsYI/c6jPevN4fgzDq0WgRHBY4EoLffJs2xexbXmf1MqYM/W/
         fiM5MAp2mJsoo5R5r8mRcSA7m1SPOJY2HZoqFtYHVi+5vRopNJXOjULYNDZiswXwkDWL
         mF+w==
X-Gm-Message-State: AOAM533JpgKcyn5raETUfND7AUszG3RPModYbPfvCDEG0C7IMZLyY49q
        X0JC8lrjUIoIN5m6LmBukp5ymvwaGQaflA==
X-Google-Smtp-Source: ABdhPJyLax6EoCYK5Ffz4oP2m/COtFZPXgekNDlSNtV1B7/sdNlwMbcqFLOofN1DUzpQ/ReBsKkR/MyKxVYseQ==
X-Received: from wonchungspecialist.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1440])
 (user=wonchung job=sendgmr) by 2002:a17:902:82c6:: with SMTP id
 u6mr22880010plz.17.1643680521608; Mon, 31 Jan 2022 17:55:21 -0800 (PST)
Date:   Tue,  1 Feb 2022 01:55:18 +0000
Message-Id: <20220201015518.3118404-1-wonchung@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.0.rc2.247.g8bbb082509-goog
Subject: [PATCH v4] ACPI: device_sysfs: Add sysfs support for _PLD
From:   Won Chung <wonchung@google.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Prashant Malani <pmalani@chromium.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Won Chung <wonchung@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

When ACPI table includes _PLD fields for a device, create a new
directory (pld) in sysfs to share _PLD fields.

Signed-off-by: Won Chung <wonchung@google.com>
---
 Documentation/ABI/testing/sysfs-bus-acpi | 107 +++++++++++++++++++++++
 drivers/acpi/device_sysfs.c              |  55 ++++++++++++
 include/acpi/acpi_bus.h                  |   1 +
 3 files changed, 163 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-acpi b/Documentation/ABI/t=
esting/sysfs-bus-acpi
index 58abacf59b2a..b8b71c8f3cfd 100644
--- a/Documentation/ABI/testing/sysfs-bus-acpi
+++ b/Documentation/ABI/testing/sysfs-bus-acpi
@@ -96,3 +96,110 @@ Description:
 		hardware, if the _HRV control method is present.  It is mostly
 		useful for non-PCI devices because lspci can list the hardware
 		version for PCI devices.
+
+What:		/sys/bus/acpi/devices/.../pld/
+Date:		Feb, 2022
+Contact:	Won Chung <wonchung@google.com>
+Description:
+		This directory contains the output of the device object's _PLD
+		control method, if present. This information provides details
+		on physical location of a device.
+
+What:		/sys/bus/acpi/devices/.../pld/revision
+Date:		Feb, 2022
+Contact:	Won Chung <wonchung@google.com>
+Description:
+		The current revision is 0x2.
+
+What:           /sys/bus/acpi/devices/.../pld/group_token
+Date:           Feb, 2022
+Contact:        Won Chung <wonchung@google.com>
+Description:
+		Unique numerical value identifying a group.
+
+What:           /sys/bus/acpi/devices/.../pld/group_position
+Date:           Feb, 2022
+Contact:        Won Chung <wonchung@google.com>
+Description:
+		Identifies this device connection point=E2=80=99s position in the group.
+
+What:           /sys/bus/acpi/devices/.../pld/user_visible
+Date:           Feb, 2022
+Contact:        Won Chung <wonchung@google.com>
+Description:
+		Set if the device connection point can be seen by the user
+		without disassembly.
+
+What:           /sys/bus/acpi/devices/.../pld/dock
+Date:           Feb, 2022
+Contact:        Won Chung <wonchung@google.com>
+Description:
+		Set if the device connection point resides in a docking station
+		or port replicator.
+
+What:           /sys/bus/acpi/devices/.../pld/bay
+Date:           Feb, 2022
+Contact:        Won Chung <wonchung@google.com>
+Description:
+		Set if describing a device in a bay or if device connection
+		point is a bay.
+
+What:           /sys/bus/acpi/devices/.../pld/lid
+Date:           Feb, 2022
+Contact:        Won Chung <wonchung@google.com>
+Description:
+		Set if this device connection point resides on the lid of
+		laptop system.
+
+What:           /sys/bus/acpi/devices/.../pld/panel
+Date:           Feb, 2022
+Contact:        Won Chung <wonchung@google.com>
+Description:
+		Describes which panel surface of the system=E2=80=99s housing the
+		device connection point resides on:
+		0 - Top
+		1 - Bottom
+		2 - Left
+		3 - Right
+		4 - Front
+		5 - Back
+		6 - Unknown (Vertical Position and Horizontal Position will be
+		ignored)
+
+What:           /sys/bus/acpi/devices/.../pld/vertical_position
+Date:           Feb, 2022
+Contact:        Won Chung <wonchung@google.com>
+Description:
+		0 - Upper
+		1 - Center
+		2 - Lower
+
+What:           /sys/bus/acpi/devices/.../pld/horizontal_position
+Date:           Feb, 2022
+Contact:        Won Chung <wonchung@google.com>
+Description:
+		ACPI specification does not define horizontal position field.
+		Can be used as either
+		0 - Left
+		1 - Center
+		2 - Right
+		or
+		0 - Leftmost
+		and higher numbers going toward the right.
+
+What:           /sys/bus/acpi/devices/.../pld/shape
+Date:           Feb, 2022
+Contact:        Won Chung <wonchung@google.com>
+Description:
+		Describes the shape of the device connection point.
+		0 - Round
+		1 - Oval
+		2 - Square
+		3 - Vertical Rectangle
+		4 - Horizontal Rectangle
+		5 - Vertical Trapezoid
+		6 - Horizontal Trapezoid
+		7 - Unknown - Shape rendered as a Rectangle with dotted lines
+		8 - Chamfered
+		15:9 - Reserved
+
diff --git a/drivers/acpi/device_sysfs.c b/drivers/acpi/device_sysfs.c
index d5d6403ba07b..610be93635a0 100644
--- a/drivers/acpi/device_sysfs.c
+++ b/drivers/acpi/device_sysfs.c
@@ -509,6 +509,49 @@ static ssize_t status_show(struct device *dev, struct =
device_attribute *attr,
 }
 static DEVICE_ATTR_RO(status);
=20
+#define DEV_ATTR_PLD_PROP(prop) \
+	static ssize_t prop##_show(struct device *dev, struct device_attribute *a=
ttr, \
+		char *buf) \
+{ \
+	struct acpi_device *acpi_dev =3D to_acpi_device(dev); \
+	if (acpi_dev->pld =3D=3D NULL) \
+		return -EIO; \
+	return sprintf(buf, "%u\n", acpi_dev->pld->prop); \
+}; \
+static DEVICE_ATTR_RO(prop)
+
+DEV_ATTR_PLD_PROP(revision);
+DEV_ATTR_PLD_PROP(group_token);
+DEV_ATTR_PLD_PROP(group_position);
+DEV_ATTR_PLD_PROP(user_visible);
+DEV_ATTR_PLD_PROP(dock);
+DEV_ATTR_PLD_PROP(bay);
+DEV_ATTR_PLD_PROP(lid);
+DEV_ATTR_PLD_PROP(panel);
+DEV_ATTR_PLD_PROP(vertical_position);
+DEV_ATTR_PLD_PROP(horizontal_position);
+DEV_ATTR_PLD_PROP(shape);
+
+static struct attribute *dev_attr_pld[] =3D {
+	&dev_attr_revision.attr,
+	&dev_attr_group_token.attr,
+	&dev_attr_group_position.attr,
+	&dev_attr_user_visible.attr,
+	&dev_attr_dock.attr,
+	&dev_attr_bay.attr,
+	&dev_attr_lid.attr,
+	&dev_attr_panel.attr,
+	&dev_attr_vertical_position.attr,
+	&dev_attr_horizontal_position.attr,
+	&dev_attr_shape.attr,
+	NULL,
+};
+
+static struct attribute_group dev_attr_pld_group =3D {
+	.name =3D "pld",
+	.attrs =3D dev_attr_pld,
+};
+
 /**
  * acpi_device_setup_files - Create sysfs attributes of an ACPI device.
  * @dev: ACPI device object.
@@ -595,6 +638,16 @@ int acpi_device_setup_files(struct acpi_device *dev)
 						    &dev_attr_real_power_state);
 	}
=20
+	if (acpi_has_method(dev->handle, "_PLD")) {
+		status =3D acpi_get_physical_device_location(dev->handle,
+			&dev->pld);
+		if (ACPI_FAILURE(status))
+			goto end;
+		result =3D device_add_group(&dev->dev, &dev_attr_pld_group);
+		if (result)
+			goto end;
+	}
+
 	acpi_expose_nondev_subnodes(&dev->dev.kobj, &dev->data);
=20
 end:
@@ -645,4 +698,6 @@ void acpi_device_remove_files(struct acpi_device *dev)
 		device_remove_file(&dev->dev, &dev_attr_status);
 	if (dev->handle)
 		device_remove_file(&dev->dev, &dev_attr_path);
+	if (acpi_has_method(dev->handle, "_PLD"))
+		device_remove_group(&dev->dev, &dev_attr_pld_group);
 }
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index ca88c4706f2b..929e726a666b 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -381,6 +381,7 @@ struct acpi_device {
 	struct acpi_hotplug_context *hp;
 	struct acpi_driver *driver;
 	const struct acpi_gpio_mapping *driver_gpios;
+	struct acpi_pld_info *pld;
 	void *driver_data;
 	struct device dev;
 	unsigned int physical_node_count;
--=20
2.35.0.rc2.247.g8bbb082509-goog

