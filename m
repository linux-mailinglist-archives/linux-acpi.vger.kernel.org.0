Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7ADF4B59B
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Jun 2019 11:53:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbfFSJxb (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 19 Jun 2019 05:53:31 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41845 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727002AbfFSJxb (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 19 Jun 2019 05:53:31 -0400
Received: by mail-wr1-f65.google.com with SMTP id c2so2639935wrm.8
        for <linux-acpi@vger.kernel.org>; Wed, 19 Jun 2019 02:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=chQPrFFBsSaN5Zy70hzC849/NN1iqycFvOtokhwycjY=;
        b=Rtr/JMKAL2PriusG0MZ4goS/8DrMhKNZlbzm6V3Jm48Yml7XPqhP1zeAjd0usen83e
         7KW2FCkWHyxrbKO/nyBoeAe2bq+6yvdZmqdTpGMN+YiKq6TfqFNpH3nWGD19T9CBhfcs
         cVuGLemtwOUA86X4PZhVa8O35exsv93OXCyOlr7Nkr39PtB43r/icxxD5i3HW0ILnCMg
         QgRNaS4sUVAT9P9MiytmoTtOK4dM7oFyk8ujbQ42NweMUOmyiNbIkIKjkkNlw1uY3vCn
         kANpyDMSb8xAE7d+u8E/YCKbkWdcMf91oNYeVfdvZQbuDAi9Z+xHQ0wezCgkXgtBNCmJ
         EDLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=chQPrFFBsSaN5Zy70hzC849/NN1iqycFvOtokhwycjY=;
        b=WkPMannqPuLFz61Nw0Xb5AJiyi4UlZMfHjZoD6b909U372yWc3Rd8XM2XYljz0pC9q
         dXhVdseowiiH4JFY962u7e875Vuh3DexImkGku5riAiAVT3d0ahQ4FMHBraxCfaBNCuY
         2vH9sPfF9Igub5SLdtT+nfWLgu4FzTXsfziWo5Y2UY/Fh0kqpKdiDRnwDUbNDoVgOOi3
         bGPsAOiyNl2bBN54PAidLSZaQ5KtWLXXgiumgye67/Z+u9Fu0HhWgQNSECaXXiakkjrU
         84m3KN148WmJtBIsf+isBmWMNgqkOkM9CEIbEmcPvkOTwxH1SDAd3oNdTyTQVdl6YEbx
         L44w==
X-Gm-Message-State: APjAAAVpa6qQkSpi42GVvsq/PBbbvlEwYzRrd1K1O1gjR5DPQiKOITWe
        EnGDmsuvAMrgUgvdL7glOjEYKw==
X-Google-Smtp-Source: APXvYqyhWECSNpWnjcYlUH2TFCJqqtFVdgjFX4hBJ5vwQ/M0l9PG7qsLV5R8TwGb4i9xzOkKoVWLsg==
X-Received: by 2002:a5d:6949:: with SMTP id r9mr68679902wrw.73.1560938009014;
        Wed, 19 Jun 2019 02:53:29 -0700 (PDT)
Received: from sudo.home ([2a01:cb1d:112:6f00:21a3:60fe:6e8e:8104])
        by smtp.gmail.com with ESMTPSA id l4sm674706wmh.18.2019.06.19.02.53.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Jun 2019 02:53:28 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-spi@vger.kernel.org
Cc:     broonie@kernel.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        kbuild test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        andy.shevchenko@gmail.com, masahisa.kojima@linaro.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        linux-acpi@vger.kernel.org, Lukas Wunner <lukas@wunner.de>
Subject: [PATCH] spi/acpi: fix incorrect ACPI parent check
Date:   Wed, 19 Jun 2019 11:52:54 +0200
Message-Id: <20190619095254.19559-1-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The ACPI device object parsing code for SPI slaves enumerates the
entire ACPI namespace to look for devices that refer to the master
in question via the 'resource_source' field in the 'SPISerialBus'
resource. If that field does not refer to a valid ACPI device or
if it refers to the wrong SPI master, we should disregard the
device.

Current, the valid device check is wrong, since it gets the
polarity of 'status' wrong. This could cause issues if the
'resource_source' field is bogus but parent_handle happens to
refer to the correct master (which is not entirely imaginary
since this code runs in a loop)

So test for ACPI_FAILURE() instead, to make the code more
self explanatory.

Fixes: 4c3c59544f33 ("spi/acpi: enumerate all SPI slaves in the namespace")
Reported-by: kbuild test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: andy.shevchenko@gmail.com
Cc: masahisa.kojima@linaro.org
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: linux-acpi@vger.kernel.org
Cc: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 drivers/spi/spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index c8adcc97f3ef..50d230b33c42 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1859,7 +1859,7 @@ static int acpi_spi_add_resource(struct acpi_resource *ares, void *data)
 						 sb->resource_source.string_ptr,
 						 &parent_handle);
 
-			if (!status ||
+			if (ACPI_FAILURE(status) ||
 			    ACPI_HANDLE(ctlr->dev.parent) != parent_handle)
 				return -ENODEV;
 
-- 
2.20.1

