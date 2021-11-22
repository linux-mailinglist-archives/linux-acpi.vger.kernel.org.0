Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 204884593AD
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Nov 2021 18:06:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238530AbhKVRJQ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 22 Nov 2021 12:09:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36002 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238230AbhKVRJN (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 22 Nov 2021 12:09:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637600766;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vnr5tG0rUVEEWNx4SJPka9TwAEv+9j7ye3+GCaD7zSM=;
        b=UQQG5KdGZUSqKyHTibOI/xhHdqAP//0kjY2U79EqOLQCTl+lDPjMqmBs5LY3BqDG9NMQd8
        oReXsKh4jyOl+CWJaxkXPDgKmBiYWGrIY+YR0ILoTyLvnVMTsQYM6Aoqayk55Kp06v/9S8
        IFoESz2eI39x1VsZuukL/FlJj94C6pA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-583-CZ9U9YGYMGGXPyI2XwHwqA-1; Mon, 22 Nov 2021 12:06:02 -0500
X-MC-Unique: CZ9U9YGYMGGXPyI2XwHwqA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6BC1710168C0;
        Mon, 22 Nov 2021 17:06:01 +0000 (UTC)
Received: from x1.localdomain (unknown [10.39.192.226])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 02BCC5D6D5;
        Mon, 22 Nov 2021 17:05:59 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org, linux-mmc@vger.kernel.org
Subject: [PATCH v2 7/7] mmc: sdhci-acpi: Use the new soc_intel_is_byt() helper
Date:   Mon, 22 Nov 2021 18:05:36 +0100
Message-Id: <20211122170536.7725-8-hdegoede@redhat.com>
In-Reply-To: <20211122170536.7725-1-hdegoede@redhat.com>
References: <20211122170536.7725-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Use the new soc_intel_is_byt() helper function from
include/linux/platform_data/x86/soc.h .

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
- No changes in v2 of this patch-series
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
2.33.1

