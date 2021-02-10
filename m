Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39300316598
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Feb 2021 12:48:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231271AbhBJLs1 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 10 Feb 2021 06:48:27 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:53072 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231274AbhBJLqR (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 10 Feb 2021 06:46:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1612957576; x=1644493576;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HiRooR0JRPW34th/7QSHeDW6g1Xmz/WY9IkNdXFN45o=;
  b=EUoy18tJpFtBwDKPjQZW2bKumgPneRtSZOrWKJTwZvf+518vchPLcjeV
   NmoGoLo7m2ruplzpCZGbX9eFqJ5SFiJ36DIw3tZVtyDpyWORnYdzL/NUo
   O97KFtpKO+ADBX5cb7YzokppL7L4cbMUfwFl/3WLxq9lofW8hPeAjL6sP
   7wAyNsb68O6j73iO4+v1ADWJR2PXVN83t7d1NW9h6bHCjzekxwtEFSHvy
   PT7Y15nXvXowJoNVodlZUG9qHFuR2IRHotuAJMPICJukItAoUPl5pX9mW
   dLcN4C9CfFqd7ChFzkEeabaIiX1+Jnsu2JEEDHx//tIKHo5bMpWI+xOs5
   g==;
IronPort-SDR: VRlDMKK2cHa3TxUR1JcmsJssA6kfjrVR7Z5f3Ls10/pKx5MNfbGzJXh0KqrAy6OgoxHnvFnykg
 xUIkDzlfEUgsWVTMJI6exxnVy6E2cZyksQSIZ9X7Qg+J1oajssVGB+YxTkbGImT7cAYeG/aF4s
 xhPVW6KZqdiT/345FloQXjz2v8LKSC/bROy7v1NYu9SxtBAD4SuVSYwtAM3otWs0cOpS264QX7
 0GXcd8BB/xVxPezvoMlkvU++SuivhTUGOJt2Ns8Exffejay8FjVRuDMDkhMO21YWorfBxuGz2r
 pAI=
X-IronPort-AV: E=Sophos;i="5.81,168,1610434800"; 
   d="scan'208";a="114541474"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 10 Feb 2021 04:44:59 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 10 Feb 2021 04:44:59 -0700
Received: from atudor-ThinkPad-T470p.amer.actel.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Wed, 10 Feb 2021 04:44:53 -0700
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
Date:   Wed, 10 Feb 2021 13:44:35 +0200
Message-ID: <20210210114435.122242-2-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210210114435.122242-1-tudor.ambarus@microchip.com>
References: <20210205222644.2357303-9-saravanak@google.com>
 <20210210114435.122242-1-tudor.ambarus@microchip.com>
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

