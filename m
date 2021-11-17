Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EEB8455017
	for <lists+linux-acpi@lfdr.de>; Wed, 17 Nov 2021 23:01:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240763AbhKQWEw (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 17 Nov 2021 17:04:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55958 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240904AbhKQWEk (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 17 Nov 2021 17:04:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637186500;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gzRqfi9r2d6jzALCSB0C8plEtz9PToXoYBaSZUOHj50=;
        b=JyiPpkl4YX6YYEbzRroF6IKmkBZjGxqgzpw6cfRf5vbePI8fqBqqlsrVE5SQr6zXYCPZp9
        wwPPVEYQOy2IET1ksYPpddXSI82105K16TS/Vy0a9cUucbLtl07qnYBv5EBEU9FjpkV7K4
        dBLW3jGLThgdGmrUtTdsP5gNFsckn0E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-557-hxFbEqMrPGWZPAMQ7FAlBQ-1; Wed, 17 Nov 2021 17:01:37 -0500
X-MC-Unique: hxFbEqMrPGWZPAMQ7FAlBQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 43F4C15720;
        Wed, 17 Nov 2021 22:01:36 +0000 (UTC)
Received: from x1.localdomain.com (unknown [10.39.192.15])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C875F5D9DE;
        Wed, 17 Nov 2021 22:01:34 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org, linux-mmc@vger.kernel.org
Subject: [PATCH 5/5] mmc: sdhci-acpi: Use the new soc_intel_is_byt() helper
Date:   Wed, 17 Nov 2021 23:01:18 +0100
Message-Id: <20211117220118.408953-6-hdegoede@redhat.com>
In-Reply-To: <20211117220118.408953-1-hdegoede@redhat.com>
References: <20211117220118.408953-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Use the new soc_intel_is_byt() helper function from
include/linux/platform_data/x86/soc.h .

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/mmc/host/sdhci-acpi.c | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
index 1461aae13c19..c0350e9c03f3 100644
--- a/drivers/mmc/host/sdhci-acpi.c
+++ b/drivers/mmc/host/sdhci-acpi.c
@@ -31,8 +31,7 @@
 #include <linux/mmc/slot-gpio.h>
 
 #ifdef CONFIG_X86
-#include <asm/cpu_device_id.h>
-#include <asm/intel-family.h>
+#include <linux/platform_data/x86/soc.h>
 #include <asm/iosf_mbi.h>
 #endif
 
@@ -239,16 +238,6 @@ static const struct sdhci_acpi_chip sdhci_acpi_chip_int = {
 
 #ifdef CONFIG_X86
 
-static bool sdhci_acpi_byt(void)
-{
-	static const struct x86_cpu_id byt[] = {
-		X86_MATCH_INTEL_FAM6_MODEL(ATOM_SILVERMONT, NULL),
-		{}
-	};
-
-	return x86_match_cpu(byt);
-}
-
 #define BYT_IOSF_SCCEP			0x63
 #define BYT_IOSF_OCP_NETCTRL0		0x1078
 #define BYT_IOSF_OCP_TIMEOUT_BASE	GENMASK(10, 8)
@@ -257,7 +246,7 @@ static void sdhci_acpi_byt_setting(struct device *dev)
 {
 	u32 val = 0;
 
-	if (!sdhci_acpi_byt())
+	if (!soc_intel_is_byt())
 		return;
 
 	if (iosf_mbi_read(BYT_IOSF_SCCEP, MBI_CR_READ, BYT_IOSF_OCP_NETCTRL0,
@@ -282,7 +271,7 @@ static void sdhci_acpi_byt_setting(struct device *dev)
 
 static bool sdhci_acpi_byt_defer(struct device *dev)
 {
-	if (!sdhci_acpi_byt())
+	if (!soc_intel_is_byt())
 		return false;
 
 	if (!iosf_mbi_available())
-- 
2.31.1

