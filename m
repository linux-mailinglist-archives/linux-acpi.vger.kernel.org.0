Return-Path: <linux-acpi+bounces-8705-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F0C2999C87
	for <lists+linux-acpi@lfdr.de>; Fri, 11 Oct 2024 08:20:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1732A1C21FA0
	for <lists+linux-acpi@lfdr.de>; Fri, 11 Oct 2024 06:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8438F208966;
	Fri, 11 Oct 2024 06:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KtEHEosk"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CDFF1CCEC2;
	Fri, 11 Oct 2024 06:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728627626; cv=none; b=glQr3wbjQ+vWgdFMg8oJMWXh/45L1KNb5YbuGhqHdWKqVzNoJOCqF1JiyIw3KFf4DpmgUbi/LrSrc+jfrH32e1WGbDb2mBxEYXEbysg8a1uZ0Vk5wKyyphr5IzvnsE8TUHDmDn8zM4ZTsObmSMBvRXlgShm+r70xe8NqxkAv0fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728627626; c=relaxed/simple;
	bh=Bg1PLwPa12hUim2QFdd4rWhuz44R0OSvKmpjhIlgV1w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bv9kBEvW6k26agFd5/O1W44zB6hZUvgs22HAw65/XtuK4vtZbS6m5uCvzWERyt9WNB3url8r53fCfJPE2CvtMaMcj9y3hna03upaLeFYOrYaNfJJUdOupg94ms54Z3augIcvwxF3BA++QHmzi+2gVlCHfOW5FiuhrBp2pd9YV7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KtEHEosk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6687C4CEC7;
	Fri, 11 Oct 2024 06:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728627626;
	bh=Bg1PLwPa12hUim2QFdd4rWhuz44R0OSvKmpjhIlgV1w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KtEHEoskxo73wM6C9zh2oO2M84T2dg767G5xJBQuajA5wR35d1gw0/8j0dTrMv6q0
	 CPSHFh+1XSaHqMPb88itwtVTOE5WirjSLC1DTKNcx9OtO5bLgQ4uNtc8D2yd6HnXLu
	 xaEoh4EqlSuvxk17UK4xhpwQCJWY9HdpmkOYOPaBkAkCSsV0L680LutwsEqEvHTG6A
	 49cgjhWV3PjlQ7FXmrbVW3ktzf9mbrSzhF4D43PImJkN41kONU/GC/4TRTjg9FzDZ4
	 uSnf8MviYzjZ9bPZiVNTsWyNpl+JyTeA2cBmhuwVy/m6zMu979aJd3Q421TSOTCiHR
	 ngGxTVUFWxO1A==
From: Arnd Bergmann <arnd@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Len Brown <lenb@kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Jarred White <jarredwhite@linux.microsoft.com>,
	Perry Yuan <perry.yuan@amd.com>,
	Easwar Hariharan <eahariha@linux.microsoft.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] acpi: allow building without CONFIG_HAS_IOPORT
Date: Fri, 11 Oct 2024 06:18:18 +0000
Message-Id: <20241011061948.3211423-2-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241011061948.3211423-1-arnd@kernel.org>
References: <20241011061948.3211423-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

CONFIG_HAS_IOPORT will soon become optional and cause a build time
failure when it is disabled but a driver calls inb()/outb(). At the
moment, all architectures that can support ACPI have port I/O, but this
is not necessarily the case in the future on non-x86 architectures.
The result is a set of errors like:

drivers/acpi/osl.c: In function 'acpi_os_read_port':
include/asm-generic/io.h:542:14: error: call to '_inb' declared with attribute error: inb()) requires CONFIG_HAS_IOPORT

Nothing should actually call these functions in this configuration,
and if it does, the result would be undefined behavior today, possibly
a NULL pointer dereference.

Change the low-level functions to return a proper error code when
HAS_IOPORT is disabled.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/acpi/cppc_acpi.c | 6 ++++--
 drivers/acpi/osl.c       | 8 ++++++++
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index b73b3aa92f3f..326b73ae77a9 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -1017,7 +1017,8 @@ static int cpc_read(int cpu, struct cpc_register_resource *reg_res, u64 *val)
 	*val = 0;
 	size = GET_BIT_WIDTH(reg);
 
-	if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_IO) {
+	if (IS_ENABLED(CONFIG_HAS_IOPORT) &&
+	    reg->space_id == ACPI_ADR_SPACE_SYSTEM_IO) {
 		u32 val_u32;
 		acpi_status status;
 
@@ -1090,7 +1091,8 @@ static int cpc_write(int cpu, struct cpc_register_resource *reg_res, u64 val)
 
 	size = GET_BIT_WIDTH(reg);
 
-	if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_IO) {
+	if (IS_ENABLED(CONFIG_HAS_IOPORT) &&
+	    reg->space_id == ACPI_ADR_SPACE_SYSTEM_IO) {
 		acpi_status status;
 
 		status = acpi_os_write_port((acpi_io_address)reg->address,
diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 70af3fbbebe5..19342ccfabb9 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -642,6 +642,11 @@ acpi_status acpi_os_read_port(acpi_io_address port, u32 *value, u32 width)
 {
 	u32 dummy;
 
+	if (!IS_ENABLED(CONFIG_HAS_IOPORT)) {
+		*value = BIT_MASK(width);
+		return AE_NOT_IMPLEMENTED;
+	}
+
 	if (value)
 		*value = 0;
 	else
@@ -665,6 +670,9 @@ EXPORT_SYMBOL(acpi_os_read_port);
 
 acpi_status acpi_os_write_port(acpi_io_address port, u32 value, u32 width)
 {
+	if (!IS_ENABLED(CONFIG_HAS_IOPORT))
+		return AE_NOT_IMPLEMENTED;
+
 	if (width <= 8) {
 		outb(value, port);
 	} else if (width <= 16) {
-- 
2.39.5


