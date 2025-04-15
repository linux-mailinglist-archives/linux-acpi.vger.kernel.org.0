Return-Path: <linux-acpi+bounces-13062-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D796A8A7E0
	for <lists+linux-acpi@lfdr.de>; Tue, 15 Apr 2025 21:26:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 491C07AD077
	for <lists+linux-acpi@lfdr.de>; Tue, 15 Apr 2025 19:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54F6523FC7A;
	Tue, 15 Apr 2025 19:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T/YFmxZi"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E59719CD17;
	Tue, 15 Apr 2025 19:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744745191; cv=none; b=Pcdavk8aU2P5Xg9t2EnPjhHlrZKj+99/DzPVEGH0GxhHCFLRFZrPphSnkPCwxW+gVeukY3ZwoGBMrbH2mKA854NGMOYyB1TwPrVxX0OfidWB5USiMXFJtKookAQSZMhPfxFenW8OrnBvbwNk6+cIgPRIVb5XHwYyY3JI3JibmaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744745191; c=relaxed/simple;
	bh=dhHHFjWpyT5HIVylDO2zg98dOnJbsIh9d6qlVbp/4Hw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Au4pMInNxVEa7Z6UjT4lPOL0z/WWqvMQYluvgMKp3X9EMZM2Ju97eRQzCg7QvCqvb53t9zQ7NieMNX9n/G97bVeeF6wNn3m1zqW5ByNtMqfH4q/gwMzUU6KZj0fojsLN1HPo+IRr6zk3LoOHq/WOg2ItiKuwHkFHDJ3l0B/Snn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T/YFmxZi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02C86C4CEE7;
	Tue, 15 Apr 2025 19:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744745190;
	bh=dhHHFjWpyT5HIVylDO2zg98dOnJbsIh9d6qlVbp/4Hw=;
	h=From:To:Cc:Subject:Date:From;
	b=T/YFmxZi7+jN30g0nNBOBhJlGcK7S1jpPXjgUpEo09B0EY5FSKQZVWib/JrM1E3uP
	 4hiAx3C95MQwnkgaJrq9gLQH3NnMiOhus4LYgwRCqTuNCx4Xxb71XdnDuzN41C9rc+
	 jQRdCmajIwVlIsqq/W/5bMWdGAPocgsiWUFBvEqkTmvsmhrJWEJlKW8BECD43X3e8F
	 WDFMPElVusZc0g8AACnbs5WS1IDyc+nq+qPwbx9FiUTO3+zabrLgTbLksR3Ya9v0An
	 lrLCsSlITmUa7VHMAKJh1hfKhWUIhhy2RPP5rzntfmXCMh5wjuODmVTGgZAotplv3g
	 r20Vu2WdNGIGg==
From: Mario Limonciello <superm1@kernel.org>
To: mario.limonciello@amd.com,
	robert.moore@intel.com,
	rafael.j.wysocki@intel.com
Cc: linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev
Subject: [PATCH] ACPICA: Add support for printing AML arguments when trace point enabled
Date: Tue, 15 Apr 2025 14:26:11 -0500
Message-ID: <20250415192614.2042036-1-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

When debug level is set to `ACPI_LV_TRACE_POINT` method start and
exit are emitted into the debug logs. This can be useful to understand
call paths, however none of the arguments for the method calls are
populated even when turning up other debug levels.

This can be useful for BIOSes that contain debug strings to see those
strings. When `ACPI_LV_TRACE_POINT` is set also output all of the arguments
for a given method call.

This enables this type of debugging:

```
extrace-0138 ex_trace_point        : Method Begin [0x0000000096b240c4:\M460] execution.
extrace-0173 ex_trace_args         :  "  POST CODE: %X  ACPI TIMER: %X  TIME: %d.%d ms\n", b0003f53, 1a26a8b2, 0, 15e, 0, 0
extrace-0138 ex_trace_point        : Method End [0x0000000096b240c4:\M460] execution.
```

Link: https://github.com/acpica/acpica/commit/08219d91b5678ae2fae6e4f208df790a4e108c1c
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
This is a backport from upstream ACPICA.  I'm not sure if there is a script
that converts code style, so I just manually adjusted to kernel code style.
It is really useful for me for debugging; so I would ideally like to see it
go for 6.16 if possible.
---
 drivers/acpi/acpica/acinterp.h |  3 +++
 drivers/acpi/acpica/dsmthdat.c |  1 +
 drivers/acpi/acpica/extrace.c  | 49 ++++++++++++++++++++++++++++++++++
 3 files changed, 53 insertions(+)

diff --git a/drivers/acpi/acpica/acinterp.h b/drivers/acpi/acpica/acinterp.h
index 955114c926bd0..d02779ee92103 100644
--- a/drivers/acpi/acpica/acinterp.h
+++ b/drivers/acpi/acpica/acinterp.h
@@ -120,6 +120,9 @@ void
 acpi_ex_trace_point(acpi_trace_event_type type,
 		    u8 begin, u8 *aml, char *pathname);
 
+void
+acpi_ex_trace_args(union acpi_operand_object **params, u32 count);
+
 /*
  * exfield - ACPI AML (p-code) execution - field manipulation
  */
diff --git a/drivers/acpi/acpica/dsmthdat.c b/drivers/acpi/acpica/dsmthdat.c
index eca50517ad824..5393de4dbc4ca 100644
--- a/drivers/acpi/acpica/dsmthdat.c
+++ b/drivers/acpi/acpica/dsmthdat.c
@@ -188,6 +188,7 @@ acpi_ds_method_data_init_args(union acpi_operand_object **params,
 
 		index++;
 	}
+	acpi_ex_trace_args(params, index);
 
 	ACPI_DEBUG_PRINT((ACPI_DB_EXEC, "%u args passed to method\n", index));
 	return_ACPI_STATUS(AE_OK);
diff --git a/drivers/acpi/acpica/extrace.c b/drivers/acpi/acpica/extrace.c
index b5e4bb4ae3ce6..4a2a1eda1b25d 100644
--- a/drivers/acpi/acpica/extrace.c
+++ b/drivers/acpi/acpica/extrace.c
@@ -147,6 +147,55 @@ acpi_ex_trace_point(acpi_trace_event_type type,
 	}
 }
 
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_ex_trace_args
+ *
+ * PARAMETERS:  params            - AML method arguments
+ *              count             - numer of method arguments
+ *
+ * RETURN:      None
+ *
+ * DESCRIPTION: Trace any arguments
+ *
+ ******************************************************************************/
+
+void
+acpi_ex_trace_args(union acpi_operand_object **params, u32 count)
+{
+	u32 i;
+
+	ACPI_FUNCTION_NAME(ex_trace_args);
+
+	for (i = 0; i < count; i++) {
+		union acpi_operand_object *obj_desc = params[i];
+
+		if (!i)
+			ACPI_DEBUG_PRINT((ACPI_DB_TRACE_POINT, " "));
+
+		switch (obj_desc->common.type) {
+		case ACPI_TYPE_INTEGER:
+			ACPI_DEBUG_PRINT_RAW((ACPI_DB_TRACE_POINT, "%llx", obj_desc->integer.value));
+			break;
+		case ACPI_TYPE_STRING:
+			if (!obj_desc->string.length) {
+				ACPI_DEBUG_PRINT_RAW((ACPI_DB_TRACE_POINT, "NULL"));
+				continue;
+			}
+			if (ACPI_IS_DEBUG_ENABLED(ACPI_LV_TRACE_POINT, _COMPONENT))
+				acpi_ut_print_string(obj_desc->string.pointer, ACPI_UINT8_MAX);
+			break;
+		default:
+			ACPI_DEBUG_PRINT_RAW((ACPI_DB_TRACE_POINT, "Unknown"));
+			break;
+		}
+		if (i+1 == count)
+			ACPI_DEBUG_PRINT_RAW((ACPI_DB_TRACE_POINT, "\n"));
+		else
+			ACPI_DEBUG_PRINT_RAW((ACPI_DB_TRACE_POINT, ", "));
+	}
+}
+
 /*******************************************************************************
  *
  * FUNCTION:    acpi_ex_start_trace_method
-- 
2.43.0


