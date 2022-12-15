Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57B7464D8DE
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Dec 2022 10:45:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbiLOJpp (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 15 Dec 2022 04:45:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbiLOJpo (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 15 Dec 2022 04:45:44 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9405B1DF30
        for <linux-acpi@vger.kernel.org>; Thu, 15 Dec 2022 01:44:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671097498;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=zjTqXGUqnbqulegoT9xPTJsKVDNW6/jnqKXTi+Tirmw=;
        b=LhympcJdT+66v2HXq1uC93Szdl17mkuxdkU2YQ982yCB2EcjjpVb02utxx4S0Bt1nCVhHl
        DDgSRRfISTrDS+fEFkuQPC/BMxErr87jFwZei3dsqzeADnHdfKAns63tA3osVJGDAoWEzz
        LRwj97XQTbZUSATHRhyTxSmgPEnBVow=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-491-1oPRIw0lNxiEbTc4be1Tzg-1; Thu, 15 Dec 2022 04:44:55 -0500
X-MC-Unique: 1oPRIw0lNxiEbTc4be1Tzg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0A3AD18E093C;
        Thu, 15 Dec 2022 09:44:55 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.193.128])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 518462166B29;
        Thu, 15 Dec 2022 09:44:54 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH] ACPI: resource: Add Asus ExpertBook B2502 to Asus quirks
Date:   Thu, 15 Dec 2022 10:44:43 +0100
Message-Id: <20221215094443.7466-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The Asus ExpertBook B2502 has the same keyboard issue as Asus Vivobook
K3402ZA/K3502ZA. The kernel overrides IRQ 1 to Edge_High when it
should be Active_Low.

This patch adds the ExpertBook B2502 model to the existing
quirk list of Asus laptops with this issue.

Fixes: b5f9223a105d ("ACPI: resource: Skip IRQ override on Asus Vivobook S5602ZA")
Link: https://bugzilla.redhat.com/show_bug.cgi?id=2142574
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/resource.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index f27914aedbd5..e721f2ec014f 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -432,6 +432,13 @@ static const struct dmi_system_id asus_laptop[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "S5602ZA"),
 		},
 	},
+	{
+		.ident = "Asus ExpertBook B2502",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_BOARD_NAME, "B2502CBA"),
+		},
+	},
 	{ }
 };
 
-- 
2.38.1

