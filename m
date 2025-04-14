Return-Path: <linux-acpi+bounces-12993-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B0E4A877D0
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Apr 2025 08:20:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7FE2B7A6D7C
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Apr 2025 06:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E4381A239D;
	Mon, 14 Apr 2025 06:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ftsJRx/T"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7A5148832;
	Mon, 14 Apr 2025 06:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744611640; cv=none; b=Vhxjj20OUWrkJyuMUhH5EcWAKo7IaZys0EfCOCdXc14UefJ2Y5dX8bzDhtIoLxsPgKj5HW6ColkHDiGuqDdnjLNpDMChpinGAYHIq1IhwltLmnJXV6TBiIUCJmOYClxl4q9Yn0wjbMfGRpxQAXg812/WL6ZR8i6BMLzEY3RSC+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744611640; c=relaxed/simple;
	bh=C4PKF284bm3UK2WkXwxqL/tl8w290NK+P9saOflVdu0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AFYQDGs7xSDx7h7A/Je0BPWyU3w6mgJHsrsL7x4wz0vSD0DK3be0L0vpFmXrepJIM4SS3w2np2vwnHDDQbhrYnSm43IDgt51bsV3IHNsggYi3Ki7+70ffR/meuX9TigMhuPNEJNJQc0Mhap/2KUEUthBvLgkK19T4m7aRLow5kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ftsJRx/T; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744611640; x=1776147640;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=C4PKF284bm3UK2WkXwxqL/tl8w290NK+P9saOflVdu0=;
  b=ftsJRx/TNF+lSRj0VBx5yY0HkSca+aF1id/D9ddbulPC4CSMn14uUcHL
   5l1DHWSTPpf80Yu5wHPJvIvtKoPAm62F79p28ROUIaggaMUSTEAcyX9/e
   d0wsWPo+urx8RhVDO+WWQ383JZwpFYrwLyKAbKbZM40JXGHLZ1yBOl4ft
   qaShnd1S2e7V+3XbUXdC899aEHuMrf0fHCFTQpXgRgwNQeBptUk/6ooni
   ADei+tQK/FbGn25MLJnI3RbDico/QRjKfrAUKdp1QlhMgSw9SxLkuOGMg
   jLa+wqci37PmvwVHZsOZ794xu1zJdQp/Vs+LEvQhhzCR4yeta7r5h0MCI
   Q==;
X-CSE-ConnectionGUID: Yr6PNfBoSh2+6N56+50TDg==
X-CSE-MsgGUID: xQj6W90gQmiwnvSupsxgsg==
X-IronPort-AV: E=McAfee;i="6700,10204,11402"; a="46155621"
X-IronPort-AV: E=Sophos;i="6.15,211,1739865600"; 
   d="scan'208";a="46155621"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2025 23:20:39 -0700
X-CSE-ConnectionGUID: hHu137UcT1i8XbcVzQpbXw==
X-CSE-MsgGUID: kx8RNqZlTn+fi23yg60x/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,211,1739865600"; 
   d="scan'208";a="129693328"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2025 23:20:34 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1u4DBG-0000000C9Ex-2w5y;
	Mon, 14 Apr 2025 09:20:30 +0300
Date: Mon, 14 Apr 2025 09:20:30 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Lizhi Xu <lizhi.xu@windriver.com>, Dmitry Vyukov <dvyukov@google.com>
Cc: syzbot+2ff22910687ee0dfd48e@syzkaller.appspotmail.com, dakr@kernel.org,
	djrscally@gmail.com, gregkh@linuxfoundation.org,
	heikki.krogerus@linux.intel.com, jgg@nvidia.com,
	kevin.tian@intel.com, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, nicolinc@nvidia.com,
	rafael@kernel.org, sakari.ailus@linux.intel.com,
	syzkaller-bugs@googlegroups.com, yi.l.liu@intel.com
Subject: Re: [PATCH] software node: Prevent link creation failure from
 causing kobj reference count imbalance
Message-ID: <Z_ypLhYQwGf41hVK@smile.fi.intel.com>
References: <67f26778.050a0220.0a13.0265.GAE@google.com>
 <20250411004203.2932899-1-lizhi.xu@windriver.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250411004203.2932899-1-lizhi.xu@windriver.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Apr 11, 2025 at 08:42:02AM +0800, Lizhi Xu wrote:
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

Please, reduce this to ~5-7 lines only. This is how Submitting Patches document
recommends to put backtraces in the commit messages:
https://www.kernel.org/doc/html/latest/process/submitting-patches.html#backtraces-in-commit-messages

> Fixes: 9eb59204d519 ("iommufd/selftest: Add set_dev_pasid in mock iommu")
> Reported-by: syzbot+2ff22910687ee0dfd48e@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=2ff22910687ee0dfd48e

> Tested-by: syzbot+2ff22910687ee0dfd48e@syzkaller.appspotmail.com

Where is the positive result of it? I can't find the respective log.
To me this one
https://syzkaller.appspot.com/x/report.txt?x=158af070580000
doesn't sound as a useful report as I don't know if this patch fixes one
regression and introduced another.

Dmitry?

-- 
With Best Regards,
Andy Shevchenko



