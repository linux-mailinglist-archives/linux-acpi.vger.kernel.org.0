Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 594DDE5F74
	for <lists+linux-acpi@lfdr.de>; Sat, 26 Oct 2019 22:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbfJZUYr (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 26 Oct 2019 16:24:47 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:48018 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726442AbfJZUYq (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Sat, 26 Oct 2019 16:24:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572121484;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=pEdr9DrKZHDgyNkOX25eckcFAaQ38an4YZO/TYlXePU=;
        b=Pi5C84LGZggOZhc9g+/u2ncQwKkXKbgk8lJ1yAgUf6VO7oPNCbswz0PIymyg6R8dgedWnD
        WZ5u22tOAS9PrlzrfN5HHRmm2gQHYT2eroAsyc/CbkaID08taBzxJe5jchikDdaDuhn1CH
        Ze1F/jlIuzzd43kWS1gwQwWWTRWYhm8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-384-02Upfad0OTmNICPGLPeGbg-1; Sat, 26 Oct 2019 16:24:40 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3B2CB1800D9C;
        Sat, 26 Oct 2019 20:24:39 +0000 (UTC)
Received: from shalem.localdomain.com (ovpn-116-34.ams2.redhat.com [10.36.116.34])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E9E255C1D4;
        Sat, 26 Oct 2019 20:24:37 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-acpi@vger.kernel.org
Subject: [PATCH v2 1/6] ACPI / button: Refactor lid_init_state module parsing code
Date:   Sat, 26 Oct 2019 22:24:31 +0200
Message-Id: <20191026202436.311894-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: 02Upfad0OTmNICPGLPeGbg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Replace the weird strncmp() calls in param_set_lid_init_state(),
which look to me like they will also accept things like "opennnn"
to use sysfs_match_string instead.

Also rewrite param_get_lid_init_state() using the new lid_init_state_str
array. Instead of doing a straightforward one line replacement, e.g. :
  return sprintf(buffer, lid_init_state_str[lid_init_state]);
print all possible values, putting [] around the selected value, so
that users can easily find out what the possible values are.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/button.c | 62 ++++++++++++++++++++++---------------------
 1 file changed, 32 insertions(+), 30 deletions(-)

diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index 4a2cde2c536a..121d747a840c 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -44,9 +44,17 @@
 #define ACPI_BUTTON_DEVICE_NAME_LID=09"Lid Switch"
 #define ACPI_BUTTON_TYPE_LID=09=090x05
=20
-#define ACPI_BUTTON_LID_INIT_IGNORE=090x00
-#define ACPI_BUTTON_LID_INIT_OPEN=090x01
-#define ACPI_BUTTON_LID_INIT_METHOD=090x02
+enum {
+=09ACPI_BUTTON_LID_INIT_IGNORE,
+=09ACPI_BUTTON_LID_INIT_OPEN,
+=09ACPI_BUTTON_LID_INIT_METHOD,
+};
+
+static const char * const lid_init_state_str[] =3D {
+=09[ACPI_BUTTON_LID_INIT_IGNORE]=09=09=3D "ignore",
+=09[ACPI_BUTTON_LID_INIT_OPEN]=09=09=3D "open",
+=09[ACPI_BUTTON_LID_INIT_METHOD]=09=09=3D "method",
+};
=20
 #define _COMPONENT=09=09ACPI_BUTTON_COMPONENT
 ACPI_MODULE_NAME("button");
@@ -578,36 +586,30 @@ static int acpi_button_remove(struct acpi_device *dev=
ice)
 static int param_set_lid_init_state(const char *val,
 =09=09=09=09    const struct kernel_param *kp)
 {
-=09int result =3D 0;
-
-=09if (!strncmp(val, "open", sizeof("open") - 1)) {
-=09=09lid_init_state =3D ACPI_BUTTON_LID_INIT_OPEN;
-=09=09pr_info("Notify initial lid state as open\n");
-=09} else if (!strncmp(val, "method", sizeof("method") - 1)) {
-=09=09lid_init_state =3D ACPI_BUTTON_LID_INIT_METHOD;
-=09=09pr_info("Notify initial lid state with _LID return value\n");
-=09} else if (!strncmp(val, "ignore", sizeof("ignore") - 1)) {
-=09=09lid_init_state =3D ACPI_BUTTON_LID_INIT_IGNORE;
-=09=09pr_info("Do not notify initial lid state\n");
-=09} else
-=09=09result =3D -EINVAL;
-=09return result;
+=09int i;
+
+=09i =3D sysfs_match_string(lid_init_state_str, val);
+=09if (i < 0)
+=09=09return i;
+
+=09lid_init_state =3D i;
+=09pr_info("Initial lid state set to '%s'\n", lid_init_state_str[i]);
+=09return 0;
 }
=20
-static int param_get_lid_init_state(char *buffer,
-=09=09=09=09    const struct kernel_param *kp)
+static int param_get_lid_init_state(char *buf, const struct kernel_param *=
kp)
 {
-=09switch (lid_init_state) {
-=09case ACPI_BUTTON_LID_INIT_OPEN:
-=09=09return sprintf(buffer, "open");
-=09case ACPI_BUTTON_LID_INIT_METHOD:
-=09=09return sprintf(buffer, "method");
-=09case ACPI_BUTTON_LID_INIT_IGNORE:
-=09=09return sprintf(buffer, "ignore");
-=09default:
-=09=09return sprintf(buffer, "invalid");
-=09}
-=09return 0;
+=09int i, c =3D 0;
+
+=09for (i =3D 0; i < ARRAY_SIZE(lid_init_state_str); i++)
+=09=09if (i =3D=3D lid_init_state)
+=09=09=09c +=3D sprintf(buf + c, "[%s] ", lid_init_state_str[i]);
+=09=09else
+=09=09=09c +=3D sprintf(buf + c, "%s ", lid_init_state_str[i]);
+
+=09buf[c - 1] =3D '\n'; /* Replace the final space with a newline */
+
+=09return c;
 }
=20
 module_param_call(lid_init_state,
--=20
2.23.0

