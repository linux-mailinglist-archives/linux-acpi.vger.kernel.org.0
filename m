Return-Path: <linux-acpi+bounces-12765-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E40D1A7CE1C
	for <lists+linux-acpi@lfdr.de>; Sun,  6 Apr 2025 15:24:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75A7C3B0C19
	for <lists+linux-acpi@lfdr.de>; Sun,  6 Apr 2025 13:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6480201103;
	Sun,  6 Apr 2025 13:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZX0owmjh"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027432AEE0;
	Sun,  6 Apr 2025 13:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743945889; cv=none; b=K3XkX0G4EytFxN4FOCWDfaA2M1BFlIH7pR1NZCTKcwmIF859jc8vtI0ndtm9n5EAnqGeBtOjeBmZFKT3Od02qgiErTmdSHZ9GkKkEjPvR4R5N5mBI4eQi32Q5qvLvy7EXB3jBtYY/QjLiFiaa0plOYv9fdTWlzzBRyV9kEZIkmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743945889; c=relaxed/simple;
	bh=HhYS6ZrofSFsRGvKxqef7mHm63j09x/tSq4gjLfSKeg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eLwUdcE97a2xxV+3dRanpKH02Wzsob8+4NLK2TXJyU2w9qccAC439KKTmFAsBOSoYHR6PlSv1GXYWtZjDPHgZDw5vZkzlF74NGNCtQPprVYwBItLwGZHCgB05VSmUf1NqJRtCeYJtBZlYfCZZyl8+7+6ST5BDTiQaWCQA9PY9sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZX0owmjh; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743945888; x=1775481888;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HhYS6ZrofSFsRGvKxqef7mHm63j09x/tSq4gjLfSKeg=;
  b=ZX0owmjhKYbiLVvdmsfK/jjnRsnmTLN9AQZW0KT0CwbYIq4GbsuyArN1
   qfrIVzN1azd35e+SkWPu0NUs0bmiWk5+eNAZveRWPiJHTfznafILPiQc7
   XzzXGqKTAJfCPeww9+o366u9au2JApr+9z5DIB0Qu1ajzIppqs+LbYyiS
   NDuYxAVB85FcMMwb3/zpZSCeiyvVdB1x6o4nM9yYqdqM6ob1ttuDBtBYM
   1S4blK70g1stuOAo4gaUiTDqO6pDmDNjhuvWm+LmWydaZcrCaQcj7EE3R
   2XOUAGy6vsKgLGaVyg0zwYE0wSnuJiKHKPaYnCEa+5xvuUh8LYn86oqDY
   w==;
X-CSE-ConnectionGUID: lOpIb5XoTemTFwZcE/yOPA==
X-CSE-MsgGUID: gZk7neS+QhCDSpVp0QPVPg==
X-IronPort-AV: E=McAfee;i="6700,10204,11396"; a="45216491"
X-IronPort-AV: E=Sophos;i="6.15,193,1739865600"; 
   d="scan'208";a="45216491"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2025 06:24:48 -0700
X-CSE-ConnectionGUID: 0lNWP3+WQPmia3rIZbkSKg==
X-CSE-MsgGUID: kPAqTsPkQ4ybufdJujVFbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,193,1739865600"; 
   d="scan'208";a="158690058"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2025 06:24:44 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1u1PzN-00000009l9w-18j1;
	Sun, 06 Apr 2025 16:24:41 +0300
Date: Sun, 6 Apr 2025 16:24:41 +0300
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
Message-ID: <Z_KAmSNLsAhctKv8@smile.fi.intel.com>
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

#syz test: https://bitbucket.org/andy-shev/linux.git test-swnode

-- 
With Best Regards,
Andy Shevchenko



