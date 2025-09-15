Return-Path: <linux-acpi+bounces-16959-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B4B8B5849F
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Sep 2025 20:30:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98E313BF795
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Sep 2025 18:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEC3B313296;
	Mon, 15 Sep 2025 18:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WqWSpndJ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876E230CD95;
	Mon, 15 Sep 2025 18:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757961017; cv=none; b=LVfWMM+RQS7MyxtBbLmoZT6bqbmssufIe4kwJBjAQwv9KRDpeI8J4kTH2o/uN9H/vDNvsw6naGw4w8fC23h0ifvo5NhvISHiSNbooUKVG9WApU0bvb6ZtsKJe9MaHSOJbG/Q31ohB5vFpz5/LcSjQcDY7gXfTZj+R+xCNvf4PQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757961017; c=relaxed/simple;
	bh=WGVvkUpHbJrKqCuo2vUXTzTO+Jv4JiDs/XNg/A33U+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LjWuwY9HeK87L+3TGc0Xk1qncJ4PR1mN0wzOQpGA9EvcS7UAdjQpRbc6RQ2CcITGIqT0qR5M4WGBaS7UnzQAPyiXYVQ+gMSogQfMU1VtGdQkrkVTDZvqm6yBS8F54SW3hhok7rQZYpXyVk5ylMqpDDynfMzlwXh1tkCJaRuIgWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WqWSpndJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD4A0C4CEF7;
	Mon, 15 Sep 2025 18:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757961017;
	bh=WGVvkUpHbJrKqCuo2vUXTzTO+Jv4JiDs/XNg/A33U+A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WqWSpndJe1MVmR4pLgKi5jpBjouTH7LVyMrETWcnDoX44XOAoTWjWhItYeq5nWV9C
	 7kKBUiK/jOvTquW20rNG7x58xcleYxQv4yXpMeMZZI6uLZCrTy7PqRqCHdNwGl0atr
	 2aJLQHNjmWM0+rdEozbfqoY7X2nI48vdcAAnDstBmvBJIjzBCZd8nVzEEpLTw2Cca5
	 R60b+HQMIFjtN6yJSeywUZFUevmrS9YiirvbPMpqLrU77WtjJUc5yGe08ppMwOxlM7
	 Zdl/g5m24UQ6+DXrgvKhbaf5byfDcPRP+ZtxLMXhQ3mo8aGicOwYv5+TPVaMUuagrj
	 tF2nn5hdc2VcA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>
Subject:
 [PATCH v2 3/5] ACPI: property: Add code comments explaining what is going on
Date: Mon, 15 Sep 2025 20:25:13 +0200
Message-ID: <3008321.e9J7NaK4W3@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <5922318.DvuYhMxLoT@rafael.j.wysocki>
References: <5922318.DvuYhMxLoT@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

In some places in the ACPI device properties handling code, it is
unclear why the code is what it is.  Some assumptions are not documented
and some pieces of code are based on knowledge that is not mentioned
anywhere.

Add code comments explaining these things.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v2:
   * Previously [2/4]
   * Rebase on top of the new [2/5]
   * Rephrase the comment under ACPI_TYPE_PACKAGE

---
 drivers/acpi/property.c |   46 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 44 insertions(+), 2 deletions(-)

--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -108,7 +108,18 @@ static bool acpi_nondev_subnode_extract(
 	if (handle)
 		acpi_get_parent(handle, &scope);
 
+	/*
+	 * Extract properties from the _DSD-equivalent package pointed to by
+	 * desc and use scope (if not NULL) for the completion of relative
+	 * pathname segments.
+	 *
+	 * The extracted properties will be held in the new data node dn.
+	 */
 	result = acpi_extract_properties(scope, desc, &dn->data);
+	/*
+	 * Look for subnodes in the _DSD-equivalent package pointed to by desc
+	 * and create child nodes of dn if there are any.
+	 */
 	if (acpi_enumerate_nondev_subnodes(scope, desc, &dn->data, &dn->fwnode))
 		result = true;
 
@@ -133,6 +144,12 @@ static bool acpi_nondev_subnode_ok(acpi_
 	acpi_handle handle;
 	acpi_status status;
 
+	/*
+	 * If the scope is unknown, the _DSD-equivalent package being parsed
+	 * was embedded in an outer _DSD-equivalent package as a result of
+	 * direct evaluation of an object pointed to by a reference.  In that
+	 * case, using a pathname as the target object pointer is invalid.
+	 */
 	if (!scope)
 		return false;
 
@@ -162,6 +179,10 @@ static bool acpi_add_nondev_subnodes(acp
 	bool ret = false;
 	int i;
 
+	/*
+	 * Every element in the links package is expected to represent a link
+	 * to a non-device node in a tree containing device-specific data.
+	 */
 	for (i = 0; i < links->package.count; i++) {
 		union acpi_object *link, *desc;
 		bool result;
@@ -171,17 +192,38 @@ static bool acpi_add_nondev_subnodes(acp
 		if (link->package.count != 2)
 			continue;
 
-		/* The first one must be a string. */
+		/* The first one (the key) must be a string. */
 		if (link->package.elements[0].type != ACPI_TYPE_STRING)
 			continue;
 
-		/* The second one may be a string or a package. */
+		/* The second one (the target) may be a string or a package. */
 		switch (link->package.elements[1].type) {
 		case ACPI_TYPE_STRING:
+			/*
+			 * The string is expected to be a full pathname or a
+			 * pathname segment relative to the given scope.  That
+			 * pathname is expected to point to an object returning
+			 * a package that contains _DSD-equivalent information.
+			 */
 			result = acpi_nondev_subnode_ok(scope, link, list,
 							 parent);
 			break;
 		case ACPI_TYPE_PACKAGE:
+			/*
+			 * This happens when a reference is used in AML to
+			 * point to the target.  Since the target is expected
+			 * to be a named object, a reference to it will cause it
+			 * to be avaluated in place and its return package will
+			 * be embedded in the links package at the location of
+			 * the reference.
+			 *
+			 * The target package is expected to contain _DSD-
+			 * equivalent information, but the scope in which it
+			 * is located in the original AML is unknown.  Thus
+			 * it cannot contain pathname segments represented as
+			 * strings because there is no way to build full
+			 * pathnames out of them.
+			 */
 			desc = &link->package.elements[1];
 			result = acpi_nondev_subnode_extract(desc, NULL, link,
 							     list, parent);




