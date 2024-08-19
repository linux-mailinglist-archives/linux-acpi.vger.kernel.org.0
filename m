Return-Path: <linux-acpi+bounces-7664-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF88B956C14
	for <lists+linux-acpi@lfdr.de>; Mon, 19 Aug 2024 15:31:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F30011C237AB
	for <lists+linux-acpi@lfdr.de>; Mon, 19 Aug 2024 13:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 316B5184114;
	Mon, 19 Aug 2024 13:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NcKCEon0"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D6C16D338;
	Mon, 19 Aug 2024 13:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724074052; cv=none; b=lqMBv7xI1miZbSCeaL3+YXHdUj6AJSGq/cW3zBBYhvrGitb1zSN+UHf8F5uEaOePwoyC3FQMnG8RqRDaoiETmaP2mNh1XbjZSe+dmDSn5cVeXQNoQIuXh5QbVZaE1j6LkJ0jnDCnWms3WCSM0RvVTwFXbtf59s66/YeSrzMGzOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724074052; c=relaxed/simple;
	bh=zgzzTwzV0BQY6hxtHWFGekrmc1vx8F7yvRK80HBJQrQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZINxj6uJsJ60lf7+wWUfO0bDla8oGhiNUuZmTjalh+WiRGOXdKAfcK1Wt0CHR7WOMXNzCl0N5fG87xK6OU8V71EwkH/EZDot4esiMyxBkkzgr9+WGyJpujlsfk2nVVQ8r8PSA9QssrOBWJttWw197p0p3iBv0nqdWT1zKQDRFZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NcKCEon0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 553EEC4AF0F;
	Mon, 19 Aug 2024 13:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724074051;
	bh=zgzzTwzV0BQY6hxtHWFGekrmc1vx8F7yvRK80HBJQrQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NcKCEon0okn3rFKqjw1KT+EdjKM9uNNBqtsORdLntcwecBj9BUCQdwpKIdu7Cjs4o
	 vMLd35t7x3feSipMIKbLDHd7YWQLqIivMqAunxzVib4+86J1w6GWEEzupwjcTNgs9V
	 LrOmwSG4AIY5XEq4ZdPOAy+wcGuluRvnBzhAnol6VCc3Y/PvPuXhf4muXpBUHs6kfK
	 lGr/t8dvyzH5H4WrG7pIqJxvbmbM0H33wo7vKjtQzYQT7FTd2sQfGY0UB29ysdbial
	 VAEZrisslXPLoaekPRXBKSq6vLD4vQexdSZ8HBvPNp4aMEibMBmkZScZ71RNaWM0CQ
	 vVj6KGIE2cC2g==
Message-ID: <e481e29c-6904-43e9-8148-402b267ecc9e@kernel.org>
Date: Mon, 19 Aug 2024 15:27:22 +0200
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
 Len Brown <lenb@kernel.org>, Maximilian Luz <luzmaximilian@gmail.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
 linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-acpi@vger.kernel.org,
 platform-driver-x86@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <quic_kdybcio@quicinc.com>,
 Krzysztof Kozlowski <krzk@kernel.org>
References: <20240814-topic-sam-v3-0-a84588aad233@quicinc.com>
 <1edadffb-67d9-476e-b0f7-7f3fc34e9592@redhat.com>
Content-Language: en-US
From: Konrad Dybcio <konradybcio@kernel.org>
In-Reply-To: <1edadffb-67d9-476e-b0f7-7f3fc34e9592@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 19.08.2024 1:57 PM, Hans de Goede wrote:
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
>   278 | static const struct software_node *ssam_node_group_sl7[] = {
>       |                                    ^~~~~~~~~~~~~~~~~~~
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
>  };
>  MODULE_DEVICE_TABLE(acpi, ssam_platform_hub_acpi_match);
>  
> -#ifdef CONFIG_OF
> -static const struct of_device_id ssam_platform_hub_of_match[] = {
> +static const struct of_device_id ssam_platform_hub_of_match[] __maybe_unused = {
>  	/* Surface Laptop 7 */
>  	{ .compatible = "microsoft,romulus13", (void *)ssam_node_group_sl7 },
>  	{ .compatible = "microsoft,romulus15", (void *)ssam_node_group_sl7 },
>  	{ },
>  };
> -#endif
>  
>  static int ssam_platform_hub_probe(struct platform_device *pdev)
>  {
> 
> Once I've run some tests on this branch the patches there will be
> added to the platform-drivers-x86/for-next branch and eventually
> will be included in the pdx86 pull-request to Linus for the next
> merge-window.

Thanks for pointing this out. Your fix seems to be the best solution
I can think of, so I'm all for it

Konrad

