Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A86736980C
	for <lists+linux-acpi@lfdr.de>; Fri, 23 Apr 2021 19:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231312AbhDWROZ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 23 Apr 2021 13:14:25 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:11197 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbhDWROY (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 23 Apr 2021 13:14:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1619198028; x=1650734028;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=pboT/kDc5xJQjQGNQQF1NQ1YOHf2UntvUl8huRCydEo=;
  b=qkzrAXItW9X8+wnjMZMmTxxi94hZ8HdU7kSsGQ+t99pwhLSN+GXxDE5e
   3ArojBLJOP8pau9x/ogStLmhzCw6Mqj3Dc6cnhSEy/KNeXCg/AwEqIA5N
   jSvzSi4u5r7ZeWXZbA0gxfG2yBPf+JkyAZgabqpF+y3qLDnWSr2i+P0fu
   eBoacoXXIPtZ7Ij1E32CRdmwgD525QjPMdXH+91+9VSygCM1O52nKzotw
   0ZoG87z9/y+0H9mW6CS+hSRWQzCcvDqslyXKqfgYn/rj55ChUqSMv1uJd
   YMak+PKg7efzBWzgzYB0F5xfkPbzkQ2Kv52SfKDN4S29TzvrxvwMmu+Fx
   g==;
IronPort-SDR: QqzZ8qBGFZVNzXyKqIC9SolqTBwxHE8E3gmN07EDLb+TLUNsg/jDFszieIv4XL5DhA4rm3Ue9u
 nKQuhXNtqZhQzt5bTJ0bKAgezs8kucDN/+HOSHxSoV2UFM1Az9m1ToVCnftynFaW3WW8QQMm9i
 sB/NyrEW9N1o+xU+1slBupMXhu4Ru6KhXhGrsZ/6lGYOOCc2rcpG2nYl2tpE65N8zXSrH+6xs9
 yCPdmFHDHQe2o4Xd1SdelwgJA8pVSq6xWY1SN6i42BlNQ8DSDAqv3bLfVioCV/IVIVxi9hZYQp
 K9s=
X-IronPort-AV: E=Sophos;i="5.82,246,1613458800"; 
   d="scan'208";a="52301924"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Apr 2021 10:13:46 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 23 Apr 2021 10:13:44 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Fri, 23 Apr 2021 10:13:37 -0700
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
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: [PATCH 0/2] clk: Do not register provider with a NULL dev->of_node 
Date:   Fri, 23 Apr 2021 20:13:32 +0300
Message-ID: <20210423171335.262316-1-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

This fixes a NULL pointer dereference that was revealed by
commit 6579c8d97ad7 ("clk: Mark fwnodes when their clock provider is added")

I chose to just return -ENODEV when a driver calls devm_of_clk_add_hw_provider()
with a NULL dev->of_node, because it seems natural to return a failure when one
asks for an _of_ function to do something, but by providing with a NULL of_node.
Plus, it avoids some waste of memory, as the call to devres_alloc() will not
take place.

The opinions on how to handle this NULL pointer dereference were split, either
by returning an error when one calls devm_of_clk_add_hw_provider() with a NULL
dev->of_node, as I did, or by 
return 0 in of_clk_add_hw_provider() when np == NULL and
return 0 in of_clk_del_provider() when np == NULL.
Let me know if you prefer the second approach.

Compile tested only.

Tudor Ambarus (2):
  clk: Do not register provider with a NULL dev->of_node
  clk: bcm: rpi: Do not call devm_of_clk_add_hw_provider with a NULL
    dev->of_node

 drivers/clk/bcm/clk-raspberrypi.c | 10 ++++++----
 drivers/clk/clk.c                 | 12 +++++++-----
 2 files changed, 13 insertions(+), 9 deletions(-)

-- 
2.25.1

