Return-Path: <linux-acpi+bounces-13006-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EA25A87AA0
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Apr 2025 10:42:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A085A188BBEE
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Apr 2025 08:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42E9725A2B5;
	Mon, 14 Apr 2025 08:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PDzng+DP"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E95E2580CD;
	Mon, 14 Apr 2025 08:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744620129; cv=none; b=Cf39YcwmHMXXNDaKNoDTgTx7DmhIqhvYLI/iewfmMdVSb7PQRPsES9DHhgEv1SpAPXnK+NzuAwQGzWX+5NnNUIOdDWCcueSVsSm/5FQGd6qAserwaL8wN1xRo6TLVgvU6lVbPeswXbuPKsRRy9pJ6DVsTGNGJlX7We6rNEKN+t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744620129; c=relaxed/simple;
	bh=yVNb+XBjRxkJl6C+3T6/4cDm3RQwDEa5c+x2ZOfmFvY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oDSpWapemFaKsRqTBdsynfz06bUrR+NPYm9iBXXw/xcq5MHGJm7qoKjsH6K4MyAZ+ZIh2b/6C3HbaWs8OEhcu7AQDHlPByNWmn+JVYd+nWw6Hd5vujrXinhQFITxz9S8N7jMnKTTAmtM2/rLJKtRY7x8SMOqgJUgz7Ql78+XrHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PDzng+DP; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744620127; x=1776156127;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yVNb+XBjRxkJl6C+3T6/4cDm3RQwDEa5c+x2ZOfmFvY=;
  b=PDzng+DPTlsduggwX1VSiZIvlkzQDM6K0UBVa26CG51d+JTD0Ag0gE4m
   f8tT5OFtbTxKTR/KjTzoHsTG5sKr1OV/sFoA2Aho9P1kJzgOaVpcgRoSX
   OATevANKhtRP0fuhXSWWjTJ1/Lr4hLysjwGomZQ+U3es7QrH7KNGeMGTO
   Czr66LLzrOySo1lpskNFFRQ4kZtaKqhe+RpVT3TU+eNlAmB7pOWpGhMwe
   vJAIZ4VASyJynXQpoeCX5kRPVFzh7efCbogy82DmwDK8laexxZsZEctkO
   ud5cLoPkLERTh9M0/+ULAheYYl3Xngz33Xpxx+08aedXo3hVyNrhwDp14
   A==;
X-CSE-ConnectionGUID: D3VLAu+JSrCPkDiagyUvCQ==
X-CSE-MsgGUID: 5JoXE9SlT9yYWud7W2UwKg==
X-IronPort-AV: E=McAfee;i="6700,10204,11402"; a="49884403"
X-IronPort-AV: E=Sophos;i="6.15,211,1739865600"; 
   d="scan'208";a="49884403"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2025 01:42:05 -0700
X-CSE-ConnectionGUID: U0QE6RrMRcK0cUNW5zk7Yg==
X-CSE-MsgGUID: yXF6xqkxROG2ms0PPeFaTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,211,1739865600"; 
   d="scan'208";a="130084836"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2025 01:42:01 -0700
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 5BB5911F871;
	Mon, 14 Apr 2025 11:41:58 +0300 (EEST)
Date: Mon, 14 Apr 2025 08:41:58 +0000
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Lizhi Xu <lizhi.xu@windriver.com>
Cc: andriy.shevchenko@linux.intel.com, dakr@kernel.org, djrscally@gmail.com,
	dvyukov@google.com, gregkh@linuxfoundation.org,
	heikki.krogerus@linux.intel.com, jgg@nvidia.com,
	kevin.tian@intel.com, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, nicolinc@nvidia.com,
	rafael@kernel.org,
	syzbot+2ff22910687ee0dfd48e@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com, yi.l.liu@intel.com
Subject: Re: [PATCH V2] software node: Prevent link creation failure from
 causing kobj reference count imbalance
Message-ID: <Z_zKVtxJbOYcys-J@kekkonen.localdomain>
References: <Z_ypLhYQwGf41hVK@smile.fi.intel.com>
 <20250414071123.1228331-1-lizhi.xu@windriver.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250414071123.1228331-1-lizhi.xu@windriver.com>

On Mon, Apr 14, 2025 at 03:11:23PM +0800, Lizhi Xu wrote:
> syzbot reported a uaf in software_node_notify_remove. [1]
> 
> When any of the two sysfs_create_link() in software_node_notify() fails,
> the swnode->kobj reference count will not increase normally, which will
> cause swnode to be released incorrectly due to the imbalance of kobj reference
> count when executing software_node_notify_remove().
> 
> Increase the reference count of kobj before creating the link to avoid uaf.
> 
> [1]
> BUG: KASAN: slab-use-after-free in software_node_notify_remove+0x1bc/0x1c0 drivers/base/swnode.c:1108
> Read of size 1 at addr ffff888033c08908 by task syz-executor105/5844
> Freed by task 5844:
>  software_node_notify_remove+0x159/0x1c0 drivers/base/swnode.c:1106
>  device_platform_notify_remove drivers/base/core.c:2387 [inline]
> 
> Fixes: 9eb59204d519 ("iommufd/selftest: Add set_dev_pasid in mock iommu")
> Reported-by: syzbot+2ff22910687ee0dfd48e@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=2ff22910687ee0dfd48e
> Tested-by: syzbot+2ff22910687ee0dfd48e@syzkaller.appspotmail.com
> Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>

Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>

> ---
> V1 -> V2: reduce calltrace
> 
>  drivers/base/swnode.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
> index b1726a3515f6..5c78fa6ae772 100644
> --- a/drivers/base/swnode.c
> +++ b/drivers/base/swnode.c
> @@ -1080,6 +1080,7 @@ void software_node_notify(struct device *dev)
>  	if (!swnode)
>  		return;
>  
> +	kobject_get(&swnode->kobj);
>  	ret = sysfs_create_link(&dev->kobj, &swnode->kobj, "software_node");
>  	if (ret)
>  		return;
> @@ -1089,8 +1090,6 @@ void software_node_notify(struct device *dev)
>  		sysfs_remove_link(&dev->kobj, "software_node");
>  		return;
>  	}
> -
> -	kobject_get(&swnode->kobj);
>  }
>  
>  void software_node_notify_remove(struct device *dev)
> -- 
> 2.43.0
> 

-- 
Sakari Ailus

