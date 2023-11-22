Return-Path: <linux-acpi+bounces-1747-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6289E7F4D13
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Nov 2023 17:45:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C1EA1F21B22
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Nov 2023 16:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E4171A5B1
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Nov 2023 16:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tQN/Apdw"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E75F4AF9E;
	Wed, 22 Nov 2023 14:44:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FAC0C433C7;
	Wed, 22 Nov 2023 14:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700664295;
	bh=h5w3izkPOTDID1ezFWef52/xpayVyQG+sKxK2opBXic=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tQN/ApdwId0YZXaPIOrYdYglm5uofDpV92WPDX9Oea02vjC+1xvKsc0ECsUP2pSb/
	 q7ugkyRzFQ8Hij4vHm/bfs6SZ/og9LQjuGE6TFB2rHqbR4eCv4p49bbrwEr5RJjsPl
	 TEzrcBuanxqqk4aZPZ/FHbiAwDl87d2tZMcc0XtU=
Date: Wed, 22 Nov 2023 14:44:53 +0000
From: Greg KH <gregkh@linuxfoundation.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org, will@kernel.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, rafael@kernel.org, lenb@kernel.org,
	lpieralisi@kernel.org, andre.draszik@linaro.org,
	quic_zhenhuah@quicinc.com
Subject: Re: [PATCH] iommu: Avoid more races around device probe
Message-ID: <2023112238-sierra-chewable-86fc@gregkh>
References: <16f433658661d7cadfea51e7c65da95826112a2b.1700071477.git.robin.murphy@arm.com>
 <ZVZL9kZuVsb9VPnM@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZVZL9kZuVsb9VPnM@nvidia.com>

On Thu, Nov 16, 2023 at 01:05:58PM -0400, Jason Gunthorpe wrote:
> On Wed, Nov 15, 2023 at 06:25:44PM +0000, Robin Murphy wrote:
> > It turns out there are more subtle races beyond just the main part of
> > __iommu_probe_device() itself running in parallel - the dev_iommu_free()
> > on the way out of an unsuccessful probe can still manage to trip up
> > concurrent accesses to a device's fwspec. Thus, extend the scope of
> > iommu_probe_device_lock() to also serialise fwspec creation and initial
> > retrieval.
> > 
> > Reported-by: Zhenhua Huang <quic_zhenhuah@quicinc.com>
> > Link: https://lore.kernel.org/linux-iommu/e2e20e1c-6450-4ac5-9804-b0000acdf7de@quicinc.com/
> > Fixes: 01657bc14a39 ("iommu: Avoid races around device probe")
> > Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> > ---
> > 
> > This is my idea of a viable fix, since it does not need a 700-line
> > diffstat to make the code do what it was already *trying* to do anyway.
> > This stuff should fundamentally not be hanging off driver probe in the
> > first place, so I'd rather get on with removing the underlying
> > brokenness than waste time and effort polishing it any further.
> 
> I'm fine with this as some hacky backport, but I don't want to see
> this cross-layer leakage left in the next merge window.
> 
> ie we should still do my other series on top of and reverting this.
> 
> I've poked at moving parts of it under probe and I think we can do
> substantial amounts in about two more series and a tidy a bunch of
> other stuff too.

I agree, it's messy and acpi should not need this, BUT at the moment, I
can't see any other way to resolve this simply.

So here's a begrudged ack:

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

and hopefully the larger series should resolve this correctly?  Can that
be rebased on top of this?

Also, cc: stable on this for whomever applies it?

thanks,

greg k-h

