Return-Path: <linux-acpi+bounces-19543-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 35D93CB3399
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Dec 2025 15:55:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9CFD4304C9D8
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Dec 2025 14:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEE4E248880;
	Wed, 10 Dec 2025 14:55:01 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 699D621D3F2;
	Wed, 10 Dec 2025 14:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765378501; cv=none; b=M+V1XxvC87OZsddwxFse/7wdJGcpunAc6vIhDA7kmuEb3U4W92I4bApyUQD3bo3d9x7fDNggHLLCEkkV7DbKqhyQPZXsoYsnUpl+bXtpnwW3mCxO45+6ik2EErDzmI2Geud3GX9xLyPFpq5DlGyTxG6JrJroSmXHZx6g1q9Fqpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765378501; c=relaxed/simple;
	bh=qzf9way1qf81inuoDSxwgM9KVcolfnNm7DYakwUS+tc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ctOHu/iPM5q+yWidHwyT76j6jErVhrozCbX8DLN+9IFzITbpOKW/+LGHtmN3krKj82T2TH9Av2m/DLE0ufWbUjz1QFdQ6gl1/fCPcTt7T37nnm1AMts+MSX1Cso8JDRtlnSXY2GPvg1g8u9cv3KP3DDOxqNcp3R4J4md2tWFU/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com; spf=none smtp.mailfrom=foss.arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=foss.arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6B8C0153B;
	Wed, 10 Dec 2025 06:54:52 -0800 (PST)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 78A483F740;
	Wed, 10 Dec 2025 06:54:57 -0800 (PST)
Date: Wed, 10 Dec 2025 14:54:54 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Pengjie Zhang <zhangpengjie2@huawei.com>
Cc: <rafael@kernel.org>, <lenb@kernel.org>, <lihuisong@huawei.com>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<zhanjie9@hisilicon.com>, <zhenglifeng1@huawei.com>,
	<yubowen8@huawei.com>, <linhongye@h-partners.com>,
	<linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<wangzhi12@huawei.com>
Subject: Re: [PATCH] ACPI: PCC: Fix race condition by removing static
 qualifier
Message-ID: <20251210-valiant-watchful-guillemot-2bb5be@sudeepholla>
References: <20251210132634.2050033-1-zhangpengjie2@huawei.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251210132634.2050033-1-zhangpengjie2@huawei.com>

On Wed, Dec 10, 2025 at 09:26:34PM +0800, Pengjie Zhang wrote:
> The variable 'ret' in acpi_pcc_address_space_setup() is currently
> declared with the 'static' storage specifier. This can lead to race
> conditions in a multithreaded environment.
> 
> Remove the 'static' qualifier to ensure 'ret' is allocated directly
> on the stack as a local variable.
> 

Ah, my mistake. I’m not sure how that slipped in other than a simple typo or
copy/paste error. Thanks for catching it. Let me know if you spotted it
because something broke or just from reading the code.

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

> Fixes: a10b1c99e2dc ("ACPI: PCC: Setup PCC Opregion handler only if platform interrupt is available")
> Signed-off-by: Pengjie Zhang <zhangpengjie2@huawei.com>
> ---
>  drivers/acpi/acpi_pcc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/acpi_pcc.c b/drivers/acpi/acpi_pcc.c
> index 97064e943768..e3f302b9dee5 100644
> --- a/drivers/acpi/acpi_pcc.c
> +++ b/drivers/acpi/acpi_pcc.c
> @@ -52,7 +52,7 @@ acpi_pcc_address_space_setup(acpi_handle region_handle, u32 function,
>  	struct pcc_data *data;
>  	struct acpi_pcc_info *ctx = handler_context;
>  	struct pcc_mbox_chan *pcc_chan;
> -	static acpi_status ret;
> +	acpi_status ret;
>  
>  	data = kzalloc(sizeof(*data), GFP_KERNEL);
>  	if (!data)
> -- 
> 2.33.0
> 

-- 
Regards,
Sudeep

