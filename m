Return-Path: <linux-acpi+bounces-16723-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C9BFB54DC6
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Sep 2025 14:31:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9ADB217A004
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Sep 2025 12:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90F0C311C03;
	Fri, 12 Sep 2025 12:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="DNo4tpsG"
X-Original-To: linux-acpi@vger.kernel.org
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665C83112BB;
	Fri, 12 Sep 2025 12:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757679925; cv=none; b=Vi8OZMrTmvpcQqZrwpgpxZACSrOvWrNuTSe3/SI5LDdD6EJQIkRM8hyLAVg3koheoTVOa/T+onlDMQ2gR3ubN2TwOoWrd+knPNigcVjl5UEATLs8BNIZMgWx0DP60iQu+2wYVgX+WBeN1fdhjTT1988guN/IAcSkbKfbxq3HAvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757679925; c=relaxed/simple;
	bh=5nT/wxso1ClexhEwU9wf9VV5ahhYIiPbAkvmh86C1SU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S06TtH1Ho5dqc6eWcTOGDu/bTTuDgYTmNubV/aooCiVd23OI8SSrKim1zWq2xFLdaFOtqVCoxsplS2Tn8+UY789YMTymjochkg+IIpla03wx/yXWYdBNksAuY2z1ksUuqVsDCPEpY4KN1E3H1YOkfLrBGNvldhng3pIvwGzoMb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=DNo4tpsG; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1757679919; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=Vw4bLV5JSDa5YV80BV+CFESp5VPTl9W3M3spAbxNswU=;
	b=DNo4tpsGVegYsqqs2WzQh8AmFrnHbVWQJiGLR7bEe5pEJuml1Fa0Zu2tu75ybclz8h3PuQwPAmYbL4WIIEVG+CwfnhMsDyvdnu+mtHAQrqKAY6OCSuLGN+YpuNy//wNgnjUyXUqxCiPS7g4hFHyyQ55rkRYbIQWADldwLjDmTPk=
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com fp:SMTPD_---0Wnr7gxV_1757679915 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 12 Sep 2025 20:25:19 +0800
From: cp0613@linux.alibaba.com
To: rafael@kernel.org,
	lenb@kernel.org,
	guoren@kernel.org,
	jeeheng.sia@starfivetech.com
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chen Pei <cp0613@linux.alibaba.com>
Subject: [PATCH v2] ACPI: SPCR: Support Precise Baud Rate filed
Date: Fri, 12 Sep 2025 20:25:14 +0800
Message-ID: <20250912122514.2303-1-cp0613@linux.alibaba.com>
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
 drivers/acpi/spcr.c | 54 ++++++++++++++++++++++++++-------------------
 1 file changed, 31 insertions(+), 23 deletions(-)

diff --git a/drivers/acpi/spcr.c b/drivers/acpi/spcr.c
index cd36a97b0ea2..a97b02ee5538 100644
--- a/drivers/acpi/spcr.c
+++ b/drivers/acpi/spcr.c
@@ -146,29 +146,37 @@ int __init acpi_parse_spcr(bool enable_earlycon, bool enable_console)
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
+	else switch (table->baud_rate) {
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
 	}
 
 	/*
-- 
2.49.0


