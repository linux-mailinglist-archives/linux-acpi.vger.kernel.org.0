Return-Path: <linux-acpi+bounces-12832-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07AE0A7F066
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Apr 2025 00:38:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4144F3A7E69
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Apr 2025 22:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3778222836C;
	Mon,  7 Apr 2025 22:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cwwfIZJ+"
X-Original-To: linux-acpi@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6260D224AEB
	for <linux-acpi@vger.kernel.org>; Mon,  7 Apr 2025 22:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744065450; cv=none; b=jCv1uudArnKrLI2B7TcDZFB9Zt56fQObdg1EXW2xnta+ytqnme+y7RzC6JJtCkUmPiO5lo6QoDZnJGy3CLmdD/Wtxe3m1EJn1IngoDkA06P94fyXhNAOGi3yuZUkvKVKVgIwE2uftI5WProR/wG6zWgKre/gjv1o9zyD8OoWOmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744065450; c=relaxed/simple;
	bh=0RHjy9Gg6nzpFP22nPWzgOuU/J8PO3od6y/zB6+i40s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=icbOGc3rQJMhrr3/9RTtSKTLVllQSapnB8E2WJDU9+fTBZNXBa/ZL1SFCsUzyPKc0KrILn5AAsaXqt8svBu7ATL3Kk7qGC95kJlyRqKjRaukJ/Qwlfb9na3mI4gu0m0mNCeSR+5Fl8vxSvS+1LajSMM/fn08mOIAtqW2xXvt1jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cwwfIZJ+; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1744065445;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yk2gCjwLaBA+Rjb+sf0kBMe/pJVNSpY8xdwLZOARR5g=;
	b=cwwfIZJ+4EN/MW00GYI3Fqdg3mO0VDqKsbPsoPg7AOsNnOvDNdG/qyiQFr3hU+sobYHOKW
	mODovZPkwgn85/z6YOZTwenjMNG+TEN2bd3FKMmQDUaymcVWhr0LgMX0Ouywls/dqGg0I5
	fhyIE7k+9ott7vlyz3ilQBL9ODOgbNg=
From: Sean Anderson <sean.anderson@linux.dev>
To: Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	devicetree@vger.kernel.org
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Len Brown <lenb@kernel.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	linux-kernel@vger.kernel.org,
	Danilo Krummrich <dakr@kernel.org>,
	linux-acpi@vger.kernel.org,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH 2/2] device property: Add fwnode_property_get_reference_optional_args
Date: Mon,  7 Apr 2025 18:37:14 -0400
Message-Id: <20250407223714.2287202-3-sean.anderson@linux.dev>
In-Reply-To: <20250407223714.2287202-1-sean.anderson@linux.dev>
References: <20250407223714.2287202-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add a fwnode variant of of_parse_phandle_with_optional_args to allow
nargs_prop to be absent from the referenced node. This improves
compatibility for references where the devicetree might not always have
nargs_prop.

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

 drivers/base/property.c  | 46 ++++++++++++++++++++++++++++++++++++++++
 include/linux/property.h |  4 ++++
 2 files changed, 50 insertions(+)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 049f8a6088a1..ef13ca32079b 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -618,6 +618,52 @@ int fwnode_property_get_reference_args(const struct fwnode_handle *fwnode,
 }
 EXPORT_SYMBOL_GPL(fwnode_property_get_reference_args);
 
+/**
+ * fwnode_property_get_reference_optional_args() - Find a reference with optional arguments
+ * @fwnode:	Firmware node where to look for the reference
+ * @prop:	The name of the property
+ * @nargs_prop:	The name of the property telling the number of
+ *		arguments in the referred node.
+ * @index:	Index of the reference, from zero onwards.
+ * @args:	Result structure with reference and integer arguments.
+ *		May be NULL.
+ *
+ * Obtain a reference based on a named property in an fwnode, with
+ * integer arguments. If @nargs_prop is absent from the referenced node, then
+ * number of arguments is be assumed to be 0.
+ *
+ * The caller is responsible for calling fwnode_handle_put() on the returned
+ * @args->fwnode pointer.
+ *
+ * Return: %0 on success
+ *	    %-ENOENT when the index is out of bounds, the index has an empty
+ *		     reference or the property was not found
+ *	    %-EINVAL on parse error
+ */
+int fwnode_property_get_reference_optional_args(const struct fwnode_handle *fwnode,
+						const char *prop,
+						const char *nargs_prop,
+						unsigned int index,
+						struct fwnode_reference_args *args)
+{
+	int ret;
+
+	if (IS_ERR_OR_NULL(fwnode))
+		return -ENOENT;
+
+	ret = fwnode_call_int_op(fwnode, get_reference_args, prop, nargs_prop,
+				 0, index, args);
+	if (ret == 0)
+		return ret;
+
+	if (IS_ERR_OR_NULL(fwnode->secondary))
+		return ret;
+
+	return fwnode_call_int_op(fwnode->secondary, get_reference_args, prop, nargs_prop,
+				  0, index, args);
+}
+EXPORT_SYMBOL_GPL(fwnode_property_get_reference_optional_args);
+
 /**
  * fwnode_find_reference - Find named reference to a fwnode_handle
  * @fwnode: Firmware node where to look for the reference
diff --git a/include/linux/property.h b/include/linux/property.h
index e214ecd241eb..a1662b36d15f 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -139,6 +139,10 @@ int fwnode_property_get_reference_args(const struct fwnode_handle *fwnode,
 				       const char *prop, const char *nargs_prop,
 				       unsigned int nargs, unsigned int index,
 				       struct fwnode_reference_args *args);
+int fwnode_property_get_reference_optional_args(const struct fwnode_handle *fwnode,
+						const char *prop, const char *nargs_prop,
+						unsigned int index,
+						struct fwnode_reference_args *args);
 
 struct fwnode_handle *fwnode_find_reference(const struct fwnode_handle *fwnode,
 					    const char *name,
-- 
2.35.1.1320.gc452695387.dirty


