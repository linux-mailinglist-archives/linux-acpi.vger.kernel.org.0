Return-Path: <linux-acpi+bounces-20310-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 97032D1EDC2
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Jan 2026 13:45:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 62C77306EAC7
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Jan 2026 12:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1295839A7F7;
	Wed, 14 Jan 2026 12:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O3DMeEuN"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3849399A59;
	Wed, 14 Jan 2026 12:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768394553; cv=none; b=T0hJCbAGxdO+2dgkt4AnjQYJ+iux9/9FbA0gNfeg2FXkC5+LWiWbmM4M/+r30np9XSiLtA1l/OVofzMwnWkAbnBBnWyY5R7ircKvWYofrdEaz54x3PKU2qF516J0gTn6x0Fhv/ABshmOoOJ7+hM47ymI5zht05DvRommibj+6ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768394553; c=relaxed/simple;
	bh=F57cUQsd2jwHyRn5zrEtCD+Txmyw6Yex1SXW6tNoFjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eTSwtQdHjc2aenhFkbflrQRKkVK7UqSmbqJoNlbWNcA7ooKJRLFaSMwV1mC2QqW7y1edDl76p5zo26ub9S19AhkZd7s6ezszcZmIrx01biBL6EO1nejgdle0MAg1AEg0yf/ednQV4PEePijy/SA82oVyKsMmTAvOw1d6YLghcgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O3DMeEuN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B5DFC4CEF7;
	Wed, 14 Jan 2026 12:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768394552;
	bh=F57cUQsd2jwHyRn5zrEtCD+Txmyw6Yex1SXW6tNoFjQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O3DMeEuNzOl/G7H9M11A7QcVeDsLlHUpXa332/xVDXp33XiwrU4nlNqpeYnsi+Ede
	 w+LDZKRTVEINaYljnjqVJ4/5Pdlay5Ue5lfklMv1ZvVcwIkmz3yoye7z8b9NbSbBrC
	 Sv9k1Vd8g+tWPH3Ruyusl7QxvHswP4C0MU44W/fXYywb3bqHnjF32Zg56RRKIxAzis
	 rYxgfaCx8EQ++xC0EReHqNexaMrYpaC2k+YgDsbWhd6DgGP76Kcxkoj+wfQhZkzOdK
	 rJnUzimjGgokCu5Wp/T0cJfmI4pA3spOkZPvHgpxVpcIdDsPq63BYHhx57axCR4gFD
	 TQDTQhw2B/DtQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 "Dumbre, Saket" <saket.dumbre@intel.com>
Subject:
 [PATCH v1 07/26] ACPICA: Add support for the Microsoft display mux _OSI
 string
Date: Wed, 14 Jan 2026 13:21:59 +0100
Message-ID: <10790566.nUPlyArG6x@rafael.j.wysocki>
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

From: Armin Wolf <W_Armin@gmx.de>

As per [1].

Link: https://learn.microsoft.com/en-us/windows-hardware/drivers/display/automatic-display-switch [1]
Link: https://github.com/acpica/acpica/commit/28b644211ff2
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpica/utosi.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/utosi.c b/drivers/acpi/acpica/utosi.c
index f6ac16729e42..88d04183ad0a 100644
--- a/drivers/acpi/acpica/utosi.c
+++ b/drivers/acpi/acpica/utosi.c
@@ -92,7 +92,11 @@ static struct acpi_interface_info acpi_default_supported_interfaces[] = {
 	{"Processor Device", NULL, ACPI_OSI_OPTIONAL_FEATURE, 0},
 	{"3.0 Thermal Model", NULL, ACPI_OSI_OPTIONAL_FEATURE, 0},
 	{"3.0 _SCP Extensions", NULL, ACPI_OSI_OPTIONAL_FEATURE, 0},
-	{"Processor Aggregator Device", NULL, ACPI_OSI_OPTIONAL_FEATURE, 0}
+	{"Processor Aggregator Device", NULL, ACPI_OSI_OPTIONAL_FEATURE, 0},
+
+	/* See https://learn.microsoft.com/en-us/windows-hardware/drivers/display/automatic-display-switch */
+
+	{"DisplayMux", NULL, ACPI_OSI_OPTIONAL_FEATURE, 0}
 };
 
 /*******************************************************************************
-- 
2.51.0





