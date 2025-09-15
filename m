Return-Path: <linux-acpi+bounces-16958-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D3C4B5849C
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Sep 2025 20:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 820BA1A27228
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Sep 2025 18:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E1C0313271;
	Mon, 15 Sep 2025 18:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LsmOQ5L3"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56ACC3064B4;
	Mon, 15 Sep 2025 18:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757961013; cv=none; b=NajhMEmQnobcAocs5k7GuxK9xIf+XlkqE8L6tek3r5FU/JFFHIQ1XbohRm7ih+UuYiSLyIZ5suwAVOcT196Q0vB7E9EclGs+iy2f4x5Mmeibb13NncVHaOHL3yyQyvAaPJN4oADxzWGa2ykrR7kFWtMQ5jn8NKGuMILSipytkhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757961013; c=relaxed/simple;
	bh=PpVc0ofa6DSO9T/pi2noMuQNRfKErz0RqnpeJC76Weg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TEnCzu0iQucyon56paOIau+xv8N604CR2UOtuVSufWk9CD8poPh3lPW8Mlbaxp0zKxvLZ8vDBRLtqU6Obt4RYBH5n+zxYqLSn6J+vKgliCEN01jVcMn4X+Mce7eIiPWb4bl8D7Swiy2Px0XckryfyWz76OicLELMA6Zl5nS8oA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LsmOQ5L3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3115C4CEFA;
	Mon, 15 Sep 2025 18:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757961013;
	bh=PpVc0ofa6DSO9T/pi2noMuQNRfKErz0RqnpeJC76Weg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LsmOQ5L3eZVJU8zoX3n14ShPXX4doLixyVCrah06DGprhSk83nImEpLCUsi6s514/
	 fLRCZajXY01e9firKjgRC5o1S+Dt9y0rwfzY+fKlpeQZIaTjHsX2M5+tl34SMCCgQI
	 Ap99rJK17jymyi/346K5rJkiAVpck4cI3ye2BurfRCcjgo37hgqKWYhW8PItMUoQqn
	 PPnhn1SE1JgHXkUadqZnfjlxf1U+E+HZGtm70Rg3/sYqiYJxVzAGGZXUS927mUl8oQ
	 Mfyl1I0KN0ED44hWj6fNG3v3aAephHqXnEj28f4Az2Yyb3vPP/H2B8JN5iipCHmeZE
	 FxMMgrm2FrUZA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>
Subject:
 [PATCH v2 4/5] ACPI: property: Do not pass NULL handles to acpi_attach_data()
Date: Mon, 15 Sep 2025 20:28:52 +0200
Message-ID: <8578679.T7Z3S40VBb@rafael.j.wysocki>
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

In certain circumstances, the ACPI handle of a data-only node may be
NULL, in which case it does not make sense to attempt to attach that
node to an ACPI namespace object, so update the code to avoid attempts
to do so.

This prevents confusing and unuseful error messages from being printed.

Also document the fact that the ACPI handle of a data-only node may be
NULL and when that happens in a code comment.  In addition, make
acpi_add_nondev_subnodes() print a diagnostic message for each data-only
node with an unknown ACPI namespace scope.

Fixes: 1d52f10917a7 ("ACPI: property: Tie data nodes to acpi handles")
Cc: 6.0+ <stable@vger.kernel.org> # 6.0+
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v2:
   * Previously [3/4]
   * Rebase on top of new [2-3/5]
   * Reformat the "unknown scope" message and downgrade it to "debug" (it
     may not indicate any functional issue)

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
@@ -224,6 +228,8 @@ static bool acpi_add_nondev_subnodes(acp
 			 * strings because there is no way to build full
 			 * pathnames out of them.
 			 */
+			acpi_handle_debug(scope, "subnode %s: Unknown scope\n",
+					  link->package.elements[0].string.pointer);
 			desc = &link->package.elements[1];
 			result = acpi_nondev_subnode_extract(desc, NULL, link,
 							     list, parent);
@@ -396,6 +402,9 @@ static void acpi_untie_nondev_subnodes(s
 	struct acpi_data_node *dn;
 
 	list_for_each_entry(dn, &data->subnodes, sibling) {
+		if (!dn->handle)
+			continue;
+
 		acpi_detach_data(dn->handle, acpi_nondev_subnode_tag);
 
 		acpi_untie_nondev_subnodes(&dn->data);
@@ -410,6 +419,9 @@ static bool acpi_tie_nondev_subnodes(str
 		acpi_status status;
 		bool ret;
 
+		if (!dn->handle)
+			continue;
+
 		status = acpi_attach_data(dn->handle, acpi_nondev_subnode_tag, dn);
 		if (ACPI_FAILURE(status) && status != AE_ALREADY_EXISTS) {
 			acpi_handle_err(dn->handle, "Can't tag data node\n");




