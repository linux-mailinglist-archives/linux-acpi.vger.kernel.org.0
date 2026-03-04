Return-Path: <linux-acpi+bounces-21324-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SLx/CL/op2mDlgAAu9opvQ
	(envelope-from <linux-acpi+bounces-21324-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Wed, 04 Mar 2026 09:09:35 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 83C7A1FC3E2
	for <lists+linux-acpi@lfdr.de>; Wed, 04 Mar 2026 09:09:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B274E30E4966
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Mar 2026 08:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BB653890EE;
	Wed,  4 Mar 2026 08:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="hHiJUJWz"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6A03890FB
	for <linux-acpi@vger.kernel.org>; Wed,  4 Mar 2026 08:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772611617; cv=none; b=CB8zzKkJyWODInEESrBDlfD9VZxaq3N9icR0hGjU9dJDyrqiCxQ+0Vk1KGCRwuVG2AJV98+WC4GQRYUwESeJ+upkwdOfpIrKaaF9LEx227TroA5ED0W9BSb/c5eIcr4f5Onpn/bgTEqELPER9P9xQSWYEQLHyYlAmjH4/J9HPJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772611617; c=relaxed/simple;
	bh=gIVQIjL6KWNp/N7IGQCVodqKY+vMRD57PEUjkJG2F/E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RnJMPHusXr/DVIygMtwDe/kL0WltiaiCR6MCBQBQ/ppNcGGNK/H/G7BFFf8O0L8kYQnu+sNG2/jMJRuQNJYQKaCnmIi6Es4EftwrxaDO0ZvjurnNPn9CfQCVcZVDRAXsrRGcELKuKYhMVaDRgCtJynYS3/IS0/vo+6PcSlf9SoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=hHiJUJWz; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-81df6a302b1so7077426b3a.2
        for <linux-acpi@vger.kernel.org>; Wed, 04 Mar 2026 00:06:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1772611615; x=1773216415; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=r6eoY4SiH0kcADzF/tE6vWrQnAgRLMu3ultuUPQsFDg=;
        b=hHiJUJWz0nENmn7ihAIfl3aKwG9aNu1tRJO/hWK71lZ96W1kuITNoRNpI+sFWHnxQr
         h36TVqi4GielPZbPJLxYJ9FHdn5bpUt0ly80967XZXW/8XMYPDU3pazNUqkbImf1lyDL
         YDBtYIv65LE6INFYnvcVFWEZ7GoSezmZkXcrClVkGy1asZAD+7Ek2R8vmfGw0V1U9aau
         wnI4Lh7cI+eveuSQfuF9Oh3Acmh5jsFIr8CaTz/FF91RQ1258t6/OFvbOP0y8oyMb4Nh
         9zr910FesIfnkZN58D7lXPQyQHkee84uuEZs3wpp7Mg+UaJh+SjkiqahS5GcXVrRgCmP
         pAaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772611615; x=1773216415;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r6eoY4SiH0kcADzF/tE6vWrQnAgRLMu3ultuUPQsFDg=;
        b=Xmu6O+b+KxzupQNLL3GQru/0wpJnRdo8k/1K7091bAqJSgNPlv0ICerpskSE5/fTLe
         JjuUCY1j0dTfTpT+GBXiUcaqGYYWtcUvlG8KJdtGr4njKkssdkjwk4HCF5sYhQYBoogx
         vTiWT6mdYZtXTnOLAeFtbuQAYSpAXSPck7zzKiOgOWFMOqUlA3Q1XK1+v3kSz4G3TUiQ
         +BAGDg4Gn/nBxFt+s0ZIdVln3E1Xw6doipI7qMYcBJJj1DCe3ZjEh3X91stLURE2CaVL
         pfWip+Z0N0jdlMWKbao1CyYGORRUBYJUTStp7jrJf6LkIdkQ6sYJQLzXpDmFhU+bXB54
         nZOA==
X-Forwarded-Encrypted: i=1; AJvYcCXB4FbCnL2dyR4CBJ/bpMdiSkqTPlponSAGf2oEWRyD3Gn8F0LHBLOzTkevjF81IBDBliXKIeyi9I4i@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8UiAy7fNvK966bJvF20FhyS7aAcSb0ObIxo1wIs/0EzLKLeox
	n5INe9u0zNVijMm6TfUJ/yBS4qQERGPRrfjwDwqA0RKg3+Ox1LzBjX0PQbYp0OtaeWQ=
X-Gm-Gg: ATEYQzz7tSD/8vqgmTF9Chhm5hw6oiF8NacBDTCnZedShUPLXTeSAPjFcB2lgDFalFz
	G2tawNQ2+MdmrBdQ5X03dSyLLAIid/frfDUu3INQaPHY60gtJxLX29Uv6+NGHKPjoDxiCyz2zff
	xZePgWJN5I0XgHSgKaoNzjbbQr9csya4saOIlCrXXZu5pbjIwJINxy1o5+yUDv3A5PeuJ6fGasQ
	/k1Kpul8IJ7O4ftVW/JVbQYBxhX96vEZr2Jr9bfViCwinh3R8A9nGTGkYPPPgQQvJrJNFOM+r8K
	TZJCGOp6zlICrC3QJRiSdHZQb4YGmQH4BbzuD3wqhjLGEtomPSPJ0lZO0L+a+qprFcWDEm4WacF
	Mn12Vt/eVWZvDfjJX9qrRYNTr4SxMh/1adShvAuzwOfzzf3Esw434V71zVzDANgy3fBt1Q33rMM
	hDwVqgr4ambkAsY108OdZo0rJC3Ke3FSG0YtYQYV8GAcoLKYI=
X-Received: by 2002:a05:6a20:3d8b:b0:394:6159:1758 with SMTP id adf61e73a8af0-3982dd69b41mr1132055637.8.1772611615452;
        Wed, 04 Mar 2026 00:06:55 -0800 (PST)
Received: from localhost.localdomain ([147.136.157.0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae54136b28sm76817775ad.73.2026.03.04.00.06.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 00:06:55 -0800 (PST)
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
Date: Wed,  4 Mar 2026 16:06:47 +0800
Message-ID: <20260304080647.169434-1-haifeng.xu@shopee.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 83C7A1FC3E2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[shopee.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[shopee.com:s=shopee.com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21324-lists,linux-acpi=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,shopee.com:dkim,shopee.com:email,shopee.com:mid]
X-Rspamd-Action: no action

For the machine Intel(R) Xeon(R) 6746E that supports CXL memory,
the possible nodes are 20 (0-19). However, only two numa nodes (0-1)
have memory and the rest nodes (2-19) detected by CEDT are memoryless.

The problems is that when creating many pods, the shrinker map size
needs to be expanded for all memory cgroups in expand_shrinker_info().
If the number of possible nodes is too large, the holding time of
shrinker lock grows significantly.

In this case, there is no CXL memory inserted in the machine, those
memoryless nodes are useless for us, so there is no need to set them
in 'numa_nodes_parsed'. After disabling parsing CFMWS, the pod creation
time is reduced from over 10 minutes to approximately 150 seconds in
our internal test.

Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
---
 arch/x86/mm/numa.c       |  2 ++
 drivers/acpi/numa/srat.c | 29 ++++++++++++++++++++++-------
 include/acpi/acpi_numa.h |  6 ++++++
 3 files changed, 30 insertions(+), 7 deletions(-)

diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
index 7a97327140df..b127bb65d360 100644
--- a/arch/x86/mm/numa.c
+++ b/arch/x86/mm/numa.c
@@ -37,6 +37,8 @@ static __init int numa_setup(char *opt)
 		disable_srat();
 	if (!strncmp(opt, "nohmat", 6))
 		disable_hmat();
+	if (!strncmp(opt, "nocfmws", 7))
+		disable_cfmws();
 	return 0;
 }
 early_param("numa", numa_setup);
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


