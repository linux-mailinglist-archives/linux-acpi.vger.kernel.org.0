Return-Path: <linux-acpi+bounces-20221-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C08BD17464
	for <lists+linux-acpi@lfdr.de>; Tue, 13 Jan 2026 09:25:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 516A4303BFC1
	for <lists+linux-acpi@lfdr.de>; Tue, 13 Jan 2026 08:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FBBC37FF63;
	Tue, 13 Jan 2026 08:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="XlIZikYv"
X-Original-To: linux-acpi@vger.kernel.org
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E19F37FF64;
	Tue, 13 Jan 2026 08:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768292737; cv=none; b=hbyJy1rB+bDL215tq/yDEcR13Lv11mO8m1yDX/tZMoWFneSe1rS1sds1ODKZus9F9Elsc3iWLdmfBCvNiyof+JRtsBuJoc0xWNXfuIHuoj6ZBhweZwewprRes/11h8TveXOqXd3BX7U283N4USB54MTXZuA8FBAM/5QRF1/FhGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768292737; c=relaxed/simple;
	bh=W2qNS9jH+n1ntDR7tK0aRGfCzFo4M80+IYjlc5JK3tI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZKyJSw77UHhke0NfEJVBnfEjba0gK2nsIdtppEIZBzOmDz2SdF79G4rJyiuej76ANbKgdLpLOkDFIOgurroNdIMK6ACGppuT4k3g2C3KmQdjZO7MimgIM1qrdJKTM2/L3kb7eRmkIsXVCudarQuSsH4RCSIEWGtyjVaZXJXerds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=XlIZikYv; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1768292730; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=7BHTJQp+BpkSNam2fgczbb/3Tj51ZWRW+AJY5rTtbjA=;
	b=XlIZikYvmNAVSMz0jR+tseTgRnydf8orCrbnFOxJ2O5oqZkQLjGT4CxgDxpU4gNNNkJ2qZBtA6TI620EgaZ06xcd6cV80VrRPfj6nUba0BY3lwBdDYKezPbI9KlYRr64pXyRmuPwy3YuxcsFXapYOt/9IGhRFmDFB3sZoU1uygo=
Received: from localhost(mailfrom:feng.tang@linux.alibaba.com fp:SMTPD_---0Wx-CZ74_1768292729 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 13 Jan 2026 16:25:29 +0800
Date: Tue, 13 Jan 2026 16:25:29 +0800
From: Feng Tang <feng.tang@linux.alibaba.com>
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Jeremy Linton <jeremy.linton@arm.com>,
	Hanjun Guo <guohanjun@huawei.com>,
	James Morse <james.morse@arm.com>,
	Joanthan Cameron <Jonathan.Cameron@huawei.com>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ACPI: PPTT: Dump PPTT table when error detected
Message-ID: <aWYBef5ZUNKVpg1W@U-2FWC9VHC-2323.local>
References: <20251231104909.80362-1-feng.tang@linux.alibaba.com>
 <aWUpQ04uNcXtp0wR@bogus>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aWUpQ04uNcXtp0wR@bogus>

Hi Sudeep,

Thanks for the reviews!

On Mon, Jan 12, 2026 at 05:02:59PM +0000, Sudeep Holla wrote:
> On Wed, Dec 31, 2025 at 06:49:09PM +0800, Feng Tang wrote:
> > There was warning message about PPTT table:
> > 
> > 	"ACPI PPTT: PPTT table found, but unable to locate core 1 (1)",
> > 
> > and it in turn caused scheduler warnings when building up the system.
> > It took a while to root cause the problem be related a broken PPTT
> > table which has wrong cache information.
> > 
> > To speedup debugging similar issues, dump the PPTT table, which makes
> > the warning more noticeable and helps bug hunting.
> > 
> > The dumped info format on a ARM server is like:
> > 
> >     ACPI PPTT: Processors:
> >     P[  0][0x0024]: parent=0x0000 acpi_proc_id=  0 num_res=1 flags=0x11(package)
> >     P[  1][0x005a]: parent=0x0024 acpi_proc_id=  0 num_res=1 flags=0x12()
> >     P[  2][0x008a]: parent=0x005a acpi_proc_id=  0 num_res=3 flags=0x1a(leaf)
> >     P[  3][0x00f2]: parent=0x005a acpi_proc_id=  1 num_res=3 flags=0x1a(leaf)
> >     P[  4][0x015a]: parent=0x005a acpi_proc_id=  2 num_res=3 flags=0x1a(leaf)
> >     ...
> >     ACPI PPTT: Caches:
> >     C[   0][0x0072]: flags=0x7f next_level=0x0000 size=0x4000000  sets=65536  way=16 attribute=0xa  line_size=64
> >     C[   1][0x00aa]: flags=0x7f next_level=0x00da size=0x10000    sets=256    way=4  attribute=0x4  line_size=64
> >     C[   2][0x00c2]: flags=0x7f next_level=0x00da size=0x10000    sets=256    way=4  attribute=0x2  line_size=64
> >     C[   3][0x00da]: flags=0x7f next_level=0x0000 size=0x100000   sets=2048   way=8  attribute=0xa  line_size=64
> >     ...
> > 
> > It provides a global and straightforward view of the hierarchy of the
> > processor and caches info of the platform, and from the offset info
> > (the 3rd column), the child-parent relation could be checked.
> > 
> > With this, the root cause of the original issue was pretty obvious,
> > that there were some caches items missing which caused the issue when
> > building up scheduler domain.
> > 
> 
> While this may sound like a good idea, it deviates from how errors in other
> table-parsing code are handled. Instead of dumping the entire table, it would
> be preferable to report the specific issue encountered during parsing.
> 
> I do not have a strong objection if Rafael is comfortable with this approach;
> however, it does differ from the established pattern used by similar code.
> Dumping the entire table in a custom manner is not the standard way of
> handling parsing errors. Just my opinion.

Yes, it's a fair point about the error handling. Actually for the issue
we met, the PPTT table complies with ACPI spec and PPTT table spec nicely,
that it has no checksum or format issue, the only problem is some items
are missing. 

So I would say the dump itself doesn't break any existing ACPI table error
handling, or change anything. As Hanjun suggested, it could be put under a
CONFIG_ACPI_PPTT_ERR_DUMP option as a PPTT specific debug method, and not
related to general ACPI table error handling.

We have had this in our tree for a while, and the good part is it gives a
direct overview of all the processors and caches in system, you get to
know the rough number of them from the index, and items are listed side
by side so that some minor error could be very obvious in this comparing
mode.

Thanks,
Feng

> 
> -- 
> Regards,
> Sudeep

