Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 569151C27B4
	for <lists+linux-acpi@lfdr.de>; Sat,  2 May 2020 20:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728600AbgEBSaK (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 2 May 2020 14:30:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40803 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728439AbgEBSaJ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 2 May 2020 14:30:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588444209;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vWzxMqNlOC6t+ssQJeLOK12H0pCtC6V2Mp/yIbRouko=;
        b=hL5vRFCDP+60+0Ib2oAg9FLpA/NXnZWgtsYBgA7JAtNEWEr0lo5ewSiiux9+6VPAe1FfsL
        YL2y/uuqGaFwdP/LxAXUlWPVuh54rXf6SaTrUY5GNuAYaNrInOD0L7bAPvUJzFmALBh7U2
        1mbPjuiZdL3G1mFTZUGwR7NPQx+cxVQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-447-zhv_AHgHNl2pfLVhwXdKNQ-1; Sat, 02 May 2020 14:30:02 -0400
X-MC-Unique: zhv_AHgHNl2pfLVhwXdKNQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 65CB380B714;
        Sat,  2 May 2020 18:30:01 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-112-4.ams2.redhat.com [10.36.112.4])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 00911600E5;
        Sat,  2 May 2020 18:29:59 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Mario Limonciello <mario.limonciello@dell.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] platform/x86: intel-vbtn: Do not advertise switches to userspace if they are not there
Date:   Sat,  2 May 2020 20:29:49 +0200
Message-Id: <20200502182951.114231-4-hdegoede@redhat.com>
In-Reply-To: <20200502182951.114231-1-hdegoede@redhat.com>
References: <20200502182951.114231-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Content-Transfer-Encoding: quoted-printable
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Commit de9647efeaa9 ("platform/x86: intel-vbtn: Only activate tablet mode
switch on 2-in-1's") added a DMI chassis-type check to avoid accidentally
reporting SW_TABLET_MODE =3D 1 to userspace on laptops (specifically on t=
he
Dell XPS 9360), to avoid e.g. userspace ignoring touchpad events because
userspace thought the device was in tablet-mode.

But if we are not getting the initial status of the switch because the
device does not have a tablet mode, then we really should not advertise
the presence of a tablet-mode switch to userspace at all, as userspace ma=
y
use the mere presence of this switch for certain heuristics.

Fixes: de9647efeaa9 ("platform/x86: intel-vbtn: Only activate tablet mode=
 switch on 2-in-1's")
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/platform/x86/intel-vbtn.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/drivers/platform/x86/intel-vbtn.c b/drivers/platform/x86/int=
el-vbtn.c
index 634096cef21a..500fae82e12c 100644
--- a/drivers/platform/x86/intel-vbtn.c
+++ b/drivers/platform/x86/intel-vbtn.c
@@ -55,6 +55,7 @@ static const struct key_entry intel_vbtn_switchmap[] =3D=
 {
 struct intel_vbtn_priv {
 	struct key_entry keymap[KEYMAP_LEN];
 	struct input_dev *input_dev;
+	bool has_switches;
 	bool wakeup_mode;
 };
=20
@@ -70,7 +71,7 @@ static int intel_vbtn_input_setup(struct platform_devic=
e *device)
 		keymap_len +=3D ARRAY_SIZE(intel_vbtn_keymap);
 	}
=20
-	if (true) {
+	if (priv->has_switches) {
 		memcpy(&priv->keymap[keymap_len], intel_vbtn_switchmap,
 		       ARRAY_SIZE(intel_vbtn_switchmap) *
 		       sizeof(struct key_entry));
@@ -138,16 +139,12 @@ static void notify_handler(acpi_handle handle, u32 =
event, void *context)
=20
 static void detect_tablet_mode(struct platform_device *device)
 {
-	const char *chassis_type =3D dmi_get_system_info(DMI_CHASSIS_TYPE);
 	struct intel_vbtn_priv *priv =3D dev_get_drvdata(&device->dev);
 	acpi_handle handle =3D ACPI_HANDLE(&device->dev);
 	unsigned long long vgbs;
 	acpi_status status;
 	int m;
=20
-	if (!(chassis_type && strcmp(chassis_type, "31") =3D=3D 0))
-		return;
-
 	status =3D acpi_evaluate_integer(handle, "VGBS", NULL, &vgbs);
 	if (ACPI_FAILURE(status))
 		return;
@@ -158,6 +155,19 @@ static void detect_tablet_mode(struct platform_devic=
e *device)
 	input_report_switch(priv->input_dev, SW_DOCK, m);
 }
=20
+static bool intel_vbtn_has_switches(acpi_handle handle)
+{
+	const char *chassis_type =3D dmi_get_system_info(DMI_CHASSIS_TYPE);
+	unsigned long long vgbs;
+	acpi_status status;
+
+	if (!(chassis_type && strcmp(chassis_type, "31") =3D=3D 0))
+		return false;
+
+	status =3D acpi_evaluate_integer(handle, "VGBS", NULL, &vgbs);
+	return ACPI_SUCCESS(status);
+}
+
 static int intel_vbtn_probe(struct platform_device *device)
 {
 	acpi_handle handle =3D ACPI_HANDLE(&device->dev);
@@ -176,13 +186,16 @@ static int intel_vbtn_probe(struct platform_device =
*device)
 		return -ENOMEM;
 	dev_set_drvdata(&device->dev, priv);
=20
+	priv->has_switches =3D intel_vbtn_has_switches(handle);
+
 	err =3D intel_vbtn_input_setup(device);
 	if (err) {
 		pr_err("Failed to setup Intel Virtual Button\n");
 		return err;
 	}
=20
-	detect_tablet_mode(device);
+	if (priv->has_switches)
+		detect_tablet_mode(device);
=20
 	status =3D acpi_install_notify_handler(handle,
 					     ACPI_DEVICE_NOTIFY,
--=20
2.26.0

