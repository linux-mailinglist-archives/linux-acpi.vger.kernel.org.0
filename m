Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E19E1427BCA
	for <lists+linux-acpi@lfdr.de>; Sat,  9 Oct 2021 18:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232465AbhJIQJH (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 9 Oct 2021 12:09:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29056 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232425AbhJIQIp (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 9 Oct 2021 12:08:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633795608;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kyRSTZhAr4vtiVySKg6oKQ+eD8aKotXSs6/ZudHdQ1c=;
        b=Y8gVLv/m8TgIOTDc7BEnAw7y4Gi+ZZVcP64Y/wxAgqFa1+Z9UzRwbNVq2OxFLk+IS7q9jr
        6ijAq6j3p6GBAI/lZD7q36T8K2+HJFT1Ln/ANdC8gMHLgvfw5IvcI7MV5Usn3v1/ws6850
        NY2Rw6BZDM6aKwyr9IVjdDjueHHAY8s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-221-xPlLhf1rMK2nUINEyyfQaQ-1; Sat, 09 Oct 2021 12:06:47 -0400
X-MC-Unique: xPlLhf1rMK2nUINEyyfQaQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D0BB01808310;
        Sat,  9 Oct 2021 16:06:44 +0000 (UTC)
Received: from x1.localdomain.com (unknown [10.39.192.7])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B645B5C1B4;
        Sat,  9 Oct 2021 16:06:41 +0000 (UTC)
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
Subject: [PATCH v2 13/13] media: ipu3-cio2: Add module soft-deps for the INT3472 drivers
Date:   Sat,  9 Oct 2021 18:05:48 +0200
Message-Id: <20211009160548.306550-14-hdegoede@redhat.com>
In-Reply-To: <20211009160548.306550-1-hdegoede@redhat.com>
References: <20211009160548.306550-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The clk and regulator frameworks expect clk/regulator consumer-devices
to have info about the consumed clks/regulators described in the device's
fw_node.

To work around this info missing from the ACPI tables on devices where
the int3472 driver is used, the int3472 MFD-cell drivers attach info about
consumers to the clks/regulators when registering these.

This causes problems with the probe ordering wrt drivers for consumers
of these clks/regulators. Since the lookups are only registered when the
provider-driver binds, trying to get these clks/regulators before then
results in a -ENOENT error for clks and a dummy regulator for regulators.

All the sensor ACPI fw-nodes have a _DEP dependency on the INT3472 ACPI
fw-node, so to work around these probe ordering issues the ACPI core
reports status.present and status.enabled as false for any ACPI devices
which have a dependency on an INT3472 ACPI device until all _DEP-s are met.

Our sensor-detect code in cio2-bridge.c depends on the status.present /
status.enabled fields. So the INT3472 driver (which fullfills the _DEP-s)
must be loaded before us to ensure the sensor-detect code works.
Add module soft-deps on the INT3472 drivers to ensure that they are loaded
first.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/media/pci/intel/ipu3/ipu3-cio2-main.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/media/pci/intel/ipu3/ipu3-cio2-main.c b/drivers/media/pci/intel/ipu3/ipu3-cio2-main.c
index 7bb86e246ebe..4db6b637f555 100644
--- a/drivers/media/pci/intel/ipu3/ipu3-cio2-main.c
+++ b/drivers/media/pci/intel/ipu3/ipu3-cio2-main.c
@@ -2063,3 +2063,9 @@ MODULE_AUTHOR("Yuning Pu <yuning.pu@intel.com>");
 MODULE_AUTHOR("Yong Zhi <yong.zhi@intel.com>");
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("IPU3 CIO2 driver");
+/*
+ * The sensor detection in cio2-bridge.c relies on adev->status.present/enabled
+ * which will only be true for sensors if their _DEP dependencies are met, which
+ * requires the INT3472 drivers to have loaded.
+ */
+MODULE_SOFTDEP("pre: intel_skl_int3472_discrete intel_skl_int3472_tps68470");
-- 
2.31.1

