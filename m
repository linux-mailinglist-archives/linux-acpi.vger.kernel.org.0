Return-Path: <linux-acpi+bounces-19720-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A7704CD08E1
	for <lists+linux-acpi@lfdr.de>; Fri, 19 Dec 2025 16:42:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 917AA307CA12
	for <lists+linux-acpi@lfdr.de>; Fri, 19 Dec 2025 15:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEF2C324B1D;
	Fri, 19 Dec 2025 15:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YUjzvPAN";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WY18KXNv"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE12303C87
	for <linux-acpi@vger.kernel.org>; Fri, 19 Dec 2025 15:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766158724; cv=none; b=OXJcCT8IYQeYqdgLFJd5UbRqZnMLP+FA+Q8WRePenNkcNODWzfpcv2uHQB/IKJ93wJSuvCLyaGwbBofmpv1Pku1Ot3GqHTfLHIrk5Na5MtvV7ro3BkRDX+mHqwcCjaizTqx8lYaoowbAtK3JhWI1xxjl/h4O96BakQtx5xPzbiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766158724; c=relaxed/simple;
	bh=yaYu6EUsZ2k+dyATPW3HziO1wVqig5bKGOvhvVQiq2w=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=TAd8Q3CN6beh9YLW8pcyq9qwkSX/JE6p6wK7T+2Zz2wUDOhwVnBM3JwfMXqOZ0kbe3xvrODPgLSmFghxNkE2B/V1BaWQM33aKB2+nRFLBE5cQBDQGvfw+HVXvAa8kQmIm/1IJFOg8v5MiPZKjYJsC8NsBmZGkiXIo2M+KJd2TUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YUjzvPAN; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WY18KXNv; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BJBl1h01772623
	for <linux-acpi@vger.kernel.org>; Fri, 19 Dec 2025 15:38:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hlktxcMQ5o7f8INb/EnzFpPAWbvL6c59BChleMZu85E=; b=YUjzvPANYfvnEzKY
	7wWNL5drEYT1SgVSWU9hAVRfWUjp+4es6rFHIeyu70/YurMrzByQw/m34TndupD5
	vsjasYjbu/deqBrTbQ7Ta/Ga66nWoMi7U1VUOzXnZS5hiCrT32oC7HB19w+tinIU
	/5yDP4ZhjLbxiiD7dV6j8maPEFt8biA+d2Tz1NQvI7JbleGIr/CroNutRdV7adBF
	M1ca06Y9ABsrqPha9moVyCy2DJWjGvCcVPnFmHG4Wwuk0JAb8ixmiTIA4X0K6oRA
	OeMUJpDmyroSczh/tpkGzUBrmdAmWE2SQ0ImFIuxgwkt/kofkpWZRvZx+XEG2UB/
	Z6WnVQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b4r2bk51m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Fri, 19 Dec 2025 15:38:42 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4ee0c1d1b36so59965881cf.0
        for <linux-acpi@vger.kernel.org>; Fri, 19 Dec 2025 07:38:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766158722; x=1766763522; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hlktxcMQ5o7f8INb/EnzFpPAWbvL6c59BChleMZu85E=;
        b=WY18KXNvvMYkPKyzKRvhKCtXZU3nZxU/4TduTsd6cNPz04s+Y3ufSsgfF5pHLKo5WI
         i1DOxp2HwEu9yhl6UsELEUa38DrH2MVjXnxO6RvcrOofQcgXl+bjD7BbVatfHA7vAAkz
         jrz8dQczOrbwo7+MuiZAnMxsRP/hjxhVP4gs78J2iSakxTRJIn8G8jO1ZYgDYksLu6L1
         7P27exYLkgqdhIMLfO5eOdaim0TVVvwlQ/icio2YrZtbVZOZGmhiU5yZwFpf0z20Mlsx
         t6Fwh4N3FeeNCrQYituBqtKlNLPugxD6WsoRk4pQDcd/3XN0UBt0LF4e75xxD6nLINdo
         4M7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766158722; x=1766763522;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hlktxcMQ5o7f8INb/EnzFpPAWbvL6c59BChleMZu85E=;
        b=DiyjGAJwH2Zt23U33zTQ0F9uVBUiQ6X3ZrjOVhvO8Eig8PYatgOa40xl9JXd8sDya8
         KOb6PSEhwkcgvjs1QKtnU59M5VKxQ8aIwIG9mO8/6ZDehrWS9IqXnbLNfQhtxt/nLERO
         67UEGPgo8YRd0IT/HapznqoC4PZcP7VqM6QnkULGcCpsaBJFhVY+0uiA5KPdStRwtmuZ
         +SX5Y+UYmxzSZtyjKTwiL87mn29jPBuBhUYbtmqlemhiN09vBwyTJq2T2ZaN7iWaMjgr
         VMTC9ZrKeVWhhNpcrbCy214jQCEwlC8kEhPpVwljd9xw6UkasQql3Fas/Cz9ve77mXZw
         va0A==
X-Forwarded-Encrypted: i=1; AJvYcCXBRLKzxasSJe26bOXXVz24xZzdaAhO49NHjFGKg9eU/G2PFgdWW8CeY3HF/Rn+kiMpy0BtN07nIVlG@vger.kernel.org
X-Gm-Message-State: AOJu0YwNn05HmvyYi2Z5yJEWyHCyGzLatPtg/obkjBkM1fCWCM4KKBGL
	BBkwGRFGA4cx+0hbXQ2mhyC2ksiPBwMkc6TaGyKUKl6A9w80yUz9w+asBAXqf+IJBe6WDa4MU28
	2fyXCMIRbs1rbTULMESDGyrTY+b0Ln/xEwHWf6XlqFx6pAlRakmI4KOkUXKN2KMbB
X-Gm-Gg: AY/fxX4ONrKX2F5pkMRWSiYYrJseIJhWBuBffVyFGRna0VxqAPKhFuwUcm+0re0kSRf
	W2hW3pvDGq6+3sKfn4P+YR//YJo64K93Eqh6l53rex2cXK9rqSJ/cvcJv/+2r0SDnBCjLMV2cVZ
	acZPKTteLasusW8rammWpGEVpNoOY4cS4MCrmiicupFQ4VDt7fUbuq3n8IG+y7DV/4E6pgwN7Ad
	Ay2TQn8m44MO6p5Rf1vLBeNrgDW881EFhgMiqBfUXv0tMSpM9IJmaOv319buOSsUub9+4rp5C0M
	ZfKjqBTpsEKwIjPwp4bPHr0fTbV7u/O+ZGUfGAcJ43C3eaCWf6i091bI6ntwn8abg34LFtmLa/j
	Gcnjg5fIkCh4fkXH2MRW4M57syGE2eG7WnxM3MGpvOFn/XPoPrsHSv6BV4cC9iwBB7KwPQl4+Ei
	195jL1WSrkBCPbjN5Mz3xHdm+3JGM9MeUhP3YS4qlAvLaB9ig0xsnQhrqenffNo8+0RbMzvtHSl
	mmt
X-Received: by 2002:ac8:7dc6:0:b0:4f1:8412:46e2 with SMTP id d75a77b69052e-4f35f45578bmr112791201cf.29.1766158721529;
        Fri, 19 Dec 2025 07:38:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEFz7Cs9DiwziUglVOvGaHZDt5ibIn6DCmJEzWtyVQj6LLINXZH1VITR5kgdSGsQi0UzLtTAA==
X-Received: by 2002:ac8:7dc6:0:b0:4f1:8412:46e2 with SMTP id d75a77b69052e-4f35f45578bmr112790581cf.29.1766158720921;
        Fri, 19 Dec 2025 07:38:40 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037ad8577sm258564766b.24.2025.12.19.07.38.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Dec 2025 07:38:40 -0800 (PST)
Message-ID: <29830128-8b75-4c57-ac55-0158f3688f12@oss.qualcomm.com>
Date: Fri, 19 Dec 2025 16:38:39 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: johannes.goede@oss.qualcomm.com
Subject: Re: [PATCH 1/1] software node: Also support referencing non-constant
 software nodes
To: Danilo Krummrich <dakr@kernel.org>
Cc: Mehdi Djait <mehdi.djait@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        linux-acpi@vger.kernel.org, Kenneth Crudup <kenny@panix.com>,
        linux-media@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <af773b82-bef2-4209-baaf-526d4661b7fc@panix.com>
 <20251219083638.2454138-1-sakari.ailus@linux.intel.com>
 <erf3c6r46lscxeqj3iqc24rkzpuuwrdhob7isva523pxtxtoy4@45gxuhkdbubx>
 <7d04ba37-b505-4207-95c3-b0ffb0736ea4@oss.qualcomm.com>
 <DF2AFGGXTTFI.1AXC4N182UUYD@kernel.org>
Content-Language: en-US, nl
In-Reply-To: <DF2AFGGXTTFI.1AXC4N182UUYD@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: JPh9VWDYg1LP8HFVGotIe5euSvdgtwu9
X-Proofpoint-ORIG-GUID: JPh9VWDYg1LP8HFVGotIe5euSvdgtwu9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE5MDEzMCBTYWx0ZWRfX9HLoWR99rGsy
 68S4B7zIrsNYZvoawSFso+iyVcA74zk1zR98MXabQhTSC5+XLgntaUV0R8cHsPQagyXuTKBtri2
 rR7hV3V2CrHgS/Pr2eQdsJ+T0hItw5xtjf8KbiEpIpoH03BFFqQOnAXTSVw0gwHU+/VfWJX621U
 GjnGOlWDhiK+YUFhrGbl2xWxnRjusVZ7Rc0vN9YoVDnIEJka0r8GVIDhhePPoVugKmG3HszyN3y
 buC0xa7w/ADEuIyimemfFoBg6vvMqcDITrD4AomMYHOL5dIQ3MfYdeMwbu1NQUL7nGIE5qIEJGE
 0z1FVjb9FISD2vyr1Mz9DOclmOn0nmjEm2gTCzoVewWSMSUtnppZHbxD6ibu8aScK+1qORyHhzl
 9BSgSo0cQL1mVqJ0oJh9wq+IxrOTmKp2azPE8/dis4cA6EbJxQPQDSWjfs82f8ICgxZVStCNotH
 4TLZUvcIv3NjRSAUfTQ==
X-Authority-Analysis: v=2.4 cv=WYwBqkhX c=1 sm=1 tr=0 ts=69457182 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=nefWIst9nuTk0MLHL2kA:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-19_05,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 priorityscore=1501
 clxscore=1015 phishscore=0 adultscore=0 suspectscore=0 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2512190130

Hi Danilo,

On 19-Dec-25 16:11, Danilo Krummrich wrote:
> On Fri Dec 19, 2025 at 4:05 PM CET, johannes.goede wrote:
>> Since this fixes a 6.19 regression: Can someone please submit
>> a pull-request with "[GIT FIXES for v6.19]" pull-request to
>> Hans + Mauro with this patch?
> 
> This code is maintained throught the driver-core tree and fixes for the current
> release cycle ending up in this tree will be sent to Linus directly for the next
> appropriate -rc.
> 
> Is there any specific reason for this request?

No reason other then me not paying attention and since this fixes
an issue related to IPU6 cameras I typed the above on auto-pilot,
my bad.

You're completely right this should go upstream through driver core
and my request makes no sense, sorry.

Regards,

Hans



