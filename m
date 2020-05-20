Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2FE11DC13B
	for <lists+linux-acpi@lfdr.de>; Wed, 20 May 2020 23:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727897AbgETVTW (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 20 May 2020 17:19:22 -0400
Received: from mga03.intel.com ([134.134.136.65]:48520 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727083AbgETVTV (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 20 May 2020 17:19:21 -0400
IronPort-SDR: h0GKZKT3q3PUDuJwMn7/RK/Y1LupwB7ePn5vZcHNF3I8knlr8OeleK0EaceDKX3FRMBU6NQ8tf
 qTdX3yPZ6okw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2020 14:19:20 -0700
IronPort-SDR: wVimzsYJ+INLkSeU7CbcyCsyC+IHEyTQxED0fx8aunrGyE6+5IHbY2P32zWVvw+xzAQcv7G/0d
 m5Hd6rhf27xw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,415,1583222400"; 
   d="scan'208";a="268400199"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 20 May 2020 14:19:18 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id DA79F14E; Thu, 21 May 2020 00:19:17 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-gpio@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-acpi@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 4/5] gpio: pca935x: Allow IRQ support for driver built as a module
Date:   Thu, 21 May 2020 00:19:15 +0300
Message-Id: <20200520211916.25727-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200520211916.25727-1-andriy.shevchenko@linux.intel.com>
References: <20200520211916.25727-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Perhaps by some historical reasons the IRQ support has been allowed
only for built-in driver. However, there is nothing prevents us
to build it as module an use as IRQ chip.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 03c01f4aa316..eff454eed9a7 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -952,7 +952,7 @@ config GPIO_PCA953X
 
 config GPIO_PCA953X_IRQ
 	bool "Interrupt controller support for PCA953x"
-	depends on GPIO_PCA953X=y
+	depends on GPIO_PCA953X
 	select GPIOLIB_IRQCHIP
 	help
 	  Say yes here to enable the pca953x to be used as an interrupt
-- 
2.26.2

