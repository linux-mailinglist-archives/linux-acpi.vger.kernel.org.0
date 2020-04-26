Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2E791B8F48
	for <lists+linux-acpi@lfdr.de>; Sun, 26 Apr 2020 13:04:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726226AbgDZLDk (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 26 Apr 2020 07:03:40 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55760 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726215AbgDZLDU (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 26 Apr 2020 07:03:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587898999;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M+b26ndc6zVYTP424qBUkq5rKzs/VJMdgytlvMYK02Q=;
        b=UOm08aUdYzo1m5lAH2bHrBDbw45vud8dhyUssaSc8Pc0vyLFpYcn1NmJTqr0J2feeKjtSE
        Gzs1BJlb+K5nk+Bdug3NBm/1hICKIMBbHeLEQqWcZtB966DGMKeZJLy45t7mPs0dCJw/Om
        8wOCkRc/C6S8HVRZYxCrsPB65dhWL4U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-506-r22GhwiBNJep_CXCVPeLcQ-1; Sun, 26 Apr 2020 07:03:16 -0400
X-MC-Unique: r22GhwiBNJep_CXCVPeLcQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2C6EC1009600;
        Sun, 26 Apr 2020 11:03:14 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-112-32.ams2.redhat.com [10.36.112.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 98C6810013A1;
        Sun, 26 Apr 2020 11:03:11 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Kevin Tsai <ktsai@capellamicro.com>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: [PATCH 5/8] iio: light: cm32181: Use units of 1/100000th for calibscale and lux_per_bit
Date:   Sun, 26 Apr 2020 13:02:53 +0200
Message-Id: <20200426110256.218186-5-hdegoede@redhat.com>
In-Reply-To: <20200426110256.218186-1-hdegoede@redhat.com>
References: <20200426110256.218186-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Content-Transfer-Encoding: quoted-printable
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Use units of 1/100000th for calibscale and lux_per_bit. The similar
cm3232 driver already uses 1/100000th as unit for calibscale.

This allows for higher-accuracy and makes it easier to add support
for getting device-specific calibscale and lux_per_bit values from
a device's ACPI tables, as the values in the ACPI tables also use
1/100000th units.

This units change means that our intermediate values in cm32181_get_lux()
may get quite big, change the type of the lux variable to a u64 to
deal with this.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/iio/light/cm32181.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/light/cm32181.c b/drivers/iio/light/cm32181.c
index e31c1005b03d..4fdf2f4a23ab 100644
--- a/drivers/iio/light/cm32181.c
+++ b/drivers/iio/light/cm32181.c
@@ -45,11 +45,11 @@
 #define CM32181_CMD_ALS_SM_MASK		(0x03 << CM32181_CMD_ALS_SM_SHIFT)
 #define CM32181_CMD_ALS_SM_DEFAULT	(0x01 << CM32181_CMD_ALS_SM_SHIFT)
=20
-#define CM32181_MLUX_PER_BIT		5	/* ALS_SM=3D01 IT=3D800ms */
-#define CM32181_MLUX_PER_BIT_BASE_IT	800000	/* Based on IT=3D800ms */
-#define	CM32181_CALIBSCALE_DEFAULT	1000
-#define CM32181_CALIBSCALE_RESOLUTION	1000
-#define MLUX_PER_LUX			1000
+#define CM32181_LUX_PER_BIT		500	/* ALS_SM=3D01 IT=3D800ms */
+#define CM32181_LUX_PER_BIT_RESOLUTION	100000
+#define CM32181_LUX_PER_BIT_BASE_IT	800000	/* Based on IT=3D800ms */
+#define CM32181_CALIBSCALE_DEFAULT	100000
+#define CM32181_CALIBSCALE_RESOLUTION	100000
=20
 #define SMBUS_ALERT_RESPONSE_ADDRESS	0x0c
=20
@@ -208,15 +208,15 @@ static int cm32181_get_lux(struct cm32181_chip *cm3=
2181)
 	struct i2c_client *client =3D cm32181->client;
 	int ret;
 	int als_it;
-	unsigned long lux;
+	u64 lux;
=20
 	ret =3D cm32181_read_als_it(cm32181, &als_it);
 	if (ret < 0)
 		return -EINVAL;
=20
-	lux =3D CM32181_MLUX_PER_BIT;
-	lux *=3D CM32181_MLUX_PER_BIT_BASE_IT;
-	lux /=3D als_it;
+	lux =3D CM32181_LUX_PER_BIT;
+	lux *=3D CM32181_LUX_PER_BIT_BASE_IT;
+	lux =3D div_u64(lux, als_it);
=20
 	ret =3D i2c_smbus_read_word_data(client, CM32181_REG_ADDR_ALS);
 	if (ret < 0)
@@ -224,8 +224,8 @@ static int cm32181_get_lux(struct cm32181_chip *cm321=
81)
=20
 	lux *=3D ret;
 	lux *=3D cm32181->calibscale;
-	lux /=3D CM32181_CALIBSCALE_RESOLUTION;
-	lux /=3D MLUX_PER_LUX;
+	lux =3D div_u64(lux, CM32181_CALIBSCALE_RESOLUTION);
+	lux =3D div_u64(lux, CM32181_LUX_PER_BIT_RESOLUTION);
=20
 	if (lux > 0xFFFF)
 		lux =3D 0xFFFF;
--=20
2.26.0

