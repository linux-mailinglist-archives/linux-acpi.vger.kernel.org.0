Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F06D4608D6
	for <lists+linux-acpi@lfdr.de>; Sun, 28 Nov 2021 19:21:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359176AbhK1SYw (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 28 Nov 2021 13:24:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31705 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1359172AbhK1SWp (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Sun, 28 Nov 2021 13:22:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638123569;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2l99ue+ZsL3kQ2KSf2Fz/GGUgFZ17LwvN/X/f1TBwSI=;
        b=YqVkucMu9yseKVDVPfKAJKNrTds+rW1+QjRauIV5tIOkdxxHIlJw3Y9U3+UbVPBx4dvASg
        zeCVX2/e2PhD+I8l0PIa8vuYao75asGUfdGFcGHkR7lmslzqB+yzUPtTdLvYV0wct93C5L
        R4Fo7lR/pbqD9fVZEk8RiGLLtV8ntwI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-89-G3Qx74dTMk2el-xs0nDXrQ-1; Sun, 28 Nov 2021 13:19:26 -0500
X-MC-Unique: G3Qx74dTMk2el-xs0nDXrQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8E365801B01;
        Sun, 28 Nov 2021 18:19:23 +0000 (UTC)
Received: from x1.localdomain (unknown [10.39.192.65])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 446F810016F4;
        Sun, 28 Nov 2021 18:19:20 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andy@infradead.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Sebastian Reichel <sre@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org, Yauhen Kharuzhy <jekhor@gmail.com>,
        Tsuchiya Yuto <kitakar@gmail.com>,
        platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org
Subject: [PATCH v3 16/20] extcon: intel-cht-wc: Use new cht_wc_model intel_soc_pmic field
Date:   Sun, 28 Nov 2021 19:18:05 +0100
Message-Id: <20211128181809.326736-17-hdegoede@redhat.com>
In-Reply-To: <20211128181809.326736-1-hdegoede@redhat.com>
References: <20211128181809.326736-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The CHT_WC_VBUS_GPIO_CTLO GPIO actually driving an external 5V Vboost
converter for Vbus depends on the board on which the Cherry Trail -
Whiskey Cove PMIC is actually used.

Since the information about the exact PMIC setup is necessary in other
places too, struct intel_soc_pmic now has a new cht_wc_model field
indicating the board model.

Only poke the CHT_WC_VBUS_GPIO_CTLO GPIO if this new field is set to
INTEL_CHT_WC_GPD_WIN_POCKET, which indicates the Type-C (with PD and
DP-altmode) setup used on the GPD pocket and GPD win; and on which
this GPIO actually controls an external 5V Vboost converter.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v3:
- Use the new cht_wc_model intel_soc_pmic field which replaces the
  intel_cht_wc_get_model() helper and adjust the commit msg to match
---
 drivers/extcon/extcon-intel-cht-wc.c | 35 +++++++++++++++++-----------
 1 file changed, 21 insertions(+), 14 deletions(-)

diff --git a/drivers/extcon/extcon-intel-cht-wc.c b/drivers/extcon/extcon-intel-cht-wc.c
index 771f6f4cf92e..81cae8c75850 100644
--- a/drivers/extcon/extcon-intel-cht-wc.c
+++ b/drivers/extcon/extcon-intel-cht-wc.c
@@ -14,6 +14,7 @@
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
 
@@ -358,20 +359,26 @@ static int cht_wc_extcon_probe(struct platform_device *pdev)
 	if (IS_ERR(ext->edev))
 		return PTR_ERR(ext->edev);
 
-	/*
-	 * When a host-cable is detected the BIOS enables an external 5v boost
-	 * converter to power connected devices there are 2 problems with this:
-	 * 1) This gets seen by the external battery charger as a valid Vbus
-	 *    supply and it then tries to feed Vsys from this creating a
-	 *    feedback loop which causes aprox. 300 mA extra battery drain
-	 *    (and unless we drive the external-charger-disable pin high it
-	 *    also tries to charge the battery causing even more feedback).
-	 * 2) This gets seen by the pwrsrc block as a SDP USB Vbus supply
-	 * Since the external battery charger has its own 5v boost converter
-	 * which does not have these issues, we simply turn the separate
-	 * external 5v boost converter off and leave it off entirely.
-	 */
-	cht_wc_extcon_set_5v_boost(ext, false);
+	switch (pmic->cht_wc_model) {
+	case INTEL_CHT_WC_GPD_WIN_POCKET:
+		/*
+		 * When a host-cable is detected the BIOS enables an external 5v boost
+		 * converter to power connected devices there are 2 problems with this:
+		 * 1) This gets seen by the external battery charger as a valid Vbus
+		 *    supply and it then tries to feed Vsys from this creating a
+		 *    feedback loop which causes aprox. 300 mA extra battery drain
+		 *    (and unless we drive the external-charger-disable pin high it
+		 *    also tries to charge the battery causing even more feedback).
+		 * 2) This gets seen by the pwrsrc block as a SDP USB Vbus supply
+		 * Since the external battery charger has its own 5v boost converter
+		 * which does not have these issues, we simply turn the separate
+		 * external 5v boost converter off and leave it off entirely.
+		 */
+		cht_wc_extcon_set_5v_boost(ext, false);
+		break;
+	default:
+		break;
+	}
 
 	/* Enable sw control */
 	ret = cht_wc_extcon_sw_control(ext, true);
-- 
2.33.1

