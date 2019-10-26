Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C060E5F76
	for <lists+linux-acpi@lfdr.de>; Sat, 26 Oct 2019 22:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbfJZUYv (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 26 Oct 2019 16:24:51 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:25495 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726442AbfJZUYu (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Sat, 26 Oct 2019 16:24:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572121489;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a9i0JTG0dhHPaYxvvLItnGuG9uxJ8sS3gtpjsIggXr4=;
        b=iW9o0DPn6NaO2fUE+UnCoLHXMvSJsBZJqK587iDFa9IsPC7w/qpr0TsJ7ByAubk6QNA/kX
        oKtE+An6qJW8BIlgeUSQX/efEufzXIXQ6RX/+UfbxNBmv+vdjLsPFNidXHWB4gQw3utaGz
        7XE0zX22r1biAlqH71ac0WzcZfuvT28=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-279-18eQYpLUNTKQXIn5t5Ao1Q-1; Sat, 26 Oct 2019 16:24:46 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 64DAA801E5C;
        Sat, 26 Oct 2019 20:24:45 +0000 (UTC)
Received: from shalem.localdomain.com (ovpn-116-34.ams2.redhat.com [10.36.116.34])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 260BF5C1D4;
        Sat, 26 Oct 2019 20:24:44 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-acpi@vger.kernel.org
Subject: [PATCH v2 5/6] ACPI / button: Add DMI quirk for Asus T200TA
Date:   Sat, 26 Oct 2019 22:24:35 +0200
Message-Id: <20191026202436.311894-5-hdegoede@redhat.com>
In-Reply-To: <20191026202436.311894-1-hdegoede@redhat.com>
References: <20191026202436.311894-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: 18eQYpLUNTKQXIn5t5Ao1Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The Asus T200TA lid has some weird behavior where _LID keeps reporting
closed after every second openening of the lid. Causing immediate
re-suspend after opening every other open.

I've looked at the AML code but it involves talking to the EC and we
have no idea what the EC is doing. Setting lid_init_state to
ACPI_BUTTON_LID_INIT_OPEN fixes the unwanted behavior, so this commit
adds a DMI based quirk to use ACPI_BUTTON_LID_INIT_OPEN on the T200TA.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
- New patch in v2 of this series
---
 drivers/acpi/button.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index e4b2aa43265b..a090e9542d82 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -77,6 +77,18 @@ MODULE_DEVICE_TABLE(acpi, button_device_ids);
=20
 /* Please keep this list sorted alphabetically by vendor and model */
 static const struct dmi_system_id dmi_lid_quirks[] =3D {
+=09{
+=09=09/*
+=09=09 * Asus T200TA, _LID keeps reporting closed after every second
+=09=09 * openening of the lid. Causing immediate re-suspend after
+=09=09 * opening every other open. Using LID_INIT_OPEN fixes this.
+=09=09 */
+=09=09.matches =3D {
+=09=09=09DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+=09=09=09DMI_MATCH(DMI_PRODUCT_NAME, "T200TA"),
+=09=09},
+=09=09.driver_data =3D (void *)(long)ACPI_BUTTON_LID_INIT_OPEN,
+=09},
 =09{
 =09=09/* GP-electronic T701, _LID method points to a floating GPIO */
 =09=09.matches =3D {
--=20
2.23.0

