Return-Path: <linux-acpi+bounces-17101-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FCB3B83539
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Sep 2025 09:34:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA32E1C24C46
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Sep 2025 07:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCFCC2E5B04;
	Thu, 18 Sep 2025 07:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r51iA/mc"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0DB32D5C7A;
	Thu, 18 Sep 2025 07:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758180835; cv=none; b=di6uFn9Oo+NAzozaB/HK/qZ9S4ME8q/gU2j+hEDYChC6kQpSAQlyiQUnom/Zo/IL1QMPq5SLnR3rDJy0fkIKrpUf6ZjU/XYtv6bAJNdbw54f5LIE7ZG5bA/+iLH3CUSHLMYeI+xBLAY8xfPzJngomGoUrLO09kmSkpPJ/ZOOsS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758180835; c=relaxed/simple;
	bh=zoF2TshriM3ZS0e8AelFve/OPI4XACW7RUZD7luL5+g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=is6SAZAzyp1dNKkqDROU97B8H71BLHhE5IADgdgtvMUExgh4cQPjJhRTM6jXqO5S8oAv2TuEe8GURCjE4jalNbZX+c3Ea4DOWogwXfne9yUUZ2B3nzMIGK+TtgPZTyu1eCzLoaEYVwO/Q2Hhie60UJq15W/Fv16vlH1yoHKsi3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r51iA/mc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A29A5C4CEE7;
	Thu, 18 Sep 2025 07:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758180835;
	bh=zoF2TshriM3ZS0e8AelFve/OPI4XACW7RUZD7luL5+g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=r51iA/mcdivvaemgqGMjjV2SmWFHkPwVzpmTtRhePCYe26CLPkKGj3HcX4F5JlKV5
	 qDm5FACFLobIj3q/8ZcsJhYH99HHQ2SpNctsDXPmfvb80yT1XQLuRxVamq8E412s87
	 lcUYjd9mb/ro0e6mBUMkIWaMzD9CE7FP1SvtOxmIRhsA4V2ACK4aU44Acb9lmwsnFR
	 n+QWEXS83Vc8ouvf4je+z/BjXvAHD3EKyRVfYmLPOC6vVnqj2nOox1LNDJtGUsAmQ3
	 zUKLEIhI0wi2p39tocUMmwELSXL7ogLHXCZChiia8MneNYC7Tot/4qbEKKmAnJ9KpL
	 6i9OblXcdmSKw==
Message-ID: <0b214249-958c-4e14-a4d8-512f1d90dff4@kernel.org>
Date: Thu, 18 Sep 2025 09:33:51 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] ACPI: video: Fix missing backlight node creation on
To: Zihuan Zhang <zhangzihuan@kylinos.cn>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, mario.limonciello@amd.com, rafael@kernel.org,
 stable@vger.kernel.org
References: <17cc74d6-2e49-4370-ae37-39cddfe67d7d@kernel.org>
 <20250912103538.3657242-1-zhangzihuan@kylinos.cn>
 <f6afc998-f11e-4aac-a190-fbadb97e2d0c@kylinos.cn>
From: Hans de Goede <hansg@kernel.org>
Content-Language: en-US, nl
In-Reply-To: <f6afc998-f11e-4aac-a190-fbadb97e2d0c@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Zihuan,

On 18-Sep-25 2:36 AM, Zihuan Zhang wrote:
> 
> 在 2025/9/12 18:35, Zihuan Zhang 写道:
>>> 1. There must be a GPU driver for these laptops somewhere?
>>> Even if out of tree using a laptop without a GPU these days
>>> just does not give a good user experience. So fix the GPU
>>> driver to call acpi_video_register_backlight().
>>>
>>> Note acpi_video_register_backlight() is deliberately exported
>>> without requiring the consuming out of tree kernel module to
>>> be GPL to allow this.
>>>
>>> Other options would be:
>>>
>>> 2. Add some special heuristics for Zhaoxin CPUs,
>>> the kernel already has a CPUID match mechanism for
>>> things like this. This could potentially be combined
>>> with a DMI system-vendor check to only do this special
>>> case handling on e.g. Lenovo and Inspur laptops.
>>>
>>> 3. Instead of adding the CPU-id based special case
>>> just outright use DMI quirks. In this case lets try
>>> to use substring matches to cover multiple models
>>> with a single entry so as to not grow the quirk
>>> table too much.
>>
>> Got it, thanks!
>>
>> In fact, we have tried a few approaches (cmdline option, CPU-ID based quirk, and DMI quirk),
>> and all of them work.
>> I will sync this information with Zhaoxin to see which way they prefer.
> 
> Zhaoxin has confirmed that they will handle this through their own GPU driver.

That is good to hear, thank you for the update.

Regards,

Hans




