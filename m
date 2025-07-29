Return-Path: <linux-acpi+bounces-15408-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD657B14E0D
	for <lists+linux-acpi@lfdr.de>; Tue, 29 Jul 2025 15:05:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 160DB18A1A39
	for <lists+linux-acpi@lfdr.de>; Tue, 29 Jul 2025 13:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5A1C14B086;
	Tue, 29 Jul 2025 13:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=listout.xyz header.i=@listout.xyz header.b="yoetLX9R"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94241442F4;
	Tue, 29 Jul 2025 13:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753794343; cv=none; b=ZvdVh+KJXd8GORe9w2SiAtSxmVzlolSFL1YVxtquJ/7n81SMFaqZpk0Y4w8+C38jvwATCIdr+jcNe06SGnal6IKXR+7pHT3uY1VQvEPGDRBGPD1mSs6Gz6pofPf1ZnIIaQ4etKMWoK1sPEYH0/E2LybF+XzV63P6g4a39/Cw33c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753794343; c=relaxed/simple;
	bh=E8U4HaasjlSJK1+GMTnWdvQ5jIArAlNSX8Ddx7nmH8I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kEp5KOeJa3HGdLwr1UXD10/c/qub72oI4L29itE4R1GagFVNvpU8Lly9fJnl0aA0+9Vc/cDUqm2wunciCxR5tZchbpZ+F5tHhHRrBn4BXPsRb7hA1rL4Z5JwvCMXOjhL8ouCZiiXT6jDJJdUepmYG/jMwopYl7ZA+y2v6Q4+uf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=listout.xyz; spf=pass smtp.mailfrom=listout.xyz; dkim=pass (2048-bit key) header.d=listout.xyz header.i=@listout.xyz header.b=yoetLX9R; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=listout.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=listout.xyz
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4brwZB09kmz9sd7;
	Tue, 29 Jul 2025 15:05:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=listout.xyz; s=MBO0001;
	t=1753794338;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=CLHsjtMIuXd91H+odZvaVwTEqjWhiAprj4V1F8Qa8sM=;
	b=yoetLX9RIBNkYz/d0StCabOiUAILBQyQyVXoS7bho7SybnrE0r/2aUkIj+HDHqar1LuWRI
	gBGn65KJzWK/UHoWa0EhSSNM/EXPjwivx6Bc6cxipu6RM9/qis2dTpnExx5TtoIbHgeYTw
	DDVFEqAaqk5XX8i/YyshZqO3UQTd0D7I+eTPRXU3rb/oObHBTZsDmuKeS1zsgu8J1N5P6p
	jUyfbcE4qYcKXiKfk3bsMQnA1ViNxiZAiN1/HIDBCswt0nmkKCPIij8qjg30l8DpJNZzBv
	qKxURbdM1b+9jIoCNz/rHJyBntTSbImkQd1CYoHEy6vw8+9FUjOnUxKHOxYsTA==
From: Brahmajit Das <listout@listout.xyz>
To: linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: robert.moore@intel.com,
	rafael.j.wysocki@intel.com,
	lenb@kernel.org,
	jrtc27@jrtc27.com,
	x0rw3ll@gmail.com
Subject: [RFC PATCH] Revert "ACPICA: Avoid subobject buffer overflow when validating RSDP signature"
Date: Tue, 29 Jul 2025 18:35:24 +0530
Message-ID: <20250729130524.7226-1-listout@listout.xyz>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This reverts commit a3e525feaeec436cd9f82f84e345f0d18dc2638f.

With 64b9dfd0776e9 there is the following build error:

In file included from ./include/acpi/acpi.h:24,
                 from drivers/acpi/acpica/tbprint.c:10:
drivers/acpi/acpica/tbprint.c: In function ‘acpi_tb_print_table_header’:
./include/acpi/actypes.h:530:43: error: ‘strncmp’ argument 1 declared attribute ‘nonstring’ is smaller than the specified bound 8 [-Werror=stringop-overread]
  530 | #define ACPI_VALIDATE_RSDP_SIG(a)       (!strncmp (ACPI_CAST_PTR (char, (a)), ACPI_SIG_RSDP, (sizeof(a) < 8) ? ACPI_NAMESEG_SIZE : 8))
      |                                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/acpi/acpica/tbprint.c:105:20: note: in expansion of macro ‘ACPI_VALIDATE_RSDP_SIG’
  105 |         } else if (ACPI_VALIDATE_RSDP_SIG(ACPI_CAST_PTR(struct acpi_table_rsdp,
      |                    ^~~~~~~~~~~~~~~~~~~~~~
In file included from ./include/acpi/acpi.h:26:
./include/acpi/actbl.h:69:14: note: argument ‘signature’ declared here
   69 |         char signature[ACPI_NAMESEG_SIZE] ACPI_NONSTRING;       /* ASCII table signature */
      |              ^~~~~~~~~
cc1: all warnings being treated as errors

With the overread checking in 64b9dfd0776e9, I think we can safely
revert this and fix the build error.

Signed-off-by: Brahmajit Das <listout@listout.xyz>
---
 drivers/acpi/acpica/tbprint.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/acpi/acpica/tbprint.c b/drivers/acpi/acpica/tbprint.c
index fd64460a2e26..73d854daad76 100644
--- a/drivers/acpi/acpica/tbprint.c
+++ b/drivers/acpi/acpica/tbprint.c
@@ -102,8 +102,7 @@ acpi_tb_print_table_header(acpi_physical_address address,
 		ACPI_INFO(("%-4.4s 0x%8.8X%8.8X %06X",
 			   header->signature, ACPI_FORMAT_UINT64(address),
 			   header->length));
-	} else if (ACPI_VALIDATE_RSDP_SIG(ACPI_CAST_PTR(struct acpi_table_rsdp,
-							header)->signature)) {
+	} else if (ACPI_VALIDATE_RSDP_SIG(header->signature)) {
 
 		/* RSDP has no common fields */
 
-- 
2.50.1


