Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D724628318
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Nov 2022 15:46:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230520AbiKNOqi (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 14 Nov 2022 09:46:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235697AbiKNOqf (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 14 Nov 2022 09:46:35 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9E5FA1A1
        for <linux-acpi@vger.kernel.org>; Mon, 14 Nov 2022 06:45:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668437110;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RTMQzN6tVBQDJG2lWc9zMg8QJWAHWlE00U7jOaw5n1s=;
        b=geouQ7jv17cpw5QrSkmpQ6K3bL5vekTGhz4FZgKI2H9cgTGKZIZqgFZaL2cfZCtn2Hw9EX
        DApPmjJFrlx951nEpocLGucDShtEtATLtX/k4XUqM0gHij6YpZsXUTYUGbP1OHoXCabG6I
        O+rNQmbneH/BCssseBijNb4FHT/8LJc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-483-yBluBb-iOlaVnvw0JwKAnA-1; Mon, 14 Nov 2022 09:45:07 -0500
X-MC-Unique: yBluBb-iOlaVnvw0JwKAnA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 23360800B23;
        Mon, 14 Nov 2022 14:45:07 +0000 (UTC)
Received: from x1.localdomain.com (unknown [10.39.193.154])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C241C1415102;
        Mon, 14 Nov 2022 14:45:05 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, Len Brown <lenb@kernel.org>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        linux-acpi@vger.kernel.org
Subject: [PATCH 1/7] ACPI: video: Add a few bugtracker links to DMI quirks
Date:   Mon, 14 Nov 2022 15:44:53 +0100
Message-Id: <20221114144459.455519-2-hdegoede@redhat.com>
In-Reply-To: <20221114144459.455519-1-hdegoede@redhat.com>
References: <20221114144459.455519-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Add a couple of missing bugtracker links to DMI quirks

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/video_detect.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index b2a616287638..bb8052fc3fee 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -166,6 +166,7 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
 		},
 	},
 	{
+	 /* https://bugs.launchpad.net/bugs/1000146 */
 	 .callback = video_detect_force_vendor,
 	 /* Asus X101CH */
 	 .matches = {
@@ -190,6 +191,7 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
 		},
 	},
 	{
+	 /* https://bugs.launchpad.net/bugs/1000146 */
 	 .callback = video_detect_force_vendor,
 	 /* Asus 1015CX */
 	 .matches = {
@@ -233,6 +235,7 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
 		},
 	},
 	{
+	 /* https://bugzilla.kernel.org/show_bug.cgi?id=202401 */
 	 .callback = video_detect_force_vendor,
 	 /* Sony VPCEH3U1E */
 	 .matches = {
@@ -400,8 +403,8 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
 		DMI_MATCH(DMI_PRODUCT_NAME, "530U4E/540U4E"),
 		},
 	},
-	/* https://bugs.launchpad.net/bugs/1894667 */
 	{
+	 /* https://bugs.launchpad.net/bugs/1894667 */
 	 .callback = video_detect_force_video,
 	 /* HP 635 Notebook */
 	 .matches = {
-- 
2.37.3

