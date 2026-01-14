Return-Path: <linux-acpi+bounces-20312-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A665DD1EDC8
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Jan 2026 13:45:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1A0A0303076E
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Jan 2026 12:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 665CB39A801;
	Wed, 14 Jan 2026 12:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JSaH3dCD"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85EF399A7C;
	Wed, 14 Jan 2026 12:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768394565; cv=none; b=O3BzngGNcP1nWOSCFkIPcEkAWIev7Fi7thdhSTTGZyCOYSzx9DtxtAv1uKW3Rdjl1ZtmUmcI8lrg7I6XfsWOWOE5w1xhrcsuI2XgDBYg4ZuFbNYX180edkpNN9yldxk2wck0xVVvDdauWHvAN6J4/JEAJKaQGs2rmyzrZS3sEBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768394565; c=relaxed/simple;
	bh=pqTJKSvmin0/eVC2ZWUh5TfpC+sGVjEpxxCohWBBG4I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rHChZUcnIG7krRBt767I/9Aj7Al1cNcpQjIk8cHmWaofms2lyPzHP4QDePcUOgh7O5WspxHVQQ0z470uw9qwE/cObPS5jkCQ5QDfmVeJqpfXLRsjgK8ykRLrNoAzcjxRCdAfNN5qLONdfjDAGzeyWnAhWys5GjCdrJpNeybIAQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JSaH3dCD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91DEFC4CEF7;
	Wed, 14 Jan 2026 12:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768394559;
	bh=pqTJKSvmin0/eVC2ZWUh5TfpC+sGVjEpxxCohWBBG4I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JSaH3dCDujXEojq7Qx1tnStKoETPSLyqjFx5NFnSbtcSAVhx8eVtB8VyGvHLzjdS8
	 rh9ieVWBG7PhUd6C397L1eP0m4O48Qx4cvC48yZ40ln11SzBhZg9cPWQeE+JejyRPs
	 E9MZQMa2KqMsMlZP11YbIG4ihF2am83h1O5jd8zhF7J6ZtezykF1BdjZxmM8nzAUwr
	 c20uHsmnUbxhgiVNEhAuphJjp5b11org/h/Qu6joNR5oEl7uiaPaU8cBSwt0etsmMg
	 9RrmBD9YgC6JhWD5QQtLeklLSwTri3DWNqlR2qY8BGNNM79K1HooTzZcS5IyuF7gKH
	 U57t9vxQaPOHQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 "Dumbre, Saket" <saket.dumbre@intel.com>
Subject:
 [PATCH v1 05/26] ACPICA: Fix NULL pointer dereference in
 acpi_ev_address_space_dispatch()
Date: Wed, 14 Jan 2026 13:20:17 +0100
Message-ID: <3030574.e9J7NaK4W3@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <12822121.O9o76ZdvQC@rafael.j.wysocki>
References: <12822121.O9o76ZdvQC@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Alexey Simakov <bigalex934@gmail.com>

Cover a missed execution path with a new check.

Fixes: 0acf24ad7e10 ("ACPICA: Add support for PCC Opregion special context data")
Link: https://github.com/acpica/acpica/commit/f421dd9dd897
Signed-off-by: Alexey Simakov <bigalex934@gmail.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpica/evregion.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/evregion.c b/drivers/acpi/acpica/evregion.c
index fa3475da7ea9..b6198f73c81d 100644
--- a/drivers/acpi/acpica/evregion.c
+++ b/drivers/acpi/acpica/evregion.c
@@ -163,7 +163,9 @@ acpi_ev_address_space_dispatch(union acpi_operand_object *region_obj,
 			return_ACPI_STATUS(AE_NOT_EXIST);
 		}
 
-		if (region_obj->region.space_id == ACPI_ADR_SPACE_PLATFORM_COMM) {
+		if (field_obj
+		    && region_obj->region.space_id ==
+		    ACPI_ADR_SPACE_PLATFORM_COMM) {
 			struct acpi_pcc_info *ctx =
 			    handler_desc->address_space.context;
 
-- 
2.51.0





