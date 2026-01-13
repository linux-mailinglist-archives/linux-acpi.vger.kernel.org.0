Return-Path: <linux-acpi+bounces-20236-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 780DCD19914
	for <lists+linux-acpi@lfdr.de>; Tue, 13 Jan 2026 15:44:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1238F3067051
	for <lists+linux-acpi@lfdr.de>; Tue, 13 Jan 2026 14:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68EFA29E117;
	Tue, 13 Jan 2026 14:41:02 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B606126F2A0;
	Tue, 13 Jan 2026 14:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768315262; cv=none; b=XJso1jwXgpNGtd+H8pEdlQkNzaprmMnNFJzYT3gkKEGB4kyQG3qxasewCF9CK6rWUQup4xkMAABIzpqlGA+f6QDC5ZrNzyj9Ssogt/igMIJiicVG0DXFsP1e5Lgnat7vvcYEa7d1LNO9922TSekjX+//FXTYTb/zG6ZHiRjWGNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768315262; c=relaxed/simple;
	bh=4zX62vGLHAl0JKGxw6VwLWF+X67YOPXZyFsihvaouvI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bVHxIz9MVu1vUU85P7jhdvUX4OTEB3e9qFMrXownc0u0HpvGeWoaRR3eUcQfcuAM+fIBM/BZtBMf9R3/qiqgmmzMQ4Gm1G0FLgHEvPMUQKH2ly3uBAX3NaHk7f1gEc+E/kE9tmHO7QEy3Kqi50bY+t52NzXTZVCeHIRahOwBAvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=foss.arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 50FC0497;
	Tue, 13 Jan 2026 06:40:53 -0800 (PST)
Received: from bogus (e133711.arm.com [10.1.197.51])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C56293F59E;
	Tue, 13 Jan 2026 06:40:58 -0800 (PST)
Date: Tue, 13 Jan 2026 14:40:56 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Feng Tang <feng.tang@linux.alibaba.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Jeremy Linton <jeremy.linton@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Hanjun Guo <guohanjun@huawei.com>,
	James Morse <james.morse@arm.com>,
	Joanthan Cameron <Jonathan.Cameron@huawei.com>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ACPI: PPTT: Dump PPTT table when error detected
Message-ID: <aWZZeD496CPi20Gc@bogus>
References: <20251231104909.80362-1-feng.tang@linux.alibaba.com>
 <aWUpQ04uNcXtp0wR@bogus>
 <aWYBef5ZUNKVpg1W@U-2FWC9VHC-2323.local>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aWYBef5ZUNKVpg1W@U-2FWC9VHC-2323.local>

On Tue, Jan 13, 2026 at 04:25:29PM +0800, Feng Tang wrote:
> Hi Sudeep,
> 
> Thanks for the reviews!
> 
> On Mon, Jan 12, 2026 at 05:02:59PM +0000, Sudeep Holla wrote:
> > On Wed, Dec 31, 2025 at 06:49:09PM +0800, Feng Tang wrote:
> > > There was warning message about PPTT table:
> > > 
> > > 	"ACPI PPTT: PPTT table found, but unable to locate core 1 (1)",
> > > 
> > > and it in turn caused scheduler warnings when building up the system.
> > > It took a while to root cause the problem be related a broken PPTT
> > > table which has wrong cache information.
> > > 
> > > To speedup debugging similar issues, dump the PPTT table, which makes
> > > the warning more noticeable and helps bug hunting.
> > > 
> > > The dumped info format on a ARM server is like:
> > > 
> > >     ACPI PPTT: Processors:
> > >     P[  0][0x0024]: parent=0x0000 acpi_proc_id=  0 num_res=1 flags=0x11(package)
> > >     P[  1][0x005a]: parent=0x0024 acpi_proc_id=  0 num_res=1 flags=0x12()
> > >     P[  2][0x008a]: parent=0x005a acpi_proc_id=  0 num_res=3 flags=0x1a(leaf)
> > >     P[  3][0x00f2]: parent=0x005a acpi_proc_id=  1 num_res=3 flags=0x1a(leaf)
> > >     P[  4][0x015a]: parent=0x005a acpi_proc_id=  2 num_res=3 flags=0x1a(leaf)
> > >     ...
> > >     ACPI PPTT: Caches:
> > >     C[   0][0x0072]: flags=0x7f next_level=0x0000 size=0x4000000  sets=65536  way=16 attribute=0xa  line_size=64
> > >     C[   1][0x00aa]: flags=0x7f next_level=0x00da size=0x10000    sets=256    way=4  attribute=0x4  line_size=64
> > >     C[   2][0x00c2]: flags=0x7f next_level=0x00da size=0x10000    sets=256    way=4  attribute=0x2  line_size=64
> > >     C[   3][0x00da]: flags=0x7f next_level=0x0000 size=0x100000   sets=2048   way=8  attribute=0xa  line_size=64
> > >     ...
> > > 
> > > It provides a global and straightforward view of the hierarchy of the
> > > processor and caches info of the platform, and from the offset info
> > > (the 3rd column), the child-parent relation could be checked.
> > > 
> > > With this, the root cause of the original issue was pretty obvious,
> > > that there were some caches items missing which caused the issue when
> > > building up scheduler domain.
> > > 
> > 
> > While this may sound like a good idea, it deviates from how errors in other
> > table-parsing code are handled. Instead of dumping the entire table, it would
> > be preferable to report the specific issue encountered during parsing.
> > 
> > I do not have a strong objection if Rafael is comfortable with this approach;
> > however, it does differ from the established pattern used by similar code.
> > Dumping the entire table in a custom manner is not the standard way of
> > handling parsing errors. Just my opinion.
> 
> Yes, it's a fair point about the error handling. Actually for the issue
> we met, the PPTT table complies with ACPI spec and PPTT table spec nicely,
> that it has no checksum or format issue, the only problem is some items
> are missing. 
> 

Agreed, but how is this any different from other tables that contain optional
entries the ASL compiler cannot detect?

> So I would say the dump itself doesn't break any existing ACPI table error
> handling, or change anything. As Hanjun suggested, it could be put under a
> CONFIG_ACPI_PPTT_ERR_DUMP option as a PPTT specific debug method, and not
> related to general ACPI table error handling.
> 

Sure, that could be an option as long as CONFIG_ACPI_PPTT_ERR_DUMP is default
off and are enabled only when debugging and not always like in distro images.
Does that work for you ?

> We have had this in our tree for a while, and the good part is it gives a
> direct overview of all the processors and caches in system, you get to
> know the rough number of them from the index, and items are listed side
> by side so that some minor error could be very obvious in this comparing
> mode.
> 

Agreed, but all this info are available to userspace in some form already.
What does this dump give other than debugging a broken PPTT ?

-- 
Regards,
Sudeep

