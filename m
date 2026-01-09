Return-Path: <linux-acpi+bounces-20094-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D2D4CD08100
	for <lists+linux-acpi@lfdr.de>; Fri, 09 Jan 2026 10:04:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1BD4B3018C96
	for <lists+linux-acpi@lfdr.de>; Fri,  9 Jan 2026 09:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B119B350A19;
	Fri,  9 Jan 2026 09:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oXL+N6Dr";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="S07VTMWe"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1893314BF
	for <linux-acpi@vger.kernel.org>; Fri,  9 Jan 2026 09:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767949373; cv=none; b=p1ZOS1IRfFiDy6nI3GuLN7kJjQrf2fAq2nj91IUyUHNqtia2igT74qm2mSxDPIXimcjq0EoLcPNbueGKXRrde44h01r9BnYjb1LJDC0Z1gsemce1JDG23Kb4840bDnVC9xoBAW85tqE4gFrs+vyU+X4o8FktzLL4yIxef9mItRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767949373; c=relaxed/simple;
	bh=W9Z8ad/AN+KNVWAE5HEzWUcd28KekPEPytmpsuBKjhY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mPXKSA+QccnkYVLhMnbUf77HzODowpy66RD3tbx6xQ4EjMVHCCdEmopc0FmiOBPshPr7w7Dle+tAjc2/gBLJP/FIGiSPCNJLYHI25dRknB0sK03nXJ/AAcp5WGQeFf5aWSIDgao1JkdwfyzrulOOnO6PjRCvxg6w9qx7UgBd+xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oXL+N6Dr; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=S07VTMWe; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6095mHnH3019005
	for <linux-acpi@vger.kernel.org>; Fri, 9 Jan 2026 09:02:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IQxw9pRj4KjsMr71sZ2t5x+9tK+jz2fwPiFRsDjX/i0=; b=oXL+N6Dr7UqfcymO
	YOAN4imTr5a2HEp9O15FtDGt3bopjHJxqZLVAMt+55EhAz9PZPqW7E++GKXgoUDq
	znXArl/vK2K0oU/X3IuUN/mOzE3n+vnKN6Pv+cRlZAU+ukslMdTx8WYjajdG+mi8
	BQKCTU3v9ft++o8G53U6ip5sOCJMUK0BnnoXlo4MV3dRniiX9wF0zny1lxUm54tI
	ikqHC4xGhmhGskTyAaBT9pKIfZnLplawfcuFj5T5YhlgoA3pUTNnHjZvNB5CSvJw
	Wry3zeANBB2n0MitQB9duLkc6yLIQcWgPUjsFNqEm3GDLmFj4om1ME0K8pKSmtD8
	fny63A==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bjjk3j22k-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Fri, 09 Jan 2026 09:02:51 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-7bad1cef9bcso7173222b3a.1
        for <linux-acpi@vger.kernel.org>; Fri, 09 Jan 2026 01:02:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767949371; x=1768554171; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IQxw9pRj4KjsMr71sZ2t5x+9tK+jz2fwPiFRsDjX/i0=;
        b=S07VTMWer4GxJTo8tyagkeizrrY0t0HAFH5Y90eQnuNy23kqKtGsiY/ml7hWMEUNL6
         aFCEeqfxPH98ycICOLsAz/ZEex53JgOYY8KF3IXK/zEWc9mx6ccg7BpZCYx9hqWau9/a
         QlZADeYoeGZUJEPAQ/UsYuaobhBOFvUZ+6zusA7UVnQ9ZoWRWj1ZNQ69QG3amiKwiOhQ
         T/XMxa59LBc1C52MRHl9S+a3UvFZgXON/diyTlvRsWdGbAPwnMisCFnmB+hFMrm8e9jg
         DGYoOQ6KQHD86p2P+GmGTaZx86UXwF0TCdcmMVgRThXhqchunIVJq4J1j7F7aTKT7NPB
         YQdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767949371; x=1768554171;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IQxw9pRj4KjsMr71sZ2t5x+9tK+jz2fwPiFRsDjX/i0=;
        b=qbP0sDzSRrziihIvILQogmPbQFplDFci+nKNhPjfktBFqED+QpNOLkCtI6G8myJBKx
         sho80iVdv+ovKF+wOm8M+H4PnRaOo+80QWjnDb0/o1Umi7kHONAM3LcM8ngnkwJE6XRy
         rUpzgEZYEHVHulBPeWcVuweIRIzajT2rAfOH+Q7xqPjD7IVHXqvv5Qko9TzUHsoosXp9
         ymHocKKHCnBmtrknCcjvLVCUQKErYpfhCTYlmdg1xFSfyjyvkhwyUt3cX5JizT6EACfg
         S62zsD4NB+NuuxNR7t5JBt/Pry6xPADLTMo5C5guI7MDwCEAXKGrCQ+0ioDY8sZOvWnq
         eaaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVTBlwAPwxMbZkU6vH5tyInC+JFR8AjxxY4lIFJUP2a/pYifLTDky3IjNSkvC2v6u/1wh5RiVujNAn+@vger.kernel.org
X-Gm-Message-State: AOJu0YwZNmPYQxmXoCLr7PVo2Jxb9YDrawBn/0x7hPjSZ0+9wcuukGYq
	Tf5KgOL9wpainUbtnD5/RoD7LiQJCb5YsyHUdnwcz2hDE+CjoDNLD9o/OLXXmb9+B55H3+kapR7
	U6lkd5JFH3NejTxk7DDs/tSw80Jv7hSo5JmWlOHCQO8kKbnv/NyrWCfPekeNvNbqR
X-Gm-Gg: AY/fxX5RTuY4xcraxqO/QBY+AE46uxtT9VN5eFMLqHQc4MiuZBnXI1R+BYt0DBdJhDX
	AMkX8V5woeXruDkPLWpa1ueGSCuOtIIMvDGjwhNmlrcGg/3QAsc+1CXM6bp49+mntn1FtFFaKqE
	1PSJYATYROn+zjx016AS91i3sTlMdS73v6pOPqKPuqcLQOo8f3u9pw7jWiW55jITaEjXy6CNGBE
	dJl1XivyjZ0PVQKBK2BHcnjs1t+nWIHtYf63JPB/+S/En4XyZz4IU/Uba5F8OxLepYoimSIV2Y6
	paEJrxd1OOioAwnDhn3Yi/rU4vXLklOFu3i5uN5EGUZ0FikCF2kYlvpZ+qdvDoS1csA3fNiHQmt
	BVYNJtSbT0MV17nBDL8nzW7e19DjXr0byRCUvvPuGAHlmEwzCy9j/HgMk5AkRIRpgBluR552mT+
	7RfWM5Yg7reEREHlk6RzGd2NnhVQEU10h1mw==
X-Received: by 2002:a05:6a00:3019:b0:806:1719:295a with SMTP id d2e1a72fcca58-81b7fdc3515mr7977748b3a.47.1767949371057;
        Fri, 09 Jan 2026 01:02:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFtfwiA+2BFdveZ7B0QFne8hWPdA9OtjKKcqFuxwp7fzla1g4pqTzNpr3/SfNjQP+cNiU4jrg==
X-Received: by 2002:a05:6a00:3019:b0:806:1719:295a with SMTP id d2e1a72fcca58-81b7fdc3515mr7977725b3a.47.1767949370599;
        Fri, 09 Jan 2026 01:02:50 -0800 (PST)
Received: from hu-himchau-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-819c59e826asm9831562b3a.54.2026.01.09.01.02.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 01:02:50 -0800 (PST)
From: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
To: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-efi@vger.kernel.org,
        acpica-devel@lists.linux.dev, paul.walmsley@sifive.com,
        palmer@dabbelt.com, lenb@kernel.org, james.morse@arm.com,
        tony.luck@intel.com, ardb@kernel.org, conor@kernel.org,
        cleger@rivosinc.com, robert.moore@intel.com, sunilvl@oss.qualcomm.com,
        anup.patel@oss.qualcomm.com
Cc: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
Subject: [PATCH v3 04/10] riscv: Add fixmap indices for GHES IRQ and SSE contexts
Date: Fri,  9 Jan 2026 14:32:18 +0530
Message-ID: <20260109090224.3105465-5-himanshu.chauhan@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260109090224.3105465-1-himanshu.chauhan@oss.qualcomm.com>
References: <20260109090224.3105465-1-himanshu.chauhan@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: crydNNssFW136gLDBrNSJe9-BSJGtGcG
X-Authority-Analysis: v=2.4 cv=EazFgfmC c=1 sm=1 tr=0 ts=6960c43b cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=h0uksLzaAAAA:8
 a=0wheRbxtA0UXKxI4o1AA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22 a=MSi_79tMYmZZG2gvAgS0:22
X-Proofpoint-GUID: crydNNssFW136gLDBrNSJe9-BSJGtGcG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA5MDA2NCBTYWx0ZWRfX3JfvlzHrFVnC
 2zBOPfBgb4Fg9mw67Nq+XcqsmhfqJ2LjlCWPaO/lVtIIMATzGCMphvNWuKxbyp2tqQMd47O97+H
 0zcNSHND5Tuxi3TlcB7mdRBPJZVVUpWsH3ZC7Rmqzenzb5PQswGTS+0WG0je5NWn+ABDOt9HYFt
 pWKeDYv5yqWPGLWg+7QWwmYZC3d60QQIcon9H6HEdgfF3NI1yi7H5GNJt8Thgd2YfOEtysMOI6m
 PnwOytJV/3jU6Zq7CBU5GghUJXTqjS1lms+TvJIhHZVy1/nkoI3txt63mWswluCJ0uCObQ2jhEl
 EhFCOQ2AHZ6A90MmbgnzzcyeR3w3arBQZVKG+ULvwIzMesNCxA62k5EcJ0d4IBWP3MrVbg5t+4Q
 BZHNDhBr83Sukm1VwaU3S7FIMkVZAVI3K9rbgVYMn+z1qfTVYy4bvmehhLB4C93fXt+2TNBVo3d
 tuZgiqm29Fj04xYEQqA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-09_02,2026-01-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 adultscore=0 impostorscore=0 priorityscore=1501
 malwarescore=0 bulkscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601090064

GHES error handling requires fixmap entries for IRQ notifications.
Add fixmap indices for IRQ, SSE Low and High priority notifications.

Signed-off-by: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
Reviewed-By: Clément Léger <cleger@rivosinc.com>
---
 arch/riscv/include/asm/fixmap.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/riscv/include/asm/fixmap.h b/arch/riscv/include/asm/fixmap.h
index 0a55099bb734..e874fd952286 100644
--- a/arch/riscv/include/asm/fixmap.h
+++ b/arch/riscv/include/asm/fixmap.h
@@ -38,6 +38,14 @@ enum fixed_addresses {
 	FIX_TEXT_POKE0,
 	FIX_EARLYCON_MEM_BASE,
 
+#ifdef CONFIG_ACPI_APEI_GHES
+	/* Used for GHES mapping from assorted contexts */
+	FIX_APEI_GHES_IRQ,
+#ifdef CONFIG_RISCV_SBI_SSE
+	FIX_APEI_GHES_SSE_LOW_PRIORITY,
+	FIX_APEI_GHES_SSE_HIGH_PRIORITY,
+#endif /* CONFIG_RISCV_SBI_SSE */
+#endif /* CONFIG_ACPI_APEI_GHES */
 	__end_of_permanent_fixed_addresses,
 	/*
 	 * Temporary boot-time mappings, used by early_ioremap(),
-- 
2.43.0


