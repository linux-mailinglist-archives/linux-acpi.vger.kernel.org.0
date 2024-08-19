Return-Path: <linux-acpi+bounces-7676-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 207D8957548
	for <lists+linux-acpi@lfdr.de>; Mon, 19 Aug 2024 22:07:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 458EA1C21F47
	for <lists+linux-acpi@lfdr.de>; Mon, 19 Aug 2024 20:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56DB41DD392;
	Mon, 19 Aug 2024 20:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DupjDfdW"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94CEE187FF1;
	Mon, 19 Aug 2024 20:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724098071; cv=none; b=LfbUwGx3IWE27zd31UEP6yLlRNT1LKW+g5yX9ZVB/sg0Z7CiCEw+ubLKIh86J1nQ6sd3FypOkv4GMaW+KsmrIb0wucJGc14lTJaMts0Fg4hQrkhk/Es/jIw2AuSQf9v7NIOsS4r6SneAZskO//Hejnrie/68A/WE14dGpG/+94s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724098071; c=relaxed/simple;
	bh=rAPCRlcod+pfbPu210SomC+sQBvMBit2CDwdTkZs9WA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k+xXNaWBF9vTtXdJjnFBhoRvGqNtXHdWLd9FxG7KsaSHdAaXUjnxnUM+S/C2CBBLEXZj10bhY1UWTyk+OfJk+IqfQ8Xgl3aibTKQ1VZ0PoGN5SQsbvBRwnGVzoSxqaZZKdxBtX6HxOsAci4S9kJtkihLfKsURCPcYY2WuuQ63PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DupjDfdW; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5bef295a2b4so922571a12.0;
        Mon, 19 Aug 2024 13:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724098068; x=1724702868; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AXG6IXtrOjPM85KujCO90THzzqzY1pavUqqhKYUalFU=;
        b=DupjDfdWerMwK5w3VidWTMW/SnbAzPXMPMu5hmhYPukmYW4C0Xp4ouyoiZhdrFr0df
         3dhYfrh3WJoTWDtLNDoQVo2w5RZJfmdKNwCgEB6jguQ7ItPpkYvZntRcfRnpsTPwhkrg
         QSBHZ5I3PYDyRPD2AhYLQJMhkwXzbWfgUs5XmMe4JM+tXQ6Vy5nmLKeV/zhoD9TgDRzJ
         hyT8VhUCWbDCsOMS8SnOmaP3K44TpvMEcHVPwSDDAhFQcRnwKYYkthqDC9G22zSd2khP
         n8qPOebCEi1x9UdpMvwcILerJaODruxmBj7Mb7pN1EIqau51o6SAeWf6NzOuyT7+Fh7x
         xkLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724098068; x=1724702868;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AXG6IXtrOjPM85KujCO90THzzqzY1pavUqqhKYUalFU=;
        b=NxDX3LfcAtRtaQqUuEbtR7fT+ZkJJQsU9Z7lUUAXZxrtNVe7pDbm5UQYYe6khIIMp9
         BHMzN0VYYyWoVQO9flE3yGvd1gD05M5tbMsCqEmuMr1RXiLJlv3FpFhfNiWw5Jzlb7Ym
         FIN8Fw1YEE9/EKVgBesfONYBuOXop17mXtqot03/gy5Ll88pPF7498vid2QxeFU1kVvl
         VwlZUI/H3SeAKKHsddRkJuOrYsz9A7/2JADt8oeC0vOn+znXE6c43kuibdAYs8hvin17
         la3fzSFURSUhI/8RVPuAkRP7ECATugEsh6RB+Q7Ff4gmajDAdkU2ehYhDkkMAUX0CUXp
         Yh4g==
X-Forwarded-Encrypted: i=1; AJvYcCVGyvbbjxIFllUp2yG0gdkVBFsUk+7lQ3EZZ9vUk5fMKb2LOmq0cG6U3cOiPugCJ8LxiRZKdAFIREU3MIc3PLZP3tNTw+OJwtCYDD8irOqDQfzVjCdAoUsV6G4aorX+5jPfKGjtOIV54XBzUPXVr9BWuWbx02unt+srQGMdf2mafeQ9m6+NpKEOO0tq16Qz7cOs+z2wd2pPPdjL2O1V3RfdWbzXSgZ+oSy3z0bRC37nrETzbvmOHz2331+/fA34zRWH2sPmYqdx
X-Gm-Message-State: AOJu0YxxQNwsMAx5LjX8okw57/NavCixE2jgTv4tSx9OnVzqmsErCZsW
	MS/VEry/4yr/yf/BM7pr2bKOtyDUYI3+bznBwDfpyOSzAynM9MFD
X-Google-Smtp-Source: AGHT+IGJ+Gfht/qOvEgwrpTVPJu3XY+E8gChTgsY9fwcJajAIgQx/hjZADakWsaqM4RF1z+rkUv/TQ==
X-Received: by 2002:a05:6402:51c6:b0:58c:b2b8:31b2 with SMTP id 4fb4d7f45d1cf-5bf0ac5b251mr753759a12.17.1724098067404;
        Mon, 19 Aug 2024 13:07:47 -0700 (PDT)
Received: from ?IPV6:2a02:8071:b783:140:927c:82ba:d32d:99c1? ([2a02:8071:b783:140:927c:82ba:d32d:99c1])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5becfc7cc93sm4516920a12.3.2024.08.19.13.07.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2024 13:07:46 -0700 (PDT)
Message-ID: <6406891b-e116-4f10-99c7-1d434d7e8410@gmail.com>
Date: Mon, 19 Aug 2024 22:07:45 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] OF support for Surface System Aggregator Module
To: Hans de Goede <hdegoede@redhat.com>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Len Brown <lenb@kernel.org>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
 linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-acpi@vger.kernel.org,
 platform-driver-x86@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <quic_kdybcio@quicinc.com>,
 Krzysztof Kozlowski <krzk@kernel.org>
References: <20240814-topic-sam-v3-0-a84588aad233@quicinc.com>
 <1edadffb-67d9-476e-b0f7-7f3fc34e9592@redhat.com>
Content-Language: en-US
From: Maximilian Luz <luzmaximilian@gmail.com>
In-Reply-To: <1edadffb-67d9-476e-b0f7-7f3fc34e9592@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/19/24 1:57 PM, Hans de Goede wrote:
> Hi,
> 
> On 8/14/24 12:27 PM, Konrad Dybcio wrote:
>> Wire up OF support for SSAM drivers, to use with Surface Laptop 7 and
>> other Qualcomm-based devices.
>>
>> Patch 3 references compatible strings introduced in [1]
>>
>> [1] https://lore.kernel.org/linux-arm-msm/20240809-topic-sl7-v1-1-2090433d8dfc@quicinc.com/T/#u
>>
>> Signed-off-by: Konrad Dybcio <quic_kdybcio@quicinc.com>
> 
> Thank you for your patch-series, I've applied the series to my
> review-hans branch:
> https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans
> 
> I did notice the following compiler warning when test building:
> 
> drivers/platform/surface/surface_aggregator_registry.c:278:36: warning: ‘ssam_node_group_sl7’ defined but not used [-Wunused-variable]
>    278 | static const struct software_node *ssam_node_group_sl7[] = {
>        |                                    ^~~~~~~~~~~~~~~~~~~
> 
> One way to fix this would be add #ifdef CONFIG_OF around the definition
> of ssam_node_group_sl7, but then future devicetree based surface devices
> would need more #ifdef-s so instead I've solved it by squashing in this fix:
> 
> diff --git a/drivers/platform/surface/surface_aggregator_registry.c b/drivers/platform/surface/surface_aggregator_registry.c
> index 495cb4300617..ac96e883cb57 100644
> --- a/drivers/platform/surface/surface_aggregator_registry.c
> +++ b/drivers/platform/surface/surface_aggregator_registry.c
> @@ -415,14 +415,12 @@ static const struct acpi_device_id ssam_platform_hub_acpi_match[] = {
>   };
>   MODULE_DEVICE_TABLE(acpi, ssam_platform_hub_acpi_match);
>   
> -#ifdef CONFIG_OF
> -static const struct of_device_id ssam_platform_hub_of_match[] = {
> +static const struct of_device_id ssam_platform_hub_of_match[] __maybe_unused = {
>   	/* Surface Laptop 7 */
>   	{ .compatible = "microsoft,romulus13", (void *)ssam_node_group_sl7 },
>   	{ .compatible = "microsoft,romulus15", (void *)ssam_node_group_sl7 },
>   	{ },
>   };
> -#endif
>   
>   static int ssam_platform_hub_probe(struct platform_device *pdev)
>   {
> 
> Once I've run some tests on this branch the patches there will be
> added to the platform-drivers-x86/for-next branch and eventually
> will be included in the pdx86 pull-request to Linus for the next
> merge-window.

I agree with Konrad, this looks like the best way to address this.
Thanks!

Best regards,
Max

