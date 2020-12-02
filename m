Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 248E82CB52A
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Dec 2020 07:42:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728683AbgLBGlL (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 2 Dec 2020 01:41:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728677AbgLBGlL (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 2 Dec 2020 01:41:11 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71668C0613D4
        for <linux-acpi@vger.kernel.org>; Tue,  1 Dec 2020 22:40:25 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id k5so582668plt.6
        for <linux-acpi@vger.kernel.org>; Tue, 01 Dec 2020 22:40:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zY92Rci4J9j+9ksUhoFOdGaklu6PbRH/V2SAmN+2l0c=;
        b=B2Z50xEZzwXaJoltyohaEnIlsLrSkCR28AjK1pu5MUumAIN3C4GnaDd3byQiOlgsNV
         /J3aCS1X4HYAXTmYvpEO8HPTB6LY17aRx+d1rJGbff/+ssyrenOQ4gUVfAeBDiHXG0ax
         zD8ei0o/BoFL+PO0rChRqyN6UvzNTAzIKdlpEGS8GpjprTVJuVIkcIGshlmH1aNsnd1c
         WkdaBE/u+jkWYbvPfUZnWS7BD1gMrLMVCVTgTjv+zvxFh0fJLsLNd7Lwns+d5EpXKzuE
         JDn/w7cQovRQKiqyObS7nS7ZKB8ik/40QQw1USYebPhUsjShqS2oFKDJ+CfEIrLlMigL
         c47g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zY92Rci4J9j+9ksUhoFOdGaklu6PbRH/V2SAmN+2l0c=;
        b=Ksnw/UqvLIfqtBZAShLtp+N1pkk9d+pUBP+Z3yP426K6xuOq+y3ylN/FiQD6G0ahFC
         9X2qDDrJh0uoWpiyz2e9u9Wwo4dtsa7A5Kt4xCzPd5qPD+gFMOb7fiptyrBRHg+g9BYe
         R82jqB76si1+5cdhSnfeNgVT7RdRtDGM1oyVJLYK8Kms73SwGcCd9ioVK9YgU/o4HP08
         Acwmx2WObGUeZA+gRu2SVHoHjO6McBAcgyIqoKaPHYTM3Vr8IlAvicw51I/neGZ4LhAa
         RrOjvhiKIfis/3bz8U71f1EUGLKTXMkM0MeaqVyWr74svOS5H3MdmguqK63N4RUXgFF3
         jC4g==
X-Gm-Message-State: AOAM532me3Psoh7EmeerjEWOYitRvk20QiAdqMAWPax43VA3e41Y2257
        rIrW1Feo6Cnn4xkciCP6dsLGRw==
X-Google-Smtp-Source: ABdhPJz48qwqgTyyUzdmiHLiBwQSkpTx8KBNvQ4018NE0PSGhPRm0jty+8EQwNgP6SkR00wvBL7S5g==
X-Received: by 2002:a17:90a:202:: with SMTP id c2mr1030309pjc.164.1606891224925;
        Tue, 01 Dec 2020 22:40:24 -0800 (PST)
Received: from localhost.localdomain (123-204-46-122.static.seed.net.tw. [123.204.46.122])
        by smtp.googlemail.com with ESMTPSA id b80sm973181pfb.40.2020.12.01.22.40.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 22:40:24 -0800 (PST)
From:   Chris Chiu <chiu@endlessos.org>
To:     rjw@rjwysocki.net, lenb@kernel.org
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux@endlessos.org, "Jasper St. Pierre" <jstpierre@mecheye.net>,
        Chris Chiu <chiu@endlessos.org>
Subject: [PATCH] ACPI: Add DMI quirk for GIGABYTE GB-BXBT-2807
Date:   Wed,  2 Dec 2020 14:39:42 +0800
Message-Id: <20201202063942.6644-1-chiu@endlessos.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: "Jasper St. Pierre" <jstpierre@mecheye.net>

The GIGABYTE GB-BXBT-2807 is a mini-PC which uses off the shelf
components, like an Intel GPU which is meant for mobile systems.
As such, it, by default, has a backlight controller exposed.

Unfortunately, the backlight controller only confuses userspace, which
sees the existence of a backlight device node and has the unrealistic
belief that there is actually a backlight there!

Add a DMI quirk to force the backlight off on this system.

Signed-off-by: Jasper St. Pierre <jstpierre@mecheye.net>
Reviewed-by: Chris Chiu <chiu@endlessos.org>
---
 drivers/acpi/video_detect.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index 2499d7e3c710..ac2e194acdbf 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -143,6 +143,13 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
 	},
 	{
 	.callback = video_detect_force_vendor,
+	.ident = "GIGABYTE GB-BXBT-2807",
+	.matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "GIGABYTE"),
+		DMI_MATCH(DMI_PRODUCT_NAME, "GB-BXBT-2807"),
+		},
+	},
+	{
 	.ident = "Sony VPCEH3U1E",
 	.matches = {
 		DMI_MATCH(DMI_SYS_VENDOR, "Sony Corporation"),
-- 
2.20.1

