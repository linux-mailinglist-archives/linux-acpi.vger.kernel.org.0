Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B01031DC137
	for <lists+linux-acpi@lfdr.de>; Wed, 20 May 2020 23:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727909AbgETVTV (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 20 May 2020 17:19:21 -0400
Received: from mga17.intel.com ([192.55.52.151]:7202 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727083AbgETVTV (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 20 May 2020 17:19:21 -0400
IronPort-SDR: JMY2KxPrHelOdHjFKH09R6S03Oc44Oy4V6WnV4dyolD+/DzZLXmrap0vhwVxkbX5svTb93Zgfh
 79qp4Glj+qDg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2020 14:19:20 -0700
IronPort-SDR: b1zvrwV+JVBpTD1IzUBKm297bpY7NPFn9ws2U9MwPdsmirPn1aYYzVGQ+xaeWRa2V9Qw6w3U5O
 1po8kFLUmUBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,415,1583222400"; 
   d="scan'208";a="264823758"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 20 May 2020 14:19:18 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id D57E517E; Thu, 21 May 2020 00:19:17 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-gpio@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-acpi@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 3/5] gpio: pca953x: Drop unneeded ACPI_PTR()
Date:   Thu, 21 May 2020 00:19:14 +0300
Message-Id: <20200520211916.25727-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200520211916.25727-1-andriy.shevchenko@linux.intel.com>
References: <20200520211916.25727-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

ACPI_PTR() becomes a no-op when !CONFIG_ACPI. This is not needed since
we always have ID table enabled. Moreover, in the mentioned case compiler
will complain about defined but not used variable.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpio-pca953x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-pca953x.c b/drivers/gpio/gpio-pca953x.c
index 4bb3d3524bc7..1fca8dd7824f 100644
--- a/drivers/gpio/gpio-pca953x.c
+++ b/drivers/gpio/gpio-pca953x.c
@@ -1176,7 +1176,7 @@ static struct i2c_driver pca953x_driver = {
 		.name	= "pca953x",
 		.pm	= &pca953x_pm_ops,
 		.of_match_table = pca953x_dt_ids,
-		.acpi_match_table = ACPI_PTR(pca953x_acpi_ids),
+		.acpi_match_table = pca953x_acpi_ids,
 	},
 	.probe		= pca953x_probe,
 	.remove		= pca953x_remove,
-- 
2.26.2

