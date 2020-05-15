Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D4201D4547
	for <lists+linux-acpi@lfdr.de>; Fri, 15 May 2020 07:35:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726341AbgEOFfJ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 15 May 2020 01:35:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726314AbgEOFfH (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 15 May 2020 01:35:07 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BC42C05BD0A
        for <linux-acpi@vger.kernel.org>; Thu, 14 May 2020 22:35:07 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id u61so1246482qtd.4
        for <linux-acpi@vger.kernel.org>; Thu, 14 May 2020 22:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=EZoy6w7ha0DNuHCPHtXM/SP1BLypAsOupCZ9P6v8cMM=;
        b=rOovWDSJYXWE5Bmy7IlspRdZnHrW3vC8hO0zRosezAonLPXvCkp4SGejQLIRYpLSlv
         QfdRJ92IBQkIQW188k9n/iXvg4qHBBRuydnWHU1LlPDJfpnfaDdF2WcN96jNPK3XknVN
         ClYXIl7QaaHGPmUiYUPJZOqBCncHbos5xkyX+i68aMXwhfkmGKjGQ1HyjlobIvmNmhna
         4+6OZLy3n/1ROIjmOYDG2XgMTFSaARz1ChwsCyhnPfL96S1evSHhST4tjA9s2RapQXna
         wBgOw9417hZKdE4zXjSNPWBk88p7+sdHK6Q7yRi2pmCfb0iyD/O0jUiI8GPItZDnZFzY
         aIxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=EZoy6w7ha0DNuHCPHtXM/SP1BLypAsOupCZ9P6v8cMM=;
        b=tlr+j2HvKvJt/pvQfPa1SZyW65h8TO71Xc6XiSKw9yI15JGFqgEMeYKz4qFLdMxEFH
         1zAwyl5DWUkA+DkgyZV25EKjjnnaZUoUVvbpJNaN+2ogMXnTP+qep++/jUp6Cbse+iHY
         QlDEgzEoEf9s6WWYm4BQ+BjMdF1frkd0lpag6FfwOfSnIgKAhS0aGWn01rRKwIHdtV4n
         PAcbmAj+rHfjcbn0trAq2iheJqtZYjhg3HqmkygwbLUmF3Cwgmz3ivComy1+8BTaYtmM
         /8BJp8uzHoGVwpJUDBS/+fgUxRD/QPf9S9EokJpNSKwj+H5viw4yhFNNwt4qL6vmPB5+
         csNQ==
X-Gm-Message-State: AOAM530a6WfRgLaELiPrxvNXOUcxCQC9xgEocwq/BNuvzG8v3EEXv0Br
        OytQWiacwTjBpA09N7rmqJfbEluIShc4aZc=
X-Google-Smtp-Source: ABdhPJwaE6/0XCEsVs67aBW7TEyiScvmgrKOX5Hlong/h0NOfDzB7vfDCEcF3sKLCbo5eLpiZQ6wtkRsTF4+GrQ=
X-Received: by 2002:a05:6214:70a:: with SMTP id b10mr1910835qvz.186.1589520906395;
 Thu, 14 May 2020 22:35:06 -0700 (PDT)
Date:   Thu, 14 May 2020 22:34:57 -0700
In-Reply-To: <20200515053500.215929-1-saravanak@google.com>
Message-Id: <20200515053500.215929-2-saravanak@google.com>
Mime-Version: 1.0
References: <20200515053500.215929-1-saravanak@google.com>
X-Mailer: git-send-email 2.26.2.761.g0e0b3e54be-goog
Subject: [PATCH v1 1/4] driver core: Move code to the right part of the file
From:   Saravana Kannan <saravanak@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Len Brown <lenb@kernel.org>
Cc:     Saravana Kannan <saravanak@google.com>, kernel-team@android.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-acpi@vger.kernel.org, Ji Luo <ji.luo@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

This commit just moves around code to match the general organization of
the file.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/base/core.c | 60 ++++++++++++++++++++++-----------------------
 1 file changed, 30 insertions(+), 30 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index c9045521596f..2b454aae64b5 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -1143,6 +1143,36 @@ static void device_links_purge(struct device *dev)
 	device_links_write_unlock();
 }
 
+static u32 fw_devlink_flags = DL_FLAG_SYNC_STATE_ONLY;
+static int __init fw_devlink_setup(char *arg)
+{
+	if (!arg)
+		return -EINVAL;
+
+	if (strcmp(arg, "off") == 0) {
+		fw_devlink_flags = 0;
+	} else if (strcmp(arg, "permissive") == 0) {
+		fw_devlink_flags = DL_FLAG_SYNC_STATE_ONLY;
+	} else if (strcmp(arg, "on") == 0) {
+		fw_devlink_flags = DL_FLAG_AUTOPROBE_CONSUMER;
+	} else if (strcmp(arg, "rpm") == 0) {
+		fw_devlink_flags = DL_FLAG_AUTOPROBE_CONSUMER |
+				   DL_FLAG_PM_RUNTIME;
+	}
+	return 0;
+}
+early_param("fw_devlink", fw_devlink_setup);
+
+u32 fw_devlink_get_flags(void)
+{
+	return fw_devlink_flags;
+}
+
+static bool fw_devlink_is_permissive(void)
+{
+	return fw_devlink_flags == DL_FLAG_SYNC_STATE_ONLY;
+}
+
 /* Device links support end. */
 
 int (*platform_notify)(struct device *dev) = NULL;
@@ -2345,36 +2375,6 @@ static int device_private_init(struct device *dev)
 	return 0;
 }
 
-static u32 fw_devlink_flags = DL_FLAG_SYNC_STATE_ONLY;
-static int __init fw_devlink_setup(char *arg)
-{
-	if (!arg)
-		return -EINVAL;
-
-	if (strcmp(arg, "off") == 0) {
-		fw_devlink_flags = 0;
-	} else if (strcmp(arg, "permissive") == 0) {
-		fw_devlink_flags = DL_FLAG_SYNC_STATE_ONLY;
-	} else if (strcmp(arg, "on") == 0) {
-		fw_devlink_flags = DL_FLAG_AUTOPROBE_CONSUMER;
-	} else if (strcmp(arg, "rpm") == 0) {
-		fw_devlink_flags = DL_FLAG_AUTOPROBE_CONSUMER |
-				   DL_FLAG_PM_RUNTIME;
-	}
-	return 0;
-}
-early_param("fw_devlink", fw_devlink_setup);
-
-u32 fw_devlink_get_flags(void)
-{
-	return fw_devlink_flags;
-}
-
-static bool fw_devlink_is_permissive(void)
-{
-	return fw_devlink_flags == DL_FLAG_SYNC_STATE_ONLY;
-}
-
 /**
  * device_add - add device to device hierarchy.
  * @dev: device.
-- 
2.26.2.761.g0e0b3e54be-goog

