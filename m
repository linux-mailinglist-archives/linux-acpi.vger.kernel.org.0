Return-Path: <linux-acpi+bounces-20092-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C247D080E5
	for <lists+linux-acpi@lfdr.de>; Fri, 09 Jan 2026 10:03:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D8448302568C
	for <lists+linux-acpi@lfdr.de>; Fri,  9 Jan 2026 09:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9534A330656;
	Fri,  9 Jan 2026 09:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VLYnbIfi";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kOdJjR3z"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3722288CB
	for <linux-acpi@vger.kernel.org>; Fri,  9 Jan 2026 09:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767949367; cv=none; b=TU0cL9FfUhrwyd7M2oWrDmzlstyl2LVCUdhFZo0XK5o9TdIJT9uRW03gMEzPhSaCsvhvGgXaetrrPjpXQM46e9+RvgyxJNollUTOveck1PMd80Buf/RL20DsV2piNOvLimBwZro4NYR+4K0W+JkbpJ+4tqXjojCyT4FgYN13yN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767949367; c=relaxed/simple;
	bh=e6foTb0AMN9HIN6gj2PSEn4vtPlZHgKWuphSixUcW9w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iZST/NQsZ0pAmYxMJNheF8ZpMC2zOm1Eho8drN5sflEYcvvPmH66VGvvfsCGZrVGfVM0n64P9G9lZiukyGGUwM7ZavCarML+3TiJyQ4aIaLOsDasWAAclyriiKLSBwkrNcEAK6cygnjWN8K7waAkWCKC4JiXWcbtg0FXLuvs3eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VLYnbIfi; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kOdJjR3z; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6091qRqo3324799
	for <linux-acpi@vger.kernel.org>; Fri, 9 Jan 2026 09:02:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=m2SLt+ibhBF
	eKeTazqX12oxB+MUF6EudEtGynVS4dKk=; b=VLYnbIfi+3ZbXTAor5IETt3WWB6
	pieuPY13RqGZL2vjDCN6I3r2xswRglaQbWCepMrq3DT0vLSx0INPxWUHNHxYekOo
	AO6cUKlzhACVZaqMR4K6n9z6y6H5v4oQZG2FkglLrcR3JxaJRKEhjAiKKtsyzfUl
	1Q5gAlKqiHIduWatuQRpDsqyFIrcA7uT+rKs8gQbCd55YtY4q+0EUeta2qDXUO5b
	SAnsUkazdaXPvyhmDHsoO+cVqRIMpL77FfOGb97LBC50kFv1jR+AoUzy98ye77ST
	yzRJyAhd57Y9rXZuQNC26xpFU16wFNmpL3qKYSIDpNzNK/19aXugTegD8Vw==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bjrd6h4tn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Fri, 09 Jan 2026 09:02:42 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-7b9321b9312so7416941b3a.1
        for <linux-acpi@vger.kernel.org>; Fri, 09 Jan 2026 01:02:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767949362; x=1768554162; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m2SLt+ibhBFeKeTazqX12oxB+MUF6EudEtGynVS4dKk=;
        b=kOdJjR3zJ3MHLdezm9wcV+rNuZ1VBGP7VH3TCGX1oUiIlVu0PCftpVRzcfG8QTzfnM
         krziRyztpQA/9Ct6eqCYg24PqtWtIaJGcuk5iupJlqqph75xqj7tF7V4RrLHkIwti7v5
         zrm9n80d3n7pvCyE2kdZA3jBXBvFgLc0iuyxo5tERNnnVOO+8C1EgWGbhlYqgcdXgWDv
         4h8Jq6jA7GHqeP5+jsBtZlFO65MEBmETRMkZotnkH8OxtaVmGDJr4svwKnB2ZbRn7BgJ
         f6WCX86egwK2QDcPBiZqP0cQBJgPxR8yM4GLboDZVSvGYhtszG3VbrX1nWrMAHU6GzEN
         5n1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767949362; x=1768554162;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=m2SLt+ibhBFeKeTazqX12oxB+MUF6EudEtGynVS4dKk=;
        b=i8yAPmB21yevWzigyGfIL3fzqCPQcOWwPf4kuyAFCjnzw2nGKzWdwNhL5d/c/qhbRP
         n3rCnEi5EHVcFFDGhzUd0SXPC8jyeiIXJrUJiCqKeBLfnxXSr9dTubLdstXxLPDWX5Lh
         Q7COfAh4EP7sEif570Hv2+PkuaFeV3JreUicxl1jdCuHhXeCijE/1fZIzlJBNgplLiFE
         BoW2dAtAlNmaVb2cYPaJYBou8FJ/7dE8vLy9ekbLA8i5s6P1Q/ESTGr25UMkQmNPA2ZX
         /6/QDVh73FB4Ae62uGz7RlxtsdKfO2nU4r0YQEe+ZV8JgAVt+3lZPMq6mEyH7oOMzBb7
         w/qw==
X-Forwarded-Encrypted: i=1; AJvYcCV1CCUi8wkAawKJXbfkWvoO+nBgJkhY6UtEVZjmQ4b/iQrfvX2vnceCAbbiHAXd7SzRvqGQM5uZU3Pu@vger.kernel.org
X-Gm-Message-State: AOJu0YxRIjS+t/zxIWxOCQqjdCx7gWI67fT6b5V9veAmRU1vBTlCmePP
	ygW8Fq3e9AHOWLhRcRkE0o3OLbsJmXH8b4CElHAl87eQORQYEWlHqOsrW+7GdMJk7XLTBpwvkaB
	LIYPDIIlADfmwO/nC86/blhwULRU1YeddqTaduaS/3Fuoi0HSMGWMhG55nfMJVReq
X-Gm-Gg: AY/fxX5mI4Em2ABhaDtPh2DkbrEhVL38OnqYB8u+ZqI5Js7dJKoREbDRTUzuLbeUEUz
	CGuzNb6nnSafnizOZcXfJeM+HTzryaT0xgT+dbvdYSXMf/Dzi+RsfBzfdeBc70Nj02J5ynk7ly2
	Dn7Kpy8qLhxw/7h13FvMGcsMZBYt+p6sU9dYhRXk/0pDbLg3qhgDFGLi7eo7Va5O4UAcCLvQ479
	o7z2whHDp4tUmW0KcemzEWFs157W72Q2LegU5fnDar+PdJ/BYVPXrxDEcrmD/9m/6sbPVadojHu
	n7d6tbMLTpSm3c/NDOhoW7GEYqQAozFbwlG4dYh3rkpCZ2EFVuyS9Sk5tPsNe/F56oEHqwfcHi8
	GS2/skORo3Qf5xtXYhu+9n4aC13aUzLu0hiKai3fAbV3YJZMEf2lifIZSK0xHBJir4pbBlVK2fd
	19sQl4ZixWnP8DRXh1uK+sjDHtZzKRvZHYDA==
X-Received: by 2002:a05:6a00:299a:b0:817:9a85:549f with SMTP id d2e1a72fcca58-81b7d850288mr9071296b3a.20.1767949361933;
        Fri, 09 Jan 2026 01:02:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGIp5ZpFALhNPNu+WcxBmPwkXjHrQyIuUsng8/3QgDICBnsVVjJqmXuPHr0vGK3StfS35fRmA==
X-Received: by 2002:a05:6a00:299a:b0:817:9a85:549f with SMTP id d2e1a72fcca58-81b7d850288mr9071263b3a.20.1767949361442;
        Fri, 09 Jan 2026 01:02:41 -0800 (PST)
Received: from hu-himchau-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-819c59e826asm9831562b3a.54.2026.01.09.01.02.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 01:02:40 -0800 (PST)
From: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
To: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-efi@vger.kernel.org,
        acpica-devel@lists.linux.dev, paul.walmsley@sifive.com,
        palmer@dabbelt.com, lenb@kernel.org, james.morse@arm.com,
        tony.luck@intel.com, ardb@kernel.org, conor@kernel.org,
        cleger@rivosinc.com, robert.moore@intel.com, sunilvl@oss.qualcomm.com,
        anup.patel@oss.qualcomm.com
Cc: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
Subject: [PATCH v3 02/10] riscv: Define arch_apei_get_mem_attribute for RISC-V
Date: Fri,  9 Jan 2026 14:32:16 +0530
Message-ID: <20260109090224.3105465-3-himanshu.chauhan@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA5MDA2NCBTYWx0ZWRfXxikBYL+hHABH
 oYUgAHTGUQl+Nn7giHDKAQxilzokvyWBdnyr+WLFd67olP2xRujPewzhQMvIfRd+Y5e5CxPcdJJ
 4RII+hkiHZWiH/7cgztmY6JA08f5HxyVnnktfON+8RBtSiDX6vLvbquciCymEYfihaI+7oazujg
 4fd2WaAL2N9VhAYf9NRXbBEXGv1GSilNS+g9ODPuKMSXwgZFtB6yKspKXuaW0agJ2Q8f5Tnnq1P
 S/z/2VG/cthZvFGLKWYG3CVq+ytpEEmOYgd/Pw4dVOyxiW6uluy5Fvp9pg+yCSi2yZlIaMWn7HB
 1qaUZsrZ8/2wg8lpoyKqVmMqgSSTxuWmedi7LzuhV239DVW1j5rOAoYZdXlLFMPqFdsQY7Ec1/M
 CAIWIZXFx0kkuKAdCFhwo93TCGM480XLYLmJZQxTZOxeblQkh73ij2S3DUCVnXyuuoixbLKiVxT
 Mxmv5HfQTJS25eAkCmw==
X-Proofpoint-GUID: 7-2mMQu5EZ4NBuTAIGa0VT0nu3p1pdzq
X-Proofpoint-ORIG-GUID: 7-2mMQu5EZ4NBuTAIGa0VT0nu3p1pdzq
X-Authority-Analysis: v=2.4 cv=Xtf3+FF9 c=1 sm=1 tr=0 ts=6960c432 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=I3DjZvlWSiOXn3_7CcgA:9 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-09_02,2026-01-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 malwarescore=0 adultscore=0 clxscore=1011 suspectscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601090064

ghes_map function uses arch_apei_get_mem_attribute to get the
protection bits for a given physical address. These protection
bits are then used to map the physical address.

Signed-off-by: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
---
 arch/riscv/include/asm/acpi.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/riscv/include/asm/acpi.h b/arch/riscv/include/asm/acpi.h
index 6e13695120bc..0c599452ef48 100644
--- a/arch/riscv/include/asm/acpi.h
+++ b/arch/riscv/include/asm/acpi.h
@@ -27,6 +27,26 @@ extern int acpi_disabled;
 extern int acpi_noirq;
 extern int acpi_pci_disabled;
 
+#ifdef	CONFIG_ACPI_APEI
+/*
+ * acpi_disable_cmcff is used in drivers/acpi/apei/hest.c for disabling
+ * IA-32 Architecture Corrected Machine Check (CMC) Firmware-First mode
+ * with a kernel command line parameter "acpi=nocmcoff". But we don't
+ * have this IA-32 specific feature on ARM64, this definition is only
+ * for compatibility.
+ */
+#define acpi_disable_cmcff 1
+static inline pgprot_t arch_apei_get_mem_attribute(phys_addr_t addr)
+{
+	/*
+	 * Until we have a way to look for EFI memory attributes.
+	 */
+	return PAGE_KERNEL;
+}
+#else /* CONFIG_ACPI_APEI */
+#define acpi_disable_cmcff 0
+#endif /* !CONFIG_ACPI_APEI */
+
 static inline void disable_acpi(void)
 {
 	acpi_disabled = 1;
-- 
2.43.0


