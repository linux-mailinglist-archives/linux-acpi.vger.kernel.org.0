Return-Path: <linux-acpi+bounces-16960-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66855B584A0
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Sep 2025 20:30:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 342811A26227
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Sep 2025 18:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1239B30E0F2;
	Mon, 15 Sep 2025 18:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H//rDNaR"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06B83054C4;
	Mon, 15 Sep 2025 18:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757961022; cv=none; b=uCFSOd1EAgIdtWgXytgSPihFTQbIfBVAIgpXZoNi2CsLaw6mE3/nv02A1zMdeT1qm5Bn1eRZowq0GQoqK9YsCHHDOTw9Qj4LHM4PV7Ru7pp1NRlBimv4Kx6OjXBR+lfqt5CG/KkILOmR75BL8wGHSHVGUJ6ey4S3fX7GSGMbC6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757961022; c=relaxed/simple;
	bh=8N3cQ4n2bZIaOKRMbUA71lc2if/SkIVxW6VuaBEM5Eo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kG7C//XUQICuO5vtdpr5lKZkjGMdMnAg7aLOgkVAfMZEZQ5gsbz0pFTnSUgqOqaNGVITBzlOZaogkgqPNbgTyzY3wsuxZrVBBg+LnQz6Fk4ogY4cFZjHZUvTj9DnH9/59Lbh9SnK5JgnDu5b52ed02Th74uMmFn5qfd8IheN7VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H//rDNaR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0766AC4CEF7;
	Mon, 15 Sep 2025 18:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757961021;
	bh=8N3cQ4n2bZIaOKRMbUA71lc2if/SkIVxW6VuaBEM5Eo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H//rDNaRaI7fB69JkWn9qn4OdN3Xf9zzc5cO2AZ2rA2FcsS8+SGBFyCGiCHctiAbO
	 fm91QAQCfeloIA1tn6KJW0Qvwk2yBNWD/bNDoInVjkCud7ooowZY63rIw1FIubqL9Z
	 N2kACJ2/yfXzKUtpSXn9P+TYV91NuW42ubGv+9Rirn8/FUT1WZ+AuiCITtW6A2y0fy
	 AGAtLtVB2ODrXh1QARv7kO/G5lTQOLnM5EOSNdeber0hwu3s0AO5pegj1eJvF15Kca
	 wAO2cG5TbnsD1GroLvYbk0U+UZcuXiO43zSqqwYKELMXmgx3dq/FgzTWKK98zeJkRb
	 vZxHlqmzSr2+Q==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>
Subject:
 [PATCH v2 2/5] ACPI: property: Disregard references in data-only subnode
 lists
Date: Mon, 15 Sep 2025 20:23:28 +0200
Message-ID: <2237009.irdbgypaU6@rafael.j.wysocki>
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

Data-only subnode links following the ACPI data subnode GUID in a _DSD
package are expected to point to named objects returning _DSD-equivalent
packages.  If a reference to such an object is used in the target field
of any of those links, that object will be evaluated in place (as a
named object) and its return data will be embedded in the outer _DSD
package.

For this reason, it is not expected to see a subnode link with the
target field containing a local reference (that would mean pointing
to a device or another object that cannot be evaluated in place and
therefore cannot return a _DSD-equivalent package).

Accordingly, simplify the code parsing data-only subnode links to
simply print a message when it encounters a local reference in the
target field of one of those links.

Moreover, since acpi_nondev_subnode_data_ok() would only have one
caller after the change above, fold it into that caller.

Link: https://lore.kernel.org/linux-acpi/CAJZ5v0jVeSrDO6hrZhKgRZrH=FpGD4vNUjFD8hV9WwN9TLHjzQ@mail.gmail.com/
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v2: New patch

---
 drivers/acpi/property.c |   51 ++++++++++++++++++++----------------------------
 1 file changed, 22 insertions(+), 29 deletions(-)

--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -124,32 +124,12 @@ static bool acpi_nondev_subnode_extract(
 	return false;
 }
 
-static bool acpi_nondev_subnode_data_ok(acpi_handle handle,
-					const union acpi_object *link,
-					struct list_head *list,
-					struct fwnode_handle *parent)
-{
-	struct acpi_buffer buf = { ACPI_ALLOCATE_BUFFER };
-	acpi_status status;
-
-	status = acpi_evaluate_object_typed(handle, NULL, NULL, &buf,
-					    ACPI_TYPE_PACKAGE);
-	if (ACPI_FAILURE(status))
-		return false;
-
-	if (acpi_nondev_subnode_extract(buf.pointer, handle, link, list,
-					parent))
-		return true;
-
-	ACPI_FREE(buf.pointer);
-	return false;
-}
-
 static bool acpi_nondev_subnode_ok(acpi_handle scope,
 				   const union acpi_object *link,
 				   struct list_head *list,
 				   struct fwnode_handle *parent)
 {
+	struct acpi_buffer buf = { ACPI_ALLOCATE_BUFFER };
 	acpi_handle handle;
 	acpi_status status;
 
@@ -161,7 +141,17 @@ static bool acpi_nondev_subnode_ok(acpi_
 	if (ACPI_FAILURE(status))
 		return false;
 
-	return acpi_nondev_subnode_data_ok(handle, link, list, parent);
+	status = acpi_evaluate_object_typed(handle, NULL, NULL, &buf,
+					    ACPI_TYPE_PACKAGE);
+	if (ACPI_FAILURE(status))
+		return false;
+
+	if (acpi_nondev_subnode_extract(buf.pointer, handle, link, list,
+					parent))
+		return true;
+
+	ACPI_FREE(buf.pointer);
+	return false;
 }
 
 static bool acpi_add_nondev_subnodes(acpi_handle scope,
@@ -174,7 +164,6 @@ static bool acpi_add_nondev_subnodes(acp
 
 	for (i = 0; i < links->package.count; i++) {
 		union acpi_object *link, *desc;
-		acpi_handle handle;
 		bool result;
 
 		link = &links->package.elements[i];
@@ -186,22 +175,26 @@ static bool acpi_add_nondev_subnodes(acp
 		if (link->package.elements[0].type != ACPI_TYPE_STRING)
 			continue;
 
-		/* The second one may be a string, a reference or a package. */
+		/* The second one may be a string or a package. */
 		switch (link->package.elements[1].type) {
 		case ACPI_TYPE_STRING:
 			result = acpi_nondev_subnode_ok(scope, link, list,
 							 parent);
 			break;
-		case ACPI_TYPE_LOCAL_REFERENCE:
-			handle = link->package.elements[1].reference.handle;
-			result = acpi_nondev_subnode_data_ok(handle, link, list,
-							     parent);
-			break;
 		case ACPI_TYPE_PACKAGE:
 			desc = &link->package.elements[1];
 			result = acpi_nondev_subnode_extract(desc, NULL, link,
 							     list, parent);
 			break;
+		case ACPI_TYPE_LOCAL_REFERENCE:
+			/*
+			 * It is not expected to see any local references in
+			 * the links package because referencing a named object
+			 * should cause it to be evaluated in place.
+			 */
+			acpi_handle_info(scope, "subnode %s: Unexpected reference\n",
+					 link->package.elements[0].string.pointer);
+			fallthrough;
 		default:
 			result = false;
 			break;




