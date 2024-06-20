Return-Path: <linux-acpi+bounces-6543-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7869090FF0A
	for <lists+linux-acpi@lfdr.de>; Thu, 20 Jun 2024 10:38:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DBAEAB2436C
	for <lists+linux-acpi@lfdr.de>; Thu, 20 Jun 2024 08:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2538C19AD86;
	Thu, 20 Jun 2024 08:38:25 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 694DB19AD65;
	Thu, 20 Jun 2024 08:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718872705; cv=none; b=VQwRxKrLkl43wEpaNGGwuK+weCe2i5dy+/HcZwpRXWKsR/IWHQ8atsVR6/hO5y5WKq1AfQrszOomF4orJagplpJM9RPq0HL5z9pWN/EtDz+MYYkrpKtkwgVjJlPJILQur+KUoyjwT4+1ISIPb/Z45nGDhE5FdEO4GhRMNh7ejxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718872705; c=relaxed/simple;
	bh=jyxdmHjbgR8ugohaJv2Qwu3u2SiMkizlUi4UbwBSWyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d25NG0QRGK7G9TJRemucf5wRHtfYrRcrK73iZIdX1SnJ0bHLkNcSl3ZIMdfjxYMIhmHJdvrIoyQi/R0BUndWbNRMZxP2Y9XWTjBvw0SsrguBDIK2aJhPP/F/smOWppn2oS7uVH1Cf4oo5SGeHKyW2xMgiwBH57vijMF0V7VPcWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5B7ABDA7;
	Thu, 20 Jun 2024 01:38:47 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 504E83F64C;
	Thu, 20 Jun 2024 01:38:21 -0700 (PDT)
Date: Thu, 20 Jun 2024 09:38:18 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Youwan Wang <youwan@nfschina.com>
Cc: lpieralisi@kernel.org, guohanjun@huawei.com,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	lenb@kernel.org, rafael@kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH] ACPI / amba: Drop unnecessary check for registered
 amba_dummy_clk
Message-ID: <ZnPqeniNlw74MW-S@bogus>
References: <20240620005930.295880-1-youwan@nfschina.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240620005930.295880-1-youwan@nfschina.com>

On Thu, Jun 20, 2024 at 08:59:30AM +0800, Youwan Wang wrote:
> amba_register_dummy_clk() is called only once from acpi_amba_init()
> and acpi_amba_init() itself is called once during the initialisation.
> amba_dummy_clk can't be initialised before this in any other code
> path and hence the check for already registered amba_dummy_clk is
> not necessary. Drop the same.
>

You are not reading my response correctly and fixing all the issues.

1. You had v3 and now this is again v1 ? Perhaps v4 ?
2. You missed to add my Acked-by which I gave to your v2
3. This is v4 and new reviewers of this patch have absolutely no idea
   what got changed from v1->v2->v3->v4. It is always good to add change
   log describing what changed across these versions
4. I asked you to add ARM64 maintainers as we would request them to pick
   this up via ARM64 tree.
	Catalin Marinas <catalin.marinas@arm.com
	Will Deacon <will@kernel.org>

I will ignore your patches if these are not fixed, I have told you same
thing twice now.

--
Regards,
Sudeep

