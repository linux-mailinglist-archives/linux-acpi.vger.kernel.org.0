Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7992363CD7
	for <lists+linux-acpi@lfdr.de>; Mon, 19 Apr 2021 09:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237877AbhDSHkX (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 19 Apr 2021 03:40:23 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:34021 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237745AbhDSHkX (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 19 Apr 2021 03:40:23 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 8CC9A1D63;
        Mon, 19 Apr 2021 03:39:53 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 19 Apr 2021 03:39:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=4TNX38GKjiMISnXJe
        hbOyzFj86uT++qqyWJOG2EEdm4=; b=piSVexebXxu2+Z0GY/jTQgWT0zor8i0C9
        LTDwT08/6hzARb0GFhiu7C42noYjxIfW9eU8Y5vOG4A1U7eNIvGTqEckqRXsz5Wk
        m3cJm2L5Mlx6ZJhl8VPbfnyE8tiLbvYdQpOY3RRGpbZeNsW5iya/kQuM5kO1FZWB
        NrX23QTmmI0i7oEcf0QTyL57U3aAVXpZ6hKAhUbCxEKUVE93lGw49ym2m+ctN0bn
        jWSz/lsEu1eO2//Bkg5EyPfxty7bFbKGN18WxEFNneLnVwJeq8FzkPkeGhdoSPWS
        BcFqFfLwEqMJIDU+ixlazJiib1zbSl6qbN4S/w7QsqKynd3U6Jpfw==
X-ME-Sender: <xms:yDN9YKM_uZOPG49u4SO3mniE5G-XKj7Jr_uy65wGxTu6LQfFJk5DIg>
    <xme:yDN9YD2UI8eZ4Sm6ygIFir7FlPE2Yt3_nXsfEPJKu2YHkw0EN7S9ObauwvS0AfM7_
    UUcwnHG1N7pbjZyv2s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvddtfedgudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpedfnfhukhgvucff
    rdculfhonhgvshdfuceolhhukhgvsehljhhonhgvshdruggvvheqnecuggftrfgrthhtvg
    hrnheplefflefhledthfdtveeugfevueeukeegteeigfeihffgjedvtedvueevtdfhvdek
    necukfhppeduudeirddvhedurdduleefrdduleeinecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:yDN9YJGsv7LZJVwV80NB2zRCTQ9bqYwZq1eda24W6VsPc1OzJvJysg>
    <xmx:yDN9YI7NPJKZYuONxqodo5umOr0rhA3tVJS663kxmoOmk6Ocdy-NVg>
    <xmx:yDN9YHsnmWAyy8e8xZP5kouFsNBYNlvWkvcx6KTqvHfNmiFzUFIiAQ>
    <xmx:yTN9YNfxukxZiRhQa9I_-ccg1e9c_7U4gNP1XARGcU7B2gEN9CBNFg>
Received: from fedora.. (unknown [116.251.193.196])
        by mail.messagingengine.com (Postfix) with ESMTPA id E9A4C24005C;
        Mon, 19 Apr 2021 03:39:49 -0400 (EDT)
From:   "Luke D. Jones" <luke@ljones.dev>
To:     rjw@rjwysocki.net
Cc:     lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Luke D Jones <luke@ljones.dev>
Subject: [PATCH 1/3] ACPI: video: use native backlight for GA401/GA502/GA503
Date:   Mon, 19 Apr 2021 19:39:17 +1200
Message-Id: <20210419073917.157722-1-luke@ljones.dev>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Luke D Jones <luke@ljones.dev>

Force backlight control in these models to use the native interface
at /sys/class/backlight/amdgpu_bl0.

Signed-off-by: Luke D. Jones <luke@ljones.dev>
---
 drivers/acpi/video_detect.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index 811d298637cb..bae08bd98817 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -384,6 +384,30 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
 		DMI_MATCH(DMI_BOARD_NAME, "BA51_MV"),
 		},
 	},
+	{
+	.callback = video_detect_force_native,
+	.ident = "ASUSTeK COMPUTER INC. GA401",
+	.matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+		DMI_MATCH(DMI_PRODUCT_NAME, "GA401"),
+		},
+	},
+	{
+	.callback = video_detect_force_native,
+	.ident = "ASUSTeK COMPUTER INC. GA502",
+	.matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+		DMI_MATCH(DMI_PRODUCT_NAME, "GA502"),
+		},
+	},
+	{
+	.callback = video_detect_force_native,
+	.ident = "ASUSTeK COMPUTER INC. GA503",
+	.matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+		DMI_MATCH(DMI_PRODUCT_NAME, "GA503"),
+		},
+	},
 
 	/*
 	 * Desktops which falsely report a backlight and which our heuristics
-- 
2.31.1

