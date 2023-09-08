Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8390798C98
	for <lists+linux-acpi@lfdr.de>; Fri,  8 Sep 2023 20:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343775AbjIHSRb (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 8 Sep 2023 14:17:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343751AbjIHSR0 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 8 Sep 2023 14:17:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E985211E;
        Fri,  8 Sep 2023 11:17:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B28C3C433BB;
        Fri,  8 Sep 2023 18:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694196105;
        bh=zFSc0oOUgRHVXI6V5t78Gov2kGzq/C8X29Th1niojrw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R3EFiB9F0xc2l1XJMbfYHNwCB7c/t+Q0J5PF54sYbeTWAG/VtpaVKbw1VAvCfbp49
         AcHry7346hHpUULuIs22DQ/NCZBB8ahKIBEbBJP4J/ZOWci9x3/3YbwZlsxGrFfb3k
         iEp8q7BSEREpQ15Dh6mruT0AjLx361NyutLe4fU66CiOnSDPrsPRVIULZdkjiChxcF
         o0x8F7f79re2HN0aU2lXQy8ea9NggLTBgwsZBsnEatB7q3vmZT98SYAjJN+6dTR0S5
         fojT/Std+guMEarxDOY/MkC7p8GMm4XPOoNllvLijKk4Dl3asd7nlMpJX3aQTgxZPC
         L4D4Cz4gxJmZA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>, rafael@kernel.org,
        linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.4 10/13] ACPI: video: Add backlight=native DMI quirk for Apple iMac12,1 and iMac12,2
Date:   Fri,  8 Sep 2023 14:00:56 -0400
Message-Id: <20230908180100.3458151-10-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230908180100.3458151-1-sashal@kernel.org>
References: <20230908180100.3458151-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.4.15
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

[ Upstream commit 8cf04bb321f036dd2e523e993897e0789bd5265c ]

Linux defaults to picking the non-working ACPI video backlight interface
on the Apple iMac12,1 and iMac12,2.

Add a DMI quirk to pick the working native radeon_bl0 interface instead.

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/1838
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2753
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/video_detect.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index 922a31857397c..1244cf9582886 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -495,6 +495,24 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
 		DMI_MATCH(DMI_PRODUCT_NAME, "iMac11,3"),
 		},
 	},
+	{
+	 /* https://gitlab.freedesktop.org/drm/amd/-/issues/1838 */
+	 .callback = video_detect_force_native,
+	 /* Apple iMac12,1 */
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "Apple Inc."),
+		DMI_MATCH(DMI_PRODUCT_NAME, "iMac12,1"),
+		},
+	},
+	{
+	 /* https://gitlab.freedesktop.org/drm/amd/-/issues/2753 */
+	 .callback = video_detect_force_native,
+	 /* Apple iMac12,2 */
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "Apple Inc."),
+		DMI_MATCH(DMI_PRODUCT_NAME, "iMac12,2"),
+		},
+	},
 	{
 	 /* https://bugzilla.redhat.com/show_bug.cgi?id=1217249 */
 	 .callback = video_detect_force_native,
-- 
2.40.1

