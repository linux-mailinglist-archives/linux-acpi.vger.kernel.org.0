Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CFF5687DCA
	for <lists+linux-acpi@lfdr.de>; Thu,  2 Feb 2023 13:46:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232238AbjBBMqW (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 2 Feb 2023 07:46:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232377AbjBBMqE (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 2 Feb 2023 07:46:04 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D1C78E06F
        for <linux-acpi@vger.kernel.org>; Thu,  2 Feb 2023 04:45:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675341892;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=/gnOeRjGL09Vlvg1hl9ICcmCu3Gm74p3kvVsOTDj5Rw=;
        b=DsnsJLnnmZJqnvrvf4LghhaWyHUJVC3eL8kYB/NSWbSxywFfToxAlQguNTzmKlkBLk3CuF
        RTZLFYmjfd3TNNq1GSRi/ES8GnaKVRSOE231/rNJ/eh75M/qvTMHF5tOMVvPV43NpEAfrS
        14CP8qTDGMFovq9ThOEalEb4r+7qoy0=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-593-Ltpr7qwDNbqiCY-63tcH1A-1; Thu, 02 Feb 2023 07:44:51 -0500
X-MC-Unique: Ltpr7qwDNbqiCY-63tcH1A-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8ADEB3C0F687;
        Thu,  2 Feb 2023 12:44:50 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.194.53])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D68A1492C3E;
        Thu,  2 Feb 2023 12:44:49 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org
Subject: [PATCH] ACPI: video: Fix Lenovo Ideapad Z570 DMI match
Date:   Thu,  2 Feb 2023 13:44:49 +0100
Message-Id: <20230202124449.427651-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Multiple Ideapad Z570 variants need acpi_backlight=native to force native
use on these pre Windows 8 machines since acpi_video backlight control
does not work here.

The original DMI quirk matches on a product_name of "102434U" but other
variants may have different product_name-s such as e.g. "1024D9U".

Move to checking product_version instead as is more or less standard for
Lenovo DMI quirks for similar reasons.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/video_detect.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index a8c02608dde4..710ac640267d 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -434,7 +434,7 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
 	 /* Lenovo Ideapad Z570 */
 	 .matches = {
 		DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
-		DMI_MATCH(DMI_PRODUCT_NAME, "102434U"),
+		DMI_MATCH(DMI_PRODUCT_VERSION, "Ideapad Z570"),
 		},
 	},
 	{
-- 
2.39.1

