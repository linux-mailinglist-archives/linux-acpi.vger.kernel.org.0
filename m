Return-Path: <linux-acpi+bounces-21249-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0EXXEgwGo2lo9AQAu9opvQ
	(envelope-from <linux-acpi+bounces-21249-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Sat, 28 Feb 2026 16:13:16 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B7B741C3D2A
	for <lists+linux-acpi@lfdr.de>; Sat, 28 Feb 2026 16:13:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8FC0C3077F35
	for <lists+linux-acpi@lfdr.de>; Sat, 28 Feb 2026 15:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9EEC4534A9;
	Sat, 28 Feb 2026 15:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cj+GcvzJ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F5F2D6E55;
	Sat, 28 Feb 2026 15:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772291591; cv=none; b=n1s/neR88e7btd7Ek22XHV/HeS+D07TFoufUdTolzJpuQ0tNAJej1U3PJB6nhTHJH27eFvPjONB2RHh28MXRX4qJiFEoTjRzT/Eu8+JHIGOaq4AvJFuPbbEuuX8Ixdyxj83yo596kgq8T/bh9axZcHJDrBM/DlRkNMEO4XkvscQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772291591; c=relaxed/simple;
	bh=aoeMEMRii655SwLJrzFvfKxjQCC/8fuBn8cmCM6K81s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eFZLuuwCkOxf9Fd5HmdO5FtJpw8HcW+jXexvKMd4nI9+yvrHzg52kFv8fDFXZ+h2/2o4ByHr5prHMM1+qa9d6xEqnX/LMHj8ip7TrPBuYsAj0LeuEBaXH71flWeRsqsATx+5H9Dv1W2T9sPTgi2co9oUg/YEomQZOyI3QgsTJXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cj+GcvzJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D347C116D0;
	Sat, 28 Feb 2026 15:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772291591;
	bh=aoeMEMRii655SwLJrzFvfKxjQCC/8fuBn8cmCM6K81s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Cj+GcvzJZKWvKsH3RtLJ8fqTxV5NuJqGlx2sbkDawVuzpu/rQQiZrpI3El01oXHdm
	 MUIw3c9eyKbTv7xNkX9XIDorS+2dKgoxbeu6yeu6PrA5Q8vuB9SFYLJGtO/kDG758x
	 Sudmb2dyESw9pjgn4MtukrPRnSBBOrz8YJ+0j36E3HmKOZScAAqu7rLLoI7vUy/qcP
	 sxvq3UohoOyCoLqyTU0qi9NF4XGUGgkPjyFIbEgcuyqkneTmTQ0VXX+Px16VKTeBat
	 he8uVcwOnsxCiX1FWIxU41VHDPt6h2NjWEyxIxtVaOkjGhrDN1bX1QRCeZKoZfxY5v
	 NZv48lBhFLGTQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Hans de Goede <hansg@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>, platform-driver-x86@vger.kernel.org,
 Corentin Chary <corentin.chary@gmail.com>, "Luke D. Jones" <luke@ljones.dev>,
 Denis Benato <benato.denis96@gmail.com>,
 =?ISO-8859-1?Q?Jo=E3o?= Paulo Rechi Vita <jprvita@gmail.com>
Subject:
 [PATCH v1 4/4] platform/x86: asus-wireless: Convert ACPI driver to a platform
 one
Date: Sat, 28 Feb 2026 16:12:48 +0100
Message-ID: <13959361.uLZWGnKmhe@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <5971620.DvuYhMxLoT@rafael.j.wysocki>
References: <5971620.DvuYhMxLoT@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21249-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	HAS_ORG_HEADER(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com,ljones.dev];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-acpi@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,rafael.j.wysocki:mid]
X-Rspamd-Queue-Id: B7B741C3D2A
X-Rspamd-Action: no action

=46rom: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

In all cases in which a struct acpi_driver is used for binding a driver
to an ACPI device object, a corresponding platform device is created by
the ACPI core and that device is regarded as a proper representation of
underlying hardware.  Accordingly, a struct platform_driver should be
used by driver code to bind to that device.  There are multiple reasons
why drivers should not bind directly to ACPI device objects [1].

Overall, it is better to bind drivers to platform devices than to their
ACPI companions, so convert the Asus wireless ACPI driver to a platform
one.

After this change, the subordinate input and LED devices will be
registered under the platform device used for driver binding instead of
its ACPI companion.

While this is not expected to alter functionality, it changes sysfs
layout and so it will be visible to user space.

Link: https://lore.kernel.org/all/2396510.ElGaqSPkdT@rafael.j.wysocki/ [1]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
=2D--
 drivers/platform/x86/asus-wireless.c | 39 +++++++++++++++-------------
 1 file changed, 21 insertions(+), 18 deletions(-)

diff --git a/drivers/platform/x86/asus-wireless.c b/drivers/platform/x86/as=
us-wireless.c
index 45d41875c515..2b494bf3cba8 100644
=2D-- a/drivers/platform/x86/asus-wireless.c
+++ b/drivers/platform/x86/asus-wireless.c
@@ -12,6 +12,7 @@
 #include <linux/acpi.h>
 #include <linux/input.h>
 #include <linux/pci_ids.h>
+#include <linux/platform_device.h>
 #include <linux/leds.h>
=20
 struct hswc_params {
@@ -124,19 +125,22 @@ static void asus_wireless_notify(acpi_handle handle, =
u32 event, void *context)
 	input_sync(data->idev);
 }
=20
=2Dstatic int asus_wireless_add(struct acpi_device *adev)
+static int asus_wireless_probe(struct platform_device *pdev)
 {
+	struct acpi_device *adev =3D ACPI_COMPANION(&pdev->dev);
 	struct asus_wireless_data *data;
 	const struct acpi_device_id *id;
 	int err;
=20
=2D	data =3D devm_kzalloc(&adev->dev, sizeof(*data), GFP_KERNEL);
+	data =3D devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
=2D	adev->driver_data =3D data;
+
+	platform_set_drvdata(pdev, data);
+
 	data->adev =3D adev;
=20
=2D	data->idev =3D devm_input_allocate_device(&adev->dev);
+	data->idev =3D devm_input_allocate_device(&pdev->dev);
 	if (!data->idev)
 		return -ENOMEM;
 	data->idev->name =3D "Asus Wireless Radio Control";
@@ -165,14 +169,14 @@ static int asus_wireless_add(struct acpi_device *adev)
 	data->led.flags =3D LED_CORE_SUSPENDRESUME;
 	data->led.max_brightness =3D 1;
 	data->led.default_trigger =3D "rfkill-none";
=2D	err =3D devm_led_classdev_register(&adev->dev, &data->led);
+	err =3D devm_led_classdev_register(&pdev->dev, &data->led);
 	if (err)
 		goto err;
=20
 	err =3D acpi_dev_install_notify_handler(adev, ACPI_DEVICE_NOTIFY,
 					      asus_wireless_notify, data);
 	if (err) {
=2D		devm_led_classdev_unregister(&adev->dev, &data->led);
+		devm_led_classdev_unregister(&pdev->dev, &data->led);
 		goto err;
 	}
 	return 0;
@@ -182,28 +186,27 @@ static int asus_wireless_add(struct acpi_device *adev)
 	return err;
 }
=20
=2Dstatic void asus_wireless_remove(struct acpi_device *adev)
+static void asus_wireless_remove(struct platform_device *pdev)
 {
=2D	struct asus_wireless_data *data =3D acpi_driver_data(adev);
+	struct asus_wireless_data *data =3D platform_get_drvdata(pdev);
=20
=2D	acpi_dev_remove_notify_handler(adev, ACPI_DEVICE_NOTIFY,
+	acpi_dev_remove_notify_handler(data->adev, ACPI_DEVICE_NOTIFY,
 				       asus_wireless_notify);
 	if (data->wq) {
=2D		devm_led_classdev_unregister(&adev->dev, &data->led);
+		devm_led_classdev_unregister(&pdev->dev, &data->led);
 		destroy_workqueue(data->wq);
 	}
 }
=20
=2Dstatic struct acpi_driver asus_wireless_driver =3D {
=2D	.name =3D "Asus Wireless Radio Control Driver",
=2D	.class =3D "hotkey",
=2D	.ids =3D device_ids,
=2D	.ops =3D {
=2D		.add =3D asus_wireless_add,
=2D		.remove =3D asus_wireless_remove,
+static struct platform_driver asus_wireless_driver =3D {
+	.probe =3D asus_wireless_probe,
+	.remove =3D asus_wireless_remove,
+	.driver =3D {
+		.name =3D "Asus Wireless Radio Control Driver",
+		.acpi_match_table =3D device_ids,
 	},
 };
=2Dmodule_acpi_driver(asus_wireless_driver);
+module_platform_driver(asus_wireless_driver);
=20
 MODULE_DESCRIPTION("Asus Wireless Radio Control Driver");
 MODULE_AUTHOR("Jo=C3=A3o Paulo Rechi Vita <jprvita@gmail.com>");
=2D-=20
2.51.0





