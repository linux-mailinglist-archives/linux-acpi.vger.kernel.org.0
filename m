Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E79A477739B
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Aug 2023 11:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232974AbjHJJBM (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 10 Aug 2023 05:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232156AbjHJJBE (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 10 Aug 2023 05:01:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C30C8211F
        for <linux-acpi@vger.kernel.org>; Thu, 10 Aug 2023 02:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691658017;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=SsptNuZqTu6x0xTH/oZR8xChOfduQk/JbRlb0DwTkYQ=;
        b=IDjqk6857lEmv0pgBJR7nFJPK+o1ypuER68YGM2RrvO8439Hx5ofX+tOm0cF1E31a5K6pl
        fSW4x61yRMVf/dyy7KKgJdwUyOWL3crPyLpgLIne/yvQiTrwI4A9J1Ji1hfLXqja41lF5Z
        U/YBSOLCrG6KDdZE9zAs90OX7ZKMlzs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-63-7JQgaiAwMWGNi_sQ0z-wWw-1; Thu, 10 Aug 2023 05:00:14 -0400
X-MC-Unique: 7JQgaiAwMWGNi_sQ0z-wWw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B6DCF833941;
        Thu, 10 Aug 2023 09:00:13 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.194.110])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9D14C2026D4B;
        Thu, 10 Aug 2023 09:00:12 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>,
        August Wikerfors <git@augustwikerfors.se>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        stable@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: [PATCH] ACPI: resource: Add IRQ override quirk for PCSpecialist Elimina Pro 16 M
Date:   Thu, 10 Aug 2023 11:00:11 +0200
Message-ID: <20230810090011.104770-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The PCSpecialist Elimina Pro 16 M laptop model is a Zen laptop which
needs to use the MADT IRQ settings override and which does not have
an INT_SRC_OVR entry for IRQ 1 in its MADT.

So this model needs a DMI quirk to enable the MADT IRQ settings override
to fix its keyboard not working.

Fixes: a9c4a912b7dc ("ACPI: resource: Remove "Zen" specific match and quirks")
Link: https://bugzilla.kernel.org/show_bug.cgi?id=217394#c18
Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Linux regressions mailing list <regressions@lists.linux.dev>
Cc: All applicable <stable@vger.kernel.org>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/resource.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index 8e32dd5776f5..a4d9f149b48d 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -498,6 +498,17 @@ static const struct dmi_system_id maingear_laptop[] = {
 	{ }
 };
 
+static const struct dmi_system_id pcspecialist_laptop[] = {
+	{
+		.ident = "PCSpecialist Elimina Pro 16 M",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "PCSpecialist"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Elimina Pro 16 M"),
+		},
+	},
+	{ }
+};
+
 static const struct dmi_system_id lg_laptop[] = {
 	{
 		.ident = "LG Electronics 17U70P",
@@ -523,6 +534,7 @@ static const struct irq_override_cmp override_table[] = {
 	{ asus_laptop, 1, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, false },
 	{ tongfang_gm_rg, 1, ACPI_EDGE_SENSITIVE, ACPI_ACTIVE_LOW, 1, true },
 	{ maingear_laptop, 1, ACPI_EDGE_SENSITIVE, ACPI_ACTIVE_LOW, 1, true },
+	{ pcspecialist_laptop, 1, ACPI_EDGE_SENSITIVE, ACPI_ACTIVE_LOW, 1, true },
 	{ lg_laptop, 1, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, false },
 };
 
-- 
2.41.0

