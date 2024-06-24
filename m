Return-Path: <linux-acpi+bounces-6597-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 341AA915100
	for <lists+linux-acpi@lfdr.de>; Mon, 24 Jun 2024 16:55:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83BE8B23D30
	for <lists+linux-acpi@lfdr.de>; Mon, 24 Jun 2024 14:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B501F19DF99;
	Mon, 24 Jun 2024 14:48:51 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1F7819B5B0;
	Mon, 24 Jun 2024 14:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719240531; cv=none; b=Z9fosUGIaYKiuiee9l4a7XEeU7JNf5k9OKuL/Jmri+LhZSiRWJCUBuCWPFv6R+YIr2dSaNY/EekrApAhNKzXoefeU/JFXvuNGtIl9U3PVtsgWimPWGw5BEfzVwrGlQDPyVnNTwjkN/Y5P02NgRAhilICRm9kYDI4ZSND4bkK+mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719240531; c=relaxed/simple;
	bh=4/dgeUPK7JV/t7zHVj1dhDdp+7TjPbrs4jAQPOfn2Hw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AVAa81p+7mHp1Nt5hGVJEI0thgifB19jDOG+Ulwx7ON877jRHmZF354IjyWjunnzxNBHbxrT5t3EKpEW+yU4yYyP4djrw36aIG4Cx5nARsfA2PFQ9SFFvojWfH5qtBaH3L08bZpG2Jjvin+ke7sxVqgxFWarE+blyhVvK6HLuw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 59A2BDA7;
	Mon, 24 Jun 2024 07:49:07 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C26CE3F73B;
	Mon, 24 Jun 2024 07:48:40 -0700 (PDT)
Date: Mon, 24 Jun 2024 15:48:38 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Youwan Wang <youwan@nfschina.com>
Cc: guohanjun@huawei.com, lenb@kernel.org, linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	lpieralisi@kernel.org, rafael@kernel.org, catalin.marinas@arm.com,
	will@kernel.org, Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v4] ACPI / amba: Drop unnecessary check for registered
 amba_dummy_clk
Message-ID: <ZnmHRgnwNUsQidWj@bogus>
References: <20240620133758.319392-1-youwan@nfschina.com>
 <20240624023101.369633-1-youwan@nfschina.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240624023101.369633-1-youwan@nfschina.com>

On Mon, Jun 24, 2024 at 10:31:01AM +0800, Youwan Wang wrote:
> amba_register_dummy_clk() is called only once from acpi_amba_init()
> and acpi_amba_init() itself is called once during the initialisation.
> amba_dummy_clk can't be initialised before this in any other code
> path and hence the check for already registered amba_dummy_clk is
> not necessary. Drop the same.
> 
> Signed-off-by: Youwan Wang <youwan@nfschina.com>
> Acked-by: Sudeep Holla <sudeep.holla@arm.com>
> Acked-by: Hanjun Guo <guohanjun@huawei.com>
> ---
> v1->v2->v3: Modify the commit log description
> v3->v4: Update the commit message suggested by Sudeep;
>         Add Acked-by from Sudeep;
>         +Cc ARM64 maintainers Catalin and Will.


I think I have told you many time now and you are missing to understand
few basic stuff. So I suggest to give
`Documentation/process/submitting-patches.rst`
under the kernel source a read and especially the section
`The canonical patch format`

Ideally this patch should have been v5 as you added Hanjun's Ack
Also "v1->v2->v3: Modify the commit log description" makes no sense.

The changelog should list all the deltas like:
v4->v5:
	- <blah3 blah3>
v3->v4:
	- <blah2 blah2>
v2->v3:
	- <blah1 blah1>
v1->v2:
	- <blah blah>

Anyways, it is only for your learning and future references.

--
Regards,
Sudeep

