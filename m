Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 512AF6D2D15
	for <lists+linux-acpi@lfdr.de>; Sat,  1 Apr 2023 03:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233608AbjDABpa (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 31 Mar 2023 21:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233617AbjDABpD (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 31 Mar 2023 21:45:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 576BC22916;
        Fri, 31 Mar 2023 18:43:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 07E40B8331A;
        Sat,  1 Apr 2023 01:43:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 013BAC4339C;
        Sat,  1 Apr 2023 01:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680313428;
        bh=MeGy0MOALBiuRe8CcWLS3lryePjtmMT+QnPF+LdrO28=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g463gtaEeQciqP1sUulM+AviomgptnjMaHwmzO/wX3h19e10OhjdS3lTbTMvCTKKk
         2tWlYy0BF1CrfCQ+4zFaFZAY4K4XfloUxOze93I/D+bLZMH4NxiDknTdk7nO+z+nb4
         tn+El4LRehzZaSrkZjs0D09L3yXRox5i/HES2ZbbWOaTYTJO5izHdsHDwgh6dxnVZn
         ykUdGde8DqA95Aq7FIUNEFMqDPA76YYytEF+HIN4vcCRKHW006zjejxLAkC1MS570/
         +WsQAuQjjZIFuFdekUfylgNlEHjZMlUFdiIXV2GjmhdiPp65qcXor+6Tt6Qc8aErNA
         FvfRo+GtGKUpQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Aymeric Wibo <obiwac@gmail.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>, rafael@kernel.org,
        linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 24/24] ACPI: resource: Add Medion S17413 to IRQ override quirk
Date:   Fri, 31 Mar 2023 21:42:40 -0400
Message-Id: <20230401014242.3356780-24-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230401014242.3356780-1-sashal@kernel.org>
References: <20230401014242.3356780-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Aymeric Wibo <obiwac@gmail.com>

[ Upstream commit 2d0ab14634a26e54f8d6d231b47b7ef233e84599 ]

Add DMI info of the Medion S17413 (board M1xA) to the IRQ override
quirk table. This fixes the keyboard not working on these laptops.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=213031
Signed-off-by: Aymeric Wibo <obiwac@gmail.com>
[ rjw: Fixed up white space ]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/resource.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index a222bda7e15b0..d08818baea88f 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -400,6 +400,13 @@ static const struct dmi_system_id medion_laptop[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "M17T"),
 		},
 	},
+	{
+		.ident = "MEDION S17413",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "MEDION"),
+			DMI_MATCH(DMI_BOARD_NAME, "M1xA"),
+		},
+	},
 	{ }
 };
 
-- 
2.39.2

