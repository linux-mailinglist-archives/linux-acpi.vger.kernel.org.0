Return-Path: <linux-acpi+bounces-21322-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0BVLAVnVp2nEkAAAu9opvQ
	(envelope-from <linux-acpi+bounces-21322-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Wed, 04 Mar 2026 07:46:49 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 67C2C1FB4C4
	for <lists+linux-acpi@lfdr.de>; Wed, 04 Mar 2026 07:46:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0B722307BB54
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Mar 2026 06:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65832372666;
	Wed,  4 Mar 2026 06:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="dK6t79vm"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E78A34C139
	for <linux-acpi@vger.kernel.org>; Wed,  4 Mar 2026 06:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772606777; cv=none; b=g7iCW6peSxm+SmRxiP9EPYlJXWwWuKB9traV+e/kNQtbTexqfbxDhn/RJDO1DuD/X7ar/KjHkxBESGUn8e/ECfv7u374Qo0iCrs6ztP64EuWt1bFnpL5TONQ2U81SZJq/wEwjqpiffaGeOX1+RBbLDw2LwYTDrafsvMBj8pBvEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772606777; c=relaxed/simple;
	bh=90PkZYD19lIg3ECOOq8+KKd7Im1dAaENxC3zu6J0m2k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R+qCV75RmkD+lI7IewqP1eohEYFESUat6jIc9Ti4/majwFm4Qfw9AvJRWGul2ftMt9hw9Tza39QlO1WRs3/MDbDhCpPKbZBrMO8GZq04KRGnz5ETI8f0lwabFms5kmsPWOiTNemqJw76n87QpgHtSlgsy2bGb1FsBGgmA9ryb9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=dK6t79vm; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2ad9a9be502so44099185ad.0
        for <linux-acpi@vger.kernel.org>; Tue, 03 Mar 2026 22:46:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1772606775; x=1773211575; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cjM1BsJwmjPeoyTCC5ziuKUW/44MzOrvs53qVh9C1CQ=;
        b=dK6t79vmf90CZiXRVc228XoY4wt1DwXSySBOfVuSFo9xpVvW4UIEwuUi81RouSkGI5
         lPvf01oQlAWLWV5qwbeJCHq+NIInyKgEnpxPa3l66al2X1FUMLhAxTqeeoIJRomwU3Kf
         CS3Z/RAJmk4LsUDjO68lIRUK3zYhPNgsDs7uDyGMfjCU6GeROnFtU1rkuIikzXyLMPLK
         yZWCWJD6JZv7zL9bnkd4VfKgbWC30c0aXNCTuqpW4zgtyw8JVP6eZ9d8JcdDXuAFhx8Z
         HsIkd0NRJSkfEMN2gTYX3iGoUU0xA/TH3ifqOzs2R4XMfRqUhUyNHwXy9h/k3g2JnQOg
         Vh/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772606775; x=1773211575;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cjM1BsJwmjPeoyTCC5ziuKUW/44MzOrvs53qVh9C1CQ=;
        b=sIjZcAMgD8kjhXl13dzlZXFv9zWDMt8zez2l7T5hEHgBE8Ddh5yNmCz1awxCLaEc1J
         ix791nugXY5puN8fA/0z5A1mIFS89HeSAviXg1iJ0cOeO43X8EeXQxledmW1nXDqv/Cb
         /+Q6ZGQXM7D0ItsGltD+J+0al8RVWaYthH/4PjNidxrVjJ580Lu59mOGa48H1WY3kyj7
         DotJctVLKdCjf0RRJY07Obsz15BZZ9vgRg9F323It2kMSOpQSJIP5uGiV5kNE+jv6LyR
         cZA6iULj87KLepSuzVJsXBtDERX0egCs2MlfAY+2bU0pMuis1LEPqX7bnrocnLtDNNSB
         Xgyg==
X-Forwarded-Encrypted: i=1; AJvYcCUr5hUvE4RcOYhokAE7+bD1hM6kXxFQ+AczsKuxG3S8uizCVDFzgl5vIrL/n0TTXkalrBW0V5raLVy2@vger.kernel.org
X-Gm-Message-State: AOJu0Yy//qYFzUtKJBuWJlZOGZh4FeGbh/ISRAdqiPxe7GYPxzdG6DhD
	r9Vlt6oAfusroKcArBnkpCp3N0YSiHzKBlgrWN/FQl2tjfkakcaaCt29TLE3zOnwi02IIHxXLnX
	fxgId0K2DQ1TZ
X-Gm-Gg: ATEYQzzuGLfRGFsznAnSveaNpo2WKClzh2aI4aOax6/mI8QEqm5F/5+9x4hj8n5HXrx
	cea2dEDFaIC3KoBVkKaIH9dbYuJqXr7dKrI9jMn+mAvqN5T4irdb183bwW1dc6FQJ6ilKtaipCH
	Rp8JVHg84CYwXdCnSCQiRWrlbluQekX6vywN6smW+iWsau3fCNG1YQDafJumz0qyG0Eb3/TJHd4
	AvOHlaGGlemV1BbV06Sz85WuM9Xk/C9DD8z4q5ux+PUYZWPY7HfxoS31VtBXCR0KifBbjc6TrI3
	apGcL+iONIbAomq+N0GXTgZJ8vbxUI/aoqmjwxGhZgsdbXYUh77P0LZSS+urt3nGzBrtWkz4/L6
	e6CyrSHqCxigW2fHJTdu+ogLTjByDFedAR6fRDMwLl+x29re/f4LC8ckaRfnb1CbIvoLOKo4pnS
	Yp4fB99RAvMxX9CWOT9Y5IZfWoDjy/CTqpIN2t
X-Received: by 2002:a17:902:cccf:b0:2ad:4265:bfab with SMTP id d9443c01a7336-2ae6a9ece4amr10630755ad.5.1772606775452;
        Tue, 03 Mar 2026 22:46:15 -0800 (PST)
Received: from localhost.localdomain ([147.136.157.2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae4b9ac021sm87248085ad.86.2026.03.03.22.46.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 22:46:15 -0800 (PST)
From: Haifeng Xu <haifeng.xu@shopee.com>
To: rafael@kernel.org,
	lenb@kernel.org,
	dan.j.williams@intel.com,
	jonathan.cameron@huawei.com
Cc: dave@stgolabs.net,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	linux-cxl@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haifeng Xu <haifeng.xu@shopee.com>
Subject: [PATCH] ACPI: add a boot parameter to disable parsing CFMWS during NUMA init
Date: Wed,  4 Mar 2026 14:46:09 +0800
Message-ID: <20260304064609.75585-1-haifeng.xu@shopee.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 67C2C1FB4C4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[shopee.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[shopee.com:s=shopee.com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21322-lists,linux-acpi=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_NEQ_ENVFROM(0.00)[haifeng.xu@shopee.com,linux-acpi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[shopee.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

For the machine Intel(R) Xeon(R) 6746E that supports CXL memory,
the possible node is 20 (0-19). However, only two numa nodes (0-1)
have memory and the rest (2-19) nodes detected by CEDT is memoryless.

The problems is that when creating many pods, the shrinker map size
need to be expanded for all memory cgroups in expand_shrinker_info().
If the number of possibles nodes is too large, the holding time of
shrinker lock grows significantly.

In this case, there is no CXL memory inserted in the machine, those
memoryless nodes are useless for us, so there is no need set them to
'numa_nodes_parsed'. After disabling parsing CFMWS, the pod creation
time is reduced from over 10 minutes to approximately 150 seconds in
our intertel test.

Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
---
 drivers/acpi/numa/srat.c | 29 ++++++++++++++++++++++-------
 include/acpi/acpi_numa.h |  6 ++++++
 2 files changed, 28 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
index aa87ee1583a4..8716d70043fe 100644
--- a/drivers/acpi/numa/srat.c
+++ b/drivers/acpi/numa/srat.c
@@ -31,6 +31,7 @@ static int node_to_pxm_map[MAX_NUMNODES]
 
 unsigned char acpi_srat_revision __initdata;
 static int acpi_numa __initdata;
+static int cfmws_numa __initdata;
 
 static int last_real_pxm;
 
@@ -39,6 +40,12 @@ void __init disable_srat(void)
 	acpi_numa = -1;
 }
 
+void __init disable_cfmws(void)
+{
+	cfmws_numa = -1;
+}
+
+
 int pxm_to_node(int pxm)
 {
 	if (pxm < 0 || pxm >= MAX_PXM_DOMAINS || numa_off)
@@ -313,6 +320,12 @@ int __init srat_disabled(void)
 	return acpi_numa < 0;
 }
 
+int __init cfmws_disabled(void)
+{
+	return cfmws_numa < 0;
+}
+
+
 __weak int __init numa_fill_memblks(u64 start, u64 end)
 {
 	return NUMA_NO_MEMBLK;
@@ -648,14 +661,16 @@ int __init acpi_numa_init(void)
 	 */
 
 	/* fake_pxm is the next unused PXM value after SRAT parsing */
-	for (i = 0, fake_pxm = -1; i < MAX_NUMNODES; i++) {
-		if (node_to_pxm_map[i] > fake_pxm)
-			fake_pxm = node_to_pxm_map[i];
+	if (!cfmws_disabled()) {
+		for (i = 0, fake_pxm = -1; i < MAX_NUMNODES; i++) {
+			if (node_to_pxm_map[i] > fake_pxm)
+				fake_pxm = node_to_pxm_map[i];
+		}
+		last_real_pxm = fake_pxm;
+		fake_pxm++;
+		acpi_table_parse_cedt(ACPI_CEDT_TYPE_CFMWS, acpi_parse_cfmws,
+				      &fake_pxm);
 	}
-	last_real_pxm = fake_pxm;
-	fake_pxm++;
-	acpi_table_parse_cedt(ACPI_CEDT_TYPE_CFMWS, acpi_parse_cfmws,
-			      &fake_pxm);
 
 	if (cnt < 0)
 		return cnt;
diff --git a/include/acpi/acpi_numa.h b/include/acpi/acpi_numa.h
index 99b960bd473c..2435f60e56ce 100644
--- a/include/acpi/acpi_numa.h
+++ b/include/acpi/acpi_numa.h
@@ -21,6 +21,7 @@ extern int fix_pxm_node_maps(int max_nid);
 
 extern void bad_srat(void);
 extern int srat_disabled(void);
+extern void disable_cfmws(void);
 
 #else				/* CONFIG_ACPI_NUMA */
 static inline int fix_pxm_node_maps(int max_nid)
@@ -30,6 +31,11 @@ static inline int fix_pxm_node_maps(int max_nid)
 static inline void disable_srat(void)
 {
 }
+
+static inline void disable_cfmws(void)
+{
+}
+
 static inline int pxm_to_node(int pxm)
 {
 	return 0;
-- 
2.43.0


