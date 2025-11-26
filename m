Return-Path: <linux-acpi+bounces-19294-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 15FD0C8B127
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Nov 2025 17:53:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0794D4E26A3
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Nov 2025 16:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6442133D6C7;
	Wed, 26 Nov 2025 16:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IoJFaLMO"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374992FD667;
	Wed, 26 Nov 2025 16:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764175990; cv=none; b=LEfjuVZhUF46U/0uWjYA3FzDwAkFro9WKThH4ymsa8qXNmt0pIpRpeg9r2qlObidfcysa7GpXt5DAKnm2Nj3znvTCYAEC3umwSGn43nwYU+kQX1Q98JGCWvt0ciOh0kq1ugTcMRY8wlVu6R72vi2aSlvzcP2VF2f2XPXMrbVqKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764175990; c=relaxed/simple;
	bh=mmQKTxXmZkxtfNlrMvRnw3FG4sKObXtL7r6tazNlwdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ihRBuSw51TKNRxto/AgQHTh/vRKinCs9LRKbiiQhz/D0rgAKlsNY4nrBnllhSzwVTs2aP4wzFrL5ZL5VKJeSBfCqga1JTRcjvJc41Wvu1Y8JzvSiJl/p8jSL3WqHltj42xYjMDB0P8/VGb7Bn5HIoit0mLOIyGN007ZXCRs2cUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IoJFaLMO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1527C4CEF7;
	Wed, 26 Nov 2025 16:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764175989;
	bh=mmQKTxXmZkxtfNlrMvRnw3FG4sKObXtL7r6tazNlwdQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IoJFaLMOjR9wr3+xuMS2vx75RuQ/Q1NPSn6yj4FJI+kL75FFDHiIZXK8+pyJbAdgM
	 3QlknRBsMdS7KCd4bttC8IYAoBz6Q/WetOM59LMpaAPju/qaAaqQ1fnFVYVC9Vx0bZ
	 k8h4KAaST2iyOldpemJLrgSLY+KAXM+/QsBqqnVRK4A1xCJnbtbxByPsnLbwwbS3ge
	 hal9/R7jNFaQJw9xC+30n8oTXjQuW11QwvmAXY3TgKEjsh7ydOgwGvy5hauc9Ccj3X
	 tlDg2+ZCt2uEVo81/XbjRjJ60ZcspbkKljDqUvDIbcL3+mFI4YgN38GWFIWV4QANIk
	 m0FqKs+V/tOlA==
Date: Wed, 26 Nov 2025 17:52:59 +0100
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Linus Walleij <linusw@kernel.org>
Cc: Lei Xue <lei.xue@mediatek.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
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
Message-ID: <aScwaxBG53dnZ4a4@lpieralisi>
References: <20251125023639.2416546-1-lei.xue@mediatek.com>
 <20251125023639.2416546-3-lei.xue@mediatek.com>
 <CAD++jL=h4ZEgrjgGOfgFyAXBM7EL91ZD-La82UQ7GPOXv8h9WQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD++jL=h4ZEgrjgGOfgFyAXBM7EL91ZD-La82UQ7GPOXv8h9WQ@mail.gmail.com>

[+cc: RobH for his information]

On Wed, Nov 26, 2025 at 10:10:15AM +0100, Linus Walleij wrote:
> On Tue, Nov 25, 2025 at 3:36 AM Lei Xue <lei.xue@mediatek.com> wrote:
> 
> > Add acpi support in the common part of pinctrl driver. Parsing
> > hardware base addresses and irq number to initialize eint
> > accroding to the acpi table data.
> >
> > Signed-off-by: Lei Xue <lei.xue@mediatek.com>
> 
> I'd ideally like Andy and the ARM64 ACPI maintainers look on
> this. (Added to To:) and CC linux-acpi@vger.kernel.org.
> 
> I'm not aware of the best way to deal with ACPI in combined drivers
> but things like this:
> 
> > -               hw->base[i] = devm_platform_ioremap_resource_byname(pdev,
> > -                                       hw->soc->base_names[i]);
> > +               hw->base[i] = is_of_node(fwnode)
> > +                       ? devm_platform_ioremap_resource_byname(pdev, hw->soc->base_names[i])
> > +                       : devm_platform_get_and_ioremap_resource(pdev, i, NULL);
> 
> Just look really quirky, I think there are better ways to go about
> this and sometimes the ACPI maintainers give some good
> pushback about the firmware as well.

How are pdev->resource initialized ? For OF I suppose the names come from
"reg-names" (that don't exist in ACPI, yet), for ACPI I assume they come
from a _CRS (and you can't tag them by name for the reason above) ?

I assume that in ACPI the _CRS resource order is foolproof against the
variaty of SOCs this code has to deal with.

I also assume/hope that we don't want to add a "reg-names" _DSD property either
in ACPI to deal with this seamlessly in DT/ACPI (that was done for
"interrupt-names"):

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/firmware-guide/acpi/enumeration.rst?h=v6.18-rc7#n188

I am sorry I have got more questions than answers here - it would be good
to understand where the line is drawn when it comes to OF/ACPI and fwnode
heuristics compatibility.

Thanks,
Lorenzo

