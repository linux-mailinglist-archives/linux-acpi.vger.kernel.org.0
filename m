Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71F3D1EC461
	for <lists+linux-acpi@lfdr.de>; Tue,  2 Jun 2020 23:34:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726373AbgFBVez (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 2 Jun 2020 17:34:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:49740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726130AbgFBVez (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 2 Jun 2020 17:34:55 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F30AE206E2;
        Tue,  2 Jun 2020 21:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591133694;
        bh=U5VQLBA0K584HyMnp25pHX350Ep4BaZZoHpAMfzXWOE=;
        h=Date:From:To:Cc:Subject:From;
        b=LHEuC4+DoL1LbalzPAmeFzSITJzZ7hODWN7PopM1OKU+1s8mHEmJJtHec0GBEaHoj
         203o2uDa+HjRZEJ1ThVBUBux4B3RnuMMwJjI90C9OcpYK9g5Fej+OXAXSDFMG3iGp/
         JDOBTjJS3zzuKz4zqk0Lsbfmp1Fi573mV5FbiVZk=
Date:   Tue, 2 Jun 2020 16:39:58 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>
Cc:     linux-acpi@vger.kernel.org, devel@acpica.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH v2] ACPICA: Replace one-element array with flexible-array
Message-ID: <20200602213958.GA32150@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The current codebase makes use of one-element arrays in the following
form:

struct something {
    int length;
    u8 data[1];
};

struct something *instance;

instance = kmalloc(sizeof(*instance) + size, GFP_KERNEL);
instance->length = size;
memcpy(instance->data, source, size);

but the preferred mechanism to declare variable-length types such as
these ones is a flexible array member[1][2], introduced in C99:

struct foo {
        int stuff;
        struct boo array[];
};

By making use of the mechanism above, we will get a compiler warning
in case the flexible array does not occur last in the structure, which
will help us prevent some kind of undefined behavior bugs from being
inadvertently introduced[3] to the codebase from now on.

This issue was found with the help of Coccinelle and audited _manually_.

[1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
[2] https://github.com/KSPP/linux/issues/21
[3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
Changes in v2:
 - Don't use struct_size() for now.
 - Update subject line and changelog text.

 drivers/acpi/acpica/utids.c | 2 +-
 include/acpi/actypes.h      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpica/utids.c b/drivers/acpi/acpica/utids.c
index 3bb06935a2ad3..225f3c60203c7 100644
--- a/drivers/acpi/acpica/utids.c
+++ b/drivers/acpi/acpica/utids.c
@@ -263,7 +263,7 @@ acpi_ut_execute_CID(struct acpi_namespace_node *device_node,
 	 * 3) Size of the actual CID strings
 	 */
 	cid_list_size = sizeof(struct acpi_pnp_device_id_list) +
-	    ((count - 1) * sizeof(struct acpi_pnp_device_id)) +
+	    count * sizeof(struct acpi_pnp_device_id) +
 	    string_area_size;
 
 	cid_list = ACPI_ALLOCATE_ZEROED(cid_list_size);
diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index 4defed58ea338..c7bcda0ad366a 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -1145,7 +1145,7 @@ struct acpi_pnp_device_id {
 struct acpi_pnp_device_id_list {
 	u32 count;		/* Number of IDs in Ids array */
 	u32 list_size;		/* Size of list, including ID strings */
-	struct acpi_pnp_device_id ids[1];	/* ID array */
+	struct acpi_pnp_device_id ids[];	/* ID array */
 };
 
 /*
-- 
2.27.0

