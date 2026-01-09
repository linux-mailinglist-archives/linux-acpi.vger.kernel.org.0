Return-Path: <linux-acpi+bounces-20100-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EC213D08169
	for <lists+linux-acpi@lfdr.de>; Fri, 09 Jan 2026 10:07:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6B66430856B2
	for <lists+linux-acpi@lfdr.de>; Fri,  9 Jan 2026 09:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40B22331A5D;
	Fri,  9 Jan 2026 09:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QYhlGNSa";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="A0lsPJH5"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6AC028D8D9
	for <linux-acpi@vger.kernel.org>; Fri,  9 Jan 2026 09:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767949402; cv=none; b=nk7UzyKmfoS/i7ShQLw/6b6uT5eVCQnWohy8F/zgTt2kwM+6NBItneoPdxaeAGoBJFIH4O8cw/s2BcGRwDrNzpqyx+6YXkfpVY8MjNxha8fUWQ73jOSkJQOUdQtkyejrLN9TpgOW1rn3a5QG1U4m2zTBT04EQ5SVirI77O+5jrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767949402; c=relaxed/simple;
	bh=z25NS89FtakA2eko6Ure0qKn5EJXXO+h7R/VGAf7s14=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jdkLq0G8l+zJiIuhsuZV3sFLOnhmvABR27wFi5TLNPulvbpXIdgDbUFu+N25sVfrHJRLXAylY5fzVURq3qNkCzGaWyKKfduK478djPvPlhs0r0n5DHhwqVSWUIuHzg82AlZTev6UzmvckeLtAhIPbbVKeCkXOwI3FclPDyHjnGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QYhlGNSa; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=A0lsPJH5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60952l9G3542271
	for <linux-acpi@vger.kernel.org>; Fri, 9 Jan 2026 09:03:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=CYIkrEqrqp8
	jD5QuPnx++ARhgF+TQWP9mqsMoFPAsjM=; b=QYhlGNSa1E8AeS+9k6scumC25RY
	Llo1ynUGgo1yhtVX3rnJ0TyHR8yxA7nGZAWdiDYJq9ySB/O3bjp6GXTDmbCxyp1P
	7HdODDWvrF4RN72k3dg2LD5a74XVPB0lEQ4OcBv0zKvS5lV8RFiv0+TcT7bltSb8
	Kr8OZnN+pUFYLvxCUrWaMI6GHBANnzcVZg8ucs1PPDIIkx7PSwDOnNSEw64yPWdM
	YTMmnGJQw5aScR4WZPRtL19BFXOp5nVETix52Jz+qI2yYubXe0lIykqx21wAQivU
	o3+S2vzQMkk12y836vf4OwBL1DqnxTi2ucQOHcel/cD583VC7OqVsV5NtAQ==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bju6b0ngj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Fri, 09 Jan 2026 09:03:19 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-81e81fbbb8cso347196b3a.3
        for <linux-acpi@vger.kernel.org>; Fri, 09 Jan 2026 01:03:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767949398; x=1768554198; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CYIkrEqrqp8jD5QuPnx++ARhgF+TQWP9mqsMoFPAsjM=;
        b=A0lsPJH5+uzERPPj45pQ+v6AmNpSSrjMkNpw2FDYxtZl1L7ZlWq/v8EdTVQR7t2kVJ
         4wn0vIqI9fLCsrtXUIx+PqbqgvWWRIlGY8OFbZaj9E+egUKnoQh6xAdo5jzyebd7M8B9
         agHu2yRX44Q+E/QZdoNBFHU4jvV6kxRtDA8Rj+HG5MlcTJ7IKfgkPpB/m6yd+p89Z1JZ
         2rFS459ijg2F9nIJNxAdtlIBUBPLD5Duw/1ppOPsAvbM9loQ50BAP7frijEiy58eGIYG
         t1sOA/VweVFk5rtDyP+b56GJdrYFM+kxsTIcJeivgYhMX5Vj+o9FTjvOv7gC99HIPnml
         1ngA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767949398; x=1768554198;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CYIkrEqrqp8jD5QuPnx++ARhgF+TQWP9mqsMoFPAsjM=;
        b=po6h27b3CV0+zbIMox2QPgIjxD0EGX9IdML28WRX7sHi0mdtSXFwzaaX4kNTFkLGBJ
         Qg2bN92a77xuYWFR5MV0JPlGO6imGVEe2t4m17DHV7uEPuUZJDYd+lSi6yBgWntM2e29
         PmuhxndnWAivZTzvDMMYDqsFeG6BTcssGHdGmuvSB4EZPhTmSGmIxIdy4eI/7okXZT1S
         gygT0O1KfrDGVTMUVrxl2KVC+UrFJMQfKCbQfNp1c+c+OhoEhm0WRJWBOgZ6zTpxnmgS
         444tuqFWMY8BPmBssAT6rneOWDfhu/1jjwp8GtmguQ5+Z4PHb5vsixzI9kex9+YzjkF9
         3JYw==
X-Forwarded-Encrypted: i=1; AJvYcCXNvG/Ip148w+EsmvApbsiAy2n7xhOgVHuXawnzFaswOKhKcDhu7xg2A7kHfq46u2q8ds7HJtzHHtQi@vger.kernel.org
X-Gm-Message-State: AOJu0YwZiGNsJUqwgHmL/ZW0Ay93xss/KMVdR5VeFATUfwl3dC/DRsaH
	IAWXGRdVaeK62T904VL1SgEbf7qnTqeTW8mlZkMLoSkmLSEXqy9BBJnBOoUB3BmNM+7qSJph07p
	JDW+dJHatW8fCDFCd7XWpNb/Q6vwVa/432yt6MvYNmt/spBZRwQa224gGiF/9LTin
X-Gm-Gg: AY/fxX5eEEk4+XlJ3ekkwlcF+HjK0dLsI5GXDvZm8Z+uk7ZAX9Te/jyjPn797RLlU9c
	xGIME/X936DBWMnC6BL9rZpuM72tJMeNwoGXUfXK7LcL38h0VSnOMaiM3pOjUH4h+Fv1pKqChIW
	M20jAO5MlmWkkjDZyxuCokgiqhQHnK9To8p77XOAvqnaCUdcOiDhb9fdi/o9XZLuQs32u57Zhr9
	T839RG+NcOiygaLQU0jczdlWz5W0L+v/c/IrtUZicnidmpTgbdCvMxktXOZwElg4iiSpV4vQLLJ
	Ru3s/SstnDXE+zmik6wHTuykHmFzW0hXuW+sFy7qe/LHbO2sc4XkZgkaBg2DVXrkiX8nwe029xn
	kGv4xXfLeqUW9/F/54PRgj3qDN6zxBYpGQ0P+Tb8xFozvyCW/+gbAKiz4la0P1ntd108FXMkRQL
	r64oaBp5cBEjN85lsVGgM8hOT6mcg5ljKkZA==
X-Received: by 2002:a05:6a00:369b:b0:7ab:4106:8508 with SMTP id d2e1a72fcca58-81b7de5ded2mr8194215b3a.28.1767949398520;
        Fri, 09 Jan 2026 01:03:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGZwwdauYHJ7mo9yWi9RFBYJfFv9+fHWbIuLHl8/MaWDzNNkxmOHuFcgwapDAslrzzgxq5nlQ==
X-Received: by 2002:a05:6a00:369b:b0:7ab:4106:8508 with SMTP id d2e1a72fcca58-81b7de5ded2mr8194191b3a.28.1767949398002;
        Fri, 09 Jan 2026 01:03:18 -0800 (PST)
Received: from hu-himchau-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-819c59e826asm9831562b3a.54.2026.01.09.01.03.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 01:03:17 -0800 (PST)
From: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
To: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-efi@vger.kernel.org,
        acpica-devel@lists.linux.dev, paul.walmsley@sifive.com,
        palmer@dabbelt.com, lenb@kernel.org, james.morse@arm.com,
        tony.luck@intel.com, ardb@kernel.org, conor@kernel.org,
        cleger@rivosinc.com, robert.moore@intel.com, sunilvl@oss.qualcomm.com,
        anup.patel@oss.qualcomm.com
Cc: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
Subject: [PATCH v3 10/10] riscv: Enable APEI GHES driver in defconfig
Date: Fri,  9 Jan 2026 14:32:24 +0530
Message-ID: <20260109090224.3105465-11-himanshu.chauhan@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA5MDA2NCBTYWx0ZWRfXzvn+7ytsHuHc
 /BhiBJ9VW47TO2SqNR6nOhmbJkB3EM8M7QYrsUrRtO/rv8yp3fWI8zDsuEDj0NZRGn62n7XJZhE
 GPj82brZJEUinDUMRbxxHh2r3OeCjOqs2X4hzLOmUCbpfnH4Mav1Hq5ccxI/o3SHNldSn+bhcOy
 susDf5WKT3tPmgMElHdx0Pq3lYEhynAv+kVsrRQhlOvvA/E8Y6WR2DvXlv9WCgWLD6qKjYVm9Ba
 SypAjOXz+VUTi40hUTY/1iuHAxA1tDBsO6b85+2Ri0cEt1Q34kot5chZe6QSHLYlB6+xKPAoUT3
 U6PUgbtVO0v4/bLj8sN3xbtro7X1Tj4FxeMaId2WRBbfglz9MoG4OniLCYkFHDjxkjVZ/BAE6LE
 ZHzThgD+v2gzZ2pmdEDxZ2F6AeONKtLBAiV+Zcm8/vYDCpUOwX6hIVVyK8OPCEkNH5iOknvOwnl
 QBhA6BE1ZuxV63i20bw==
X-Proofpoint-ORIG-GUID: R21EW6dIHeY1aKha0uI5q3r_v6JjxIRd
X-Authority-Analysis: v=2.4 cv=V+5wEOni c=1 sm=1 tr=0 ts=6960c457 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=xUlk1AThICIXWUt23vsA:9 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-GUID: R21EW6dIHeY1aKha0uI5q3r_v6JjxIRd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-09_02,2026-01-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0
 adultscore=0 clxscore=1011 suspectscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601090064

The APEI GHES driver is very important for error handling on ACPI
based platforms so enable it in defconfig.

Signed-off-by: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
---
 arch/riscv/configs/defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index cd736a1d657e..38b4a802c2d5 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -46,6 +46,9 @@ CONFIG_ACPI_CPPC_CPUFREQ=m
 CONFIG_VIRTUALIZATION=y
 CONFIG_KVM=m
 CONFIG_ACPI=y
+CONFIG_ACPI_APEI=y
+CONFIG_ACPI_APEI_GHES=y
+CONFIG_ACPI_APEI_ERST_DEBUG=y
 CONFIG_JUMP_LABEL=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
-- 
2.43.0


