Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F2EB369819
	for <lists+linux-acpi@lfdr.de>; Fri, 23 Apr 2021 19:14:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243123AbhDWROk (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 23 Apr 2021 13:14:40 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:11222 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbhDWROk (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 23 Apr 2021 13:14:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1619198043; x=1650734043;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wqgq7pqsXLy9APhVwMMB3KE4tW51aVfTECKn3WOERfU=;
  b=LO1ojkegWj5z77zftm1dIr8CGcQiuYduaJicDrsUk+K7H+yz5jMlkIg2
   OBkzcciVa9wYCthf2ilqQeUbFurL7UN/Kxou+v/el0TK5wMickVVH7dO8
   zAFpdBFeQcFwctQcY6mx3VXGqJC3bqevA/wqacU5PY1wQOwmu7Czu1gA0
   Ap762g/e5Lcch80mGCgBdioXej0SXuQTePq/FUy2z+ZdgEuJ11BExmikO
   K6Iz10pPuDQkp92rkG/duQAO7z9euaIyhxu4rrjA4R0IesqEquYQKyhrH
   OfxUPnqOaNq690kpJzbRmYrD01xZ9GAp5UEriNMW3hxYrWjIy5trQOzto
   A==;
IronPort-SDR: 3tvSmtPWm/TnnbjXHVqeskJ0XLo8TbMcIZrsiniZgIrC7PY3wK2pXk+AXOpj+ZnJkuD8Eff73/
 My9PEZT+xFTs5b9QhDEvy8Q25Xm7aTV+7/H3Aziy6ROKBxkqvERD3eZSGTA6Qv1vx8dv8MYrFv
 e1Dz9sadfdbxkWz3/pOCcx3rgrfZCH4+Z2asUHiVxS6v2UHSfOuK+AZ9DFkdBYU7TRMCmx21d/
 REgTPr4B5FMCXFs0fwqoxZe1Y3vbX+5HQqtv0zYm7MUDRaCSIv5JESGyS7sDitPLK/a/SeNGyM
 SpM=
X-IronPort-AV: E=Sophos;i="5.82,246,1613458800"; 
   d="scan'208";a="52301960"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Apr 2021 10:14:02 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 23 Apr 2021 10:13:58 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Fri, 23 Apr 2021 10:13:52 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>, <nsaenz@kernel.org>,
        <maxime@cerno.tech>, <gregkh@linuxfoundation.org>,
        <rafael@kernel.org>, <khilman@kernel.org>,
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
Subject: [PATCH 2/2] clk: bcm: rpi: Do not call devm_of_clk_add_hw_provider with a NULL dev->of_node
Date:   Fri, 23 Apr 2021 20:13:34 +0300
Message-ID: <20210423171335.262316-3-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210423171335.262316-1-tudor.ambarus@microchip.com>
References: <20210423171335.262316-1-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

devm_of_clk_add_hw_provider() expects, as the "_of_" string indicates,
a non NULL dev->of_node, otherwise it will return -ENODEV.
Since this driver can be probed either through the old-fashioned
platform device registration or through a DT node that is a child of the
firmware node, call devm_of_clk_add_hw_provider() only when the DT node
is present.

Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Fixes: 6579c8d97ad7 ("clk: Mark fwnodes when their clock provider is added")
Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/clk/bcm/clk-raspberrypi.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/bcm/clk-raspberrypi.c b/drivers/clk/bcm/clk-raspberrypi.c
index dd3b71eafabf..84a4e14babff 100644
--- a/drivers/clk/bcm/clk-raspberrypi.c
+++ b/drivers/clk/bcm/clk-raspberrypi.c
@@ -337,10 +337,12 @@ static int raspberrypi_clk_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	ret = devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get,
-					  clk_data);
-	if (ret)
-		return ret;
+	if (dev->of_node) {
+		ret = devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get,
+						  clk_data);
+		if (ret)
+			return ret;
+	}
 
 	rpi->cpufreq = platform_device_register_data(dev, "raspberrypi-cpufreq",
 						     -1, NULL, 0);
-- 
2.25.1

