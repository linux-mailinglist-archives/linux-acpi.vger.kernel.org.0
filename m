Return-Path: <linux-acpi+bounces-6873-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C398F92FD82
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Jul 2024 17:26:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A2391F239E0
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Jul 2024 15:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4F2E173345;
	Fri, 12 Jul 2024 15:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YknbULhx"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5BA172BB9;
	Fri, 12 Jul 2024 15:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720797979; cv=none; b=lMD/GeGhjK4MU4Ii2XHsCDv6IRbIgn+U2VSDFXzcJFWNFSIw0ptttp+fSWsxYJs1yp8te4RdmWXEmHv98D3TAVy/Z2srQab5TwMZ/8eFe9dELs/F+18GAXUaOoEliflDd708K2Wn8/oOAfU97/LodlQGcAtGJd715DLktlWN77M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720797979; c=relaxed/simple;
	bh=8y7K6bnc0wy+XvnY3lIRwJq+zBdXbg30jzZxKtYYGAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ds5bon9z66qhrSxJkRbsBFPRR9CIqDiTCFlWrsp8+qqf/Wf8zmTI+u4nBUT37XlZNgWnWbs2R0Mo+p3C16DQ3ptR4B6vP6DDBkcDUncHnrCahnYh+rCAiompdlqikQxgTDCcJyYQpGbIqn8LnpR9WjkVJOUjY9TXIXXqNKFkxvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YknbULhx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 105E4C32782;
	Fri, 12 Jul 2024 15:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720797979;
	bh=8y7K6bnc0wy+XvnY3lIRwJq+zBdXbg30jzZxKtYYGAM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YknbULhxMSm3hPP99gb5VI1dokKXYba/KyPvUwol2xVaLyVbILvl0lOc9jRo0WO45
	 z16c0gfZRbC001ShDcCLBjaya329FTL/rbPi+5TidLOEwfEyitJl/PVnyaTp+SpiPR
	 i6kIqXBRh2M3LFNiUzUbko+OOneSCfuI75BGIwzCzMC/FQti1wwt8LKsJaDccKT0/P
	 5WSzMfloZZ51tONUKTj/cC61t+4KlAKKJO3F7BNfrw8+JEB/nJnWhYcDe2MKJM5L9C
	 s04cfkqCguV42jM1yxtG1QvO/c7Hv+ZE5BdCaeGjGlVT1MmPPno3TvulYgZezs+H1A
	 i02nCDCsJa+/Q==
Date: Fri, 12 Jul 2024 16:26:12 +0100
From: Will Deacon <will@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Jon Hunter <jonathanh@nvidia.com>, Joerg Roedel <joro@8bytes.org>,
	linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Yong Wu <yong.wu@mediatek.com>,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH v3 2/5] iommu: Resolve fwspec ops automatically
Message-ID: <20240712152612.GA16474@willie-the-truck>
References: <cover.1719919669.git.robin.murphy@arm.com>
 <0e2727adeb8cd73274425322f2f793561bdc927e.1719919669.git.robin.murphy@arm.com>
 <0eec5f84-6b39-43ba-ab2f-914688a5cf45@nvidia.com>
 <01c05fb2-16ce-450c-befb-8a92ac2a8af9@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <01c05fb2-16ce-450c-befb-8a92ac2a8af9@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Fri, Jul 12, 2024 at 12:48:31PM +0100, Robin Murphy wrote:
> On 2024-07-12 12:01 pm, Jon Hunter wrote:
> > I am seeing some failures on -next with some of our devices. Bisect is
> > pointing to this commit. Looks like the host1x device is no longer
> > probing successfully. I see the following ...
> > 
> >   tegra-host1x 50000000.host1x: failed to initialize fwspec: -517
> >   nouveau 57000000.gpu: failed to initialize fwspec: -517
> > 
> > The probe seems to be deferred forever. The above is seen on Tegra210
> > but Tegra30 and Tegra194 are also having the same problem. Interestingly
> > it is not all devices and so make me wonder if we are missing something
> > on these devices? Let me know if you have any thoughts.
> 
> Ugh, tegra-smmu has been doing a complete nonsense this whole time - on
> closer inspection, it's passing the fwnode of the *client device* where it
> should be that of the IOMMU device :(

Ha, so it is!

> I *think* it should probably just be a case of:
> 
> -    err = iommu_fwspec_init(dev, of_fwnode_handle(dev->of_node));
> +    err = iommu_fwspec_init(dev, of_fwnode_handle(smmu->dev->of_node));
> 
> since smmu->dev appears to be the same one initially passed to
> iommu_device_register(), so it at least ought to match and work, but the
> SMMU device vs. MC device thing leaves me mildly wary of how correct it
> might be overall.

Jon -- any chance you could give this fix a go, please? I'm hesitant to
drop the whole branch just for this, but we've basically run out of time
for 6.11 and so knowing we have a working fix would be really helpful.

Cheers,

Will

