Return-Path: <linux-acpi+bounces-8296-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5262597913D
	for <lists+linux-acpi@lfdr.de>; Sat, 14 Sep 2024 16:00:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 853351C2161F
	for <lists+linux-acpi@lfdr.de>; Sat, 14 Sep 2024 14:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36CB21CF7D7;
	Sat, 14 Sep 2024 14:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="nJopdLyc"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77DD21CEEBC;
	Sat, 14 Sep 2024 14:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726322437; cv=none; b=NgzdGaYdwOtBE9rNal3M8t3NZwl3GQ7FlsCoL+zDdYlqxpK5ALEGXmemoqGYGuzVhBHYIHtK6yhbGzPdg95k9+cSYy7KrKePLkf18mIXb2NbQMusjJ/SKJ4lNHnufN+3/ghF4BCYUt6nhU2jk39o7v6SSzW8LNLOY0irBQuGakw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726322437; c=relaxed/simple;
	bh=82rejOJR+TwO9X37FqwfJ3bR4ZNm/CSYaWyYBH+OzaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UlE++1kLJSSPxy6dMXQH6CEGQ0MhpZH6EQjpVinsH3512W3jFgi8UDbgf5IeE9n0CuUPCHRAWq/6nCCWmzlEu+BOR8uQbaSBBEqQ9s6GOOGiLvuM1ZCcSX7fU4cXfwCpTgpoBn9DeGf7fdlPgi6HWy2PoKz4Z8tN7k2Mfj9EBHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=nJopdLyc; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=k6R1/4DRhZ0we6xzGH0zTpjBTa6qCA5H7oC8snl4NXU=; b=nJopdLyc+58OwXVr
	I7SSO86UTRFJO14o8Oxud0BAKdlI1mdqaZqCkpGc+BYdqH7Hli3lTe1HCY/DBBGK7sAhdGOOlruvH
	+RC4jLnnI8qvcZaxW8nxe98SBn89n+EYGsO9Jju2+zoJhXmqddnzVXDrX5dIVYykpgh8cObpeou72
	fUTu8tDu2qlacz/RtIuspz0tX6E/tlyEo/Lnn6O/fMoNOC0Nx1zBguzNwibNP1CPOXMrYwyHIq5bE
	7WQa21e1zGT7Sk9eKPXyOyW1+80qu96vbpZqWqF3C7hMrO3++A0LWa4sY4dZHhCcNPa4OaXv/cZ/x
	Idgnte9f6UhfsXFsZA==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1spTK7-005ko8-36;
	Sat, 14 Sep 2024 14:00:28 +0000
From: linux@treblig.org
To: robert.moore@intel.com,
	rafael.j.wysocki@intel.com,
	lenb@kernel.org
Cc: linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH] ACPCIA: Remove unused acpi_ns_one_complete_parse
Date: Sat, 14 Sep 2024 15:00:26 +0100
Message-ID: <20240914140026.29144-1-linux@treblig.org>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

The last use of 'acpi_ns_one_complete_parse' was removed by commit
aa342261bde5 ("ACPICA: Remove legacy module-level code support")

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/acpi/acpica/acnamesp.h |   5 --
 drivers/acpi/acpica/nsparse.c  | 102 ---------------------------------
 2 files changed, 107 deletions(-)

diff --git a/drivers/acpi/acpica/acnamesp.h b/drivers/acpi/acpica/acnamesp.h
index 9448bc026b9b..c3dd202e247f 100644
--- a/drivers/acpi/acpica/acnamesp.h
+++ b/drivers/acpi/acpica/acnamesp.h
@@ -104,11 +104,6 @@ acpi_ns_parse_table(u32 table_index, struct acpi_namespace_node *start_node);
 acpi_status
 acpi_ns_execute_table(u32 table_index, struct acpi_namespace_node *start_node);
 
-acpi_status
-acpi_ns_one_complete_parse(u32 pass_number,
-			   u32 table_index,
-			   struct acpi_namespace_node *start_node);
-
 /*
  * nsaccess - Top-level namespace access
  */
diff --git a/drivers/acpi/acpica/nsparse.c b/drivers/acpi/acpica/nsparse.c
index 31e551cf4ea6..549dc16aed3c 100644
--- a/drivers/acpi/acpica/nsparse.c
+++ b/drivers/acpi/acpica/nsparse.c
@@ -131,108 +131,6 @@ acpi_ns_execute_table(u32 table_index, struct acpi_namespace_node *start_node)
 	return_ACPI_STATUS(status);
 }
 
-/*******************************************************************************
- *
- * FUNCTION:    ns_one_complete_parse
- *
- * PARAMETERS:  pass_number             - 1 or 2
- *              table_desc              - The table to be parsed.
- *
- * RETURN:      Status
- *
- * DESCRIPTION: Perform one complete parse of an ACPI/AML table.
- *
- ******************************************************************************/
-
-acpi_status
-acpi_ns_one_complete_parse(u32 pass_number,
-			   u32 table_index,
-			   struct acpi_namespace_node *start_node)
-{
-	union acpi_parse_object *parse_root;
-	acpi_status status;
-	u32 aml_length;
-	u8 *aml_start;
-	struct acpi_walk_state *walk_state;
-	struct acpi_table_header *table;
-	acpi_owner_id owner_id;
-
-	ACPI_FUNCTION_TRACE(ns_one_complete_parse);
-
-	status = acpi_get_table_by_index(table_index, &table);
-	if (ACPI_FAILURE(status)) {
-		return_ACPI_STATUS(status);
-	}
-
-	/* Table must consist of at least a complete header */
-
-	if (table->length < sizeof(struct acpi_table_header)) {
-		return_ACPI_STATUS(AE_BAD_HEADER);
-	}
-
-	aml_start = (u8 *)table + sizeof(struct acpi_table_header);
-	aml_length = table->length - sizeof(struct acpi_table_header);
-
-	status = acpi_tb_get_owner_id(table_index, &owner_id);
-	if (ACPI_FAILURE(status)) {
-		return_ACPI_STATUS(status);
-	}
-
-	/* Create and init a Root Node */
-
-	parse_root = acpi_ps_create_scope_op(aml_start);
-	if (!parse_root) {
-		return_ACPI_STATUS(AE_NO_MEMORY);
-	}
-
-	/* Create and initialize a new walk state */
-
-	walk_state = acpi_ds_create_walk_state(owner_id, NULL, NULL, NULL);
-	if (!walk_state) {
-		acpi_ps_free_op(parse_root);
-		return_ACPI_STATUS(AE_NO_MEMORY);
-	}
-
-	status = acpi_ds_init_aml_walk(walk_state, parse_root, NULL,
-				       aml_start, aml_length, NULL,
-				       (u8)pass_number);
-	if (ACPI_FAILURE(status)) {
-		acpi_ds_delete_walk_state(walk_state);
-		goto cleanup;
-	}
-
-	/* Found OSDT table, enable the namespace override feature */
-
-	if (ACPI_COMPARE_NAMESEG(table->signature, ACPI_SIG_OSDT) &&
-	    pass_number == ACPI_IMODE_LOAD_PASS1) {
-		walk_state->namespace_override = TRUE;
-	}
-
-	/* start_node is the default location to load the table */
-
-	if (start_node && start_node != acpi_gbl_root_node) {
-		status =
-		    acpi_ds_scope_stack_push(start_node, ACPI_TYPE_METHOD,
-					     walk_state);
-		if (ACPI_FAILURE(status)) {
-			acpi_ds_delete_walk_state(walk_state);
-			goto cleanup;
-		}
-	}
-
-	/* Parse the AML */
-
-	ACPI_DEBUG_PRINT((ACPI_DB_PARSE,
-			  "*PARSE* pass %u parse\n", pass_number));
-	acpi_ex_enter_interpreter();
-	status = acpi_ps_parse_aml(walk_state);
-	acpi_ex_exit_interpreter();
-
-cleanup:
-	acpi_ps_delete_parse_tree(parse_root);
-	return_ACPI_STATUS(status);
-}
-
 /*******************************************************************************
  *
  * FUNCTION:    acpi_ns_parse_table
-- 
2.46.0


