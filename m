Return-Path: <linux-acpi+bounces-6876-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B45E92FDA0
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Jul 2024 17:31:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7ABA1F25272
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Jul 2024 15:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18E5B171E53;
	Fri, 12 Jul 2024 15:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pOJII4t+"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC6F5256;
	Fri, 12 Jul 2024 15:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720798305; cv=none; b=CAFc3Ti6MWodqjzlootOJU8Z5ybGffOGj99Uh2Y4PrMkQUsUqJLmVVK4TEDOdIyZlFbQkfPdoc9ybohF67WEc7dA43TBNZvVlAIpP8Vr01tsqcIPmdh8nbYskXDyctjMLkUQ3RJyn2PnDfrnkQa4+lywxUv6tvmVHmYN6gNN4rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720798305; c=relaxed/simple;
	bh=LRIkw/BD/2bNKPTenaVDfImH7SQgH4W77dv2MrBSNeA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DaX1DycmdwjTUNLleZqB9e9jZWNcmnZn83pMn3Cra/t6BMTF0uk8rvKKtkfIGknCnpCWmv/nSiNy77OPZ1Jma/GkPluKWz0f68JmskveXNq+1XW7qyyI7YVMFw+gMtc/h7+shYEjkYNajg48kZxkXetIJAOSY8n0JkQzaVcnFLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pOJII4t+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2705DC32782;
	Fri, 12 Jul 2024 15:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720798304;
	bh=LRIkw/BD/2bNKPTenaVDfImH7SQgH4W77dv2MrBSNeA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pOJII4t+nzeUYk/FDfYFaC8VCyuM8gYvhGilJncEL8JtJkWXM6myojtFCMEP3Hb8n
	 Kc/QU2x200MvaCRwdHHIb8atLTYMulbj376mWD/yCkEiaSTgY43ZRlHUrU+10WRNC9
	 rTx2RLItwbOhPLessYmbRBFlrTAX+5dZfVLcE30wBRRCpge8DPVrwqEmQiXRTU3U2y
	 wcUM6KG7DckJzr5/TbAfI7ELhT8MvfZpAdYBhAz5o/oKtJfURDCvbHEEfauIpIGQVd
	 qg5DULx27TrtvnqHceCFoaJuExYKFyo2bgA3Ypm6M0EBcQhnrMFTtz/zZw0AieFyjg
	 LhwXuHo8O1KSQ==
Date: Fri, 12 Jul 2024 16:31:38 +0100
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
Message-ID: <20240712153137.GC16474@willie-the-truck>
References: <cover.1719919669.git.robin.murphy@arm.com>
 <0e2727adeb8cd73274425322f2f793561bdc927e.1719919669.git.robin.murphy@arm.com>
 <0eec5f84-6b39-43ba-ab2f-914688a5cf45@nvidia.com>
 <01c05fb2-16ce-450c-befb-8a92ac2a8af9@arm.com>
 <ee24cb5f-d170-41d3-9928-5507b8ab22a7@nvidia.com>
 <82624cf6-98ad-47df-8dcd-368117600805@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <82624cf6-98ad-47df-8dcd-368117600805@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Fri, Jul 12, 2024 at 04:28:37PM +0100, Robin Murphy wrote:
> On 12/07/2024 4:24 pm, Jon Hunter wrote:
> > 
> > On 12/07/2024 12:48, Robin Murphy wrote:
> > 
> > ...
> > 
> > > > I am seeing some failures on -next with some of our devices.
> > > > Bisect is pointing to this commit. Looks like the host1x device
> > > > is no longer probing successfully. I see the following ...
> > > > 
> > > >   tegra-host1x 50000000.host1x: failed to initialize fwspec: -517
> > > >   nouveau 57000000.gpu: failed to initialize fwspec: -517
> > > > 
> > > > The probe seems to be deferred forever. The above is seen on
> > > > Tegra210 but Tegra30 and Tegra194 are also having the same
> > > > problem. Interestingly it is not all devices and so make me
> > > > wonder if we are missing something on these devices? Let me know
> > > > if you have any thoughts.
> > > 
> > > Ugh, tegra-smmu has been doing a complete nonsense this whole time -
> > > on closer inspection, it's passing the fwnode of the *client device*
> > > where it should be that of the IOMMU device :(
> > > 
> > > I *think* it should probably just be a case of:
> > > 
> > > -    err = iommu_fwspec_init(dev, of_fwnode_handle(dev->of_node));
> > > +    err = iommu_fwspec_init(dev, of_fwnode_handle(smmu->dev->of_node));
> > > 
> > > since smmu->dev appears to be the same one initially passed to
> > > iommu_device_register(), so it at least ought to match and work, but
> > > the SMMU device vs. MC device thing leaves me mildly wary of how
> > > correct it might be overall.
> > > 
> > > (Also now I'm wondering why I didn't just use dev_fwnode() there...)
> > 
> > 
> > Yes making that change in the tegra-smmu driver does fix it.
> 
> Ace, thanks for confirming! I was just writing a follow-up to say that I've
> pretty much convinced myself that this (proper diff below) should in fact be
> the right thing to do in general as well :)
> 
> Will, Joerg, would you prefer to have a standalone fix patch for the
> nvidia/tegra branch to then re-merge fwspec-ops-removal and fix up the
> conflict, or just a patch on top of fwspec-ops-removal as below?

I've just fixed it locally on the tegra branch, so I'll then just
resolve the conflict with fwspec-ops-removal the right way. That way, we
can backport the thing if we need to.

Cheers,

Will

