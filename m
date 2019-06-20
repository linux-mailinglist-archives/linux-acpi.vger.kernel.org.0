Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 513494C86F
	for <lists+linux-acpi@lfdr.de>; Thu, 20 Jun 2019 09:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725875AbfFTHeI (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 20 Jun 2019 03:34:08 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54770 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbfFTHeI (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 20 Jun 2019 03:34:08 -0400
Received: by mail-wm1-f68.google.com with SMTP id g135so1916069wme.4
        for <linux-acpi@vger.kernel.org>; Thu, 20 Jun 2019 00:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=4FqCiRm/R1y86qapH/9mGQH5c8EcuBpU48EvhhlV0Xo=;
        b=znxrnhE1zn6897NXu7Ylb/PPmBkD1bHTVNiahykJsigkiAXochglTrE8rTxzxCgMhZ
         VbTtDSBvvLdcwD73C7E71LtJf2AF3A4j+9VXt/49eQPd0os3vg9d6q8EQ1g5nR98KBq9
         NmK4FNti4NGbO+P6JCbZ+g9bRpl6IVBU0zYKbBp7Ovt/2JZo1NqWBK1nBWKvoPe+IBSX
         tnium+eClaXewTUoyeOxQ0Xyyfttx4wZIFChLJcZQXT3wjMu6pTQfGPD5rthYNNvZrtZ
         xmoqXJ142pr0tBe2RKZaxpLNxLK9ckmauyujjtjS/UqA71HJqY5H/dBGNd/dwlCZKxP4
         z5tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4FqCiRm/R1y86qapH/9mGQH5c8EcuBpU48EvhhlV0Xo=;
        b=tmGhGY1ik2zomRTYX3tj8tSKAVGSgeFPKbJ07AOtrMrzkqRIapuzXDk6YfLWCa9xie
         RUwxKDDQNeivI74is3PTY+deeiMk+Bb74S+TolC4mFQvwWClrhrC5rbZcJP4qjvWTs9/
         6vyXkHxdgXgPxq6rnxOa+u3gOOI4I9YBMvm4KK/BlfYdGYDevTloYc58Ru3KLzcZZBib
         VnBc3PZspbucEzh7coGqaqJDOShnYGkaxdWhyibAQvw41L40BMyLq/tp3UXrR1wuzB2S
         6pbxCa2MyGt3ieCfz9FiFBIvbxB4sS0SWzw8sPr2rcd7n3c10M8Nb1M/ANr4UhskN9oi
         6J2g==
X-Gm-Message-State: APjAAAVOMCH9nI/K1rtZP0ChgBe6KM9iv23kQei1xfoyEipB/CdLtzuf
        lfCDRTij2GdF7C6MLda25cSiohKqZIcgUg==
X-Google-Smtp-Source: APXvYqyhvbgPRSyh9mi2Cnbgo5E4w8ydYQCCsBmK+dsG2lpRj8XVop9CkYpBVmi9HZCZzGPoacM/0A==
X-Received: by 2002:a1c:3dc1:: with SMTP id k184mr1536273wma.88.1561016046015;
        Thu, 20 Jun 2019 00:34:06 -0700 (PDT)
Received: from e111045-lin.arm.com (lfbn-nic-1-216-10.w2-15.abo.wanadoo.fr. [2.15.62.10])
        by smtp.gmail.com with ESMTPSA id a7sm20023181wrs.94.2019.06.20.00.34.04
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 20 Jun 2019 00:34:05 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-acpi@vger.kernel.org
Cc:     lenb@kernel.org, rjw@rjwysocki.net, lee.jones@linaro.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH] acpi: make AC and battery drivers available on !X86
Date:   Thu, 20 Jun 2019 09:33:53 +0200
Message-Id: <20190620073353.5770-1-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

ACPI battery and AC devices can be found in arm64 laptops as well,
so drop the Kconfig dependency on X86 for their drivers.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 drivers/acpi/Kconfig | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index e016f7a6ed13..3c8011e7b0d7 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -155,7 +155,6 @@ config ACPI_EC_DEBUGFS
 
 config ACPI_AC
 	tristate "AC Adapter"
-	depends on X86
 	select POWER_SUPPLY
 	default y
 	help
@@ -168,7 +167,6 @@ config ACPI_AC
 
 config ACPI_BATTERY
 	tristate "Battery"
-	depends on X86
 	select POWER_SUPPLY
 	default y
 	help
-- 
2.17.1

