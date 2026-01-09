Return-Path: <linux-acpi+bounces-20118-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C4F16D0B388
	for <lists+linux-acpi@lfdr.de>; Fri, 09 Jan 2026 17:27:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 051B6305DE72
	for <lists+linux-acpi@lfdr.de>; Fri,  9 Jan 2026 16:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23723272803;
	Fri,  9 Jan 2026 16:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IuEpyZhm"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC91F5CDF1;
	Fri,  9 Jan 2026 16:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767975553; cv=none; b=mJyb38NWtTgtLaEOBv3LAuTzdcnflBXFYek6B4NCSwZ9U0vN+NJ6apVWDjGffbWPx0N90/OE79fZ6ffYu7DSEDpewqCDGAaOw35KT4ZT/3gNGnmicXkOlO//roGFdRnG1kH8vWoJK4twAh9tNPUMOAOH+KHnFeOFsdJVy5x8N1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767975553; c=relaxed/simple;
	bh=+pU6kVmWtj079ZTboEgReEyXewHkpN3eN1GsQHr1/f0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fF4UpEqzu9bRrXtTVnvuFxxZLgOKIYfNYs7aHjQ7wZPwz2WZYX2K9NAX7QTLwOIG/d7uXZbxkMIImvsGyY9ryYRgjzRbKG/EsGt0WzKz0iusGzruQu87bme5m4xdfq2UaSK8J8E1cHf83qNy+XYRfyj3/pIt/8FXz6cEo48tVFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IuEpyZhm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7281DC4CEF1;
	Fri,  9 Jan 2026 16:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767975552;
	bh=+pU6kVmWtj079ZTboEgReEyXewHkpN3eN1GsQHr1/f0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=IuEpyZhmn4Ese3Fn3hWrGCVNqEeeFHPRPRZ1iycywYSGYKUOIRcTNEHRJTzkBiaUh
	 j9JdnrgtWkJ2Q5mvInbOboXXoCG8auPiNa1J6r4AjDLhH7jiqaAe1oNVWWKrks5LNs
	 MalFJ7eFyX5Purb2qDtDI0ImwpxC6q7b8TJ8ULHubGbRrdTK3EDyWizqgIDzoq1yNs
	 +eA/I+rGdx0y6SZ2NfjGcp8PASOOmBxFpeuQs4Lkop1a5i+9+rZst2BzyI/ZlyuDyw
	 pD/CvHMEa1J0zo3O1zNcQRxbe7+DQ3k1cvVUOOTDzxW89ijjFFGWtK7PVseo1P/tx2
	 8rigIlVXRhDag==
Message-ID: <8643ee12-2240-4d28-ba5b-32c08f597af3@kernel.org>
Date: Fri, 9 Jan 2026 10:19:11 -0600
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ACPI: x86: s2idle: Remove dead code in
 lps0_device_attach()
To: Gergo Koteles <soyer@irl.hu>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260109001619.37532-1-soyer@irl.hu>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20260109001619.37532-1-soyer@irl.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/8/26 6:16 PM, Gergo Koteles wrote:
> The rev_id is always 0 for AMD since commit
> e32d546483a2 ("ACPI: x86: Drop quirk for HP Elitebook"),
> so this condition will never be true.
> 
> Remove the dead code.
> 
> Signed-off-by: Gergo Koteles <soyer@irl.hu>

Makes sense, thanks!

Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>

> ---
>   drivers/acpi/x86/s2idle.c | 3 ---
>   1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
> index 6d4d06236f61..a095b6f4401b 100644
> --- a/drivers/acpi/x86/s2idle.c
> +++ b/drivers/acpi/x86/s2idle.c
> @@ -459,9 +459,6 @@ static int lps0_device_attach(struct acpi_device *adev,
>   			lps0_dsm_func_mask = (lps0_dsm_func_mask << 1) | 0x1;
>   			acpi_handle_debug(adev->handle, "_DSM UUID %s: Adjusted function mask: 0x%x\n",
>   					  ACPI_LPS0_DSM_UUID_AMD, lps0_dsm_func_mask);
> -		} else if (lps0_dsm_func_mask_microsoft > 0 && rev_id) {
> -			lps0_dsm_func_mask_microsoft = -EINVAL;
> -			acpi_handle_debug(adev->handle, "_DSM Using AMD method\n");
>   		}
>   	} else {
>   		rev_id = 1;


