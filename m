Return-Path: <linux-acpi+bounces-20304-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D7BAD1EDA2
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Jan 2026 13:43:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4095630081B5
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Jan 2026 12:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D59239B4B4;
	Wed, 14 Jan 2026 12:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ki703BjB"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A48A399A7B;
	Wed, 14 Jan 2026 12:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768394531; cv=none; b=quHcapDO1QR9GWv9gJrPXU446io1bAtGUm2X2DBeEpq2swdigdwLUpAORXNjpknmF+84r0YaHLr1rBeoK5yT4b9Qof+jOblRuwm/yfTiByhMVctgWXwAGNJYKARNLCj5n229+Drin1IZAzpFSK0PEizZLkrOg/CGkBGaB4eT1k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768394531; c=relaxed/simple;
	bh=7T/2nQ3ECFNsWMgDN+JfOLkJl2PTZMB1e2XreCGU96M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BUpzL6k+KRZkFKptgH8M0mNTHjNCeWe7yBwEi/0SUIRyo8xmULC0O8P68Xsu+GhRcg61Qairn8Z82GgHojY7+mDiiFZdfqOgx23EK/QIE1d9GxpQkJh0AsO5B4OrrtRee/FDPMgIEodNHG9eFNemFmVDHnsuBNiIz+6fBJAz7xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ki703BjB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3903BC16AAE;
	Wed, 14 Jan 2026 12:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768394531;
	bh=7T/2nQ3ECFNsWMgDN+JfOLkJl2PTZMB1e2XreCGU96M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ki703BjBgSIKAmbokJY5nbUS3kSBrTjeSbYkeRcwksiaMkBnbLx/YExth55tg0GfK
	 oz91gv8AazFHXIJxS3uZdngDqKa5BipmOg4kFBTZkx9ICySW834DHPub5YDhuLFhjV
	 ZaYi38uYFqIdAyxLFtUh07GE51ZNz3owmRghsE+mIUVzVj5uAgO3OdBAZYdKVzqho3
	 KNo5LtDCJDZzWrFErQR2mdAC77OQh4W+oJogGjeHC2GjjElSpdAivAeNYdd05lv6E9
	 /+sh0a0SOvYs3oe02yvH21k1R+2bKkhq+c+Nu2/eFumYvNcVjsSwXRQbyBnBP8ttc7
	 1iR+tKDl10t0w==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 "Dumbre, Saket" <saket.dumbre@intel.com>
Subject: [PATCH v1 13/26] ACPICA: Fix asltests using the Fatal() opcode
Date: Wed, 14 Jan 2026 13:27:47 +0100
Message-ID: <2052065.usQuhbGJ8B@rafael.j.wysocki>
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

Some asltests test the behavior of the Fatal() opcode and thus require
that said opcode does not return an error when called.

Introduce a compile-time option called ACPI_CONTINUE_ON_FATAL to
instruct the executor to continue the execution of AML bytecode when
encountering a Fatal() opcode. Also update the asltest to use this
new option.

Fixes: ("Abort AML bytecode execution when executing AML_FATAL_OP")
Link: https://github.com/acpica/acpica/commit/428b3410c490
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpica/exoparg3.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/acpi/acpica/exoparg3.c b/drivers/acpi/acpica/exoparg3.c
index c8c8c4e49563..2fc8070814e3 100644
--- a/drivers/acpi/acpica/exoparg3.c
+++ b/drivers/acpi/acpica/exoparg3.c
@@ -72,11 +72,18 @@ acpi_status acpi_ex_opcode_3A_0T_0R(struct acpi_walk_state *walk_state)
 
 		acpi_os_signal(ACPI_SIGNAL_FATAL, &fatal);
 
+#ifndef ACPI_CONTINUE_ON_FATAL
 		/*
 		 * Might return while OS is shutting down, so abort the AML execution
 		 * by returning an error.
 		 */
 		return_ACPI_STATUS(AE_ERROR);
+#else
+		/*
+		 * The alstests require that the Fatal() opcode does not return an error.
+		 */
+		return_ACPI_STATUS(AE_OK);
+#endif
 
 	case AML_EXTERNAL_OP:
 		/*
-- 
2.51.0





