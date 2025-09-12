Return-Path: <linux-acpi+bounces-16752-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E7B8B55439
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Sep 2025 17:57:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2BBB3B1D90
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Sep 2025 15:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A525289E36;
	Fri, 12 Sep 2025 15:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="p+n4HTYT"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9117B3E1;
	Fri, 12 Sep 2025 15:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757692643; cv=none; b=SCkZYDtSyX/FDkFtYqhuJso6iysWg+uWcOUadfEcDVp8HFQ9zsy0Ajc9XfrT+c2feg201AUvkL/4DDX38wuDBsFFE+1Kf42c5RJtGM1F+REKc+qZt8TWzF7nvR/XUi/hGJm4TAf69jcxQFSPGfTq4VRXwjeaxv/MBSYd7OdhS5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757692643; c=relaxed/simple;
	bh=VdpnpXpvffnFkbv+UhY7JbF26A542XO4sx9mfnd6nQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BgazkMtECfVw1wJZRwTk96rpOjpA40Qgr96tYL5qj+XoAOV7kD2VgLk4Gzohs4RfsdL1la0dzaMdoq6MgJl2G5yA7KKGkLIaPAYNtanJLricidJ3xCrDyYRKobEK22g+iivV3fUqU2D31vRBb6wARMokK8A2ZKv3e4lMTJEjVpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=p+n4HTYT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 454F5C4CEF1;
	Fri, 12 Sep 2025 15:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757692642;
	bh=VdpnpXpvffnFkbv+UhY7JbF26A542XO4sx9mfnd6nQM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p+n4HTYTpyj4GG1Tk4ZndzRLon9XNHKXFQoguPN0K5dSFzDu9fa14cwLff13P1URP
	 FYbihAhMeL0AujfAFXc8L8n2c6sdmIxZbnh37Cw/jqxWSJdHDd9B3kaqEcIlP/DfpA
	 fErgBYucIS2VXIp2PTArzGorbC3jq9RxwCDbFUB4=
Date: Fri, 12 Sep 2025 17:57:19 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: GuangFei Luo <luogf2025@163.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Sebastian Reichel <sre@kernel.org>,
	linux-pm@vger.kernel.org, Dan Carpenter <dan.carpenter@linaro.org>,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v3] ACPI: battery: prevent sysfs_add_battery re-entry on
 rapid events
Message-ID: <2025091242-waltz-gruffly-0936@gregkh>
References: <20250910142653.313360-1-luogf2025@163.com>
 <20250912154859.692750-1-luogf2025@163.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250912154859.692750-1-luogf2025@163.com>

On Fri, Sep 12, 2025 at 11:48:59PM +0800, GuangFei Luo wrote:
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
> 
>   - ACPI_BATTERY_NOTIFY_STATUS (0x80)
>   - ACPI_BATTERY_NOTIFY_INFO   (0x81)

Changelog should go below the --- line.

>  static int sysfs_add_battery(struct acpi_battery *battery)
>  {
> +	mutex_lock(&battery->sysfs_lock);

Why not just use a guard() here?  That would make the logic elsewhere
much simpler.

thanks,

greg k-h

