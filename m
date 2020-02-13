Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D7F015C464
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Feb 2020 16:53:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387420AbgBMPqp (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 13 Feb 2020 10:46:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:49298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729320AbgBMP1N (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 13 Feb 2020 10:27:13 -0500
Received: from localhost (unknown [104.132.1.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C57D224670;
        Thu, 13 Feb 2020 15:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581607632;
        bh=qNVJvkLk5QY4zMFf9zWqo7r205XJykyNObIRHrwIBPo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I/RI49Fj0iePnzHFOd2elTDSeOXHDVFQ/YA8TQB1FVeMz0ExNwkBI8hmFYzWqcVTS
         YKIgBuEU7kgdmWz+cfL6D3neYYVPpap7N6AjzG2bgQ3Z29AgQWa9TPAoShpYIVQQTl
         rBWRcvsGBvZUi49UventhH9pm7sJqv54kRxL3NoQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Steven Clarkson <sc@lambdal.com>,
        Borislav Petkov <bp@suse.de>, linux-acpi@vger.kernel.org,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 34/96] x86/boot: Handle malformed SRAT tables during early ACPI parsing
Date:   Thu, 13 Feb 2020 07:20:41 -0800
Message-Id: <20200213151852.168079621@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200213151839.156309910@linuxfoundation.org>
References: <20200213151839.156309910@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Steven Clarkson <sc@lambdal.com>

[ Upstream commit 2b73ea3796242608b4ccf019ff217156c92e92fe ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/boot/compressed/acpi.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/boot/compressed/acpi.c b/arch/x86/boot/compressed/acpi.c
index 25019d42ae937..ef2ad7253cd5e 100644
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
 
-- 
2.20.1



