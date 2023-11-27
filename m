Return-Path: <linux-acpi+bounces-1832-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96A9F7F9DA5
	for <lists+linux-acpi@lfdr.de>; Mon, 27 Nov 2023 11:36:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1AC9EB20DD5
	for <lists+linux-acpi@lfdr.de>; Mon, 27 Nov 2023 10:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A14B18C15
	for <lists+linux-acpi@lfdr.de>; Mon, 27 Nov 2023 10:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="Zz3X/iBi"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail.8bytes.org (mail.8bytes.org [IPv6:2a01:238:42d9:3f00:e505:6202:4f0c:f051])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id D4004F0;
	Mon, 27 Nov 2023 01:57:10 -0800 (PST)
Received: from 8bytes.org (p4ffe1e67.dip0.t-ipconnect.de [79.254.30.103])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 2BC441A4799;
	Mon, 27 Nov 2023 10:57:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1701079029;
	bh=CHHOkEMTPlg6Xp1XqOEpVungIbDgk3x5eaYRFc6OMvA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Zz3X/iBiBVM3gKoGzcPRKsUrKzGKvDDxddIItBGIrI9aqPyU/yKP2kaAn5hQux0XS
	 JrGbXWO93UFSecEJJPItKQCoLPlqLJKODxmzQq2CxV0v5EB+UMbDItB/LOuFI1M9ib
	 z+Gi8Z2yssva5mirEt3Hj9QyfmvAxPMoPvl3swdWsmpi9h6A7qY3fXWvBIOVpb+HTX
	 r95P85qXK0wfnz2uG+IFAsmHPCYNs/7j/sHzCAHsd8rv35jiZbiFp+3nYeQIcn670e
	 bZm8zYouky0yAKTY4eTcWL+se5W9w03k9+hGmn+QElmPFJ6NYMKymmQztvlugfbQ6J
	 fwBa0QYmVCNag==
Date: Mon, 27 Nov 2023 10:57:08 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Robin Murphy <robin.murphy@arm.com>, will@kernel.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, rafael@kernel.org, lenb@kernel.org,
	lpieralisi@kernel.org, andre.draszik@linaro.org,
	quic_zhenhuah@quicinc.com
Subject: Re: [PATCH] iommu: Avoid more races around device probe
Message-ID: <ZWRn9G2Fzyibzn0X@8bytes.org>
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
> I'm fine with this as some hacky backport, but I don't want to see
> this cross-layer leakage left in the next merge window.
> 
> ie we should still do my other series on top of and reverting this.
> 
> I've poked at moving parts of it under probe and I think we can do
> substantial amounts in about two more series and a tidy a bunch of
> other stuff too.

Applied this for v6.7. Before I am going to apply any series on-top I
want to see you and Robin agree on a general direction for this moving
forward.

Regards,

	Joerg

