Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF1CF440D8C
	for <lists+linux-acpi@lfdr.de>; Sun, 31 Oct 2021 10:02:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbhJaJEq (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 31 Oct 2021 05:04:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41795 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229660AbhJaJEq (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Sun, 31 Oct 2021 05:04:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635670935;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=SLG2kfm1CRcYvEXNmRRUsEpFH1oBMt1mUPp6s++xQCU=;
        b=IroVSEZS5f8YI0ZEmSap+4Fs7lkbApgfILyj7NxH1rHcxofsVPMO1QeJhhuGgJpyD4UVPw
        ZjqZGIkYCCBr+iwWCXlr19253ajVQlG0dcJzTc0Q6q8YCGxdqO9DfD0ITjq4gCRdNYpq+G
        peM3vl1+5v+naCxDnpDFZ2e6ymUklak=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-233-lrEBfxnsNc23-zZnM6-T9A-1; Sun, 31 Oct 2021 05:02:11 -0400
X-MC-Unique: lrEBfxnsNc23-zZnM6-T9A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2D40D362F8;
        Sun, 31 Oct 2021 09:02:10 +0000 (UTC)
Received: from x1.localdomain (unknown [10.39.192.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E42485C1C5;
        Sun, 31 Oct 2021 09:02:08 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org,
        "Andrew F . Davis" <afd@ti.com>
Subject: [PATCH] power: supply: bq27xxx: Fix kernel crash on IRQ handler register error
Date:   Sun, 31 Oct 2021 10:02:08 +0100
Message-Id: <20211031090208.6564-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

When registering the IRQ handler fails, do not just return the error code,
this will free the devm_kalloc-ed data struct while leaving the queued
work queued and the registered power_supply registered with both of them
now pointing to free-ed memory, resulting in various kernel crashes
soon afterwards.

Instead properly tear-down things on IRQ handler register errors.

Fixes: 703df6c09795 ("power: bq27xxx_battery: Reorganize I2C into a module")
Cc: Andrew F. Davis <afd@ti.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/power/supply/bq27xxx_battery_i2c.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/bq27xxx_battery_i2c.c b/drivers/power/supply/bq27xxx_battery_i2c.c
index 46f078350fd3..cf38cbfe13e9 100644
--- a/drivers/power/supply/bq27xxx_battery_i2c.c
+++ b/drivers/power/supply/bq27xxx_battery_i2c.c
@@ -187,7 +187,8 @@ static int bq27xxx_battery_i2c_probe(struct i2c_client *client,
 			dev_err(&client->dev,
 				"Unable to register IRQ %d error %d\n",
 				client->irq, ret);
-			return ret;
+			bq27xxx_battery_teardown(di);
+			goto err_failed;
 		}
 	}
 
-- 
2.31.1

