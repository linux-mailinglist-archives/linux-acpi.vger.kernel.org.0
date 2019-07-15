Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FE1569C27
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Jul 2019 22:02:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732220AbfGOUCD (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 15 Jul 2019 16:02:03 -0400
Received: from mail-qk1-f201.google.com ([209.85.222.201]:39708 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732506AbfGOUAh (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 15 Jul 2019 16:00:37 -0400
Received: by mail-qk1-f201.google.com with SMTP id x1so14694138qkn.6
        for <linux-acpi@vger.kernel.org>; Mon, 15 Jul 2019 13:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=5T+b4pkocKIcoPwPocbouCfMQE+Kz4ndw1ZbXIQy5/k=;
        b=WiP2xn7hpAfVzOYD0zMTv398nzim5ITpRx7xasgZ/7JJ1ldY9RN+GzQar/QJ/H559P
         As5LDUrSxo3S742mB7JhtBaQ/zw4YzZtwjpUltwV0ZC2+ynjaufKYbosyx7j33dmTPPL
         VjzNr6fWWw3AUfow3dbdCh0DJ1k6PjUSXU2vgnyE8Dn4KYjN2keZYQ5aPvD2KL8j5hSp
         iLn5yiPDspkHNxs0iDVApzCb3WbakwL4P2nZGEKVZg5zQvsvRnKJwQ/FfhB9FT6dmnkE
         NAuQ4zblcRoTtABvv1i8qmWTPsv/kFIPVHdXDUjHet9xV1C6dL3t3HMhTD7tdT6rCxPl
         ZoQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=5T+b4pkocKIcoPwPocbouCfMQE+Kz4ndw1ZbXIQy5/k=;
        b=LIxQ31JeQkdjHNBYwH43wG+h6Qu3UjdF+QhyZeatnB2BZPWViHrGaTMkzbk6hjq6dw
         szfYTBcWOITZjQ9c638oFPJ4Vd+yxy1HDx57TYM/jc2Cl+F8TCxArceCzmqSRzb2HP+z
         9uPncWtByUm7zSEPZP1AO/6xpV/VQ8DOduFJGoSElDi0mf4a9DjMgiS0ZK6jswwHh/pR
         zIH+Ydrwjw/ZO8iCjKRmpFRVEZF4WfUJPV9+iiosxS2iC/zggViHtfChkv3/YDZyESgx
         a/NICo6B7im/bih8I+fE8QiB7JBYTteji5y/PbmTUncEclVzB3hkJviTi2fdaZUHyWW+
         fliA==
X-Gm-Message-State: APjAAAURDipuIFFsgZP6409rUCDT53ui8XLsDeqP/yHI6afjzqyr5hXI
        +nrGgcsD8XT/NzXnDdBEAw06GfcksIQWUKLpWSMcpw==
X-Google-Smtp-Source: APXvYqxrHpgFWUgZ9E+cUYHX+RPLtAcPfO7gJMJvEmlA6W+iOSXGyUu0fsENQ6p+pjnV5VI8Ui+qzLBkbHarm4qbjeEzkA==
X-Received: by 2002:ac8:24b8:: with SMTP id s53mr20092158qts.276.1563220836026;
 Mon, 15 Jul 2019 13:00:36 -0700 (PDT)
Date:   Mon, 15 Jul 2019 12:59:33 -0700
In-Reply-To: <20190715195946.223443-1-matthewgarrett@google.com>
Message-Id: <20190715195946.223443-17-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190715195946.223443-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
Subject: [PATCH V35 16/29] acpi: Disable ACPI table override if the kernel is
 locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Linn Crosetto <linn@hpe.com>,
        David Howells <dhowells@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        Kees Cook <keescook@chromium.org>, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Linn Crosetto <linn@hpe.com>

From the kernel documentation (initrd_table_override.txt):

  If the ACPI_INITRD_TABLE_OVERRIDE compile option is true, it is possible
  to override nearly any ACPI table provided by the BIOS with an
  instrumented, modified one.

When lockdown is enabled, the kernel should disallow any unauthenticated
changes to kernel space.  ACPI tables contain code invoked by the kernel,
so do not allow ACPI tables to be overridden if the kernel is locked down.

Signed-off-by: Linn Crosetto <linn@hpe.com>
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
2.22.0.510.g264f2c817a-goog

