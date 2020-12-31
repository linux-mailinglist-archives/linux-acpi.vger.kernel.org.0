Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E520C2E7FB1
	for <lists+linux-acpi@lfdr.de>; Thu, 31 Dec 2020 12:36:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726499AbgLaLgQ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 31 Dec 2020 06:36:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbgLaLgO (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 31 Dec 2020 06:36:14 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF815C061575
        for <linux-acpi@vger.kernel.org>; Thu, 31 Dec 2020 03:35:33 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id b5so5235196pjl.0
        for <linux-acpi@vger.kernel.org>; Thu, 31 Dec 2020 03:35:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=VvNbdMgLzpd7ixuoNwnyFlGlaRTTC2c804LXFW9PL8Q=;
        b=wg5KP8IzqFr4LBkLFYoo0kTLFg3muBtnzy4SsGLz2/GYX3cGmgtFwiZXxtMdzoNYQ1
         eLiq+NGuE2ZPqSzyWX/6D/P4oj+LVsuMakpXzNlQ9dPST4xK/mFNRV5YqsA9znelGQsM
         tCqb1Gb/89bdo1F+4seZ2n4FCMfaHWW2+9zXux2GBf1uZT7RXkNyDzvsUmn8hvJ5gkun
         7nUDIswlPJt0D9igHYTEs6yaVcjca+ENL8KEeq4kPqKiAJ3JrsDCwwus1BEveEt6Q+ov
         U3VA9i7NtixpCZDbSPeHhPPvlwN211EkdR/e8eK4drhKtLwiwD0dtymuQMR6O9JqrS6d
         R09w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=VvNbdMgLzpd7ixuoNwnyFlGlaRTTC2c804LXFW9PL8Q=;
        b=i9LSHqPtjtF4Eo19AJK8n2SijgCYH2MlNT1Hqk02vc8bH0lQR1n20QAcCV9yL5SO+q
         JPJN0MMLldaihaURn2sNMoFZ4EHcnEA2gIapMHMydsjYKjakemX3wFjtTxuYhJXH/QbY
         wxdVgT9jqrdM5IP2MGOrTpZ58fN5Mv6YAnJregZ6/lH/2tBMZvIw+o4RmyC06lpwCwNz
         qUNdUb+MQBYe3vEZyD9ZrhgfLMBZzjvUXQZA3U8xIC22eeB9K8/Pi/ben0gwrT7PzHt/
         7mT/jgSem2gTQjqrAsdS0lKoX6iZLjCc+msAQJkVvpYqXoLjZ/+FMJAsEySol3OAIyxY
         AAEA==
X-Gm-Message-State: AOAM532majvjP8a5w+1HxcMQQtpfwP/qJzdFq5qF8ljNgbTO1gsGU5Sz
        8SU9VUpuvZRj9YGVZWWBZj6f5A==
X-Google-Smtp-Source: ABdhPJwHoHQFvcQVg2voukSs3bfIkm20izqJoruuT3gb8MD6kNkThudCn215vm/E7MdLybVF+lnoEQ==
X-Received: by 2002:a17:902:6947:b029:db:c7fd:9db3 with SMTP id k7-20020a1709026947b02900dbc7fd9db3mr56751334plt.56.1609414533244;
        Thu, 31 Dec 2020 03:35:33 -0800 (PST)
Received: from localhost.localdomain (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id n10sm36381528pfu.176.2020.12.31.03.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Dec 2020 03:35:32 -0800 (PST)
From:   Shawn Guo <shawn.guo@linaro.org>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH] ACPI: add stub acpi_create_platform_device() for !CONFIG_ACPI
Date:   Thu, 31 Dec 2020 19:35:25 +0800
Message-Id: <20201231113525.19614-1-shawn.guo@linaro.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

It adds a stub acpi_create_platform_device() for !CONFIG_ACPI build, so
that caller doesn't have to deal with !CONFIG_ACPI build issue.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
This fixes an build issue reported by kernel test robot as below.

https://lore.kernel.org/linux-arm-msm/20201230124925.19260-1-shawn.guo@linaro.org/T/#u

 include/linux/acpi.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 2630c2e953f7..053bf05fb1f7 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -885,6 +885,13 @@ static inline int acpi_device_modalias(struct device *dev,
 	return -ENODEV;
 }
 
+static inline struct platform_device *
+acpi_create_platform_device(struct acpi_device *adev,
+			    struct property_entry *properties)
+{
+	return NULL;
+}
+
 static inline bool acpi_dma_supported(struct acpi_device *adev)
 {
 	return false;
-- 
2.17.1

