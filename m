Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4FBE5C0538
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Sep 2022 19:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbiIURYc (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 21 Sep 2022 13:24:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiIURYb (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 21 Sep 2022 13:24:31 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD5771BE
        for <linux-acpi@vger.kernel.org>; Wed, 21 Sep 2022 10:24:28 -0700 (PDT)
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 0E7BB3F337
        for <linux-acpi@vger.kernel.org>; Wed, 21 Sep 2022 17:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1663781067;
        bh=9piyT/VCnJlMmHymPvmNLYxbTaKtOFLio9F+8h9hJ9c=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=uRzvoVjcl871kW1r3aqyrkmqv2OKBponIPV7J7xTHutTOuOTA7Ku6msdy4MFgF4l8
         W47y7WDSp49/HsrbWBBc9ggE38s00keGollHQvHsxFK+bh1x+7GlOwMhIgDtB1SyaC
         x0yyCpZut4ZJiMzg1w8qSbs1sz3rT1EZoQoBDZmfHhFsVf9tyhmb8j0+EnlVwm6yBm
         d4cfd7U+DJddgaag/RWAQZUhguHXPLrgT3s02qVP/EmqmY1rfF4sJmigQEC2oG5xT3
         JYFvBDXudgPeXiWXswGRykcJrHUN2O0howmupSDuhphnn5SN44jT24uE2PAaHeq2jv
         g5RyiGHqV5Lwg==
Received: by mail-pg1-f198.google.com with SMTP id w1-20020a63d741000000b0042c254a4ccdso3795841pgi.15
        for <linux-acpi@vger.kernel.org>; Wed, 21 Sep 2022 10:24:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=9piyT/VCnJlMmHymPvmNLYxbTaKtOFLio9F+8h9hJ9c=;
        b=dFmE07tg03URdzGPObkgt0QZLyUdBrx4sHCsMTJN0X5x7dYkp61MBy5vrEU5Dc4wjB
         S1EjxftexbofX6ln1LvuyN9r7U+zI4vSNNDp/ox1yRHeq/lYVsk7Yfpaf0hE0EyCvMpt
         wdWo3AmRUTcsZCWjwVN5WycVLGDqoezYL9tbQ8Ar1sgG3oCqYWIu6mjepCpUFouDNT3F
         e/HTnOGaHeaPKAcftDsY3tFNJXUqXnoCe7Wzukm1GmRWhhOl10vYuZd55K0/gIWeFPCC
         bSlSNbu7V1x2V6f7twJ9wTv8BJDW2u18We5KEFdzOIFTvFDVphHnsaUVnGBXEK6sK5iK
         3sng==
X-Gm-Message-State: ACrzQf1H2eoqXgibUsW9kzaViNJVO5j/em381y0rwqjulx7EY7ieEDsT
        cmH/+xlcoudmhuM7zLC0Z3h17BLjasB8t9fbo8mb+ggLjTyIayBRPcd8WHLVDpaleJVTUi9015O
        yrweVRTIfr5m0uOITrfNe3lKScUbXxxlGPKBpqpA=
X-Received: by 2002:a17:902:d4c1:b0:176:b795:c639 with SMTP id o1-20020a170902d4c100b00176b795c639mr5717731plg.154.1663781065317;
        Wed, 21 Sep 2022 10:24:25 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4WX1aYTbIwRcfCVN4W588CV/XvjYWHcK6PVkEXvP4qjobX++S8B4HCEEzInRCAY75VXKnmwQ==
X-Received: by 2002:a17:902:d4c1:b0:176:b795:c639 with SMTP id o1-20020a170902d4c100b00176b795c639mr5717712plg.154.1663781065065;
        Wed, 21 Sep 2022 10:24:25 -0700 (PDT)
Received: from workstation.canonical.bluequartz.xyz (c-68-84-194-247.hsd1.az.comcast.net. [68.84.194.247])
        by smtp.gmail.com with ESMTPSA id b8-20020a170902650800b00178a9b193cfsm2310861plk.140.2022.09.21.10.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 10:24:24 -0700 (PDT)
From:   Kellen Renshaw <kellen.renshaw@canonical.com>
To:     linux-acpi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, rafael@kernel.org, lenb@kernel.org,
        hui.wang@canonical.com, kellen.renshaw@canonical.com
Subject: [PATCH] ACPI: resources: Add ASUS model S5402ZA to quirks
Date:   Wed, 21 Sep 2022 10:24:22 -0700
Message-Id: <20220921172422.650880-1-kellen.renshaw@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The Asus Vivobook S5402ZA has the same keyboard issue as Asus Vivobook 
K3402ZA/K3502ZA. The kernel overrides IRQ 1 to Edge_High when it
should be Active_Low.

This patch adds the S5402ZA model to the quirk list.

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=216158
Tested-by: Kellen Renshaw <kellen.renshaw@canonical.com>
Signed-off-by: Kellen Renshaw <kellen.renshaw@canonical.com>
---
Follows e12dee373673 (ACPI: resource: Skip IRQ override on Asus Vivobook 
K3402ZA/K3502ZA).

 drivers/acpi/resource.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index 8b4faec8cae7..5d688e546239 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -414,6 +414,13 @@ static const struct dmi_system_id asus_laptop[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "K3502ZA"),
 		},
 	},
+	{
+		.ident = "Asus Vivobook S5402ZA",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_BOARD_NAME, "S5402ZA"),
+		},
+	},
 	{ }
 };
 
-- 
2.25.1

