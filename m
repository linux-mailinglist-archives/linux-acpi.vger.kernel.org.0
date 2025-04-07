Return-Path: <linux-acpi+bounces-12831-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A054FA7F061
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Apr 2025 00:37:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8232C17B69B
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Apr 2025 22:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 618C22248BA;
	Mon,  7 Apr 2025 22:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="E/gjyn3e"
X-Original-To: linux-acpi@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC64223705;
	Mon,  7 Apr 2025 22:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744065447; cv=none; b=D9C1FNbNGE6ikSY8MaNmJ+ICbOqsv9L2miI6F0AmNb+L5pDnGyvvPCtIchPDdAmIae30ETLQPyMsJSIITRiJm/QuEgaGYtyB8/L6JbbDhlHv1kGUk9pdOagbxkKpnYTD2BUGmy4SizQb2ej9KFZNox2ej/9BIhQqUMHkwwGOUqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744065447; c=relaxed/simple;
	bh=MQM1kmIoyeIPIvXSo+fdLdzfUuOIRsInGoIf6OY/FxA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U58ULh+mvydRIlbIZ6MsPwPVAhZl7ZA0UaE0dlTG0iNgEG3IHIVIETpGJKAz4Xdyls17crri9/8Kqx5kbe2l0cYHzChrVoFQjMNS9IxywhmZI+CzNGKZ1DD/28E6E35/jee/ImsEGza8KURuigf1WlKA23dGUV7/cdYEaaWzYis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=E/gjyn3e; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1744065443;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0XQwgBGUl+kN6A+/kOzVZipYCaxZjyIp9j83vL3Yths=;
	b=E/gjyn3eXJgs6JaLMvFqLeCUH5QHFYamcevGa6Rr4uF4/gIcHmdh1mHQsIne5nw1xa7BZq
	XkcMcI+hIjtFacsTC3HG80QvRF75Dif0ywvGrW9uzwAgHqWt6IrmZXDZb15KZJnIpo60fM
	GWzH3uDint/eKFdS3qez3rZrj0hW31o=
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
Subject: [PATCH 1/2] device property: Add optional nargs_prop for get_reference_args
Date: Mon,  7 Apr 2025 18:37:13 -0400
Message-Id: <20250407223714.2287202-2-sean.anderson@linux.dev>
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

get_reference_args does not permit falling back to nargs when nargs_prop
is missing. This makes it difficult to support older devicetrees where
nargs_prop may not be present. Add support for this by converting nargs
to a signed value. Where before nargs was ignored if nargs_prop was
passed, now nargs is only ignored if it is strictly negative. When it is
positive, nargs represents the fallback cells to use if nargs_prop is
absent.

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

 drivers/base/property.c |  4 ++--
 drivers/base/swnode.c   | 13 +++++++++----
 drivers/of/property.c   | 10 +++-------
 include/linux/fwnode.h  |  2 +-
 4 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index c1392743df9c..049f8a6088a1 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -606,7 +606,7 @@ int fwnode_property_get_reference_args(const struct fwnode_handle *fwnode,
 		return -ENOENT;
 
 	ret = fwnode_call_int_op(fwnode, get_reference_args, prop, nargs_prop,
-				 nargs, index, args);
+				 nargs_prop ? -1 : nargs, index, args);
 	if (ret == 0)
 		return ret;
 
@@ -614,7 +614,7 @@ int fwnode_property_get_reference_args(const struct fwnode_handle *fwnode,
 		return ret;
 
 	return fwnode_call_int_op(fwnode->secondary, get_reference_args, prop, nargs_prop,
-				  nargs, index, args);
+				  nargs_prop ? -1 : nargs, index, args);
 }
 EXPORT_SYMBOL_GPL(fwnode_property_get_reference_args);
 
diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index b1726a3515f6..11af2001478f 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -503,7 +503,7 @@ software_node_get_named_child_node(const struct fwnode_handle *fwnode,
 static int
 software_node_get_reference_args(const struct fwnode_handle *fwnode,
 				 const char *propname, const char *nargs_prop,
-				 unsigned int nargs, unsigned int index,
+				 int nargs, unsigned int index,
 				 struct fwnode_reference_args *args)
 {
 	struct swnode *swnode = to_swnode(fwnode);
@@ -543,10 +543,15 @@ software_node_get_reference_args(const struct fwnode_handle *fwnode,
 		error = property_entry_read_int_array(ref->node->properties,
 						      nargs_prop, sizeof(u32),
 						      &nargs_prop_val, 1);
-		if (error)
+
+		if (error == -EINVAL) {
+			if (nargs < 0)
+				return error;
+		} else if (error) {
 			return error;
-
-		nargs = nargs_prop_val;
+		} else {
+			nargs = nargs_prop_val;
+		}
 	}
 
 	if (nargs > NR_FWNODE_REFERENCE_ARGS)
diff --git a/drivers/of/property.c b/drivers/of/property.c
index c1feb631e383..c41190e47111 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -1116,19 +1116,15 @@ of_fwnode_get_named_child_node(const struct fwnode_handle *fwnode,
 static int
 of_fwnode_get_reference_args(const struct fwnode_handle *fwnode,
 			     const char *prop, const char *nargs_prop,
-			     unsigned int nargs, unsigned int index,
+			     int nargs, unsigned int index,
 			     struct fwnode_reference_args *args)
 {
 	struct of_phandle_args of_args;
 	unsigned int i;
 	int ret;
 
-	if (nargs_prop)
-		ret = of_parse_phandle_with_args(to_of_node(fwnode), prop,
-						 nargs_prop, index, &of_args);
-	else
-		ret = of_parse_phandle_with_fixed_args(to_of_node(fwnode), prop,
-						       nargs, index, &of_args);
+	ret = __of_parse_phandle_with_args(to_of_node(fwnode), prop, nargs_prop,
+					   nargs, index, &of_args);
 	if (ret < 0)
 		return ret;
 	if (!args) {
diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
index 6fa0a268d538..69fe44c68f8c 100644
--- a/include/linux/fwnode.h
+++ b/include/linux/fwnode.h
@@ -163,7 +163,7 @@ struct fwnode_operations {
 				const char *name);
 	int (*get_reference_args)(const struct fwnode_handle *fwnode,
 				  const char *prop, const char *nargs_prop,
-				  unsigned int nargs, unsigned int index,
+				  int nargs, unsigned int index,
 				  struct fwnode_reference_args *args);
 	struct fwnode_handle *
 	(*graph_get_next_endpoint)(const struct fwnode_handle *fwnode,
-- 
2.35.1.1320.gc452695387.dirty


