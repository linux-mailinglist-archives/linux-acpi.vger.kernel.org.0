Return-Path: <linux-acpi+bounces-16845-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD32DB55F17
	for <lists+linux-acpi@lfdr.de>; Sat, 13 Sep 2025 09:08:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00BD37B468D
	for <lists+linux-acpi@lfdr.de>; Sat, 13 Sep 2025 07:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73D262DCF44;
	Sat, 13 Sep 2025 07:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="UuuxdnBj"
X-Original-To: linux-acpi@vger.kernel.org
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4559F1E834F;
	Sat, 13 Sep 2025 07:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757747307; cv=none; b=UxtrvpqB/NdB6AjYVqcDLAFHtsPMVA5PY3S0nuhYAf5lDnJgHmx64aICGrgQZWz1j6M/ZHY3FERXYJCZNyPWMUkfof4M0crqREUpeI8zb3eGQ9bQ66NPQZIDcOtqTvKSUdN4ts/oORvx1E7aG1zmvLx5ia85o37jWgCpQObsbaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757747307; c=relaxed/simple;
	bh=MKLj1EvDHHG41eQW2ovKCQ4Pq8nz+LM7NJh0jYVwNlM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c5E39JzsbqVJCseg72P6SzO10jz8gVQ1Wxmq0+I5BOClI6ZRh7H5BVP03tgYIL88vtmiQg7qGuxlsTFPNddc9KXoKWgRAUUV5gle5GatlVcRd1pByK/lM/rNOtIB5JJZcPFroWJoAgTFrxl5ZH//sPTOwAxDfjIGbHKCzmL1WDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=UuuxdnBj; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1757747300; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=I/jdtq6NNXrjZaLXiSN0QGDNGA++av7AiEkNwlYW1xo=;
	b=UuuxdnBjcAnLGjF/Y4ARZqDY7sXfABvdRs5rYLrGYQsBZRcTYnQsy8z7iqt3l1JrWWJ6UU91XwqJCugHgHRC0IXm/koRvV+rjdD/E4UQQ6T0EQJdI9O0gfuO8KoQofF0lBOLYmZos9IgD30F4DvTz0qKKZyTACaHIs/RVsRJDT4=
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com fp:SMTPD_---0WnsuL5U_1757747295 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 13 Sep 2025 15:08:20 +0800
From: cp0613@linux.alibaba.com
To: rafael@kernel.org,
	lenb@kernel.org,
	guoren@kernel.org,
	jeeheng.sia@starfivetech.com
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chen Pei <cp0613@linux.alibaba.com>
Subject: [PATCH v3] ACPI: SPCR: Support Precise Baud Rate filed
Date: Sat, 13 Sep 2025 15:08:15 +0800
Message-ID: <20250913070815.16758-1-cp0613@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen Pei <cp0613@linux.alibaba.com>

The Microsoft Serial Port Console Redirection (SPCR) specification
revision 1.09 comprises additional field: Precise Baud Rate [1].

It is used to describe non-traditional baud rates (such as those
used by high-speed UARTs).

It contains a specific non-zero baud rate which overrides the value
of the Configured Baud Rate field. If this field is zero or not
present, Configured Baud Rate is used.

Link: https://learn.microsoft.com/en-us/windows-hardware/drivers/serports/serial-port-console-redirection-table # 1

Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>
---
 drivers/acpi/spcr.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/spcr.c b/drivers/acpi/spcr.c
index cd36a97b0ea2..fa12e740386d 100644
--- a/drivers/acpi/spcr.c
+++ b/drivers/acpi/spcr.c
@@ -146,7 +146,15 @@ int __init acpi_parse_spcr(bool enable_earlycon, bool enable_console)
 		goto done;
 	}
 
-	switch (table->baud_rate) {
+	/*
+	 * SPCR 1.09 defines Precise Baud Rate Filed contains a specific
+	 * non-zero baud rate which overrides the value of the Configured
+	 * Baud Rate field. If this field is zero or not present, Configured
+	 * Baud Rate is used.
+	 */
+	if (table->precise_baudrate)
+		baud_rate = table->precise_baudrate;
+	else switch (table->baud_rate) {
 	case 0:
 		/*
 		 * SPCR 1.04 defines 0 as a preconfigured state of UART.
-- 
2.49.0


