Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B6FA440D87
	for <lists+linux-acpi@lfdr.de>; Sun, 31 Oct 2021 10:00:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbhJaJDS (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 31 Oct 2021 05:03:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:55215 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229525AbhJaJDS (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Sun, 31 Oct 2021 05:03:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635670846;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Z4ASAiv+SIq5uZw+Lsxb9ayRoGky8y61FOJKaWDBieY=;
        b=Jeo5yWOu1kJ2NFy0YoMvlTC00eIRBfkmAq3U7X1Px1HMpYYISwEhq862nYbGBF2BDJo1sQ
        hrqa93kCN+rcfVk73nM4yXjdnDXjBqvB9bCMALa+G4kJp9+p0dRb6Irn1Ou/iUn/edfy//
        r3xlHHx+0x++wsl3qHxDlA8TE6iz5Cc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-104-Ww7yk3eJPhiT7_5EVR0Djw-1; Sun, 31 Oct 2021 05:00:41 -0400
X-MC-Unique: Ww7yk3eJPhiT7_5EVR0Djw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9C3101006AA4;
        Sun, 31 Oct 2021 09:00:39 +0000 (UTC)
Received: from x1.localdomain (unknown [10.39.192.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 27B0E60BF4;
        Sun, 31 Oct 2021 09:00:28 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Andy Shevchenko <andy@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Felipe Balbi <balbi@kernel.org>
Subject: [PATCH] ACPI / PMIC: Fix intel_pmic_regs_handler() read accesses
Date:   Sun, 31 Oct 2021 10:00:28 +0100
Message-Id: <20211031090028.6445-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The handling of PMIC register reads through writing 0 to address 4
of the opregion is wrong. Instead of returning the read value
through the value64, which is a no-op for function == ACPI_WRITE calls,
store the value and then on a subsequent function == ACPI_READ with
address == 3 (the address for the value field of the OpRegion)
return the stored value.

This has been tested on a Xiaomi Mi Pad 2 and makes the ACPI battery dev
there mostly functional (unfortunately there are still other issues).

Here are the SET() / GET() functions of the PMIC ACPI device,
which use this opregion, which clearly show the new behavior to
be correct:

OperationRegion (REGS, 0x8F, Zero, 0x50)
Field (REGS, ByteAcc, NoLock, Preserve)
{
    CLNT,   8,
    SA,     8,
    OFF,    8,
    VAL,    8,
    RWM,    8
}

Method (GET, 3, Serialized)
{
    If ((AVBE == One))
    {
        CLNT = Arg0
        SA = Arg1
        OFF = Arg2
        RWM = Zero
        If ((AVBG == One))
        {
            GPRW = Zero
        }
    }

    Return (VAL) /* \_SB_.PCI0.I2C7.PMI5.VAL_ */
}

Method (SET, 4, Serialized)
{
    If ((AVBE == One))
    {
        CLNT = Arg0
        SA = Arg1
        OFF = Arg2
        VAL = Arg3
        RWM = One
        If ((AVBG == One))
        {
            GPRW = One
        }
    }
}

Fixes: 0afa877a5650 ("ACPI / PMIC: intel: add REGS operation region support")
Cc: Felipe Balbi <balbi@kernel.org>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/pmic/intel_pmic.c | 51 +++++++++++++++++++---------------
 1 file changed, 28 insertions(+), 23 deletions(-)

diff --git a/drivers/acpi/pmic/intel_pmic.c b/drivers/acpi/pmic/intel_pmic.c
index a371f273f99d..9cde299eba88 100644
--- a/drivers/acpi/pmic/intel_pmic.c
+++ b/drivers/acpi/pmic/intel_pmic.c
@@ -211,31 +211,36 @@ static acpi_status intel_pmic_regs_handler(u32 function,
 		void *handler_context, void *region_context)
 {
 	struct intel_pmic_opregion *opregion = region_context;
-	int result = 0;
+	int result = -EINVAL;
+
+	if (function == ACPI_WRITE) {
+		switch (address) {
+		case 0:
+			return AE_OK;
+		case 1:
+			opregion->ctx.addr |= (*value64 & 0xff) << 8;
+			return AE_OK;
+		case 2:
+			opregion->ctx.addr |= *value64 & 0xff;
+			return AE_OK;
+		case 3:
+			opregion->ctx.val = *value64 & 0xff;
+			return AE_OK;
+		case 4:
+			if (*value64) {
+				result = regmap_write(opregion->regmap, opregion->ctx.addr,
+						      opregion->ctx.val);
+			} else {
+				result = regmap_read(opregion->regmap, opregion->ctx.addr,
+						     &opregion->ctx.val);
+			}
+			opregion->ctx.addr = 0;
+		}
+	}
 
-	switch (address) {
-	case 0:
-		return AE_OK;
-	case 1:
-		opregion->ctx.addr |= (*value64 & 0xff) << 8;
-		return AE_OK;
-	case 2:
-		opregion->ctx.addr |= *value64 & 0xff;
+	if (function == ACPI_READ && address == 3) {
+		*value64 = opregion->ctx.val;
 		return AE_OK;
-	case 3:
-		opregion->ctx.val = *value64 & 0xff;
-		return AE_OK;
-	case 4:
-		if (*value64) {
-			result = regmap_write(opregion->regmap, opregion->ctx.addr,
-					      opregion->ctx.val);
-		} else {
-			result = regmap_read(opregion->regmap, opregion->ctx.addr,
-					     &opregion->ctx.val);
-			if (result == 0)
-				*value64 = opregion->ctx.val;
-		}
-		memset(&opregion->ctx, 0x00, sizeof(opregion->ctx));
 	}
 
 	if (result < 0) {
-- 
2.31.1

