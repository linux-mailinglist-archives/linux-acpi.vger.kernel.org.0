Return-Path: <linux-acpi+bounces-5223-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46A4A8AC38E
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Apr 2024 07:01:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 021182817B3
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Apr 2024 05:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27FF8168BD;
	Mon, 22 Apr 2024 05:01:32 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from fgw22-7.mail.saunalahti.fi (fgw22-7.mail.saunalahti.fi [62.142.5.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD0314A81
	for <linux-acpi@vger.kernel.org>; Mon, 22 Apr 2024 05:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713762092; cv=none; b=LlFkj0NJoUjxzvWXnA86piPW8zb4ezs97eElsmfR2mDNhnsDCluyXJtOmOin5zthLvY/g4+WGCmGXWtrEMdw6t2gSfognx26AyShMDeDhShFYkF3yXUvlqQ7C0gmT0kjmUHdYucFTIweTdGmcW++zc+OzdgmLuWyvwbpS17pz/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713762092; c=relaxed/simple;
	bh=pA6jdIeParIDDslb0VbpOv9iLNAFp/mbNR9RFF6IuQA=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=umwVDBJ441p8CELULeqwrlBtTtXX5ws8vdkwzFNLQEPaQxWQYbZbL3aLfZF6UXmxHsoa1Ka5DJHYgMWCysD7zkjNY4x/K4MKz/QIqlY1wDBRqBt0SjHFiKTeXVv8MgqYglCmrWy+tCNUiNeSfjA0M/W493ubqdLj45PIg5vqYds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-25-208.elisa-laajakaista.fi [88.113.25.208])
	by fgw21.mail.saunalahti.fi (Halon) with ESMTP
	id 3694bb42-0065-11ef-abf4-005056bdd08f;
	Mon, 22 Apr 2024 08:00:19 +0300 (EEST)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 22 Apr 2024 08:00:17 +0300
To: Robin Murphy <robin.murphy@arm.com>
Cc: Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
	linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH 1/4] iommu: Resolve fwspec ops automatically
Message-ID: <ZiXu4Tk8lDroOKTA@surfacebook.localdomain>
References: <cover.1713523251.git.robin.murphy@arm.com>
 <ad80fed9800194f21c0fc581fec68ca3cfb5dac6.1713523251.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad80fed9800194f21c0fc581fec68ca3cfb5dac6.1713523251.git.robin.murphy@arm.com>

Fri, Apr 19, 2024 at 05:55:59PM +0100, Robin Murphy kirjoitti:
> There's no real need for callers to resolve ops from a fwnode in order
> to then pass both to iommu_fwspec_init() - it's simpler and more sensible
> for that to resolve the ops itself. This in turn means we can centralise
> the notion of checking for a present driver, and enforce that fwspecs
> aren't allocated unless and until we know they will be usable.
> 
> Also we've grown a generic fwnode_handle_get() since this code was first
> written, so may as well clear up that ugly mismatch while we're in here.

...

> +++ b/drivers/iommu/mtk_iommu_v1.c

>  	if (!fwspec) {
> -		ret = iommu_fwspec_init(dev, &args->np->fwnode, &mtk_iommu_v1_ops);
> +		ret = iommu_fwspec_init(dev, &args->np->fwnode);

I'm wondering, while at it, if can avoid direct dereference of fwnode by using of_fwnode_handle().

>  		if (ret)
>  			return ret;

...

> +++ b/drivers/iommu/of_iommu.c

> -	ret = iommu_fwspec_init(dev, fwnode, ops);
> +	ret = iommu_fwspec_init(dev, &iommu_spec->np->fwnode);

Ditto.

> +	if (ret == -EPROBE_DEFER)
> +		return driver_deferred_probe_check_state(dev);
>  	if (ret)
>  		return ret;

...

> --- a/drivers/iommu/tegra-smmu.c
> +++ b/drivers/iommu/tegra-smmu.c

> -	err = iommu_fwspec_init(dev, &dev->of_node->fwnode, ops);
> +	err = iommu_fwspec_init(dev, &dev->of_node->fwnode);

Ditto.

>  	if (err < 0) {
>  		dev_err(dev, "failed to initialize fwspec: %d\n", err);
>  		return err;

-- 
With Best Regards,
Andy Shevchenko



