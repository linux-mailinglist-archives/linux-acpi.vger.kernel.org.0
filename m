Return-Path: <linux-acpi+bounces-16507-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3782FB499E8
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Sep 2025 21:28:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E76B1BC2D94
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Sep 2025 19:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C519427F012;
	Mon,  8 Sep 2025 19:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="A8A6E8ZP"
X-Original-To: linux-acpi@vger.kernel.org
Received: from silver.cherry.relay.mailchannels.net (silver.cherry.relay.mailchannels.net [23.83.223.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B88327EC99;
	Mon,  8 Sep 2025 19:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.223.166
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757359701; cv=pass; b=eRXoPoA/2e+RRCcOn5hOfjM/7Qnp5BtFd9rUTA/Jx5kJmCB8NuszKV5YSViduWTXFLw18G4LB8sbCAPTRMslK2gkkleMMpDV/JsA4G2ewNOlkNFjDamHW8bSrCzEybjnmuN62zmjbDjJRQ6UnnXw3jNic6eU9tWuJ1f8Ss0PLqE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757359701; c=relaxed/simple;
	bh=tnWf8OCqVXBo4JcyurtaqL5pbuuuVwoSJW0rtNu/iU4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ct+pycXp82GBSUTgAuKO+vad8e/olXkRteX25h2sMgrASchG8Oz5aAA9c8DhoqJfdDP8Kfswym59v0jSBKxo/rtk5tjsyi66+0iTgPUwhl04ARPlkGWD7qmFUrslmXyaFXcr0a8gp84OdE4T+rbO/+pW/QxBAbho3JL+Co6Nvpk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=A8A6E8ZP; arc=pass smtp.client-ip=23.83.223.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 2DF221C5834;
	Mon,  8 Sep 2025 16:01:05 +0000 (UTC)
Received: from pdx1-sub0-mail-a205.dreamhost.com (trex-blue-4.trex.outbound.svc.cluster.local [100.107.18.138])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 44FCC1C4A0B;
	Mon,  8 Sep 2025 16:00:40 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1757347249; a=rsa-sha256;
	cv=none;
	b=oOePyCmVB4qfF4gT5vakgdpLOtCcTiYw3t0btYCZ/712p4wEggNpfK2u86Nw6PIwd2jY98
	9DK7A+Oss6DnKSq2Mxq1MCSubR5SbwaYxAW8vXlmxebM6mABeNyRk77Igg3dkeEgLUGIVw
	5jrhlZfgCCm7xzGKN3xSqIAb+v39WF7rX/u2c/7L56kzIwiexJAja9SbJ7YhjcaoxmyoYJ
	eeJyuB0yYrTrR7Xq88oE901aqfX0PPa3JzZHEEfQJwnq0jin+HHcpbpXcB2Aca7JId2Lio
	7mul3GW2pQWkBsxB9qYekb6nEf9idzeRA0bof5SzsQFWu22TfCy59O0CXcKl5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1757347249;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=dHk/0tmtJMYbCOXHOucJ8cznc/d1xX4q5DHhMkM57b8=;
	b=9biPKlbhF3qaJ9FywvFTG0QZ8Y4iYO32IFPlPKN5qyl8Rd4IGQRCKqzYmi1cISyPWl3c5e
	a8+8U8qdWE5wBFKI15quGyjVM2NaXddFPB1+Vur5SnQeWx85mRM1Gdk1i3F5zQMUcedby8
	GKD+toF5gbr51RHv0FWl9dyYb7/NZTGeqmg+5rvktDlWFTm+AjRETgQw1hBrYfVtbPPBJs
	fZD4o9dF68Ti7UHVrY6wC7d3jAEpmO0VRnxTeljwA8FZDMx92w2VuqKqzJLoinfEcvVnw3
	fhMh5CZEruDOJ0lNWULdWbpivpJ50E4rvCnaM2BQQt3czvgioEAg8cvSDM/bXA==
ARC-Authentication-Results: i=1;
	rspamd-9968f48fc-22hz2;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Fearful-Battle: 2a8f7a9e5c3185be_1757347250172_4040245632
X-MC-Loop-Signature: 1757347250172:3171356223
X-MC-Ingress-Time: 1757347250172
Received: from pdx1-sub0-mail-a205.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.107.18.138 (trex/7.1.3);
	Mon, 08 Sep 2025 16:00:49 +0000
Received: from offworld.lan (syn-076-167-199-067.res.spectrum.com [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a205.dreamhost.com (Postfix) with ESMTPSA id 4cLBWB1v9lzF1;
	Mon,  8 Sep 2025 09:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1757347239;
	bh=dHk/0tmtJMYbCOXHOucJ8cznc/d1xX4q5DHhMkM57b8=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=A8A6E8ZPXJ5XNH2297PoWdarG2UGJI3EAVmvWNCtV9LssfnPLTHbfA+VGDFF7iWMl
	 f8M8gfRNkirGOrhd5ZQibsw3Aa1uuM75uQSGxCgojYTtr+mCdjc/e77Qr/Wk1fDjB3
	 HnOn/YrytGRKz9XlpLg8jTeSGzONvpoMuTHSr3e2fRf4l4UuqNgmXLLPAdYLQbZ2re
	 kUYyQJjkHI8med60dsBzKFPJsXdIUNQoG3ibwCYWIc6Rl2KBvcgFTAvdLGEL5NOIhn
	 NKkWRxbMo2Y4jWMP+K38pebQKbemYCdVOqhtsgldlzO4iSVAOOVgZdeCIQnqfhgtR3
	 aYhSWfQrJ522Q==
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
	Davidlohr Bueso <dave@stgolabs.net>,
	"Rafael J . Wysocki" <rafael@kernel.org>
Subject: [PATCH v2] cxl/acpi: Rename CFMW coherency restrictions
Date: Mon,  8 Sep 2025 09:00:34 -0700
Message-Id: <20250908160034.86471-1-dave@stgolabs.net>
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

Link: https://github.com/acpica/acpica/commit/710745713ad3a2543dbfb70e84764f31f0e46bdc
Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>
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


