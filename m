Return-Path: <linux-acpi+bounces-20099-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A061ED08139
	for <lists+linux-acpi@lfdr.de>; Fri, 09 Jan 2026 10:06:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 03585301E100
	for <lists+linux-acpi@lfdr.de>; Fri,  9 Jan 2026 09:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 314C6356A10;
	Fri,  9 Jan 2026 09:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ntRZbJyg";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="feFxv5Ig"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7D3330675
	for <linux-acpi@vger.kernel.org>; Fri,  9 Jan 2026 09:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767949401; cv=none; b=ksD+PChSSwGlZNqzhbgKWq9S2xDtMTy6OGzzPwZoCzjskEwmcg+XEPcIBT61PmyOj1SeRCRmvYwZZU4/jqIICLlkA7jLXp2Rht8nXfbHV+yKLo8UIniDnOv0tnA3KM3+aitx6ke4Pop1FVk8vTZLpekt9ZsMx20N9xFqBgadm+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767949401; c=relaxed/simple;
	bh=5AbkwUe4KSHUvslJtTs9okt35cK2ziGtjk7b0QstlZo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SKMkLFoQP5BYBlSzvG7izA19w8DJ6/Pcay8coKzA/sm3wr1m6TSPE69FMqxeXJ7l68m6jHB4k64gh7Z/ApNFAsa1Sc5BMn5+gi5arOAf74faoFWzl2qnEpqqyILBhhJhnpromuuHcsMRfR+Ppydj8/H0SDeE2MfX3oZDd8zbFzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ntRZbJyg; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=feFxv5Ig; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60952d1l3541993
	for <linux-acpi@vger.kernel.org>; Fri, 9 Jan 2026 09:03:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=V1pVonEOJuX
	JcP7BoStX++5XFX/aG8G2NnylegJ0870=; b=ntRZbJyg+8my8ljnN0AGP/4c3n3
	nCAtVLnBl9pTa3b2lggy65Q7ADypQisdrHZExjNrjnO5Z5uMomhdJzwelhbMxUmt
	lhl+3bPl1KFvyJ+v//7x6a6vnjHfY7/OzVAECTsPKpwZjq+SOYyaIPPPIa2XG52N
	e12ksXNY5bubRJEnCadm1c8u6UMd8DiRXP4zIj6Xh7jLywh+NKoMDJ93Ts3y4hEs
	P6swjzvLc4gk01QCiB3cLhAJWkJIH5oQcPEb6KWiC8yfCBScy30F0u62mMsVWzq4
	0sDADrmHWOUncbNf7NFqD3ZfvLDoW04Q+JF1x6p7y0pqUDjXi+NQTa2NEeA==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bju6b0nge-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Fri, 09 Jan 2026 09:03:18 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-7ba92341f38so4053379b3a.0
        for <linux-acpi@vger.kernel.org>; Fri, 09 Jan 2026 01:03:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767949398; x=1768554198; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V1pVonEOJuXJcP7BoStX++5XFX/aG8G2NnylegJ0870=;
        b=feFxv5IgdZU1pEDbZcBzSgtlfZp+yoPkbxQj7eLGvTcoW8hnBDDhSf8I/f639Ljeqv
         yXlIi1uOORDt8mp7sRRXKBcVkLt62TDmfPITEX57yqdtQrqWjG0QDJHNPCCZ93paCl+l
         SkIWtFuALQ+6tN7HRg7Jw1wJCNKASz/aX3LnCTMbpoCFtZeZfgiy61riBt+7CnPnoJh8
         q+q/TpeHjU3bam6phhwRWD7qc8wpu47OS5/xLws72haJqNgN+ROH0kvIepLLEcIVJ/EA
         WXlUtxQeTJpdllRCZ9PrwMD1XLsWhakCbCine02FyXmiGFnZXDKNJlnUPtaHrB6sY5t8
         2T7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767949398; x=1768554198;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=V1pVonEOJuXJcP7BoStX++5XFX/aG8G2NnylegJ0870=;
        b=PGuXb5RYsD7LRNgw0FCDj1OCO/64i23RjkLY9Vq+cMKW6vmQClBel8v7y89TasBAhF
         Y9HyIQpG1FXkw3oVt4kdg0/xG8vN42EJdDALIn3yN7KjprWDdPz8Fg/dUuq2HnctQxrE
         qbIJJTYx7fIEfWq+h9S/nOE4ZgnZAnNQYyYrhJoJGKe/WtOgOzuWuXpyntGR24P6wGDh
         XyWv1mJxfIb/BM3oU8FABhSS+4CTVOeNElc51E0wks3srXvfhIhYd1TZpoMpv1Ut45rB
         d3831+HMNd9mVeA2svuNYAD2Xl9BaXw3lowc9OeV6guW6edHaLAB0UUmPQFDNVlNiwev
         kFAQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5irhR+uqPw7KUipeLT6DofDvTgMGT3A9+27J+HRdjlyUN7g8QGdi2LELSUAin3Qh3GI84WhE+KPqi@vger.kernel.org
X-Gm-Message-State: AOJu0Yys8Z+5BkaHJRAWuhpGImy8FR1deXKQSIjImTRCB0YqJDfpejxB
	fzRJyTt8U1ciXGBmZFOk2a1xiE+vNlTAa200jXhndkxIyT4ZA02epcGQezyECWdJn5i5HY8tEeu
	PJc26j3O9sCBxhD4w5l9l7VMqCt7Lb/kVhLYv1EWglQQ85vbAxocGlbNDTXU14zYc
X-Gm-Gg: AY/fxX7mYtAhKuB20a1q3GVZqhubrSpUM+uPpWeGj6E7TtcL/h4MQ64t7l5TWH7jk9Y
	/zRa2qbl70Ml0+Lzi6IWHULRsDbKPFZ+JtpRQi4yVYYFhNQhdpfOcEdJWYWRW2dedYlhu2+VG2s
	U38xkZFt3AQvpWkUFAO3y1ryz94a4tyWzOnh1pmBwqy/SCMEph+iV8iJzLX9vPXIBuZG8ozMbSM
	5M/2BD7EVSKMBkvqdCrU3ds8cCxiFVGSd/otEMHiJrx3eTugENZlK96fklmADaTD5FQ3t7nsaQy
	o2LYFABvXpENj8fvlyE3TWLFOfvH8YjRHFJFr00h2g4+N/l2ZUuDcY2skxgPVNiofl8KW59V0vO
	nAtQG5AYX8KFXJUcDQY27ZRNNUJfpPB9h1TNpoTv4LG42gwdhjusYlV9uEdtcIn8J32NWxy2gBb
	c8Br4fAoxkZv2g+kChr3LLnw8iR8hWfP3GxQ==
X-Received: by 2002:a05:6a00:4394:b0:7ff:e71d:49a4 with SMTP id d2e1a72fcca58-81b7d85305cmr7454420b3a.11.1767949397702;
        Fri, 09 Jan 2026 01:03:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGu6Dzzr3vQDc5S1B/XHUHzgN4IyrQ0Y+ZBxjQJDn6l/lNEm6JmdGsaCaXI4BvbmrSGPo9+sQ==
X-Received: by 2002:a05:6a00:4394:b0:7ff:e71d:49a4 with SMTP id d2e1a72fcca58-81b7d85305cmr7454225b3a.11.1767949393427;
        Fri, 09 Jan 2026 01:03:13 -0800 (PST)
Received: from hu-himchau-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-819c59e826asm9831562b3a.54.2026.01.09.01.03.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 01:03:13 -0800 (PST)
From: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
To: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-efi@vger.kernel.org,
        acpica-devel@lists.linux.dev, paul.walmsley@sifive.com,
        palmer@dabbelt.com, lenb@kernel.org, james.morse@arm.com,
        tony.luck@intel.com, ardb@kernel.org, conor@kernel.org,
        cleger@rivosinc.com, robert.moore@intel.com, sunilvl@oss.qualcomm.com,
        anup.patel@oss.qualcomm.com
Cc: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
Subject: [PATCH v3 09/10] riscv: Select HAVE_ACPI_APEI required for RAS
Date: Fri,  9 Jan 2026 14:32:23 +0530
Message-ID: <20260109090224.3105465-10-himanshu.chauhan@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA5MDA2NCBTYWx0ZWRfXw85t88EBSwqC
 y1m5tMY5RWmzxKQaTtbGkxLKC2QHqPMfs53BhZpDMt5T1DQ/3N5w4wfAonqOb+qKLo5JHaKxRck
 WiRCfeuM1xdIoEoPpDapzvbxqBprk6JWWWTt46BVc8NYzh+LhID9kzjfrNO36IhJnb1GTsoGwUn
 NHSKwwUGiXgxUkLzg2eCSYINCNhBcThFTo/CoAxcHaoUgTdxzu/6/ToUkoJg/zi+6N/kmtDNgCn
 zgLrsrTct8bjGrCrt8il3xSs9ivfEsCA5fGJ1CEA+vkJUsqLP99VIQtCIn0eVuRLskjjsBOCsRA
 5WicGizEUOfXOov2WD+8FuntfWCjovBxnjAen0OKquZKNTGJWPQycbfXIuvLxavztik3r9ncb+6
 iKn+1dofGofywL8JxMuhey1A86yhpaYzFuehLXwg4vImDvUkQTsxUj8tXEJXP6IMAKi3lzmUbcw
 nZBn2UNm9yaju7KsFzA==
X-Proofpoint-ORIG-GUID: UeDb-PtLeUNonV30BvKZePYwEeQjiv3i
X-Authority-Analysis: v=2.4 cv=V+5wEOni c=1 sm=1 tr=0 ts=6960c456 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=B44PnEIMzw-PxGPnmokA:9 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-GUID: UeDb-PtLeUNonV30BvKZePYwEeQjiv3i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-09_02,2026-01-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0
 adultscore=0 clxscore=1015 suspectscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601090064

Select the HAVE_ACPI_APEI option so that APEI GHES config options
are visible.

Signed-off-by: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
---
 arch/riscv/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 6b39f37f769a..ef3f052e97c5 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -187,6 +187,7 @@ config RISCV
 	select HAVE_MOVE_PUD
 	select HAVE_PAGE_SIZE_4KB
 	select HAVE_PCI
+	select HAVE_ACPI_APEI if ACPI
 	select HAVE_PERF_EVENTS
 	select HAVE_PERF_REGS
 	select HAVE_PERF_USER_STACK_DUMP
-- 
2.43.0


