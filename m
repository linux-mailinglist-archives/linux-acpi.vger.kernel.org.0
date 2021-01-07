Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8AF72ECE88
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Jan 2021 12:19:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbhAGLTA (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 7 Jan 2021 06:19:00 -0500
Received: from foss.arm.com ([217.140.110.172]:58064 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726326AbhAGLTA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 7 Jan 2021 06:19:00 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6698B106F;
        Thu,  7 Jan 2021 03:18:14 -0800 (PST)
Received: from e108754-lin.cambridge.arm.com (unknown [10.1.198.32])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 17AAC3F719;
        Thu,  7 Jan 2021 03:18:12 -0800 (PST)
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     rjw@rjwysocki.net, lenb@kernel.org, robert.moore@intel.com
Cc:     viro@zeniv.linux.org.uk, catalin.marinas@arm.com,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        ionela.voinescu@arm.com, Erik Kaneda <erik.kaneda@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 1/3] acpi: cppc_acpi: remove __iomem annotation for cpc_reg's address
Date:   Thu,  7 Jan 2021 11:17:15 +0000
Message-Id: <20210107111717.5571-2-ionela.voinescu@arm.com>
X-Mailer: git-send-email 2.29.2.dirty
In-Reply-To: <20210107111717.5571-1-ionela.voinescu@arm.com>
References: <20210107111717.5571-1-ionela.voinescu@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The cpc_reg address does not represent either an I/O virtual address,
nor a field located in iomem. This address is used as an address offset
which eventually is given as physical address argument to ioremap or PCC
space offset to GET_PCC_VADDR. Therefore, having the __iomem annotation
does not make sense.

Fix the following sparse warnings by removing the __iomem annotation
for cpc_reg's address.

drivers/acpi/cppc_acpi.c:762:37: warning: dereference of noderef expression
drivers/acpi/cppc_acpi.c:765:48: warning: dereference of noderef expression
drivers/acpi/cppc_acpi.c:948:25: warning: dereference of noderef expression
drivers/acpi/cppc_acpi.c:954:67: warning: dereference of noderef expression
drivers/acpi/cppc_acpi.c:987:25: warning: dereference of noderef expression
drivers/acpi/cppc_acpi.c:993:68: warning: dereference of noderef expression
drivers/acpi/cppc_acpi.c:1120:13: warning: dereference of noderef expression
drivers/acpi/cppc_acpi.c:1134:13: warning: dereference of noderef expression
drivers/acpi/cppc_acpi.c:1137:13: warning: dereference of noderef expression
drivers/acpi/cppc_acpi.c:1182:14: warning: dereference of noderef expression
drivers/acpi/cppc_acpi.c:1212:13: warning: dereference of noderef expression

Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Ionela Voinescu <ionela.voinescu@arm.com>
Cc: Robert Moore <robert.moore@intel.com>
Cc: Erik Kaneda <erik.kaneda@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
---
 include/acpi/cppc_acpi.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
index 232838d28f50..c7fc4524e151 100644
--- a/include/acpi/cppc_acpi.h
+++ b/include/acpi/cppc_acpi.h
@@ -39,7 +39,7 @@ struct cpc_reg {
 	u8 bit_width;
 	u8 bit_offset;
 	u8 access_width;
-	u64 __iomem address;
+	u64 address;
 } __packed;
 
 /*
-- 
2.29.2.dirty

