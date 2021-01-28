Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F9C13081CD
	for <lists+linux-acpi@lfdr.de>; Fri, 29 Jan 2021 00:26:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231330AbhA1X0Z (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 28 Jan 2021 18:26:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231228AbhA1X0Y (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 28 Jan 2021 18:26:24 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6488C06174A;
        Thu, 28 Jan 2021 15:25:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=9LAtGDFH6zDnTdxtCfVVdPAvctAiNjV0aqHUdl2anj0=; b=23jmMc4bphLmkaLLj37Aw7pzKP
        srJHKBofiwnPdB961Ogi07DNQRmqfhqlmtzekyALdJiUxnIi9ZMlC9LSnItF8D+XDtwYtPI/3V/hi
        FPZnKX0Aayhfap9SEPq+O8Ldy6X8gSKjoTRTk1Ax4D7xr/4Vr2hdFwZ7ylQQcLf8KJ5wfeENt2Kba
        PEkmdL29L9fxgcCYERDy/cChLJfqETOjzetBydSbE8Zg8LLSMKtH8Sc9Nydie6tPXZk9DbtHLERfM
        AWhU8uYQT+Teo7oyM4u5S4XwKJZgRY6ywGKUzmk8xDRYzD6PsK42+cmJ5m+0Y/BJfTVkLWNbhoeVy
        4a4QAxiw==;
Received: from [2601:1c0:6280:3f0::7650] (helo=merlin.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l5GfS-0008Ie-0t; Thu, 28 Jan 2021 23:25:38 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH -next] acpi: fpdt: drop errant comma in pr_info()
Date:   Thu, 28 Jan 2021 15:25:28 -0800
Message-Id: <20210128232528.21117-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Drop a mistaken comma in the pr_info() args to prevent the
build warning.

../drivers/acpi/acpi_fpdt.c: In function 'acpi_init_fpdt':
../include/linux/kern_levels.h:5:18: warning: too many arguments for format [-Wformat-extra-args]
../drivers/acpi/acpi_fpdt.c:255:4: note: in expansion of macro 'pr_info'
    pr_info(FW_BUG, "Invalid subtable type %d found.\n",

Fixes: 208757d71098 ("ACPI: tables: introduce support for FPDT table")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/acpi_fpdt.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20210128.orig/drivers/acpi/acpi_fpdt.c
+++ linux-next-20210128/drivers/acpi/acpi_fpdt.c
@@ -252,7 +252,7 @@ void acpi_init_fpdt(void)
 					      subtable->type);
 			break;
 		default:
-			pr_info(FW_BUG, "Invalid subtable type %d found.\n",
+			pr_info(FW_BUG "Invalid subtable type %d found.\n",
 			       subtable->type);
 			return;
 		}
