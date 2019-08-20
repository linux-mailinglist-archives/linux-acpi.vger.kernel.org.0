Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CFF9A9529F
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Aug 2019 02:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728946AbfHTAUH (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 19 Aug 2019 20:20:07 -0400
Received: from mail-qk1-f201.google.com ([209.85.222.201]:48945 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729045AbfHTASr (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 19 Aug 2019 20:18:47 -0400
Received: by mail-qk1-f201.google.com with SMTP id k5so5219016qke.15
        for <linux-acpi@vger.kernel.org>; Mon, 19 Aug 2019 17:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=cqqNQcjxZKCBbJrhwZmXlaL29Q1qsVjTwEkp4+lUxdU=;
        b=BO4kQ0935/Y6yDgFnhcP8U6VvEnTvdTFa/3/fszoNSnRJF6dFBqhAjx6db960YfW0K
         qw9yz47/8ZyE7El9zyKrpX6FxYTqfCOL/KV4sKWwPji/sOlAKKSZJGMnIfy08kBE/oZj
         5Ow1ygy8tsS7ANpFzOe7Kp1U16F48xU8m+P1WFrA1xc3bLm6Jgh5b9hFkkh5oaITb+Ji
         sWSWe0i1edcvaMRxj6V14kv8WeQFfDfQM3JvK0bj3fESox4Fnq9hVhynGXjBbP3l99Ut
         R8L+pMW90KxNobngtePTakpHnAIOlPcoCK4QFSrTWkmEbbuLhqiAbOcS0Cx5ErD3vfgm
         UIiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=cqqNQcjxZKCBbJrhwZmXlaL29Q1qsVjTwEkp4+lUxdU=;
        b=QKK56K5AwFFzJA+w+vVZ3HdxmgygqRKGAiL4wyPoecadlCWmGqUbCftG/vIW3fSC5k
         Jz1OdmIwdtIz4f2tu1s0qQNiAb8aZRImQ9nweZIhqUItasot8LrSmFO1bSXs0xon7WEa
         x0NwOiTIB/e4eL9hN5lmYJOk94xLZba7H6HHZLSUsiB/jONBD9Si8/RYdUcDxn3jBeqJ
         aDYIgKge4j9GeTqjukhQckNJEeA0OGEUyfInieesse1gMTZLSKK/PZvot6V+D2CxAqO8
         LWGz9BOCpoQVDubYn4JXFV1j8dnKQlmfprwV8/mmxWyctfp5yMC3EWTI1A0wjpISklu3
         byKQ==
X-Gm-Message-State: APjAAAV4rxMIY0CcVqO4CZ1mYf3Ith9ZA/HcbIrT4Qoit5f58tJatgL+
        Hz6TT5bOKY+as2EC5XnG9eTbnqiIKPDHSly1wPDuFg==
X-Google-Smtp-Source: APXvYqxswIM8pnBZTf4JSFzJH5iVwegnGiEXZPza+6Bn5dQaguOlalUfABkzQuHVZ7Yhx2xki+lP2+gvBt9AxTPDA6C5Hw==
X-Received: by 2002:a05:620a:1413:: with SMTP id d19mr23052964qkj.341.1566260326602;
 Mon, 19 Aug 2019 17:18:46 -0700 (PDT)
Date:   Mon, 19 Aug 2019 17:17:50 -0700
In-Reply-To: <20190820001805.241928-1-matthewgarrett@google.com>
Message-Id: <20190820001805.241928-15-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190820001805.241928-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
Subject: [PATCH V40 14/29] ACPI: Limit access to custom_method when the kernel
 is locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Matthew Garrett <mjg59@google.com>,
        David Howells <dhowells@redhat.com>,
        Kees Cook <keescook@chromium.org>, linux-acpi@vger.kernel.org
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
Reviewed-by: Kees Cook <keescook@chromium.org>
cc: linux-acpi@vger.kernel.org
Signed-off-by: James Morris <jmorris@namei.org>
---
 drivers/acpi/custom_method.c | 6 ++++++
 include/linux/security.h     | 1 +
 security/lockdown/lockdown.c | 1 +
 3 files changed, 8 insertions(+)

diff --git a/drivers/acpi/custom_method.c b/drivers/acpi/custom_method.c
index b2ef4c2ec955..7031307becd7 100644
--- a/drivers/acpi/custom_method.c
+++ b/drivers/acpi/custom_method.c
@@ -9,6 +9,7 @@
 #include <linux/uaccess.h>
 #include <linux/debugfs.h>
 #include <linux/acpi.h>
+#include <linux/security.h>
 
 #include "internal.h"
 
@@ -29,6 +30,11 @@ static ssize_t cm_write(struct file *file, const char __user * user_buf,
 
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
index 010637a79eac..390e39395112 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -110,6 +110,7 @@ enum lockdown_reason {
 	LOCKDOWN_PCI_ACCESS,
 	LOCKDOWN_IOPORT,
 	LOCKDOWN_MSR,
+	LOCKDOWN_ACPI_TABLES,
 	LOCKDOWN_INTEGRITY_MAX,
 	LOCKDOWN_CONFIDENTIALITY_MAX,
 };
diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
index b1c1c72440d5..6d44db0ddffa 100644
--- a/security/lockdown/lockdown.c
+++ b/security/lockdown/lockdown.c
@@ -25,6 +25,7 @@ static char *lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1] = {
 	[LOCKDOWN_PCI_ACCESS] = "direct PCI access",
 	[LOCKDOWN_IOPORT] = "raw io port access",
 	[LOCKDOWN_MSR] = "raw MSR access",
+	[LOCKDOWN_ACPI_TABLES] = "modifying ACPI tables",
 	[LOCKDOWN_INTEGRITY_MAX] = "integrity",
 	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
 };
-- 
2.23.0.rc1.153.gdeed80330f-goog

