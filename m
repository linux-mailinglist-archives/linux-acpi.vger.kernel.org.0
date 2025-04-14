Return-Path: <linux-acpi+bounces-12999-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B15A87885
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Apr 2025 09:16:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02FB41885089
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Apr 2025 07:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E45A42459C3;
	Mon, 14 Apr 2025 07:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DslXwfWb"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5810245006;
	Mon, 14 Apr 2025 07:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744614971; cv=none; b=Fk9SMQWysPaUfsW1t+K/XuL23MX39EDK3xTdQ21tscmtsUwPrLo6UuIj12ZkYcI8fzbkEyvGPdzfMxOrEhbZOdRKLHvJ/Vq01zUJgONKP5pznrmLMdHsPeYlxoNpFkHtGBIVktt9Zmw7vGUaoM96eSAgW+QyD/YP6QRq8REeKCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744614971; c=relaxed/simple;
	bh=FfWVaYl9McUOFjG3dCa4tGjF80czMFii1m3cLj4EFoI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WQVI7jMUvxhVF/9yDV62J9HtNL5tyJz4+LftiMk+AxATM7S8eHhXHEJGhu2qhgbJELKIwUXEPtkL1BI7Y9Xeq1VUuNMfuVcPi9ENMyrH450PIqUZJezFcapJnBGF56Yn1qdfng7OgEebiUVITXZTXXCTjPMUgNaQnBU+0tydEzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DslXwfWb; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744614970; x=1776150970;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FfWVaYl9McUOFjG3dCa4tGjF80czMFii1m3cLj4EFoI=;
  b=DslXwfWbj+A2tOAe6CHB13PP8xnH1qix+pWy4QgdXaiSGlIkoLomkusZ
   Zzvx+xqoaxi7P+XmFlR9C+8RwGf3QlLVGMIQTxMJFVru+Wzx6VsMYvOX5
   8JjKeaTulQMJPrREPW1G3wHXH+oIMu4pGY9LB7W87YkN46BpTeOoC+dgh
   Q25xZC5rg6NuFQHA0JwRGre/2N4XVCSiUCypD2Wq/xhXQnmrchkGSzuvL
   E22ysEDH6VxbSy1P/81blxMQATxX9nJF2Mo24axq1y5mTmBVztnMh9wlY
   Zx7qAGGOodQXY3r33022rblTjzP6LeJ13egVeoiknA8O5bwcNTTxWT6h7
   A==;
X-CSE-ConnectionGUID: cTv6HafmT6aEVjMFpRAAcQ==
X-CSE-MsgGUID: b1Jl7bAvRc+1VTJAt5dwRA==
X-IronPort-AV: E=McAfee;i="6700,10204,11402"; a="63475798"
X-IronPort-AV: E=Sophos;i="6.15,211,1739865600"; 
   d="scan'208";a="63475798"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2025 00:16:09 -0700
X-CSE-ConnectionGUID: NYtpdj/4Q62qo5FJTlT36w==
X-CSE-MsgGUID: 7ESE92YXQCaQ+n6B4nPSZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,211,1739865600"; 
   d="scan'208";a="133842238"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2025 00:16:05 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1u4E2z-0000000CA29-2gzh;
	Mon, 14 Apr 2025 10:16:01 +0300
Date: Mon, 14 Apr 2025 10:16:01 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Lizhi Xu <lizhi.xu@windriver.com>
Cc: dakr@kernel.org, djrscally@gmail.com, dvyukov@google.com,
	gregkh@linuxfoundation.org, heikki.krogerus@linux.intel.com,
	jgg@nvidia.com, kevin.tian@intel.com, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, nicolinc@nvidia.com,
	rafael@kernel.org, sakari.ailus@linux.intel.com,
	syzbot+2ff22910687ee0dfd48e@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com, yi.l.liu@intel.com
Subject: Re: [PATCH] software node: Prevent link creation failure from
 causing kobj reference count imbalance
Message-ID: <Z_y2MdGMS861mvgS@smile.fi.intel.com>
References: <Z_ypLhYQwGf41hVK@smile.fi.intel.com>
 <20250414070834.1224154-1-lizhi.xu@windriver.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250414070834.1224154-1-lizhi.xu@windriver.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Apr 14, 2025 at 03:08:34PM +0800, Lizhi Xu wrote:
> On Mon, 14 Apr 2025 09:20:30 +0300, Andy Shevchenko wrote:
> > On Fri, Apr 11, 2025 at 08:42:02AM +0800, Lizhi Xu wrote:
> > > syzbot reported a uaf in software_node_notify_remove. [1]
> > >
> > > When any of the two sysfs_create_link() in software_node_notify() fails,
> > > the swnode->kobj reference count will not increase normally, which will
> > > cause swnode to be released incorrectly due to the imbalance of kobj reference
> > > count when executing software_node_notify_remove().
> > >
> > > Increase the reference count of kobj before creating the link to avoid uaf.
> > >
> > > [1]
> > 
> > Please, reduce this to ~5-7 lines only. This is how Submitting Patches document
> > recommends to put backtraces in the commit messages:
> > https://www.kernel.org/doc/html/latest/process/submitting-patches.html#backtraces-in-commit-messages
> Ok, I will reduce the calltrace, and send V2 patch.
> > 
> > > Fixes: 9eb59204d519 ("iommufd/selftest: Add set_dev_pasid in mock iommu")
> > > Reported-by: syzbot+2ff22910687ee0dfd48e@syzkaller.appspotmail.com
> > > Closes: https://syzkaller.appspot.com/bug?extid=2ff22910687ee0dfd48e
> > 
> > > Tested-by: syzbot+2ff22910687ee0dfd48e@syzkaller.appspotmail.com
> > 
> > Where is the positive result of it? I can't find the respective log.
> > To me this one
> > https://syzkaller.appspot.com/x/report.txt?x=158af070580000
> > doesn't sound as a useful report as I don't know if this patch fixes one
> > regression and introduced another.
> You can see: https://syzkaller.appspot.com/x/log.txt?x=118af07058000
> For tasks related to the reproducing program, there are only FAULT_INJECTION
> related problems in the log, no other problems, and the log record duration
> exceeds 240 seconds, and no uaf occurs, which is enough to prove that the
> problem has been fixed.

I'm not objecting that the original issue is being fixed, what I'm confused on
is that the report has only one line which doesn't make it clear that there are
no new regressions found during the same run.

-- 
With Best Regards,
Andy Shevchenko



