Return-Path: <linux-acpi+bounces-5790-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B2A0A8C3E83
	for <lists+linux-acpi@lfdr.de>; Mon, 13 May 2024 12:01:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40BC0B20D0D
	for <lists+linux-acpi@lfdr.de>; Mon, 13 May 2024 10:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42280148FE5;
	Mon, 13 May 2024 10:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="al/YreVq"
X-Original-To: linux-acpi@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEFDE148855;
	Mon, 13 May 2024 10:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715594491; cv=none; b=T1wnINZoTq574qs+H4nWSRCfNkptd6/Hg3qb8b1hFVJbvrYtzz6yU0UeLQo5MZTzVI6hAKWfalA5u0VaxIN2MykQBKU6cLIZIoeQ6/ZbsvWPvRCWfKrC9laZvfq6Q+hIHa8d/dq9dKBrBWCeX+MUbc3DTWHSjaOVru0mFjOyt5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715594491; c=relaxed/simple;
	bh=vzJEz9QnIFNvbREi3UlmbyFZkWZ7ZUfLk222orIBBYY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=W9OPqXqwDt75pWkw1iBaho8q+232DDEnqsgZSvcZbtU++NqTdwI/2KYMWK7AzX74M7I2x5XzupHSN/VwUTvfvvn+w77glWsZ0APjkhw2/Nvd77kZqQV6lYH60WPnqyxLsz+GPEY37siJzZvejXBSLao0kPZ1D+TjBKeDUeLhgG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=al/YreVq; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1715594487;
	bh=vzJEz9QnIFNvbREi3UlmbyFZkWZ7ZUfLk222orIBBYY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=al/YreVqDRNZD3wWAeeX39E9rAcYIz1hA0MCD1SPENOfDVj1lSLi65BItwZaqNLgH
	 /fwqBEqHhLtHfNKH0tMlsnUSqBVHqUFORw1vp+PCe2ZLXsIET2B/SPqj67KDBHXPXE
	 WSvwae10CepalW4LRzCjMpejfho0vm9gVUmKWY6jKHGihf7C62YBb63InJnwLIG3Vg
	 HJ/XjSSD0pGgShaLWZ3k5Zh84QH31YZUrAr6pu5IFsWGmz0m9xvPMxR/qq5cF3rea8
	 AwFG6eaOgjBlFdOL4CMAVjxoeSdYKeaNxPs3IpYP9y5SmlQpNwN14gzul9gEjzjicy
	 fGi5rLY4reBaw==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id EA0D73782121;
	Mon, 13 May 2024 10:01:26 +0000 (UTC)
From: Laura Nao <laura.nao@collabora.com>
To: andriy.shevchenko@linux.intel.com
Cc: bot@kernelci.org,
	brgl@bgdev.pl,
	kernel@collabora.com,
	laura.nao@collabora.com,
	linus.walleij@linaro.org,
	linux-acpi@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mika.westerberg@linux.intel.com
Subject: Re: [PATCH] gpiolib: acpi: Add ACPI device NULL check to
Date: Mon, 13 May 2024 12:02:00 +0200
Message-Id: <20240513100200.218261-1-laura.nao@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <Zj4zNefxGUGKjxha@smile.fi.intel.com>
References: <Zj4zNefxGUGKjxha@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Andy,

On 5/10/24 16:46, Andy Shevchenko wrote:
> 
> Now we may remove that check from __acpi_find_gpio():
> 
> --- a/drivers/gpio/gpiolib-acpi.c
> +++ b/drivers/gpio/gpiolib-acpi.c
> @@ -988,10 +988,10 @@ __acpi_find_gpio(struct fwnode_handle *fwnode,
> const char *con_id, unsigned int
>   	}
>   
>   	/* Then from plain _CRS GPIOs */
> -	if (!adev || !can_fallback)
> -		return ERR_PTR(-ENOENT);
> +	if (can_fallback)
> +		return acpi_get_gpiod_by_index(adev, NULL, idx, info);
>   
> -	return acpi_get_gpiod_by_index(adev, NULL, idx, info);
> +	return ERR_PTR(-ENOENT);
>   }
>   
>   struct gpio_desc *acpi_find_gpio(struct fwnode_handle *fwnode,
> 
> 
> As a side effect it will make the comment better to understand.
> 
> With above suggestion applied, feel free to add mine
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> You might need to rephrase the commit message to say that
> 
>   "We also move the check in additional to the moving the function
>   call
>   outside of __acpi_find_gpio()."
> 
> or something similar, up to you.
> 

Thanks for the feedback, I sent another patch with the suggestions above
applied:
https://lore.kernel.org/all/20240513095610.216668-1-laura.nao@collabora.com/T/#u

Best regards,

Laura Nao


