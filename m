Return-Path: <linux-acpi+bounces-16700-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 17646B54628
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Sep 2025 10:58:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BECCA4E1042
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Sep 2025 08:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CC1D1A3142;
	Fri, 12 Sep 2025 08:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="CCmrZAHf"
X-Original-To: linux-acpi@vger.kernel.org
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468B325B69F;
	Fri, 12 Sep 2025 08:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757667497; cv=none; b=d+1Y4UuxF6OKbobJH170ZPGuC4VOf5C5iL3dTD23CxFTzHbRPIMcg6mhxFEOvuXPHd3bIUJjkroyysKwpU68udtspy+nmsR//Tyhpy0KYUFCpA+TK5h07v87n+PoQ2lSI2dVnaSqX162m3B39mWmZMaZH5WE2cXoXDkGtuTzcVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757667497; c=relaxed/simple;
	bh=pXD1GOB0cbTdVj8FUueMhUDXO/nSK5ONCybwQdy2u1c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SeLueIm0zdgp1JzdVlAlthH16WUOxHJ3L8o0bYD4omswR7dQMvh3o50TxomeVNexfTdR9XG9HKJrJnOh2BNIpKBEutQfSNVrppTUcpUHmheYbYTw49/mWZuzo/Qk8ZMSvPhHksVIlgxVW0HWSibRYENYLq/B5gWTs5VK0wwZ1kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=CCmrZAHf; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1757667491; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=unvEIGeTlrpXSRjOs0JkLDP3YTUJCy8UNsc0fX9TNUs=;
	b=CCmrZAHflb9fd80UigVbCEaW7AchkeIbjy7K3MA9EasD2L84El3YdP6BKUjdbkCL/l8CuXA32Ns5zcoOdQRizG2/ojEojzJiQW4umoczCFyZE/tQQ9RHl/Qi7Q6Y18JnliVGGhV4Pve/CFNc5YdhkecO8lfd8jq74AFfwJkLyq4=
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com fp:SMTPD_---0Wnqfryp_1757667479 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 12 Sep 2025 16:58:10 +0800
From: cp0613@linux.alibaba.com
To: rafael@kernel.org,
	lenb@kernel.org,
	guoren@kernel.org,
	jeeheng.sia@starfivetech.com
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chen Pei <cp0613@linux.alibaba.com>
Subject: [PATCH] ACPI: SPCR: Support Precise Baud Rate filed
Date: Fri, 12 Sep 2025 16:57:56 +0800
Message-ID: <20250912085756.1742-1-cp0613@linux.alibaba.com>
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
 drivers/acpi/spcr.c | 56 ++++++++++++++++++++++++++-------------------
 1 file changed, 33 insertions(+), 23 deletions(-)

diff --git a/drivers/acpi/spcr.c b/drivers/acpi/spcr.c
index cd36a97b0ea2..69142c2ac4b3 100644
--- a/drivers/acpi/spcr.c
+++ b/drivers/acpi/spcr.c
@@ -146,29 +146,39 @@ int __init acpi_parse_spcr(bool enable_earlycon, bool enable_console)
 		goto done;
 	}
 
-	switch (table->baud_rate) {
-	case 0:
-		/*
-		 * SPCR 1.04 defines 0 as a preconfigured state of UART.
-		 * Assume firmware or bootloader configures console correctly.
-		 */
-		baud_rate = 0;
-		break;
-	case 3:
-		baud_rate = 9600;
-		break;
-	case 4:
-		baud_rate = 19200;
-		break;
-	case 6:
-		baud_rate = 57600;
-		break;
-	case 7:
-		baud_rate = 115200;
-		break;
-	default:
-		err = -ENOENT;
-		goto done;
+	/*
+	 * SPCR 1.09 defines Precise Baud Rate Filed contains a specific
+	 * non-zero baud rate which overrides the value of the Configured
+	 * Baud Rate field. If this field is zero or not present, Configured
+	 * Baud Rate is used.
+	 */
+	if (table->precise_baudrate)
+		baud_rate = table->precise_baudrate;
+	else {
+		switch (table->baud_rate) {
+		case 0:
+			/*
+			 * SPCR 1.04 defines 0 as a preconfigured state of UART.
+			 * Assume firmware or bootloader configures console correctly.
+			 */
+			baud_rate = 0;
+			break;
+		case 3:
+			baud_rate = 9600;
+			break;
+		case 4:
+			baud_rate = 19200;
+			break;
+		case 6:
+			baud_rate = 57600;
+			break;
+		case 7:
+			baud_rate = 115200;
+			break;
+		default:
+			err = -ENOENT;
+			goto done;
+		}
 	}
 
 	/*
-- 
2.49.0


