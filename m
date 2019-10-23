Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1AB84E23AC
	for <lists+linux-acpi@lfdr.de>; Wed, 23 Oct 2019 22:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406461AbfJWUDD (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 23 Oct 2019 16:03:03 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45931 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405963AbfJWUDC (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 23 Oct 2019 16:03:02 -0400
Received: by mail-pl1-f194.google.com with SMTP id y24so6673445plr.12;
        Wed, 23 Oct 2019 13:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RhGMxD9ZBui9SyjLsOvl3oJZU+AUjLFpiylNO9yBlvg=;
        b=u/cI76IAPXZqzuflqxh4ezni8rgLEaXy2SfJXyCqUD/CU8y8ALp9fFSejVe0qx0tSC
         ZgggEDeL4rITVhP3qtbpfKztrhD6FXzBw8eeX68ZHGV+sbEMq6kZC8SzHvm50xU0ckWC
         TIqINoXiDZMQcyWASucla7uuZ5nuZtBeU6Ce47Dfyko08X5pllemXipb7nuGYbLcrSUq
         dzm/JVoNqXkzzzAPurQ9jgq5RnmRysuWyR33TIbR51DhzHPawIDAESAtMtbx7o2Ko5Nz
         sdulCPIQWaIV1+ZfXr1fv/O3RMOxUhjne6slKm0SrUwBxbnfO1FtCToZh1t0xzEoAzMt
         jQ5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RhGMxD9ZBui9SyjLsOvl3oJZU+AUjLFpiylNO9yBlvg=;
        b=XRgaZw6H4du6FT65PrMNMs9AzkFZQ2id+pdh7fViTk0DIZuRGQe6mAHIJiXugDShbC
         2Ht5ns9oFu77LNl7TSfOJjnaRtHMBwAAagfIAzHr7i+8yjoLAW0NdLAqkdbwL8PNjZ08
         cX7HItNM8voB08IxL2ajL/DhnmVMZfNKZ92Fmq+h5A6JgYTRef4g9fygMgehltzeD39q
         B3g7qZFnIL/LAXVSNgyZUnWpYoHuSbVIU7THZElWDzIU1mQeHWkJm6WYkpR0phmLXXBB
         RYonMiw2ePelcZ+P4IKquz2bjJ0VX9d0toNMkAK2Mseq8SvvOd63omZtBgIRnEc0s+6d
         YHrQ==
X-Gm-Message-State: APjAAAVIdgtvd3wIOX0OwAnCSpwKqijmG1RW/1hgeBs9N4aaR3zoF67i
        LuEHjb/D6QuI1M3c6ahpAmvDRuWk
X-Google-Smtp-Source: APXvYqxw4rcPhUQYF+Z2qcbeF69ICHrw1KkopL29Ae/m4A+amiYDp7quyR+wH+qWvjz33ITblfgEsA==
X-Received: by 2002:a17:902:b687:: with SMTP id c7mr11285749pls.116.1571860981357;
        Wed, 23 Oct 2019 13:03:01 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id 6sm10593598pfy.43.2019.10.23.13.03.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 13:03:00 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH v6 14/15] software node: remove separate handling of references
Date:   Wed, 23 Oct 2019 13:02:32 -0700
Message-Id: <20191023200233.86616-15-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.23.0.866.gb869b98d4c-goog
In-Reply-To: <20191023200233.86616-1-dmitry.torokhov@gmail.com>
References: <20191023200233.86616-1-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Now that all users of references have moved to reference properties,
we can remove separate handling of references.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/base/swnode.c    | 46 +++++++++++++++-------------------------
 include/linux/property.h | 14 ------------
 2 files changed, 17 insertions(+), 43 deletions(-)

diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index 8fb4dd532433..87c715648eb6 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -497,9 +497,8 @@ software_node_get_reference_args(const struct fwnode_handle *fwnode,
 				 struct fwnode_reference_args *args)
 {
 	struct swnode *swnode = to_swnode(fwnode);
-	const struct software_node_reference *ref;
 	const struct software_node_ref_args *ref_array;
-	const struct software_node_ref_args *ref_args;
+	const struct software_node_ref_args *ref;
 	const struct property_entry *prop;
 	struct fwnode_handle *refnode;
 	int i;
@@ -508,37 +507,26 @@ software_node_get_reference_args(const struct fwnode_handle *fwnode,
 		return -ENOENT;
 
 	prop = property_entry_get(swnode->node->properties, propname);
-	if (prop) {
-		if (prop->type != DEV_PROP_REF)
-			return -EINVAL;
-
-		/*
-		 * We expect that references are never stored inline, even
-		 * single ones, as they are too big.
-		 */
-		if (prop->is_inline)
-			return -EINVAL;
-
-		if (index * sizeof(*ref_args) >= prop->length)
-			return -ENOENT;
+	if (!prop)
+		return -ENOENT;
 
-		ref_array = prop->pointer;
-		ref_args = &ref_array[index];
-	} else {
-		if (!swnode->node->references)
-			return -ENOENT;
+	if (prop->type != DEV_PROP_REF)
+		return -EINVAL;
 
-		for (ref = swnode->node->references; ref->name; ref++)
-			if (!strcmp(ref->name, propname))
-				break;
+	/*
+	 * We expect that references are never stored inline, even
+	 * single ones, as they are too big.
+	 */
+	if (prop->is_inline)
+		return -EINVAL;
 
-		if (!ref->name || index > (ref->nrefs - 1))
-			return -ENOENT;
+	if (index * sizeof(*ref) >= prop->length)
+		return -ENOENT;
 
-		ref_args = &ref->refs[index];
-	}
+	ref_array = prop->pointer;
+	ref = &ref_array[index];
 
-	refnode = software_node_fwnode(ref_args->node);
+	refnode = software_node_fwnode(ref->node);
 	if (!refnode)
 		return -ENOENT;
 
@@ -557,7 +545,7 @@ software_node_get_reference_args(const struct fwnode_handle *fwnode,
 	args->nargs = nargs;
 
 	for (i = 0; i < nargs; i++)
-		args->args[i] = ref_args->args[i];
+		args->args[i] = ref->args[i];
 
 	return 0;
 }
diff --git a/include/linux/property.h b/include/linux/property.h
index 68655c094b39..b315fdc0ec28 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -418,30 +418,16 @@ int fwnode_graph_parse_endpoint(const struct fwnode_handle *fwnode,
 /* -------------------------------------------------------------------------- */
 /* Software fwnode support - when HW description is incomplete or missing */
 
-/**
- * struct software_node_reference - Named software node reference property
- * @name: Name of the property
- * @nrefs: Number of elements in @refs array
- * @refs: Array of references with optional arguments
- */
-struct software_node_reference {
-	const char *name;
-	unsigned int nrefs;
-	const struct software_node_ref_args *refs;
-};
-
 /**
  * struct software_node - Software node description
  * @name: Name of the software node
  * @parent: Parent of the software node
  * @properties: Array of device properties
- * @references: Array of software node reference properties
  */
 struct software_node {
 	const char *name;
 	const struct software_node *parent;
 	const struct property_entry *properties;
-	const struct software_node_reference *references;
 };
 
 bool is_software_node(const struct fwnode_handle *fwnode);
-- 
2.23.0.866.gb869b98d4c-goog

