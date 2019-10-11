Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4B8BD4A9C
	for <lists+linux-acpi@lfdr.de>; Sat, 12 Oct 2019 01:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728230AbfJKXHs (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 11 Oct 2019 19:07:48 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38977 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728209AbfJKXHq (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 11 Oct 2019 19:07:46 -0400
Received: by mail-pg1-f196.google.com with SMTP id e1so6611813pgj.6;
        Fri, 11 Oct 2019 16:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S0//uf0M37JZw3nISBvezCORU54B4ZZcLP9zD7cFu34=;
        b=pC0LY6U/44gpmU6UUdSKZ9hNbdX8XXx2aDAnQiDTvUbEHGMtEWH+zjvk/M1Fyyy9Uu
         xmwZW4Z9rhpzRoU3FjmHFis9MTRtqwiih6//B2XJKnJaQrnfwvbt/XhyfoB8MjpPCGO6
         im7v6KeOh5samYuQW4qSthXnynnvTej/HiybhKjTvY6/lZnqWnzk9VMYo1NuH9vfhofK
         AGQF0K6MP0OnOVKLhMcZT06M1JO80M7jte1K0A06hoKVy1OAZrWEEi5Soh/A2Iq7eLoP
         sHx1C5KCtDWf9WHyyKkV/VH2X/+saF+w42bAh//w5CI5ufKLMYlz7fkTDIKiycjQE2z3
         Ebgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S0//uf0M37JZw3nISBvezCORU54B4ZZcLP9zD7cFu34=;
        b=iH7cBjV3Ea2yvLMwKiTYlwuGj7ZjmFr7RVfB20ZMl0gyPdIriEYmRibzb9SQ8rfYj1
         k0Fl+Qrr+BwGcgRAm4aSYfYoLL1psAoau3Q+p/hGJZVdLJi7DcXBU9+n/xnhh0CvpH7X
         efSpAXlDEsgSkBih+cZQloI46uPO76RCK6ykUba7eX3ZjyXoJ9PXrbXrvHTan7bIJByU
         w7m5jYh6GRMlWrr0s1gxpjPT+bQzGK86EkUuo8O3fNvi2eRTmd8EmJfU2iKebV26MGv9
         PwsnDObta2r00F3SEIgKcNeflFKjAw7qUp1wXMQpTBsVS5kty7PMadY2NPHt9zOnjCyx
         3zxQ==
X-Gm-Message-State: APjAAAUpF6acDDB5v96KDdmAoWsUl17N3ctivAB9E2DrkJglD9MIKQOo
        3RyQLUFvDOIDIFvOps8+UvZxOvKP
X-Google-Smtp-Source: APXvYqz/TR8uDeeYkhJAxOu1rC6UATHW4Lrnd0hhlLSi5qIrvJirjHPF8WSDaOTCRaZDRVJ+X/YTjw==
X-Received: by 2002:a17:90a:19c1:: with SMTP id 1mr20378906pjj.52.1570835264154;
        Fri, 11 Oct 2019 16:07:44 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id w2sm11529251pfn.57.2019.10.11.16.07.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 16:07:42 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH v5 14/14] software node: remove separate handling of references
Date:   Fri, 11 Oct 2019 16:07:21 -0700
Message-Id: <20191011230721.206646-15-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.23.0.700.g56cf767bdb-goog
In-Reply-To: <20191011230721.206646-1-dmitry.torokhov@gmail.com>
References: <20191011230721.206646-1-dmitry.torokhov@gmail.com>
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
index a5b592a4e956..4cb62cd105db 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -465,9 +465,8 @@ software_node_get_reference_args(const struct fwnode_handle *fwnode,
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
@@ -476,37 +475,26 @@ software_node_get_reference_args(const struct fwnode_handle *fwnode,
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
 
@@ -525,7 +513,7 @@ software_node_get_reference_args(const struct fwnode_handle *fwnode,
 	args->nargs = nargs;
 
 	for (i = 0; i < nargs; i++)
-		args->args[i] = ref_args->args[i];
+		args->args[i] = ref->args[i];
 
 	return 0;
 }
diff --git a/include/linux/property.h b/include/linux/property.h
index 08d3e9d126ef..fa5a2ddc0c7b 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -412,30 +412,16 @@ int fwnode_graph_parse_endpoint(const struct fwnode_handle *fwnode,
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
2.23.0.700.g56cf767bdb-goog

