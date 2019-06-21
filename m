Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 894284DEA7
	for <lists+linux-acpi@lfdr.de>; Fri, 21 Jun 2019 03:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbfFUBV5 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 20 Jun 2019 21:21:57 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:51454 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726688AbfFUBU2 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 20 Jun 2019 21:20:28 -0400
Received: by mail-pl1-f202.google.com with SMTP id d2so2651885pla.18
        for <linux-acpi@vger.kernel.org>; Thu, 20 Jun 2019 18:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=iJrEpiYEEq/u9uVQ7rtK8OnmsmoBNHfJU3q0QdD2/5Y=;
        b=F9ZPwUtUQbrjYEXZQyys0W0e+13BLgRaMQSW6Q81kqXAQet8b/73xFPivmrD1M/C2I
         9M1sv4e8uEkc/EvXNP5EiV4mjSNxEK0hC4EXMQ6YfQRkihmViiE508BR39E3lV8smyu8
         AvFNJ/jgB3m0BM53WQxjvDN5I0mkE2Daka0tGee+3XchZBmYPEDZ7vTc8z7pvxFIAskv
         Pv6AehRkSqxKGjcOr5kPpDp635xUFWQOKqbJgtWNl2xALyeXTEgmtwewwTJJN5CttJ24
         qmCHjQIU8yJjzuyjGRCzVL+wbvFIblHROGH9FBKyv4j09Gi9B+F7ZD4gqHXvm3zU68BL
         hkQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=iJrEpiYEEq/u9uVQ7rtK8OnmsmoBNHfJU3q0QdD2/5Y=;
        b=a1gd406iCeNWO4+6phU1e4Th6Hv2bNbU4kPYK+m8crjjB8IaOt32Y5klwgn50ozXl3
         /3pKuXxNaL8a+IP7K+DFGwePrRoC2sfE1zL1oaj5IIGTbZYjanocG5jrCUGtTfyzZSNl
         OJGBLFp9Nc74gB5Xn2SWSPZzvBjdX5UAmFwYnLEmsNRJOIiD6+fRey49SSVm9oe5VXGG
         5AyNeC9lDcIS6vXzvrNaCA/pr/wSuXUDT2WhZGmG16Rh62qaGGS9yjgTjHvZajkW0inJ
         3HpbbY7d91KyVYLaQHEtF7Bcw88q15EHy3YNV9qO8jSsWxNt/I3wsMFS87Snng2sP4fn
         zvkA==
X-Gm-Message-State: APjAAAUoG/hf889uBtrULH9MuBXgqW9zDPyihx5cPv2eCYr0p6SPnw65
        xARaRa6Pfi1xgYwAdxZr6dCEUbyj19h2tJM9NUSAjw==
X-Google-Smtp-Source: APXvYqwY3NxahetSXDYqQ9ndXRHa9UacYcJUwFfE58pwvnctD/tPrLKsdvpeA4hn6iytxyEZ2DJWm7PHUyN5yS+aMVkdxw==
X-Received: by 2002:a63:5207:: with SMTP id g7mr10342146pgb.284.1561080027898;
 Thu, 20 Jun 2019 18:20:27 -0700 (PDT)
Date:   Thu, 20 Jun 2019 18:19:27 -0700
In-Reply-To: <20190621011941.186255-1-matthewgarrett@google.com>
Message-Id: <20190621011941.186255-17-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190621011941.186255-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH V33 16/30] acpi: Ignore acpi_rsdp kernel param when the kernel
 has been locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, Josh Boyer <jwboyer@redhat.com>,
        David Howells <dhowells@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        Dave Young <dyoung@redhat.com>, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Josh Boyer <jwboyer@redhat.com>

This option allows userspace to pass the RSDP address to the kernel, which
makes it possible for a user to modify the workings of hardware .  Reject
the option when the kernel is locked down.

Signed-off-by: Josh Boyer <jwboyer@redhat.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Matthew Garrett <mjg59@google.com>
cc: Dave Young <dyoung@redhat.com>
cc: linux-acpi@vger.kernel.org
---
 drivers/acpi/osl.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index f29e427d0d1d..1f8f394fce34 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -40,6 +40,7 @@
 #include <linux/list.h>
 #include <linux/jiffies.h>
 #include <linux/semaphore.h>
+#include <linux/security.h>
 
 #include <asm/io.h>
 #include <linux/uaccess.h>
@@ -194,7 +195,7 @@ acpi_physical_address __init acpi_os_get_root_pointer(void)
 	acpi_physical_address pa;
 
 #ifdef CONFIG_KEXEC
-	if (acpi_rsdp)
+	if (acpi_rsdp && !security_is_locked_down(LOCKDOWN_ACPI_TABLES))
 		return acpi_rsdp;
 #endif
 	pa = acpi_arch_get_root_pointer();
-- 
2.22.0.410.gd8fdbe21b5-goog

