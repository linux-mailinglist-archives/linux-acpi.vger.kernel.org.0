Return-Path: <linux-acpi+bounces-13964-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3D5AAC8B6A
	for <lists+linux-acpi@lfdr.de>; Fri, 30 May 2025 11:48:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E0E31BA1CDE
	for <lists+linux-acpi@lfdr.de>; Fri, 30 May 2025 09:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B0A0220F4B;
	Fri, 30 May 2025 09:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="BYmI2JEx"
X-Original-To: linux-acpi@vger.kernel.org
Received: from forward102b.mail.yandex.net (forward102b.mail.yandex.net [178.154.239.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720692192EC
	for <linux-acpi@vger.kernel.org>; Fri, 30 May 2025 09:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748598513; cv=none; b=IUKtDcIfK2sfGm2A39xsfQUZfKC2a7ii2RyQvYwXXyneyOG9I0M+uOyJAJ3tL/LQ9GWQA0xGMlrxuAcOg7UhCi7Mr362z7zWxuALO8fFnYIFPJJ05sfm0DIze1dOruRir3lA0TfH5S/CrdtbZQFBMeagpfy+7pfehTlU+5M7o40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748598513; c=relaxed/simple;
	bh=7f6mAQcF5PHVp5UXsxfyp8gyKgBiiyml5t+WUzoXmBI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X9BipKd6i5/qcSdtWBB5iPoL3IJiFM/ZgSDLD6jc5W7v8yOP0DEh/gv7F6eYeCufhmYZAigUiveR0FDR8YyORDFUWENLQzyP74ZzZs23cTXYEG6p9ByJujqx9IIEz3Sh336Jt+OX2PwoUfLMMRXp3qb9udUzry7/kKvUeBm8AGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=BYmI2JEx; arc=none smtp.client-ip=178.154.239.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-74.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-74.sas.yp-c.yandex.net [IPv6:2a02:6b8:c37:8f27:0:640:e8c0:0])
	by forward102b.mail.yandex.net (Yandex) with ESMTPS id EA2AF60D7E;
	Fri, 30 May 2025 12:48:21 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-74.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id KmTv6meLdGk0-Z4GG1Io6;
	Fri, 30 May 2025 12:48:21 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1748598501; bh=0FHP8kmV67CuuMxQRuqAcgMUA7ovCAbmaqmbD6Nl184=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=BYmI2JExRJTdoo89XTPFuNgLOWv9gVY5EJKWfs3Qa3tJacdjDt/g/5/y9hKBWGTj5
	 0Z9EoL329kbqWNEjaeD+wudwmUIyS/KBZyy3YyD6apNqzy9p7J66c+RdrdJmcJgtNU
	 /oem4kGlpKKWrg42JwQoVdipQhz3Xn+PT4Ex6gkU=
Authentication-Results: mail-nwsmtp-smtp-production-main-74.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Ahmed Salem <x0rw3ll@gmail.com>
Cc: linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] ACPICA: avoid out-of-bounds read in acpi_ut_safe_strncpy()
Date: Fri, 30 May 2025 12:47:37 +0300
Message-ID: <20250530094737.127830-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Running KASAN-enabled kernel with ACPI_DEBUG_OUTPUT, I've noticed
the following:

BUG: KASAN: global-out-of-bounds in acpi_ut_safe_strncpy+0x25/0x70
Read of size 16 at addr ffffffff8bf2bee0 by task swapper/0/1
CPU: 2 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.15.0-08486-gf66bc387efbe #17 PREEMPT(full)
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-4.fc42 04/01/2014

Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250
 ...
 kasan_check_range+0x2b0/0x2c0
 __asan_memcpy+0x29/0x70
 acpi_ut_safe_strncpy+0x25/0x70
 acpi_ps_alloc_op+0x201/0x3a0
 ...

The buggy address belongs to the variable:
 .str.8+0x0/0x20

This happens when 'acpi_ut_safe_strncpy()' makes an attempt to copy to
the destination which is larger than source, and may be fixed by using
'strscpy()' (which also guarantees NUL termination for a destination).

Fixes: ebf27765421c ("ACPICA: Replace strncpy() with memcpy()")
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 drivers/acpi/acpica/utnonansi.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/acpi/acpica/utnonansi.c b/drivers/acpi/acpica/utnonansi.c
index 803e3e893825..1447d8689209 100644
--- a/drivers/acpi/acpica/utnonansi.c
+++ b/drivers/acpi/acpica/utnonansi.c
@@ -166,10 +166,7 @@ acpi_ut_safe_strncat(char *dest,
 
 void acpi_ut_safe_strncpy(char *dest, char *source, acpi_size dest_size)
 {
-	/* Always terminate destination string */
-
-	memcpy(dest, source, dest_size);
-	dest[dest_size - 1] = 0;
+	strscpy(dest, source, dest_size);
 }
 
 #endif
-- 
2.49.0


