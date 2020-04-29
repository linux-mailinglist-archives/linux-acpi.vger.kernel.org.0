Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86C891BDA05
	for <lists+linux-acpi@lfdr.de>; Wed, 29 Apr 2020 12:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726677AbgD2KpX (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 29 Apr 2020 06:45:23 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:27881 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726523AbgD2KpW (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 29 Apr 2020 06:45:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588157121;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=CfchcXkhkrZSiqgfVUqdKBtxhVgWGmRJOsKZunO02Ds=;
        b=Ej94sUyZJ+EAz8+b/W4tVmVxkF/TuHK2uw6VHprFOSaRYv9PPws28vS8ysar9+wqwavENk
        sEql6TzI4FA21Y1kevGeUezFjADnBeSKLPKEwN9Nc2z3GqFT9lbRlh+Lf4F2d807XKJIWy
        V9GGSoJM8ymjZu2mVwBtU7PS1STVORM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-433-4K8GpWTkNcGThkaEvporDg-1; Wed, 29 Apr 2020 06:45:19 -0400
X-MC-Unique: 4K8GpWTkNcGThkaEvporDg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8C7451B2C983;
        Wed, 29 Apr 2020 10:45:18 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-115-57.ams2.redhat.com [10.36.115.57])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 349EB5D9E5;
        Wed, 29 Apr 2020 10:45:17 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-gpio@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: [PATCH] platform/x86: intel-vbtn: Use acpi_evaluate_integer()
Date:   Wed, 29 Apr 2020 12:45:15 +0200
Message-Id: <20200429104515.63570-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Content-Transfer-Encoding: quoted-printable
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Use acpi_evaluate_integer() instead of open-coding it.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/platform/x86/intel-vbtn.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/drivers/platform/x86/intel-vbtn.c b/drivers/platform/x86/int=
el-vbtn.c
index b5880936d785..191894d648bb 100644
--- a/drivers/platform/x86/intel-vbtn.c
+++ b/drivers/platform/x86/intel-vbtn.c
@@ -119,28 +119,21 @@ static void detect_tablet_mode(struct platform_devi=
ce *device)
 	const char *chassis_type =3D dmi_get_system_info(DMI_CHASSIS_TYPE);
 	struct intel_vbtn_priv *priv =3D dev_get_drvdata(&device->dev);
 	acpi_handle handle =3D ACPI_HANDLE(&device->dev);
-	struct acpi_buffer vgbs_output =3D { ACPI_ALLOCATE_BUFFER, NULL };
-	union acpi_object *obj;
+	unsigned long long vgbs;
 	acpi_status status;
 	int m;
=20
 	if (!(chassis_type && strcmp(chassis_type, "31") =3D=3D 0))
-		goto out;
+		return;
=20
-	status =3D acpi_evaluate_object(handle, "VGBS", NULL, &vgbs_output);
+	status =3D acpi_evaluate_integer(handle, "VGBS", NULL, &vgbs);
 	if (ACPI_FAILURE(status))
-		goto out;
-
-	obj =3D vgbs_output.pointer;
-	if (!(obj && obj->type =3D=3D ACPI_TYPE_INTEGER))
-		goto out;
+		return;
=20
-	m =3D !(obj->integer.value & TABLET_MODE_FLAG);
+	m =3D !(vgbs & TABLET_MODE_FLAG);
 	input_report_switch(priv->input_dev, SW_TABLET_MODE, m);
-	m =3D (obj->integer.value & DOCK_MODE_FLAG) ? 1 : 0;
+	m =3D (vgbs & DOCK_MODE_FLAG) ? 1 : 0;
 	input_report_switch(priv->input_dev, SW_DOCK, m);
-out:
-	kfree(vgbs_output.pointer);
 }
=20
 static int intel_vbtn_probe(struct platform_device *device)
--=20
2.26.0

