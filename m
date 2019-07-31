Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 691617D0F0
	for <lists+linux-acpi@lfdr.de>; Thu,  1 Aug 2019 00:19:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728242AbfGaWTI (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 31 Jul 2019 18:19:08 -0400
Received: from mail-vs1-f74.google.com ([209.85.217.74]:39870 "EHLO
        mail-vs1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731307AbfGaWRI (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 31 Jul 2019 18:17:08 -0400
Received: by mail-vs1-f74.google.com with SMTP id p62so18218798vsd.6
        for <linux-acpi@vger.kernel.org>; Wed, 31 Jul 2019 15:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Tmn4zMTjEPlUC2x7KbFrZqCSBZYi0Bx5tDyyMiSTkHI=;
        b=KNtYwwW10pBzgMhIxkJCS/uENsLSdnfeR4Sv0jIZjE/kqgEDSSHm7qFmZbYcYGhoW6
         ah/D6endKWnFZUJYaYj7c4Z+Ww90IGwhNDxIsN8ddpHHjZu1K7WMe4g+HC9ErAOL+Oan
         P+BwGpuxFHwb5gLspVTRu+6V+KSMYrvGqWk/8uA5Bh2vAksZ/MPON9EHcNcYaMbAc+XA
         C8a2S8I67YkszaV+R1icsFv0U0LpSf3kIpJXXD+cQD5wRZp78DzPMYAZY0V+NEYlQnJJ
         vgeuo4JK2gW0U5FN7kBmSeEw1cE/vN5M3uTg1hBFh/FZ4R94jpLxHeYydBoPJgYD3CRN
         TwlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Tmn4zMTjEPlUC2x7KbFrZqCSBZYi0Bx5tDyyMiSTkHI=;
        b=QW90aI3JvZEsLXOKEjBuNm0peO9+b18TuDriiaDNHy3J+b7LeIp12yRso9JTHfMWfS
         5HsKqkn0jVODHkExYCu4rDWmsMfvnkSDAmkYS/EcaD9otB7ilpMgsV2n7E6KKmSO75vj
         2+hsKmvF6Rutmtg5qo45RG05o37BmgkHpdXdaz9/mmMG4kT1AxfNkq6IUvT3fWCdzYgi
         2Vm4EhZ+2Lg92Ny65S3qWhe27u5hIjuKWBzkbSeqED0wdU1z3UuSR7pQSAG/qBn7SIMa
         yrb+TAHS8sut4YpV9ioO2aLcXAHK2t/dYTHEqmSiMIBzk2lmSBV13cdtXVxWkZYKGWyW
         jSsA==
X-Gm-Message-State: APjAAAXRSJHsyVK047FYbiLgCaRkap0Rg5v6RQgAzB6S8OmG4Hrp8nyU
        AKW5zgmP0/do0AEPji+RZ9s2hOGDlKrQMcPZ3S3Udw==
X-Google-Smtp-Source: APXvYqyn7wWBd2XqZE1SpADBue93B65mbiHUDF9eDEu3R6HN098MIwjsGaS2ZfwdCHJzwoGqIuAtZDoBJTZs2wCzIwTnOA==
X-Received: by 2002:ab0:4307:: with SMTP id k7mr12696958uak.45.1564611426939;
 Wed, 31 Jul 2019 15:17:06 -0700 (PDT)
Date:   Wed, 31 Jul 2019 15:16:04 -0700
In-Reply-To: <20190731221617.234725-1-matthewgarrett@google.com>
Message-Id: <20190731221617.234725-17-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190731221617.234725-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
Subject: [PATCH V37 16/29] acpi: Disable ACPI table override if the kernel is
 locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Linn Crosetto <lcrosetto@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        Kees Cook <keescook@chromium.org>, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Linn Crosetto <lcrosetto@gmail.com>

From the kernel documentation (initrd_table_override.txt):

  If the ACPI_INITRD_TABLE_OVERRIDE compile option is true, it is possible
  to override nearly any ACPI table provided by the BIOS with an
  instrumented, modified one.

When lockdown is enabled, the kernel should disallow any unauthenticated
changes to kernel space.  ACPI tables contain code invoked by the kernel,
so do not allow ACPI tables to be overridden if the kernel is locked down.

Signed-off-by: Linn Crosetto <lcrosetto@gmail.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Matthew Garrett <mjg59@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
cc: linux-acpi@vger.kernel.org
---
 drivers/acpi/tables.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index b32327759380..180ac4329763 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -20,6 +20,7 @@
 #include <linux/memblock.h>
 #include <linux/earlycpio.h>
 #include <linux/initrd.h>
+#include <linux/security.h>
 #include "internal.h"
 
 #ifdef CONFIG_ACPI_CUSTOM_DSDT
@@ -578,6 +579,11 @@ void __init acpi_table_upgrade(void)
 	if (table_nr == 0)
 		return;
 
+	if (security_locked_down(LOCKDOWN_ACPI_TABLES)) {
+		pr_notice("kernel is locked down, ignoring table override\n");
+		return;
+	}
+
 	acpi_tables_addr =
 		memblock_find_in_range(0, ACPI_TABLE_UPGRADE_MAX_PHYS,
 				       all_tables_size, PAGE_SIZE);
-- 
2.22.0.770.g0f2c4a37fd-goog

