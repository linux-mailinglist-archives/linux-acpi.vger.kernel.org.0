Return-Path: <linux-acpi+bounces-16761-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A714DB5570C
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Sep 2025 21:44:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0607A1D65228
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Sep 2025 19:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9CB6335BC4;
	Fri, 12 Sep 2025 19:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RifUejSv"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FEF5335BBF;
	Fri, 12 Sep 2025 19:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757706239; cv=none; b=i7dSC/LTJoveFFw/czbkIxODVCKc838biSSoXxRlaW/VqcV3d/9yDervF8O0A9xM5NCIP2AB/aBBYOdL0tLtyLscsVhEKyL5N94ULju5tyDV7q4FdRqHX9FS0SmLviCmYHobcOBWJo1+MOhb8agyW6Ne19h4t8t+tqJtj88GPuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757706239; c=relaxed/simple;
	bh=Twdx3/SnajCQAPtUtUGLkJDR+nHetYXoHKGVxK5EVUE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RkzSLmzjWPXQNfQBUc3m+v2/gIMW8tkeW/tAoBp1KOTzVJEIZgJ6BASjCgnBzPiBYI08oh/ksxN993Xo92Yxsvi+6q0agoXKmheD4ZYnjacvDd9mSkBV1DKYUVs+m+EWAQ53jk+3ONxaTruEcqk+nv8gtNwAjZxkT29uw5ws/LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RifUejSv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61B36C4CEF4;
	Fri, 12 Sep 2025 19:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757706239;
	bh=Twdx3/SnajCQAPtUtUGLkJDR+nHetYXoHKGVxK5EVUE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RifUejSvDMF59+gxD94rO/B7pM3YbYjZgOgzrphApQm1JclTWUqSeXlM8r7kWOYYo
	 5U2yu0vMCowtmh8QYh6jlxe/D+WDJh31ecu1lRpX0zf6mI1iaKhLMS+pmnICW2v2fj
	 NAwXJVt/Cs/OiT6VdxmguwVQ4rkzWFM1Uw2q7O3HnjSCRqbMSED3nA9zTwCnlt2RLF
	 STto2Yp9KBT8f5lplCqA+WAjA3vD9T9DKpnD0wPr97sBAfcM68ofs5tPI3fE6Jb3MK
	 WClf8KHj3kToJGv8EU79BPctcSwnAqpzkmuOLH8xBgNTN6BAftzURvx1+JqpKGJhNf
	 Z5//qg5U7eFNQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>
Subject:
 [PATCH v1 2/4] ACPI: property: Add code comments explaining what is going on
Date: Fri, 12 Sep 2025 21:40:58 +0200
Message-ID: <2243680.irdbgypaU6@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <5046661.31r3eYUQgx@rafael.j.wysocki>
References: <5046661.31r3eYUQgx@rafael.j.wysocki>
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
and some pieces of code are based on experience that is not mentioned
anywhere.

Add code comments explaining these things.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/property.c |   51 ++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 49 insertions(+), 2 deletions(-)

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
 
@@ -153,6 +164,12 @@ static bool acpi_nondev_subnode_ok(acpi_
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
 
@@ -172,6 +189,10 @@ static bool acpi_add_nondev_subnodes(acp
 	bool ret = false;
 	int i;
 
+	/*
+	 * Every element in the links package is expected to represent a link
+	 * to a non-device node in a tree containing device-specific data.
+	 */
 	for (i = 0; i < links->package.count; i++) {
 		union acpi_object *link, *desc;
 		acpi_handle handle;
@@ -182,22 +203,48 @@ static bool acpi_add_nondev_subnodes(acp
 		if (link->package.count != 2)
 			continue;
 
-		/* The first one must be a string. */
+		/* The first one (the key) must be a string. */
 		if (link->package.elements[0].type != ACPI_TYPE_STRING)
 			continue;
 
-		/* The second one may be a string, a reference or a package. */
+		/*
+		 * The second one (the target) may be a string, a reference or
+		 * a package.
+		 */
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
 		case ACPI_TYPE_LOCAL_REFERENCE:
+			/*
+			 * The reference is expected to point to an object
+			 * returning a package that contains _DSD-equivalent
+			 * information.
+			 */
 			handle = link->package.elements[1].reference.handle;
 			result = acpi_nondev_subnode_data_ok(handle, link, list,
 							     parent);
 			break;
 		case ACPI_TYPE_PACKAGE:
+			/*
+			 * This happens when the target package is embedded
+			 * within the links package as a result of direct
+			 * evaluation of an object pointed to by a reference.
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




