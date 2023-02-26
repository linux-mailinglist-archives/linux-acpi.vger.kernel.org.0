Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 403FB6A3107
	for <lists+linux-acpi@lfdr.de>; Sun, 26 Feb 2023 15:56:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbjBZO4E (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 26 Feb 2023 09:56:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231204AbjBZOzH (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 26 Feb 2023 09:55:07 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA14212BFA;
        Sun, 26 Feb 2023 06:50:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C958560C47;
        Sun, 26 Feb 2023 14:48:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BAD5C433EF;
        Sun, 26 Feb 2023 14:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677422883;
        bh=eSK8hg1UkMaqVFdrzxomPlwdKefl6p/vTJUwx2aw1Yk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GqZs5XQ8X/QzDsJIHdd6ZZxqCefpyYMbVUSJE2l1vnpcbhm3GC4WrY3fqrTRzxHlN
         0oJigopEVdipjdEMde8mOC5UA3Nb5Tzy4JJAPDqOor/wuseQn1clJpAyLkHEpMxs9w
         bUyb1V+nfMNkfLmHCiCN6QH49h8XPfMrhY+vX4VtRPHTHAO1Ch9F3voWxlJg5h5ncd
         JJ6YFq4LnMezqRhG+7dPjpy3m3UOM2lsjnz2we3MczOVgIrGMTNyglQxk4xiDojhXg
         oTgyfe4JNXuSoKtxBt/VS331yNl1ymwA7PmFqhWxY8J8pK7aFER6IN30EcB58ptHih
         DcntwIfIuberw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>, rafael@kernel.org,
        linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 33/49] ACPI: video: Fix Lenovo Ideapad Z570 DMI match
Date:   Sun, 26 Feb 2023 09:46:33 -0500
Message-Id: <20230226144650.826470-33-sashal@kernel.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230226144650.826470-1-sashal@kernel.org>
References: <20230226144650.826470-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit 2d11eae42d52a131f06061015e49dc0f085c5bfc ]

Multiple Ideapad Z570 variants need acpi_backlight=native to force native
use on these pre Windows 8 machines since acpi_video backlight control
does not work here.

The original DMI quirk matches on a product_name of "102434U" but other
variants may have different product_name-s such as e.g. "1024D9U".

Move to checking product_version instead as is more or less standard for
Lenovo DMI quirks for similar reasons.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/video_detect.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index b48f85c3791e9..7f0ed845cd6ad 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -432,7 +432,7 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
 	 /* Lenovo Ideapad Z570 */
 	 .matches = {
 		DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
-		DMI_MATCH(DMI_PRODUCT_NAME, "102434U"),
+		DMI_MATCH(DMI_PRODUCT_VERSION, "Ideapad Z570"),
 		},
 	},
 	{
-- 
2.39.0

