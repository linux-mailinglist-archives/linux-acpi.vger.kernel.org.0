Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80C4D438F3E
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Oct 2021 08:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbhJYGSa (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 25 Oct 2021 02:18:30 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:50956
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229841AbhJYGS3 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 25 Oct 2021 02:18:29 -0400
Received: from localhost.localdomain (unknown [103.229.218.199])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 5708C40059;
        Mon, 25 Oct 2021 06:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1635142567;
        bh=42GmMbqdm2hfM6AcNsbCI9jgN1yKCMcTAJ+J03o4Roo=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=rSsTFPFVMUH930XQ/GsXWxneCL5Tbw9FoIHhQxYXs4/xaAEy/B5KHwMzBzAtBPuoW
         V0Hp/zLCjK7ZByHnsjzl964LY3W2MOf1cu6bbosOX/yCJtZnGlr3oOTbqhvvKNSYGh
         kTljqs5mAl7OwGwsE2vH1Z2usEWzIQ8gFZslIAg5UXmtN/C8isFm3shGWEiuTIpDyp
         FZvFM/HnIdF1kkcjqr8+tFIDB10MJT/JXLFTS7cfZprHF2QWuW72LUB+Ri02y8+K1T
         2737u1WB3Fv/aOU1Y0vitRf9LN94naSPqrB+b/sBvgMk55B5t90FRo+FVHSV1dDXyS
         d5ftLw+ssmTnQ==
From:   Hui Wang <hui.wang@canonical.com>
To:     linux-acpi@vger.kernel.org, rafael.j.wysocki@intel.com
Cc:     dirksche@posteo.de, hui.wang@canonical.com
Subject: [RESEND][For 5.16][PATCH] ACPI: resources: Add one more Medion model in IRQ override quirk
Date:   Mon, 25 Oct 2021 14:16:01 +0800
Message-Id: <20211025061601.7866-1-hui.wang@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The Medion s17 series laptops have the same issue on the keyboard
as the s15 series, if skipping to call acpi_get_override_irq(), the
keyboard could work well. So put the DMI info of s17 series in the
IRQ override quirk table as well.

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=213031
Tested-by: dirksche <dirksche@posteo.de>
Signed-off-by: Hui Wang <hui.wang@canonical.com>
---
 drivers/acpi/resource.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index 7bf38652e6ac..3c25ce8c95ba 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -389,6 +389,13 @@ static const struct dmi_system_id medion_laptop[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "M15T"),
 		},
 	},
+	{
+		.ident = "MEDION S17405",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "MEDION"),
+			DMI_MATCH(DMI_BOARD_NAME, "M17T"),
+		},
+	},
 	{ }
 };
 
-- 
2.25.1

