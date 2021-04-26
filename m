Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D7DD36AC7E
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Apr 2021 08:56:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231907AbhDZG5M (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 26 Apr 2021 02:57:12 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:23292 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231616AbhDZG5L (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 26 Apr 2021 02:57:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1619420190; x=1650956190;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=uhDMDx6U8lKJACDDMg5wJ1xGShyMkk8ZFuePWaxHS1A=;
  b=I4NZFXczk40EQQ/Nhzl1I86VCKQr30BOqZ7Yd6HdL+tmHgFqi2S4iRg2
   Jdd1ubPhMpCigXqHdGxDpi95Dt6UPX04yu6gw/7Du3wv0HGvfEbFQdaaW
   J95xJALTAQD3GzuxkUJ2j42dAITlaXIVllyioECvofvpzIUbCl0tH8+c+
   mFCBR/mopW+CTS+8a3sluYkQtDlqBeDoy1qHwUVxU7UUlgvS8FxgXpdgO
   0shaefzdjS5nTI1O8PXVyPF0FTuGy5aNjSAyacu1QALLLqz5kywUMd36X
   RzA6FcDQRJiZjV3E/8eqdLAcUKkqLfG1dH6DlnY+OugJsGRZ8KfQ4xvz5
   w==;
IronPort-SDR: eQx0XRS0qdgNtEscfcMgNylm24Yn6OdQCsMYQ/JM+r0a2OLPJWPoIAGuTJkX2E7JJ4azYberSY
 pTbQTH3KHNSQBuPHfR3uiIZ0ECAkZsAOLTnDm1rUpmG16AOf/oXI1Cs3iuuhuXANXlgHO5C2LI
 qGON2LKbum09IQQUT62FJeOo5mxoQKMiFq7fDViWaZXqT9uTgxAsu6vSJGOwb9Zm72sova0vMf
 5qecgKuyfyeYMMhpsZway34KiQkqBgdq2xm881kQvgLvvktY53qH52eq/Au5msKIZ0Q2KCbK5l
 kCs=
X-IronPort-AV: E=Sophos;i="5.82,251,1613458800"; 
   d="scan'208";a="118343164"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Apr 2021 23:56:27 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sun, 25 Apr 2021 23:56:27 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Sun, 25 Apr 2021 23:56:20 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>, <nsaenz@kernel.org>,
        <maxime@cerno.tech>, <khilman@kernel.org>,
        <ulf.hansson@linaro.org>, <len.brown@intel.com>, <pavel@ucw.cz>,
        <robh+dt@kernel.org>, <frowand.list@gmail.com>, <maz@kernel.org>,
        <tglx@linutronix.de>, <saravanak@google.com>,
        <geert@linux-m68k.org>, <nsaenzjulienne@suse.de>,
        <linux@roeck-us.net>, <guillaume.tucker@collabora.com>
CC:     <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <corbet@lwn.net>, <nicolas.ferre@microchip.com>,
        <claudiu.beznea@microchip.com>, <linux-doc@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>, <kernel-team@android.com>,
        <linux-rpi-kernel@lists.infradead.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v2] clk: Skip clk provider registration when np is NULL
Date:   Mon, 26 Apr 2021 09:56:18 +0300
Message-ID: <20210426065618.588144-1-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

commit 6579c8d97ad7 ("clk: Mark fwnodes when their clock provider is added")
revealed that clk/bcm/clk-raspberrypi.c driver calls
devm_of_clk_add_hw_provider(), with a NULL dev->of_node, which resulted in a
NULL pointer dereference in of_clk_add_hw_provider() when calling
fwnode_dev_initialized().

Returning 0 is reducing the if conditions in driver code and is being
consistent with the CONFIG_OF=n inline stub that returns 0 when CONFIG_OF
is disabled. The downside is that drivers will maybe register clkdev lookups
when they don't need to and waste some memory.

Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Fixes: 6579c8d97ad7 ("clk: Mark fwnodes when their clock provider is added")
Fixes: 3c9ea42802a1 ("clk: Mark fwnodes when their clock provider is added/removed")
Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
---
v2:
- s/return 0;/return; in void of_clk_del_provider()
- add second fixes tag and Stephen's R-b tag
The opinions on whether to return an error or zero were split. Returning 0
and skipping the logic was considered safer as we don't know for sure if
other drivers are affected. See:
https://lore.kernel.org/lkml/d24bebc5-0f78-021f-293f-e58defa32531@samsung.com/
https://lore.kernel.org/lkml/20210423171335.262316-1-tudor.ambarus@microchip.com/

 drivers/clk/clk.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index a3b30f7de2ef..b47460b40d14 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -4552,6 +4552,9 @@ int of_clk_add_provider(struct device_node *np,
 	struct of_clk_provider *cp;
 	int ret;
 
+	if (!np)
+		return 0;
+
 	cp = kzalloc(sizeof(*cp), GFP_KERNEL);
 	if (!cp)
 		return -ENOMEM;
@@ -4591,6 +4594,9 @@ int of_clk_add_hw_provider(struct device_node *np,
 	struct of_clk_provider *cp;
 	int ret;
 
+	if (!np)
+		return 0;
+
 	cp = kzalloc(sizeof(*cp), GFP_KERNEL);
 	if (!cp)
 		return -ENOMEM;
@@ -4688,6 +4694,9 @@ void of_clk_del_provider(struct device_node *np)
 {
 	struct of_clk_provider *cp;
 
+	if (!np)
+		return;
+
 	mutex_lock(&of_clk_mutex);
 	list_for_each_entry(cp, &of_clk_providers, link) {
 		if (cp->node == np) {
-- 
2.25.1

