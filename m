Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD2AB175945
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Mar 2020 12:12:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbgCBLMf (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 2 Mar 2020 06:12:35 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54714 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726915AbgCBLMf (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 2 Mar 2020 06:12:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583147553;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=JEYVaHBOg1BkrEALHUWaStW3c4T+abGro/yXHseA/C4=;
        b=BV5CX6mQH1BCvyoV5O30T2qPW3bFp/73eNmTwW/L2s2+Fc2GZdD5YBMZfSSrVp3Yqryd0m
        cbIYD4bF/qWCl/vmgsn28kXC3qk8rIHn/eVuF0e/y0uKevJeHXb4S37+noPjOqu1VXqZJn
        ifwGXN4aUFt246deP14r0Temf5Ts16o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-19-lp9Pc_abOsSGOhGexPDO5g-1; Mon, 02 Mar 2020 06:12:30 -0500
X-MC-Unique: lp9Pc_abOsSGOhGexPDO5g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 08A89189F763;
        Mon,  2 Mar 2020 11:12:29 +0000 (UTC)
Received: from x1.localdomain.com (unknown [10.36.118.189])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2B2D05D9C9;
        Mon,  2 Mar 2020 11:12:27 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Marc Lehmann <schmorp@schmorp.de>, linux-gpio@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: [PATCH v2 1/4] gpiolib: acpi: Correct comment for HP x2 10 honor_wakeup quirk
Date:   Mon,  2 Mar 2020 12:12:22 +0100
Message-Id: <20200302111225.6641-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Content-Transfer-Encoding: quoted-printable
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Commit aa23ca3d98f7 ("gpiolib: acpi: Add honor_wakeup module-option +
quirk mechanism") added a quirk for some models of the HP x2 10 series.

There are 2 issues with the comment describing the quirk:
1) The comment claims the DMI quirk applies to all Cherry Trail based HP =
x2
   10 models. In the mean time I have learned that there are at least 3
   models of the HP x2 10 models:

   Bay Trail SoC + AXP288 PMIC
   Cherry Trail SoC + AXP288 PMIC
   Cherry Trail SoC + TI PMIC

   And this quirk's DMI matches only match the Cherry Trail SoC + TI PMIC
   SoC, which is good because we want a slightly different quirk for the
   others. This commit updates the comment to make it clear that the quir=
k
   is only for the Cherry Trail SoC + TI PMIC models.

2) The comment says that it is ok to disable wakeup on all ACPI GPIO even=
t
   handlers, because there is only the one for the embedded-controller
   events. This is not true, there also is a handler for the special
   INT0002 device which is related to USB wakeups. We need to also disabl=
e
   wakeups on that one because the device turns of the USB-keyboard built
   into the dock when closing the lid. The XHCI controller takes a while
   to notice this, so it only notices it when already suspended, causing
   a spurious wakeup because of this. So disabling wakeup on all handlers
   is the right thing to do, but not because there only is the one handle=
r
   for the EC events. This commit updates the comment to correctly reflec=
t
   this.

Fixes: aa23ca3d98f7 ("gpiolib: acpi: Add honor_wakeup module-option + qui=
rk mechanism")
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/gpio/gpiolib-acpi.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index 31fee5e918b7..a77edd31dd60 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -1345,12 +1345,14 @@ static const struct dmi_system_id gpiolib_acpi_qu=
irks[] =3D {
 	},
 	{
 		/*
-		 * Various HP X2 10 Cherry Trail models use an external
-		 * embedded-controller connected via I2C + an ACPI GPIO
-		 * event handler. The embedded controller generates various
-		 * spurious wakeup events when suspended. So disable wakeup
-		 * for its handler (it uses the only ACPI GPIO event handler).
-		 * This breaks wakeup when opening the lid, the user needs
+		 * HP X2 10 models with Cherry Trail SoC + TI PMIC use an
+		 * external embedded-controller connected via I2C + an ACPI GPIO
+		 * event handler on INT33FF:01 pin 0, causing spurious wakeups.
+		 * When suspending by closing the LID, the power to the USB
+		 * keyboard is turned off, causing INT0002 ACPI events to
+		 * trigger once the XHCI controller notices the keyboard is
+		 * gone. So INT0002 events cause spurious wakeups too. Ignoring
+		 * EC wakes breaks wakeup when opening the lid, the user needs
 		 * to press the power-button to wakeup the system. The
 		 * alternative is suspend simply not working, which is worse.
 		 */
--=20
2.25.1

