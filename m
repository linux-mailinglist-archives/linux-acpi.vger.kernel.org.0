Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C4897A4C36
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Sep 2023 17:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbjIRP2y (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 18 Sep 2023 11:28:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjIRP2e (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 18 Sep 2023 11:28:34 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58A631FCE
        for <linux-acpi@vger.kernel.org>; Mon, 18 Sep 2023 08:26:18 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id 6a1803df08f44-6560eebe1ebso20250596d6.1
        for <linux-acpi@vger.kernel.org>; Mon, 18 Sep 2023 08:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1695050637; x=1695655437; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Tpm5xcoWaqPutX8hLc4KJDonfYY31uGnLv5B+/F01yU=;
        b=iTLEBZrj4nc1B7Cd6OGk0GgR0o7GovZ0PvQqMvZ+GKHQ26jaqLY+ehnZU1WXNStlcg
         NQKx4yf+3R0CszC+ukaPMChY7vWNu6X+a/MyaWUexSrblfhORmpewtWSbcgrerXWweQi
         Ef3f9GKN3EUycQdPwA9E4sJqbBU7eMuQAnOYTc8vXjXiAXZdvBFfjt1/ThshA6xzUfLf
         aBxLBjRSBAO5bFIAHJD7Ehs3uUzVDIAtjpEyb9/lg9ReT74cXTdMSA5k7mvFujKpg5LH
         kmVlu80n1+J/IJuZg54MlPoR4F8Xxeb9ZTyPR/eWHaEsRTgcqe87EKRWxRfDDlPMZ/To
         qDsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695050637; x=1695655437;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tpm5xcoWaqPutX8hLc4KJDonfYY31uGnLv5B+/F01yU=;
        b=D06fekUaWN//eB74ERinT8eZ+wf9R7B9YAc/ozOm/FRphjEfX2feXx5oeKLg8AlYGI
         Zm24hGJh7nycoEes40cGFKFfk9P8rBnQkgvt+qWldxUpehVmjYj++obra0ofZb7Ranf+
         1v+I8S94i3xpTbxVgSALwE2VcMFmEcCpljwY6RtN7hMHbR48lFnd5gBdUsd+9/NGT0Gi
         6qY5Yl454CZLikkgXHAalHU3EFKpD4CK2MUNCrYgwPIuQwvYr4melUmK9a1ocsupZV+W
         Bz9OkD1IIj+MAXrE8/ksH9fEEvThLH3L4udbu0rWftYWc+qqdYZjEh7SdrMu6LV4uWiE
         ezAw==
X-Gm-Message-State: AOJu0Yx7APOY2OkEK3w+SFKNCzgNQ9zE6tksjhgCvH+BAZR1Si+IQF+b
        YBJAVZUHtmnuTcFF7DZETGMKF99hjNVMqa4PVhdhDqG2
X-Google-Smtp-Source: AGHT+IFMTkNiPkvXGoZsRsx+w1ypzJpo0ABobTPJaedpSaKBIFdLxBCcgXUiIKDqPqlVTW1PXE0tng==
X-Received: by 2002:a17:902:c1cc:b0:1c5:72cc:1b65 with SMTP id c12-20020a170902c1cc00b001c572cc1b65mr2361443plc.44.1695044757485;
        Mon, 18 Sep 2023 06:45:57 -0700 (PDT)
Received: from PF2LML5M-SMJ.bytedance.net ([203.208.189.7])
        by smtp.gmail.com with ESMTPSA id h7-20020a170902ac8700b001bc59cd718asm3420818plr.278.2023.09.18.06.45.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 06:45:57 -0700 (PDT)
From:   Jinhui Guo <guojinhui.liam@bytedance.com>
To:     rafael@kernel.org, lenb@kernel.org, gregkh@linuxfoundation.org
Cc:     lizefan.x@bytedance.com, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jinhui Guo <guojinhui.liam@bytedance.com>,
        stable@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: [PATCH v6] driver core: platform: set numa_node before platform_device_add()
Date:   Mon, 18 Sep 2023 21:45:27 +0800
Message-Id: <20230918134527.252-1-guojinhui.liam@bytedance.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Setting the devices' numa_node needs to be done in
platform_device_register_full(), because that's where the
platform device object is allocated.

Fixes: 4a60406d3592 ("driver core: platform: expose numa_node to users in sysfs")
Cc: stable@vger.kernel.org
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202309122309.mbxAnAIe-lkp@intel.com/
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Rafael J. Wysocki <rafael@kernel.org>
Signed-off-by: Jinhui Guo <guojinhui.liam@bytedance.com>
---
V5 -> V6:
  1. Update subject to correct function name platform_device_add().
  2. Provide a more clear and accurate description of the changes
     made in commit (suggested by Rafael J. Wysocki).
  3. Add reviewer name.

V4 -> V5:
  Add Cc: stable line and changes from the previous submited patches.

V3 -> V4:
  Refactor code to be an ACPI function call.

V2 -> V3:
  Fix Signed-off name.

V1 -> V2:
  Fix compile error without enabling CONFIG_ACPI.
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

