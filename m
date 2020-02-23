Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3209169812
	for <lists+linux-acpi@lfdr.de>; Sun, 23 Feb 2020 15:29:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbgBWO3v (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 23 Feb 2020 09:29:51 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:45880 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726490AbgBWO3v (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Sun, 23 Feb 2020 09:29:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582468190;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5tPAEitkZkP4qj5iTmbxQ0xqVpp7vgl4rO3MxdieB8k=;
        b=GKlTrxnv82NAo13+hx9TX8J3S3xBPftI2CDLOUmwbH36hm0Fsh+UHYFbr24VovaHh/O9AS
        AltUgVinYWN69s7bhAHvPFrmFhuBkAtJPAJfkwmMWMSdbsbXP9oaufTtEXlGHUEPazrxXI
        urg105iB2+LrXNWlW0KAnK9h8iFDqio=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-23-Ef_ompNIOKumoEbXUPnkQA-1; Sun, 23 Feb 2020 09:29:46 -0500
X-MC-Unique: Ef_ompNIOKumoEbXUPnkQA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CD830800D53;
        Sun, 23 Feb 2020 14:29:44 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-116-120.ams2.redhat.com [10.36.116.120])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CD7601001B07;
        Sun, 23 Feb 2020 14:29:43 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org
Subject: [PATCH 1/2] ACPI / AC: Cleanup DMI quirk table
Date:   Sun, 23 Feb 2020 15:29:40 +0100
Message-Id: <20200223142941.60705-2-hdegoede@redhat.com>
In-Reply-To: <20200223142941.60705-1-hdegoede@redhat.com>
References: <20200223142941.60705-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Content-Transfer-Encoding: quoted-printable
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The 3 different entries we have sofar all use different identation and
2 of the use DMI_MATCH where as 1 unnecessarily used DMI_EXACT_MATCH
Fix this to just use full tab idents for each level and DMI_MATCH
everywhere and sort the entries alphabetically.

Also add a bit of text to the comments explaining why the quirk is
necessary.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/ac.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/acpi/ac.c b/drivers/acpi/ac.c
index 829f37d36b9f..69d2db13886b 100644
--- a/drivers/acpi/ac.c
+++ b/drivers/acpi/ac.c
@@ -293,29 +293,30 @@ static int __init ac_do_not_check_pmic_quirk(const =
struct dmi_system_id *d)
 	return 0;
 }
=20
+/* Please keep this list alphabetically sorted */
 static const struct dmi_system_id ac_dmi_table[]  __initconst =3D {
 	{
-	/* Thinkpad e530 */
-	.callback =3D thinkpad_e530_quirk,
-	.matches =3D {
-		DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
-		DMI_MATCH(DMI_PRODUCT_NAME, "32597CG"),
+		/* ECS EF20EA, AXP288 PMIC but uses separate fuel-gauge */
+		.callback =3D ac_do_not_check_pmic_quirk,
+		.matches =3D {
+			DMI_MATCH(DMI_PRODUCT_NAME, "EF20EA"),
 		},
 	},
 	{
-		/* ECS EF20EA */
+		/* Lenovo Ideapad Miix 320, AXP288 PMIC, separate fuel-gauge */
 		.callback =3D ac_do_not_check_pmic_quirk,
 		.matches =3D {
-			DMI_MATCH(DMI_PRODUCT_NAME, "EF20EA"),
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "80XF"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "Lenovo MIIX 320-10ICR"),
 		},
 	},
 	{
-		/* Lenovo Ideapad Miix 320 */
-		.callback =3D ac_do_not_check_pmic_quirk,
+		/* Lenovo Thinkpad e530, see comment in acpi_ac_notify() */
+		.callback =3D thinkpad_e530_quirk,
 		.matches =3D {
-		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "LENOVO"),
-		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "80XF"),
-		  DMI_EXACT_MATCH(DMI_PRODUCT_VERSION, "Lenovo MIIX 320-10ICR"),
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "32597CG"),
 		},
 	},
 	{},
--=20
2.25.0

