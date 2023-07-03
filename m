Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6C41745C2B
	for <lists+linux-acpi@lfdr.de>; Mon,  3 Jul 2023 14:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbjGCMY6 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 3 Jul 2023 08:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbjGCMY5 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 3 Jul 2023 08:24:57 -0400
Received: from imap5.colo.codethink.co.uk (imap5.colo.codethink.co.uk [78.40.148.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ADD6109
        for <linux-acpi@vger.kernel.org>; Mon,  3 Jul 2023 05:24:56 -0700 (PDT)
Received: from [167.98.27.226] (helo=rainbowdash)
        by imap5.colo.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
        id 1qGIbs-0029ze-02; Mon, 03 Jul 2023 13:24:52 +0100
Received: from ben by rainbowdash with local (Exim 4.96)
        (envelope-from <ben@rainbowdash>)
        id 1qGIbr-003zaH-2I;
        Mon, 03 Jul 2023 13:24:51 +0100
From:   Ben Dooks <ben.dooks@codethink.co.uk>
To:     acpica-devel@lists.linuxfoundation.org
Cc:     linux-acpi@vger.kernel.org, robert.moore@intel.com,
        lenb@kernel.org, rafael@kernel.org,
        Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH] ACPI: fix undeclared symbols from saprse
Date:   Mon,  3 Jul 2023 13:24:50 +0100
Message-Id: <20230703122450.951704-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The building of drivers/acpi/acpica/utglobal.o is throwing
a number of sparse warnins about undeclared symbols. This is
due to defining DEFINE_ACPI_GLOBALS then making the macro
ACPI_INIT_GLOBAL() define it but never declaring the fact this
is an extern declared varible.

This is some of the sparse warnings that are being fixed here:

drivers/acpi/acpica/utglobal.c: note: in included file (through include/acpi/acpi.h):
./include/acpi/acpixf.h:104:1: warning: symbol 'acpi_gbl_enable_interpreter_slack' was not declared. Should it be static?
./include/acpi/acpixf.h:113:1: warning: symbol 'acpi_gbl_auto_serialize_methods' was not declared. Should it be static?
./include/acpi/acpixf.h:120:1: warning: symbol 'acpi_gbl_create_osi_method' was not declared. Should it be static?
./include/acpi/acpixf.h:126:1: warning: symbol 'acpi_gbl_use_default_register_widths' was not declared. Should it be static?
./include/acpi/acpixf.h:136:1: warning: symbol 'acpi_gbl_enable_table_validation' was not declared. Should it be static?
./include/acpi/acpixf.h:141:1: warning: symbol 'acpi_gbl_enable_aml_debug_object' was not declared. Should it be static?
./include/acpi/acpixf.h:149:1: warning: symbol 'acpi_gbl_copy_dsdt_locally' was not declared. Should it be static?
./include/acpi/acpixf.h:157:1: warning: symbol 'acpi_gbl_do_not_use_xsdt' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
Note, if this isn't the correct place to fix, where should this be
going?
---
 include/acpi/acpixf.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index 9ffdc0425bc2..8d69d1e39cd9 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -37,6 +37,7 @@
 	type name
 
 #define ACPI_INIT_GLOBAL(type,name,value) \
+	extern type name; \
 	type name=value
 
 #else
-- 
2.40.1

