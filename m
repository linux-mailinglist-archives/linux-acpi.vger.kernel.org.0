Return-Path: <linux-acpi+bounces-12764-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B012A7CE06
	for <lists+linux-acpi@lfdr.de>; Sun,  6 Apr 2025 15:13:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F172A16B175
	for <lists+linux-acpi@lfdr.de>; Sun,  6 Apr 2025 13:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EF191A0B0E;
	Sun,  6 Apr 2025 13:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U3uUTHYI"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485F079CF;
	Sun,  6 Apr 2025 13:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743945195; cv=none; b=XsQ66SVaJVZ+tAZNMRVailszvKokAL7eDvaOnGAYrvYRurmi0lC8QRKxqwnDRUni4B+4zdSblNM6iZ6qZgFC3GkXL8XBqGlDk4K8LObz0A2C9YhEw2rk1Vo4ukqjGuKb1LRhhgkg7jqecJypYBBzAbb2JuoMtun/JmMdgrMbskg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743945195; c=relaxed/simple;
	bh=Ej2Hq7jpSOIG7V6PCnu6LxemPiYhAtlxrkIWOUAG6UY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eoPBRVRWm/I9a7xvugMTWsJeh322IhAO2Xjb51n18S5OgRyGRzgg+3u+VG2fesH1tEzOXGi5zG0GTWx1742MczRrVNp97bdgJDnwjFG5n3TQsg/cQtRx6KxHZvGJ8bz1NEEgmHWGUj+xrq94CapZXTXBUA1o+J/0qdrBOB2Zw6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U3uUTHYI; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743945193; x=1775481193;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ej2Hq7jpSOIG7V6PCnu6LxemPiYhAtlxrkIWOUAG6UY=;
  b=U3uUTHYIxUXTuHT8y1l7M+dH/T7zrI5+LnEwQG5zJ0460+oR18jiDhM3
   m3oZOUWQVxa5cXGs6CBWoi45KHELHJ5piax4TwgwYME3D70BccWw63X0F
   gANVEWCYLKR+PwqkJ5ubvXxu6iDTesDvBiZdBgtFW72eTl0LAs7LPmltF
   DqwjP19JGoYfrUKvTNrwpDNxImVd9haDxgfZGzv3iKAFogtkEyLdBLynY
   1Mg6uUj1GO3bYv2deAoSiVkaxpKQLRW/SeGHtoU9zobi/vjGfI72PYYZn
   4MItEj1VMzTbpK0mX4rl9kep1lvi3qX4JjW1Xz0/1YTMy57aLT98pwMK0
   w==;
X-CSE-ConnectionGUID: sGv3FeLHTc2vYIMHFRxg2w==
X-CSE-MsgGUID: qSI+SCBYS/aOC4LLsLAySA==
X-IronPort-AV: E=McAfee;i="6700,10204,11396"; a="48987472"
X-IronPort-AV: E=Sophos;i="6.15,193,1739865600"; 
   d="scan'208";a="48987472"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2025 06:13:12 -0700
X-CSE-ConnectionGUID: TDuQPgYhRYSZ8dgoaSFKIA==
X-CSE-MsgGUID: ktbfnMUaQCWrkrOy7iYplw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,193,1739865600"; 
   d="scan'208";a="158688730"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2025 06:13:09 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1u1Po9-00000009ksD-1l2a;
	Sun, 06 Apr 2025 16:13:05 +0300
Date: Sun, 6 Apr 2025 16:13:05 +0300
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
Message-ID: <Z_J94Up33luYw6Xg@smile.fi.intel.com>
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

> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.

#syz test: git@bitbucket.org:andy-shev/linux.git test-swnode

-- 
With Best Regards,
Andy Shevchenko



