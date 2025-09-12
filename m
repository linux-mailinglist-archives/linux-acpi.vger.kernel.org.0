Return-Path: <linux-acpi+bounces-16777-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63B77B5576C
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Sep 2025 22:09:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 214BF17B4E0
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Sep 2025 20:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34B82343208;
	Fri, 12 Sep 2025 20:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tjpVJONb"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069EC2D0C8C;
	Fri, 12 Sep 2025 20:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757707620; cv=none; b=JaszWOjZtBLJL+K3hcSyyO1zF/9RF2d1Qaf2Aso2nS5BU0eZpbtOGVRMOfMOAJBYr+HQUUbRilScDEubxSfMTFqU3zz/zgSiSN85XnoTuhVNGffxtH8Rhb1RLoSzvA697al0Fktr8yIlW8GM43bkjn65dO09EyrU8j2ZMopcWcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757707620; c=relaxed/simple;
	bh=hS5u+9Sakaw4shoG+tk3afQibwVwO7XRqH597D0rn6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ag9KE6ckySgJQ36rUvknaqPuNtJni0syxbwYeeGwOD3u0aob/JewSeeZ50BwDWxbCFQSdZAgwsaciXtZrkkBrg9INZhTvCwDjbzS2FxKdf1mu+NfeSis6TFoovqjFrH9GxYbb9U3593XKSRI2wAZJPaWvG1DnCCAXZK1LfawumA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tjpVJONb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9681C4CEF8;
	Fri, 12 Sep 2025 20:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757707619;
	bh=hS5u+9Sakaw4shoG+tk3afQibwVwO7XRqH597D0rn6Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tjpVJONb9eBXWmtCf6MpNEIAUFJAokFH5aUucnG86+PuVwsmzqqvEZictLbej0AKe
	 YTEWQx2gAekhr/NhLm5gouXDnbffNCOqhnMs5voc2IalxkU4I4NsrDoZ+79Om8fnhG
	 uEKR0K/U4ds7i3A0G1HcGVO4IeXVw76REfQjQx3Te7XAsZRdeZdcYTddmYIGvIR4ke
	 HZzzMR6Czdm3CcR6LREocGDvK5aExKKCFYFijUUqNRjh+tp0fo0tg8iu3w8aiKI+Ls
	 ZgK41xjrs3bHnpW2P5ertA+673PyxMH218aDjnE/amb8knyMaVYKsX6AI2JfCDqr6I
	 oFXL6dWIXbt/w==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 "Dumbre, Saket" <saket.dumbre@intel.com>
Subject: [PATCH v1 03/16] ACPICA: Change the compilation conditions
Date: Fri, 12 Sep 2025 21:54:07 +0200
Message-ID: <3308016.5fSG56mABF@rafael.j.wysocki>
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

From: Zhe Qiao <qiaozhe@iscas.ac.cn>

To prevent the risk of undefined variables.

Link: https://github.com/acpica/acpica/commit/9f86d4c9
Signed-off-by: Zhe Qiao <qiaozhe@iscas.ac.cn>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpica/psopinfo.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpica/psopinfo.c b/drivers/acpi/acpica/psopinfo.c
index ca867d9407f9..532ea307a675 100644
--- a/drivers/acpi/acpica/psopinfo.c
+++ b/drivers/acpi/acpica/psopinfo.c
@@ -34,6 +34,9 @@ static const u8 acpi_gbl_argument_count[] =
 
 const struct acpi_opcode_info *acpi_ps_get_opcode_info(u16 opcode)
 {
+#if defined ACPI_ASL_COMPILER && defined ACPI_DEBUG_OUTPUT
+	const char *opcode_name = "Unknown AML opcode";
+#endif
 
 	ACPI_FUNCTION_NAME(ps_get_opcode_info);
 
@@ -59,8 +62,6 @@ const struct acpi_opcode_info *acpi_ps_get_opcode_info(u16 opcode)
 #if defined ACPI_ASL_COMPILER && defined ACPI_DEBUG_OUTPUT
 #include "asldefine.h"
 
-	const char *opcode_name = "Unknown AML opcode";
-
 	switch (opcode) {
 	case AML_RAW_DATA_BYTE:
 		opcode_name = "-Raw Data Byte-";
-- 
2.51.0





