Return-Path: <linux-acpi+bounces-13328-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D61CDA9E42D
	for <lists+linux-acpi@lfdr.de>; Sun, 27 Apr 2025 20:35:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 065FE16F6E8
	for <lists+linux-acpi@lfdr.de>; Sun, 27 Apr 2025 18:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41CBF1B4223;
	Sun, 27 Apr 2025 18:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PCsYrja6"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0D2A945;
	Sun, 27 Apr 2025 18:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745778904; cv=none; b=GVT8cOGDvsxCJci9v34pBPaSWqMvOmRo8BVLst/WQcnPwK377I26H2/lKJviWrrcBbWSfg/l4dTKtmh8gMol4DdV9WtE0Z88Xjm/AnWvEqXqy3ergd9gJHhPQ7zd4rgf6UeXGoxsvATAQWviHEGyl7X4gQj8XWX6cB7YCWJRg7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745778904; c=relaxed/simple;
	bh=Sg5X0o8jRCtJy0GS6duf1XUBMixINXoWZ1NFXcDLqkU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DZWAQ+PJfklzIWHEyoJFEMdhrfajdDXgOxu8wfVTnc8dyShjEUpC6exkSaqb4k2scr00JR++gKBb/DP/GnpSKSImi2A71fMdmm5PI2jpDXaEkZ4dP9k6uHy+oC4tAVT8tbO46ZMbRGQQPXIj+7zk1ikg4jGQ2aC4O3eareibXDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PCsYrja6; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-225df540edcso50677405ad.0;
        Sun, 27 Apr 2025 11:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745778902; x=1746383702; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Qc22T7B67pzr5CmWDa7lTbtZQsBPvR2OWrJN90rhBDM=;
        b=PCsYrja6d5sYbYa7UCvxuYEhtKIDSetPZHWxtR9mpxfQ8zbGfnbIw3tSNP4UWQ3tkH
         5biA2fzUrG//xzpgnYcOQhbI/iQIqyb6cPQzUjajukXoFuVMnE+ng9QMOMQ7s4Mx8dpV
         86RS+/n3t/SVsLHsxIjnd8SNBfGzRC1vvpbtMcVrUMMf7Z53X6TApdH96a1XddT4E0Pm
         bX9bg2pZOgPvQkUTLsvnQG3JxD8yfxTT0E/Ey4jeEINHjjouST3ysr2/lMDRBs73KBaf
         pnxc1RqRnALEmHT7z7gpe2traY+jM/ufPW+rjFVkiDLps3Vtc8SiAqfXOYHeci5X/kik
         wS3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745778902; x=1746383702;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qc22T7B67pzr5CmWDa7lTbtZQsBPvR2OWrJN90rhBDM=;
        b=eu3XpEDpR9yZBPnKi91JhfIiDMn0LQl/kWQAFw405+zPUgru6YYm8uiYoKVcqoXqu9
         GEeMzLKKCdkCAQOD31UgQGG8wqhHR42ccgaxoDRcHCN5xoPTY0jZzCWO2OLw6vn2/Mj+
         0D46RL25TVDX3Y/bEr9cH3gl8WidGMqn0AldYCXTK3FnhauG/qt4bFnA6NojEpRRgN2H
         3yCbsYgzmKhjsoOz5DkK+PZK1kTKg3EHh4M92GRGzvYMEPriFVfMVJneOMvN7dwi76J4
         jJd1fvEaUzfTMoKD+/4dHhIe+AZEfPGJen+nDwOA9ssTsRHeSynCH6ICLQpon2JCP3rD
         0hFg==
X-Forwarded-Encrypted: i=1; AJvYcCW4aoxcME78NOZFGn41XHQqXY9QAXrBox8ZcaB9NwtvvyDj+kQE6g3c7529UXJ2vjX/nCGpcAZX0Qra95U1zGalC6l2yw==@vger.kernel.org, AJvYcCXV2lCErzRCEolR1+stpILMjHuVWJZsfU92pt4tYKDfgv78eJuaPAn64ISQTwoVTnVpoBpxDCce/gPz1ho=@vger.kernel.org
X-Gm-Message-State: AOJu0YzB1Nw27rTKcg1Wto+XVLFQY0a6QtVM3EPXuBYeY/EnYF573NpU
	PM93u7zD0OGD+PDLRXjl+3d3gVgYOjksbo7vv/5PG9PQnxOsGDNv
X-Gm-Gg: ASbGnctHSMVT+CLi4MdS7lcCYG5KPqjL+XUXNMrFcpOJTQwdNRF1dgWkc7eicYM+4SF
	fOj99a5DP3wh1CpaQUUP5KY3eQzAgHg//GG8DYunjMKdlDrLqHx0/DLARgsf6djvEeY9QLUZam/
	jrxACiKFixowEv6qYKmY80YrcQullEVaRjyO+4dcAE7KS8ceVUYX4z7ssWO501FoTpaQDO20hCc
	ipZiT8Tewe/2PzWc50UEinmOH8FK0MEJo/wSOMPQLTv06gc8hycKCjekURBxGthF57Cnk2cGIuX
	U7/zaANFIA58cwvMjv7G1GxqidG56bkxnf9f+ARzVT9hUCbZwxZl0ARpBY0Mse0/lUR3okiSkNm
	GKBAW0WGP2+KXrBoUHT5wHtnhDw==
X-Google-Smtp-Source: AGHT+IER3+7G/3E34/uKjl2syToNdatwizsergQ3nq2H7ETEy//rwMOTgJ07iTbH9YpvxOblb5HR9Q==
X-Received: by 2002:a17:903:183:b0:215:a56f:1e50 with SMTP id d9443c01a7336-22dbf8ea6f8mr133156845ad.8.1745778901735;
        Sun, 27 Apr 2025 11:35:01 -0700 (PDT)
Received: from ?IPV6:2804:14d:5cd1:5e16:9c54:6114:336a:bbaf? ([2804:14d:5cd1:5e16:9c54:6114:336a:bbaf])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db4d76e8dsm66852845ad.21.2025.04.27.11.34.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Apr 2025 11:35:00 -0700 (PDT)
Message-ID: <9de18953-3f6d-447a-8274-c953bae64039@gmail.com>
Date: Sun, 27 Apr 2025 15:34:56 -0300
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH] ACPI: EC: Fix CPU frequency limitation on AMD platforms
 after suspend/resume
To: Mario Limonciello <mario.limonciello@amd.com>, mark.pearson@lenovo.com
Cc: linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 rafael@kernel.org, lenb@kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <f5dd019ad4506.2100bf0f83374@gmail.com>
 <445f6320-698f-4d29-8556-665366668e4d@gmail.com>
 <b6fc4e66-b35a-41ce-a633-db3d660b88a2@amd.com>
 <106bd256-2c08-463f-8498-b68f2d5ccaca@amd.com>
Content-Language: en-US
From: "M. Bergo" <marcusbergo@gmail.com>
Autocrypt: addr=marcusbergo@gmail.com; keydata=
 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
In-Reply-To: <106bd256-2c08-463f-8498-b68f2d5ccaca@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

It does make it work fine for me, I saw the clock/timing interference 
and this sane this problem for Lenovo as well.

On 4/24/25 11:11 AM, Mario Limonciello wrote:
> On 4/19/2025 1:03 PM, Mario Limonciello wrote:
>> On 4/19/2025 4:28 AM, M. Bergo wrote:
>>>  From 881e57c87b9595c186c2ca7e6d35d0a52c1a10c2 Mon Sep 17 00:00:00 2001
>>> From: Marcus Bergo <marcusbergo@gmail.com>
>>> Date: Sat, 19 Apr 2025 05:19:05 -0300
>>> Subject: [PATCH] ACPI: EC: Fix CPU frequency limitation on AMD 
>>> platforms after
>>>   suspend/resume
>>>
>>> Several AMD-based laptop models (Lenovo P15v Gen 3, P16v Gen 1, HP 
>>> EliteBook 845 G10)
>>> experience a CPU frequency limitation issue where the processor gets 
>>> stuck at
>>> approximately 544MHz after resuming from suspend when the power cord 
>>> is unplugged
>>> during sleep. This issue makes the systems practically unusable 
>>> until a full
>>> power cycle is performed.
>>>
>>> The root cause was traced to commit b5539eb5ee70 ("ACPI: EC: Fix
>>> acpi_ec_dispatch_gpe()") which restored the behavior of clearing the 
>>> GPE
>>> in acpi_ec_dispatch_gpe() function to prevent GPE storms. While this 
>>> fix is
>>> necessary for most platforms to prevent excessive power consumption 
>>> during
>>> suspend-to-idle, it causes problems on certain AMD platforms by 
>>> interfering
>>> with the EC's ability to properly restore power management settings 
>>> after resume.
>>>
>>> This patch implements a targeted workaround that:
>>> 1. Adds DMI-based detection for affected AMD platforms
>>> 2. Adds a function to check if we're in suspend-to-idle mode
>>> 3. Modifies the acpi_ec_dispatch_gpe() function to handle AMD 
>>> platforms specially:
>>>     - For affected AMD platforms during suspend-to-idle, it advances 
>>> the
>>>       transaction without clearing the GPE status bit
>>>     - For all other platforms, it maintains the existing behavior of 
>>> clearing
>>>       the GPE status bit
>>>
>>> Testing was performed on a Lenovo P16v Gen 1 with AMD Ryzen 7 PRO 
>>> 7840HS and
>>> confirmed that:
>>> 1. Without the patch, the CPU frequency is limited to 544MHz after the
>>>   suspend/unplug/resume sequence
>>> 2. With the patch applied, the CPU properly scales up to its maximum 
>>> frequency
>>>     (5.1GHz) after the same sequence
>>> 3. No regressions were observed in other EC functionality (battery 
>>> status,
>>>     keyboard backlight, etc.)
>>> 4. Multiple suspend/resume cycles with different power states were 
>>> tested
>>>     without issues
>>>
>>> The patch was also verified not to affect the behavior on 
>>> Intel-based systems,
>>> ensuring that the GPE storm prevention remains effective where needed.
>>>
>>> Fixes: b5539eb5ee70 ("ACPI: EC: Fix acpi_ec_dispatch_gpe()")
>>> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=218557
>>> Reported-by: Mark Pearson <mark.pearson@lenovo.com>
>>> Signed-off-by: Marcus Bergo <marcusbergo@gmail.com>
>>
>> Great finding with this being a potential root cause of this behavior 
>> (at least from a Linux perspective).
>>
>> Although this helps, I'm not really a fan of the tech debt 
>> accumulated by needing to quirk this on a system by system basis as a 
>> bandage.
>>
>> At least for HP someone said that this commit happens to help them 
>> for the same issue you're describing:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers- 
>> x86.git/commit/?h=fixes&id=9f5595d5f03fd4dc640607a71e89a1daa68fd19d
>>
>> That was surprising to me, but it must be changing the timing of some 
>> of the code running in HP's EC.  Since you happen to have a Lenovo 
>> system does it happen to help the Lenovo EC too?
>>
>> Mark, comments please?
>>
> Someone just reported that the timing delay patch helped their Lenovo 
> system as well.  Can you see if it helps you too?

