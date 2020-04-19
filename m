Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD191AFBAD
	for <lists+linux-acpi@lfdr.de>; Sun, 19 Apr 2020 17:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726208AbgDSPRE (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 19 Apr 2020 11:17:04 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:20259 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726099AbgDSPRE (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Sun, 19 Apr 2020 11:17:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587309423;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=LRbFemGrpsDOuqq7wzxlVQ0qcFZKVZNZjd2oB7alHE0=;
        b=XBRbzS1Wf5w6NLjXx5epHt5FwS0jTFYbv2/m9EwhX4s5ViQzXPyI6HS4Y7olfGeLVXJ85c
        Q5XNAOFeMBbA+Rt8hVV6ywM/2lR/EfI2tWDubNCQoUhkfGF+ghlWeJSbsQFDestQZv1NUP
        Df1seeJIPGdpFSurst0qVbo1tO/3/iQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-183-16L0w_HxPY6uotpWNpN8Rg-1; Sun, 19 Apr 2020 11:16:42 -0400
X-MC-Unique: 16L0w_HxPY6uotpWNpN8Rg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AFE291005513;
        Sun, 19 Apr 2020 15:16:41 +0000 (UTC)
Received: from x1.com (ovpn-112-70.ams2.redhat.com [10.36.112.70])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B44E518A85;
        Sun, 19 Apr 2020 15:16:40 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org
Subject: [PATCH] ACPI: button: Drop no longer necessary Asus T200TA lid_init_state quirk
Date:   Sun, 19 Apr 2020 17:16:13 +0200
Message-Id: <20200419151613.14933-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Content-Transfer-Encoding: quoted-printable
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Commit 17e5888e4e18 ("x86: Select HARDIRQS_SW_RESEND on x86") fixes
the edge-triggered embedded-controller (WC) IRQ not being replayed after
resume when woken by opening the lid, which gets signaled by the EC.

This means that the lid_init_state=3DACPI_BUTTON_LID_INIT_OPEN quirk for
the Asus T200TA is no longer necessary, the lid now works properly
without it, so drop the quirk.

Fixes: 17e5888e4e18 ("x86: Select HARDIRQS_SW_RESEND on x86")
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/button.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index 00112cf15322..78cfc70cb320 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -87,18 +87,6 @@ static const struct dmi_system_id dmi_lid_quirks[] =3D=
 {
 		},
 		.driver_data =3D (void *)(long)ACPI_BUTTON_LID_INIT_DISABLED,
 	},
-	{
-		/*
-		 * Asus T200TA, _LID keeps reporting closed after every second
-		 * openening of the lid. Causing immediate re-suspend after
-		 * opening every other open. Using LID_INIT_OPEN fixes this.
-		 */
-		.matches =3D {
-			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
-			DMI_MATCH(DMI_PRODUCT_NAME, "T200TA"),
-		},
-		.driver_data =3D (void *)(long)ACPI_BUTTON_LID_INIT_OPEN,
-	},
 	{
 		/* GP-electronic T701, _LID method points to a floating GPIO */
 		.matches =3D {
--=20
2.26.0

