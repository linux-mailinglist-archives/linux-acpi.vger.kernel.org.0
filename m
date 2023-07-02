Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 364987451E4
	for <lists+linux-acpi@lfdr.de>; Sun,  2 Jul 2023 21:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233200AbjGBT7J (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 2 Jul 2023 15:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233284AbjGBT6D (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 2 Jul 2023 15:58:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 226DE2680;
        Sun,  2 Jul 2023 12:55:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 56B3160D2B;
        Sun,  2 Jul 2023 19:52:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64ECEC433CA;
        Sun,  2 Jul 2023 19:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688327542;
        bh=lwZ1svAY0g6/mInAGdcu3Le5e9Uq4Rks/r8+ZIvw/h0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kEc2mUH1v6d96NNRMve9JaVCl7c22qr3JbPl1PA3Wps+St6x4xPd7+8EekSRnV+2s
         a+UE52+VKXu8HBSDHobHqVKfyIgCEO824NT3ZcpAMbif1H+/S6uz+ukZjhkgt3njP0
         GDVr+M91BbbBM1NVXau7Iwli5RIpshomg62GbtQDcfgSOn/Ck/WF0dqNxlS4nBu73U
         fYXz7yBKU8rRNPjmb7HRRL7xg4IKRpAV2vv5clVryqFqhBC0A/0HCXgrai96gOL35r
         zbeZr0fC3f1Mnx9zuP3QCeZMVG7eA4RegLMPvI13dMMthc97H9v9rr0cfRIR+9twfS
         P6/97dAftX8Lg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>,
        raycekarneal <raycekarneal@gmail.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>, rafael@kernel.org,
        linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 9/9] ACPI: video: Add backlight=native DMI quirk for Dell Studio 1569
Date:   Sun,  2 Jul 2023 15:51:56 -0400
Message-Id: <20230702195159.1788402-9-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230702195159.1788402-1-sashal@kernel.org>
References: <20230702195159.1788402-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.37
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit 23d28cc0444be3f694eb986cd653b6888b78431d ]

The Dell Studio 1569 predates Windows 8, so it defaults to using
acpi_video# for backlight control, but this is non functional on
this model.

Add a DMI quirk to use the native intel_backlight interface which
does work properly.

Reported-by: raycekarneal <raycekarneal@gmail.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/video_detect.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index 4a77e7e6e3fa0..c8dd7f7407da2 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -526,6 +526,14 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
 		DMI_MATCH(DMI_PRODUCT_NAME, "Precision 7510"),
 		},
 	},
+	{
+	 .callback = video_detect_force_native,
+	 /* Dell Studio 1569 */
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+		DMI_MATCH(DMI_PRODUCT_NAME, "Studio 1569"),
+		},
+	},
 	{
 	 .callback = video_detect_force_native,
 	 /* Acer Aspire 3830TG */
-- 
2.39.2

