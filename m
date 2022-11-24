Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44BF96376DC
	for <lists+linux-acpi@lfdr.de>; Thu, 24 Nov 2022 11:54:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbiKXKyJ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 24 Nov 2022 05:54:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbiKXKyF (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 24 Nov 2022 05:54:05 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8D074F188
        for <linux-acpi@vger.kernel.org>; Thu, 24 Nov 2022 02:53:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669287191;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=1SZwgsy3QqeXUi98EnVUg1rWneJwEiKkLXHi1dijXKw=;
        b=LuAkgvwUHmJxBsj6DDx5TPGAAqMXkIb7uRfckPsRWBaukN5rtCbyYDYBr0wqEWTPsfWV/v
        nDBOFHUj0fM4ZSAGvCjmiEdCTuzJvXH40jbEJNgV8oXlNh0uNRjHAXxcaGjG3Ta2WZFzg6
        v9dYFQVPENdzxneGuN+zazNYe1lbvoo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-362-a_jJmfLQO8KzoYOA992h5w-1; Thu, 24 Nov 2022 05:53:09 -0500
X-MC-Unique: a_jJmfLQO8KzoYOA992h5w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B7C73800B23;
        Thu, 24 Nov 2022 10:53:08 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.195.152])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2BEF040C2064;
        Thu, 24 Nov 2022 10:53:08 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org
Subject: [PATCH] PNP: Do not disable devices on suspend when they cannot be re-enabled on resume
Date:   Thu, 24 Nov 2022 11:53:05 +0100
Message-Id: <20221124105305.13214-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On an Advantech MICA-071 tablet, with a builtin barcode scanner connected
to ttyS0, the following message is shown on suspend:

serial 00:02: disabled

And after suspend/resume trying to use the barcode scanner / ttyS0 shows:

serial 00:02: LSR safety check engaged!

Indicating that the UARTs io-ports are no longer reachable.

This is caused by __pnp_bus_suspend() calling pnp_stop_dev() on the "00:02"
pnp device on suspend (this outputs the disabled message).

The problem is that pnp_can_write() returns false for the "00:02" pnp
device, so after disabling it (disabling its decoding of IO addresses)
during suspend, it cannot be re-enabled.

Add a pnp_can_write() check to the suspend path and only disable devices
which can actually be re-enabled on resume.

This fixes the Advantech MICA-071's ttyS0 no longer working after
a suspend/resume.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/pnp/driver.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pnp/driver.c b/drivers/pnp/driver.c
index c02e7bf643a6..46c534f6b1c9 100644
--- a/drivers/pnp/driver.c
+++ b/drivers/pnp/driver.c
@@ -182,7 +182,8 @@ static int __pnp_bus_suspend(struct device *dev, pm_message_t state)
 			return error;
 	}
 
-	if (pnp_can_disable(pnp_dev)) {
+	/* can_write is necessary to be able to re-start the device on resume */
+	if (pnp_can_disable(pnp_dev) && pnp_can_write(pnp_dev)) {
 		error = pnp_stop_dev(pnp_dev);
 		if (error)
 			return error;
-- 
2.38.1

