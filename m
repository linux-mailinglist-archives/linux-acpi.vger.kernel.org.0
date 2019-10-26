Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA1CFE5F77
	for <lists+linux-acpi@lfdr.de>; Sat, 26 Oct 2019 22:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbfJZUYv (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 26 Oct 2019 16:24:51 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:32267 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726519AbfJZUYv (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Sat, 26 Oct 2019 16:24:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572121490;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3maoJ32kKzUTambmZovi9QT6dCW3DGL2Z7/6IBAM89c=;
        b=A3uFE0FoR0QuB9ivXmei/PVLA4qUkuRyHG8v4j0TqrGKX3UXdhkp0MdY13F+ERwwhiilnu
        TKVqwIoyhODXANbviGrrjncd5tYK21Glj0EEzCI7wguoxUI4JizXRziKMjM9CluFMYF5kH
        j6jNcT5EFYF+hfcrX7QSjU0bCGoSLIE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-227-JCG984eZMCex2EQEzNjDzg-1; Sat, 26 Oct 2019 16:24:47 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EB8B2107AD25;
        Sat, 26 Oct 2019 20:24:46 +0000 (UTC)
Received: from shalem.localdomain.com (ovpn-116-34.ams2.redhat.com [10.36.116.34])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AA5B45C1D4;
        Sat, 26 Oct 2019 20:24:45 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-acpi@vger.kernel.org
Subject: [PATCH v2 6/6] ACPI / button: Remove unused acpi_lid_notifier_[un]register functions
Date:   Sat, 26 Oct 2019 22:24:36 +0200
Message-Id: <20191026202436.311894-6-hdegoede@redhat.com>
In-Reply-To: <20191026202436.311894-1-hdegoede@redhat.com>
References: <20191026202436.311894-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: JCG984eZMCex2EQEzNjDzg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

There are no users of the acpi_lid_notifier_[un]register functions,
so lets remove them.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/button.c | 27 +--------------------------
 include/acpi/button.h | 12 ------------
 2 files changed, 1 insertion(+), 38 deletions(-)

diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index a090e9542d82..d27b01c0323d 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -147,7 +147,6 @@ struct acpi_button {
 =09bool suspended;
 };
=20
-static BLOCKING_NOTIFIER_HEAD(acpi_lid_notifier);
 static struct acpi_device *lid_device;
 static long lid_init_state =3D -1;
=20
@@ -177,7 +176,6 @@ static int acpi_lid_evaluate_state(struct acpi_device *=
device)
 static int acpi_lid_notify_state(struct acpi_device *device, int state)
 {
 =09struct acpi_button *button =3D acpi_driver_data(device);
-=09int ret;
 =09ktime_t next_report;
 =09bool do_update;
=20
@@ -254,18 +252,7 @@ static int acpi_lid_notify_state(struct acpi_device *d=
evice, int state)
 =09=09button->last_time =3D ktime_get();
 =09}
=20
-=09ret =3D blocking_notifier_call_chain(&acpi_lid_notifier, state, device)=
;
-=09if (ret =3D=3D NOTIFY_DONE)
-=09=09ret =3D blocking_notifier_call_chain(&acpi_lid_notifier, state,
-=09=09=09=09=09=09   device);
-=09if (ret =3D=3D NOTIFY_DONE || ret =3D=3D NOTIFY_OK) {
-=09=09/*
-=09=09 * It is also regarded as success if the notifier_chain
-=09=09 * returns NOTIFY_OK or NOTIFY_DONE.
-=09=09 */
-=09=09ret =3D 0;
-=09}
-=09return ret;
+=09return 0;
 }
=20
 static int __maybe_unused acpi_button_state_seq_show(struct seq_file *seq,
@@ -362,18 +349,6 @@ static int acpi_button_remove_fs(struct acpi_device *d=
evice)
 /* -----------------------------------------------------------------------=
---
                                 Driver Interface
    -----------------------------------------------------------------------=
--- */
-int acpi_lid_notifier_register(struct notifier_block *nb)
-{
-=09return blocking_notifier_chain_register(&acpi_lid_notifier, nb);
-}
-EXPORT_SYMBOL(acpi_lid_notifier_register);
-
-int acpi_lid_notifier_unregister(struct notifier_block *nb)
-{
-=09return blocking_notifier_chain_unregister(&acpi_lid_notifier, nb);
-}
-EXPORT_SYMBOL(acpi_lid_notifier_unregister);
-
 int acpi_lid_open(void)
 {
 =09if (!lid_device)
diff --git a/include/acpi/button.h b/include/acpi/button.h
index 3a2b8535dec6..340da7784cc8 100644
--- a/include/acpi/button.h
+++ b/include/acpi/button.h
@@ -2,21 +2,9 @@
 #ifndef ACPI_BUTTON_H
 #define ACPI_BUTTON_H
=20
-#include <linux/notifier.h>
-
 #if IS_ENABLED(CONFIG_ACPI_BUTTON)
-extern int acpi_lid_notifier_register(struct notifier_block *nb);
-extern int acpi_lid_notifier_unregister(struct notifier_block *nb);
 extern int acpi_lid_open(void);
 #else
-static inline int acpi_lid_notifier_register(struct notifier_block *nb)
-{
-=09return 0;
-}
-static inline int acpi_lid_notifier_unregister(struct notifier_block *nb)
-{
-=09return 0;
-}
 static inline int acpi_lid_open(void)
 {
 =09return 1;
--=20
2.23.0

