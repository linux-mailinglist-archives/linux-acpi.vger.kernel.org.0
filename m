Return-Path: <linux-acpi+bounces-6598-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 83646915141
	for <lists+linux-acpi@lfdr.de>; Mon, 24 Jun 2024 17:02:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2749B2490F
	for <lists+linux-acpi@lfdr.de>; Mon, 24 Jun 2024 15:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72FAB19ADB3;
	Mon, 24 Jun 2024 15:02:25 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6CA319ADA6;
	Mon, 24 Jun 2024 15:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719241345; cv=none; b=JLMmXC9QqUdh3TNBiQqx1yR6fp9dyuUKKes6+QuuYEKXRS3t+1r/5p9hcH0/pfM76rMYANYbGaWMadrvzJXg/iqvvQIOtqi7TTjsUI/afzxE0lPVUl3cW96/dYy9RU269Vig+q+MgavhhGQd48CB7BO0yuzJ5xpPKoHtpSNjI1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719241345; c=relaxed/simple;
	bh=7/n0M37UbHanag3ZtvhTAiruyypQB04RHFuFUP75xTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TRh7LdyPWu3q4iwCFaP3aVX6Qedv9wsSpufL1cAETH7wMibxrctYJUnSlsVN7XPvO2Gkk+IwmaT4FM79yirrPCekOz/BWhfpIhQK2mUiyrl2kRO9E6D5kGwLl2l8x3TYSHYMFnASE7MMwjBfBmG5smv7m2b/AYw/gQT9stfjzbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C821DDA7;
	Mon, 24 Jun 2024 08:02:46 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3A8243F73B;
	Mon, 24 Jun 2024 08:02:20 -0700 (PDT)
Date: Mon, 24 Jun 2024 16:02:17 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Youwan Wang <youwan@nfschina.com>, catalin.marinas@arm.com
Cc: guohanjun@huawei.com, lenb@kernel.org, linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	lpieralisi@kernel.org, rafael@kernel.org, will@kernel.org,
	Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v4] ACPI / amba: Drop unnecessary check for registered
 amba_dummy_clk
Message-ID: <ZnmKebiTxIbZHfSf@bogus>
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

Hi Catalin,

Can you please pick up this simple cleanup patch under ACPI changes ?
It is very hard to follow the versions as it is messed up, but this
version is good to take though.

--
Regards,
Sudeep

