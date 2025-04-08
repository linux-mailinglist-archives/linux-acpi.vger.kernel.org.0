Return-Path: <linux-acpi+bounces-12861-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 660A2A80F0A
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Apr 2025 16:58:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EA1F1BA6F00
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Apr 2025 14:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2C041FE44E;
	Tue,  8 Apr 2025 14:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hrJdad6m"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F081DF991;
	Tue,  8 Apr 2025 14:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744124100; cv=none; b=bi0OdIPd07csK3ZXBsEtWblcZwkPh/76w7eF97LuwpqqE5G1Om7ZLTghRzrEbb1Ys8u2qBXBK6Wv2I0GiLNYPoTgZwHDhhJW/72d57pOXUjpw8T5CgiZZBFglYLJeu9OyjBIAwuPJpNiEqE3LxvDoVT1Nq8XTtZM3+742i0a/qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744124100; c=relaxed/simple;
	bh=nZ1yhl1scTXfkiPAhPmxOZZ2j4lMgnCcL0OYg+kZnOo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h8KakP7ANeB2wYBnFgyVsNAYEdvv94sZkehHN9+LRcV13WX3pmbQaAoIEComUhsvheuEwGV1sgEnWomECkns6ucOf7LBPX3mjSQz/+xnP6jNpX1cBAQs8YoTXV03EVuebWTxQxMi+a3MnxL5bYAENmiLgPMCYnuXHXqBopFjLFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hrJdad6m; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744124099; x=1775660099;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nZ1yhl1scTXfkiPAhPmxOZZ2j4lMgnCcL0OYg+kZnOo=;
  b=hrJdad6m+u0HSoz/A+wVlEevl30pNDYgH86h6m6GrNCYKk/1a1t2HRQK
   HXpO2X144PRS5uXqYk9VI5oKBgqdqmNu8f47D1vQmYoTCvXKyxKRSCkeu
   /MI3fGOYzlUVLf7OADuG0bD/Zax+5cNXwBFnZB/0ssNsDKgpqeHIJ1pqg
   6TzAdWFRSmhWWOACCDQkG1Kq/JWwCiPoxkGbe7BdzCbIa3wp/JbpDgSZs
   Ti0lg+42uFa/tFy+7pt4bogHMgO4StOfNoeTmqMwnvsTLJVsUfjqFH9m4
   wkVEMcCGmtZ+9lqmp48JiG3r9gp0W4OhkodFPI9VNlo8QeZEIjboWO9/b
   A==;
X-CSE-ConnectionGUID: 598SdRxUSFGYmF3DMkCd6Q==
X-CSE-MsgGUID: wqli1UHVTlW9MDFYP00OpA==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="55744639"
X-IronPort-AV: E=Sophos;i="6.15,198,1739865600"; 
   d="scan'208";a="55744639"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2025 07:54:58 -0700
X-CSE-ConnectionGUID: LXRmzx/nS3yEKVJw8+IY+A==
X-CSE-MsgGUID: Pgo2jEVpQ7iIn6rvOz0LpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,198,1739865600"; 
   d="scan'208";a="128022280"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2025 07:54:55 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1u2ALj-0000000AR1D-3Wgo;
	Tue, 08 Apr 2025 17:54:51 +0300
Date: Tue, 8 Apr 2025 17:54:51 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: syzbot <syzbot+2ff22910687ee0dfd48e@syzkaller.appspotmail.com>
Cc: dakr@kernel.org, djrscally@gmail.com, gregkh@linuxfoundation.org,
	heikki.krogerus@linux.intel.com, jgg@nvidia.com,
	kevin.tian@intel.com, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, nicolinc@nvidia.com,
	rafael@kernel.org, sakari.ailus@linux.intel.com,
	syzkaller-bugs@googlegroups.com, yi.l.liu@intel.com
Subject: Re: [syzbot] [acpi?] KASAN: slab-use-after-free Read in
 software_node_notify_remove
Message-ID: <Z_U4uxxjGLF52m2q@smile.fi.intel.com>
References: <67f26778.050a0220.0a13.0265.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67f26778.050a0220.0a13.0265.GAE@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sun, Apr 06, 2025 at 04:37:28AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    acc4d5ff0b61 Merge tag 'net-6.15-rc0' of git://git.kernel...
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=15a807cf980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=24f9c4330e7c0609
> dashboard link: https://syzkaller.appspot.com/bug?extid=2ff22910687ee0dfd48e
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=109077b0580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13717c3f980000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/e4bfa652b34a/disk-acc4d5ff.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/3d19beb8bb92/vmlinux-acc4d5ff.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/e7298ccc6331/bzImage-acc4d5ff.xz
> 
> The issue was bisected to:
> 
> commit 9eb59204d5197b4add63968c8c5b7633631f9a5a
> Author: Yi Liu <yi.l.liu@intel.com>

Liu, have you looked at the issue? It has a good reproducibility ratio and
definitely something with your patch, but it might be still that it revealed
a lurking bug in software node implementation or driver core, however I don't
see it.


-- 
With Best Regards,
Andy Shevchenko



