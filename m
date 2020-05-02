Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8581E1C27AF
	for <lists+linux-acpi@lfdr.de>; Sat,  2 May 2020 20:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728593AbgEBSaG (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 2 May 2020 14:30:06 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47488 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728587AbgEBSaF (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 2 May 2020 14:30:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588444204;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nU5clpbbNcvIEaL+E70ArYSlf45LwjetdDzC3qLBcXg=;
        b=VRy8GkyDQYijklbSK9jSKXTBSROKZrXNXUzU1hfnboF/7u28rJ9B/sfXAiO7IXipSRybEH
        CInghJECPIcAsO6zoSSeoEOPOHC8Kb38FHmZK39rPgnEx+MW9XugmptO5kwU76PwZwCY4l
        xsm40YUztGD5gZdGKCiHUJCqWWbJxg0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-147-tpmmQSAONHW9xoX_TSwcJg-1; Sat, 02 May 2020 14:30:01 -0400
X-MC-Unique: tpmmQSAONHW9xoX_TSwcJg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AEAAD45F;
        Sat,  2 May 2020 18:29:59 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-112-4.ams2.redhat.com [10.36.112.4])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 43A5A600E5;
        Sat,  2 May 2020 18:29:58 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Mario Limonciello <mario.limonciello@dell.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] platform/x86: intel-vbtn: Split keymap into buttons and switches parts
Date:   Sat,  2 May 2020 20:29:48 +0200
Message-Id: <20200502182951.114231-3-hdegoede@redhat.com>
In-Reply-To: <20200502182951.114231-1-hdegoede@redhat.com>
References: <20200502182951.114231-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Content-Transfer-Encoding: quoted-printable
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Split the sparse keymap into 2 separate keymaps, a buttons and a switches
keymap and combine the 2 to a single map again in intel_vbtn_input_setup(=
).

This is a preparation patch for not telling userspace that we have switch=
es
when we do not have them (and for doing the same for the buttons).

Fixes: de9647efeaa9 ("platform/x86: intel-vbtn: Only activate tablet mode=
 switch on 2-in-1's")
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/platform/x86/intel-vbtn.c | 28 +++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/intel-vbtn.c b/drivers/platform/x86/int=
el-vbtn.c
index 191894d648bb..634096cef21a 100644
--- a/drivers/platform/x86/intel-vbtn.c
+++ b/drivers/platform/x86/intel-vbtn.c
@@ -40,14 +40,20 @@ static const struct key_entry intel_vbtn_keymap[] =3D=
 {
 	{ KE_IGNORE, 0xC7, { KEY_VOLUMEDOWN } },	/* volume-down key release */
 	{ KE_KEY,    0xC8, { KEY_ROTATE_LOCK_TOGGLE } },	/* rotate-lock key pre=
ss */
 	{ KE_KEY,    0xC9, { KEY_ROTATE_LOCK_TOGGLE } },	/* rotate-lock key rel=
ease */
+};
+
+static const struct key_entry intel_vbtn_switchmap[] =3D {
 	{ KE_SW,     0xCA, { .sw =3D { SW_DOCK, 1 } } },		/* Docked */
 	{ KE_SW,     0xCB, { .sw =3D { SW_DOCK, 0 } } },		/* Undocked */
 	{ KE_SW,     0xCC, { .sw =3D { SW_TABLET_MODE, 1 } } },	/* Tablet */
 	{ KE_SW,     0xCD, { .sw =3D { SW_TABLET_MODE, 0 } } },	/* Laptop */
-	{ KE_END },
 };
=20
+#define KEYMAP_LEN \
+	(ARRAY_SIZE(intel_vbtn_keymap) + ARRAY_SIZE(intel_vbtn_switchmap) + 1)
+
 struct intel_vbtn_priv {
+	struct key_entry keymap[KEYMAP_LEN];
 	struct input_dev *input_dev;
 	bool wakeup_mode;
 };
@@ -55,13 +61,29 @@ struct intel_vbtn_priv {
 static int intel_vbtn_input_setup(struct platform_device *device)
 {
 	struct intel_vbtn_priv *priv =3D dev_get_drvdata(&device->dev);
-	int ret;
+	int ret, keymap_len =3D 0;
+
+	if (true) {
+		memcpy(&priv->keymap[keymap_len], intel_vbtn_keymap,
+		       ARRAY_SIZE(intel_vbtn_keymap) *
+		       sizeof(struct key_entry));
+		keymap_len +=3D ARRAY_SIZE(intel_vbtn_keymap);
+	}
+
+	if (true) {
+		memcpy(&priv->keymap[keymap_len], intel_vbtn_switchmap,
+		       ARRAY_SIZE(intel_vbtn_switchmap) *
+		       sizeof(struct key_entry));
+		keymap_len +=3D ARRAY_SIZE(intel_vbtn_switchmap);
+	}
+
+	priv->keymap[keymap_len].type =3D KE_END;
=20
 	priv->input_dev =3D devm_input_allocate_device(&device->dev);
 	if (!priv->input_dev)
 		return -ENOMEM;
=20
-	ret =3D sparse_keymap_setup(priv->input_dev, intel_vbtn_keymap, NULL);
+	ret =3D sparse_keymap_setup(priv->input_dev, priv->keymap, NULL);
 	if (ret)
 		return ret;
=20
--=20
2.26.0

