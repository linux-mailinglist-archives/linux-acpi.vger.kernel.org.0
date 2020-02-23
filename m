Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D9E3169811
	for <lists+linux-acpi@lfdr.de>; Sun, 23 Feb 2020 15:29:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbgBWO3u (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 23 Feb 2020 09:29:50 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39101 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726302AbgBWO3u (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 23 Feb 2020 09:29:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582468189;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2E/Kqk0nvY8Ox/tVC5G9l/kGRtFSPestMoAK8+V2IFk=;
        b=KCU4Hh6N3bdjivp1B2hgWW/f8TCKaUakwsIv2DShcHbgEFPFld5YWA6/Tg+1ai1kLIZA6t
        01oSWJ3jdfWphQmzjljSFkMJsZQHzEs9TCrHQuuH1e2sX/RDoikoCXQqiZ44pYISgXy65B
        Aq87rY1/IeEq2NEviyUggCqhEBrmaYc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-190-r7awsrz5NWSXfbUw5nWrHg-1; Sun, 23 Feb 2020 09:29:47 -0500
X-MC-Unique: r7awsrz5NWSXfbUw5nWrHg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 19D99107ACC5;
        Sun, 23 Feb 2020 14:29:46 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-116-120.ams2.redhat.com [10.36.116.120])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1EADF1001B30;
        Sun, 23 Feb 2020 14:29:44 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org
Subject: [PATCH 2/2] ACPI / battery: Cleanup Lenovo Ideapad Miix 320 DMI table entry
Date:   Sun, 23 Feb 2020 15:29:41 +0100
Message-Id: <20200223142941.60705-3-hdegoede@redhat.com>
In-Reply-To: <20200223142941.60705-1-hdegoede@redhat.com>
References: <20200223142941.60705-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Content-Transfer-Encoding: quoted-printable
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The Lenovo Ideapad Miix 320 bat_dmi_table entry is using weird indentatio=
n
and is the only entry which (unnecessarily) uses DMI_EXACT_MATCH instead
of DMI_MATCH, fixup both to make the entry consistent with the others.

While at it also update the comments for battery_do_not_check_pmic_quirk
entries, adding a bit of text explaining why the quirk is necessary.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/battery.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 111a407dcc77..366c389175d8 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -1365,19 +1365,19 @@ static const struct dmi_system_id bat_dmi_table[]=
 __initconst =3D {
 		},
 	},
 	{
-		/* ECS EF20EA */
+		/* ECS EF20EA, AXP288 PMIC but uses separate fuel-gauge */
 		.callback =3D battery_do_not_check_pmic_quirk,
 		.matches =3D {
 			DMI_MATCH(DMI_PRODUCT_NAME, "EF20EA"),
 		},
 	},
 	{
-		/* Lenovo Ideapad Miix 320 */
+		/* Lenovo Ideapad Miix 320, AXP288 PMIC, separate fuel-gauge */
 		.callback =3D battery_do_not_check_pmic_quirk,
 		.matches =3D {
-		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "LENOVO"),
-		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "80XF"),
-		  DMI_EXACT_MATCH(DMI_PRODUCT_VERSION, "Lenovo MIIX 320-10ICR"),
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "80XF"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "Lenovo MIIX 320-10ICR"),
 		},
 	},
 	{},
--=20
2.25.0

