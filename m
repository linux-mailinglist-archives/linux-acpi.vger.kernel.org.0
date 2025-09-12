Return-Path: <linux-acpi+bounces-16760-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C55EB5570A
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Sep 2025 21:44:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEA831D6528A
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Sep 2025 19:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC74532BF38;
	Fri, 12 Sep 2025 19:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CPAlQieN"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1988327A2E;
	Fri, 12 Sep 2025 19:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757706236; cv=none; b=LEplV7jhQCc2C3wEsPu+TYVUaT8VNdBwuWU64slWuSGZPWeX5LbQJbInrfiVh8HuHkSL49RgEB+1Yqxht/vhFLseBx2FBu+gy1BSXtLsi8KVs2U9vgEbIJcr+RTYP6SD0jubQBi+RIR18wcd/8VO8QbxYQQ58z4onzfo5nfYGzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757706236; c=relaxed/simple;
	bh=wYP2/RHa5oRDrnM6dzMcTKRuYwJA2aMW68L266yjqf0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q7H+D6zls6X63SEp6vRX87ISAXveWbXbMA4gbhRd5hJQ/XNcewdzLQMB8txDXuvAEUqM2VNmezo8CCGolblodhklPVF7IIjUIfUOT0k6u01Q7Yt9OX4lMTVCwiSoPwEThTgkQe/ZDVR9cAWDUONji4XI8z0/eZbZWKE1DrW85s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CPAlQieN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2653AC4CEF1;
	Fri, 12 Sep 2025 19:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757706236;
	bh=wYP2/RHa5oRDrnM6dzMcTKRuYwJA2aMW68L266yjqf0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CPAlQieNOL5Duemph/YE7itZbpwr9qgV859bisKW51SiCyI+bf2gJgEE0MiRYDOzG
	 muX2IKLhYJI570IpinfAAVNR7Rb6Xoz4LY+XprX8KhgNhXxJhtXd2gqOWCoYAucLdK
	 hfAfcqsT68S/h9MW+W916gUXec45oN7g5m3nNgQuZihb1K2c9Yjt9lCbONaKyO3qIU
	 NsEXQIOM8PmBX1RWSU+uD7xdK1Q9AVGeJ81OzKufQSEAQXypL8+ylbTbM4n38djfqu
	 xPDrEKPKWasYx813bZVpDQ9WxZTRqP8IdicoLfbNfUk/G8xYEq0hNoEsncBmii89H7
	 sSE6QkSl5wZgQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>
Subject:
 [PATCH v1 3/4] ACPI: property: Do not pass NULL handles to acpi_attach_data()
Date: Fri, 12 Sep 2025 21:42:55 +0200
Message-ID: <3014880.e9J7NaK4W3@rafael.j.wysocki>
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

In certain circumstances, the ACPI handle of a data-only node may be
NULL, in which case it does not make sense to attempt to attach that
node to an ACPI namespace object, so update the code to avoid attempts
to do so.

This prevents confusing and unuseful error messages from being printed.

Also document the fact that the ACPI handle of a data-only node may be
NULL, and when that happens, in a code comment.

In addition, make acpi_add_nondev_subnodes() print a diagnostic message
for each data-only node with an unknown ACPI namespace scope.

Fixes: 1d52f10917a7 ("ACPI: property: Tie data nodes to acpi handles")
Cc: 6.0+ <stable@vger.kernel.org> # 6.0+
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/property.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -124,6 +124,10 @@ static bool acpi_nondev_subnode_extract(
 		result = true;
 
 	if (result) {
+		/*
+		 * This will be NULL if the desc package is embedded in an outer
+		 * _DSD-equivalent package and its scope cannot be determined.
+		 */
 		dn->handle = handle;
 		dn->data.pointer = desc;
 		list_add_tail(&dn->sibling, list);
@@ -245,6 +249,8 @@ static bool acpi_add_nondev_subnodes(acp
 			 * strings because there is no way to build full
 			 * pathnames out of them.
 			 */
+			acpi_handle_info(scope, "Unknown namespace scope of node %s\n",
+					 link->package.elements[0].string.pointer);
 			desc = &link->package.elements[1];
 			result = acpi_nondev_subnode_extract(desc, NULL, link,
 							     list, parent);
@@ -408,6 +414,9 @@ static void acpi_untie_nondev_subnodes(s
 	struct acpi_data_node *dn;
 
 	list_for_each_entry(dn, &data->subnodes, sibling) {
+		if (!dn->handle)
+			continue;
+
 		acpi_detach_data(dn->handle, acpi_nondev_subnode_tag);
 
 		acpi_untie_nondev_subnodes(&dn->data);
@@ -422,6 +431,9 @@ static bool acpi_tie_nondev_subnodes(str
 		acpi_status status;
 		bool ret;
 
+		if (!dn->handle)
+			continue;
+
 		status = acpi_attach_data(dn->handle, acpi_nondev_subnode_tag, dn);
 		if (ACPI_FAILURE(status) && status != AE_ALREADY_EXISTS) {
 			acpi_handle_err(dn->handle, "Can't tag data node\n");




