Return-Path: <linux-acpi+bounces-7496-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06E4C94DF63
	for <lists+linux-acpi@lfdr.de>; Sun, 11 Aug 2024 02:26:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91766B21343
	for <lists+linux-acpi@lfdr.de>; Sun, 11 Aug 2024 00:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F3244C79;
	Sun, 11 Aug 2024 00:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G217z+xc"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C944689;
	Sun, 11 Aug 2024 00:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723336002; cv=none; b=mf+i2vJeP4RgbpDtWdExtLHSwu85eZ/63EoNH9LIHABKSihyD4s9J9kFqbN6ViahDNXXD4AOAOsWfVkfGBsHA43vvco13S0LS4FTYCn0gA7v/puQ+3pfiw1JTg+qV4FBT5ZX63f3mnTPrbkcF5Ualx0WYupo1xk1JhZB7Ow55RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723336002; c=relaxed/simple;
	bh=4F4WrJKMMj/mzhKGOf6beBPkIcpH11FmNTcDNr7IdQs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X0/a1P8PLW4JFplNI3LWnDkgsq/hofnmCA1ssFB1tULO/YgcF7QgoJLCdpA5L9eCdBeseLPBvalxnMCBbMweJDbficwQ2d9CHO5D5+5YyyeAZSzi+RFJu8R1gNPxmEb/79t6sD00dOdivNgVBSATQeSxRoLtl9MruTAWe0BODIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G217z+xc; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52f01ec08d6so4431799e87.2;
        Sat, 10 Aug 2024 17:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723335998; x=1723940798; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KzucCDEgUPc/knhsH0R6bnlBW2fZ6eS9QbdJKQ4MQ6s=;
        b=G217z+xcQNw7qwAkFkmllxykzqShurDi6LxEOazzg+i2Fp1giacG38njru7EldJZef
         ylIBNuIRYnA0NWPEGtmYszro0g1OYvIjwntoyGA0BLMLrP/uyB+W7XdxJ33OSoQtulV/
         talu8FX0/m32HXPFS15ChdjkRl0tSZqg4I9EEEkHKdPj4J1QNI2CQFPR58PtMEmiPqRl
         7usLQhB5bPYZM6bcRYxy8hp9XCqbmjvtzIMQa3roVnCL613cLmHctM6jf/YI/bHvrNKs
         ECfwubXoNK9qFb15/2Rll5YWMkUEvGQEs9zowl2Thllz3miG5G/7Lh25hB5u/pqOePr3
         jwJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723335998; x=1723940798;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KzucCDEgUPc/knhsH0R6bnlBW2fZ6eS9QbdJKQ4MQ6s=;
        b=WME7VtE3FMJLFc+CqxavFJF8670/4haeK+hLhy0RhOcE5yGxgbnttTiNPoWkS6lsNq
         PbOzuenovUVQA9xA8wf1PyqGNlzLB/XdeX5ULoqTja09/MJJgdua6ktJF6MX6M0itz/v
         4sBkcmIUEaLUPqEElu4WvnGvsF0OXKipyhOc2Dx+SDDfLfC79x5tKSu/nnNKpXshpGFy
         jfGU64UvY2g4Zf1DZsYnxTvdzHxFiKl9VS/y4NikGkbqOTGu/ZCeCuchOpGYdrFauz+2
         vAM1Zce6ot/wiPoD/hvuLnTYQwLsoD0mKrzTt2mV7f2bsi3P24cFX/vV5c6VsZQaG4Tb
         g9AQ==
X-Forwarded-Encrypted: i=1; AJvYcCV043k7jjFdkyenwyZU5gecFPCoOo+flWbKp7RgnKRECBVkyNhC55mcT3s3RzbUtV3ud7oxFipn0Yq3XmDkWzxMjuIJw6y5GcwcN5TMBbvXdbkwh7lUbxax3nZS5q88LtbU/TqYFYUJRmocpBlqe8kvTmW/UwLPfAesVAZ18aD1Rf9HtaVL6Q4TaX4reI75CFh2wQgFFkL5cDvtMO2ULP9JTCn7c5alubwdERqZiVHpC31fHPJbof18X2I5mDxQ9H3daL5/r8sp
X-Gm-Message-State: AOJu0YzR+Ropoev0mdrhrxjkuWOp5kaPPQC5FXLk+LTpLc2OYFEtk7XA
	X5A0Ktwq6/MiEK3xpA1Nn2mOfoqe12bZxLnMkkLV9yKH6Jr1C3v4
X-Google-Smtp-Source: AGHT+IHGUDxTBJfpaHljrBfVqf8VHFwyZebTa6fbP6EnQs4QbnrVNUPOXxqYqfTpTIhUbCCRTtnLjw==
X-Received: by 2002:a05:6512:3ca4:b0:52c:d905:9645 with SMTP id 2adb3069b0e04-530ee998c1fmr4413909e87.13.1723335997946;
        Sat, 10 Aug 2024 17:26:37 -0700 (PDT)
Received: from ?IPV6:2a02:8071:b783:140:927c:82ba:d32d:99c1? ([2a02:8071:b783:140:927c:82ba:d32d:99c1])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80bb2136a3sm108263966b.172.2024.08.10.17.26.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Aug 2024 17:26:37 -0700 (PDT)
Message-ID: <40f3a81a-b5b9-459d-8231-25ba3dc71b68@gmail.com>
Date: Sun, 11 Aug 2024 02:26:35 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] platform/surface: Add OF support
To: Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Len Brown <lenb@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
 linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-acpi@vger.kernel.org,
 platform-driver-x86@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <quic_kdybcio@quicinc.com>
References: <20240810-topic-sam-v2-0-8a8eb368a4f0@quicinc.com>
 <20240810-topic-sam-v2-3-8a8eb368a4f0@quicinc.com>
Content-Language: en-US
From: Maximilian Luz <luzmaximilian@gmail.com>
In-Reply-To: <20240810-topic-sam-v2-3-8a8eb368a4f0@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/10/24 3:28 AM, Konrad Dybcio wrote:
> From: Konrad Dybcio <quic_kdybcio@quicinc.com>

[...]

> @@ -346,7 +359,7 @@ static const struct software_node *ssam_node_group_sp9[] = {
>   
>   /* -- SSAM platform/meta-hub driver. ---------------------------------------- */
>   
> -static const struct acpi_device_id ssam_platform_hub_match[] = {
> +static const struct acpi_device_id ssam_platform_hub_acpi_match[] = {
>   	/* Surface Pro 4, 5, and 6 (OMBR < 0x10) */
>   	{ "MSHW0081", (unsigned long)ssam_node_group_gen5 },
>   
> @@ -402,16 +415,39 @@ static const struct acpi_device_id ssam_platform_hub_match[] = {
>   };
>   MODULE_DEVICE_TABLE(acpi, ssam_platform_hub_match);

This should be

     MODULE_DEVICE_TABLE(acpi, ssam_platform_hub_acpi_match);

as it has been renamed above. In addition to this, the
surface_aggregator_registry module currently does not auto-load. So we
also need to add

     MODULE_ALIAS("platform:surface_aggregator_platform_hub");

somewhere. With that fixed, it builds and runs fine on the SPX.

Best regards,
Max

