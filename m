Return-Path: <linux-acpi+bounces-20042-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 38BFBD00DD1
	for <lists+linux-acpi@lfdr.de>; Thu, 08 Jan 2026 04:28:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A3D323004291
	for <lists+linux-acpi@lfdr.de>; Thu,  8 Jan 2026 03:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B7DC2773F9;
	Thu,  8 Jan 2026 03:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CugIrXrD"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0089513635C;
	Thu,  8 Jan 2026 03:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767842900; cv=none; b=gXE3Nc9KXeKYBVqahZEcsfXMTuImkKrJydqTAWxgXSdM+IETNYrjoDUWaxWPXm08wgIjXrfgnNZ56FTYTriIvzho6qOjjx7i9fGdUbkEUXxYkVhAeWK+NDREBYdg52OZqyqsrJB8BIxE2EE2xNR7t1BRlksGLrakJKHPdBgGwf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767842900; c=relaxed/simple;
	bh=A05daoEEUJ2ZX7IFP63uEe39zSNINlPMMSEFcNRX2js=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qXq/pD5zI8B7SAkBHtp8juTo5PTp3qXNdhhCJRqRAjK0D1MHAwYV1GiapRRxUXOwBYQEaS36xhJfhkA2q7F/w6j1VtGs1Vzwh91U2e5U33/5RaAyArUgW/wXcEcLU9HM2h6XrervfauRMlAy975/00ByW8e3VfDf3z+1gvBCUnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CugIrXrD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B850C116C6;
	Thu,  8 Jan 2026 03:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767842899;
	bh=A05daoEEUJ2ZX7IFP63uEe39zSNINlPMMSEFcNRX2js=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CugIrXrDclGf5kR7tnLIFk1yP2zLLrvQ9mFZY3uF9YySsNR29pmpTy8WgO2BrqOcP
	 SIsEpeMw/xXaRYSiMMdmZlujgbFrbXeQq/mR8zN3usdQXadnz44UDzQrU+7sbtrSQn
	 nSS7E92mf4RLQqjwK3H8KKrLihHq9ZjUtqBuMlvzJRn8/s8dDQtx8nz8+4J9py5ttI
	 ZwEiR+uyw6IwLjpDG8swp7PGhWRaYDPiohwY0HiA1lb84iG3tMW0Ln0YvwGdHtoSge
	 OBFJOPRnG2mZVWxf+UqCBkUAY1QN1qxHabbiePzEb202pDlONFpZJC5+j7nQByxJoN
	 IZxklIj9FkCZg==
Message-ID: <578420dc-7c28-4117-839b-ab4f24ff9c3e@kernel.org>
Date: Wed, 7 Jan 2026 21:28:17 -0600
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] ACPI: PM: s2idle: Add missing checks to
 acpi_s2idle_begin_lps0()
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>
References: <2818730.mvXUDI8C0e@rafael.j.wysocki>
Content-Language: en-US
From: "Mario Limonciello (AMD) (kernel.org)" <superm1@kernel.org>
In-Reply-To: <2818730.mvXUDI8C0e@rafael.j.wysocki>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/7/2026 9:14 AM, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Commit 32ece31db4df ("ACPI: PM: s2idle: Only retrieve constraints
> when needed"), that attempted to avoid useless evaluation of LPS0 _DSM
> Function 1 in lps0_device_attach(), forgot to add checks for
> lps0_device_handle and sleep_no_lps0 to acpi_s2idle_begin_lps0()
> where they should be done before calling lpi_device_get_constraints()
> or lpi_device_get_constraints_amd().
> 
> Add the missing checks.
> 
> Fixes: 32ece31db4df ("ACPI: PM: s2idle: Only retrieve constraints when needed")
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
> ---
>   drivers/acpi/x86/s2idle.c |    3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> --- a/drivers/acpi/x86/s2idle.c
> +++ b/drivers/acpi/x86/s2idle.c
> @@ -515,7 +515,8 @@ static struct acpi_scan_handler lps0_han
>   
>   static int acpi_s2idle_begin_lps0(void)
>   {
> -	if (pm_debug_messages_on && !lpi_constraints_table) {
> +	if (lps0_device_handle && !sleep_no_lps0 && pm_debug_messages_on &&
> +	    !lpi_constraints_table) {
>   		if (acpi_s2idle_vendor_amd())
>   			lpi_device_get_constraints_amd();
>   		else
> 
> 
> 


