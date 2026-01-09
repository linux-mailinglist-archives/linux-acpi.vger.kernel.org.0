Return-Path: <linux-acpi+bounces-20115-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F2B09D0AAB0
	for <lists+linux-acpi@lfdr.de>; Fri, 09 Jan 2026 15:39:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8D5BF30CB101
	for <lists+linux-acpi@lfdr.de>; Fri,  9 Jan 2026 14:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FDCB35FF7C;
	Fri,  9 Jan 2026 14:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mTGzVf2n";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CS+Jbgff"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E71A35FF6C
	for <linux-acpi@vger.kernel.org>; Fri,  9 Jan 2026 14:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767969452; cv=none; b=dCvIaZYK/oU8P2IbnqGmKmgavBAV3UeCSjBJWLy1zKbICmZjZKAQPQnXV9DSHGt90cz/3yzcQ6gEDplhLHWE3eLNM9rxoQ2Rm04DBqfQkH9OKcLp0QNRT3db8tQgWzJSy7gLbgeBFVCJX3ArorF/RBffb2uukve29YXE1OKGOsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767969452; c=relaxed/simple;
	bh=dsYdNgsl+vlBqYNhq51V/s6LnUw3bm0i40vFYzGlwMo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fGpC3dzXGMIsk999NtWkCxov95Qyn7qn4iTA0j6zxLpCpFMBb6qCW+Q4alle4SxLyMkN7aq8gdxOUBZbtRym0woMc7xSQbZwhzjzDhaHV+yX5C4o3Ol3jTWTjNS5CKsGHMIOsm5iuSClEk+uKzbI4u7m88C4mq2lH7M6TNFwKKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mTGzVf2n; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CS+Jbgff; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 609B39R71063483
	for <linux-acpi@vger.kernel.org>; Fri, 9 Jan 2026 14:37:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=
	qcppdkim1; bh=+ysgsKTq/m9T0qhX5590PZF3RQ4Mh0B8PnSQRpVzqAQ=; b=mT
	GzVf2nDhMw4o6/3HLd/DbZ7cczaTSnz2ZaiG/2pJV6UDzpW3OqY1qBbje3xrOi8R
	8ByOpa44LCArRRWtS1jP3uWpgU9alL3VBNqfyRH5N9YdeYovPczZpjSAsH1PvITI
	MA1mzUkPdDqNiwMaL6upiKH3H8/LsqiJERwe2xVyKracA7mMoZQMknrCqXRc2Crb
	/Lr/SMIWfcRgD8XUz7emNhMQ4wyopgqnF0z2Ynk6zeXhzz8iFZr+M+Ydn7Z6EIN5
	aTDv3ERyfgeBQn7tRQ+AEwJWL3opQf8xboU9aNpHtgBI2uUSb+4TDEeD5iuPWNrh
	QOnnVaxSk40hAztYMxGw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bk0f68hpd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Fri, 09 Jan 2026 14:37:27 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8c2bcf21a58so1153082485a.3
        for <linux-acpi@vger.kernel.org>; Fri, 09 Jan 2026 06:37:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767969446; x=1768574246; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+ysgsKTq/m9T0qhX5590PZF3RQ4Mh0B8PnSQRpVzqAQ=;
        b=CS+JbgffdJqoZwx8U54K4j1YiJPkCgwsltg+xCUhn6Y/3TvNlniSrh7hFWOjs+LseF
         R6UbWg2O83A11u4Olq0dT42SReP//ceuU9t4WmOfr/ZvvZnLo715rhYvKGolxwy1WWJ/
         +mjxOEvMn0+uodF1w8xtiM2uco0tHaQG/23ZlJpGs05WcDDsE+YIXtbhLhaSfrpKPcoo
         spKw9+o+QtCgx4uV8P2maQkyZdbr1W5RH9SwNLYrCxjzkEijDlWktaHc9adtUbAsBusb
         kE5j0a3BVPgryBsgqRP/j2uJx7bnCIvYaS2Lxo+9FNsbi3WnWzv1e0RfTKG8SQmEVi42
         aN3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767969446; x=1768574246;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+ysgsKTq/m9T0qhX5590PZF3RQ4Mh0B8PnSQRpVzqAQ=;
        b=doKm3UlXDTVMTFLCmeiSYWNOuDr0v9ISKMKI1aETZpD/wYH6ejQ1PJWGgbN6+apCLV
         Rf7pZyQtHItq7AwcwKF4XA1QiUyohDHTeoItj8MC+jsjbwrk/l52o1PsiL41iQMP3Pqp
         YnJtlc38cSXpkuq9mQ0CeDGHk30MAzSM4JxqxG13aR9Qi1DgpAg7AYkgRMd028Mndxsp
         xp1M2KemFACu+t/tDYoSovEbad/PlANrDnKiGOuMGwGjns7oBx2GALsvcCRTH18g78az
         3tTBKN576Q5ykY+Fln/VKD2jM46OixOseGzB4pfPNsT3b89vK7UpnDeKpe6iwwbiuu1z
         oBuA==
X-Forwarded-Encrypted: i=1; AJvYcCWwNuUzz4eBSWypvdRFukysMA8mYrpaWV1yQIL9mNori7P3bDvtPC91pzEy1jfaU6RIXrWvKDbYuuy+@vger.kernel.org
X-Gm-Message-State: AOJu0YzzTqO+zuKRxeOQGve1ICSrr7CBpDlUp+zMVUaFOsKfNZJF0DIj
	qjhy6pqMeFLRec+oZf1XCpmp2gi9orTd0ZMQF3w2OihMrZsaQTqaNMImAiI7Xbad51NITJDuLNY
	SyiwqnLGCtDqv3J2+l4ly72qzlvJFEQI69iBND5hEJ8Y2IAWlkCGuPUOQQMlKBwgJ8Cf+BmQ3Is
	ZMQJcQK6sxRA/jAbz1sSvZURHfPVMGqlYrtAFGKzz7CdxfNaHftw==
X-Gm-Gg: AY/fxX5iL31q0w4vx7cvKDMcoRCDJqxFglx96dVnO+pLqr6j0dvCNR9HecmKLiS1PHk
	AiETZ165RulvftdzwgL+rv7/Y6DEMkny+TGXIChfXvbumaWwNpMDBnxmd8Fn2NZWrx03FurrCAT
	Sv87ce8X40GBSisc9HhgGqYkBJtUXo4sPEHJGmelO7Lxo2BCiN74fOHEI2uKbrKCuSITQ=
X-Received: by 2002:a05:620a:318a:b0:85e:24c3:a612 with SMTP id af79cd13be357-8c3893b2c4emr1367490985a.32.1767969446137;
        Fri, 09 Jan 2026 06:37:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG5/7nOlDZo5viCDFcqB59VO553vPiFD2t5yij1MhIo9Az81+Uf2uPVbDkTkMomisRCSbRk6+fPaS1p9QPc/VM=
X-Received: by 2002:a05:620a:318a:b0:85e:24c3:a612 with SMTP id
 af79cd13be357-8c3893b2c4emr1367486685a.32.1767969445611; Fri, 09 Jan 2026
 06:37:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260109090224.3105465-1-himanshu.chauhan@oss.qualcomm.com> <20260109090224.3105465-3-himanshu.chauhan@oss.qualcomm.com>
In-Reply-To: <20260109090224.3105465-3-himanshu.chauhan@oss.qualcomm.com>
Reply-To: sunilvl@oss.qualcomm.com
From: Sunil V L <sunilvl@oss.qualcomm.com>
Date: Fri, 9 Jan 2026 20:07:14 +0530
X-Gm-Features: AZwV_Qi5BjfSLxD-fWr--rIzTe5eMh_UeAHuI8CxS4Y_6Lnfr3xI3R8vXnjfma0
Message-ID: <CAB19ukHDigCSgubLBxq0Pq6XuOfg3gEM7TWse3sNH4EkqqAcGw@mail.gmail.com>
Subject: Re: [PATCH v3 02/10] riscv: Define arch_apei_get_mem_attribute for RISC-V
To: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-efi@vger.kernel.org,
        acpica-devel@lists.linux.dev, paul.walmsley@sifive.com,
        palmer@dabbelt.com, lenb@kernel.org, james.morse@arm.com,
        tony.luck@intel.com, ardb@kernel.org, conor@kernel.org,
        cleger@rivosinc.com, robert.moore@intel.com,
        anup.patel@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=P803RyAu c=1 sm=1 tr=0 ts=696112a7 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=lVw1crRH7-GITBzhd7oA:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA5MDEwOSBTYWx0ZWRfX2/k2O11RE8dn
 W4n05YsLNxoFbhsWDqDB+qjIEWZ4L8R5DBr3uyPB52Vi74KJSkggy+83rOAdqgy7WBZn6feCtYH
 CF6m87lf/oQ706D7Im0s+4pkIVtyrvD0WsAAUYG/TZCDeVkDLhtIjtOk/oOMtJplxKraeWDqV9P
 KzxzbucEmr941cRk2ZM9Jl65MO2HbMtqygeZYehhm2y24U5xwE+BwEruKmD0PRkuN9RCYBNaK8G
 mx3w4vhgc6T5HrUyOyLa8rOY+UxeNPDo4Ywmr+Cn+MF981EI2xOchT5Vd8JZla4+DiUy4t45cEs
 vzuf+I9WBBmyyHwmU1yHPIYnKa5e7vMtZpB/V1dtKTadRitSN/gsD2cLKB0LIzttLO3spJbtdoW
 KWpN4cED5S1UYXTQMxIkHG+9A/jRY5uIh0mc4gv08sCdekFbrE3Yq9UTsHBNWwIYk0jT4PI7nPp
 91NklFmuwKGqk3kcUwg==
X-Proofpoint-GUID: i08hznVeKQM1EYEIZaL2Mo7BJVuLzBh_
X-Proofpoint-ORIG-GUID: i08hznVeKQM1EYEIZaL2Mo7BJVuLzBh_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-09_04,2026-01-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 bulkscore=0 spamscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601090109

Hi Himanshu,

On Fri, Jan 9, 2026 at 2:32=E2=80=AFPM Himanshu Chauhan
<himanshu.chauhan@oss.qualcomm.com> wrote:
>
> ghes_map function uses arch_apei_get_mem_attribute to get the
> protection bits for a given physical address. These protection
> bits are then used to map the physical address.
>
> Signed-off-by: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
> ---
>  arch/riscv/include/asm/acpi.h | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/arch/riscv/include/asm/acpi.h b/arch/riscv/include/asm/acpi.=
h
> index 6e13695120bc..0c599452ef48 100644
> --- a/arch/riscv/include/asm/acpi.h
> +++ b/arch/riscv/include/asm/acpi.h
> @@ -27,6 +27,26 @@ extern int acpi_disabled;
>  extern int acpi_noirq;
>  extern int acpi_pci_disabled;
>
> +#ifdef CONFIG_ACPI_APEI
> +/*
> + * acpi_disable_cmcff is used in drivers/acpi/apei/hest.c for disabling
> + * IA-32 Architecture Corrected Machine Check (CMC) Firmware-First mode
> + * with a kernel command line parameter "acpi=3Dnocmcoff". But we don't
> + * have this IA-32 specific feature on ARM64, this definition is only
> + * for compatibility.
> + */
This comment needs to be updated.

> +#define acpi_disable_cmcff 1
> +static inline pgprot_t arch_apei_get_mem_attribute(phys_addr_t addr)
> +{
> +       /*
> +        * Until we have a way to look for EFI memory attributes.
> +        */
I am not sure I understand this comment. We should be able to get the
attributes of the EFI memory regions. Do you mean the memory region
attribute will be the same and currently don't support non-cacheable?

> +       return PAGE_KERNEL;
> +}
> +#else /* CONFIG_ACPI_APEI */
> +#define acpi_disable_cmcff 0
Why is this change required?

Regards,
Sunil

