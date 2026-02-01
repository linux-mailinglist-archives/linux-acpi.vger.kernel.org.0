Return-Path: <linux-acpi+bounces-20802-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yOXlAj9Pf2nangIAu9opvQ
	(envelope-from <linux-acpi+bounces-20802-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Sun, 01 Feb 2026 14:03:59 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E8164C5F3D
	for <lists+linux-acpi@lfdr.de>; Sun, 01 Feb 2026 14:03:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 484613003831
	for <lists+linux-acpi@lfdr.de>; Sun,  1 Feb 2026 13:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3B3D33F8B2;
	Sun,  1 Feb 2026 13:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bfD/in+C"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD5F33D6CF
	for <linux-acpi@vger.kernel.org>; Sun,  1 Feb 2026 13:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769951035; cv=none; b=USYQwQ5PP54s0YUifrBL2zPkuc8j0Ms+y4wcjb22DbEj3vQ4J8pDFIjyLizMPQvFNmFQlVzYLbfpVtzeUqojQhvNRja+aGGcXgiWWVmKuSWZJNgGEMDrfwvm5qK5t2/4cBmi6zI3sv0kVzwTs22nO5lG8PvkpgUEOxRzlwjqAKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769951035; c=relaxed/simple;
	bh=jkJFaSw+4QB88At9pISwIN/7R4HhlxcEMlc2qyYUNjo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OXv7bVw1DsDN9chx/X/IBlpteu850MFHHnvhdd8FwMKollLbLYbkAVTE8ZwR4SM+S7chNooXqjhYNAjToEB9vvnXhaZ1lIlVQ0L+NjgF4eUS0j0hBvNETnm6EXC27JiR6IUTf3lnvDVVGtiHWd1II9+MAn9NozIG7SCQ79ahdQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bfD/in+C; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2a09a3bd9c5so25477305ad.3
        for <linux-acpi@vger.kernel.org>; Sun, 01 Feb 2026 05:03:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769951027; x=1770555827; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zpTdJ6kU9128Bplq2Lsam/HvuOJViBWd2y7vXvIt9P8=;
        b=bfD/in+CcQ6LU7k70toJqin7m6NIf00XTdyWIjzRcg5sWKYuEyO4QUqt6vc3KNFaA/
         nTT0KxrD/+RawiKEy3+WHxiedOLspzhyMX7vxEi6FGN79O8CwCB31Gq7A8FxqdTFfaBW
         x3Iq4VFQ9pfEy1dZG7TyQFl2qHjW3lctux8YINlMYyLmQsefM9VQV70pzQgOMzk7Ub9Z
         ws438n67DWrmBC8z2/2zvOwPkrYbrP14ULorDhoA5XBoRNzEq1id/RnaHXXq3ZpgTBVF
         CkroBdNJmcfItuGUMpS9YTMc96gZAcjhCGR+VA/lubuOUM9rcb6XFv3mSWgCYh3FUf2y
         Ux8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769951027; x=1770555827;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zpTdJ6kU9128Bplq2Lsam/HvuOJViBWd2y7vXvIt9P8=;
        b=lU0Ze9b+JGtFr9chLFP8T8QGaEfs1L1/tkEbMc1tiWG53ZhKplPG6g9/Gi0mOFNBMa
         JZGwUnjI3ZWWUAA4A/H+GpRYrLMZK8jpWxf5PergnYJ+ZQXr4XaxIlfVJRsSb5iGj5if
         RI8kNjuY8ydZtEZEzqZ2RXFINUrvFX1ZpgFjVfb/gtFGvKkgMPCjLWzeCWXprdaZb99L
         JXA8PbVdz2PgAJUCk2ODmWfYY8Qtu4Wnj2CL5AZ/Svfp1gUWuyNLQem0sW23ol/jEWeH
         Y+VWDGjXx8h1W/PW/eSV8kbPpFUP8o7ZwtQcFK04292J4rcxiOda3OiRjfrk1Uadfp6E
         lPGA==
X-Forwarded-Encrypted: i=1; AJvYcCUdcrZX66TEJ27yi8C4/m6GRe3vBMGjAqkRe0ldK3ZwcL2vYYC5DJjU13cxFCad8uWOBqIpBSX1QUex@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt3nC4VYLtD0oRrZsRXDXSVd0Wka7VYeyP6bxhnbldR0UCSBwO
	AKZqpn6G8QE0wwOV6oaVcI7rPKm53kK6cC+f2rlVsmvmXjE2L5F8iySm
X-Gm-Gg: AZuq6aLBqCNT9kJb8FMAIdl8p3HvurWpww5k6+uu4ri4G0v5kaoAw389K4QojvmB4vL
	xslUPxG/un9BLuOrtfvbbX/sFSFY6oFr7cDD/i/df3stWMoXmX/DcN/SQ6SjZngXEsLMjMdjMsp
	MB2S+zssC7/FFp2WvOei24uWAWqNP1l5PnzSf8+pf+igOR0l89WaaZveibSEIufqTrjZhdQwCaP
	hnq+vu/7xfeX6/Xu/3mwrLdSgpJTWX6k4QueQUzwMsFlO/e3B1aK0a7evm39k6r67kSpyK4DfYx
	/NG/ac5jsi6AcfVaoopuJK6hBLRZDyw80w4Ashwm1yCalypfBbjrxK+60Fud1TImsL+gyMz/Qko
	SKGKJvrLRWiKqDhJcUu4+71Df/qWCEX5O1Yrgp4JKwayJbYCXJVr8wd05yd0a9AscmXKETAcYSW
	3dIfsRx7Q/EpSl1IZi8/EWwre55oDa5oHvtACE6xlI+wLLvefSRDKyCisdsjb6Rmu4QDJQ/c1HX
	5ZtJnFY8g==
X-Received: by 2002:a17:902:cf10:b0:29d:65ed:f481 with SMTP id d9443c01a7336-2a8d8946eabmr94972755ad.0.1769951027197;
        Sun, 01 Feb 2026 05:03:47 -0800 (PST)
Received: from nickhuang.. (2001-b400-e28b-f958-90c5-2a29-7d9f-5524.emome-ip6.hinet.net. [2001:b400:e28b:f958:90c5:2a29:7d9f:5524])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a8bd74e9bbsm96831045ad.95.2026.02.01.05.03.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Feb 2026 05:03:46 -0800 (PST)
From: Nick Huang <sef1548@gmail.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Robert Moore <robert.moore@intel.com>
Cc: Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	paladin@ntub.edu.tw,
	kusogame68@gmail.com,
	ceyanglab@gmail.com,
	n1136402@ntub.edu.tw,
	Nick Huang <sef1548@gmail.com>
Subject: [PATCH 1/2] =?UTF-8?q?ACPI:=20nsrepair2:=20Replace=20O(n=C2=B2)?= =?UTF-8?q?=20bubble=20sort=20with=20O(n=20log=20n)=20sort=5Fr()?=
Date: Sun,  1 Feb 2026 13:03:33 +0000
Message-ID: <20260201130334.3107-2-sef1548@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260201130334.3107-1-sef1548@gmail.com>
References: <20260201130334.3107-1-sef1548@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,lists.linux.dev,ntub.edu.tw,gmail.com];
	TAGGED_FROM(0.00)[bounces-20802-lists,linux-acpi=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sef1548@gmail.com,linux-acpi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-acpi];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E8164C5F3D
X-Rspamd-Action: no action

   Replace the O(n²) bubble sort implementation in acpi_ns_sort_list()
   with the kernel's sort_r() function which uses heapsort, providing
   O(n log n) time complexity.

   This improves performance for large ACPI package lists while also
   reducing code complexity by leveraging the existing kernel sort API.

Signed-off-by: Nick Huang <sef1548@gmail.com>
---
 drivers/acpi/acpica/nsrepair2.c | 87 +++++++++++++++++++++++----------
 1 file changed, 62 insertions(+), 25 deletions(-)

diff --git a/drivers/acpi/acpica/nsrepair2.c b/drivers/acpi/acpica/nsrepair2.c
index 8dbb870f4..a39ef59fe 100644
--- a/drivers/acpi/acpica/nsrepair2.c
+++ b/drivers/acpi/acpica/nsrepair2.c
@@ -9,6 +9,7 @@
  *****************************************************************************/
 
 #include <acpi/acpi.h>
+#include <linux/sort.h>
 #include "accommon.h"
 #include "acnamesp.h"
 
@@ -84,6 +85,14 @@ acpi_ns_check_sorted_list(struct acpi_evaluate_info *info,
 static void
 acpi_ns_remove_element(union acpi_operand_object *obj_desc, u32 index);
 
+/* Context structure for sort comparison function */
+struct acpi_sort_context {
+	u32 sort_index;
+	u8 sort_direction;
+};
+
+static int acpi_ns_sort_cmp(const void *a, const void *b, const void *priv);
+
 static void
 acpi_ns_sort_list(union acpi_operand_object **elements,
 		  u32 count, u32 index, u8 sort_direction);
@@ -851,6 +860,52 @@ acpi_ns_check_sorted_list(struct acpi_evaluate_info *info,
 	return (AE_OK);
 }
 
+/******************************************************************************
+ *
+ * FUNCTION:    acpi_ns_sort_cmp
+ *
+ * PARAMETERS:  a               - First element to compare
+ *              b               - Second element to compare
+ *              priv            - Pointer to sort context (acpi_sort_context)
+ *
+ * RETURN:      -1, 0, or 1 depending on sort order
+ *
+ * DESCRIPTION: Comparison function for sort_r() API. Compares the integer
+ *              values at the specified index within package elements.
+ *
+ *****************************************************************************/
+
+static int acpi_ns_sort_cmp(const void *a, const void *b, const void *priv)
+{
+	union acpi_operand_object *obj_a = *(union acpi_operand_object **)a;
+	union acpi_operand_object *obj_b = *(union acpi_operand_object **)b;
+	const struct acpi_sort_context *ctx = priv;
+	union acpi_operand_object *value_a;
+	union acpi_operand_object *value_b;
+	u64 a_val;
+	u64 b_val;
+
+	value_a = obj_a->package.elements[ctx->sort_index];
+	value_b = obj_b->package.elements[ctx->sort_index];
+
+	a_val = value_a->integer.value;
+	b_val = value_b->integer.value;
+
+	if (ctx->sort_direction == ACPI_SORT_ASCENDING) {
+		if (a_val < b_val)
+			return -1;
+		if (a_val > b_val)
+			return 1;
+	} else {
+		if (a_val > b_val)
+			return -1;
+		if (a_val < b_val)
+			return 1;
+	}
+
+	return 0;
+}
+
 /******************************************************************************
  *
  * FUNCTION:    acpi_ns_sort_list
@@ -873,31 +928,13 @@ static void
 acpi_ns_sort_list(union acpi_operand_object **elements,
 		  u32 count, u32 index, u8 sort_direction)
 {
-	union acpi_operand_object *obj_desc1;
-	union acpi_operand_object *obj_desc2;
-	union acpi_operand_object *temp_obj;
-	u32 i;
-	u32 j;
-
-	/* Simple bubble sort */
-
-	for (i = 1; i < count; i++) {
-		for (j = (count - 1); j >= i; j--) {
-			obj_desc1 = elements[j - 1]->package.elements[index];
-			obj_desc2 = elements[j]->package.elements[index];
-
-			if (((sort_direction == ACPI_SORT_ASCENDING) &&
-			     (obj_desc1->integer.value >
-			      obj_desc2->integer.value))
-			    || ((sort_direction == ACPI_SORT_DESCENDING)
-				&& (obj_desc1->integer.value <
-				    obj_desc2->integer.value))) {
-				temp_obj = elements[j - 1];
-				elements[j - 1] = elements[j];
-				elements[j] = temp_obj;
-			}
-		}
-	}
+	struct acpi_sort_context ctx;
+
+	ctx.sort_index = index;
+	ctx.sort_direction = sort_direction;
+
+	sort_r(elements, count, sizeof(union acpi_operand_object *),
+	       acpi_ns_sort_cmp, NULL, &ctx);
 }
 
 /******************************************************************************
-- 
2.43.0


