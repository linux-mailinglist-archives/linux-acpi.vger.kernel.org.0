Return-Path: <linux-acpi+bounces-9483-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CF549C2FAD
	for <lists+linux-acpi@lfdr.de>; Sat,  9 Nov 2024 22:59:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97FC1B212EF
	for <lists+linux-acpi@lfdr.de>; Sat,  9 Nov 2024 21:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90F461A0711;
	Sat,  9 Nov 2024 21:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z85MuH5J"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA41145B24
	for <linux-acpi@vger.kernel.org>; Sat,  9 Nov 2024 21:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731189591; cv=none; b=JRznd/B2Rzse9YwiWDT91ZqZAAVKdtcktT6nFuwdeh+1NDsmprLtuBDzOI4SjcD6sheTbrZMeLTzVyPSE/ygLcHS9+7QfHLphLx6XTHph6nqpAUYUPwOWZ0fCY30UcBGm81dSaqRGpx3RpZCg0H6gFSHtZE01Zpk4yVYFeOwXoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731189591; c=relaxed/simple;
	bh=DrH+r4V+hmUjuc3bVPIFQLKTw2Bm52Mm+K5CjLphAO0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f7MxZQHtVVGiwynQpp7sckdxgD/+qZbGqgDfLTBZPbWuaqfZNtjbh5NnBNoAit63Ll/0Cz2vQ1n/mnZP7gWhu+vAfB2WYhK1CT9BZk++36m/NogKgZVu8vDdivYI5vplXRTobOEKEwI7H1akJusxLCVd32P6fC6klP7nZdhLo7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z85MuH5J; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731189588;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rqHEorfea4+g+Qr30u/nJdVKWzrB7nqrtIzUZ6lzj+c=;
	b=Z85MuH5JBYyVFA2cVdzPUqJ8tuNIbQbBZ5twgP7Scn1px2+Fb09xSj5tDvJ7tJrFyU9dJ6
	iCR/zmXWP5TcCloScSL1jBCvEYRpFrFW0R8vXnYjcIThCd0NXvSrW6yF2p4FAwURhjc3cg
	jEYZ/EMXsrAyxXT/EG34+v1FgYSDxtQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-10-7Nx5wCobPFODqlf8NUtTJA-1; Sat,
 09 Nov 2024 16:59:44 -0500
X-MC-Unique: 7Nx5wCobPFODqlf8NUtTJA-1
X-Mimecast-MFC-AGG-ID: 7Nx5wCobPFODqlf8NUtTJA
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BD85419560AA;
	Sat,  9 Nov 2024 21:59:43 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.21])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4F0A7300019E;
	Sat,  9 Nov 2024 21:59:42 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	linux-acpi@vger.kernel.org
Subject: [PATCH] ACPI: x86: Make UART skip quirks work on PCI UARTs without an UID
Date: Sat,  9 Nov 2024 22:59:36 +0100
Message-ID: <20241109215936.83004-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

The Vexia EDU ATLA 10 tablet (9V version) which shipped with Android 4.2
as factory OS has the usual broken DSDT issues for x86 Android tablets.

On top of that this tablet is special because all its LPSS island
peripherals are enumerated as PCI devices rather then as ACPI devices as
they typically are.

For the x86-android-tablets kmod to be able to instantiate a serdev client
for the Bluetooth HCI on this tablet, an ACPI_QUIRK_UART1_SKIP quirk is
necessary.

Modify acpi_dmi_skip_serdev_enumeration() to work with PCI enumerated
UARTs without an UID, such as the UARTs on this tablet.

Also make acpi_dmi_skip_serdev_enumeration() exit early if there are no
quirks, since there is nothing to do then.

And add the necessary quirks for the Vexia EDU ATLA 10 tablet.

This should compile with CONFIG_PCI being unset without issues because
dev_is_pci() is defined as "(false)" then.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/x86/utils.c | 49 ++++++++++++++++++++++++++++++++--------
 1 file changed, 40 insertions(+), 9 deletions(-)

diff --git a/drivers/acpi/x86/utils.c b/drivers/acpi/x86/utils.c
index 6af546b21574..3eec889d4f5f 100644
--- a/drivers/acpi/x86/utils.c
+++ b/drivers/acpi/x86/utils.c
@@ -12,6 +12,7 @@
 
 #include <linux/acpi.h>
 #include <linux/dmi.h>
+#include <linux/pci.h>
 #include <linux/platform_device.h>
 #include <asm/cpu_device_id.h>
 #include <asm/intel-family.h>
@@ -391,6 +392,19 @@ static const struct dmi_system_id acpi_quirk_skip_dmi_ids[] = {
 		.driver_data = (void *)(ACPI_QUIRK_SKIP_I2C_CLIENTS |
 					ACPI_QUIRK_SKIP_ACPI_AC_AND_BATTERY),
 	},
+	{
+		/* Vexia Edu Atla 10 tablet 9V version */
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "AMI Corporation"),
+			DMI_MATCH(DMI_BOARD_NAME, "Aptio CRB"),
+			/* Above strings are too generic, also match on BIOS date */
+			DMI_MATCH(DMI_BIOS_DATE, "08/25/2014"),
+		},
+		.driver_data = (void *)(ACPI_QUIRK_SKIP_I2C_CLIENTS |
+					ACPI_QUIRK_UART1_SKIP |
+					ACPI_QUIRK_SKIP_ACPI_AC_AND_BATTERY |
+					ACPI_QUIRK_SKIP_GPIO_EVENT_HANDLERS),
+	},
 	{
 		/* Whitelabel (sold as various brands) TM800A550L */
 		.matches = {
@@ -439,18 +453,35 @@ static int acpi_dmi_skip_serdev_enumeration(struct device *controller_parent, bo
 	struct acpi_device *adev = ACPI_COMPANION(controller_parent);
 	const struct dmi_system_id *dmi_id;
 	long quirks = 0;
-	u64 uid;
-	int ret;
-
-	ret = acpi_dev_uid_to_integer(adev, &uid);
-	if (ret)
-		return 0;
+	u64 uid = 0;
 
 	dmi_id = dmi_first_match(acpi_quirk_skip_dmi_ids);
-	if (dmi_id)
-		quirks = (unsigned long)dmi_id->driver_data;
+	if (!dmi_id)
+		return 0;
 
-	if (!dev_is_platform(controller_parent)) {
+	quirks = (unsigned long)dmi_id->driver_data;
+
+	/* uid is left at 0 on errors and 0 is not a valid UART UID */
+	acpi_dev_uid_to_integer(adev, &uid);
+
+	/* For PCI UARTs without an UID */
+	if (!uid && dev_is_pci(controller_parent)) {
+		struct pci_dev *pdev = to_pci_dev(controller_parent);
+
+		/*
+		 * Devfn values for PCI UARTs on Bay Trail SoCs, which are
+		 * the only devices where this fallback is necessary.
+		 */
+		if (pdev->devfn == PCI_DEVFN(0x1e, 3))
+			uid = 1;
+		else if (pdev->devfn == PCI_DEVFN(0x1e, 4))
+			uid = 2;
+	}
+
+	if (!uid)
+		return 0;
+
+	if (!dev_is_platform(controller_parent) && !dev_is_pci(controller_parent)) {
 		/* PNP enumerated UARTs */
 		if ((quirks & ACPI_QUIRK_PNP_UART1_SKIP) && uid == 1)
 			*skip = true;
-- 
2.47.0


