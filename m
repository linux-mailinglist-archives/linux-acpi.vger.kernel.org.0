Return-Path: <linux-acpi+bounces-18551-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 023FCC36326
	for <lists+linux-acpi@lfdr.de>; Wed, 05 Nov 2025 16:00:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7461B627DEE
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Nov 2025 14:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC41032E74A;
	Wed,  5 Nov 2025 14:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TkxSwH0J";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MhRwUca9"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C86311966
	for <linux-acpi@vger.kernel.org>; Wed,  5 Nov 2025 14:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762353780; cv=none; b=LAfXR7Q8ZbqjoRXrlWLBHy/r7dnh/TomufTnwib2gpx+xWwg7fNv2GPvSjpcnlX4e+ru23QWduthun9Im14qZ3AellzPf8Su6VJ0MJSaPle2RemzeXiZBD5AwB1HK7f0UnRmmJr4lWx0U/opf8/jkQ9gTr4+5iYAEYBKPqiCcH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762353780; c=relaxed/simple;
	bh=GwlUy5ylQ1Pv0lfKzslittEfdt62+GAqpjfgfGHQJt0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eCFyuEhTa58rygy7kJGeyXxdWvzUVjo9ahW8UsDP6TO8gKn2Vw0ivZnhjwo9AukkHqoiD/ZKRlHUqwT06m+3tBZwr1vKJXXyPB42xRYeQBsTQMmRsgyAyGv9mZLHoHTAwOTe2TFv1xtLtKjKveAmgSfu35k45DQH72Y9kiqeUkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TkxSwH0J; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MhRwUca9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A5AKwHI3665328
	for <linux-acpi@vger.kernel.org>; Wed, 5 Nov 2025 14:42:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=joFUIqRKiwwscmbjlOdGkL+oQb4b5DS+XtM
	xPC+GTEA=; b=TkxSwH0JJOlgpO2TARCUqT639eNjX+Ft5viIvOp0VoKojgptPwH
	BF5uoUg6SRLiySKLO5ka8q+a0GrJxb8OSP5S0jFArgVy+zwH/9efdCAe+WiKjACV
	E5bJBZcpDjqPfg1dy5M7RCd51osZw+AJlVSM3dCEP1lCyPDEW5eqhleZVMdTgMmY
	+LyU4J63vU6PQLjwzhODWSEhwwxckqhuewNj7xrfgCLqaXYJsd5g8uAMNP4hz04C
	ZHTaUcaLS356C9pHoe1IIZiH+xFWxq26gd+bk4k3/4zdk3FPDY9TJtETE4LRqFRx
	SLVbyMNqyFmzM57xm2wNXqoi6Am+jt/hTmA==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a7sfdtjrw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Wed, 05 Nov 2025 14:42:58 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b6ce1b57b9cso6393759a12.1
        for <linux-acpi@vger.kernel.org>; Wed, 05 Nov 2025 06:42:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762353777; x=1762958577; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=joFUIqRKiwwscmbjlOdGkL+oQb4b5DS+XtMxPC+GTEA=;
        b=MhRwUca9i00nlP07mX5ych9fzRX43IWvZww1T6ti1eSDv9+KMuj1tVGRUshe9TwdY4
         AnhL4LHbpsFiQCMbOf1Cvt5uJfZA4dMRnTWUhkFPtCSoExDguKvBKCs70Tp5PBzvZ5lz
         ieke6PHk9h4mHGrnmVBS/3KFMqkO9mcwGuGdglzyzQSp2gTPZe1QZvMdYDlA5Ktq5Itv
         0g4gGF0dYHz4ZZwEJxceLu02pyVQtdqi4Q+++xICq1BaYJdWPf5X5GSUHxrKrbN/SqRY
         Jwv2aXA3kFUs9XBbv4e7qis2WZqnilqJirtGku2waqgEp3oPZM6GMtdynz/VcrxqEM93
         wtHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762353777; x=1762958577;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=joFUIqRKiwwscmbjlOdGkL+oQb4b5DS+XtMxPC+GTEA=;
        b=r1N7nmDMMAZks73tn3xZUYx/I2gJjmzkjEazjY8SlYGbsF60rLZFqbYnH8FDgvOhhs
         YMov7V9QVCkd0QBYcwnB81adV9DTvG3MdJNCn+fXquBCO7mLJTkfqKe2XvdZQzowjTmR
         YXxsaY5vyY9Az6+mK9dGWYOT61vGl2Eb7uMCf4hN6NmEEoJOaHBDeZrTyaQaNrtS+WoA
         eDhw3voLdaUKwjDxKEEJjekV0c/DC0rh7FEWAJRa/tr92SjKeEaifi81FtByagpsEviF
         hLII8AX0e8bcmtJLVpJz9PqMhKJJidhA1wexp20rRMvTgsbByjtfWdzvnY1aPudsTsjT
         dyrA==
X-Forwarded-Encrypted: i=1; AJvYcCVOPMQbtEu8Yfgw9Fe3UTHBJdVlu9GxqRBBJNl0qTaH072VPWR44VQSjJjbX+ulgYg+/0mhlh7EgG7D@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv5y0vE8TR7SE2Wn6UERoFwvyytTJuUshZtogZLJE87cANTYJ+
	yyObWWCZeyqGuc+vqk28JocZqWfVJFi/yVKslFfMgHGlkDDs8OyoQsV+eO0jkXWOTqcsUYBqGS0
	XYFWNyT86HeXVMlPTLGeBZ6q0/eAKVqks6i81/rBn3R5be8j0k3Sd9e3rm6ECQzBi
X-Gm-Gg: ASbGncs4zz46h3B0zKKI9J/3M6ixrmC7+YZ4sf1VMeT2oWhicFD4Pa+Fh4CWWIwAKMA
	jvbR0ZIOcNVFjN85QYMj5zeJcqpCt9O0cOtCJQRpPa5qgiuwU6Gb9quSTnG0FUWeT8Lc8XwYrJB
	2HwIFN5a9iR7aDHSNbnfviL8KKEjnyKiz+vLQEQWbyYzAvsckFnk3nRmSwi8sbWn2Kny82QA/sv
	RwIuY6itTJUkiiIceTZ42fSeFJt9eSyWhA1oWU0ELeERES/qiPeR90s5qUDVl1u2KCbPDJIk6Cc
	6zv5pZAeJ2DUdws+4T49R6XgqmDp8DGFAtmV3Qg6Rr0q+8fnOrH9X1rp++cdV+IbExwyR64QHpo
	GJZNAGcxlCNky1KuvJ6Np6P/6JSvAvJSo5Ltv2TGDJuCXOH+YSoji
X-Received: by 2002:a17:902:f70d:b0:267:a1f1:9b23 with SMTP id d9443c01a7336-2962ad260fdmr46545785ad.18.1762353777327;
        Wed, 05 Nov 2025 06:42:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEMHiWz7adnyvabUa3wdrjM7PdxTv++b6QonkfSIBs6/Ncps9VRs/OvuXKWRkYmATP0T9Ueow==
X-Received: by 2002:a17:902:f70d:b0:267:a1f1:9b23 with SMTP id d9443c01a7336-2962ad260fdmr46545485ad.18.1762353776807;
        Wed, 05 Nov 2025 06:42:56 -0800 (PST)
Received: from hu-punita-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29601976248sm62933075ad.12.2025.11.05.06.42.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 06:42:53 -0800 (PST)
From: Punit Agrawal <punit.agrawal@oss.qualcomm.com>
To: sudeep.holla@arm.com
Cc: jassisinghbrar@gmail.com, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jamie Iles <jamie.iles@oss.qualcomm.com>,
        Punit Agrawal <punit.agrawal@oss.qualcomm.com>
Subject: [PATCH] mailbox: pcc: don't zero error register
Date: Wed,  5 Nov 2025 14:42:29 +0000
Message-Id: <20251105144229.467089-1-punit.agrawal@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: MCnLJ8t0r5WAKNanpPv2X96BNMzfU2y5
X-Authority-Analysis: v=2.4 cv=MMFtWcZl c=1 sm=1 tr=0 ts=690b6272 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=KhMsqpDh0VVKwBF6wk8A:9 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: MCnLJ8t0r5WAKNanpPv2X96BNMzfU2y5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA1MDExMiBTYWx0ZWRfX8oKhHemxubyz
 SuMXyIvrgaUUscxg1Ui5baRFrwmmGXJCTYyWM1eBN80bXdmAu1x2XXMOekR6W8WRWA8NcKDnCzy
 NmUfrZeUJQd0cMKiDzyTlki5fPfGp/Yesln8yyV49AVNavU3cBrI282doOxzSrCGGRFB02lIL8M
 SzISVcw67XAu0cJS/RSflQqGoCNTBSdyyj61WywFrlDF9Fh1KH4XZH1rnkWO37MiIgaRdX1ZRwF
 eksFRjz75wfcOgdL5RHvoC9zsjyy6XhDLid0/NAxxMYRVhavoMCloZ5OuadFdPY7r8ve3m9dVG0
 uVpmQBDT6QBfD7auXYOFCnAWHZxDtTDo4GVnbotUt29nZU0sg+FPKbCb2AnoM4G3s0l25O6sPGJ
 nWR+U/OuS7AWvZz7kMorjbdSYh+RgQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-05_05,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 malwarescore=0 suspectscore=0 spamscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511050112

From: Jamie Iles <jamie.iles@oss.qualcomm.com>

The error status mask for a type 3/4 subspace is used for reading the
error status, and the bitwise inverse is used for clearing the error
with the intent being to preserve any of the non-error bits.  However,
we were previously applying the mask to extract the status and then
applying the inverse to the result which ended up clearing all bits.

Instead, store the inverse mask in the preserve mask and then use that
on the original value read from the error status so that only the error
is cleared.

Fixes: c45ded7e1135 ("mailbox: pcc: Add support for PCCT extended PCC subspaces(type 3/4)")
Signed-off-by: Jamie Iles <jamie.iles@oss.qualcomm.com>
Signed-off-by: Punit Agrawal <punit.agrawal@oss.qualcomm.com>
---
 drivers/mailbox/pcc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
index 1aa3a7dbb7be..5b454769d260 100644
--- a/drivers/mailbox/pcc.c
+++ b/drivers/mailbox/pcc.c
@@ -281,9 +281,8 @@ static int pcc_mbox_error_check_and_clear(struct pcc_chan_info *pchan)
 	if (ret)
 		return ret;
 
-	val &= pchan->error.status_mask;
-	if (val) {
-		val &= ~pchan->error.status_mask;
+	if (val & pchan->error.status_mask) {
+		val &= pchan->error.preserve_mask;
 		pcc_chan_reg_write(&pchan->error, val);
 		return -EIO;
 	}
@@ -750,7 +749,8 @@ static int pcc_parse_subspace_db_reg(struct pcc_chan_info *pchan,
 
 		ret = pcc_chan_reg_init(&pchan->error,
 					&pcct_ext->error_status_register,
-					0, 0, pcct_ext->error_status_mask,
+					~pcct_ext->error_status_mask, 0,
+					pcct_ext->error_status_mask,
 					"Error Status");
 	}
 	return ret;
-- 
2.34.1


