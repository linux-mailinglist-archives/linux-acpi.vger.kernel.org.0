Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C81C22E6FEA
	for <lists+linux-acpi@lfdr.de>; Tue, 29 Dec 2020 12:20:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726412AbgL2LSp (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 29 Dec 2020 06:18:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbgL2LSo (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 29 Dec 2020 06:18:44 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7595CC0613D6;
        Tue, 29 Dec 2020 03:18:04 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id r7so14337564wrc.5;
        Tue, 29 Dec 2020 03:18:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lKImzdzCVGUFzldrnv3fKP8xmN5nYfEvPJ2R5lNtMwk=;
        b=UmiPWCPLjX3o2kb/y5EwBplCMV2icP5bnaXlUbP69U8OdFbr/DqncficWkT8HXmEKo
         58FrycQ3QA6dgeEIUHNRCUwyhpiS+j0xP1O8HWSaUFbm+IhDoWn/ou+JmBXcZJJAl9fp
         wwIAWDaLVZoM2Zaby2mC06If4cVMm1xQULGdjtoRD6pJdC6v2CrJcMxqFnK7o8tHnuIJ
         jGbrYlH8teN+vZjxd+O5JIQYx3gRty5oQca+NEOf/KfHVB+aJFMXrgNX8KZTRCkrPLtV
         CQh0L5GYIKwJ1q5nBOa145jHDDmkaamrNxnf6MeGMCHZ7qLfyx+2WCX9JUpv3sAtDEcv
         l1Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lKImzdzCVGUFzldrnv3fKP8xmN5nYfEvPJ2R5lNtMwk=;
        b=ZzGBajfN9/zcfyJwzT7Wr8MCdhAKxWLW7PEuL88L7rcsjF+3SmY+Xt/ynixE362OvH
         ktCxbfH+lmzn3+XQIHLLcTbDIH5AoIF2Ar8HsyrRbXOWCIM7HXTnNlRSrmLypXVXK9Az
         Pp8yKw+GRmhZlKmjBUMsZuF3E4NPoBRDPGSkS5KAlnFeXnFEVZU3qQYoB8O+Pk1+vmi0
         /plp0/qO5VNXQILuSdHJ5cRIJNOmFizA0OCq/bVKuUpbfUXh5zmOjZlRQACV4ZppT3fd
         5d76LTdw/KH6bvKm1kktgOi1B49WDbbyzMJ5/cgw52qdu+IF/Pfqk6s7mZ6O07BiyOEA
         gihg==
X-Gm-Message-State: AOAM532Dss1u9IwcpwdEzt0tJrvGl+7SP+liGoyWULLyO5QeeAPq7op/
        x0THVdC7VYztn3btfZ7RAQnTqYJaIFU=
X-Google-Smtp-Source: ABdhPJzoXq4QlPD0RSNKGk/+UHRAQFSI4AJkppMz6y4talkjQl42f+Z/LCrho4/L2YvRETg9zmFCgg==
X-Received: by 2002:a5d:4c49:: with SMTP id n9mr56247904wrt.30.1609240683132;
        Tue, 29 Dec 2020 03:18:03 -0800 (PST)
Received: from morpheus.home.roving-it.com (f.c.9.1.f.e.c.d.1.e.0.0.2.b.5.5.1.8.6.2.1.1.b.f.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:fb11:2681:55b2:e1:dcef:19cf])
        by smtp.googlemail.com with ESMTPSA id l5sm60194997wrv.44.2020.12.29.03.18.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Dec 2020 03:18:02 -0800 (PST)
From:   Peter Robinson <pbrobinson@gmail.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH] ACPI: Update Kconfig help text for items that are no longer modular
Date:   Tue, 29 Dec 2020 11:17:59 +0000
Message-Id: <20201229111759.1207387-1-pbrobinson@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The CONTAINER and HOTPLUG_MEMORY memory options mention modules
but are bool only options so if selected are alway built in. Drop
the help text about modules.

Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
---
 drivers/acpi/Kconfig | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index edf1558c1105..ebcf534514be 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -395,9 +395,6 @@ config ACPI_CONTAINER
 
 	  This helps support hotplug of nodes, CPUs, and memory.
 
-	  To compile this driver as a module, choose M here:
-	  the module will be called container.
-
 config ACPI_HOTPLUG_MEMORY
 	bool "Memory Hotplug"
 	depends on MEMORY_HOTPLUG
@@ -411,9 +408,6 @@ config ACPI_HOTPLUG_MEMORY
 	  removing memory devices at runtime, you need not enable
 	  this driver.
 
-	  To compile this driver as a module, choose M here:
-	  the module will be called acpi_memhotplug.
-
 config ACPI_HOTPLUG_IOAPIC
 	bool
 	depends on PCI
-- 
2.29.2

