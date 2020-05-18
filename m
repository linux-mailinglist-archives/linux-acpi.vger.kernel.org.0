Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B25231D8AB0
	for <lists+linux-acpi@lfdr.de>; Tue, 19 May 2020 00:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbgERWWh (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 18 May 2020 18:22:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:34846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726386AbgERWWg (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 18 May 2020 18:22:36 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8FDB620674;
        Mon, 18 May 2020 22:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589840556;
        bh=I48flygjIBp7uOnVnXDFpml1edpXtpsCjzT/57eK7CQ=;
        h=Date:From:To:Cc:Subject:From;
        b=r2Z4K0y2G8YiS1+K48wrTdZc8IcboE5EvkgJatVdyvfNLmOZ/GLIOr/AteenNbOBW
         rRDXRtgGIto++cGMHN27fMO358VTGas/gXzeuSuxTaIUCBnRee0Fu3worwP9ddV5Jh
         Eoyk06j6KCZ1MWUhrWx13BTFIGqueNItbI5JS1w8=
Date:   Mon, 18 May 2020 17:27:22 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>
Cc:     linux-acpi@vger.kernel.org, devel@acpica.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH] ACPICA: Replace one-element array and use struct_size()
 helper
Message-ID: <20200518222722.GA7791@embeddedor>
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

Also, make use of the new struct_size() helper to properly calculate the
size of struct acpi_pnp_device_id_list.

This issue was found with the help of Coccinellea and, audited and
fixed _manually_.

[1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
[2] https://github.com/KSPP/linux/issues/21
[3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/acpi/acpica/utids.c | 4 +---
 include/acpi/actypes.h      | 2 +-
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/acpica/utids.c b/drivers/acpi/acpica/utids.c
index 3bb06935a2ad3..c2f819a39424a 100644
--- a/drivers/acpi/acpica/utids.c
+++ b/drivers/acpi/acpica/utids.c
@@ -262,9 +262,7 @@ acpi_ut_execute_CID(struct acpi_namespace_node *device_node,
 	 * 2) Size of the CID PNP_DEVICE_ID array +
 	 * 3) Size of the actual CID strings
 	 */
-	cid_list_size = sizeof(struct acpi_pnp_device_id_list) +
-	    ((count - 1) * sizeof(struct acpi_pnp_device_id)) +
-	    string_area_size;
+	cid_list_size = struct_size(cid_list, ids, count) + string_area_size;
 
 	cid_list = ACPI_ALLOCATE_ZEROED(cid_list_size);
 	if (!cid_list) {
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
2.26.2

