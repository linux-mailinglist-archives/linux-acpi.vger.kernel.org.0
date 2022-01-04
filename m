Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36906483C6F
	for <lists+linux-acpi@lfdr.de>; Tue,  4 Jan 2022 08:29:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233310AbiADH3H (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 4 Jan 2022 02:29:07 -0500
Received: from marcansoft.com ([212.63.210.85]:46198 "EHLO mail.marcansoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233326AbiADH3G (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 4 Jan 2022 02:29:06 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: hector@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 19EC4419BC;
        Tue,  4 Jan 2022 07:28:56 +0000 (UTC)
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
        SHA-cyfmac-dev-list@infineon.com
Subject: [PATCH v2 10/35] brcmfmac: firmware: Allow platform to override macaddr
Date:   Tue,  4 Jan 2022 16:26:33 +0900
Message-Id: <20220104072658.69756-11-marcan@marcan.st>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220104072658.69756-1-marcan@marcan.st>
References: <20220104072658.69756-1-marcan@marcan.st>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Device Tree platforms, it is customary to be able to set the MAC
address via the Device Tree, as it is often stored in system firmware.
This is particularly relevant for Apple ARM64 platforms, where this
information comes from system configuration and passed through by the
bootloader into the DT.

Implement support for this by fetching the platform MAC address and
adding or replacing the macaddr= property in nvram. This becomes the
dongle's default MAC address.

On platforms with an SROM MAC address, this overrides it. On platforms
without one, such as Apple ARM64 devices, this is required for the
firmware to boot (it will fail if it does not have a valid MAC at all).

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Hector Martin <marcan@marcan.st>
---
 .../broadcom/brcm80211/brcmfmac/firmware.c    | 29 +++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c
index 054ea3ed133e..e3f7ac0f5671 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c
@@ -21,6 +21,8 @@
 #define BRCMF_FW_NVRAM_DEVPATH_LEN		19	/* devpath0=pcie/1/4/ */
 #define BRCMF_FW_NVRAM_PCIEDEV_LEN		10	/* pcie/1/4/ + \0 */
 #define BRCMF_FW_DEFAULT_BOARDREV		"boardrev=0xff"
+#define BRCMF_FW_MACADDR_FMT			"macaddr=%pM"
+#define BRCMF_FW_MACADDR_LEN			(7 + ETH_ALEN * 3)
 
 enum nvram_parser_state {
 	IDLE,
@@ -57,6 +59,7 @@ struct nvram_parser {
 	bool multi_dev_v1;
 	bool multi_dev_v2;
 	bool boardrev_found;
+	bool strip_mac;
 };
 
 /*
@@ -121,6 +124,10 @@ static enum nvram_parser_state brcmf_nvram_handle_key(struct nvram_parser *nvp)
 			nvp->multi_dev_v2 = true;
 		if (strncmp(&nvp->data[nvp->entry], "boardrev", 8) == 0)
 			nvp->boardrev_found = true;
+		/* strip macaddr if platform MAC overrides */
+		if (nvp->strip_mac &&
+		    strncmp(&nvp->data[nvp->entry], "macaddr", 7) == 0)
+			st = COMMENT;
 	} else if (!is_nvram_char(c) || c == ' ') {
 		brcmf_dbg(INFO, "warning: ln=%d:col=%d: '=' expected, skip invalid key entry\n",
 			  nvp->line, nvp->column);
@@ -207,6 +214,8 @@ static int brcmf_init_nvram_parser(struct nvram_parser *nvp,
 		size = BRCMF_FW_MAX_NVRAM_SIZE;
 	else
 		size = data_len;
+	/* Add space for properties we may add */
+	size += BRCMF_FW_MACADDR_LEN + 1;
 	/* Alloc for extra 0 byte + roundup by 4 + length field */
 	size += 1 + 3 + sizeof(u32);
 	nvp->nvram = kzalloc(size, GFP_KERNEL);
@@ -366,22 +375,34 @@ static void brcmf_fw_add_defaults(struct nvram_parser *nvp)
 	nvp->nvram_len++;
 }
 
+static void brcmf_fw_add_macaddr(struct nvram_parser *nvp, u8 *mac)
+{
+	snprintf(&nvp->nvram[nvp->nvram_len], BRCMF_FW_MACADDR_LEN + 1,
+		 BRCMF_FW_MACADDR_FMT, mac);
+	nvp->nvram_len += BRCMF_FW_MACADDR_LEN + 1;
+}
+
 /* brcmf_nvram_strip :Takes a buffer of "<var>=<value>\n" lines read from a fil
  * and ending in a NUL. Removes carriage returns, empty lines, comment lines,
  * and converts newlines to NULs. Shortens buffer as needed and pads with NULs.
  * End of buffer is completed with token identifying length of buffer.
  */
 static void *brcmf_fw_nvram_strip(const u8 *data, size_t data_len,
-				  u32 *new_length, u16 domain_nr, u16 bus_nr)
+				  u32 *new_length, u16 domain_nr, u16 bus_nr,
+				  struct device *dev)
 {
 	struct nvram_parser nvp;
 	u32 pad;
 	u32 token;
 	__le32 token_le;
+	u8 mac[ETH_ALEN];
 
 	if (brcmf_init_nvram_parser(&nvp, data, data_len) < 0)
 		return NULL;
 
+	if (eth_platform_get_mac_address(dev, mac) == 0)
+		nvp.strip_mac = true;
+
 	while (nvp.pos < data_len) {
 		nvp.state = nv_parser_states[nvp.state](&nvp);
 		if (nvp.state == END)
@@ -402,6 +423,9 @@ static void *brcmf_fw_nvram_strip(const u8 *data, size_t data_len,
 
 	brcmf_fw_add_defaults(&nvp);
 
+	if (nvp.strip_mac)
+		brcmf_fw_add_macaddr(&nvp, mac);
+
 	pad = nvp.nvram_len;
 	*new_length = roundup(nvp.nvram_len + 1, 4);
 	while (pad != *new_length) {
@@ -546,7 +570,8 @@ static int brcmf_fw_request_nvram_done(const struct firmware *fw, void *ctx)
 	if (data)
 		nvram = brcmf_fw_nvram_strip(data, data_len, &nvram_length,
 					     fwctx->req->domain_nr,
-					     fwctx->req->bus_nr);
+					     fwctx->req->bus_nr,
+					     fwctx->dev);
 
 	if (free_bcm47xx_nvram)
 		bcm47xx_nvram_release_contents(data);
-- 
2.33.0

