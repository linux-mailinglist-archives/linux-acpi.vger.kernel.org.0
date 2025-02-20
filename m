Return-Path: <linux-acpi+bounces-11338-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FFCCA3D05F
	for <lists+linux-acpi@lfdr.de>; Thu, 20 Feb 2025 05:22:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2169189E9D6
	for <lists+linux-acpi@lfdr.de>; Thu, 20 Feb 2025 04:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99CED1DF992;
	Thu, 20 Feb 2025 04:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="H3K0DN2e"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807211DF97F;
	Thu, 20 Feb 2025 04:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740025338; cv=none; b=KeAutpTf2oymMDZO/hwwB8DL4IfggPfhXCM2+NKrYvkYLiuLkbYPzDtQT4E+Mju1Ze+cSN58PufrVLqpSOGDUwB+J8mVgbI9XVtcdj5CE3DmpYa7WsB9aMF4U+J6laqlSV6U/TNY4GUbc88SHL0+rfp8L7TpSkWdnN3c31L8EoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740025338; c=relaxed/simple;
	bh=ZpbQYYqPfBwqAi+EvQ56HTQ50vCGCqHqA9vlVu5HsHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Uv2CV5ggE7i1q0KrbaQ6bFxg7ZYI7hAz6wYUZcYX+Vr3/NvJExf298We5JVcAK1bDHztg5yRmNDPLFmFs0Lfy5jJV/gpYdJ2kQSFfunAkaBERAaLzaVJcKME6dKG693XesH1G//4CHbmlgqTLoDA8n9sLay08RFoa58bNi0Mqd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=H3K0DN2e; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1740025295;
	bh=snU/JuNdQbqD/yBp3kwEH7MmPngVPYjJTzwEBOQ5weU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=H3K0DN2eFiq6AzZB0meYM0lHVq37OeSD+fijuPmQFSHlwmNR9rZAEDwRxKcv8awSq
	 7s7m1vcNYbeRqIBZwLZioV8BWeU3xt7FJIsCghQJZFLPQItFzmy5BC6bZH6g7jsNXl
	 o6u/UljspLA0U+QT5mpDcrZ4CK4XgPjYGqVxV5w4=
X-QQ-mid: bizesmtpip2t1740025242treh9xo
X-QQ-Originating-IP: 3KC212wm0bcFBkDU6Pf1UmgXiopVepGDyXZaqzVIgWc=
Received: from localhost.localdomain ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 20 Feb 2025 12:20:40 +0800 (CST)
X-QQ-SSF: 0002000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 10374400301936631136
From: WangYuli <wangyuli@uniontech.com>
To: chenhuacai@kernel.org,
	kernel@xen0n.name,
	rafael@kernel.org,
	lenb@kernel.org
Cc: wangyuli@uniontech.com,
	maobibo@loongson.cn,
	guanwentao@uniontech.com,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Jonathan.Cameron@huawei.com,
	dan.j.williams@intel.com,
	alison.schofield@intel.com,
	rrichter@amd.com,
	bfaccini@nvidia.com,
	dave.jiang@intel.com,
	haibo1.xu@intel.com,
	rppt@kernel.org,
	linux-acpi@vger.kernel.org,
	zhanjun@uniontech.com,
	niecheng1@uniontech.com,
	chenlinxuan@uniontech.com
Subject: [PATCH] ACPI: NUMA: Move get_numa_distances_cnt() helper to needed location
Date: Thu, 20 Feb 2025 12:20:37 +0800
Message-ID: <D87315C93AF20D4E+20250220042037.942802-1-wangyuli@uniontech.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: OM0exKGC/eNyJV+qTER9+vsTDDZeCB+mx1flhOzFE6pkbKc/gWYnDHN8
	rQNsyOrlx7nAu3c+paJGIFBmTQhEb8a8ZkGKX2qmlgHReg6hmrKsVpjj6qCWLxZf4aPdT01
	GGNS0oSkEskywGuX6I2Gg9AfTnOUGbzev/z+kgjlmOsYqOAhz2g94ny4kaSzJ51d9iFi05d
	gk3otcF9FQnGQRMmXQ1mMCu2j5EDkUm5vaDhy/GdB5ypNE3UaS4G8T15X6goWKThUuE2hCR
	D67FLqb7ILV+xI3FHURzxHlnXFrHuvXW2ZY9dVZmxjGqXG4o485VSSkbyKM4IemqHF9Pm4X
	Ta0SVN+DLTMGfrE0jZD41WewWgYmplBe8sH8kzSVkBHIdK1RnvlY9d3VUg4Y72LOroQkbNr
	yQ2rlzrQRNtGHAJPaHw49Ark3GQw62wSylrM5nicNaQZ28dZwHwbMY/sfuPiLYM85HrswlG
	74lSguauGgfi+jjZSG7TUAbGVqaiztL0IEvqqBjtelJmoEbOu4lUlfU0gSvSuy9Y77lxCoi
	JirOtEjcEbXSDuh7KyF0FYK0rzFNaYk2hGaRmvtd3UvAbW8Js368YvvN+kRXp12FKI0FVtz
	Fb3Hjf0KmwhoqgRSc/AZn8FLU8CHbpOuie640208HD3yqrcjYpECqy9NiTl5qslFEwFGEd4
	CYrS3z2jisj5hxw+lCq5rAYkNIsrClas6sMFnumtmp8fImfEhTHUvXcT1vy3GuGETXvyE0X
	sEWYR7Djtp4gFV7+tA6soYtastl5fBCwPCKXqnq3p9uV7Aeey8IKJZkEocSEIuV2nOWOnMb
	uaCv02sFYxtyVMqMjE/a92EuJ0HfrZByvzW6erEavSsLSRIZENQWdMksQRmEnrUyS+2x8e1
	1QKeQTDixNNSrFxGM5ngFiDhgwj8A3tSTc/GQHUGBnvLf8ucTHgUYa5iIwL4/w3jplVfUwQ
	Z2qex1hwKBDWkPKw6gOUVr7/Qy8fN/J0zXygI5YKctYh07OV4cg8lPWGh7AFetx+WWf8wka
	I1ro0UEv8IdbRrysaP
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
X-QQ-RECHKSPAM: 0

In LoongArch, get_numa_distances_cnt() was not in use, resulting in
a compiler warning.

Serendipitously, drivers/acpi/numa/srat.c appears to be a more
relevant location for this helper function, hence its relocation.

This commit not only resolves these immediate concerns but also sets
the groundwork for potential future integration of ACPI related logic
from other architectures into this driver module.

Separately, the locality_count member in struct acpi_table_slit is
typed as u64. Adapt the function type to eliminate potential code
risks.

Fix follow errors with clang-18 when W=1e:

arch/loongarch/kernel/acpi.c:259:28: error: unused function 'get_numa_distances_cnt' [-Werror,-Wunused-function]
  259 | static inline unsigned int get_numa_distances_cnt(struct acpi_table_slit *slit)
      |                            ^~~~~~~~~~~~~~~~~~~~~~
1 error generated.

Signed-off-by: WangYuli <wangyuli@uniontech.com>
---
 arch/loongarch/kernel/acpi.c |  5 -----
 drivers/acpi/numa/srat.c     | 13 +++++++++----
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/loongarch/kernel/acpi.c b/arch/loongarch/kernel/acpi.c
index ee471a80763e..90cc9250f121 100644
--- a/arch/loongarch/kernel/acpi.c
+++ b/arch/loongarch/kernel/acpi.c
@@ -256,11 +256,6 @@ static __init int setup_node(int pxm)
  */
 unsigned int numa_distance_cnt;
 
-static inline unsigned int get_numa_distances_cnt(struct acpi_table_slit *slit)
-{
-	return slit->locality_count;
-}
-
 void __init numa_set_distance(int from, int to, int distance)
 {
 	if ((u8)distance != distance || (from == to && distance != LOCAL_DISTANCE)) {
diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
index 00ac0d7bb8c9..36053ae3dad6 100644
--- a/drivers/acpi/numa/srat.c
+++ b/drivers/acpi/numa/srat.c
@@ -283,6 +283,11 @@ acpi_table_print_srat_entry(struct acpi_subtable_header *header)
 	}
 }
 
+static inline u64 get_numa_distances_cnt(struct acpi_table_slit *slit)
+{
+	return slit->locality_count;
+}
+
 /*
  * A lot of BIOS fill in 10 (= no distance) everywhere. This messes
  * up the NUMA heuristics which wants the local node to have a smaller
@@ -292,7 +297,7 @@ acpi_table_print_srat_entry(struct acpi_subtable_header *header)
 static int __init slit_valid(struct acpi_table_slit *slit)
 {
 	int i, j;
-	int d = slit->locality_count;
+	u64 d = get_numa_distances_cnt(slit);
 	for (i = 0; i < d; i++) {
 		for (j = 0; j < d; j++) {
 			u8 val = slit->entry[d*i + j];
@@ -337,20 +342,20 @@ static int __init acpi_parse_slit(struct acpi_table_header *table)
 		return -EINVAL;
 	}
 
-	for (i = 0; i < slit->locality_count; i++) {
+	for (i = 0; i < get_numa_distances_cnt(slit); i++) {
 		const int from_node = pxm_to_node(i);
 
 		if (from_node == NUMA_NO_NODE)
 			continue;
 
-		for (j = 0; j < slit->locality_count; j++) {
+		for (j = 0; j < get_numa_distances_cnt(slit); j++) {
 			const int to_node = pxm_to_node(j);
 
 			if (to_node == NUMA_NO_NODE)
 				continue;
 
 			numa_set_distance(from_node, to_node,
-				slit->entry[slit->locality_count * i + j]);
+				slit->entry[get_numa_distances_cnt(slit) * i + j]);
 		}
 	}
 
-- 
2.47.2


