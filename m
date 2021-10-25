Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3585438F19
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Oct 2021 08:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbhJYGI5 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 25 Oct 2021 02:08:57 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:56694
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229678AbhJYGI4 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 25 Oct 2021 02:08:56 -0400
Received: from localhost.localdomain (unknown [103.229.218.199])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 385AA3FFE2;
        Mon, 25 Oct 2021 06:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1635141994;
        bh=xUsU9ni8JR6Wlgmr858mUDjb0pbUknniUGa2mOOS7EU=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=hDFA1uiurJhPOfup0zXuKnJC6WMs9qsPtWONB4I+x7Y2VX8RTif6pIFWbC7EKg6b1
         nweftFz4FXzbS22Oyo7Dx0TBsRWY8szOUJ3OUPVdOM7EWtRwKp3069KO6cC45kMJX2
         +jV4KWQ4JZ5JCPbGWQzElduSORVl2wSY/TfhLbG87kW2Z+sv39ZW87Xg7MQiK6GV0d
         r3Hxyt/vn6oIraNkbOdCVuRSY7py4U9bXUJ2owStoLqqV9xDvrOXTdNKq1IUTikArE
         uX7RYdNYROuUzaLXs540bVQ3eqruaSSshI5vaEA4Sz7eRN8nOd8Ezt6FXHc2sNN69M
         xTjK07dIR+EuA==
From:   Hui Wang <hui.wang@canonical.com>
To:     linux-acpi@vger.kernel.org, rafael.j.wysocki@intel.com
Cc:     dirksche@posteo.de, hui.wang@canonical.com
Subject: [For 5.16][PATCH] ACPI: resources: Add one more Medion model in IRQ override quirk
Date:   Mon, 25 Oct 2021 14:06:28 +0800
Message-Id: <20211025060628.7580-1-hui.wang@canonical.com>
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

https://bugzilla.kernel.org/show_bug.cgi?id=213031
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

