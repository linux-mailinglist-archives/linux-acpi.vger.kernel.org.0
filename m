Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8082319428
	for <lists+linux-acpi@lfdr.de>; Thu, 11 Feb 2021 21:18:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231773AbhBKUSK (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 11 Feb 2021 15:18:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231749AbhBKUSA (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 11 Feb 2021 15:18:00 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 459DDC061786;
        Thu, 11 Feb 2021 12:17:19 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id f14so11985622ejc.8;
        Thu, 11 Feb 2021 12:17:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vG1SnwWHtBNBHayDF+yVo2bQqBQka0EM0VyXHrOitPY=;
        b=BTTzgjXcZszTRG3K8JiFHUpcLkh5b7eprjzLhrt7nDzybIQ4QIEhbYlZwp2nQ+4zAZ
         12fQ49xSW2Q6QbDHzA5sK7i+s31NoIBjbZWDysNd3sC0shtFIjPCh87/x53o2TsYMRxM
         mhrxlJDnsSKm39srvIkYtx8W7M6IXFCWQ224d8QuJXHHopSzEa5aRxcTqGWXtOjssbJ4
         9GQ7/mxiqzJUq8GaXnHXSRxJM/xgafEQrP/+QgO8UYN3bbfIwtG0ktZjHmHIN4vGclLQ
         fIhzo5QoBijtrLEpyqkCPvKfPRQ2M190bDuBWpAfhv+QCdvp3S/9QAexPXTe0qs9g161
         +4mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vG1SnwWHtBNBHayDF+yVo2bQqBQka0EM0VyXHrOitPY=;
        b=KWXr3SseERYLrtKiC3XtC8S9vvokCQElNV0Doansb355071FqKmZTpajRuo7PSS/Hu
         Hv5Mlj+h7IH08+nY+z2efkP1YQZeZTic+V4i6zFimhmNZcZLhl0VkKa5fY5wmCjYiUsQ
         lNiHckAMQ+JPd/WNG38/pksF8WHKjzEIsjerm0kRm8jE0OTQeC1TQY2wfoR5IilWUMDn
         sWtBteaeXWfp/b6VkKw2J6JeAkhNIrvGLFoFxPmkOOdZthoFFwBSp3mlq+tLJbLSmfNd
         l61K+FODcjCoNF2P4iVP9d5Vt3YSXcS1pl9C/2ZWBPrUwscl3MISYp1YQIJpO25O+1a1
         jSUA==
X-Gm-Message-State: AOAM5329iHOsq8MlX1gcoPyFsiO79Bok91Kps/Pn7wHdr66zvnSDLWiN
        cNpAy2JHXnQi1evKjUtwXCA=
X-Google-Smtp-Source: ABdhPJxqgDV00V2rhEkcUN9lbWmyAjsYANQIwAdTCgvbI6rliAe2FOVLUX3gDhu5E7fZt9LCgjDrgQ==
X-Received: by 2002:a17:906:24d1:: with SMTP id f17mr10052540ejb.503.1613074638097;
        Thu, 11 Feb 2021 12:17:18 -0800 (PST)
Received: from xws.localdomain ([37.58.58.229])
        by smtp.gmail.com with ESMTPSA id a1sm4938177edj.6.2021.02.11.12.17.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Feb 2021 12:17:17 -0800 (PST)
From:   Maximilian Luz <luzmaximilian@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Maximilian Luz <luzmaximilian@gmail.com>,
        Mark Gross <mgross@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        Mark Pearson <markpearson@lenovo.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/4] ACPI: platform: Fix file references in comment
Date:   Thu, 11 Feb 2021 21:17:01 +0100
Message-Id: <20210211201703.658240-3-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210211201703.658240-1-luzmaximilian@gmail.com>
References: <20210211201703.658240-1-luzmaximilian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The referenced files are named slightly different. Replace '-' with '_'
and drop the .rst ending.

Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
---
 include/linux/platform_profile.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/linux/platform_profile.h b/include/linux/platform_profile.h
index a26542d53058..b4794027e759 100644
--- a/include/linux/platform_profile.h
+++ b/include/linux/platform_profile.h
@@ -12,9 +12,8 @@
 #include <linux/bitops.h>
 
 /*
- * If more options are added please update profile_names
- * array in platform-profile.c and sysfs-platform-profile.rst
- * documentation.
+ * If more options are added please update profile_names array in
+ * platform_profile.c and sysfs-platform_profile documentation.
  */
 
 enum platform_profile_option {
-- 
2.30.0

