Return-Path: <linux-acpi+bounces-4301-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A77287A1C8
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Mar 2024 04:03:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6304B1C21A69
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Mar 2024 03:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE612C144;
	Wed, 13 Mar 2024 03:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="IIkfJKG+"
X-Original-To: linux-acpi@vger.kernel.org
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E85D51A
	for <linux-acpi@vger.kernel.org>; Wed, 13 Mar 2024 03:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710298988; cv=none; b=sxAs2UqD+vpWuVSDGNtrweleR+ZKKT5zBiIRPF44bZrotucJUgFcSb00h69LiNI+8WwDdNoEJNwFAG5nF8rPmBqWBCvnNXafAZokhcqX2YfUG7D0h5LTy+Rjsr7mBdkOnEv3TrfG16g0OUFX0uSMLvowfZ4s3G9hSp+Mk7YqdaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710298988; c=relaxed/simple;
	bh=gFW5hMTbaG1K47hGfNLNUOgpap+1DIiUz88Htc00KHs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DHJmYcE1qq6CeSZP3m7Suo2Z7td9chf1ELAHZPK123uDbaB4ulhTyIpjyESjx1DB3wIZ/npcDN6WUKAMOiUowRuhetoQqWMkUynjXAKDosCH56m5lgmpqTMby561aEWxCtuO1c53viY85yStWkjloYMz8SXCqxZHy9NDBXMtPRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=IIkfJKG+; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 3A38E2C03B6;
	Wed, 13 Mar 2024 16:03:03 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1710298983;
	bh=/oXEFZFkNeReiz2Qe1ck1mRocFWyHSVCru3ultVwEQ4=;
	h=From:To:Cc:Subject:Date:From;
	b=IIkfJKG+oZVGHiYCak2oaFPsilWdr7u/IiNuEcU78/fL6hoQqBti4cc9tPTG6EyYy
	 nWVDGelhPAB5RQof0Cu3YQtwmUAR9FvsinxaL50bEDlEsjMvmJkzTGLOuZfE8mAkkv
	 S36/1YnBOtI2paNdXWejl9abN8Ahg+wy/kEpkiNpQgljNwbcyofc8a+NL6ADBXHoHA
	 lcYdrI0uBJ45Yupoa+klXxeNuhIjELXKWZLj3dU1YUTuz3IDs6BVZqDostWkdLofAr
	 1nj/sZBhN2WQ8QJTOqGR1TWDgWemKAGlsuCRJeKQrqfonvzAaS3suc4bF6zhW2YTII
	 XInkZF0PQ7N9A==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B65f117660000>; Wed, 13 Mar 2024 16:03:02 +1300
Received: from hamishm-dl.ws.atlnz.lc (hamishm-dl.ws.atlnz.lc [10.33.24.13])
	by pat.atlnz.lc (Postfix) with ESMTP id F37C413ED56;
	Wed, 13 Mar 2024 16:03:02 +1300 (NZDT)
Received: by hamishm-dl.ws.atlnz.lc (Postfix, from userid 1133)
	id F119124092D; Wed, 13 Mar 2024 16:03:02 +1300 (NZDT)
From: Hamish Martin <hamish.martin@alliedtelesis.co.nz>
To: mika.westerberg@linux.intel.com,
	andriy.shevchenko@linux.intel.com,
	linus.walleij@linaro.org,
	brgl@bgdev.pl
Cc: linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	Hamish Martin <hamish.martin@alliedtelesis.co.nz>
Subject: [PATCH] gpiolib: acpi: Move storage of acpi_gpio_chip
Date: Wed, 13 Mar 2024 16:02:51 +1300
Message-ID: <20240313030251.1049624-1-hamish.martin@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.4 cv=BKkQr0QG c=1 sm=1 tr=0 ts=65f11767 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=K6JAEmCyrfEA:10 a=4Qf1ARyw2_cHiD8XAKQA:9 a=3ZKOabzyN94A:10
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat

A memory leak occurs in a scenario where an ACPI SSDT overlay is removed
and that is the trigger for the removal of the acpi_gpio_chip.
This occurs because we use the ACPI_HANDLE of the chip->parent as a
convenient location to tie the 'struct acpi_gpio_chip' to, using
acpi_attach_data().
This is fine in the usual case of removal of the 'struct acpi_gpio_chip'
via a call to acpi_gpiochip_remove() because usually the ACPI data is
still valid.
But in the case of an SSDT overlay removal, the ACPI data has been
marked as invalid before the removal code is triggered (see the setting
of the acpi_device handle to INVALID_ACPI_HANDLE in
acpi_scan_drop_device()). This means that by the time we execute
acpi_gpiochip_remove(), the handles are invalid and we are unable to
retrieve the 'struct acpi_gpio_chip' using acpi_get_data(). Unable to
get our data, we hit the failure case and see the following warning
logged:
  Failed to retrieve ACPI GPIO chip
This means we also fail to kfree() the struct at the end of
acpi_gpiochip_remove().

The fix is to no longer tie the acpi_gpio_chip data to the ACPI data,
but instead hang it directly from the 'struct gpio_chip' with a new
field. This decouples the lifecycle of the acpi_gpio_chip from the ACPI
data, and ties it to the gpio_chip. This seems a much better place since
they share a common lifecycle.

The general concept of attaching data to the ACPI objects may also need
revisiting in light of the issue this patch addresses. For instance
i2c_acpi_remove_space_handler() is vulnerable to a similar leak due to
using acpi_bus_get_private_data(), which just wraps acpi_attach_data().
This may need a more widespread change than is addressed in this patch.

Signed-off-by: Hamish Martin <hamish.martin@alliedtelesis.co.nz>
---
 drivers/gpio/gpiolib-acpi.c | 57 ++++++++-----------------------------
 include/linux/gpio/driver.h |  4 +++
 2 files changed, 16 insertions(+), 45 deletions(-)

diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index cd3e9657cc36..14d29902391f 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -180,11 +180,6 @@ static irqreturn_t acpi_gpio_irq_handler_evt(int irq=
, void *data)
 	return IRQ_HANDLED;
 }
=20
-static void acpi_gpio_chip_dh(acpi_handle handle, void *data)
-{
-	/* The address of this function is used as a key. */
-}
-
 bool acpi_gpio_get_irq_resource(struct acpi_resource *ares,
 				struct acpi_resource_gpio **agpio)
 {
@@ -500,18 +495,17 @@ void acpi_gpiochip_request_interrupts(struct gpio_c=
hip *chip)
 {
 	struct acpi_gpio_chip *acpi_gpio;
 	acpi_handle handle;
-	acpi_status status;
 	bool defer;
=20
 	if (!chip->parent || !chip->to_irq)
 		return;
=20
-	handle =3D ACPI_HANDLE(chip->parent);
-	if (!handle)
+	acpi_gpio =3D chip->acpi_gpio;
+	if (!acpi_gpio)
 		return;
=20
-	status =3D acpi_get_data(handle, acpi_gpio_chip_dh, (void **)&acpi_gpio=
);
-	if (ACPI_FAILURE(status))
+	handle =3D ACPI_HANDLE(chip->parent);
+	if (!handle)
 		return;
=20
 	if (acpi_quirk_skip_gpio_event_handlers())
@@ -545,18 +539,12 @@ void acpi_gpiochip_free_interrupts(struct gpio_chip=
 *chip)
 {
 	struct acpi_gpio_chip *acpi_gpio;
 	struct acpi_gpio_event *event, *ep;
-	acpi_handle handle;
-	acpi_status status;
=20
 	if (!chip->parent || !chip->to_irq)
 		return;
=20
-	handle =3D ACPI_HANDLE(chip->parent);
-	if (!handle)
-		return;
-
-	status =3D acpi_get_data(handle, acpi_gpio_chip_dh, (void **)&acpi_gpio=
);
-	if (ACPI_FAILURE(status))
+	acpi_gpio =3D chip->acpi_gpio;
+	if (!acpi_gpio)
 		return;
=20
 	mutex_lock(&acpi_gpio_deferred_req_irqs_lock);
@@ -1218,15 +1206,10 @@ static void acpi_gpiochip_free_regions(struct acp=
i_gpio_chip *achip)
 	struct gpio_chip *chip =3D achip->chip;
 	acpi_handle handle =3D ACPI_HANDLE(chip->parent);
 	struct acpi_gpio_connection *conn, *tmp;
-	acpi_status status;
=20
-	status =3D acpi_remove_address_space_handler(handle, ACPI_ADR_SPACE_GPI=
O,
-						   acpi_gpio_adr_space_handler);
-	if (ACPI_FAILURE(status)) {
-		dev_err(chip->parent,
-			"Failed to remove GPIO OpRegion handler\n");
-		return;
-	}
+	/* Ignore the return status as the handle is likely no longer valid. */
+	acpi_remove_address_space_handler(handle, ACPI_ADR_SPACE_GPIO,
+					  acpi_gpio_adr_space_handler);
=20
 	list_for_each_entry_safe_reverse(conn, tmp, &achip->conns, node) {
 		gpiochip_free_own_desc(conn->desc);
@@ -1310,7 +1293,6 @@ void acpi_gpiochip_add(struct gpio_chip *chip)
 {
 	struct acpi_gpio_chip *acpi_gpio;
 	struct acpi_device *adev;
-	acpi_status status;
=20
 	if (!chip || !chip->parent)
 		return;
@@ -1327,16 +1309,10 @@ void acpi_gpiochip_add(struct gpio_chip *chip)
 	}
=20
 	acpi_gpio->chip =3D chip;
+	chip->acpi_gpio =3D acpi_gpio;
 	INIT_LIST_HEAD(&acpi_gpio->events);
 	INIT_LIST_HEAD(&acpi_gpio->deferred_req_irqs_list_entry);
=20
-	status =3D acpi_attach_data(adev->handle, acpi_gpio_chip_dh, acpi_gpio)=
;
-	if (ACPI_FAILURE(status)) {
-		dev_err(chip->parent, "Failed to attach ACPI GPIO chip\n");
-		kfree(acpi_gpio);
-		return;
-	}
-
 	acpi_gpiochip_request_regions(acpi_gpio);
 	acpi_gpiochip_scan_gpios(acpi_gpio);
 	acpi_dev_clear_dependencies(adev);
@@ -1345,25 +1321,16 @@ void acpi_gpiochip_add(struct gpio_chip *chip)
 void acpi_gpiochip_remove(struct gpio_chip *chip)
 {
 	struct acpi_gpio_chip *acpi_gpio;
-	acpi_handle handle;
-	acpi_status status;
=20
 	if (!chip || !chip->parent)
 		return;
=20
-	handle =3D ACPI_HANDLE(chip->parent);
-	if (!handle)
+	acpi_gpio =3D chip->acpi_gpio;
+	if (!acpi_gpio)
 		return;
=20
-	status =3D acpi_get_data(handle, acpi_gpio_chip_dh, (void **)&acpi_gpio=
);
-	if (ACPI_FAILURE(status)) {
-		dev_warn(chip->parent, "Failed to retrieve ACPI GPIO chip\n");
-		return;
-	}
-
 	acpi_gpiochip_free_regions(acpi_gpio);
=20
-	acpi_detach_data(handle, acpi_gpio_chip_dh);
 	kfree(acpi_gpio);
 }
=20
diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
index 7f75c9a51874..698b92b1764c 100644
--- a/include/linux/gpio/driver.h
+++ b/include/linux/gpio/driver.h
@@ -529,6 +529,10 @@ struct gpio_chip {
 	int (*of_xlate)(struct gpio_chip *gc,
 			const struct of_phandle_args *gpiospec, u32 *flags);
 #endif /* CONFIG_OF_GPIO */
+
+#ifdef CONFIG_GPIO_ACPI
+	struct acpi_gpio_chip *acpi_gpio;
+#endif /* CONFIG_GPIO_ACPI */
 };
=20
 char *gpiochip_dup_line_label(struct gpio_chip *gc, unsigned int offset)=
;
--=20
2.43.2


