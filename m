Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60D0C79C7BC
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Sep 2023 09:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231316AbjILHJf (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 12 Sep 2023 03:09:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbjILHJf (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 12 Sep 2023 03:09:35 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B216C6
        for <linux-acpi@vger.kernel.org>; Tue, 12 Sep 2023 00:09:31 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1bf57366ccdso43940415ad.1
        for <linux-acpi@vger.kernel.org>; Tue, 12 Sep 2023 00:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1694502570; x=1695107370; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7neP8LMiub1YbC2kDb6STylXpBWNHy6kn2mPL3bRXqg=;
        b=XRFZPUVux/2dyUQ+A8SjhjA9/4HfNlOte/HEz+fyYTHLveaLPGJaa81+OIOCtqx8gs
         sOSnssUeaujnEs2lAKbT+nrecygfmy4d16BkSQRPcmclq/PFA/SCO9Er5+khAkxr8QDG
         E5feKd76R2ZCHPAhTa1WjutJH/Qpb+O5R1HSmX3fzr1jFNOu/rawABSICEwT/vcDerWz
         wyxeqyGRN4kpzJHo5xB0xOqPt5YdqWfy9neSMOXORRnyLJmjMHVhnqeDrLo/vNFOaiig
         xIDDANkMkrgzg/wbyxJPsC5HTe8FXPThh0PILsvrK/gvy8XVMXU0CxivWbplngg5hvXB
         /H1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694502570; x=1695107370;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7neP8LMiub1YbC2kDb6STylXpBWNHy6kn2mPL3bRXqg=;
        b=vjM6HMXbo1cKEM4xXTU1/6uKSlWPvX8V0rcG/2i3Sefw0efZcJgMxu3EOR/ha0PxG1
         nxwWeZaaEfnGLH5tF6funb57vFk4KaiSw9qat1t0tzJUkgdZ20m/H77Zo2IvKgnSbA4S
         PPigLQb0KX86LZ1lPib2o7zC7fav4S3BHPfyYlJg4ZldDGxbjvw9+iVy1/ifUrp4oms5
         9zHLQNcT3AZj7e0XmcvC153aGX3zgJIcQ1QdyzySheRmYbiax3WCQ/Ro3EtRoHTkE8im
         jCYzSDIKkNlOwP59wUXE8yJVuzeL91hO0ghW8rCFjY4xmK2Aj7cEw4fAm3xb5dDAMjRW
         sd4g==
X-Gm-Message-State: AOJu0YyDJN2hG2nZM7cPR3HYBgPfqsKQFMNDxyU6tCFEbTIqcBy0OuVX
        f98Nf32a38pQXs637+QP5DtNiw==
X-Google-Smtp-Source: AGHT+IGcF79zzfYpckzYOnYVVyFO1u3wU048/F7jeQAGwg5JzfCVch2AQDPKcBmJ9F6wALa+zFXMQw==
X-Received: by 2002:a17:902:d501:b0:1c3:22a9:8643 with SMTP id b1-20020a170902d50100b001c322a98643mr2469259plg.31.1694502570653;
        Tue, 12 Sep 2023 00:09:30 -0700 (PDT)
Received: from PF2LML5M-SMJ.bytedance.net ([2001:c10:ff04:0:1000:0:1:f])
        by smtp.gmail.com with ESMTPSA id d4-20020a170902c18400b001bba3a4888bsm7616431pld.102.2023.09.12.00.09.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 00:09:30 -0700 (PDT)
From:   "guojinhui.liam" <guojinhui.liam@bytedance.com>
To:     rafael@kernel.org, lenb@kernel.org, gregkh@linuxfoundation.org
Cc:     lizefan.x@bytedance.com, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "guojinhui.liam" <guojinhui.liam@bytedance.com>
Subject: [PATCH] driver core: platform: set numa_node before platform_add_device()
Date:   Tue, 12 Sep 2023 15:09:00 +0800
Message-Id: <20230912070900.1862-1-guojinhui.liam@bytedance.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

platform_add_device creates numa_node attribute of sysfs according to
whether dev_to_node(dev) is equal to NUMA_NO_NODE. So set the numa node
of the device before creating numa_node attribute of sysfs.

Fixes: 4a60406d3592 ("driver core: platform: expose numa_node to users in sysfs")
Signed-off-by: guojinhui.liam <guojinhui.liam@bytedance.com>
---
 drivers/acpi/acpi_platform.c | 4 +---
 drivers/base/platform.c      | 4 ++++
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/acpi_platform.c b/drivers/acpi/acpi_platform.c
index 48d15dd785f6..adcbfbdc343f 100644
--- a/drivers/acpi/acpi_platform.c
+++ b/drivers/acpi/acpi_platform.c
@@ -178,11 +178,9 @@ struct platform_device *acpi_create_platform_device(struct acpi_device *adev,
 	if (IS_ERR(pdev))
 		dev_err(&adev->dev, "platform device creation failed: %ld\n",
 			PTR_ERR(pdev));
-	else {
-		set_dev_node(&pdev->dev, acpi_get_node(adev->handle));
+	else
 		dev_dbg(&adev->dev, "created platform device %s\n",
 			dev_name(&pdev->dev));
-	}
 
 	kfree(resources);
 
diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 76bfcba25003..355abf91930a 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -808,6 +808,7 @@ struct platform_device *platform_device_register_full(
 {
 	int ret;
 	struct platform_device *pdev;
+	struct acpi_device *adev = to_acpi_device_node(pdevinfo->fwnode);
 
 	pdev = platform_device_alloc(pdevinfo->name, pdevinfo->id);
 	if (!pdev)
@@ -841,6 +842,9 @@ struct platform_device *platform_device_register_full(
 			goto err;
 	}
 
+	if (adev)
+		set_dev_node(&pdev->dev, acpi_get_node(adev->handle));
+
 	ret = platform_device_add(pdev);
 	if (ret) {
 err:
-- 
2.20.1

