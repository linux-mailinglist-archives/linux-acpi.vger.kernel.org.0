Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BB8F1C9A58
	for <lists+linux-acpi@lfdr.de>; Thu,  7 May 2020 21:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728045AbgEGTCN (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 7 May 2020 15:02:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:33280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726926AbgEGTCM (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 7 May 2020 15:02:12 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 04D4F2083B;
        Thu,  7 May 2020 19:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588878132;
        bh=1BaK2d/28Q3HiRySzkjK8VA6eqj1T7RCpk6P2tPRcUQ=;
        h=Date:From:To:Cc:Subject:From;
        b=SjV2+HqlI/Oyuk1tKqHzIVyfvzIIC0ng2W75q3QOaNO8CdboTX8sTZAFnr7y1vpd8
         DGxg8REQrOFAuld69/Gt+037N7+iFJXTvLQoRy/hJ9ipynYwbnItpXmhMPCM3dde2Y
         QlKSMQeEErUXj3kJvXWdOw/mCb9O9+0nIYSllaCk=
Date:   Thu, 7 May 2020 14:06:38 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] PNPBIOS: Replace zero-length array with flexible-array
Message-ID: <20200507190638.GA15700@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The current codebase makes use of the zero-length array language
extension to the C90 standard, but the preferred mechanism to declare
variable-length types such as these ones is a flexible array member[1][2],
introduced in C99:

struct foo {
        int stuff;
        struct boo array[];
};

By making use of the mechanism above, we will get a compiler warning
in case the flexible array does not occur last in the structure, which
will help us prevent some kind of undefined behavior bugs from being
inadvertently introduced[3] to the codebase from now on.

Also, notice that, dynamic memory allocations won't be affected by
this change:

"Flexible array members have incomplete type, and so the sizeof operator
may not be applied. As a quirk of the original implementation of
zero-length arrays, sizeof evaluates to zero."[1]

sizeof(flexible-array-member) triggers a warning because flexible array
members have incomplete type[1]. There are some instances of code in
which the sizeof operator is being incorrectly/erroneously applied to
zero-length arrays and the result is zero. Such instances may be hiding
some bugs. So, this work (flexible-array member conversions) will also
help to get completely rid of those sorts of issues.

This issue was found with the help of Coccinelle.

[1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
[2] https://github.com/KSPP/linux/issues/21
[3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/pnp/pnpbios/pnpbios.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pnp/pnpbios/pnpbios.h b/drivers/pnp/pnpbios/pnpbios.h
index 37acb8378f39..2ce739ff9c1a 100644
--- a/drivers/pnp/pnpbios/pnpbios.h
+++ b/drivers/pnp/pnpbios/pnpbios.h
@@ -107,7 +107,7 @@ struct pnp_bios_node {
 	__u32 eisa_id;
 	__u8 type_code[3];
 	__u16 flags;
-	__u8 data[0];
+	__u8 data[];
 };
 #pragma pack()
 

