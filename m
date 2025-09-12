Return-Path: <linux-acpi+bounces-16774-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E726B55768
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Sep 2025 22:08:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF8D9AA2346
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Sep 2025 20:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0B4E341AA4;
	Fri, 12 Sep 2025 20:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ekr8Aj4f"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78ACA2C15AE;
	Fri, 12 Sep 2025 20:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757707610; cv=none; b=QFegDqErt4Y5RGIXUlWq3NusUou56F4o5EPFi0oygKBAwCBAnGBCzWXrGSq2ok0ojWMo8m+qTfIQ+fxx+N3bql8qC3PIHA/FklEInpk0KapIsRXycw+qSmumg3LxQi0j682KgCrpoAUo7nVIlE0s4u0+CqTyOb0PhsRqWi5YSIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757707610; c=relaxed/simple;
	bh=YtCqz04CZpIVXl0XfDRjPvSyv9kA2new/Y41ykI4vg0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UaPSbseldaqVnyn839EoPvW4JeZLjYdjQrbC7o0EoedsaOYbvLE0LJWkiZChtOeSA+fceTwtTkNY+NLOWa5cF7Eos6rAGK1IOG1S19TeRGg7VQedLvw3iUa1+6VFk8Q7vU8n9R9IHmcqCOBhQj3L0bxxNecY1oeZ7TgeVlZGJxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ekr8Aj4f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31B07C4CEF1;
	Fri, 12 Sep 2025 20:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757707610;
	bh=YtCqz04CZpIVXl0XfDRjPvSyv9kA2new/Y41ykI4vg0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ekr8Aj4fxEPFcymIfp0SArWGivPRl8mT6AMwo38LM0bPvu8YmX55N2vP2ZfGsM14Q
	 lp3GFLx7D5Lg2wk3jvOb6n2FRuORvSjhyPuwo1YpsIima3rkWkfupyl4ozsWgBq/hl
	 PdzQAt2C3DwwMrOI0ZD5zG2OFITrbOQJuQMkWXn3Ls9XdrtepEvayvA1xuz6+c77X1
	 TFR+GOpBtHKljVZBkawR9e508xaFWdk2RFycS07IE9qo8xi6yAjYsHC/1raCXAJf9W
	 BxZSbDPKvfWPB6wAxz+GH5BTjRHrft15kKtsJ4Xbt9Fs+hC2kVTy7BlaCcAtWy25az
	 0Edmian1iBQ5A==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 "Dumbre, Saket" <saket.dumbre@intel.com>
Subject: [PATCH v1 06/16] ACPICA: iASL: Fix printing CDAT table header
Date: Fri, 12 Sep 2025 21:56:18 +0200
Message-ID: <1943926.CQOukoFCf9@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <2021361.PYKUYFuaPT@rafael.j.wysocki>
References: <2021361.PYKUYFuaPT@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Ahmed Salem <x0rw3ll@gmail.com>

When disassembling CDAT AML, the lack of CDAT's common ACPI table header
should be taken into consideration when printing the table's actual
header. As the table header lacks fields like Signature, header
information is mangled and incorrect:

 # $ iasl -d -ds CDAT cdat.aml
 # Input file cdat.aml, Length 0xE4 (228) bytes
 # ACPI: ?    0x0000000000000000 000C01 (v00        ?        00180000 ??   23456789)

Both Signature and Length are printed incorrectly, and the remaining
fields are not applicable for this special table. To fix this, verify
acpi_gbl_CDAT is set (<-ds CDAT> via command line) and Header->Signature
is an invalid nameseg (due to the presence of non-ASCII char(s)), then
print only the explicitly-passed signature (ACPI_SIG_CDAT) and the table
length as cast with a pointer to the struct acpi_table_cdat structure.

Link: https://github.com/acpica/acpica/commit/2b5586b4
Signed-off-by: Ahmed Salem <x0rw3ll@gmail.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpica/tbprint.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/acpi/acpica/tbprint.c b/drivers/acpi/acpica/tbprint.c
index fd64460a2e26..049f6c2f1e32 100644
--- a/drivers/acpi/acpica/tbprint.c
+++ b/drivers/acpi/acpica/tbprint.c
@@ -121,6 +121,14 @@ acpi_tb_print_table_header(acpi_physical_address address,
 			   ACPI_CAST_PTR(struct acpi_table_rsdp,
 					 header)->revision,
 			   local_header.oem_id));
+	} else if (acpi_gbl_CDAT && !acpi_ut_valid_nameseg(header->signature)) {
+
+		/* CDAT does not use the common ACPI table header */
+
+		ACPI_INFO(("%-4.4s 0x%8.8X%8.8X %06X",
+			   ACPI_SIG_CDAT, ACPI_FORMAT_UINT64(address),
+			   ACPI_CAST_PTR(struct acpi_table_cdat,
+					 header)->length));
 	} else {
 		/* Standard ACPI table with full common header */
 
-- 
2.51.0





