Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19D98316594
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Feb 2021 12:48:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231213AbhBJLsP (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 10 Feb 2021 06:48:15 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:53048 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231260AbhBJLqN (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 10 Feb 2021 06:46:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1612957572; x=1644493572;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HiRooR0JRPW34th/7QSHeDW6g1Xmz/WY9IkNdXFN45o=;
  b=XfUqdweFbC/6vzRVj/mX53tPvRbWTx2asMr2LtKB+S27ggN2Iz5USJ6H
   toWzlY0NF28TrX/n6NELdiNqu0kr7+OiY+sVItJ30Sgh7Z6A6OpkZ+2uh
   CX9+nNBO5mhAUPKmNxPjYYL10QSELyBIIfLa2keByWbNhKh6u1eDf38Xq
   RprVo2Ql/dRESLvgsmiHzgYdDf2zE7fOgz79t2vSSg8sRRv6i6ikymtwa
   gALslvPkMakBlP5ubrJIOOcstZbvvxuJU2m2W08BX3XoXGYgTHmbhm88q
   tpcTFR30ONpkd7Awy0i1t3ipp09cWKv1i37HIcSEvTX16Gx6WD58NIsmE
   g==;
IronPort-SDR: OJzOT1L7uR9EmsWc/byKWwNOkbxZX5ra5Qezzd8kgRQ5TkFJOnClQLYVRAhlaYG4DOUZBeg/Du
 tc8jDnu5zgYjn1ZPne5vnQclQ/SYOg7EDOT27/vbn4zYVlcGyyBzd7dsK8QHtlPv3W9LLuWXs5
 fA0+sXRCAF8SDN7JnFwc5KXcjkH2HaRAjecHslK0blQ16mHCN17TgsS3p4WSbpWKZS89oiviWC
 In5HEVkM+jLk/NmesobzktSTduQGvBR6xxpa4cZzRegMmsvSlTBAHcBublgXQlWf3a5D+JaVrx
 yBY=
X-IronPort-AV: E=Sophos;i="5.81,168,1610434800"; 
   d="scan'208";a="114541425"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 10 Feb 2021 04:44:54 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 10 Feb 2021 04:44:53 -0700
Received: from atudor-ThinkPad-T470p.amer.actel.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Wed, 10 Feb 2021 04:44:47 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <corbet@lwn.net>, <gregkh@linuxfoundation.org>,
        <rafael@kernel.org>, <khilman@kernel.org>,
        <ulf.hansson@linaro.org>, <len.brown@intel.com>, <lenb@kernel.org>,
        <pavel@ucw.cz>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh+dt@kernel.org>, <frowand.list@gmail.com>, <maz@kernel.org>,
        <tglx@linutronix.de>, <saravanak@google.com>
CC:     <nicolas.ferre@microchip.com>, <claudiu.beznea@microchip.com>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <m.szyprowski@samsung.com>, <geert@linux-m68k.org>,
        <kernel-team@android.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: [PATCH] clk: Mark fwnodes when their clock provider is added
Date:   Wed, 10 Feb 2021 13:44:34 +0200
Message-ID: <20210210114435.122242-1-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210205222644.2357303-9-saravanak@google.com>
References: <20210205222644.2357303-9-saravanak@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

This is a follow-up for:
commit 3c9ea42802a1 ("clk: Mark fwnodes when their clock provider is added/removed")

The above commit updated the deprecated of_clk_add_provider(),
but missed to update the preferred of_clk_add_hw_provider().
Update it now.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/clk/clk.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 27ff90eacb1f..9370e4dfecae 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -4594,6 +4594,8 @@ int of_clk_add_hw_provider(struct device_node *np,
 	if (ret < 0)
 		of_clk_del_provider(np);
 
+	fwnode_dev_initialized(&np->fwnode, true);
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(of_clk_add_hw_provider);
-- 
2.25.1

