Return-Path: <linux-acpi+bounces-16381-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3178BB445C0
	for <lists+linux-acpi@lfdr.de>; Thu,  4 Sep 2025 20:48:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F44C1CC153E
	for <lists+linux-acpi@lfdr.de>; Thu,  4 Sep 2025 18:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE90C2550CC;
	Thu,  4 Sep 2025 18:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="HFHnCdaI"
X-Original-To: linux-acpi@vger.kernel.org
Received: from iguana.tulip.relay.mailchannels.net (iguana.tulip.relay.mailchannels.net [23.83.218.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B775E2505A5;
	Thu,  4 Sep 2025 18:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.218.253
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757011699; cv=pass; b=VhyfTGwCALwG3yYsG1maP/iT64xLb5hg7nXjI/zW6wCatJfVc/fnwowTM65nrM9eFAakkXOZuvWr8xUqp0vHYwUXP7s2pIMwGvITZ/HvJdmLlAhMF2q66xPBlbJM/WjvoQ8PoNnFdMrwwbcyHX9ExtgCbejxEyL1Nlaiaycw7mY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757011699; c=relaxed/simple;
	bh=zVBoUBDk6LNpa2rPxcMF/px2EY2Tk2CJDQheuO7cQvY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KNcymR44bqRQU/tjgqfGBYgLKz9F3UVC16fDcfOzIV0/mra7KIH+kH2qvBMMzBHCFXEF6+DF/cJaNTReTRIu9cVHmVWG1CQV3DB0FtOjBAX2evUMA6BvB7McxYFyAo13yuvY7Cke28BDtPNqhVfsIG6nVBdDrbhzbKpNIRGTlII=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=HFHnCdaI; arc=pass smtp.client-ip=23.83.218.253
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 47F7C783F7E;
	Thu,  4 Sep 2025 18:48:11 +0000 (UTC)
Received: from pdx1-sub0-mail-a216.dreamhost.com (100-102-90-158.trex-nlb.outbound.svc.cluster.local [100.102.90.158])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id BA59878263F;
	Thu,  4 Sep 2025 18:48:10 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1757011690; a=rsa-sha256;
	cv=none;
	b=mwot+RoSt5WFH1Z2E8QaaT4REcB/hB9DIJHg530BkZMCMJF+RZGYEys8KAvoppkdN9PMOv
	QQx+kMSNIM5Cd6eVwcj3Axbv2CSJaNbGTZb0SlbJqnsAgmrKcAfsrUkDEvLRqNpEB6MUcx
	dS8HaPneswOSvrCziy0Za04PQT+AMGjof8KHoMTAgjk2kAPlWBjoWX2b6Cvq5aQ8HMqeTZ
	viQnLSHJKGQnsoRrJ50XMdBiioZlhNmJpWZGF8DGwe+FRcvoANL/DBUBreBvBjtk6+iP1b
	65gvLwUoVz3E1ooUwfBqNT3OgpAv2VFpUaDnWyC40LnUDi7k1b9UCFYLuEcBCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1757011690;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=JHwOvcWkt+mIE9FpPBs3qDJ2IlTxHvz63kAx8Lygg0I=;
	b=vfftwxu6mISPizFvw+ys4XbngjJCTPXvUKEv+LydfvRS+75gvN9tgyOfivTFd78eAgLt79
	QIlzjtyiCXQDrO7pubGfG1KlH6doj19EsMGV/F1nL/+Azl9ETCFD7YVjI0hDr6V9PZwxpx
	LcCh9HstHGIVsaRKrJYHB/n7w76BssV6gZSycY1aoUyrLPxoRUyknhU0QFSGqjR41uWaxF
	c1WLacWo4SLeQjL7vHtq49sBvsAlcOiSrC98FZGpRb1nTamcFUExKmZuarN1aBsKtH/jO8
	m6audvB7KBAQU0FDcecXzCERkQgLDwOezrZS2O0ulcPvixY36OvKvdBvYvBkOg==
ARC-Authentication-Results: i=1;
	rspamd-8b9589799-n4rjh;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Abiding-Robust: 1681329f306e1448_1757011691083_2189893994
X-MC-Loop-Signature: 1757011691083:16660094
X-MC-Ingress-Time: 1757011691082
Received: from pdx1-sub0-mail-a216.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.102.90.158 (trex/7.1.3);
	Thu, 04 Sep 2025 18:48:11 +0000
Received: from offworld.lan (syn-076-167-199-067.res.spectrum.com [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a216.dreamhost.com (Postfix) with ESMTPSA id 4cHpQK6ZVjz6h;
	Thu,  4 Sep 2025 11:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1757011690;
	bh=JHwOvcWkt+mIE9FpPBs3qDJ2IlTxHvz63kAx8Lygg0I=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=HFHnCdaIzZmtUjZjuUTA1pQ1JK0Wa0SWQ7VtvQkO73MSCUr0C4Z/dyQhKFmITdVV1
	 xykVe4xWV92q7qbdMfdjK8sBIHDDEHALiVzyVYCvMc3KoR6jvPCMbCoQpBwFxbJ+6Z
	 vCBB+D+Lj1SUTvii5qLGk9i4ax8bahChbqcucNV0zN81d5/3JBX02Qd7Wl46b+vQqU
	 Y9vzGvXPMUwoY9wR+CwfkXgWnB1ATyV90NeNr70BO9sRPtgcV/9MgRbC4TuMou5+9d
	 ZbSism92LpVhgaZ+qW5x4Risc2aI87L3pqcIFMpbGVIItN4CAQ9BmWJx2HwQfLSFM1
	 eP8JFOR8OZcHw==
From: Davidlohr Bueso <dave@stgolabs.net>
To: rafael.j.wysocki@intel.com,
	dave.jiang@intel.com
Cc: dan.j.williams@intel.com,
	jonathan.cameron@huawei.com,
	alejandro.lucero-palau@amd.com,
	ira.weiny@intel.com,
	alison.schofield@intel.com,
	a.manzanares@samsung.com,
	linux-acpi@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Davidlohr Bueso <dave@stgolabs.net>
Subject: [PATCH] acpi, tables: Rename coherency CFMW restrictions
Date: Thu,  4 Sep 2025 11:48:01 -0700
Message-Id: <20250904184801.47498-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ACPICA commit 710745713ad3a2543dbfb70e84764f31f0e46bdc

This has been renamed in more recent CXL specs, as
type3 (memory expanders) can also use HDM-DB for
device coherent memory.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 drivers/cxl/acpi.c           |  4 ++--
 include/acpi/actbl1.h        |  4 ++--
 tools/testing/cxl/test/cxl.c | 18 +++++++++---------
 3 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 26c494704437..2cf75b553f26 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -128,9 +128,9 @@ static unsigned long cfmws_to_decoder_flags(int restrictions)
 {
 	unsigned long flags = CXL_DECODER_F_ENABLE;
 
-	if (restrictions & ACPI_CEDT_CFMWS_RESTRICT_TYPE2)
+	if (restrictions & ACPI_CEDT_CFMWS_RESTRICT_DEVMEM)
 		flags |= CXL_DECODER_F_TYPE2;
-	if (restrictions & ACPI_CEDT_CFMWS_RESTRICT_TYPE3)
+	if (restrictions & ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYMEM)
 		flags |= CXL_DECODER_F_TYPE3;
 	if (restrictions & ACPI_CEDT_CFMWS_RESTRICT_VOLATILE)
 		flags |= CXL_DECODER_F_RAM;
diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
index 99fd1588ff38..eb787dfbd2fa 100644
--- a/include/acpi/actbl1.h
+++ b/include/acpi/actbl1.h
@@ -560,8 +560,8 @@ struct acpi_cedt_cfmws_target_element {
 
 /* Values for Restrictions field above */
 
-#define ACPI_CEDT_CFMWS_RESTRICT_TYPE2      (1)
-#define ACPI_CEDT_CFMWS_RESTRICT_TYPE3      (1<<1)
+#define ACPI_CEDT_CFMWS_RESTRICT_DEVMEM      (1)
+#define ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYMEM (1<<1)
 #define ACPI_CEDT_CFMWS_RESTRICT_VOLATILE   (1<<2)
 #define ACPI_CEDT_CFMWS_RESTRICT_PMEM       (1<<3)
 #define ACPI_CEDT_CFMWS_RESTRICT_FIXED      (1<<4)
diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index 6a25cca5636f..ba50338f8ada 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -210,7 +210,7 @@ static struct {
 			},
 			.interleave_ways = 0,
 			.granularity = 4,
-			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_TYPE3 |
+			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYMEM |
 					ACPI_CEDT_CFMWS_RESTRICT_VOLATILE,
 			.qtg_id = FAKE_QTG_ID,
 			.window_size = SZ_256M * 4UL,
@@ -225,7 +225,7 @@ static struct {
 			},
 			.interleave_ways = 1,
 			.granularity = 4,
-			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_TYPE3 |
+			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYMEM |
 					ACPI_CEDT_CFMWS_RESTRICT_VOLATILE,
 			.qtg_id = FAKE_QTG_ID,
 			.window_size = SZ_256M * 8UL,
@@ -240,7 +240,7 @@ static struct {
 			},
 			.interleave_ways = 0,
 			.granularity = 4,
-			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_TYPE3 |
+			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYMEM |
 					ACPI_CEDT_CFMWS_RESTRICT_PMEM,
 			.qtg_id = FAKE_QTG_ID,
 			.window_size = SZ_256M * 4UL,
@@ -255,7 +255,7 @@ static struct {
 			},
 			.interleave_ways = 1,
 			.granularity = 4,
-			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_TYPE3 |
+			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYMEM |
 					ACPI_CEDT_CFMWS_RESTRICT_PMEM,
 			.qtg_id = FAKE_QTG_ID,
 			.window_size = SZ_256M * 8UL,
@@ -270,7 +270,7 @@ static struct {
 			},
 			.interleave_ways = 0,
 			.granularity = 4,
-			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_TYPE3 |
+			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYMEM |
 					ACPI_CEDT_CFMWS_RESTRICT_PMEM,
 			.qtg_id = FAKE_QTG_ID,
 			.window_size = SZ_256M * 4UL,
@@ -285,7 +285,7 @@ static struct {
 			},
 			.interleave_ways = 0,
 			.granularity = 4,
-			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_TYPE3 |
+			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYMEM |
 					ACPI_CEDT_CFMWS_RESTRICT_VOLATILE,
 			.qtg_id = FAKE_QTG_ID,
 			.window_size = SZ_256M,
@@ -302,7 +302,7 @@ static struct {
 			.interleave_arithmetic = ACPI_CEDT_CFMWS_ARITHMETIC_XOR,
 			.interleave_ways = 0,
 			.granularity = 4,
-			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_TYPE3 |
+			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYMEM |
 					ACPI_CEDT_CFMWS_RESTRICT_PMEM,
 			.qtg_id = FAKE_QTG_ID,
 			.window_size = SZ_256M * 8UL,
@@ -318,7 +318,7 @@ static struct {
 			.interleave_arithmetic = ACPI_CEDT_CFMWS_ARITHMETIC_XOR,
 			.interleave_ways = 1,
 			.granularity = 0,
-			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_TYPE3 |
+			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYMEM |
 					ACPI_CEDT_CFMWS_RESTRICT_PMEM,
 			.qtg_id = FAKE_QTG_ID,
 			.window_size = SZ_256M * 8UL,
@@ -334,7 +334,7 @@ static struct {
 			.interleave_arithmetic = ACPI_CEDT_CFMWS_ARITHMETIC_XOR,
 			.interleave_ways = 8,
 			.granularity = 1,
-			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_TYPE3 |
+			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYMEM |
 					ACPI_CEDT_CFMWS_RESTRICT_PMEM,
 			.qtg_id = FAKE_QTG_ID,
 			.window_size = SZ_512M * 6UL,
-- 
2.39.5


