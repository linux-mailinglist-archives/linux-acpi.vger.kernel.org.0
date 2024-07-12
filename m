Return-Path: <linux-acpi+bounces-6874-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3363A92FD88
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Jul 2024 17:27:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B2931C2381E
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Jul 2024 15:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E16CE1741EA;
	Fri, 12 Jul 2024 15:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f47l6tyO"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0791741E3;
	Fri, 12 Jul 2024 15:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720798015; cv=none; b=WoGyNXmaPP5Zg1pRFU22UR12YwV7hItfybXbRM70Kf6B+gvHBCR0wCLihd73ULMS1+O/O+L2peOu0xkUbh5iHIwgJYFdaXiioKsZy1mYIdNGVWXwaL6ZZdYm1ehU6Nm7pxy9uRtPTIXMuV+fTjdOD3DhhYx8Aa/8Os+eXDxV/c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720798015; c=relaxed/simple;
	bh=LW8POJE80nNCIpTSXQaoVXIVEDk5dceoKuSUVxEF+K8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SWjpOCIRC6jrMHDSwen7o9Du8nlHqy68v24JygpPWDV+SBddWJWvumVXqhT3Q48DQyGNXcVvop4voBVutVxGi2FKBvUIru1vXiLaF+P/w7VgXzoDrVySKkC9qUpw03icreRjP7JTzqH77M/SAJdhpIe40GdEtQDO7Dfh2ygkeEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f47l6tyO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22298C32782;
	Fri, 12 Jul 2024 15:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720798015;
	bh=LW8POJE80nNCIpTSXQaoVXIVEDk5dceoKuSUVxEF+K8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f47l6tyOCFs9Co7u1Dm/Hy9msa9L6eZRxZxd3I9AF3CyyTFx8r5RVebrVAOl7PG2a
	 Wj0WJJB9bIDDb783QoZjqEL9+FXil26hz2IddeQhxS8hz61RZWHeJPo6maNCnZ9RIu
	 MQ7Jbf1REHqTLd8wL1ClapwkWJGVagxa5HxOo2kPAkQxDajELOoJCOULJ2AQZw3Ry/
	 s5fw3Eu9EPHYlBlGzYZq/NsPv2JC+hxsltwT5ypGfyfP7tM+V3PbjlEerJIX91/X69
	 H65+qv6cgobgUKd9PV4K4CkRlzbVYovZge8k254la0T1XOfLjx1KW6rZZm7qLExJeU
	 IMR8UKaGcGhkA==
Date: Fri, 12 Jul 2024 16:26:48 +0100
From: Will Deacon <will@kernel.org>
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
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
Message-ID: <20240712152648.GB16474@willie-the-truck>
References: <cover.1719919669.git.robin.murphy@arm.com>
 <0e2727adeb8cd73274425322f2f793561bdc927e.1719919669.git.robin.murphy@arm.com>
 <0eec5f84-6b39-43ba-ab2f-914688a5cf45@nvidia.com>
 <01c05fb2-16ce-450c-befb-8a92ac2a8af9@arm.com>
 <ee24cb5f-d170-41d3-9928-5507b8ab22a7@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ee24cb5f-d170-41d3-9928-5507b8ab22a7@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Fri, Jul 12, 2024 at 04:24:48PM +0100, Jon Hunter wrote:
> 
> On 12/07/2024 12:48, Robin Murphy wrote:
> 
> ...
> 
> > > I am seeing some failures on -next with some of our devices. Bisect
> > > is pointing to this commit. Looks like the host1x device is no
> > > longer probing successfully. I see the following ...
> > > 
> > >   tegra-host1x 50000000.host1x: failed to initialize fwspec: -517
> > >   nouveau 57000000.gpu: failed to initialize fwspec: -517
> > > 
> > > The probe seems to be deferred forever. The above is seen on
> > > Tegra210 but Tegra30 and Tegra194 are also having the same problem.
> > > Interestingly it is not all devices and so make me wonder if we are
> > > missing something on these devices? Let me know if you have any
> > > thoughts.
> > 
> > Ugh, tegra-smmu has been doing a complete nonsense this whole time - on
> > closer inspection, it's passing the fwnode of the *client device* where
> > it should be that of the IOMMU device :(
> > 
> > I *think* it should probably just be a case of:
> > 
> > -    err = iommu_fwspec_init(dev, of_fwnode_handle(dev->of_node));
> > +    err = iommu_fwspec_init(dev, of_fwnode_handle(smmu->dev->of_node));
> > 
> > since smmu->dev appears to be the same one initially passed to
> > iommu_device_register(), so it at least ought to match and work, but the
> > SMMU device vs. MC device thing leaves me mildly wary of how correct it
> > might be overall.
> > 
> > (Also now I'm wondering why I didn't just use dev_fwnode() there...)
> 
> 
> Yes making that change in the tegra-smmu driver does fix it.

Fantastic! I'll pick it up right now.

Cheers,

Will

