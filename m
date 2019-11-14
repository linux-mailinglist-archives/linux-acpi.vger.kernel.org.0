Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC831FC418
	for <lists+linux-acpi@lfdr.de>; Thu, 14 Nov 2019 11:26:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbfKNK0K (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 14 Nov 2019 05:26:10 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46256 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726655AbfKNK0J (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 14 Nov 2019 05:26:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573727169;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=13HbaFrPIsJtwRdpwF/J8JmziMwdkA+udMLvORazA1U=;
        b=OsmEtigVrjAAtHBqVnNha7hbb+1jQZqoG42kNe/49zBDxpejjSf3FsYEIve/LCF31P0LBj
        7wWdjaIXmK2ChG3C5cDEqQYsh6F2hBq9cJTJyXpC5cX0xyaghWBUSO3LIIFEkeH8HTgRSe
        aPkeQFubeQZWLf0Asjg85wOajElT3yI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-288-quqh6LWiNGGnHFM5tDDMEw-1; Thu, 14 Nov 2019 05:26:05 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6A8E818A3EC0;
        Thu, 14 Nov 2019 10:26:04 +0000 (UTC)
Received: from shalem.localdomain.com (unknown [10.36.118.128])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F2B3053C28;
        Thu, 14 Nov 2019 10:26:02 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-gpio@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: [PATCH v2 2/2] gpiolib: acpi: Make acpi_gpiochip_alloc_event always return AE_OK
Date:   Thu, 14 Nov 2019 11:26:00 +0100
Message-Id: <20191114102600.34558-2-hdegoede@redhat.com>
In-Reply-To: <20191114102600.34558-1-hdegoede@redhat.com>
References: <20191114102600.34558-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: quqh6LWiNGGnHFM5tDDMEw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

acpi_gpiochip_alloc_event is used to loop over all _AEI resources, if
we fail to bind an event handler to one of them, that is not a reason to
not try the other resources.

This commit modifies acpi_gpiochip_alloc_event to always return AE_OK,
so that we will always try to add an event handler for all _AEI resources.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
-This is a new patch in v2 of this patch-set
---
 drivers/gpio/gpiolib-acpi.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index 473c3b7508af..d30e57dc755c 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -194,6 +194,7 @@ static void acpi_gpiochip_request_irqs(struct acpi_gpio=
_chip *acpi_gpio)
 =09=09acpi_gpiochip_request_irq(acpi_gpio, event);
 }
=20
+/* Always returns AE_OK so that we keep looping over the resources */
 static acpi_status acpi_gpiochip_alloc_event(struct acpi_resource *ares,
 =09=09=09=09=09     void *context)
 {
@@ -233,7 +234,7 @@ static acpi_status acpi_gpiochip_alloc_event(struct acp=
i_resource *ares,
 =09=09dev_err(chip->parent,
 =09=09=09"Failed to request GPIO for pin 0x%04X, err %ld\n",
 =09=09=09pin, PTR_ERR(desc));
-=09=09return AE_ERROR;
+=09=09return AE_OK;
 =09}
=20
 =09ret =3D gpiochip_lock_as_irq(chip, pin);
@@ -293,7 +294,7 @@ static acpi_status acpi_gpiochip_alloc_event(struct acp=
i_resource *ares,
 fail_free_desc:
 =09gpiochip_free_own_desc(desc);
=20
-=09return AE_ERROR;
+=09return AE_OK;
 }
=20
 /**
--=20
2.23.0

