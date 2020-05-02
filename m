Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F176B1C27B0
	for <lists+linux-acpi@lfdr.de>; Sat,  2 May 2020 20:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728588AbgEBSaG (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 2 May 2020 14:30:06 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22204 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728573AbgEBSaE (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 2 May 2020 14:30:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588444203;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zcEcrCn5D0OhCHYjh6wHfqw4y+Glm2KA2NUo7TRLpVo=;
        b=LK69Wu4+EJh+k6IjkGRI9Rz02ejdLd23o9FZXmp1zHfHZ2zrFtnMvokZnFQbsYnQLGYie3
        x9bclvu4PghFgXZkxSZgEUwsD5K7fLxMdI+MKYRVoR8XbbsMXYTWFnR6NObRfcfNtnW8g3
        lhPmOmBo5DvHtZQsD0vF9sX1nktrbdo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-514-8YzLH5AWOl-R9M4Zaz63Gg-1; Sat, 02 May 2020 14:29:59 -0400
X-MC-Unique: 8YzLH5AWOl-R9M4Zaz63Gg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F0891100960F;
        Sat,  2 May 2020 18:29:57 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-112-4.ams2.redhat.com [10.36.112.4])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 30E5C600E5;
        Sat,  2 May 2020 18:29:55 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Mario Limonciello <mario.limonciello@dell.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] platform/x86: intel-vbtn: Use acpi_evaluate_integer()
Date:   Sat,  2 May 2020 20:29:47 +0200
Message-Id: <20200502182951.114231-2-hdegoede@redhat.com>
In-Reply-To: <20200502182951.114231-1-hdegoede@redhat.com>
References: <20200502182951.114231-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Content-Transfer-Encoding: quoted-printable
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Use acpi_evaluate_integer() instead of open-coding it.

This is a preparation patch for adding a intel_vbtn_has_switches()
helper function.

Fixes: de9647efeaa9 ("platform/x86: intel-vbtn: Only activate tablet mode=
 switch on 2-in-1's")
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

