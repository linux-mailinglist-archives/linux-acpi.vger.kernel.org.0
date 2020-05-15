Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 254EB1D454E
	for <lists+linux-acpi@lfdr.de>; Fri, 15 May 2020 07:35:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbgEOFfR (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 15 May 2020 01:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726657AbgEOFfO (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 15 May 2020 01:35:14 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 849ABC05BD0B
        for <linux-acpi@vger.kernel.org>; Thu, 14 May 2020 22:35:14 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id q16so1094302qki.13
        for <linux-acpi@vger.kernel.org>; Thu, 14 May 2020 22:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=DX4XT+k02Ir/KDfouowfMsuBfYhxf4GU86W0BHIaHtQ=;
        b=h+QlbAmrwT3Qk4XUER329GnhkSmrKvVq49brjpGM/uyL/DEiMw6DIaqHwVX6GqCOIB
         TknypZylAeb9WhesT1jWWEO02DyLbugXMPf5rmRsRnZpaiaTUzo1fs0oLRyuhWXbpsjX
         Pm8gJKEfiAsoM8LYcey7kctMNCeL/9WKjacPxTokZ+UIIzANPDcR9JeLWvI6uWYrHNub
         sFN6BSjBRFFZy9Pwb5Gjo8WOwwMO3bxjCGrUOBF46x30sYznw9flhLN/Gzgy35+RvJm4
         l5cZChSPp7ithvlffbtvdVokmYA3Pm1O94rTPKB8RtxdWUkQjt+64irBeKpJWbv5xSlg
         dgig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=DX4XT+k02Ir/KDfouowfMsuBfYhxf4GU86W0BHIaHtQ=;
        b=blS2bipKVpeauPbjXHg/d4xReaQxZXTL43XlMG7WCqTMIhsawyFwjRTKd5Ybr3uGov
         7+NFXJlFA3pizncpY4hsSbhV0kF4EHS9mFZUjvJC2A+6inLwGIrU2LegUmqAoNciLFN1
         BnTzA72DDDYDPu95gWvks47QuFSx2RmdCkRXj2ZXld9gHcuSgZDniSVVQuSrMo2U+U54
         iqfSojnqhR0r4m8foebrwACsQ73L7+RYGtp28gykT/T0OD5Xtwb1iGyyn4nrcyiawBOq
         +wd0060kHH78+WmcV0toPrS5Qs54JFS5w5UT9BPNkCvhmb/L16aL8xRMw34JfQuJVboW
         jQ/w==
X-Gm-Message-State: AOAM533pl9WWVabdcfwXdzGPdyH2UV0paYB5bt24wE5GI9y8+2bf670p
        8BCVWIPbiOnHspBJWuQGXq+X2Os/hDqIUx0=
X-Google-Smtp-Source: ABdhPJwU9KkQfudVyjXyuE1Z396eMGSwdCB1SS/UClNjOPAmBPGEnfF7OqgDxMbxzOdUKsYQeJryPfZDxQez2Aw=
X-Received: by 2002:a05:6214:42f:: with SMTP id a15mr1851765qvy.170.1589520913709;
 Thu, 14 May 2020 22:35:13 -0700 (PDT)
Date:   Thu, 14 May 2020 22:35:00 -0700
In-Reply-To: <20200515053500.215929-1-saravanak@google.com>
Message-Id: <20200515053500.215929-5-saravanak@google.com>
Mime-Version: 1.0
References: <20200515053500.215929-1-saravanak@google.com>
X-Mailer: git-send-email 2.26.2.761.g0e0b3e54be-goog
Subject: [PATCH v1 4/4] of: platform: Batch fwnode parsing when adding all top
 level devices
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

The fw_devlink_pause() and fw_devlink_resume() APIs allow batching the
parsing of the device tree nodes when a lot of devices are added. This
will significantly cut down parsing time (as much a 1 second on some
systems). So, use them when adding devices for all the top level device
tree nodes in a system.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/of/platform.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index 3371e4a06248..55d719347810 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -538,7 +538,9 @@ static int __init of_platform_default_populate_init(void)
 	}
 
 	/* Populate everything else. */
+	fw_devlink_pause();
 	of_platform_default_populate(NULL, NULL, NULL);
+	fw_devlink_resume();
 
 	return 0;
 }
-- 
2.26.2.761.g0e0b3e54be-goog

