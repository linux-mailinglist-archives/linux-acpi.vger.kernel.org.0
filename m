Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B84CC17A533
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Mar 2020 13:24:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725948AbgCEMYc (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 5 Mar 2020 07:24:32 -0500
Received: from a3.inai.de ([88.198.85.195]:60814 "EHLO a3.inai.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725926AbgCEMYc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 5 Mar 2020 07:24:32 -0500
Received: by a3.inai.de (Postfix, from userid 65534)
        id 8472F5872F8D4; Thu,  5 Mar 2020 13:24:31 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on a3.inai.de
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.2
Received: from a4.inai.de (a4.inai.de [IPv6:2a01:4f8:10b:45d8::f8])
        by a3.inai.de (Postfix) with ESMTP id 0A61058078513;
        Thu,  5 Mar 2020 13:24:26 +0100 (CET)
From:   Jan Engelhardt <jengelh@inai.de>
To:     linux-acpi@vger.kernel.org
Cc:     jengelh@inai.de
Subject: [PATCH] x86: ignore unspecified bit positions in the ACPI global lock field
Date:   Thu,  5 Mar 2020 13:24:25 +0100
Message-Id: <20200305122425.32223-1-jengelh@inai.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The value in "new" is constructed from "old" such that all bits defined
as reserved by the ACPI spec[1] are left untouched. But if those bits
do not happen to be all zero, "new < 3" will not evaluate to true.

The firmware of the laptop(s) Medion MD63490 / Akoya P15648 comes with
garbage inside the "FACS" ACPI table. The starting value is
old=0x4944454d, therefore new=0x4944454e, which is >= 3. Mask off
the reserved bits.

[1] https://uefi.org/sites/default/files/resources/ACPI_6_2.pdf

References: https://bugzilla.kernel.org/show_bug.cgi?id=206553
Signed-off-by: Jan Engelhardt <jengelh@inai.de>
---
 arch/x86/kernel/acpi/boot.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index 04205ce127a1..f9e84a0e2fa2 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -1740,7 +1740,7 @@ int __acpi_acquire_global_lock(unsigned int *lock)
 		new = (((old & ~0x3) + 2) + ((old >> 1) & 0x1));
 		val = cmpxchg(lock, old, new);
 	} while (unlikely (val != old));
-	return (new < 3) ? -1 : 0;
+	return ((new & 0x3) < 3) ? -1 : 0;
 }
 
 int __acpi_release_global_lock(unsigned int *lock)
-- 
2.25.1

