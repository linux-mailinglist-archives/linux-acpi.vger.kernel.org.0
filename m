Return-Path: <linux-acpi+bounces-18358-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3462C1EE9D
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Oct 2025 09:10:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B91FF188341A
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Oct 2025 08:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4358432C93C;
	Thu, 30 Oct 2025 08:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="O+yO0p9B";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Akoqr9/h"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E8C285CB6
	for <linux-acpi@vger.kernel.org>; Thu, 30 Oct 2025 08:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761811841; cv=none; b=ejmuoSLg5ZIal5v30jKUQaqf/zi1c6Ac5WucPgjR/g+LWOWqmR15nVqbufHg3vW0tqw6HMt/1EDw1oaJz8ltXYODfJOZwolFSaKejrjASANMygS87ArpoJJ4DYeaPy+L7DZ5HyZoHTgFoP2auLyia33STtZ8r0WjVWAiFmMCwgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761811841; c=relaxed/simple;
	bh=AbFlfNka/LMULfTYtozLlcZUbwq2UCX+dbWn5XbxTAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZSfP8sBU5aIrN0mIEyJki9nm3PLgU05Gxgs7y1tizybm71i5HaOAmR/8JqpwSDzmVYpeBSaTTP4wRbBCPPcNnOeci6KbF8MKh7TqXNKYTPv3MgMT6d6b081HI9jbhmH7QCw5OeeFdWb2k2IjpNzbG3FvEKWOXS49Q6BOtTnx0uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=O+yO0p9B; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Akoqr9/h; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59U7fR7R1578774
	for <linux-acpi@vger.kernel.org>; Thu, 30 Oct 2025 08:10:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=sKQ5jVf0l4p+IXXgicmYUBfd
	OUjcnM90HD067+of6oU=; b=O+yO0p9BDKyV8PNn4MnfKFPmGYM6YDHn6ZBQiHeo
	BK9qB9UmT2+yrEpng4Ytd04oZ3GhJU6ix1gjQtGbXnR7uX0YUWbTM3oIrHBHdcDv
	8nd5/qgkyVEfbNQ/cKQG008O7J6qEU378LWWS6BfV9ggbGfVciHqLpSKJ9TeOFcQ
	gb2WakR+4GUa+a/96Few+2O3EGE1s3+a2GJF4jmxJu/RBmCrtMWjWOKjV9eehUGd
	VQVg5ORBQ4QGw0H+P9sbvB0DHs9T4tnH3+fNaAu3zBMfNus/JQ5bfLIfut6c6eWA
	27FPTj3cxJdU8brWEcrhwtr9ej/6Eu5383EuPCEQtzrGcw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a3tjehk1j-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Thu, 30 Oct 2025 08:10:39 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-33c6140336eso1697577a91.3
        for <linux-acpi@vger.kernel.org>; Thu, 30 Oct 2025 01:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761811838; x=1762416638; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sKQ5jVf0l4p+IXXgicmYUBfdOUjcnM90HD067+of6oU=;
        b=Akoqr9/hTeZYDrcdzlGM+p6jolo/LuwccEQDW5/d7ys5ljmDLa+lY4u6Q2R3ct7ibo
         W8o2vL+zwebjwlKbEFw5kJ/AicWwWwMeEdJlkHHgo1BEkeK7gCL8Pg4YxDJSqRErqaPf
         Qloyd43r1cuCJfmyaevAnzQdsJ9RUgwHw0HufkoG9edzohP/4f9Wtvnmqn5TQfkTrWwI
         CCj++p9zg9nWOTqZNHVlJ3lF35MA2chqJ0QCI7EEUTryv0Sfgs5GQPbiyoOqswbPvner
         MkaD3UJjPU28bpY8hXVwiH4k6Ue4Yilslqz0/4JTSEjymFDZeRHpQDnYjAN0R3ySIriV
         gRsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761811838; x=1762416638;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sKQ5jVf0l4p+IXXgicmYUBfdOUjcnM90HD067+of6oU=;
        b=Nh0eb/aHOAVu9X5RUyNm2Qw8EKfDjJmtVolKIkTSmtb9hHdHVJ9weVmNwMK8nj8aw+
         bOQKnPMjTSfO3CNdmalQyA+j2IeRFuImSoclN5zkFTfIn+0CIiLIdAFmvT3GUVE7oKAr
         L4mMnSnABllz5epdhLvLBj7gUo1bl6aRhsHqewmmesCB14+fmJIW1XJk0Ro1WW6CaSfp
         o+IqNoP9irLiM2sYnSmwRF1sju3Cb5mBu4VpqgYBXTemoTtUGbD/2nAXp7/NFUVXDYUP
         2vmg64SE6nhzsVWxMBE0mVQnE6mZOrp0jiQitJfVA5KaDyeu4DFcUZ7u71Qat/cQc4YZ
         3tEA==
X-Forwarded-Encrypted: i=1; AJvYcCXsUO0e1W+ItafkNSdBX0+/jdg0rsPmVC/XCTh0MkH7NquyqyHKMMOOxNOO+e3xBQOZ2Ai74UUuLXjD@vger.kernel.org
X-Gm-Message-State: AOJu0YwM3L9RtNi143j1FHKjq5urujN2V88x3ZsZV165gmB7uhgQ1w1S
	/bzgCnOw+hBIGm5kdLTr6zKhLEkipyuUxfMjB9m2KIpf6ly2z8t4ZcblSqM2odXAImwiEpFgxZe
	zvmSkmJRYKi2qMkr+MyQ5/tgzKEAHVy2fugc49JDIavajzXhVjgllUt3jt8uiVjE1
X-Gm-Gg: ASbGnctzxGw/F1nuTLWqrPvB0maU2/KqBMR+Mz9Eg2gSE/ISn6RV0YBAmsI93nsly0g
	fOtIMkK6rNyDVXmxYzm++H2f0jqvhLkR8yN4Yyu27laVJMEYO02/3M5BWRz8/Fxjouo67ybQn+2
	8EJbnUJKP0amG3+RpB5AicC6QbriXeYs+mqjUrZkKWZNW4f6aBM+Cx49502Mn5aVeugB6SN39El
	amMEsWKAldidp3T0AR/X+sSYnDkKuVNhVHQS91aNtI15HHleIbfpDa0YzFLx2ApY6QY87iJyT5H
	uDlPlYFtaOHi8P7vXuFU+PF4GZ+t5//mkUXdV1W+6/y14uT5PsRA3ReV5om5sGtuoyJnC3yXX/D
	oaioSqc6QlOu0Q9TrquzgS4zb2rmc2Z4t
X-Received: by 2002:a17:90b:4c10:b0:33b:c9b6:1cd with SMTP id 98e67ed59e1d1-3403a281deemr7057770a91.19.1761811838307;
        Thu, 30 Oct 2025 01:10:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHcXwJ16VDmZHn89sViUhOlCtgQOUsBXdbwSglJJN9TfXEZWwsHddtgf4n3/AsvcnxW7oW5+Q==
X-Received: by 2002:a17:90b:4c10:b0:33b:c9b6:1cd with SMTP id 98e67ed59e1d1-3403a281deemr7057701a91.19.1761811837588;
        Thu, 30 Oct 2025 01:10:37 -0700 (PDT)
Received: from hu-pkondeti-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-340291158c0sm4612475a91.1.2025.10.30.01.10.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 01:10:37 -0700 (PDT)
Date: Thu, 30 Oct 2025 13:40:31 +0530
From: Pavan Kondeti <pavan.kondeti@oss.qualcomm.com>
To: Marc Zyngier <maz@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Hanjun Guo <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 1/4] ACPI: GTDT: Generate platform devices for MMIO timers
Message-ID: <1eafe745-068b-4c15-a3d0-14e7222970fd@quicinc.com>
References: <20250807160243.1970533-1-maz@kernel.org>
 <20250807160243.1970533-2-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250807160243.1970533-2-maz@kernel.org>
X-Proofpoint-GUID: bgRV_auD_7s0SB5fcaEyRhWD2CIK0rQ8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMwMDA2NSBTYWx0ZWRfXxRUSzlPnT2iF
 U+BAm8fC01phEnFE+7NFNJLioSV9SpeACX9TjPKyJI8JQCp9BSsg8vY+7HEBNtsfzbuoPMoJbhZ
 QR2WYgxwS5MB0pU27Uyh1Wi5EQxSKn/F+gExTkJhcQ3ftL1bLLEq7nLObfsvegnBGmFOhfGdbiY
 7bijVITQY4FS5D7MBQjmhlrMKnWEkZg0YaR8OZLw9YJYCQC5v/+0HfT/JNU1OmH8IR6NRIeViSO
 LhwmZG2ReYZ8XDOJ02RFEdWd4toBcuCufAugn2P+nAQ3cf5+demveEvt0PPcR3zEnmyGrcdDyNK
 nF4wmtlS+J3x1lCwWG2p7PFARoFOKNVtUjVsbWbbdDuC5KfWbM2xX8O9eTboBrOZrXvV91C+gtC
 DrOYmfMWyFxIZao07Uq54Pjwaj7eaA==
X-Authority-Analysis: v=2.4 cv=a/Q9NESF c=1 sm=1 tr=0 ts=69031d7f cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=kj9zAlcOel0A:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=XE_7NARKTCcpHfg7NDIA:9
 a=CjuIK1q_8ugA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: bgRV_auD_7s0SB5fcaEyRhWD2CIK0rQ8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_02,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 suspectscore=0 phishscore=0 spamscore=0 adultscore=0 clxscore=1011
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2510300065

On Thu, Aug 07, 2025 at 05:02:40PM +0100, Marc Zyngier wrote:
> In preparation for the MMIO timer support code becoming an actual
> driver, mimic what is done for the SBSA watchdog and expose
> a synthetic device for each MMIO timer block.
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  drivers/acpi/arm64/gtdt.c | 29 +++++++++++++++++++++++++----
>  1 file changed, 25 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/acpi/arm64/gtdt.c b/drivers/acpi/arm64/gtdt.c
> index 70f8290b659de..fd995a1d3d248 100644
> --- a/drivers/acpi/arm64/gtdt.c
> +++ b/drivers/acpi/arm64/gtdt.c
> @@ -388,11 +388,11 @@ static int __init gtdt_import_sbsa_gwdt(struct acpi_gtdt_watchdog *wd,
>  	return 0;
>  }
>  
> -static int __init gtdt_sbsa_gwdt_init(void)
> +static int __init gtdt_platform_timer_init(void)
>  {
>  	void *platform_timer;
>  	struct acpi_table_header *table;
> -	int ret, timer_count, gwdt_count = 0;
> +	int ret, timer_count, gwdt_count = 0, mmio_timer_count = 0;
>  
>  	if (acpi_disabled)
>  		return 0;
> @@ -414,20 +414,41 @@ static int __init gtdt_sbsa_gwdt_init(void)
>  		goto out_put_gtdt;
>  
>  	for_each_platform_timer(platform_timer) {
> +		ret = 0;
> +
>  		if (is_non_secure_watchdog(platform_timer)) {
>  			ret = gtdt_import_sbsa_gwdt(platform_timer, gwdt_count);
>  			if (ret)
> -				break;
> +				continue;
>  			gwdt_count++;
> +		} else 	if (is_timer_block(platform_timer)) {
> +			struct arch_timer_mem atm = {};
> +			struct platform_device *pdev;
> +
> +			ret = gtdt_parse_timer_block(platform_timer, &atm);
> +			if (ret)
> +				continue;
> +
> +			pdev = platform_device_register_data(NULL, "gtdt-arm-mmio-timer",
> +							     gwdt_count, &atm,
> +							     sizeof(atm));

Did you mean to pass `mmio_timer_count` as the `id` argument to
platform_device_register_data()?


> +			if (IS_ERR(pdev)) {
> +				pr_err("Can't register timer %d\n", gwdt_count);
> +				continue;
> +			}

and here too.

Thanks,
Pavan

