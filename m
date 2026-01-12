Return-Path: <linux-acpi+bounces-20210-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 16A83D14430
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Jan 2026 18:11:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6F07F3040672
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Jan 2026 17:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AC7437F11D;
	Mon, 12 Jan 2026 17:03:08 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BAFD37B404;
	Mon, 12 Jan 2026 17:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768237387; cv=none; b=GQyFt9lu0nN7SjwOeNOhtcY0Tu0UWGU7w23wlNdt/IH3nCw0iRcorPv9qo7FLN6WAFpOKXbfLsOwpQqIbIN1PXILjVCYiQqLKM9eigRO8K60oJggpG+QU40P92aztWhdPvdKf2L/FgUcEIimJSSc9Kmltu9hgYjKfm1tAZhmmZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768237387; c=relaxed/simple;
	bh=kaUVELI5XnJwMyerZ6NQc0FwEMuuU44+CVtDEcX8m+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kRZUTccYpXMQ+ZxiW9qIMC9w6i9yL9t269XsiQI72BTAEo0qtVXDg2Em5S9OUN3cxepV0O/doz5EHUh/1ofxtEO8ztzQVLVLdD1xgCZ7JvRUculV9ZsNUMpBkXBkcoRHmi8NSAYqNVDASmnwANhajf+ZrofyjM4Vf1YkujHIONU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=foss.arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 71AC61596;
	Mon, 12 Jan 2026 09:02:56 -0800 (PST)
Received: from bogus (e133711.arm.com [10.1.197.51])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EDF693F7C5;
	Mon, 12 Jan 2026 09:03:01 -0800 (PST)
Date: Mon, 12 Jan 2026 17:02:59 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Feng Tang <feng.tang@linux.alibaba.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Jeremy Linton <jeremy.linton@arm.com>,
	Hanjun Guo <guohanjun@huawei.com>,
	James Morse <james.morse@arm.com>,
	Joanthan Cameron <Jonathan.Cameron@huawei.com>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ACPI: PPTT: Dump PPTT table when error detected
Message-ID: <aWUpQ04uNcXtp0wR@bogus>
References: <20251231104909.80362-1-feng.tang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251231104909.80362-1-feng.tang@linux.alibaba.com>

On Wed, Dec 31, 2025 at 06:49:09PM +0800, Feng Tang wrote:
> There was warning message about PPTT table:
> 
> 	"ACPI PPTT: PPTT table found, but unable to locate core 1 (1)",
> 
> and it in turn caused scheduler warnings when building up the system.
> It took a while to root cause the problem be related a broken PPTT
> table which has wrong cache information.
> 
> To speedup debugging similar issues, dump the PPTT table, which makes
> the warning more noticeable and helps bug hunting.
> 
> The dumped info format on a ARM server is like:
> 
>     ACPI PPTT: Processors:
>     P[  0][0x0024]: parent=0x0000 acpi_proc_id=  0 num_res=1 flags=0x11(package)
>     P[  1][0x005a]: parent=0x0024 acpi_proc_id=  0 num_res=1 flags=0x12()
>     P[  2][0x008a]: parent=0x005a acpi_proc_id=  0 num_res=3 flags=0x1a(leaf)
>     P[  3][0x00f2]: parent=0x005a acpi_proc_id=  1 num_res=3 flags=0x1a(leaf)
>     P[  4][0x015a]: parent=0x005a acpi_proc_id=  2 num_res=3 flags=0x1a(leaf)
>     ...
>     ACPI PPTT: Caches:
>     C[   0][0x0072]: flags=0x7f next_level=0x0000 size=0x4000000  sets=65536  way=16 attribute=0xa  line_size=64
>     C[   1][0x00aa]: flags=0x7f next_level=0x00da size=0x10000    sets=256    way=4  attribute=0x4  line_size=64
>     C[   2][0x00c2]: flags=0x7f next_level=0x00da size=0x10000    sets=256    way=4  attribute=0x2  line_size=64
>     C[   3][0x00da]: flags=0x7f next_level=0x0000 size=0x100000   sets=2048   way=8  attribute=0xa  line_size=64
>     ...
> 
> It provides a global and straightforward view of the hierarchy of the
> processor and caches info of the platform, and from the offset info
> (the 3rd column), the child-parent relation could be checked.
> 
> With this, the root cause of the original issue was pretty obvious,
> that there were some caches items missing which caused the issue when
> building up scheduler domain.
> 

While this may sound like a good idea, it deviates from how errors in other
table-parsing code are handled. Instead of dumping the entire table, it would
be preferable to report the specific issue encountered during parsing.

I do not have a strong objection if Rafael is comfortable with this approach;
however, it does differ from the established pattern used by similar code.
Dumping the entire table in a custom manner is not the standard way of
handling parsing errors. Just my opinion.

-- 
Regards,
Sudeep

