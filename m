Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43DDE388521
	for <lists+linux-acpi@lfdr.de>; Wed, 19 May 2021 05:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237753AbhESDNI (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 18 May 2021 23:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237719AbhESDNI (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 18 May 2021 23:13:08 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46247C06175F
        for <linux-acpi@vger.kernel.org>; Tue, 18 May 2021 20:11:49 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d16so8882366pfn.12
        for <linux-acpi@vger.kernel.org>; Tue, 18 May 2021 20:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7K64pRj8ZX1/Io9KSFtbDGYG+Ub4qBkvcfx5Mnlfq8o=;
        b=lK5SztMqVOowpYqMlYj54+++wA5kjcYGPDMeqtSJgPg7WX3uzxVwsvAHxPsKQxTY6z
         XEtwe34Ug3Skmz10H7IhGtx3zCdUsGwqAjyIW9v4Zp2QaDIr3RYUqEAvPgmczyLb8lXD
         qzQA7B7GBb/h2ExjIPV7KqjVhiPO5KMr7mowI6dnrLrP0+yTjs97SlHCPAc185AistZJ
         eidFCoTJfQmd8uEgPNRlXO3+uzaMGEydfVNrSWt4USeYQM+bXNNrMgMY4EdiHBO3OMK2
         3V6G4waxl+Er35hoTpBJqTJEYVl3UmddRpGf+4ELcM9Al3hlFE3+YJOZ4e6CsKXw181q
         BBWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7K64pRj8ZX1/Io9KSFtbDGYG+Ub4qBkvcfx5Mnlfq8o=;
        b=SbOM/GEGvSLHgH2i99y33qfmni2r81LPHGo+sWlEr/CWldqUmZTauZQInOfvoCLsRT
         w7XWIjzL1Nu3JytpBkT18rAMs92ec7qPG1zcKOp6VoQYJgxPTJJ5t4e/1I+aypubQUxV
         UMkgayJtYwwoJ9n9yVfL/w+QbQv3euT3UVbgJekbw1o6b8zWaj7MbpABGs8yj0obpQmV
         eyeivypa8BXyUrawEVGXPdMjk/sWMwu7RVsiofWRKVxz0JfyvtdKL7TgFtXAv2oN364E
         kWKXQqUVyMsNM8VaJFNNwv1LxbGk80Wn3Ve6e4jt6DLdUBLPfqSFPXD+a9id8beJTbFk
         YH7g==
X-Gm-Message-State: AOAM533iR1HFvqHd5ipV9o1wurf4Kme08ghcTt6cJEyF+p54DxH9XN94
        3aOpSDEw3MXHl1WiBOjdhDakbA==
X-Google-Smtp-Source: ABdhPJwKOzSmk8vB8qmgE1rMmGXqfMfPmCGUuhvd9ch5cfsIZqWEAEL7xgKu7E9zVCmkJTbY1KPj5g==
X-Received: by 2002:a62:a517:0:b029:2dc:9daf:5e91 with SMTP id v23-20020a62a5170000b02902dc9daf5e91mr8457957pfm.39.1621393908595;
        Tue, 18 May 2021 20:11:48 -0700 (PDT)
Received: from starnight.localdomain (123-204-46-122.static.seed.net.tw. [123.204.46.122])
        by smtp.googlemail.com with ESMTPSA id np1sm2898662pjb.13.2021.05.18.20.11.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 20:11:48 -0700 (PDT)
From:   Jian-Hong Pan <jhp@endlessos.org>
To:     "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@endlessos.org,
        Chris Chiu <chris.chiu@canonical.com>,
        Chris Chiu <chiu@endlessm.com>,
        Jian-Hong Pan <jhp@endlessos.org>
Subject: [PATCH v2] ACPI: EC: Make more Asus laptops use ECDT _GPE
Date:   Wed, 19 May 2021 11:06:56 +0800
Message-Id: <20210519030655.2197-1-jhp@endlessos.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <CAJZ5v0iU15F42yGm5etxmMLsDwC=u7p1eT6EoVADnJnV8+S4VA@mail.gmail.com>
References: <CAJZ5v0iU15F42yGm5etxmMLsDwC=u7p1eT6EoVADnJnV8+S4VA@mail.gmail.com>
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

Signed-off-by: Chris Chiu <chiu@endlessm.com>
Signed-off-by: Jian-Hong Pan <jhp@endlessos.org>
---
v2: Edit the author information with valid email address

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

