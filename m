Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C97657A82D5
	for <lists+linux-acpi@lfdr.de>; Wed, 20 Sep 2023 15:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236477AbjITNGf (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 20 Sep 2023 09:06:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236538AbjITNGM (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 20 Sep 2023 09:06:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1996CFB
        for <linux-acpi@vger.kernel.org>; Wed, 20 Sep 2023 06:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695215116;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=taNAclTSUensrs8JiB1vFUZBqJhbA/bz6kppXCiNaN4=;
        b=diXx/YcHYGDqPBQWHDi0HOBOla9MjCUSYWr91FjJZHiZBTHkmGV7ZGX9AqRYDDL6KNu4ht
        zuebD8nJWwfZeC/DM5IBOBCTHqmMfSPOEyQZEnfIwM/Zu/3sBiTAazeeXrMJZFWK+osfcc
        lTlXHKJf7r6yS5qBqcL/AO+PiqF2R+0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-680-F0ZF7T_3M1qvn255dM2vdw-1; Wed, 20 Sep 2023 09:05:13 -0400
X-MC-Unique: F0ZF7T_3M1qvn255dM2vdw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BB00D85A5BF;
        Wed, 20 Sep 2023 13:05:12 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.195.126])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 344BC10F1BE7;
        Wed, 20 Sep 2023 13:05:12 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org
Subject: [PATCH] ACPI: EC: Add quirk for the HP Pavilion Gaming 15-dk1xxx
Date:   Wed, 20 Sep 2023 15:05:06 +0200
Message-ID: <20230920130506.8595-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Added GPE quirk entry for the HP Pavilion Gaming 15-dk1xxx.
There is a quirk entry for 2 15-c..... laptops, this is
for a new version which has 15-dk1xxx as identifier.

This fixes the LID switch and rfkill and brightness hotkeys
not working.

Closes: https://github.com/systemd/systemd/issues/28942
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/ec.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 660834a49c1f..c95d0edb0be9 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -1913,6 +1913,17 @@ static const struct dmi_system_id ec_dmi_table[] __initconst = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "HP 15-cx0041ur"),
 		},
 	},
+	{
+		/*
+		 * HP Pavilion Gaming Laptop 15-dk1xxx
+		 * https://github.com/systemd/systemd/issues/28942
+		 */
+		.callback = ec_honor_dsdt_gpe,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "HP"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "HP Pavilion Gaming Laptop 15-dk1xxx"),
+		},
+	},
 	{
 		/*
 		 * Samsung hardware
-- 
2.41.0

