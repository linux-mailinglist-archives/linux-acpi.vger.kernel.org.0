Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A4F57A0884
	for <lists+linux-acpi@lfdr.de>; Thu, 14 Sep 2023 17:06:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240347AbjINPHA (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 14 Sep 2023 11:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234066AbjINPHA (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 14 Sep 2023 11:07:00 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 081B11AE
        for <linux-acpi@vger.kernel.org>; Thu, 14 Sep 2023 08:06:34 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-68fe2470d81so936073b3a.1
        for <linux-acpi@vger.kernel.org>; Thu, 14 Sep 2023 08:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1694703993; x=1695308793; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jG54HLrMQG4OE0xAHorBCovujULO0w3vqxw1/nGGQmo=;
        b=JWrGR+EUYkg0BoQCe8/SpraZULjn1kcnxfs+K/PVHtFHCYa6v1+Xmxks3dOfwyjMVe
         mhkZv3P/fGQQDxOJNqQNGZCJ3gCFp17aHKHliddYMbgtDTPfmintoOZKndmqQNapgobX
         vPJ8bsDsG2AlYpk4b+zkIv0hzKJaTWKdT7pLoHTU67/Fp4KuewTE0PG/dU/vgGzX3H7L
         ZmZ0W464sOJ470BK7apw2X50D2I+fjaSECA1LOdfmqdiTRMLQYBwb0vczWj5hXsw53xQ
         i95UfdrNJb4hEL7Q5Jh+vCpfYI9INiI1FMdhhCKVWcbHwScMfzqS9XUratDBTYZx7uxk
         awnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694703993; x=1695308793;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jG54HLrMQG4OE0xAHorBCovujULO0w3vqxw1/nGGQmo=;
        b=Rrtmvggt66cV777L1q2MBuMvAWz0CSsrnMLqaPfFI5u9xJsKgx/c/c9n3o8/io5qhl
         arri3uXpOTsXlDkLd/mZM8uh2AhGdjO5Lmab58ur19QhwEEkuvOs8ygjiO7YhN7FTkZ7
         00DTPcIGpax1hbhAnhGNc3WInyvEkpN5ka2RDh9yOMB/5eBXqaJLortyFRpleXS+RIb8
         LerWQiMsdwQs4YnOaOu5CjynY5Mkpr95pCa16xHnZL18ihiraYi0wZ3lqNwmApyjXgOq
         rVsWHAvTWP8gPLRvd3Ou7NWKqGfjsEC+6XP4riQKKMldTiJaBWMw9K3IDDBGIHYx7T5v
         pKGQ==
X-Gm-Message-State: AOJu0YzkxFGTfbDJ1YvLTpKROY0Y+CpBbVSq+vNhRfxjijfVpae3MNCc
        yZ4Icm2mA/+2royAawWsUN1BQA==
X-Google-Smtp-Source: AGHT+IHhwHVjntzoz3jPjbLQ62A6HHdFXXYcE9CsoBNeoPxmpWbauBnbpTuoNSuRHyk4RxI1h7URXg==
X-Received: by 2002:a05:6a00:150b:b0:68f:c6f8:1451 with SMTP id q11-20020a056a00150b00b0068fc6f81451mr6554286pfu.16.1694703993458;
        Thu, 14 Sep 2023 08:06:33 -0700 (PDT)
Received: from PF2LML5M-SMJ.lan ([49.7.199.234])
        by smtp.gmail.com with ESMTPSA id t6-20020a62ea06000000b006884549adc8sm1457630pfh.29.2023.09.14.08.06.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 08:06:32 -0700 (PDT)
From:   Jinhui Guo <guojinhui.liam@bytedance.com>
To:     rafael@kernel.org, lenb@kernel.org, gregkh@linuxfoundation.org
Cc:     lizefan.x@bytedance.com, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jinhui Guo <guojinhui.liam@bytedance.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v4] driver core: platform: set numa_node before platform_add_device()
Date:   Thu, 14 Sep 2023 23:06:12 +0800
Message-Id: <20230914150612.3440-1-guojinhui.liam@bytedance.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

platform_add_device() creates the numa_node attribute of sysfs according
to whether dev_to_node(dev) is equal to NUMA_NO_NODE. So set the numa node
of device before creating numa_node attribute of sysfs.

Fixes: 4a60406d3592 ("driver core: platform: expose numa_node to users in sysfs")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202309122309.mbxAnAIe-lkp@intel.com/
Signed-off-by: Jinhui Guo <guojinhui.liam@bytedance.com>
---
 drivers/acpi/acpi_platform.c | 4 +---
 drivers/base/platform.c      | 1 +
 include/linux/acpi.h         | 5 +++++
 3 files changed, 7 insertions(+), 3 deletions(-)

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
index 76bfcba25003..35c891075d95 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -841,6 +841,7 @@ struct platform_device *platform_device_register_full(
 			goto err;
 	}
 
+	set_dev_node(&pdev->dev, ACPI_NODE_GET(ACPI_COMPANION(&pdev->dev)));
 	ret = platform_device_add(pdev);
 	if (ret) {
 err:
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index a73246c3c35e..6a349d53f19e 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -477,6 +477,10 @@ static inline int acpi_get_node(acpi_handle handle)
 	return 0;
 }
 #endif
+
+#define ACPI_NODE_GET(adev) ((adev) && (adev)->handle ? \
+	acpi_get_node((adev)->handle) : NUMA_NO_NODE)
+
 extern int pnpacpi_disabled;
 
 #define PXM_INVAL	(-1)
@@ -770,6 +774,7 @@ const char *acpi_get_subsystem_id(acpi_handle handle);
 #define ACPI_COMPANION_SET(dev, adev)	do { } while (0)
 #define ACPI_HANDLE(dev)		(NULL)
 #define ACPI_HANDLE_FWNODE(fwnode)	(NULL)
+#define ACPI_NODE_GET(adev)		NUMA_NO_NODE
 
 #include <acpi/acpi_numa.h>
 
-- 
2.20.1

