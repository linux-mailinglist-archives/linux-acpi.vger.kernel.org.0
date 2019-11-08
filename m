Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C25DBF3CB7
	for <lists+linux-acpi@lfdr.de>; Fri,  8 Nov 2019 01:18:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728525AbfKHASP (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 7 Nov 2019 19:18:15 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33203 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727952AbfKHASP (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Nov 2019 19:18:15 -0500
Received: by mail-pf1-f193.google.com with SMTP id c184so3582001pfb.0;
        Thu, 07 Nov 2019 16:18:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sO4aD46q4EABKrP8LLceQDRZ7MVOUHaHnUQ8y0rtL9Y=;
        b=DZteuO4dO6HC0iWYzGecKtBwbz+Ti0PhyrEmcm1ixpTPcUJmtEuwtSX2c8LRVE8E/E
         01aSxI2dxx2oFO+rueFP4D5BsopkSlD96l2H0WFoMf7R4pKh7Fcx6Vbo+L1Nu95p9Eef
         xxgnt7XvdGoOEyqNztQqTsgi4u2GGciwQVom+cbzVrBExXPhE0SE2mSFcikNWzliJGhA
         NJ8KNMi0ED3ybi/N4NZNnaVApOnTaj6AmoeSjn+oEC6iMW1nDKMLpLd99alUxaLieQPg
         /vN04MpTnGXlIulhXL7ik88an6buowdVMwmq5FHqcTl174GZxvm3TjCZksRXfEOmwemF
         4dVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sO4aD46q4EABKrP8LLceQDRZ7MVOUHaHnUQ8y0rtL9Y=;
        b=Da5nec960RDEB5brizCgrORZaBCGQPImphoCJMtPA+1JcD83+9UxGoNNkrK5eMCWwg
         M2OfTyjVpNBK36VcC74JGieIP1jMStFuTltpLwR1rwdxEt1bLvYH4dXBfYmvym8i+QLO
         FAbdy20QXoV8NHT87jjgLrM7gyUIQ0SF0X253hJHJbmADZ/ysXSQkv2QxTiIa4lgGXO0
         +EOj2zzcCM/lpveOwvd0c5VfwIxDqyCSWr+j+Nv2OUS1XCIfgprHEp3k69WSWjARMrDC
         WSG182BxlO+IqV4rpXWUaZjdh24KU5iNIumygRiwHTxYEeie+6o0Sz52wzRigzPOLUtE
         JdAw==
X-Gm-Message-State: APjAAAUIMFW4Cj6BPnsXnAF2WuVfqb91Adnm5fevlQ8waE2Ebzf7rZSe
        Vvw6AEU2kBAHxttfBnLcst4=
X-Google-Smtp-Source: APXvYqxs1K+BtG4WBu9yRyUZCztww/N8vv3TtoZzONk82w8sGOP/gL143CV3nkrH6cFEVphiSMEl4Q==
X-Received: by 2002:aa7:9348:: with SMTP id 8mr7798989pfn.135.1573172294043;
        Thu, 07 Nov 2019 16:18:14 -0800 (PST)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id m68sm3688764pfb.122.2019.11.07.16.18.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 16:18:13 -0800 (PST)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH v7 5/6] software node: remove separate handling of references
Date:   Thu,  7 Nov 2019 16:18:02 -0800
Message-Id: <20191108001803.191541-6-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
In-Reply-To: <20191108001803.191541-1-dmitry.torokhov@gmail.com>
References: <20191108001803.191541-1-dmitry.torokhov@gmail.com>
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
index 809146f57aa45..bb6c3c052d23c 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -479,9 +479,8 @@ software_node_get_reference_args(const struct fwnode_handle *fwnode,
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
@@ -490,37 +489,26 @@ software_node_get_reference_args(const struct fwnode_handle *fwnode,
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
 
@@ -539,7 +527,7 @@ software_node_get_reference_args(const struct fwnode_handle *fwnode,
 	args->nargs = nargs;
 
 	for (i = 0; i < nargs; i++)
-		args->args[i] = ref_args->args[i];
+		args->args[i] = ref->args[i];
 
 	return 0;
 }
diff --git a/include/linux/property.h b/include/linux/property.h
index 68655c094b395..b315fdc0ec28d 100644
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
2.24.0.rc1.363.gb1bccd3e3d-goog

