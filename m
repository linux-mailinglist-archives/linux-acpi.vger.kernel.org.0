Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88589613FE1
	for <lists+linux-acpi@lfdr.de>; Mon, 31 Oct 2022 22:27:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbiJaV1C (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 31 Oct 2022 17:27:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbiJaV1B (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 31 Oct 2022 17:27:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78273E0B7
        for <linux-acpi@vger.kernel.org>; Mon, 31 Oct 2022 14:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667251561;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=shBZPHKYcMC0unaK56b0eDrAF/WjMbXbhoipJJg1iNY=;
        b=fO5l0UlwIhCbazVcSaWtYmiVkwgijIQ04W5k52xKjs7inzzhfqUnFIOX+X7jbgwiEgmD5b
        0DgtJboH0cB+Fb1yrPqmPoarGdWSsHjgmNTcjHPmdGtOuQa5cYFCi9GCpkwV+lOD+RNeaz
        j9ld7H3rlkcLtREXT9GVizftejzhr2o=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-271-B0R6GCAVPq-v3ersUlo2WA-1; Mon, 31 Oct 2022 17:25:58 -0400
X-MC-Unique: B0R6GCAVPq-v3ersUlo2WA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D41293814943;
        Mon, 31 Oct 2022 21:25:57 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.194.145])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E76DBC15BB2;
        Mon, 31 Oct 2022 21:25:56 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Daniel Dadap <ddadap@nvidia.com>
Subject: [PATCH] ACPI: video: Add backlight=native DMI quirk for Dell G15 5515
Date:   Mon, 31 Oct 2022 22:25:56 +0100
Message-Id: <20221031212556.401618-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The Dell G15 5515 has the WMI interface (and WMI call returns) expected
by the nvidia-wmi-ec-backlight interface. But the backlight class device
registered by the nvidia-wmi-ec-backlight driver does not actually work.

The amdgpu_bl0 native GPU backlight class device does actually work,
add a backlight=native DMI quirk for this.

Cc: Daniel Dadap <ddadap@nvidia.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/video_detect.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index 841f6213b4de..88acc09773bb 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -645,6 +645,16 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
 		},
 	},
 
+	/* Models which have nvidia-ec-wmi support, but should not use it. */
+	{
+	 .callback = video_detect_force_native,
+	 /* Dell G15 5515 */
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+		DMI_MATCH(DMI_PRODUCT_NAME, "Dell G15 5515"),
+		},
+	},
+
 	/*
 	 * Desktops which falsely report a backlight and which our heuristics
 	 * for this do not catch.
-- 
2.37.3

