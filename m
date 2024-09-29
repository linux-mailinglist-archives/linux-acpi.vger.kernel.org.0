Return-Path: <linux-acpi+bounces-8479-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF298989215
	for <lists+linux-acpi@lfdr.de>; Sun, 29 Sep 2024 02:03:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B254280EA3
	for <lists+linux-acpi@lfdr.de>; Sun, 29 Sep 2024 00:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDE1023A0;
	Sun, 29 Sep 2024 00:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="pXFFQGkt"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6C82594;
	Sun, 29 Sep 2024 00:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727568193; cv=none; b=evDgM+HBq8np80sVUjHjbO4n44tudVq4MAHepmE41dW5mJFtJhofjVsJKCsJxHamrKYgKep7CMYAJ3CVuvHBtTYoyNEKsTPAC9Fg3azgYBqp2X5Y8kJ03xyoqTMz94YvbiNeaEi9KMffHVIjIW/bJ7EbLeDr4n6wj4B11iLjA5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727568193; c=relaxed/simple;
	bh=U3e3anVP2I5mlSlWV5cTmjbYxuRmLsYw2ZO11ASv4R4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CCtgJ3Dd46RGte9V4NteEZl5hC1U8rBqgk3bVywAg5SbCwwsdPH8yLlgrV1KLE7mO6hWJeJvw+4DXCL+maorwlquXZ6V3EJgDamQcvq2b5jBwDwWlQXvIVmRn0PkLCqECJZpUAJwhyahQu2Iag3o4mb7dw/+oj6JGYh/KF0CbyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=pXFFQGkt; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=547Das7nJu/+ANxIPN+NDpwejelzHoEvg/AEGNlGgOQ=; b=pXFFQGkttYKM8lOY
	8S3peTzXEZ+Ty3HnxmiUb66y9B+L+iPUAyt1nZxXyALJxYueYhgcm5D2yl04q6eRQuoLySBrq+TgR
	dGpeoDywd6VOiMKq9sfNeXHWZHFuYqGob6oQ5etfjLT+9tk5grBQ8FMZUwiIv2vjoZ5nFRXh+QCTC
	h9B/4TIEo4vCUmXTwCMeujl3gPCQEMenhNoy9ZkncGMh5KVnMHu98tEkygBCEY20+B74D97GUfUbA
	r59FXbeofxDXZySFnSiTN8N1Ll0jc6K9yOMV8hgvZmwQhSYefsIR19S8NBqnVnp4hiQyWtSNLe/FR
	ndO3+nc3Epupemqrrw==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1suhOs-007mHS-0o;
	Sun, 29 Sep 2024 00:02:58 +0000
From: linux@treblig.org
To: robert.moore@intel.com,
	rafael.j.wysocki@intel.com,
	lenb@kernel.org
Cc: linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH] ACPICA: Remove unused 'acpi_ps_get_name'
Date: Sun, 29 Sep 2024 01:02:53 +0100
Message-ID: <20240929000253.418403-1-linux@treblig.org>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

acpi_ps_get_name is currently unused, remove it.

I can't find any history of it's use since git, but I can
see it was used in 2.5.0, and see a record of a removal
of uses at Fri Aug 30 00:38:52 2002.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/acpi/acpica/acparser.h |  2 --
 drivers/acpi/acpica/psutils.c  | 17 -----------------
 2 files changed, 19 deletions(-)

diff --git a/drivers/acpi/acpica/acparser.h b/drivers/acpi/acpica/acparser.h
index 6dad786a382c..3a61853591d3 100644
--- a/drivers/acpi/acpica/acparser.h
+++ b/drivers/acpi/acpica/acparser.h
@@ -207,8 +207,6 @@ void acpi_ps_free_op(union acpi_parse_object *op);
 
 u8 acpi_ps_is_leading_char(u32 c);
 
-u32 acpi_ps_get_name(union acpi_parse_object *op);
-
 void acpi_ps_set_name(union acpi_parse_object *op, u32 name);
 
 /*
diff --git a/drivers/acpi/acpica/psutils.c b/drivers/acpi/acpica/psutils.c
index d550c4af4702..3799ae9f6d39 100644
--- a/drivers/acpi/acpica/psutils.c
+++ b/drivers/acpi/acpica/psutils.c
@@ -181,23 +181,6 @@ u8 acpi_ps_is_leading_char(u32 c)
 	return ((u8) (c == '_' || (c >= 'A' && c <= 'Z')));
 }
 
-/*
- * Get op's name (4-byte name segment) or 0 if unnamed
- */
-u32 acpi_ps_get_name(union acpi_parse_object * op)
-{
-
-	/* The "generic" object has no name associated with it */
-
-	if (op->common.flags & ACPI_PARSEOP_GENERIC) {
-		return (0);
-	}
-
-	/* Only the "Extended" parse objects have a name */
-
-	return (op->named.name);
-}
-
 /*
  * Set op's name
  */
-- 
2.46.2


