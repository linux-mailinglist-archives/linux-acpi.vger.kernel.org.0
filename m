Return-Path: <linux-acpi+bounces-20095-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E33F2D0810C
	for <lists+linux-acpi@lfdr.de>; Fri, 09 Jan 2026 10:04:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E54033035BE6
	for <lists+linux-acpi@lfdr.de>; Fri,  9 Jan 2026 09:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 829FE330B12;
	Fri,  9 Jan 2026 09:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BZYzt1Zl";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="j/w6B1xh"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8433314AB
	for <linux-acpi@vger.kernel.org>; Fri,  9 Jan 2026 09:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767949381; cv=none; b=mIiEv0M7rfzquNu5Y7emhNXHVciZlqslWHrbCeuUe09p3scPENqusc0OH5Q5x9TbiLyzePi9X154tiH9X6YEc2jxnuLUWq4cAzHLQOG3L+KJHgHNgwW7IaiboYP1fvbZxnQqf20UTr9xwOCzyOrzb/INsGwYMBvAUtWEuQdOMgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767949381; c=relaxed/simple;
	bh=oEof/wOPgbWYhhNlnzJuAEyOdqQayAwN+vF30IVWeww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cy5/GQMB0ENBTYM5RZf3jxB0GkM/CCccU5WgJnrnPxZ17B2d9iSRNugrLt8hLRB7p0BK+tj2l6ChX4kDBQMYKHuWtT8Qb9bdXM3NHBMzObq3OYq36oHB7y2L/WxchHFUU9iDRChpvPm8KjrFQf4NJj73PzJLXrrPG38GDBWW7dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BZYzt1Zl; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=j/w6B1xh; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60969eh83019302
	for <linux-acpi@vger.kernel.org>; Fri, 9 Jan 2026 09:02:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=d4ucWhJ3h8W
	TC/Vx88wr4lDxFFX8PD/AphAsZy//mrg=; b=BZYzt1ZlebyBfYGZ1iZvKCvxRjV
	/XsXeUmeVGCAr7Y/ZQEnwO5sFv30zU5TIBxzC9+AUfTcMKqD6ZVDQ8fGvZyTe8j0
	l9I01Tn84VvmtT6LkpSzRccL8RZ7ufW7619ncKlnP2UUHefYRSfp1D5rgQcaGkSv
	aT86WU/PP+MUzWVx526bRJt4sfdX9iaxjMgcPiazyxNnGyIHEXsRQ5mtHQIvIV06
	YhCwxiCsHsH0zGPQavn4ccYKouL6LMEjN7hg8k1seu/hQNkT4SX9p/RpcF0okiPS
	foUowAjdtVI0ouAkGy1eDwyDZXSBIZ7wjH5+hqFYENhpp+mR26yLsk+h5Cw==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bjjk3j235-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Fri, 09 Jan 2026 09:02:56 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-7d5564057d0so7959332b3a.0
        for <linux-acpi@vger.kernel.org>; Fri, 09 Jan 2026 01:02:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767949376; x=1768554176; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d4ucWhJ3h8WTC/Vx88wr4lDxFFX8PD/AphAsZy//mrg=;
        b=j/w6B1xhcSqUDfh4iYWHqiHbxmRAm5cfLvCydPAgMiDPfKQFcOBRcyLgrsSMUXMOM0
         8L4pFA34iGhJdkBFdHEUZsjtzLFtsdBoRtd5lMeVoe+CkT2B59cCbF+S9I26xec9jpu7
         pvZwyqYpjhvoCTi01qCSEsirhi75IP9kXOzCVkS1s/QFRxNVCcfcdH8Isd9+BIE4308I
         P6S8izBSc1o9GdBMzO4Pu2UCAcovfUa5ejKxMmAFrnVYriz4uS4cPC+LIWjgLdROovnT
         i2gbF/L8Jy6ScrN0igWJpF+v5KnoY8PWoZa0AyDLNFWKmlzYIe77skh8m/mclMmQ0zqP
         U0qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767949376; x=1768554176;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=d4ucWhJ3h8WTC/Vx88wr4lDxFFX8PD/AphAsZy//mrg=;
        b=TXQc61IlZ0skPonAL3pVT9JvMe+pOMKIcfMhXezBT3z3dWWPEn0NIVCdXzKlbRi0bk
         plCWd/zaRO0UhBNLnBxWJ8AOox9aWLXIZJqrkSMyWUP2atYXQdjVxGQy7OX2SQ//eKCa
         w5/ERnvmEA7nWaHGlcBOHAiibgAjKKWIjkp1c+xLOlMBnHSc5iXe/mmgDMzVA/8TeokN
         hj7c7/ls7QHoxpJI1Klrz2WoEOr38qCfVI3ZiEDPHkgcYw733fIwYMztryTOCDU1FY+r
         +EoZKmT7xKTMknvHohqmUBYHE3i6Zrn7NmXoudZxi9yxaZ1TBAUfKIGP9VcsLq7v5Nws
         EdoA==
X-Forwarded-Encrypted: i=1; AJvYcCUNLDG1zi7C0FEfSxj3Suig7S1Q3YdRDApbLKncwuNaNV6+zvqBsd8kR5RuhEsEFlpW93zVcjLIbQS1@vger.kernel.org
X-Gm-Message-State: AOJu0YwFCTrVRG7g1zBD1vXVv1yqWjwGgAnMJCm6R/tyGWFMyJMu4icQ
	HrJZuJBCUsFNNAdDtW8f1PR4wfc2T/lRMDJ5Mbn+y2GLBhAHY1ARZ0FxCHjVZ/uo+krIus4wa/e
	CxfViULwjZJMeor/yuN3pWJ2LYHRXaLjDPsRKSQwxGgt/tkqV3F3BaKt/ndPZgxmU
X-Gm-Gg: AY/fxX60sm1TxxyFhSpkFEbV8cHipgqvq72v0jLmQxm2lLId/GH//TZqZPZoVNqGfZx
	QIZFeNb4JHLDKMReYP3B6CsCwWaaEY7S4kf3TVVlwB5A07m8Xi8nqDoly8aFvrgAPYmaWcD8mKL
	Xg1AJ3Y/i2wE9L+WWY6ev7Q6EanWdHYWQk9eacJfyb1QaC666xFOFaYwsCr9IesCFgPaQdpDidk
	OPE9tikbKqDyjl3CVnLxX0hGN9nclBDtF2ybr7Hqz+pbgwU3RhniMEYz3QO9C5P/YDtiqkOf+yc
	NqtO0EhSvBxyXD0Dc+43QNABVonQOghoMcPx3yHffRAxGe2Dr+DK6sV1q5hz6X3G5QwIPZnxGc7
	6Vfb/nK830ud+dfvQkoKwO8NY55duSccPV0+kKFsRBmC63Wlz/e9I5hLLJMyLlKXYBiVCabYhcf
	3ho9u0q5hZ6KwsJu3syvPV6GpB2sCseHBUvg==
X-Received: by 2002:a05:6a00:909d:b0:7f7:4dc8:55e with SMTP id d2e1a72fcca58-81b7d8621dfmr8786989b3a.7.1767949375631;
        Fri, 09 Jan 2026 01:02:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH7zW5d+nSu+0wcfE2eze2NWNEmecsW0E5hntD0qHwPd/5r9VK82uccFBhoCMXa8NAbj/Emew==
X-Received: by 2002:a05:6a00:909d:b0:7f7:4dc8:55e with SMTP id d2e1a72fcca58-81b7d8621dfmr8786945b3a.7.1767949375086;
        Fri, 09 Jan 2026 01:02:55 -0800 (PST)
Received: from hu-himchau-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-819c59e826asm9831562b3a.54.2026.01.09.01.02.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 01:02:54 -0800 (PST)
From: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
To: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-efi@vger.kernel.org,
        acpica-devel@lists.linux.dev, paul.walmsley@sifive.com,
        palmer@dabbelt.com, lenb@kernel.org, james.morse@arm.com,
        tony.luck@intel.com, ardb@kernel.org, conor@kernel.org,
        cleger@rivosinc.com, robert.moore@intel.com, sunilvl@oss.qualcomm.com,
        anup.patel@oss.qualcomm.com
Cc: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
Subject: [PATCH v3 05/10] riscv: conditionally compile GHES NMI spool function
Date: Fri,  9 Jan 2026 14:32:19 +0530
Message-ID: <20260109090224.3105465-6-himanshu.chauhan@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260109090224.3105465-1-himanshu.chauhan@oss.qualcomm.com>
References: <20260109090224.3105465-1-himanshu.chauhan@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Pjsrk2Xwuwp7SrIYURHmIaw2ojWHAAbK
X-Authority-Analysis: v=2.4 cv=EazFgfmC c=1 sm=1 tr=0 ts=6960c440 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=-FlRX8pefk0TmyAjS3oA:9 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-GUID: Pjsrk2Xwuwp7SrIYURHmIaw2ojWHAAbK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA5MDA2NCBTYWx0ZWRfXx3gKe3q5/X4D
 yZzqOV3F+z9wJCaf3/ujFRQhl4I2kLhzdTf9JY1bUUg8SINfUelGuRMQLHXDYcLMMNpYOu4CMme
 greiu+CW3rBUvVNvfG9d0fVK7teeCwkSz0FOOmLyP+9HPiVgTM5A0Nge8pRTtzffnwTD1xDRw4m
 bUliWpPlF1Fg4rTSMEeKBwjn3X0/KHuHufp6PZCp31ChSqtEre/N8/fTATqDitFad6tKVIEpsIa
 n7PeG9HwNT6qY9in/+HijcBi9na8O71Wwl/0j2ZLASrjDokV5FW3c5O/U2rNjnEo9iFDRjhgwwY
 /bpsPByw7urb1HRTGAwn+CHyOAbvi79qev7XAuRxHpJbX1PZs5pNOHNdl68MhS2ylX85ji0Zg7q
 qCOW2juuZfu4PczWDtACQ6Tfvqi1x24HwGwyBSbKVFozKU3hrr1gSkN5qiUiSYKguTwFpUcpQk/
 HO7so4OvBmtLSltgprQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-09_02,2026-01-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 spamscore=0 adultscore=0 impostorscore=0 priorityscore=1501
 malwarescore=0 bulkscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601090064

Compile ghes_in_nmi_spool_from_list only when NMI and SEA
is enabled. Otherwise compilation fails with "defined but
not used" error.

Signed-off-by: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
---
 drivers/acpi/apei/ghes.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 0dc767392a6c..6fd84a1772c6 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -1387,6 +1387,7 @@ static int ghes_in_nmi_queue_one_entry(struct ghes *ghes,
 	return rc;
 }
 
+#if defined(CONFIG_HAVE_ACPI_APEI_NMI) || defined(CONFIG_ACPI_APEI_SEA)
 static int ghes_in_nmi_spool_from_list(struct list_head *rcu_list,
 				       enum fixed_addresses fixmap_idx)
 {
@@ -1405,6 +1406,7 @@ static int ghes_in_nmi_spool_from_list(struct list_head *rcu_list,
 
 	return ret;
 }
+#endif
 
 #ifdef CONFIG_ACPI_APEI_SEA
 static LIST_HEAD(ghes_sea);
-- 
2.43.0


