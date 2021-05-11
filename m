Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44EE2379FD4
	for <lists+linux-acpi@lfdr.de>; Tue, 11 May 2021 08:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbhEKGlt (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 11 May 2021 02:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230130AbhEKGlt (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 11 May 2021 02:41:49 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B8C6C061574
        for <linux-acpi@vger.kernel.org>; Mon, 10 May 2021 23:40:43 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id gq14-20020a17090b104eb029015be008ab0fso318674pjb.1
        for <linux-acpi@vger.kernel.org>; Mon, 10 May 2021 23:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HfebJNYv1F+pT/dPexAwWAT8H8fFsnP2pXkHvkLF40U=;
        b=XZB1cPruSntPTSrXajT7ZsLkeROzvfWw1d9BXny+hoOxlpkCLYN9s3nju3QIP0yfcG
         ccv5iPJpnnBp6lNz6PaI3j9BT9KleQmzzlTyJcF0kdeDQq4pLJ8Qiu/Aygih+fgX/oFF
         P+mAOzbk92/1M5p3V6J7rA1+DAsAph/usiI04lXyju8LS4/lGUr8O2uiK8JaUyh2Le58
         5tKMlzjv2PdDuhfCY8LskUFtSoc89EXSveFwQEdn9fzZ1Mp4oh11/yrW22C/baptsAQo
         15jRgVAQ1khyBqlelLZUy0JNCacc37XRdtGNuoxd6LddR22MasxqETxXDuCge3oq5onl
         QTWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HfebJNYv1F+pT/dPexAwWAT8H8fFsnP2pXkHvkLF40U=;
        b=CB/EhriZ3NVaoZtRmpzb/A59yNVLnjFmMOr1hdz90B+UexnKmjFKRo0rQTTb9G0ekJ
         +gfcvDIMeNLIfqelauPGBF6nyRV7UlajnWIqIbrcXsWk4Px3oHi+MyWBT2AKNLhIzUpn
         fST6NMtjIhOImfTlshF+L/sY5VxrD54FBtbQCVBDAqZXqNDlkboSuYge3lKp7wO/K85I
         bAj+/M70FP4SoGegtChU2gJ11H2Qn9MX7xcTYc9u6imfNfr0EPNWbu7uN21kAzfdriyk
         3/z4CmG+E02EH4vJtTq4+GMKIGvlhVYRgUQslrDrANX3vvUTHYvL03gkgTuwgRrPfSxu
         lQkQ==
X-Gm-Message-State: AOAM532ccek84sHbuCqlhg1LbXHGBpz138XQlM+da1rGAyDvXvA+sv3E
        ByzyTYbQat9kjl4HL1GVAKR5tQ==
X-Google-Smtp-Source: ABdhPJwjLbxLYzLJfiWZJfh7yiwxI4k6XUi1go0SRbdpdFFWQZBVv0TipbM+4YVxo7y4RE19aJEPDw==
X-Received: by 2002:a17:90a:7a89:: with SMTP id q9mr3434430pjf.0.1620715242811;
        Mon, 10 May 2021 23:40:42 -0700 (PDT)
Received: from starnight.localdomain (123-204-46-122.static.seed.net.tw. [123.204.46.122])
        by smtp.googlemail.com with ESMTPSA id s184sm13059251pgc.29.2021.05.10.23.40.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 23:40:42 -0700 (PDT)
From:   Jian-Hong Pan <jhp@endlessos.org>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Cc:     Chris Chiu <chris.chiu@canonical.com>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@endlessos.org,
        Chris Chiu <chiu@endlessm.com>,
        Jian-Hong Pan <jhp@endlessos.org>
Subject: [PATCH] ACPI / EC: Fix media keys not working problem on more Asus laptops
Date:   Tue, 11 May 2021 14:38:36 +0800
Message-Id: <20210511063835.7794-1-jhp@endlessos.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Chris Chiu <chiu@endlessm.com>

More ASUS laptops have the _GPE define in the DSDT table with a
different value than the _GPE number in the ECDT.

This is causing media keys not working on ASUS X505BA/BP, X542BA/BP

Add model info to the quirks list.

Signed-off-by: Chris Chiu <chiu@endlessm.com>
Signed-off-by: Jian-Hong Pan <jhp@endlessos.org>
---
 drivers/acpi/ec.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 13565629ce0a..e8c5da2b964a 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -1846,6 +1846,22 @@ static const struct dmi_system_id ec_dmi_table[] __initconst = {
 	DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
 	DMI_MATCH(DMI_PRODUCT_NAME, "GL702VMK"),}, NULL},
 	{
+	ec_honor_ecdt_gpe, "ASUSTeK COMPUTER INC. X505BA", {
+	DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+	DMI_MATCH(DMI_PRODUCT_NAME, "X505BA"),}, NULL},
+	{
+	ec_honor_ecdt_gpe, "ASUSTeK COMPUTER INC. X505BP", {
+	DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+	DMI_MATCH(DMI_PRODUCT_NAME, "X505BP"),}, NULL},
+	{
+	ec_honor_ecdt_gpe, "ASUSTeK COMPUTER INC. X542BA", {
+	DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+	DMI_MATCH(DMI_PRODUCT_NAME, "X542BA"),}, NULL},
+	{
+	ec_honor_ecdt_gpe, "ASUSTeK COMPUTER INC. X542BP", {
+	DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+	DMI_MATCH(DMI_PRODUCT_NAME, "X542BP"),}, NULL},
+	{
 	ec_honor_ecdt_gpe, "ASUS X550VXK", {
 	DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
 	DMI_MATCH(DMI_PRODUCT_NAME, "X550VXK"),}, NULL},
-- 
2.31.1

