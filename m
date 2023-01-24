Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAFE96795DE
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Jan 2023 11:58:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbjAXK6t (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 24 Jan 2023 05:58:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233491AbjAXK6o (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 24 Jan 2023 05:58:44 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9ABC16325
        for <linux-acpi@vger.kernel.org>; Tue, 24 Jan 2023 02:57:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674557878;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=C1xSnfHC9qgHCYoaeDywx/rnJLoBj2mJnZ3PpjNS2nw=;
        b=Bt9FnxRq91jW1C1fDwaxh/cx4fB2UZ7ypsivrXEEmrgDlfbawZt2F3e8M2TiDmGCujPbAI
        xzv91CBBm6kzS67l5H3kGHdaVo0hn7fhqMbrL5h5X04YusOHItteC1VUTkNkAgrhz6Na5r
        FZEnRw1Rinu/Qf7uyWqWnmtPOPyF5Vg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-590-ppQD1lL4MnadrDx40QU6bA-1; Tue, 24 Jan 2023 05:57:57 -0500
X-MC-Unique: ppQD1lL4MnadrDx40QU6bA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A70F3183B3C1;
        Tue, 24 Jan 2023 10:57:56 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.195.52])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C199E40444C5;
        Tue, 24 Jan 2023 10:57:54 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Lukas Wunner <lukas@wunner.de>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andy@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, Len Brown <lenb@kernel.org>,
        Emmanouil Kouroupakis <kartebi@gmail.com>,
        Aditya Garg <gargaditya08@live.com>,
        Orlando Chamberlain <orlandoch.dev@gmail.com>,
        linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: [PATCH v2 0/3] ACPI: video/apple-gmux: Fix apple gmux backlight detection
Date:   Tue, 24 Jan 2023 11:57:51 +0100
Message-Id: <20230124105754.62167-1-hdegoede@redhat.com>
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

Hi All,

Here is v2 of my series to fix apple-gmux detection in
the acpi_video_get_backlight_type() function.

Changes in v2:
- Fix leaking of adev reference returned by acpi_dev_get_first_match_dev()
  (Reported-by: Andy Shevchenko <andy.shevchenko@gmail.com>)
- Add list of known affected Apple models (Lukas Wunner)
- Add Reported-by and Link tags

Most of the changes are in the commit messages. Here is the actual code-diff
between v1 and v2 for fixing the adev leak:

--- a/include/linux/apple-gmux.h
+++ b/include/linux/apple-gmux.h
@@ -68,18 +68,19 @@ static inline bool apple_gmux_is_indexed(unsigned long iostart)
 static inline bool apple_gmux_detect(struct pnp_dev *pnp_dev, bool *indexed_ret)
 {
 	u8 ver_major, ver_minor, ver_release;
+	struct device *dev = NULL;
+	struct acpi_device *adev;
 	struct resource *res;
 	bool indexed = false;
+	bool ret = false;
 
 	if (!pnp_dev) {
-		struct acpi_device *adev;
-		struct device *dev;
-
 		adev = acpi_dev_get_first_match_dev(GMUX_ACPI_HID, NULL, -1);
 		if (!adev)
 			return false;
 
-		dev = acpi_get_first_physical_node(adev);
+		dev = get_device(acpi_get_first_physical_node(adev));
+		acpi_dev_put(adev);
 		if (!dev)
 			return false;
 
@@ -87,11 +88,8 @@ static inline bool apple_gmux_detect(struct pnp_dev *pnp_dev, bool *indexed_ret)
 	}
 
 	res = pnp_get_resource(pnp_dev, IORESOURCE_IO, 0);
-	if (!res)
-		return false;
-
-	if (resource_size(res) < GMUX_MIN_IO_LEN)
-		return false;
+	if (!res || resource_size(res) < GMUX_MIN_IO_LEN)
+		goto out;
 
 	/*
 	 * Invalid version information may indicate either that the gmux
@@ -103,13 +101,16 @@ static inline bool apple_gmux_detect(struct pnp_dev *pnp_dev, bool *indexed_ret)
 	if (ver_major == 0xff && ver_minor == 0xff && ver_release == 0xff) {
 		indexed = apple_gmux_is_indexed(res->start);
 		if (!indexed)
-			return false;
+			goto out;
 	}
 
 	if (indexed_ret)
 		*indexed_ret = indexed;
 
-	return true;
+	ret = true;
+out:
+	put_device(dev);
+	return ret;
 }
 
 /**

Thank you Andy for pointing out this leak.

Note I plan to push this v2 to pdx86/fixes pretty much straight away after
sending this out, to give the builders some time to play with it. And then
if there is no negative feedback on this I'll include this in a fixes
pull-req to Linus later this week.

Regards,

Hans



Hans de Goede (3):
  platform/x86: apple-gmux: Move port defines to apple-gmux.h
  platform/x86: apple-gmux: Add apple_gmux_detect() helper
  ACPI: video: Fix apple gmux detection

 drivers/acpi/video_detect.c       |  24 +------
 drivers/platform/x86/apple-gmux.c |  93 +++++--------------------
 include/linux/apple-gmux.h        | 109 +++++++++++++++++++++++++++++-
 3 files changed, 128 insertions(+), 98 deletions(-)

-- 
2.39.0

