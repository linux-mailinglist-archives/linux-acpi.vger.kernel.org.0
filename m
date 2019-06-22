Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43A524F28C
	for <lists+linux-acpi@lfdr.de>; Sat, 22 Jun 2019 02:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726188AbfFVAGd (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 21 Jun 2019 20:06:33 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:43751 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726749AbfFVAEi (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 21 Jun 2019 20:04:38 -0400
Received: by mail-pf1-f202.google.com with SMTP id j7so5316821pfn.10
        for <linux-acpi@vger.kernel.org>; Fri, 21 Jun 2019 17:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=zyyz4Cz4gGHUXuxtWW1WrDh1XJA1NU8T7MmFpiT0rrE=;
        b=YIv34y8sbA5lbQnK/eli+pwNC0VaL5Zccqe5P08QByeHBjnT4ZCaFF6VNL0237nXRe
         Y82y2K6IWweiDfz+suVmozJiIJZ4FiWrNiF+czLcZ885+84IldvjGYnCqd6cBVGOB6X2
         LIB2ZUGsmvExhTJU+g5rsLSfPaB38pUV78wxFfZqkdvu5Ty0dz1z8kt1VvYSbRJXtjNZ
         PLQq1u/pklNhYtpNo+/JudN2J6hh+ZEnvhrWfXMwYC7LO2f/KTEcHLdaZib/MbY/cT6M
         aVlj+/7Xd3xzeZffz22TPbGJZPZ1gHSJhdPrgKyRQrQrSPgPzbAC5RkBFZ9Hz3KfX+B5
         eKNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=zyyz4Cz4gGHUXuxtWW1WrDh1XJA1NU8T7MmFpiT0rrE=;
        b=cQtcFMr+ryBYQ21JlM7V2U3INz5gFqnW/j6mnv81zFwVEdshnLl826lL/H8R+JhT40
         wgNxkvWqOG7JdmS9SYl8qgEOJEZo0qdCv1848JumrgTej4lURAHpu9Z/i9370fLbOruk
         W0DGTWfxucWWxyol3CSQvpYA1jHyKUoDC2Et8c94yEoOejB1Fw5f6eIeEJupjO9LYCRe
         sFWY8RsHbo9VbiK1kRcWD1SHdD30D45YeJ9Kp+hNNQ/QLe7WqzfHQByzvB6qAVTPhOVb
         prf0KRfAB0Smkr1dwExy2CFv9b50gDSSsj3UBDKHfkW5ezZJ+ipgoophShXrht5KM0FX
         9YDQ==
X-Gm-Message-State: APjAAAXAcfY2bKDyvnJiTECvgqZcwRxJP8PxlqxGu0PCzjbIE5cvIfIX
        x7/KwD6iwHWAG/go6RlrZYwgEEPb9vQL+qdjj6F20w==
X-Google-Smtp-Source: APXvYqxrieaEV4JvvipGtYx+FVX4wzWJu+9dkQO98TgTYS8DbVQaONy7gFhmlvKZ4R1EVRlKzulPfnPIGtj1Uc2BV2hMgw==
X-Received: by 2002:a63:f817:: with SMTP id n23mr21183139pgh.35.1561161877500;
 Fri, 21 Jun 2019 17:04:37 -0700 (PDT)
Date:   Fri, 21 Jun 2019 17:03:43 -0700
In-Reply-To: <20190622000358.19895-1-matthewgarrett@google.com>
Message-Id: <20190622000358.19895-15-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190622000358.19895-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH V34 14/29] ACPI: Limit access to custom_method when the kernel
 is locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Matthew Garrett <mjg59@google.com>,
        David Howells <dhowells@redhat.com>, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Matthew Garrett <mjg59@srcf.ucam.org>

custom_method effectively allows arbitrary access to system memory, making
it possible for an attacker to circumvent restrictions on module loading.
Disable it if the kernel is locked down.

Signed-off-by: Matthew Garrett <mjg59@google.com>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-acpi@vger.kernel.org
---
 drivers/acpi/custom_method.c | 6 ++++++
 include/linux/security.h     | 1 +
 security/lockdown/lockdown.c | 1 +
 3 files changed, 8 insertions(+)

diff --git a/drivers/acpi/custom_method.c b/drivers/acpi/custom_method.c
index aa972dc5cb7e..6e56f9f43492 100644
--- a/drivers/acpi/custom_method.c
+++ b/drivers/acpi/custom_method.c
@@ -8,6 +8,7 @@
 #include <linux/uaccess.h>
 #include <linux/debugfs.h>
 #include <linux/acpi.h>
+#include <linux/security.h>
 
 #include "internal.h"
 
@@ -28,6 +29,11 @@ static ssize_t cm_write(struct file *file, const char __user * user_buf,
 
 	struct acpi_table_header table;
 	acpi_status status;
+	int ret;
+
+	ret = security_locked_down(LOCKDOWN_ACPI_TABLES);
+	if (ret)
+		return ret;
 
 	if (!(*ppos)) {
 		/* parse the table header to get the table length */
diff --git a/include/linux/security.h b/include/linux/security.h
index 30bc6f058926..cc2b5ee4cadd 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -89,6 +89,7 @@ enum lockdown_reason {
 	LOCKDOWN_PCI_ACCESS,
 	LOCKDOWN_IOPORT,
 	LOCKDOWN_MSR,
+	LOCKDOWN_ACPI_TABLES,
 	LOCKDOWN_INTEGRITY_MAX,
 	LOCKDOWN_CONFIDENTIALITY_MAX,
 };
diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
index 297a065e6261..1725224f0024 100644
--- a/security/lockdown/lockdown.c
+++ b/security/lockdown/lockdown.c
@@ -25,6 +25,7 @@ static char *lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1] = {
 	[LOCKDOWN_PCI_ACCESS] = "direct PCI access",
 	[LOCKDOWN_IOPORT] = "raw io port access",
 	[LOCKDOWN_MSR] = "raw MSR access",
+	[LOCKDOWN_ACPI_TABLES] = "modified ACPI tables",
 	[LOCKDOWN_INTEGRITY_MAX] = "integrity",
 	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
 };
-- 
2.22.0.410.gd8fdbe21b5-goog

