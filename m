Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7FC4426EE3
	for <lists+linux-acpi@lfdr.de>; Fri,  8 Oct 2021 18:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236555AbhJHQ1d (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 8 Oct 2021 12:27:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22412 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236616AbhJHQ1X (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 8 Oct 2021 12:27:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633710327;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+/qOVV3GWWwyv36CwuqsRbEhyl0VVy51ttzWNK0tWNY=;
        b=DdgLXXjVqrBc7dYo8wN5Q0o3UfLKFxLYgLvRhc/QuFpVtWEwfrn/h+ZKEogN7e6s1WVcF1
        vETLtTMTyUYlJqBoGnUiY+n8WzO9xm54vsJFeEYwootrCbuH7tB4o8bxaLyvw0LlKtEVAE
        bA+fWWvYBuu8v5gcep81A3DAWJpatFY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-561-sxsQn74rOdOoMvEgRFB_7g-1; Fri, 08 Oct 2021 12:25:23 -0400
X-MC-Unique: sxsQn74rOdOoMvEgRFB_7g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D76E18FA4A3;
        Fri,  8 Oct 2021 16:23:04 +0000 (UTC)
Received: from x1.localdomain (unknown [10.39.192.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A4FF560BF1;
        Fri,  8 Oct 2021 16:23:00 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andy@infradead.org>,
        Daniel Scally <djrscally@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Kate Hsuan <hpa@redhat.com>, linux-media@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [PATCH 07/12] platform/x86: int3472: Enable I2c daisy chain
Date:   Fri,  8 Oct 2021 18:21:16 +0200
Message-Id: <20211008162121.6628-8-hdegoede@redhat.com>
In-Reply-To: <20211008162121.6628-1-hdegoede@redhat.com>
References: <20211008162121.6628-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Daniel Scally <djrscally@gmail.com>

The TPS68470 PMIC has an I2C passthrough mode through which I2C traffic
can be forwarded to a device connected to the PMIC as though it were
connected directly to the system bus. Enable this mode when the chip
is initialised.

Signed-off-by: Daniel Scally <djrscally@gmail.com>
---
 .../x86/intel/int3472/intel_skl_int3472_tps68470.c         | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/platform/x86/intel/int3472/intel_skl_int3472_tps68470.c b/drivers/platform/x86/intel/int3472/intel_skl_int3472_tps68470.c
index c05b4cf502fe..42e688f4cad4 100644
--- a/drivers/platform/x86/intel/int3472/intel_skl_int3472_tps68470.c
+++ b/drivers/platform/x86/intel/int3472/intel_skl_int3472_tps68470.c
@@ -45,6 +45,13 @@ static int tps68470_chip_init(struct device *dev, struct regmap *regmap)
 		return ret;
 	}
 
+	/* Enable I2C daisy chain */
+	ret = regmap_write(regmap, TPS68470_REG_S_I2C_CTL, 0x03);
+	if (ret) {
+		dev_err(dev, "Failed to enable i2c daisy chain\n");
+		return ret;
+	}
+
 	dev_info(dev, "TPS68470 REVID: 0x%02x\n", version);
 
 	return 0;
-- 
2.31.1

