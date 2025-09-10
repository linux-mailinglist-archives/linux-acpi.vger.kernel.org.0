Return-Path: <linux-acpi+bounces-16567-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2240CB512E3
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Sep 2025 11:42:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FCB9189BDBD
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Sep 2025 09:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11365314A78;
	Wed, 10 Sep 2025 09:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="oTm2T3Ip"
X-Original-To: linux-acpi@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED9A3148C6;
	Wed, 10 Sep 2025 09:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757497323; cv=none; b=T1t3/m302V484v5Tq8eQaquPsrXhkzZdZYXIH88hbicjNjbLd8M/8a92qUWO3YUDRCKK7P4Rx88t5VquJbUCOfj+KUdVngVg4mnJQbyC5j1QlhAsC1hRDR97+EZrrIIkvpceZ2owOTb1RNt4t+dPGcQLSioVzsITs2IfSh/leUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757497323; c=relaxed/simple;
	bh=uw3AP+ZggIuTz/107yrTqEM9W/STfScu5gps/mdGbtM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=vBez2hxzZYlrdXUeRWWh4nzMoZPXQVlEkidkmT+Ln5rClbaX/yfDetBIALn13lPSU9WVCq2kYNcl3hb39P9e8zTXYxVRXwnOOEAPP5QCFhwA5TUamtAIy1oM0Bb+wtZZvbj0iPXnjsgAC92JzyVdPbz4/dPFA3MKn5xBjK0dG8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=oTm2T3Ip; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1757497317; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=drmcW2Ckjhxcey4MSWp5CHONvSvb7q2f8a1if2Lgu54=;
	b=oTm2T3IpTqz9yXzzruBeeB31uiRu6+eCiSQqRK4+zEys/mn2uGaCGGIgTXhOtSLZVB3J+JerVyhtJtrosLScJ+KfS1k6aSZFpYqVkm6gX9COP0yHQTkJwty7IhlAo5uDjyAvqbuOROoiScnpPFw5t3PVoCZ9E5cNN5J1zgY5DrQ=
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com fp:SMTPD_---0Wnha8WD_1757497313 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 10 Sep 2025 17:41:57 +0800
From: cp0613@linux.alibaba.com
To: rafael@kernel.org,
	lenb@kernel.org,
	guoren@kernel.org,
	jeeheng.sia@starfivetech.com
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chen Pei <cp0613@linux.alibaba.com>
Subject: [PATCH] ACPI: SPCR: Add support for DBG2 RISC-V SBI port subtype
Date: Wed, 10 Sep 2025 17:41:36 +0800
Message-ID: <20250910094136.4423-1-cp0613@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen Pei <cp0613@linux.alibaba.com>

The commit 4aca2bef90bd1296 ("ACPICA: Headers: Add RISC-V SBI Subtype
to DBG2") has added the definition of ACPI_DBG2_RISCV_SBI_CON.

This patch continues to implement its function so that the parameters
of uart can be configured correctly. Subsequent calls to setup_earlycon
to reuse the earlycon based on sbi.

Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>
---
 drivers/acpi/spcr.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/acpi/spcr.c b/drivers/acpi/spcr.c
index cd36a97b0ea2..208d6bbc65e0 100644
--- a/drivers/acpi/spcr.c
+++ b/drivers/acpi/spcr.c
@@ -141,6 +141,9 @@ int __init acpi_parse_spcr(bool enable_earlycon, bool enable_console)
 	case ACPI_DBG2_16550_NVIDIA:
 		uart = "uart";
 		break;
+	case ACPI_DBG2_RISCV_SBI_CON:
+		uart = "sbi";
+		break;
 	default:
 		err = -ENOENT;
 		goto done;
-- 
2.49.0


