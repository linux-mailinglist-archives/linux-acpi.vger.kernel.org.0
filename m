Return-Path: <linux-acpi+bounces-16762-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86A90B5570E
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Sep 2025 21:44:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41A02A012B2
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Sep 2025 19:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6195A2E06E4;
	Fri, 12 Sep 2025 19:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FpxyXg7/"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3981E32B7;
	Fri, 12 Sep 2025 19:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757706244; cv=none; b=KC6meQxOtUhbbSL0S9XvAstDuty/xrLRfrIoZSKC7DiZQa/72iMtAnGVDHyIihNyW/Ty1rJqb8PodbtfSz06qC/Rt/4R6XdTk3TiAKKH2h0g6MFdTzrD6Iy8X4soeVKg1JsAOp/YXDwlikEUKDi5nLOpkZXEwLXPLprCsVQqXsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757706244; c=relaxed/simple;
	bh=2ENTkAsq63/G6GtjipV7GBKQnRfquf0TZf+Ow+SQi1I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aV03LrcV/VQaieYLCeNW+e15NlPIg+VAPHkOztPw/48THZOoxpwNW0M5JRs8g23qHfp7PklFXtRAFt7afmpmh6s9kdlKt136QXJWPZfamHjhVxQRFvJcdmS5e+6r1D9IRsxRXUPhUQf/BG7AGqIKDVYqZ9eMPkzRg4wS77oPPlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FpxyXg7/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6610C4CEF4;
	Fri, 12 Sep 2025 19:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757706242;
	bh=2ENTkAsq63/G6GtjipV7GBKQnRfquf0TZf+Ow+SQi1I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FpxyXg7/h2jewjg7E5MtForeStrYBXGuSQnwRiPQEfdpdTqHMQAsuSW1QZETTjWtS
	 yS7a78y1VeRFnRS7VKSN75og2w1pUWG739UZS3+RdDXcReRYFNdH8Z2/clG1/xIrQs
	 6JfJy/Y6iFLDioA99CZ2jZFkYdxcXy0hZ0wGM6w7wGXMfhOWBNHttza3YhVuxQyMTH
	 AsaE+WHA0F8Vn3tzR6iteYwcxe36z7m7dAGlh3FPGA6DSVYg4p3NG6i+z8fuTfNVAn
	 /wHebQmj837CLqzUAWtuMRQpyN76s+lbCfaM9euGcqRnfLximOo/KzyXU40sFfM2xu
	 UiXG/5x9mxGDQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>
Subject:
 [PATCH v1 1/4] ACPI: property: Fix buffer properties extraction for subnodes
Date: Fri, 12 Sep 2025 21:39:52 +0200
Message-ID: <5017964.GXAFRqVoOG@rafael.j.wysocki>
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

The ACPI handle passed to acpi_extract_properties() as the first
argument represents the ACPI namespace scope in which to look for
objects returning buffers associated with buffer properties.

For _DSD objects located immediately under ACPI devices, this handle is
the same as the handle of the device object holding the _DSD, but for
data-only subnodes it is not so.

First of all, data-only subnodes are represented by objects that
cannot hold other objects in their scopes (like control methods).
Therefore a data-only subnode handle cannot be used for completing
relative pathname segments, so the current code in
in acpi_nondev_subnode_extract() passing a data-only subnode handle
to acpi_extract_properties() is invalid.

Moreover, a data-only subnode of device A may be represented by an
object located in the scope of device B (which kind of makes sense,
for instance, if A is a B's child).  In that case, the scope in
question would be the one of device B.  In other words, the scope
mentioned above is the same as the scope used for subnode object
lookup in acpi_nondev_subnode_extract().

Accordingly, rearrange that function to use the same scope for the
extraction of properties and subnode object lookup.

Fixes: 103e10c69c61 ("ACPI: property: Add support for parsing buffer property UUID")
Cc: 6.0+ <stable@vger.kernel.org> # 6.0+
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/property.c |   30 +++++++++++-------------------
 1 file changed, 11 insertions(+), 19 deletions(-)

--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -83,6 +83,7 @@ static bool acpi_nondev_subnode_extract(
 					struct fwnode_handle *parent)
 {
 	struct acpi_data_node *dn;
+	acpi_handle scope = NULL;
 	bool result;
 
 	if (acpi_graph_ignore_port(handle))
@@ -98,27 +99,18 @@ static bool acpi_nondev_subnode_extract(
 	INIT_LIST_HEAD(&dn->data.properties);
 	INIT_LIST_HEAD(&dn->data.subnodes);
 
-	result = acpi_extract_properties(handle, desc, &dn->data);
+	/*
+	 * The scope for the completion of relative pathname segments and
+	 * subnode object lookup is the one of the namespace node (device)
+	 * containing the object that has returned the package.  That is, it's
+	 * the scope of that object's parent device.
+	 */
+	if (handle)
+		acpi_get_parent(handle, &scope);
 
-	if (handle) {
-		acpi_handle scope;
-		acpi_status status;
-
-		/*
-		 * The scope for the subnode object lookup is the one of the
-		 * namespace node (device) containing the object that has
-		 * returned the package.  That is, it's the scope of that
-		 * object's parent.
-		 */
-		status = acpi_get_parent(handle, &scope);
-		if (ACPI_SUCCESS(status)
-		    && acpi_enumerate_nondev_subnodes(scope, desc, &dn->data,
-						      &dn->fwnode))
-			result = true;
-	} else if (acpi_enumerate_nondev_subnodes(NULL, desc, &dn->data,
-						  &dn->fwnode)) {
+	result = acpi_extract_properties(scope, desc, &dn->data);
+	if (acpi_enumerate_nondev_subnodes(scope, desc, &dn->data, &dn->fwnode))
 		result = true;
-	}
 
 	if (result) {
 		dn->handle = handle;




