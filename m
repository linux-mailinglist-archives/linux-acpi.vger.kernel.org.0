Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 015E5369813
	for <lists+linux-acpi@lfdr.de>; Fri, 23 Apr 2021 19:14:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243314AbhDWROh (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 23 Apr 2021 13:14:37 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:11222 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbhDWROg (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 23 Apr 2021 13:14:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1619198040; x=1650734040;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QIoM99CY+uivITKsW95n7kgBLB9Nzc9i1eVPqL+LXCU=;
  b=i87Q/ntYJWlGLil4DpLPPsmVEnp/6AxQ8l+ulx0ASp4VKdvbovBN/j9E
   VEn5NPfG88bHMgueSv0Lmzy43cPMo2uf3CUCcKeymVh1U0u0/BHQhZ3ZI
   xA6NlJLOdnADF+AOBPlGWNTsp7b7WLKNqXMLNfyr7QvThEVxvqlIWIDDe
   6lW0aH+l7KaLHu5CkwiTzujBcrbOZQa/qp+jwjrG2+oyOm0pm338paU72
   SZQ3uXt6qZptICJc5p1ceBhnWkcY3CQ3xqm6e748CuIzKkyUI87+Ot82t
   aq+TOgErLBPQeqFrSoyrbwPb+JOG4Ka+vBhalQ7Z03OIr3fu4JXpZEZ6Q
   Q==;
IronPort-SDR: T9EqCRHM/Xfwb2+swXmRa0ogKVHe4KIeSvYd56sR/kQkjK4iGNCGr3cRnUeTcSPrMDi/GggrgG
 IrwTy5bfH9hoAc3v1A5h7fnZgPWIXbptO5ehsQ/3Pb8malF41VXFLEJgJeRlNUUBVgQVRJSDSc
 ABv2Fio3Mfn4eKgmn62Qdiyc4jUn3tYqoQv6V58QQGFfdqXBFcvdCPJ2LRFZFhIRMjEGcA/zkl
 epQ/+h+uAlqwJy/l1q7VqI0Bb+adNZjSh8HUbpyUJbzJbA3UzSloI0KUCOR8UGZzIleUOuyjeP
 ISw=
X-IronPort-AV: E=Sophos;i="5.82,246,1613458800"; 
   d="scan'208";a="52301948"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Apr 2021 10:13:59 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 23 Apr 2021 10:13:51 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Fri, 23 Apr 2021 10:13:44 -0700
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
Subject: [PATCH 1/2] clk: Do not register provider with a NULL dev->of_node
Date:   Fri, 23 Apr 2021 20:13:33 +0300
Message-ID: <20210423171335.262316-2-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210423171335.262316-1-tudor.ambarus@microchip.com>
References: <20210423171335.262316-1-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

commit 6579c8d97ad7 ("clk: Mark fwnodes when their clock provider is added")
revealed that clk/bcm/clk-raspberrypi.c driver calls
devm_of_clk_add_hw_provider(), with a NULL dev->of_node.

devm_of_clk_add_hw_provider() should not register the provider with
a NULL dev->of_node, as there is no of_node. Apart of the NULL pointer
dereference that will result when calling fwnode_dev_initialized() in
of_clk_add_hw_provider(), another problem is that when two drivers calling
of_clk_add_hw_provider() with np = NULL, their unregistration order is not
guaranteed to be correct. Avoid all the problems and just return -ENODEV
when the callers of devm_of_clk_add_hw_provider() use a NULL dev->of_node,
which seems the natural way to do.

Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Fixes: 6579c8d97ad7 ("clk: Mark fwnodes when their clock provider is added")
Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/clk/clk.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index e2ec1b745243..8b5077cc5e67 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -4634,11 +4634,10 @@ static struct device_node *get_clk_provider_node(struct device *dev)
  * @get: callback for decoding clk_hw
  * @data: context pointer for @get callback
  *
- * Registers clock provider for given device's node. If the device has no DT
- * node or if the device node lacks of clock provider information (#clock-cells)
- * then the parent device's node is scanned for this information. If parent node
- * has the #clock-cells then it is used in registration. Provider is
- * automatically released at device exit.
+ * Registers clock provider for given device's node. If the device node lacks
+ * of clock provider information (#clock-cells) then the parent device's node is
+ * scanned for this information. If parent node has the #clock-cells then it is
+ * used in registration. Provider is automatically released at device exit.
  *
  * Return: 0 on success or an errno on failure.
  */
@@ -4650,6 +4649,9 @@ int devm_of_clk_add_hw_provider(struct device *dev,
 	struct device_node **ptr, *np;
 	int ret;
 
+	if (!dev->of_node)
+		return -ENODEV;
+
 	ptr = devres_alloc(devm_of_clk_release_provider, sizeof(*ptr),
 			   GFP_KERNEL);
 	if (!ptr)
-- 
2.25.1

