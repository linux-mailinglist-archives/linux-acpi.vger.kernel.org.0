Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5222A40E499
	for <lists+linux-acpi@lfdr.de>; Thu, 16 Sep 2021 19:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245372AbhIPREs (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 16 Sep 2021 13:04:48 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:53892
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348297AbhIPRCZ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 16 Sep 2021 13:02:25 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 3F28A40260
        for <linux-acpi@vger.kernel.org>; Thu, 16 Sep 2021 17:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1631811664;
        bh=kGvrlwC8dgj36kHCoqcN/7cctXrefdaA9zTh75o6nwc=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=p9e9jYuAZG15cq1oVUiqNz3U1bAhSfVTgWKgISenDRKK8OqKT1lOTntWQ5QM05xrS
         xjGf4IUdu3NjmMkVuyAZf2vod74CRFCFjfH/WLAyzPnfzHlVsPWRsaAglkvBTWOxDI
         U0AAYf8CaBULJZCfDJukZMdldV9chteJONWu+FTJoEa0PxMFQeXAasfGk1oGbUc2eb
         mey/LS9bt7+0Qy3K7h7BPE8SM7EW8ZJ44jym95HvIQ48YVsWtpR/IjTlnIkYO7avPe
         1fSLDIrf+de0uAYzBRGdrcENQAHnMOnbWcop3jZ65mvMIWTOihJd6FkGKzjxebG04f
         ecQm27ZeBGauw==
Received: by mail-wr1-f71.google.com with SMTP id r7-20020a5d6947000000b0015e0f68a63bso2691181wrw.22
        for <linux-acpi@vger.kernel.org>; Thu, 16 Sep 2021 10:01:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kGvrlwC8dgj36kHCoqcN/7cctXrefdaA9zTh75o6nwc=;
        b=ozyjjAv9EcUcjKPKw+4RqZ2BvJsh/j2QNlzPtPA06IwokwPzxbgbeXil0/EZ5ftwxh
         hCj86+cGjR8CAM4VOIqGHDRwaSocVfUMcU+3XQMF8hW/xQAYzBhoPW3MjASE6+ZpF6jW
         hz2ygEbVNt0+jmDs3fiQsTbWTLDsaEKShC2WhuX3VfT3vN9WcRoBXACSl+FKBhDlAff7
         EtJgcNSZl7IIdnW7ulwuEGjG72i7Vt5INmsKk86H1MZfYWA5ruB0oJES8mxzzE1j7vpS
         6DnU0x87jVklD6d/WYOYBP4izx4LYZWRUrZzXmdvapMZkHrMPPPJGGSfdGhfTj3qwBvi
         NJOw==
X-Gm-Message-State: AOAM532HSzSModWySf6J3yGvHidUqlNXPs7T71KpS16k6iQMosWmj7RR
        U5+V1jdqhgnjr0OorRxD+d2a8XID3cwDa1mC8QxzRRmXJH/ACLmZJewmfgybEOKajzBuPGteZ1q
        cPYhc7Cj1ttb30BlNnXXXA2jkjOlNjigh6U2vpfE=
X-Received: by 2002:adf:f084:: with SMTP id n4mr7440209wro.362.1631811662733;
        Thu, 16 Sep 2021 10:01:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwZv2NplR10Hi7PCHwaacjnOu8R/e6iK1WzNnokBmPAZv6ETWalQ+ItW3RvnaNG42gpPNXYng==
X-Received: by 2002:adf:f084:: with SMTP id n4mr7440176wro.362.1631811662501;
        Thu, 16 Sep 2021 10:01:02 -0700 (PDT)
Received: from kozik-lap.lan (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id q7sm4062646wrr.10.2021.09.16.10.01.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 10:01:01 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Matan Ziv-Av <matan@svgalib.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH 1/2] platform: lg-laptop: drop unneeded MODULE_ALIAS
Date:   Thu, 16 Sep 2021 19:00:53 +0200
Message-Id: <20210916170054.136790-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The MODULE_DEVICE_TABLE already creates proper alias for ACPI driver.
Having another MODULE_ALIAS causes the alias to be duplicated.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/platform/x86/lg-laptop.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/platform/x86/lg-laptop.c b/drivers/platform/x86/lg-laptop.c
index 3e520d5bca07..4f3ece819f4c 100644
--- a/drivers/platform/x86/lg-laptop.c
+++ b/drivers/platform/x86/lg-laptop.c
@@ -60,7 +60,6 @@ MODULE_ALIAS("wmi:" WMI_EVENT_GUID2);
 MODULE_ALIAS("wmi:" WMI_EVENT_GUID3);
 MODULE_ALIAS("wmi:" WMI_METHOD_WMAB);
 MODULE_ALIAS("wmi:" WMI_METHOD_WMBB);
-MODULE_ALIAS("acpi*:LGEX0815:*");
 
 static struct platform_device *pf_device;
 static struct input_dev *wmi_input_dev;
-- 
2.30.2

