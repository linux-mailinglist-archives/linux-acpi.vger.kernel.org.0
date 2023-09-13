Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B606479E74B
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Sep 2023 13:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240547AbjIMLzj (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 13 Sep 2023 07:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240559AbjIMLzh (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 13 Sep 2023 07:55:37 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FBFE19A8
        for <linux-acpi@vger.kernel.org>; Wed, 13 Sep 2023 04:55:11 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-68fc9e0e22eso2491666b3a.1
        for <linux-acpi@vger.kernel.org>; Wed, 13 Sep 2023 04:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1694606110; x=1695210910; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Pu3JgOqK1qHfFlEv9iaLw63FLkSFt2itvwieh3FO1vk=;
        b=bZ/l5Kd+2SjBTtwKoIHzPttwSBBYggtRYHFIzzewJ6yM+ivLoGRA3O+4AAnLoLVqYi
         OUtrCCPtFHaVn0bdlXMOSfwSXwDKHFM90P/hsY2dP9oDW30BUbt+bhX1kpQw2hJE433i
         o+6HbmqD2I3ADPstgQRGHftMiptC3BNc5UOE9eTemDMAHVKTkgCXT+tTAkKZhHGpehmB
         h2Ylh5ZvAryAmpA5pw4uKvYxW1ufkTfKA23sJfwYFOZxCMl46kdk5iNFvb5AtTE2cN+A
         E4x4ati8q0M7Bm7qG/Mdkc3F1x0HZ8rgy1g3Dfg+lM4WpS2QZjxLUWG5EPLOxABNfJnv
         2LVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694606110; x=1695210910;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pu3JgOqK1qHfFlEv9iaLw63FLkSFt2itvwieh3FO1vk=;
        b=MsAjR6uoEorJQT0t5RIIKNcP2Vh209WSzHAP/CTyifUztnqaSq+2b//W8yyWkNbTdM
         NvUGMTcEruQIRAqvdTJfhRsBQT50PhoiolUhIQISyKmMhUbdIA07IBnY2A/czuRhwIZZ
         gprcZV392OIqWYECAxlUU+zZDOXMFn9IvSYIsHfWeDeVrvJjK/rnW1HnkVVJVb4dqdVH
         Svw6ZwiLmy6/28LBYbX0oxpZPofBrtrnLdD0ZW/HG9PsCFi/EpMo9BfWekAjzCrWbI95
         x/romLxDG/28OpbyKLDtYKtH/wDEycJCBMna5MZNSevAhmawHk5qQ63aeiDKcnOdcJVQ
         YBVA==
X-Gm-Message-State: AOJu0YzpEyfSf2DgZmY8JOiI42jNvZpAwySLZByvJNxlL7ZdpXeuGvlE
        8M05UPkQ4FBrmv66RUg7HBxCNQ==
X-Google-Smtp-Source: AGHT+IEa23NP5lIOAPDrGV3RoJboYf5AS5rs7k+0dzft6BSZdffsVotXwlj4ni6ad66boED4BOGMew==
X-Received: by 2002:a05:6a00:1a10:b0:68c:b30:8fcc with SMTP id g16-20020a056a001a1000b0068c0b308fccmr2421901pfv.20.1694606110092;
        Wed, 13 Sep 2023 04:55:10 -0700 (PDT)
Received: from PF2LML5M-SMJ.bytedance.net ([220.243.131.6])
        by smtp.gmail.com with ESMTPSA id w4-20020aa78584000000b006732786b5f1sm3790854pfn.213.2023.09.13.04.55.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 04:55:09 -0700 (PDT)
From:   Jinhui Guo <guojinhui.liam@bytedance.com>
To:     rafael@kernel.org, lenb@kernel.org, gregkh@linuxfoundation.org
Cc:     lizefan.x@bytedance.com, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Jinhui Guo" <guojinhui.liam@bytedance.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v3] driver core: platform: set numa_node before platform_add_device()
Date:   Wed, 13 Sep 2023 19:54:54 +0800
Message-Id: <20230913115454.3073-1-guojinhui.liam@bytedance.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: "Jinhui Guo" <guojinhui.liam@bytedance.com>

platform_add_device creates numa_node attribute of sysfs according to
whether dev_to_node(dev) is equal to NUMA_NO_NODE. So set the numa node
of the device before creating numa_node attribute of sysfs.

Fixes: 4a60406d3592 ("driver core: platform: expose numa_node to users in sysfs")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202309122309.mbxAnAIe-lkp@intel.com/
Signed-off-by: Jinhui Guo <guojinhui.liam@bytedance.com>
---
 drivers/acpi/acpi_platform.c |  4 +---
 drivers/base/platform.c      | 13 +++++++++++++
 2 files changed, 14 insertions(+), 3 deletions(-)

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
index 76bfcba25003..206dc7b020cd 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -795,6 +795,18 @@ void platform_device_unregister(struct platform_device *pdev)
 }
 EXPORT_SYMBOL_GPL(platform_device_unregister);
 
+#ifdef CONFIG_ACPI
+static inline void platform_set_dev_node(struct platform_device *pdev)
+{
+	struct acpi_device *adev = to_acpi_device_node(pdev->dev.fwnode);
+
+	if (adev && adev->handle)
+		set_dev_node(&pdev->dev, acpi_get_node(adev->handle));
+}
+#else
+static inline void platform_set_dev_node(struct platform_device *pdev) {}
+#endif
+
 /**
  * platform_device_register_full - add a platform-level device with
  * resources and platform-specific data
@@ -841,6 +853,7 @@ struct platform_device *platform_device_register_full(
 			goto err;
 	}
 
+	platform_set_dev_node(pdev);
 	ret = platform_device_add(pdev);
 	if (ret) {
 err:
-- 
2.20.1

