Return-Path: <linux-acpi+bounces-21303-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YLnCI+d9pmnhQQAAu9opvQ
	(envelope-from <linux-acpi+bounces-21303-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Tue, 03 Mar 2026 07:21:27 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D94021E9924
	for <lists+linux-acpi@lfdr.de>; Tue, 03 Mar 2026 07:21:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3192230D0B1E
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Mar 2026 06:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D96C37CD3D;
	Tue,  3 Mar 2026 06:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SY3yygMe";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="habgIZQl"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B53D2DCBEC
	for <linux-acpi@vger.kernel.org>; Tue,  3 Mar 2026 06:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772518579; cv=none; b=rco/b8c1NdL5qCJAIjT0z67ETVQMCO/fsk3sx2/RwjJZoF02TMZqU6hA5RlDkFBYRwFtdVaNU+cIREDkAwlNlO2NP0vyob5f58kxMSb5X91pXeuk/Lw29IU7m4MiSwZS1bLlOaynelYZNJRILoCxde+N338Dt7RSN0b4lIbejZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772518579; c=relaxed/simple;
	bh=hRwXdQyprmxss/kzNBT5i0vbtcuqywuAiUb3Y9zZZ98=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gqqO/j0+wYW0HUIQ9QL+h7kDS9hifLJcxcQ3OOTk6ckRudG9rx2qYkQyst4ZHCtgocIiZIBL/P/UgPlr4D8sxtNmRfi0yln1nNpzdJyrPKtqXuDryCD6MOHOy7f39Napt89ZjUt3rqENjdzx9slburiHJhhqeMZlD9HNGXzNDvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SY3yygMe; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=habgIZQl; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62367q5Q959240
	for <linux-acpi@vger.kernel.org>; Tue, 3 Mar 2026 06:16:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:sender:subject:to; s=qcppdkim1; bh=jBfJTiyHpDNC9aAf8vmH+NG8GrN3
	IfFl9hSg78Pea7E=; b=SY3yygMenGp7bzTezkaG5EyOZObt3y7qa6ARKasWE1bI
	0WvNrfVWVFWznlyrLf9+BJfL7peFjgB1Fh+1uu6IR3hIWMhm2tdoJWV8Vz4KXdXP
	eBIHJpw4TDNhI3sEXOICzTIYbJpdKg+KB9vvblyHs0PYe75m+mJgFERClA3fWXaY
	i08AHj0cYej44zSoQD3cnjDH9pPH/1BYJDfgC6oqbm/icCgpusRzGcFqksSnDVaJ
	BAZif341A/eNYm4OSGDIOlJwXq5qXn4bvlyVIezAziNZ4b9qo35o+v4yBD1MN5/k
	BqJO7DKwCrqBEFzpWnsvSTOSxywpXnkpm/5kCaZMqw==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cnhx59j6x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Tue, 03 Mar 2026 06:16:17 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c6e24ee93a6so3447195a12.0
        for <linux-acpi@vger.kernel.org>; Mon, 02 Mar 2026 22:16:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772518576; x=1773123376; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=jBfJTiyHpDNC9aAf8vmH+NG8GrN3IfFl9hSg78Pea7E=;
        b=habgIZQlZ658lTb43MCyDOkob85IdjDW7AX5OzEJPOHdIVzUVdg6RM9wdf99FTbNws
         uIu5LnEvDoSNNp8FkxJGQOmHcBLQv/IswEEp0PVAjc5p4MxA+yqy4bAKS54CxBvYTok0
         Ci4MzkaRLgjbo9B3S1aFRNqwp0b5IdRFYrtMftE1WeaoCD5TZCefQCIMSVmxFIX/3216
         PF7YpAWLaIBmMgHQJkWxmMR0ppnHkwDS/VZNtM4hki0PO2Qc8XU4vWmlpfyXddNa+2yG
         +2saOKByvhEeFzYr5kEVL0bdtCWKpWrp9jM2I5rCXNr6kBzc1sIT9p3dMOT3glaCIm1j
         eAKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772518576; x=1773123376;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jBfJTiyHpDNC9aAf8vmH+NG8GrN3IfFl9hSg78Pea7E=;
        b=Tp3oPor8CDCMRPbams8LBPrwAz+jamHgdbX9oXDeI3wDZ5YNxDpJDR43ClQAqVQzUO
         4neq3Cq2j84uocrb30b7U7v3agwX7s1VgKrOmDSVOnavfAlNPx7EPzkAtD6DMh211qzj
         hHMklGcNYevrdum7RmR9SvvXr/OJP8jLCuBL/u0r2Qbk98pOGb11KzIMqriTN80YM2P8
         u77zoEpjWfHw9WMElYSM5VSnho534Wx72USxXrea3VWR+ucK5i8kcz9k8Q8s7wI62JaW
         dKr1hqCWnLr7Md6nAYT5UNSUTJNMuhTSqzOY1YOXQYSdE93QWFfp34xk95UysNA5dGkG
         gYzA==
X-Forwarded-Encrypted: i=1; AJvYcCWP/kyS0HQMdO4Ykz/4KcnL+Y9t4s79qQXF4oGSIOWe0ukrCQ+wIewY8vsvCSosQHNnMRvtlKGHrjgv@vger.kernel.org
X-Gm-Message-State: AOJu0YzjeqWxzmLkliPouUx03CcoAB4VtownPR337dCGVT58UO/MQgF+
	INdpR7YFOZFVa/lG++qSZOE+bET1vFzsJ++S0YLw/xhJhDqVcY0kY8i4ELhBzaEgbSICLOjmadE
	LqcKfMTWm2BUo5Poi36XPzzdOnKW7NenUfN7PdlxcZYKmNYJ9CBi9i1DI8XQsM5fZ
X-Gm-Gg: ATEYQzzkqX33OxtuCyLZm7w2fPmhtdCGZ4C2ngdWjXBXJNWEJuIDRqXJdawwWdGHE6Y
	RWYoyLK/K3v8FVob/X0DxXS/lPYDtt8HoyRIfWKHGOVVg/bunbddyQpZr4no0A+ejBO7YHPCA3B
	jkDcJYyT1EgkdygvLwyXDur+OHa9cYFi7STJWEvk5a9iTwyNKyMvgUwxKviRu0vDRhnr7UoAQqa
	QxK5nXcXLv1ETp/V9+AyhrQB63YeHUstQa9eQvEHFhTdp9nOarta99OD+yiBw1A11tTbCZ2tGV2
	HJ0qESmXxsFgvD8kkPMIAHRBeBf6BuGGytY6FWeiaDSAP2cWi54L7/5dC1xA+yNTECiNjyn3sRy
	gXioEcSHSk14nAVXA9k2+o/iEGsP0OF7DYTgKkJNynWsJckYBk+EU8OVJ+teLPJstWPdE7x17/C
	kjtg==
X-Received: by 2002:a05:6a00:13aa:b0:821:78ac:f197 with SMTP id d2e1a72fcca58-8295d99ff4fmr1205381b3a.23.1772518575874;
        Mon, 02 Mar 2026 22:16:15 -0800 (PST)
X-Received: by 2002:a05:6a00:13aa:b0:821:78ac:f197 with SMTP id d2e1a72fcca58-8295d99ff4fmr1205358b3a.23.1772518575401;
        Mon, 02 Mar 2026 22:16:15 -0800 (PST)
Received: from hu-sunilvl-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82739ff350asm14132649b3a.35.2026.03.02.22.16.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 22:16:15 -0800 (PST)
Sender: Sunil Vishwanathpura Laxminarasimha <sunil.laxminarasimha@oss.qualcomm.com>
From: Sunil V L <sunilvl@oss.qualcomm.com>
X-Google-Original-From: Sunil V L <sunilvl@oss.qualcomm.com
To: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-acpi@vger.kernel.org
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
        Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
        Anup Patel <anup@brainfault.org>,
        Andrew Jones <andrew.jones@oss.qualcomm.com>,
        Anup Patel <anup.patel@oss.qualcomm.com>,
        Sunil V L <sunilvl@oss.qualcomm.com>
Subject: [PATCH] ACPI: RIMT: Add dependency between iommu and devices
Date: Tue,  3 Mar 2026 11:46:05 +0530
Message-ID: <20260303061605.722949-1-sunilvl@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAzMDA0MSBTYWx0ZWRfX+wLKp+tQ8shh
 JUFYBWU111QnM+6EbAImd3tNt6eT+O2/lGxmn8Db6kJa0Yd0VECsKwQ8BZdIv500A4NmD3RfupQ
 yN823mPvnLo2d2p34Nm+Pv01uHzZbB5bnnaEWlqWcmqTIYmv//2iq57W474Jv5bqsh6jyGJ4VY4
 PxTBl09PBK+KHJRW7IBYKlA4b6tMjdopaoeKVpvcd6GBG0Fd24qDaES3VBZQ/e1g6Q7dJXAaE4n
 pBZBIbDkt79nOvqpUFRp+i4zZzDz0pQFEtaVOAn/lmUJzHQXJAVm24px/UOCOe7jAMaOpASnKHP
 MtLOImH9jKl/mdzaPcnm6M2Dj1WVxquvmSmLlEM0oVY1qO/xXwhFFS1ujoh7wuOSi60o4JsMfSb
 PLDs+I8zwhmrmxgSWiMiHnPNHt1CdcQs3Dbo2gf5K2g/zHUz0Om92BZmJmOfpXPYhs9LrgNOSui
 i31MjQOM3W08ZDCj+cQ==
X-Authority-Analysis: v=2.4 cv=T9CBjvKQ c=1 sm=1 tr=0 ts=69a67cb1 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=UhKKETOMA_ZNL8J_uLkA:9 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: SEyER_4YZZnZXuGqCVu98juTRUfORAJ4
X-Proofpoint-ORIG-GUID: SEyER_4YZZnZXuGqCVu98juTRUfORAJ4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_05,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 clxscore=1015 suspectscore=0 malwarescore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603030041
X-Rspamd-Queue-Id: D94021E9924
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21303-lists,linux-acpi=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_NEQ_ENVFROM(0.00)[sunilvl@oss.qualcomm.com,linux-acpi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

From: Sunil V L <sunilvl@oss.qualcomm.com>

EPROBE_DEFER ensures IOMMU devices are probed before the devices that
depend on them. During shutdown, however, the IOMMU may be removed
first, leading to issues. To avoid this, a device link is added
which enforces the correct removal order.

Fixes: 8f7729552582 ("ACPI: RISC-V: Add support for RIMT")
Signed-off-by: Sunil V L <sunilvl@oss.qualcomm.com>
---
 drivers/acpi/riscv/rimt.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/acpi/riscv/rimt.c b/drivers/acpi/riscv/rimt.c
index 7f423405e5ef..8eaa8731bddd 100644
--- a/drivers/acpi/riscv/rimt.c
+++ b/drivers/acpi/riscv/rimt.c
@@ -263,6 +263,13 @@ static int rimt_iommu_xlate(struct device *dev, struct acpi_rimt_node *node, u32
 	if (!rimt_fwnode)
 		return -EPROBE_DEFER;
 
+	/*
+	 * EPROBE_DEFER ensures IOMMU is probed before the devices that
+	 * depend on them. During shutdown, however, the IOMMU may be removed
+	 * first, leading to issues. To avoid this, a device link is added
+	 * which enforces the correct removal order.
+	 */
+	device_link_add(dev, rimt_fwnode->dev, DL_FLAG_AUTOREMOVE_CONSUMER);
 	return acpi_iommu_fwspec_init(dev, deviceid, rimt_fwnode);
 }
 
-- 
2.43.0


