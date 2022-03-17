Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62B834DC873
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Mar 2022 15:12:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233970AbiCQOOJ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 17 Mar 2022 10:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233668AbiCQOOI (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 17 Mar 2022 10:14:08 -0400
X-Greylist: delayed 542 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 17 Mar 2022 07:12:46 PDT
Received: from srv1.home.kabele.me (gw.home.kabele.me [195.88.143.223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ED9401FE574
        for <linux-acpi@vger.kernel.org>; Thu, 17 Mar 2022 07:12:46 -0700 (PDT)
Received: from srv1.home.kabele.me (localhost [IPv6:::1])
        by srv1.home.kabele.me (Postfix) with ESMTP id 67FBF168FA8;
        Thu, 17 Mar 2022 15:04:31 +0100 (CET)
Received: from localhost ([2a01:c22:8dfa:1400:beea:2810:7764:7afc])
        by srv1.home.kabele.me with ESMTPSA
        id FsSRFu8/M2JB8zMAnmUwTQ
        (envelope-from <vit@kabele.me>); Thu, 17 Mar 2022 15:04:31 +0100
Date:   Thu, 17 Mar 2022 15:04:26 +0100
From:   Vit Kabele <vit@kabele.me>
To:     platform-driver-x86@kernel.org
Cc:     vit@kabele.me, r.marek@assembler.cz, devel@acpica.org,
        mingo@redhat.com, robert.moore@intel.com, linux-kernel@kernel.org,
        linux-acpi@vger.kernel.org
Subject: [PATCH 2/3] acpica: Check that the EBDA pointer is in valid range
Message-ID: <YjM/6rqxZN19en2I@czspare1-lap.sysgo.cz>
Mail-Followup-To: platform-driver-x86@kernel.org, r.marek@assembler.cz,
        devel@acpica.org, mingo@redhat.com, robert.moore@intel.com,
        linux-kernel@kernel.org, linux-acpi@vger.kernel.org
References: <cover.1647525033.git.vit@kabele.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1647525033.git.vit@kabele.me>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

If the memory at 0x40e is uninitialized, the retrieved physical_memory
address of EBDA may be beyond the low memory (i.e. above 640K).

If so, the kernel may unintentionally access the VGA memory, that
might not be decoded or even present in case of virtualization.

Signed-off-by: Vit Kabele <vit@kabele.me>
Reviewed-by: Rudolf Marek <r.marek@assembler.cz>
---
 drivers/acpi/acpica/tbxfroot.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpica/tbxfroot.c b/drivers/acpi/acpica/tbxfroot.c
index 9fec3df6c3ba..67b7df1c0520 100644
--- a/drivers/acpi/acpica/tbxfroot.c
+++ b/drivers/acpi/acpica/tbxfroot.c
@@ -138,8 +138,11 @@ acpi_find_root_pointer(acpi_physical_address *table_address)
 	acpi_os_unmap_memory(table_ptr, ACPI_EBDA_PTR_LENGTH);
 
 	/* EBDA present? */
-
-	if (physical_address > 0x400) {
+	/* Check that the EBDA pointer from 0x40e is sane and does not point
+	 * above valid low memory
+	 */
+	if (physical_address > 0x400 &&
+	    physical_address < 0xA0000) {
 		/*
 		 * 1b) Search EBDA paragraphs (EBDA is required to be a
 		 *     minimum of 1K length)
-- 
2.30.2

