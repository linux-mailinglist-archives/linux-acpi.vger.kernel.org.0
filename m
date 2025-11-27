Return-Path: <linux-acpi+bounces-19307-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A26D6C8DB0E
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Nov 2025 11:06:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4A11034E7E8
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Nov 2025 10:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C711031812F;
	Thu, 27 Nov 2025 10:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HjFWFM0T"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9993E2FC875;
	Thu, 27 Nov 2025 10:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764237999; cv=none; b=gxKCxWm7OKrWjhMpVFCMijjxhsw4k9jgybx8SWugKb/JSBugKOXHOEF+QcqELRDpolu93BaxGbzZBU19F1z8xU2T4IEw4v1E9E8+o7tqbGE4BRkXcpemqa55IqTCtTaa7YiS48eLYBX9wthEP7yUKYYzIWSQZy3gVU/6r2/pR5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764237999; c=relaxed/simple;
	bh=qyB6IHXo0lkqDWnnBdQrPg7IJ3IfbM8Oc4yUhLX0Ab4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JSN+hTawG7HDJsJMRlfKvzKf3202zumv/Cs2FOmA9tvMYxHgJtbfZJ2xyqfiBJWHyeCiltgLHJvvzF/v89h3kaEGo90ZxbhmmL0wCPr+6cCH4m9GZ1d/GfzIoWjurdjVd4ppab4TW6PY3mylJxQ+y/iC9IWq19zGVcF8cMp6v/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HjFWFM0T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67AB4C4CEF8;
	Thu, 27 Nov 2025 10:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764237999;
	bh=qyB6IHXo0lkqDWnnBdQrPg7IJ3IfbM8Oc4yUhLX0Ab4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HjFWFM0TvahrAGCiGYFsG3hXKmygUZkBeXVRRQKnNMymfJ14kg45MbPvglwQOTy6m
	 oh6e7g2SRP/+9aV+5tz5WXbdzBT0zHBs2yJ3jB28pVUeLy7AHHdV/yTh0QOJ7VQ98U
	 4X2oEbQSzzrPZbkinJ26irCm3HRZtta2RsURL6Y8C9kMrMIROE8a/7DQfVbEekGcY1
	 CDvZmsIYGYY5tU8q9I+aCO15M9NaWXpdaUuI6d3CRFZncWxCpzPO6vM6yBu7yuxwT1
	 4bYyrNwLWAXE5LQsEBeDNCGYyJobuYfGAArzGUgUr+977XW7wbefeIsx7sUeBlmjOv
	 LpSvqAFpqWisQ==
Date: Thu, 27 Nov 2025 11:06:29 +0100
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Linus Walleij <linusw@kernel.org>, Lei Xue <lei.xue@mediatek.com>,
	Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Sean Wang <sean.wang@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
	linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	yong.mao@mediatek.com, qingliang.li@mediatek.com,
	Fred-WY.Chen@mediatek.com, ot_cathy.xu@mediatek.com,
	ot_shunxi.zhang@mediatek.com, ot_yaoy.wang@mediatek.com,
	ot_ye.wang@mediatek.com, linux-acpi@vger.kernel.org,
	robh@kernel.org
Subject: Re: [PATCH 2/3] pinctrl: mediatek: Add acpi support
Message-ID: <aSgipbe75hrwhTD7@lpieralisi>
References: <20251125023639.2416546-1-lei.xue@mediatek.com>
 <20251125023639.2416546-3-lei.xue@mediatek.com>
 <CAD++jL=h4ZEgrjgGOfgFyAXBM7EL91ZD-La82UQ7GPOXv8h9WQ@mail.gmail.com>
 <aScwaxBG53dnZ4a4@lpieralisi>
 <aSdBu-B9mwU2-1_S@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aSdBu-B9mwU2-1_S@smile.fi.intel.com>

On Wed, Nov 26, 2025 at 08:06:51PM +0200, Andy Shevchenko wrote:

[...]

> > I also assume/hope that we don't want to add a "reg-names" _DSD property either
> > in ACPI to deal with this seamlessly in DT/ACPI (that was done for
> > "interrupt-names"):
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/firmware-guide/acpi/enumeration.rst?h=v6.18-rc7#n188
> 
> Hmm... Why not?

What's the policy there ? Half of the ACPI bindings for an interrupt
descriptor are defined in the ACPI specs (ie _CRS) and the other half
(ie "interrupt-names") is documented in the Linux kernel (or are we
documenting this elsewhere ?) ?

Or we are saying that "interrupt-names" properties are added by kernel
code _only_ (through software nodes, to make parsing seamless between DT
and ACPI) based on hardcoded name values in drivers ?

I don't think I can grok any example of the latter in the mainline.

I am asking because I'd need to add something similar shortly to make parsing
of platform devices created out of ACPI static tables easier (I guess we
can postpone discussion till I post the code but I thought I'd ask).

Are we going to do the same for "reg-names" ?

Most importantly, what is DT maintainers stance on the matter ?

Thanks,
Lorenzo

> > I am sorry I have got more questions than answers here - it would be good
> > to understand where the line is drawn when it comes to OF/ACPI and fwnode
> > heuristics compatibility.
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

