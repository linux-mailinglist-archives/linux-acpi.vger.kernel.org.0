Return-Path: <linux-acpi+bounces-19983-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B4CBFCFB47C
	for <lists+linux-acpi@lfdr.de>; Tue, 06 Jan 2026 23:44:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2D021300EB92
	for <lists+linux-acpi@lfdr.de>; Tue,  6 Jan 2026 22:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A4F130FC1D;
	Tue,  6 Jan 2026 22:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sQZsUjib"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D5B3081A2;
	Tue,  6 Jan 2026 22:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767739486; cv=none; b=uLGZyaN9mbAI07Xo8+SZMxDZMBWZprnJceJF9uZBChA5zrnZzMf+pArlLzvEQDAw6BXBaaU2LBKcktj6VxYzGS5O8hi2yAAl/jt+m2CTBpf6em1z8bSuuMVWHGX/itlT5wxbMnxQLzpwDevg/uIXmmz2zYaqqWNzSrOjexgFN9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767739486; c=relaxed/simple;
	bh=/H+qCF9kqG4o0P7ihGD2M6YxEfN99MtTRRTRSCQ91Xg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fTR+HW3j6a+Jn3rfiKweco5sfkg+v1Fjq4mcYP7XngnF8OWR5nBuILUSgN3rfMFyjKRPH6Zi6jY6MaWKyZbtgsUgzbaeiVKMyBcpC/IWcBNVUBApYKDVpGtkqvB37MK85CSFECPX9T4KEwrQ/Q1pXfrUY689rJWYU+MUcNV4H0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sQZsUjib; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A165C116C6;
	Tue,  6 Jan 2026 22:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767739485;
	bh=/H+qCF9kqG4o0P7ihGD2M6YxEfN99MtTRRTRSCQ91Xg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=sQZsUjibWTC/j3OQxVhplSDYwFNhn/GzUG/vZGnKIrMlEoVjoA88bJkC8KXyrljST
	 1ww24Yv13vwmR4LSRQDCrvLdov1k4X5SGcI7FvJ6oyERpCUL+32sIw5DtzUXZ82Md3
	 x0Huwp/bwbXiRENGZhW5mjzN3w5WD4g4qAzjgVYGvRg7XF8khlUSfF9WydDFBuWMlx
	 w3dZT7axZKCNEQi47BCiSMi2/l1SCEMOQK4UvfxNj8xf/WuFdiJBD0bIbdyf2vnG5M
	 yK1mfgh6bpaHfY1Fsm+3CgHGpR4bS+WrzSEkjgwnV+W3W1stCKE0us3XYVInGKBGc6
	 1J0Cg/FiP6vOg==
Message-ID: <4bcbf926-4543-4992-9803-6ad281bf42f4@kernel.org>
Date: Tue, 6 Jan 2026 16:44:43 -0600
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] ACPI: bus: Fix typo under sizeof() in acpi_run_osc()
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 LKML <linux-kernel@vger.kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Hans de Goede <hansg@kernel.org>
References: <2817106.mvXUDI8C0e@rafael.j.wysocki>
Content-Language: en-US
From: "Mario Limonciello (AMD) (kernel.org)" <superm1@kernel.org>
In-Reply-To: <2817106.mvXUDI8C0e@rafael.j.wysocki>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/29/2025 7:27 AM, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Subject:
> 
> The sizeof(32) in acpi_run_osc() should be sizeof(u32), so fix it.
> 
> Fixes: e5322888e6bf ("ACPI: bus: Rework the handling of \_SB._OSC platform features")
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
> ---
> 
> Commit e5322888e6bf is a linux-next one.
> 
> ---
>   drivers/acpi/bus.c |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- a/drivers/acpi/bus.c
> +++ b/drivers/acpi/bus.c
> @@ -294,7 +294,7 @@ acpi_status acpi_run_osc(acpi_handle han
>   	int ret;
>   
>   	if (!context || !context->cap.pointer ||
> -	    context->cap.length < 2 * sizeof(32) ||
> +	    context->cap.length < 2 * sizeof(u32) ||
>   	    guid_parse(context->uuid_str, &guid))
>   		return AE_BAD_PARAMETER;
>   
> 
> 
> 


