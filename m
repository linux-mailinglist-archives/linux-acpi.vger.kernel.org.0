Return-Path: <linux-acpi+bounces-12994-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EBE4A877D9
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Apr 2025 08:27:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01F843AFEA3
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Apr 2025 06:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77DA01A3165;
	Mon, 14 Apr 2025 06:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AkG8rKll"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1334689;
	Mon, 14 Apr 2025 06:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744612039; cv=none; b=lIwwhislVLTjfaFeOV/xyr9m66fgvK9pK/Vss6Lsl4o66nVJcf/OECw4ySFQyUUOv0/XzboBPbSfrGRTSNy58nUdPyg7llIXCYC8Uel/8AgpDcG17X6YSxc33YLQ4s6iQX/7ogV5ySauE43HX9H19yPa1FqDwYXQvPf4RpV01NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744612039; c=relaxed/simple;
	bh=xNuLtHvn1T857pJq/3ThxDkVEgBk+YZJqAFTHy8SeQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rp7tNwFd2troUdPWCu+7dQ1R43FeTNwhvsQ3f2tmSXph84gAeXt3PHoMGamgnf1xl7+l9tCsZX3QGnC56LA7thmDA6FMJ0JyBpYYslEVZsNbctKXB/zbYqoNWRe/eiwM7Vc4ONqQbzyN5TROhYprr5LtwgYUbKYMd22u4FIuDUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AkG8rKll; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744612038; x=1776148038;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xNuLtHvn1T857pJq/3ThxDkVEgBk+YZJqAFTHy8SeQk=;
  b=AkG8rKllk6rpH/VKKGSS9d9EaFuTiKBjfV82a6+JDTA6oHs04W0ggaAE
   CeRz2IBnNAcw1u7F2b8UO9yZlaO2e/bjOOESTCNYb7dH01meN2Lb5stFS
   1fLj4sU1H9qk9dFzZmxNdZFF5fulC03h/uPORcsZhOa5zZuCqGvZnk1G+
   9pVauMUX/tTh0qNy9k6BtEASlJF6Cl1N4K2d6J78v45efQhECtc6ni6fD
   s4qu3GwlmID52Tkhe6PtQBf1KzwVdSZOhfuYfmBlrAVWidqbkiljpTghH
   uJVCjHoiR6idTyZq9pPqmFIEKpUgYZxjN27kRJcw24Uqo8g/QvFnApBiz
   Q==;
X-CSE-ConnectionGUID: 1N+GujUrSlakhpDUjXWaiA==
X-CSE-MsgGUID: Rs/5lpH3SFa2llmqQTgM7w==
X-IronPort-AV: E=McAfee;i="6700,10204,11402"; a="45954353"
X-IronPort-AV: E=Sophos;i="6.15,211,1739865600"; 
   d="scan'208";a="45954353"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2025 23:27:16 -0700
X-CSE-ConnectionGUID: YhH81Kj9S0Kw4vvGSEyc2A==
X-CSE-MsgGUID: TeCcFbqdShi5VY6ASNQ+zw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,211,1739865600"; 
   d="scan'208";a="130267760"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2025 23:27:12 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1u4DHh-0000000C9L4-1c0g;
	Mon, 14 Apr 2025 09:27:09 +0300
Date: Mon, 14 Apr 2025 09:27:09 +0300
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
Message-ID: <Z_yqvRvBolxhqi1k@smile.fi.intel.com>
References: <67f26778.050a0220.0a13.0265.GAE@google.com>
 <20250411004203.2932899-1-lizhi.xu@windriver.com>
 <Z_ypLhYQwGf41hVK@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z_ypLhYQwGf41hVK@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Apr 14, 2025 at 09:20:30AM +0300, Andy Shevchenko wrote:
> On Fri, Apr 11, 2025 at 08:42:02AM +0800, Lizhi Xu wrote:
> > syzbot reported a uaf in software_node_notify_remove. [1]
> > 
> > When any of the two sysfs_create_link() in software_node_notify() fails,
> > the swnode->kobj reference count will not increase normally, which will
> > cause swnode to be released incorrectly due to the imbalance of kobj reference
> > count when executing software_node_notify_remove().
> > 
> > Increase the reference count of kobj before creating the link to avoid uaf.
> > 
> > [1]
> 
> Please, reduce this to ~5-7 lines only. This is how Submitting Patches document
> recommends to put backtraces in the commit messages:
> https://www.kernel.org/doc/html/latest/process/submitting-patches.html#backtraces-in-commit-messages
> 
> > Fixes: 9eb59204d519 ("iommufd/selftest: Add set_dev_pasid in mock iommu")
> > Reported-by: syzbot+2ff22910687ee0dfd48e@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=2ff22910687ee0dfd48e
> 
> > Tested-by: syzbot+2ff22910687ee0dfd48e@syzkaller.appspotmail.com
> 
> Where is the positive result of it? I can't find the respective log.
> To me this one
> https://syzkaller.appspot.com/x/report.txt?x=158af070580000
> doesn't sound as a useful report as I don't know if this patch fixes one
> regression and introduced another.
> 
> Dmitry?

Code wise makes sense to me. We do the put in asymmetrical order.
Thanks for looking into it.

-- 
With Best Regards,
Andy Shevchenko



