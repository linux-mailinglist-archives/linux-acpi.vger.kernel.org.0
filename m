Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0CEC389BA5
	for <lists+linux-acpi@lfdr.de>; Thu, 20 May 2021 05:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbhETDO2 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 19 May 2021 23:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbhETDO1 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 19 May 2021 23:14:27 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D682EC06175F
        for <linux-acpi@vger.kernel.org>; Wed, 19 May 2021 20:13:05 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id k15so10838801pgb.10
        for <linux-acpi@vger.kernel.org>; Wed, 19 May 2021 20:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l4FqofBPzTFOe/vcTYGIA+MZyZ9bPwJdmK6oj34OHvY=;
        b=jli7jfI0AJlTshbSyviLDRn8eRJ5kwjfDX466aMZkQYXgrxkVggU8ZZL02pHZp2EW/
         vY/8CEaS6Ih/oVyA/c8roajIzDn3kLdCk40Ij6RqM7KVf/qbVIajXcWtPY2Fzy3sDe+0
         2ZfYLE9cOHfC87W7b7W+z6bLl3IbA64J6VGKvlfBW/fgjxsWAVhiKGsENtLvKLP26oHr
         p1uSXeC+fBt+WZ3a9K0Mi4v4ojR91N/1Mo5NuVFktnU8SbHOsySpMROZY+PKvmxbqOGD
         /HwurTLmJ0i51XeYXhNVHIn9+3ceXdxoA5zsK8G1pdOONFIlTGagWvlJPwIUYmVWoBI2
         Rrww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l4FqofBPzTFOe/vcTYGIA+MZyZ9bPwJdmK6oj34OHvY=;
        b=Q9O7HksXS0usDHdCYOhr9il3KV6N5njLH5rOh4GxGQBevZrkSZu9dhoK6yHpnKAMT/
         ncDdwEYNZZ/nTeN2pW9B8LBCLMCseqp9gRRO+ZSe8XHe9UjJqyg2FWPqUiqPSkMyyy9j
         AWbzVYkYkUWhYFnwGgG9CS/W8Yl34EIvxe/rfNletaF8g6UEQLVemGS1qN36J+iH4Kes
         EddOFajSrZZcswIiwJbQiiIVmiqpPMGW6Vul10M6LpqZJVAaU0y71mcJtSdLPzJ7A6iS
         eJ2vbYsj2cmNi3UYjEas3lCU+ck8VAM4Qg6q0vmUvIJrQuusPED4A2F8GwcrXfLqkIGq
         3ygA==
X-Gm-Message-State: AOAM531EnfoazNunZbhXw8YVVqDHG1hXq/F/CojYb0egIFM/XuVLEnAR
        gxEnKMU+ogzgVhmiRghe1fVVaQ==
X-Google-Smtp-Source: ABdhPJyr1sX0c2X2ifVKz/ZDNjCI6RXE/3KawtLX70d4FW/4cQTnr9AZPl4cRVe9GFZsyMP15XCDTQ==
X-Received: by 2002:a05:6a00:1384:b029:2c7:fcda:8d83 with SMTP id t4-20020a056a001384b02902c7fcda8d83mr2339843pfg.0.1621480385263;
        Wed, 19 May 2021 20:13:05 -0700 (PDT)
Received: from starnight.localdomain (123-204-46-122.static.seed.net.tw. [123.204.46.122])
        by smtp.googlemail.com with ESMTPSA id hk15sm4741590pjb.53.2021.05.19.20.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 20:13:04 -0700 (PDT)
From:   Jian-Hong Pan <jhp@endlessos.org>
To:     "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@endlessos.org,
        Chris Chiu <chris.chiu@canonical.com>,
        Jian-Hong Pan <jhp@endlessos.org>
Subject: [PATCH v3] ACPI: EC: Make more Asus laptops use ECDT _GPE
Date:   Thu, 20 May 2021 11:09:50 +0800
Message-Id: <20210520030949.2471-1-jhp@endlessos.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <CABTNMG12HADeXoWe+25kYKQPcY8KV0GCDx+75GVAVATQ1pZYTA@mail.gmail.com>
References: <CABTNMG12HADeXoWe+25kYKQPcY8KV0GCDx+75GVAVATQ1pZYTA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Chris Chiu <chris.chiu@canonical.com>

More ASUS laptops have the _GPE define in the DSDT table with a
different value than the _GPE number in the ECDT.

This is causing media keys not working on ASUS X505BA/BP, X542BA/BP

Add model info to the quirks list.

Signed-off-by: Chris Chiu <chris.chiu@canonical.com>
Signed-off-by: Jian-Hong Pan <jhp@endlessos.org>
---
v2: Edit the author information with valid email address

v3: Edit Chris' S-o-b with current valid email address

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

