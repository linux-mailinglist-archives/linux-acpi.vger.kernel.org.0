Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DDEE14F28D
	for <lists+linux-acpi@lfdr.de>; Fri, 31 Jan 2020 20:10:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726065AbgAaTKd (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 31 Jan 2020 14:10:33 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:56570 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbgAaTKd (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 31 Jan 2020 14:10:33 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1ixbgS-0004CG-LY; Fri, 31 Jan 2020 20:10:29 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 4E5EF1C1D5A;
        Fri, 31 Jan 2020 20:10:28 +0100 (CET)
Date:   Fri, 31 Jan 2020 19:10:28 -0000
From:   "tip-bot2 for Steven Clarkson" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/boot: Handle malformed SRAT tables during early
 ACPI parsing
Cc:     Steven Clarkson <sc@lambdal.com>, Borislav Petkov <bp@suse.de>,
        linux-acpi@vger.kernel.org, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <CAHKq8taGzj0u1E_i=poHUam60Bko5BpiJ9jn0fAupFUYexvdUQ@mail.gmail.com>
References: <CAHKq8taGzj0u1E_i=poHUam60Bko5BpiJ9jn0fAupFUYexvdUQ@mail.gmail.com>
MIME-Version: 1.0
Message-ID: <158049782801.396.10779532409008194964.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     2b73ea3796242608b4ccf019ff217156c92e92fe
Gitweb:        https://git.kernel.org/tip/2b73ea3796242608b4ccf019ff217156c92e92fe
Author:        Steven Clarkson <sc@lambdal.com>
AuthorDate:    Thu, 30 Jan 2020 16:48:16 -08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Fri, 31 Jan 2020 20:03:23 +01:00

x86/boot: Handle malformed SRAT tables during early ACPI parsing

Break an infinite loop when early parsing of the SRAT table is caused
by a subtable with zero length. Known to affect the ASUS WS X299 SAGE
motherboard with firmware version 1201 which has a large block of
zeros in its SRAT table. The kernel could boot successfully on this
board/firmware prior to the introduction of early parsing this table or
after a BIOS update.

 [ bp: Fixup whitespace damage and commit message. Make it return 0 to
   denote that there are no immovable regions because who knows what
   else is broken in this BIOS. ]

Fixes: 02a3e3cdb7f1 ("x86/boot: Parse SRAT table and count immovable memory regions")
Signed-off-by: Steven Clarkson <sc@lambdal.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: linux-acpi@vger.kernel.org
Link: https://bugzilla.kernel.org/show_bug.cgi?id=206343
Link: https://lkml.kernel.org/r/CAHKq8taGzj0u1E_i=poHUam60Bko5BpiJ9jn0fAupFUYexvdUQ@mail.gmail.com
---
 arch/x86/boot/compressed/acpi.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/boot/compressed/acpi.c b/arch/x86/boot/compressed/acpi.c
index 25019d4..ef2ad72 100644
--- a/arch/x86/boot/compressed/acpi.c
+++ b/arch/x86/boot/compressed/acpi.c
@@ -393,7 +393,13 @@ int count_immovable_mem_regions(void)
 	table = table_addr + sizeof(struct acpi_table_srat);
 
 	while (table + sizeof(struct acpi_subtable_header) < table_end) {
+
 		sub_table = (struct acpi_subtable_header *)table;
+		if (!sub_table->length) {
+			debug_putstr("Invalid zero length SRAT subtable.\n");
+			return 0;
+		}
+
 		if (sub_table->type == ACPI_SRAT_TYPE_MEMORY_AFFINITY) {
 			struct acpi_srat_mem_affinity *ma;
 
