Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FCAD79CD6D
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Sep 2023 12:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233537AbjILKKz (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 12 Sep 2023 06:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233276AbjILKKm (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 12 Sep 2023 06:10:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4740F3A81
        for <linux-acpi@vger.kernel.org>; Tue, 12 Sep 2023 03:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694513318;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=B4FnuU5zFazKzznQKyXClo3vGbnJ76lHN9TmMtGnauo=;
        b=B/scBfA37/NSqMv5szUtu5951BQF3bYQ4h8W+3F/sPnj2WH1VC/8goH0NOESSOQ9pc+8nH
        vSa/VgGIN6gC6XihULTLDpkwcjX0Ik2JTVJ1AbRdEHCP0JGYMzp8ynfKK49LLb6yWaNysD
        a7U5CrY9dAZ7OH7uiWh0WAKvdGwO6LE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-677-vRgriTc5O6-L-OnFEipXgQ-1; Tue, 12 Sep 2023 06:08:37 -0400
X-MC-Unique: vRgriTc5O6-L-OnFEipXgQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B7728101FAA3;
        Tue, 12 Sep 2023 10:08:36 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.194.220])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1147C2026D4B;
        Tue, 12 Sep 2023 10:08:35 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org,
        stable@vger.kernel.org
Subject: [PATCH] ACPI: resource: Skip IRQ override on ASUS ExpertBook B1402CBA
Date:   Tue, 12 Sep 2023 12:08:27 +0200
Message-ID: <20230912100827.303590-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Like various other ASUS ExpertBook-s, the ASUS ExpertBook B1402CBA
has an ACPI DSDT table that describes IRQ 1 as ActiveLow while
the kernel overrides it to EdgeHigh.

This prevents the keyboard from working. To fix this issue, add this laptop
to the skip_override_table so that the kernel does not override IRQ 1.

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217901
Cc: stable@vger.kernel.org
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/resource.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index 32cfa3f4efd3..8116b55b6c98 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -439,6 +439,13 @@ static const struct dmi_system_id asus_laptop[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "S5602ZA"),
 		},
 	},
+	{
+		.ident = "Asus ExpertBook B1402CBA",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_BOARD_NAME, "B1402CBA"),
+		},
+	},
 	{
 		.ident = "Asus ExpertBook B1502CBA",
 		.matches = {
-- 
2.41.0

