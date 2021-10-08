Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E81A426EBE
	for <lists+linux-acpi@lfdr.de>; Fri,  8 Oct 2021 18:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbhJHQ0o (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 8 Oct 2021 12:26:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38950 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229681AbhJHQ0n (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 8 Oct 2021 12:26:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633710288;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tS5QQ64GZGVdogMYc2KeOgl0dL67SII0vN7yTynJRjo=;
        b=Q0jgT4UyzMpd5L0AsewSRmAz/Rifpxrx7AZnXqvwnZnH2+vfmbZLwChBQnFL/M1S/XBtfq
        33LjCsQiquzVvsU+Y0i7g6gEtCDpACP1c/MqIlT4wm2akeIRrLFh6pBwOSkdCKBc7ThLA7
        /vbbuzGnUIP5ZkZfmD9TSWNqk4L5azM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-562-Xw8GCAEGPuaBHOI4VBjVKg-1; Fri, 08 Oct 2021 12:24:46 -0400
X-MC-Unique: Xw8GCAEGPuaBHOI4VBjVKg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8ED341139582;
        Fri,  8 Oct 2021 16:22:30 +0000 (UTC)
Received: from x1.localdomain (unknown [10.39.192.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E2BC760C0F;
        Fri,  8 Oct 2021 16:22:20 +0000 (UTC)
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
Subject: [PATCH 02/12] media: i2c: ov8865: Add an has_unmet_acpi_deps() check
Date:   Fri,  8 Oct 2021 18:21:11 +0200
Message-Id: <20211008162121.6628-3-hdegoede@redhat.com>
In-Reply-To: <20211008162121.6628-1-hdegoede@redhat.com>
References: <20211008162121.6628-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The clk and regulator frameworks expect clk/regulator consumer-devices
to have info about the consumed clks/regulators described in the device's
fw_node.

To work around cases where this info is not present in the firmware tables,
which is often the case on x86/ACPI devices, both frameworks allow the
provider-driver to attach info about consumers to the clks/regulators
when registering these.

This causes problems with the probe ordering of the ov8865 driver vs the
drivers for these clks/regulators. Since the lookups are only registered
when the provider-driver binds, trying to get these clks/regulators before
then results in a -ENOENT error for clks and a dummy regulator for regs.

On ACPI/x86 where this is a problem, the ov8865 ACPI fw-nodes have a _DEP
dependency on the INT3472 ACPI fw-node which describes the hardware which
provides the clks/regulators.

The drivers/platform/x86/intel/int3472/ code dealing with these ACPI
fw-nodes will call acpi_dev_clear_dependencies() to indicate that this
_DEP has been "met" when all the clks/regulators have been setup.

Call the has_unmet_acpi_deps() helper to check for unmet _DEPs
and return -EPROBE_DEFER if this returns true, so that we wait for
the clk/regulator setup to be done before continuing with probing.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/media/i2c/ov8865.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/media/i2c/ov8865.c b/drivers/media/i2c/ov8865.c
index ce4e0ae2c4d3..fd18d1256f78 100644
--- a/drivers/media/i2c/ov8865.c
+++ b/drivers/media/i2c/ov8865.c
@@ -2978,6 +2978,9 @@ static int ov8865_probe(struct i2c_client *client)
 	unsigned int i;
 	int ret;
 
+	if (has_unmet_acpi_deps(dev))
+		return -EPROBE_DEFER;
+
 	sensor = devm_kzalloc(dev, sizeof(*sensor), GFP_KERNEL);
 	if (!sensor)
 		return -ENOMEM;
-- 
2.31.1

