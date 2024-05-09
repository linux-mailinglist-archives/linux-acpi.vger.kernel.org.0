Return-Path: <linux-acpi+bounces-5696-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 762BF8C11F6
	for <lists+linux-acpi@lfdr.de>; Thu,  9 May 2024 17:27:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 329C7281218
	for <lists+linux-acpi@lfdr.de>; Thu,  9 May 2024 15:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3A3416F0E0;
	Thu,  9 May 2024 15:27:33 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF8A116F0E3;
	Thu,  9 May 2024 15:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715268453; cv=none; b=KggptflW8v04w3XhFaRgdRilLsPUdnPJiSJzRTjgMxLexqPWs5tOVc4Tv+DcIGAkAd5bggeIIKpUzwi0pUdvPWlVb5H/uNau1hd114FMY5pW445fO/LDX+atYimLr7iDXLrn+XxYefXQir+bB6xSHOaM1LUdGFcOqO+RlKyx1Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715268453; c=relaxed/simple;
	bh=QYn96/erChYTP+1PKVNf3SdpeYI0voDpHb/wAXwg5mc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ONS+Mg9fGFxeCi3mh4GEKROJ7ElFwR5rhix07jCVl1piEaczxGhADOE5FQjq73ibnWYUdKZrjU2HAGKcdIHg0GMaKfxtBIMJ5zAHLr+s67a+dFWcdw7WucGk0aPu5dktTCJNZxJ3Bc2n8oteWreo7f1lVloFyUl+Try18WV6Iac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 62329106F;
	Thu,  9 May 2024 08:27:56 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AE4E03F641;
	Thu,  9 May 2024 08:27:28 -0700 (PDT)
Date: Thu, 9 May 2024 16:27:26 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Yunhui Cui <cuiyunhui@bytedance.com>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, paul.walmsley@sifive.com,
	palmer@dabbelt.com, sunilvl@ventanamicro.com, aou@eecs.berkeley.edu,
	linux-riscv@lists.infradead.org, bhelgaas@google.com,
	james.morse@arm.com, jhugo@codeaurora.org, jeremy.linton@arm.com,
	john.garry@huawei.com, Jonathan.Cameron@huawei.com,
	pierre.gondois@arm.com, tiantao6@huawei.com,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v5 2/3] riscv: cacheinfo: initialize cacheinfo's level
 and type from ACPI PPTT
Message-ID: <ZjzrXnOc5AAost4O@bogus>
References: <20240509073300.4968-1-cuiyunhui@bytedance.com>
 <20240509073300.4968-2-cuiyunhui@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240509073300.4968-2-cuiyunhui@bytedance.com>

On Thu, May 09, 2024 at 03:32:59PM +0800, Yunhui Cui wrote:
> Before cacheinfo can be built correctly, we need to initialize level
> and type. Since RISC-V currently does not have a register group that
> describes cache-related attributes like ARM64, we cannot obtain them
> directly, so now we obtain cache leaves from the ACPI PPTT table
> (acpi_get_cache_info()) and set the cache type through split_levels.
> 
> Suggested-by: Jeremy Linton <jeremy.linton@arm.com>
> Suggested-by: Sudeep Holla <sudeep.holla@arm.com>

I am not sure why you have not added my reviewed-by as I was happy with
v3 onwards IIRC. Anyways, I will give it again 😄

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep

