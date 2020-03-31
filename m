Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 027F419969F
	for <lists+linux-acpi@lfdr.de>; Tue, 31 Mar 2020 14:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730562AbgCaMgc (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 31 Mar 2020 08:36:32 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37249 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730436AbgCaMgc (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 31 Mar 2020 08:36:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585658190;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=CnaLaS9W1uRXoaaCCxMTDZ471FmKi6dA6YY856Kx06k=;
        b=SaHH7sQN2hl6Q1xSzKl/0zy9flSARjN/X6eehKe7DoZ90d287wH45oQ8kNlXGS+ZI06mte
        dvh1Bnq8FBYxeHSi2M77bLSPJXJdptZvCvtAti2dBek6xannMNrMpBL06OcMfrWGaxUnfk
        FAM+tGjnsvnZvWDx1DQV9/q79XscOgI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-232-6mzGDJHrNCSM38em2JoJmw-1; Tue, 31 Mar 2020 08:36:27 -0400
X-MC-Unique: 6mzGDJHrNCSM38em2JoJmw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 373C5801E53;
        Tue, 31 Mar 2020 12:36:26 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-112-136.ams2.redhat.com [10.36.112.136])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3F22CD7665;
        Tue, 31 Mar 2020 12:36:25 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org
Subject: [PATCH] ACPI: video: Use native backlight on Acer Aspire 5783z
Date:   Tue, 31 Mar 2020 14:36:23 +0200
Message-Id: <20200331123623.318792-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Content-Transfer-Encoding: quoted-printable
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The Acer Aspire 5783z shipped with Windows 7 and as such does not trigger
our "win8 ready" heuristic for prefering the native backlight interface.

Still ACPI backlight control doesn't work on this model, where as the
native (intel_video) backlight interface does work. Add a quirk to
force using native backlight control on this model.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/video_detect.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index 419f814d596a..b4994e50608d 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -352,6 +352,15 @@ static const struct dmi_system_id video_detect_dmi_t=
able[] =3D {
 		DMI_MATCH(DMI_PRODUCT_NAME, "Precision 7510"),
 		},
 	},
+	{
+	 .callback =3D video_detect_force_native,
+	 .ident =3D "Acer Aspire 5738z",
+	 .matches =3D {
+		DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+		DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 5738"),
+		DMI_MATCH(DMI_BOARD_NAME, "JV50"),
+		},
+	},
=20
 	/*
 	 * Desktops which falsely report a backlight and which our heuristics
--=20
2.26.0

