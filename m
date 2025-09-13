Return-Path: <linux-acpi+bounces-16847-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 98269B55F23
	for <lists+linux-acpi@lfdr.de>; Sat, 13 Sep 2025 09:33:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93EC27B6205
	for <lists+linux-acpi@lfdr.de>; Sat, 13 Sep 2025 07:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 176862E88B1;
	Sat, 13 Sep 2025 07:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZRYrktNW"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B858E45C14;
	Sat, 13 Sep 2025 07:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757748821; cv=none; b=WUcIWn94SM/sQRQL1otJCagklEjSQz2lyIv1Y+pFbTVr5UTzl0uU8wA93U5qxLy4GKACCv1AKkpgkRzEYOVz4hqp8yfLrsaoiDUrgor+4k+fk+enx3KBGsRABR/G/0+heSvMGUTmTlLwh2c449byBvGI+0GLRY0XONEqmsyjOHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757748821; c=relaxed/simple;
	bh=vsGwDuodr2tQy2mh//NV+yOBikhDYbj20ZKtEa9w99w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dNUBwXrnMCw/tfaviTjrqxtdEQfjEWHmntiqjEZiDnhSRtyLI2G04qKeheYck2WiYqhuOTHKfmCGp3PnCWj57WAJPifee94fxOtqbFdF0467Pjv0e+IFusEeMzJk4iykZaGlmhBvsJCKA2YoUBTM9uBNtbeqPl5sFsM7fyz0oyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZRYrktNW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC8D4C4CEEB;
	Sat, 13 Sep 2025 07:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757748820;
	bh=vsGwDuodr2tQy2mh//NV+yOBikhDYbj20ZKtEa9w99w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZRYrktNWy0IdPXQTmm61HJk5eBYIk63uHY3b/BSScm8gubGr+vL1Z4I5qKj/gOBAd
	 D8FGewItKhYR9kdCn26mi5zF/2LnGqtEsH/34phHKJ3aPzLB3WVf+/DBpvR/xnjwb2
	 3rJ2dHn1sF+HLpccP/lnVErUZr1g80ynKLp3tTgw=
Date: Sat, 13 Sep 2025 09:33:36 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: GuangFei Luo <luogf2025@163.com>
Cc: rafael@kernel.org, dan.carpenter@linaro.org, lenb@kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, lkp@intel.com, sre@kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v4] ACPI: battery: prevent sysfs_add_battery re-entry on
 rapid events
Message-ID: <2025091322-resilient-bottle-6d85@gregkh>
References: <20250910142653.313360-1-luogf2025@163.com>
 <20250913071925.697603-1-luogf2025@163.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250913071925.697603-1-luogf2025@163.com>

On Sat, Sep 13, 2025 at 03:19:25PM +0800, GuangFei Luo wrote:
> v4:
>   - Uses guard(mutex) for battery->sysfs_lock in sysfs_add_battery().
>   - Since sysfs_add_battery() now handles the battery->bat check with
>     proper locking,the extra if (!battery->bat) check at the call site
>     has become redundant.
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

Again, all of this goes below the --- line, not above it.

