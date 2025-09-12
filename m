Return-Path: <linux-acpi+bounces-16769-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 461ADB5575E
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Sep 2025 22:07:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FA6AAA216D
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Sep 2025 20:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01CB232ED2D;
	Fri, 12 Sep 2025 20:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M08/yRHq"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB492C0282;
	Fri, 12 Sep 2025 20:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757707594; cv=none; b=dzEp8gPEbZZSrtJRcVIE+6p7cGCveLy2Fy6lKBPi3CSSFVHNWRrh9efBo98Q99MMx6ydebtr8JwX0JiRU9zaPUgZC9ee6LFhW5lLk2uoz1RT2BcJZk38ojAykDJadOyFS+R5Rtx9rsC5nhg6W+M1Cu9E1s3wez4zzmkho3ho9Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757707594; c=relaxed/simple;
	bh=clRxbIUzBNOG9ow7tQFYMU4AjUWvjX9qQ+s9wM8+IxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ltsRqnTQA1Jjcy1lnbM7RiPCXTc+MGk3Vohv2ztHTizaGr7p1WyTVTyDM+BqpAwQejViFxobEaR5ft74ty6ssQcJS9QtL2EIV+2/7R4YqjnsJeJNhYMDzW3s/4U2NFMuYBlY3FVfzvT7UIhfPVHUmtRGI3Q2fz8TN3QA5DCcAEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M08/yRHq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D532C4CEF4;
	Fri, 12 Sep 2025 20:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757707594;
	bh=clRxbIUzBNOG9ow7tQFYMU4AjUWvjX9qQ+s9wM8+IxE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M08/yRHqc3bvHRCACEU0+OVfQ86W3tNiyhbYU17/xokK5lTjwBcr2pJQMkgbR+zXl
	 kBB3UbqAIBQ6tPOy7cOOgCfnzRiIeWCdycPUDMrcobm7Fh0iaGkHB+OYff7mq7c05B
	 ge2cE/3M0FVM3AwA1Xh62OkEapIwH9kAE9BKvnQE27OWvys2vKm4fhEmP9h162jfs0
	 PPy9y7og3v3lMgZvFpkd5R53Ff1FnZO5dPrHcPVAKn+ZY7mIHBKR40+ohaLbthNYvO
	 YE2k2fBplqGrUyb+GaCmfl9zj1O7OnzoaEYYCGODp7SyHxKSj6KiK1eaEjqwqDeHCW
	 QtkLdHpyqWF4Q==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 "Dumbre, Saket" <saket.dumbre@intel.com>
Subject:
 [PATCH v1 11/16] ACPICA: Print error messages for too few or too many
 arguments
Date: Fri, 12 Sep 2025 22:01:52 +0200
Message-ID: <2255091.Icojqenx9y@rafael.j.wysocki>
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

From: Saket Dumbre <saket.dumbre@intel.com>

Fix Issue #1027 by displaying error messages when there are too few or
too many arguments in the caller vs the definition of an ASL/AML method.

Link: https://github.com/acpica/acpica/commit/cbc243e4
Reported-by: Peter Williams <peter@newton.cx>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Tested-by: Hans de Goede <hansg@kernel.org>
Signed-off-by: Saket Dumbre <saket.dumbre@intel.com>
---
 drivers/acpi/acpica/dsmethod.c | 11 +++++++++--
 include/acpi/acexcep.h         | 10 ++++++++--
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/acpica/dsmethod.c b/drivers/acpi/acpica/dsmethod.c
index b2f756b7078d..45ec32e81903 100644
--- a/drivers/acpi/acpica/dsmethod.c
+++ b/drivers/acpi/acpica/dsmethod.c
@@ -483,10 +483,17 @@ acpi_ds_call_control_method(struct acpi_thread_state *thread,
 	}
 
 	if (this_walk_state->num_operands < obj_desc->method.param_count) {
-		ACPI_ERROR((AE_INFO, "Missing argument for method [%4.4s]",
+		ACPI_ERROR((AE_INFO, "Missing argument(s) for method [%4.4s]",
 			    acpi_ut_get_node_name(method_node)));
 
-		return_ACPI_STATUS(AE_AML_UNINITIALIZED_ARG);
+		return_ACPI_STATUS(AE_AML_TOO_FEW_ARGUMENTS);
+	}
+
+	else if (this_walk_state->num_operands > obj_desc->method.param_count) {
+		ACPI_ERROR((AE_INFO, "Too many arguments for method [%4.4s]",
+			    acpi_ut_get_node_name(method_node)));
+
+		return_ACPI_STATUS(AE_AML_TOO_MANY_ARGUMENTS);
 	}
 
 	/* Init for new method, possibly wait on method mutex */
diff --git a/include/acpi/acexcep.h b/include/acpi/acexcep.h
index 53c98f5fe3c3..a2db36d18419 100644
--- a/include/acpi/acexcep.h
+++ b/include/acpi/acexcep.h
@@ -173,8 +173,10 @@ struct acpi_exception_info {
 #define AE_AML_TARGET_TYPE              EXCEP_AML (0x0023)
 #define AE_AML_PROTOCOL                 EXCEP_AML (0x0024)
 #define AE_AML_BUFFER_LENGTH            EXCEP_AML (0x0025)
+#define AE_AML_TOO_FEW_ARGUMENTS        EXCEP_AML (0x0026)
+#define AE_AML_TOO_MANY_ARGUMENTS       EXCEP_AML (0x0027)
 
-#define AE_CODE_AML_MAX                 0x0025
+#define AE_CODE_AML_MAX                 0x0027
 
 /*
  * Internal exceptions used for control
@@ -353,7 +355,11 @@ static const struct acpi_exception_info acpi_gbl_exception_names_aml[] = {
 		  "A target operand of an incorrect type was encountered"),
 	EXCEP_TXT("AE_AML_PROTOCOL", "Violation of a fixed ACPI protocol"),
 	EXCEP_TXT("AE_AML_BUFFER_LENGTH",
-		  "The length of the buffer is invalid/incorrect")
+		  "The length of the buffer is invalid/incorrect"),
+	EXCEP_TXT("AE_AML_TOO_FEW_ARGUMENTS",
+		  "There are fewer than expected method arguments"),
+	EXCEP_TXT("AE_AML_TOO_MANY_ARGUMENTS",
+		  "There are too many arguments for this method")
 };
 
 static const struct acpi_exception_info acpi_gbl_exception_names_ctrl[] = {
-- 
2.51.0





