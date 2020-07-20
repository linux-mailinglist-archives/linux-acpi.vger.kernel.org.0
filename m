Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 408DB226D9E
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Jul 2020 19:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726675AbgGTRzN (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 20 Jul 2020 13:55:13 -0400
Received: from mga14.intel.com ([192.55.52.115]:19980 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726486AbgGTRzM (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 20 Jul 2020 13:55:12 -0400
IronPort-SDR: JL9LNM3bssDZDD33TXd8ifPilqlHObV7Eg4YgvolBKtRshei//m5vuEivHq4R6wuJwZwbQAvIe
 ObkrM+Pqnk2w==
X-IronPort-AV: E=McAfee;i="6000,8403,9688"; a="149135337"
X-IronPort-AV: E=Sophos;i="5.75,375,1589266800"; 
   d="scan'208";a="149135337"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2020 10:55:12 -0700
IronPort-SDR: ZaJTb7xjEUzU2xuAZWMvkn8q5HGFtEECP0ngj7UlQZx8eeDMq3yac64BToOPoQaD5ZfFeI7fSq
 cm2in/s2N9hA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,375,1589266800"; 
   d="scan'208";a="392105329"
Received: from sibelius.jf.intel.com ([10.54.75.172])
  by fmsmga001.fm.intel.com with ESMTP; 20 Jul 2020 10:55:12 -0700
From:   Erik Kaneda <erik.kaneda@intel.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-acpi@vger.kernel.org
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Erik Kaneda <erik.kaneda@intel.com>,
        Bob Moore <robert.moore@intel.com>
Subject: [PATCH 1/3] ACPICA: Replace one-element array with flexible-array
Date:   Mon, 20 Jul 2020 10:31:19 -0700
Message-Id: <20200720173121.2580755-2-erik.kaneda@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200720173121.2580755-1-erik.kaneda@intel.com>
References: <20200720173121.2580755-1-erik.kaneda@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: "Gustavo A. R. Silva" <gustavoars@kernel.org>

ACPICA commit 7ba2f3d91a32f104765961fda0ed78b884ae193d

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
in case the flexible array does not occur last in the structure,
which will help us prevent some kind of undefined behavior bugs from
being inadvertently introduced[3] to the linux codebase from now on.

This issue was found with the help of Coccinelle and audited _manually_.

[1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
[2] https://github.com/KSPP/linux/issues/21
[3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")

Link: https://github.com/acpica/acpica/commit/7ba2f3d9
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Signed-off-by: Erik Kaneda <erik.kaneda@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/utids.c | 3 +--
 include/acpi/actypes.h      | 2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/acpica/utids.c b/drivers/acpi/acpica/utids.c
index 3bb06935a2ad..3e68864ef242 100644
--- a/drivers/acpi/acpica/utids.c
+++ b/drivers/acpi/acpica/utids.c
@@ -263,8 +263,7 @@ acpi_ut_execute_CID(struct acpi_namespace_node *device_node,
 	 * 3) Size of the actual CID strings
 	 */
 	cid_list_size = sizeof(struct acpi_pnp_device_id_list) +
-	    ((count - 1) * sizeof(struct acpi_pnp_device_id)) +
-	    string_area_size;
+	    (count * sizeof(struct acpi_pnp_device_id)) + string_area_size;
 
 	cid_list = ACPI_ALLOCATE_ZEROED(cid_list_size);
 	if (!cid_list) {
diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index d005e35ab399..d50e61384f1f 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -1146,7 +1146,7 @@ struct acpi_pnp_device_id {
 struct acpi_pnp_device_id_list {
 	u32 count;		/* Number of IDs in Ids array */
 	u32 list_size;		/* Size of list, including ID strings */
-	struct acpi_pnp_device_id ids[1];	/* ID array */
+	struct acpi_pnp_device_id ids[];	/* ID array */
 };
 
 /*
-- 
2.25.1

