Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A452E47F785
	for <lists+linux-acpi@lfdr.de>; Sun, 26 Dec 2021 16:37:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233920AbhLZPhM (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 26 Dec 2021 10:37:12 -0500
Received: from marcansoft.com ([212.63.210.85]:55620 "EHLO mail.marcansoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233879AbhLZPhK (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sun, 26 Dec 2021 10:37:10 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: hector@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 290884494D;
        Sun, 26 Dec 2021 15:37:00 +0000 (UTC)
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
        Chi-hsien Lin <chi-hsien.lin@infineon.com>,
        Wright Feng <wright.feng@infineon.com>,
        Chung-hsien Hsu <chung-hsien.hsu@infineon.com>
Cc:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Mark Kettenis <kettenis@openbsd.org>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
        Pieter-Paul Giesberts <pieter-paul.giesberts@broadcom.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        "John W. Linville" <linville@tuxdriver.com>,
        "Daniel (Deognyoun) Kim" <dekim@broadcom.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com
Subject: [PATCH 04/34] brcmfmac: firmware: Handle per-board clm_blob files
Date:   Mon, 27 Dec 2021 00:35:54 +0900
Message-Id: <20211226153624.162281-5-marcan@marcan.st>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211226153624.162281-1-marcan@marcan.st>
References: <20211226153624.162281-1-marcan@marcan.st>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Teach brcm_alt_fw_paths to correctly split off variable length
extensions, and enable alt firmware lookups for the CLM blob firmware
requests.

Apple platforms have per-board CLM blob files.

Signed-off-by: Hector Martin <marcan@marcan.st>
---
 .../broadcom/brcm80211/brcmfmac/firmware.c       | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c
index cc97cd1da44d..eca5a6df1058 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c
@@ -598,16 +598,16 @@ static const char **brcm_alt_fw_paths(const char *path, const char *board_type)
 {
 	char alt_path[BRCMF_FW_NAME_LEN];
 	char **alt_paths;
-	char suffix[5];
+	const char *suffix;
 
-	strscpy(alt_path, path, BRCMF_FW_NAME_LEN);
-	/* At least one character + suffix */
-	if (strlen(alt_path) < 5)
+	suffix = strrchr(path, '.');
+	if (!suffix || suffix == path)
 		return NULL;
 
-	/* strip .txt or .bin at the end */
-	strscpy(suffix, alt_path + strlen(alt_path) - 4, 5);
-	alt_path[strlen(alt_path) - 4] = 0;
+	/* strip extension at the end */
+	strscpy(alt_path, path, BRCMF_FW_NAME_LEN);
+	alt_path[suffix - path] = 0;
+
 	strlcat(alt_path, ".", BRCMF_FW_NAME_LEN);
 	strlcat(alt_path, board_type, BRCMF_FW_NAME_LEN);
 	strlcat(alt_path, suffix, BRCMF_FW_NAME_LEN);
@@ -638,7 +638,7 @@ static int brcmf_fw_request_firmware(const struct firmware **fw,
 	int ret, i;
 
 	/* Files can be board-specific, first try a board-specific path */
-	if (cur->type == BRCMF_FW_TYPE_NVRAM && fwctx->req->board_type) {
+	if (fwctx->req->board_type) {
 		const char **alt_paths = brcm_alt_fw_paths(cur->path, fwctx);
 
 		if (!alt_paths)
-- 
2.33.0

