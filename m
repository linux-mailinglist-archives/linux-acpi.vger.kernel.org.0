Return-Path: <linux-acpi+bounces-13370-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97EC9AA1B55
	for <lists+linux-acpi@lfdr.de>; Tue, 29 Apr 2025 21:26:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E854B4C84DC
	for <lists+linux-acpi@lfdr.de>; Tue, 29 Apr 2025 19:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9707A25F78C;
	Tue, 29 Apr 2025 19:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="o3eFeqyZ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD99422A7ED
	for <linux-acpi@vger.kernel.org>; Tue, 29 Apr 2025 19:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745954762; cv=none; b=T7ZzSmrd7Y84uVy4imkOQO2COGPhSGFsuPs7sEDumb/T/ADRjLE7rBZOaPcyMninFkCNXnXJwkbai7NOunpefnLRqMM3ggmqCBG+5UC/nswOmgFZlSN/AHnFkJOoRa7BfAEiKYTtxaHv2MUeDgKjREUgHMv4FSXxLJRYljdPprE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745954762; c=relaxed/simple;
	bh=nOsG60cjnryw1HpcpeTERdYcwGbMkzNgzgyEU01q3us=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iCAk/c/fJP4we2Dtp4Rg+yR+TOxpmFDzcoHZnKxBxy1ASTKzumErg25irGOTwxDFCvd4u0rl2ercXV7NfkzLgHNfKZ4JueFD7jLArdGZ33CAuVODhrUoJEax9MCfs1L0BQemiFnxEOZINhEJhIUYdZqkVoMvEv1QWvcr4t84E9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=o3eFeqyZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53TAJNKk006055
	for <linux-acpi@vger.kernel.org>; Tue, 29 Apr 2025 19:25:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SZDZI43E332yNRCJFIwANBWoXEasKU0d/26e/2xQtgs=; b=o3eFeqyZdPLFuCuH
	mP7nN9MEbhQ+Mt8pmNMbSPMTt1IvhBiQzblyX1+x3ULG0XB1A+lB/aoNc3Ht4Pgq
	DlJ4M/1r2Ctd0FG1W82odOgUwCgjimm92UfF6YNB/KiCTuFj95eCRUFib32hij9U
	ycI7pnmb5QjnW/ZqIkqWaYYpcI0sVq2Bb5O3JPKiBy3x93oPJjd2pKylQcIpjlbp
	tgvWeTUtS5hx81RgYui13cn413QQPZ6mrXy45V6FLtvuwArdNbifm/fjn71LrwAL
	nIQ6OeFIlrqhpko4UqwJ7U2DeZ8UY8TDP5sWorLJIkLQ+SD/UBfQXa/nNCDYDiXI
	p+9Ugg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 468ptmnpkx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Tue, 29 Apr 2025 19:25:59 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-47983a580dbso13497541cf.3
        for <linux-acpi@vger.kernel.org>; Tue, 29 Apr 2025 12:25:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745954758; x=1746559558;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SZDZI43E332yNRCJFIwANBWoXEasKU0d/26e/2xQtgs=;
        b=UIyWUG+m4LEkD1q4e4rjW3P3OrEIM43ajeTI1hg6WOCYtN7NYHo88GHxI9sPP69S5Z
         4MUllYkG8QIvoRcfi6jc9DNN/Sv+IcHz45rX4glfTo/A32OUQH4DUjjUHnIXlFANiZLF
         1+vOMpFNugggW89DvGG72NcbP0ZKNFKbHm4+OoTk4Uw86cax6f4M1l5WIbajvevuuNlA
         s16THJge3Vdm0QfEH2cA3glI6tGBl7a9sYQb0Rk3Q6Y/ZYj8apMRkUElpEyZ9kz4w/eH
         ETdejMRQTL6tplqxnBUb4sLBz0Jlq3tJ1B2LFMT9YR2pS3CovhHtl9xOAVLXSmIB8S0n
         3kYA==
X-Forwarded-Encrypted: i=1; AJvYcCV1obJ2RFraMstzv+XYu25Xyruxuym5blbnUbWD/XhWv7Qh4Xa3JIRWoPTSsX1Ior9TGR3Scn8BxXEp@vger.kernel.org
X-Gm-Message-State: AOJu0YzLSZgGA3WXfeqnPX57FfSmV/n2e0eISb4dXvqklHWUYHp3M7K/
	+7T5CRuiDVU49uDRKzFBZoXuSZxU+5eId/FWVTdehPZumQ7ws42BkDRJSYqtpUk1oWDJ62Lo+jT
	d/v+dpnEh6Lr7lBGr2oVfszynPeUKzzHyIiHRBPhqiHDU1lWf190VqXJLXpGV
X-Gm-Gg: ASbGncue6sV9GjyyeyBiyiNHA5pMDKyOhDdjemC5n7MFSEg3vYeTKowpHNKnHvLIn1r
	lYBvSOoCxL/sM6eKqlxhpdVqPVS2su+/YrFcbSYJV/tFpXkfCE9DItyC0cOiyBWCJxZGqA8FgDa
	4UPDyiwL97K+zlIw4kbuA7il1ODjpkmYLMZR+1sGlcPdGEoe1XbtwQBz+A3S+A6WZb0n2Fly4np
	YgqitvOmfznUiItxMeRzFD0pTpr0c/1W0VyivCy8HBHZwZvILUIbo7hFXOlqo2k0ugWbdUgrJgc
	9RTkDWtcUORKGMPH0Q2EbnT5AAqMrk3/8CNK2s74uOkq4jNPp0J9LG6P8QjLybP5Dw==
X-Received: by 2002:a05:622a:1490:b0:472:1d00:1fc3 with SMTP id d75a77b69052e-489c445ca44mr1384791cf.8.1745954758659;
        Tue, 29 Apr 2025 12:25:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHeCpvJWeqZH0ttcvHHJ9VqFEgyci4j9m5BtdmVr/zQ3sRean1THCu8ARbeAV6i3mZ/LHvo8g==
X-Received: by 2002:a05:622a:1490:b0:472:1d00:1fc3 with SMTP id d75a77b69052e-489c445ca44mr1384561cf.8.1745954758152;
        Tue, 29 Apr 2025 12:25:58 -0700 (PDT)
Received: from [192.168.65.43] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acec0530c37sm225421966b.136.2025.04.29.12.25.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Apr 2025 12:25:57 -0700 (PDT)
Message-ID: <da8f8506-edbe-4a4a-bef9-29126d3e5c04@oss.qualcomm.com>
Date: Tue, 29 Apr 2025 21:25:55 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] firmware: SDEI: Allow sdei initialization without
 ACPI_APEI_GHES
To: Huang Yiwei <quic_hyiwei@quicinc.com>, rafael@kernel.org, lenb@kernel.org,
        james.morse@arm.com, tony.luck@intel.com, bp@alien8.de
Cc: xueshuai@linux.alibaba.com, quic_aiquny@quicinc.com,
        quic_satyap@quicinc.com, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@quicinc.com, kernel@oss.qualcomm.com
References: <20250428095623.3220369-1-quic_hyiwei@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250428095623.3220369-1-quic_hyiwei@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: OOJY8ufc_GFKfVxMpVFpr94rn3PopXuu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI5MDE0MyBTYWx0ZWRfX3riRIvrjQSqd szI1klmZMVxP3uknw6NIkaelmcnKw+/JXpDyqLKfB6xTmKCeDvEEBWctnokL3/OoHKjEIGDIZSh ny5Hx0Ki8ad4kxR1nVv2yCGA0KBMQfMMPZBPS1Yo822rXfFKC7fXLRo3aiqkoww9lU8qfX5G81m
 Y5uZW7/m4i9lXLdY8dpBSZ+yD0zxiiC4jldOiwq3cjtKHKJ1gC5H8dBqy771hvDp5/vRSAH77dT bAbw2oUEUZYoCUqf5mcMpUmIGs836sXMF1QFos7q135/O6JohK1wCnre6PmdzfPq7RcqgWiVgId d4BCQdgEBM4xzN6DYUGIU7iUil2D7QEGwl5mU4UZ5HcolCoAISHawksLMfvpwHDPHI8Gokk6Bds
 30DshbBfwXuVoyxOl01Ys3+2fj4q+bRgisX/rrEk5Xsp8DZ2s6FmIfx/HxYVJp++2ROI/+P2
X-Proofpoint-GUID: OOJY8ufc_GFKfVxMpVFpr94rn3PopXuu
X-Authority-Analysis: v=2.4 cv=DKWP4zNb c=1 sm=1 tr=0 ts=681127c7 cx=c_pps a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=SRrdq9N9AAAA:8 a=COk6AnOGAAAA:8 a=uYIpP0hKP73jGhetqrMA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-29_07,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=848 clxscore=1011
 priorityscore=1501 impostorscore=0 mlxscore=0 bulkscore=0 malwarescore=0
 phishscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504290143

On 4/28/25 11:56 AM, Huang Yiwei wrote:
> SDEI usually initialize with the ACPI table, but on platforms where
> ACPI is not used, the SDEI feature can still be used to handle
> specific firmware calls or other customized purposes. Therefore, it
> is not necessary for ARM_SDE_INTERFACE to depend on ACPI_APEI_GHES.
> 
> In commit dc4e8c07e9e2 ("ACPI: APEI: explicit init of HEST and GHES
> in acpi_init()"), to make APEI ready earlier, sdei_init was moved
> into acpi_ghes_init instead of being a standalone initcall, adding
> ACPI_APEI_GHES dependency to ARM_SDE_INTERFACE. This restricts the
> flexibility and usability of SDEI.
> 
> This patch corrects the dependency in Kconfig and allows the
> initialization of SDEI without ACPI_APEI_GHES enabled.
> 
> Fixes: dc4e8c07e9e2 ("ACPI: APEI: explicit init of HEST and GHES in apci_init()")
> Cc: Shuai Xue <xueshuai@linux.alibaba.com>
> Signed-off-by: Huang Yiwei <quic_hyiwei@quicinc.com>
> ---

[...]

> +#ifndef CONFIG_ACPI_APEI_GHES
> +subsys_initcall_sync(sdei_init);

I think it'd be good to leave a comment such as:

/* Initialized by acpi_ghes_init() when ACPI is present */

Konrad

