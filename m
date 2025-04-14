Return-Path: <linux-acpi+bounces-13000-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BBF1A8789E
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Apr 2025 09:22:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F17B73A7034
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Apr 2025 07:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3395257AFE;
	Mon, 14 Apr 2025 07:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LvObdVba"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5FE1B4241;
	Mon, 14 Apr 2025 07:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744615371; cv=none; b=JcWSbqqdp1ybDNodbMHDdwEk9mhlmE08TaHMelU12TE3lV0VTMGEuDiRqSAWkAvkeHRnfWnfl03AyhQkXKJM6/t82gr3A9Kb5i41mrmhll289O/qFxhxGYFgFPAqDxH078HsAsSKRmffg2KnQlnoYh6Dv+GEbWFcIJHmVcMVnN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744615371; c=relaxed/simple;
	bh=IOILmuO2B3RZBYuN+CUITTHeDhATmMItT1uR2lClnoM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rhD7SSBwdGtW97Opk+kplgd6xv02lAtJawDp/wmFIBfGqL8tCLa7jQ+EXq/PTrIJuZ3cdoG1eHxROQqwo9lh6duIaL/4TcJvXRqlyd0XzEWcYr+If+kMcEO40help3Gxw1E8qg3jKs9q4UI1GKNjK++iaGB40sy02aSv363r2Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LvObdVba; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744615369; x=1776151369;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IOILmuO2B3RZBYuN+CUITTHeDhATmMItT1uR2lClnoM=;
  b=LvObdVbaUSY5/wKhbiC9XfQRSJhIZFvS32jqoAbUl6WdntBW0vtCyLO0
   RJyrtMRn4LEz5/smXwB6N9O0k4K8c3PKoQBQCgywR6oUVCm4jgjor9mF/
   ZNTl3Pm5zuSjgaBRQLDT6Voan1s4hzANFF5c6hXR7okKpcOPVfamKDA7+
   7Y+8H4enlHE7c3MHS8SMuxAH2fwRMInXfa/PdtcZVglh1AVHXTc/EDCBc
   LZMB1yGG6XkcOH9xI8g/yX1UjmP6fM2T8RPOvzlBVP1+Qd9gi11Hqig6S
   AWfvt7HUQ68xvSL/eGAbJ4VlEY+oEghDmcAAKo8GvJ3utOn3Vk1ARtRse
   A==;
X-CSE-ConnectionGUID: ogJLm5uORaa40SBX1KQ3yw==
X-CSE-MsgGUID: 89nMMZZuRKOxJObagNUNgg==
X-IronPort-AV: E=McAfee;i="6700,10204,11402"; a="45210027"
X-IronPort-AV: E=Sophos;i="6.15,211,1739865600"; 
   d="scan'208";a="45210027"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2025 00:22:49 -0700
X-CSE-ConnectionGUID: kFfeufNeQIKrUspjwLFnhQ==
X-CSE-MsgGUID: vwvFqfg9TTaDyMS6+tOp0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,211,1739865600"; 
   d="scan'208";a="130600144"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2025 00:22:45 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1u4E9R-0000000CA9G-3Jc1;
	Mon, 14 Apr 2025 10:22:41 +0300
Date: Mon, 14 Apr 2025 10:22:41 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Lizhi Xu <lizhi.xu@windriver.com>
Cc: dakr@kernel.org, djrscally@gmail.com, dvyukov@google.com,
	gregkh@linuxfoundation.org, heikki.krogerus@linux.intel.com,
	jgg@nvidia.com, kevin.tian@intel.com, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, nicolinc@nvidia.com,
	rafael@kernel.org, sakari.ailus@linux.intel.com,
	syzbot+2ff22910687ee0dfd48e@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com, yi.l.liu@intel.com
Subject: Re: [PATCH V2] software node: Prevent link creation failure from
 causing kobj reference count imbalance
Message-ID: <Z_y3wd7zur1_xUjM@smile.fi.intel.com>
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
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

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

The fix looks correct to me,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



