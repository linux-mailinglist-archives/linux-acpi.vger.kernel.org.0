Return-Path: <linux-acpi+bounces-16842-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 719F1B55ED8
	for <lists+linux-acpi@lfdr.de>; Sat, 13 Sep 2025 08:05:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A4C3AA26F3
	for <lists+linux-acpi@lfdr.de>; Sat, 13 Sep 2025 06:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E6102E6CBF;
	Sat, 13 Sep 2025 06:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mn1gIkoh"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5736D2D94BF;
	Sat, 13 Sep 2025 06:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757743519; cv=none; b=sLsyN/5N4+UNe4hfZMjUGiQvbtrBNHRvURww6E+FLpmxodfO9vgF1w6PY9KryNCdJwWnweX4jBbcuOq555BNiXADAhvvVAer4UgVkjfjA5D9XqZYpblq4TQk3JLjGYazLR/5bI+iJVfVSRXSkY+vaEgpY4/0X/IGX04uQw2XhA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757743519; c=relaxed/simple;
	bh=GyZIzWAtehw+usycPJMh6r6YySiZ3FIOwMksfbkFqUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qdNJXgQ/kIv7yS9dd1m6+dN+dsY1WzqJ8oN8yApOi+44T47eyjqRXfp6MQRwnziPrxgpWWbNWk0PR/zZKnallzSjOn3W/HHIm/XicyKrtf7HLUTX37FxdwhyupkA8/e+18Srt2db+dJIYsqXLWmZ5S+soGdaDVnK1tSN18Mrs3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mn1gIkoh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6754CC4CEEB;
	Sat, 13 Sep 2025 06:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757743516;
	bh=GyZIzWAtehw+usycPJMh6r6YySiZ3FIOwMksfbkFqUk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mn1gIkoheGYCabLjCi2pDaCtXe+Vk7oADLAcFkBWdaRzFjMpnVqiShU2MsCWy4J0c
	 vUXlrnxUJrYb+hgBzwqkqQY0sra8Ykwvt7hygbZnuTnG3mXiw1QjA2l6NjzGAnNnEs
	 o5Tok+r0dEmY9lZh+56ofNibYfMNv+3+AWZQvVeE=
Date: Sat, 13 Sep 2025 08:05:13 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: GuangFei Luo <luogf2025@163.com>
Cc: rafael@kernel.org, dan.carpenter@linaro.org, lenb@kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, lkp@intel.com, sre@kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v3] ACPI: battery: prevent sysfs_add_battery re-entry on
 rapid events
Message-ID: <2025091354-query-oblivion-9d18@gregkh>
References: <2025091242-waltz-gruffly-0936@gregkh>
 <20250912162516.692861-1-luogf2025@163.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250912162516.692861-1-luogf2025@163.com>

On Sat, Sep 13, 2025 at 12:25:16AM +0800, GuangFei Luo wrote:
> Hi Greg,
> 
> Thanks for your review and suggestion.
> 
> I've updated sysfs_add_battery() to address your comment.
> The locking is now applied explicitly inside the function
> to prevent re-entry issues, while keeping the function
> self-contained for all call sites.
> 
> Patch version: v3
> 
> Thanks,
> GuangFei
> 
> v3:
>   - Modified the earlier approach: since sysfs_add_battery() is invoked
>     from multiple places, the most reliable way is to add the lock inside
>     the function itself.
>   - sysfs_remove_battery() had a similar race issue in the past, which was
>     fixed by adding a lock as well. Reference:
>     https://lore.kernel.org/all/9c921c22a7f33397a6774d7fa076db9b6a0fd669
> 	.1312318300.git.len.brown@intel.com/
> 
> v2:
>  - Fix missing mutex_unlock in acpi_battery_update()
>    (Reported-by: kernel test robot)
> 
> v1:
> When removing and reinserting the laptop battery, ACPI can trigger
> two notifications in quick succession:

Note, none of the above should be here in the changelog body, it should
be below the --- line.

> diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
> index 6905b56bf3e4..f6d4a8b39a9c 100644
> --- a/drivers/acpi/battery.c
> +++ b/drivers/acpi/battery.c
> @@ -850,6 +850,12 @@ static void __exit battery_hook_exit(void)
>  
>  static int sysfs_add_battery(struct acpi_battery *battery)
>  {
> +	mutex_lock(&battery->sysfs_lock);

Again, can you use guard() to make this logic simpler?  That would turn
this into a much smaller patch.

thanks,

greg k-h

