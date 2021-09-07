Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6825E402F81
	for <lists+linux-acpi@lfdr.de>; Tue,  7 Sep 2021 22:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346472AbhIGURG (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 7 Sep 2021 16:17:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346464AbhIGURF (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 7 Sep 2021 16:17:05 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01B45C061575
        for <linux-acpi@vger.kernel.org>; Tue,  7 Sep 2021 13:15:59 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id u9so16196080wrg.8
        for <linux-acpi@vger.kernel.org>; Tue, 07 Sep 2021 13:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=AEzS+NzXiVO2B1rt9KzaQ+5Htm2vKUYnlV52m7gHTQY=;
        b=Y3uiqLXKYWBfAGyXPPCZhmpgyEGZOEkKCLjNpna93i1kX+Z9wvEzt7cklen5pcuteK
         bx6LcwajhiMEy9WmkRqQH+8r1SWSkUHZ44VuikvZqLShrBX9gm0XZfqO0gLLATvIpSrC
         HQo5HVDyJxu4Fw5AzdHjYyfB6D9MIqf3IvX93vrVUNFDR+zCyGXuPVd+ftzyzaAn7h+Q
         dARF4fwpzfKJ+qWlYQZDGYUJwuc8q8ZanWf2rPTNlsJdybjqq8sjUnuemVzFtoYILo3E
         UT4s9niJKoQISG95HOCEXBrbG/zvCvKPgbzAIs9XuQ1USr3tr73WUjHajaVeyEUpmcjv
         gKzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=AEzS+NzXiVO2B1rt9KzaQ+5Htm2vKUYnlV52m7gHTQY=;
        b=LIwjMKSVofm/DkrLkz1xn7YaRJas473GftjQRyF7XNP+IEh8f81qp8mWPD9SuopxSn
         RXMLJC0Akx56mYOenvKcidveOp+gLaarpr76pU6tRAbnu8i4SOvyhfw4qwGUsWOUiECl
         Ljq2cNCUxHHs8CnLU4/kpN5IsNzIyIGtWQOYLlTik19MGOidSPmiulHko2Pw3451dZfQ
         4uu3MYfm3jtnduRcJTv9J4eFBAVEMAkUBJLVYdLoqwJbbyCMcVl4NqLfPxYj4ecjenqX
         6Q01wE+WqMr9++IfKMfNYGeI82PsoDd6VasLW7vqZktBtsSfYR8m6YaWzFu8yXeIrhTD
         kg0g==
X-Gm-Message-State: AOAM531NWMtEvSXpGZakXx4FMgRy1BTR8tHJ2dGIFANp33ZDNxFDA65X
        B6gXtabwpPwnrxhMQtfMcWZx/3KUcaI=
X-Google-Smtp-Source: ABdhPJwlLK4fBE3fmAMUzLqNlYk2PfqaeljGMEAtHxOJiaoOHeAw1uA6UhMdbDqaQTZk2NQKO+60gw==
X-Received: by 2002:a5d:69c6:: with SMTP id s6mr152255wrw.157.1631045757467;
        Tue, 07 Sep 2021 13:15:57 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f08:4500:e01f:158d:8ab5:13ce? (p200300ea8f084500e01f158d8ab513ce.dip0.t-ipconnect.de. [2003:ea:8f08:4500:e01f:158d:8ab5:13ce])
        by smtp.googlemail.com with ESMTPSA id k4sm12240403wrm.74.2021.09.07.13.15.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Sep 2021 13:15:56 -0700 (PDT)
To:     Jean Delvare <jdelvare@suse.com>
Cc:     linux-acpi@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@intel.com>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH] i2c: i801: Stop using pm_runtime_set_autosuspend_delay(-1)
Message-ID: <57de0110-3b33-a05c-286f-0f744b92340b@gmail.com>
Date:   Tue, 7 Sep 2021 22:15:42 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The original change works as intended, but Andy pointed in [0] that now
userspace could re-enable RPM via sysfs, even though we explicitly want
to disable it. So effectively revert the original patch, just with small
improvements:
- Calls to pm_runtime_allow()/pm_runtime_forbid() don't have to be
  balanced, so we can remove the call to pm_runtime_forbid() in
  i801_remove().
- priv->acpi_reserved is accessed after i801_acpi_remove(), and according
  to Robert [1] the custom handler can't run any longer. Therefore we
  don't have to take priv->acpi_lock.

[0] https://www.spinics.net/lists/linux-i2c/msg52730.html
[1] https://lore.kernel.org/linux-acpi/BYAPR11MB32561D19A0FD9AB93E2B1E5287D39@BYAPR11MB3256.namprd11.prod.outlook.com/T/#t

Fixes: 4e60d5dd10cd ("i2c: i801: Improve disabling runtime pm")
Reported-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/i2c/busses/i2c-i801.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
index 1f929e6c3..f3c79942c 100644
--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -1623,7 +1623,7 @@ i801_acpi_io_handler(u32 function, acpi_physical_address address, u32 bits,
 		 * BIOS is accessing the host controller so prevent it from
 		 * suspending automatically from now on.
 		 */
-		pm_runtime_set_autosuspend_delay(&pdev->dev, -1);
+		pm_runtime_get_sync(&pdev->dev);
 	}
 
 	if ((function & ACPI_IO_MASK) == ACPI_READ)
@@ -1890,9 +1890,6 @@ static void i801_remove(struct pci_dev *dev)
 {
 	struct i801_priv *priv = pci_get_drvdata(dev);
 
-	pm_runtime_forbid(&dev->dev);
-	pm_runtime_get_noresume(&dev->dev);
-
 	i801_disable_host_notify(priv);
 	i801_del_mux(priv);
 	i2c_del_adapter(&priv->adapter);
@@ -1901,6 +1898,10 @@ static void i801_remove(struct pci_dev *dev)
 
 	platform_device_unregister(priv->tco_pdev);
 
+	/* if acpi_reserved is set then usage_count is incremented already */
+	if (!priv->acpi_reserved)
+		pm_runtime_get_noresume(&dev->dev);
+
 	/*
 	 * do not call pci_disable_device(dev) since it can cause hard hangs on
 	 * some systems during power-off (eg. Fujitsu-Siemens Lifebook E8010)
-- 
2.33.0

