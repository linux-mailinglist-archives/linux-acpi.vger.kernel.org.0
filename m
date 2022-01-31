Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED3784A4B6A
	for <lists+linux-acpi@lfdr.de>; Mon, 31 Jan 2022 17:10:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380146AbiAaQJm (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 31 Jan 2022 11:09:42 -0500
Received: from marcansoft.com ([212.63.210.85]:35068 "EHLO mail.marcansoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1380145AbiAaQIb (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 31 Jan 2022 11:08:31 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: hector@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 9AC8941F75;
        Mon, 31 Jan 2022 16:08:22 +0000 (UTC)
From:   Hector Martin <marcan@marcan.st>
To:     Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Wright Feng <wright.feng@infineon.com>,
        Dmitry Osipenko <digetx@gmail.com>
Cc:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Mark Kettenis <kettenis@openbsd.org>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
        Pieter-Paul Giesberts <pieter-paul.giesberts@broadcom.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        "John W. Linville" <linville@tuxdriver.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com,
        Arend van Spriel <arend.vanspriel@broadcom.com>
Subject: [PATCH v4 7/9] brcmfmac: of: Use devm_kstrdup for board_type & check for errors
Date:   Tue,  1 Feb 2022 01:07:11 +0900
Message-Id: <20220131160713.245637-8-marcan@marcan.st>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220131160713.245637-1-marcan@marcan.st>
References: <20220131160713.245637-1-marcan@marcan.st>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

This was missing a NULL check, and we can collapse the strlen/alloc/copy
into a devm_kstrdup().

Reviewed-by: Arend van Spriel <arend.vanspriel@broadcom.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Hector Martin <marcan@marcan.st>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
index 513c7e6421b2..5708de1d9f26 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
@@ -79,8 +79,11 @@ void brcmf_of_probe(struct device *dev, enum brcmf_bus_type bus_type,
 
 		/* get rid of '/' in the compatible string to be able to find the FW */
 		len = strlen(tmp) + 1;
-		board_type = devm_kzalloc(dev, len, GFP_KERNEL);
-		strscpy(board_type, tmp, len);
+		board_type = devm_kstrdup(dev, tmp, GFP_KERNEL);
+		if (!board_type) {
+			of_node_put(root);
+			return;
+		}
 		for (i = 0; i < board_type[i]; i++) {
 			if (board_type[i] == '/')
 				board_type[i] = '-';
-- 
2.33.0

