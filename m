Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA205426EC5
	for <lists+linux-acpi@lfdr.de>; Fri,  8 Oct 2021 18:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230497AbhJHQ1O (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 8 Oct 2021 12:27:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:32706 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230282AbhJHQ1K (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 8 Oct 2021 12:27:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633710313;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+gTkDyyN5iHsDmp3h6rm/ifPFPdKLxTQ1AjeEl1QIN4=;
        b=LeodExMj9p7WZ5DYudBBoYkZUsxukXD/AzhoyL6ODrkMVJf9gJq4lZy78cHP8E+IHguNfR
        23l3UffwKqY+SOxsXRZZyuzRGkhOZ3yVHAW8S4tAKlFAW9ce1Ikdx+P6KPeuxepUX7VxyT
        Cydl9nJS6k9ua3cxokPBq9ekev8U72M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-306-UXqeT9f-Prys0jQJWuoOFg-1; Fri, 08 Oct 2021 12:25:10 -0400
X-MC-Unique: UXqeT9f-Prys0jQJWuoOFg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BA71A132B5B;
        Fri,  8 Oct 2021 16:22:42 +0000 (UTC)
Received: from x1.localdomain (unknown [10.39.192.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EC49C60C0F;
        Fri,  8 Oct 2021 16:22:30 +0000 (UTC)
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
Subject: [PATCH 03/12] media: i2c: ov5693: Add an has_unmet_acpi_deps() check
Date:   Fri,  8 Oct 2021 18:21:12 +0200
Message-Id: <20211008162121.6628-4-hdegoede@redhat.com>
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

This causes problems with the probe ordering of the ov5693 driver vs the
drivers for these clks/regulators. Since the lookups are only registered
when the provider-driver binds, trying to get these clks/regulators before
then results in a -ENOENT error for clks and a dummy regulator for regs.

On ACPI/x86 where this is a problem, the ov5693 ACPI fw-nodes have a _DEP
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
 drivers/media/i2c/ov5693.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/media/i2c/ov5693.c b/drivers/media/i2c/ov5693.c
index 1320063c6747..886649670efb 100644
--- a/drivers/media/i2c/ov5693.c
+++ b/drivers/media/i2c/ov5693.c
@@ -1415,6 +1415,9 @@ static int ov5693_probe(struct i2c_client *client)
 	if (!endpoint)
 		return -EPROBE_DEFER;
 
+	if (has_unmet_acpi_deps(&client->dev))
+		return -EPROBE_DEFER;
+
 	ov5693 = devm_kzalloc(&client->dev, sizeof(*ov5693), GFP_KERNEL);
 	if (!ov5693)
 		return -ENOMEM;
-- 
2.31.1

