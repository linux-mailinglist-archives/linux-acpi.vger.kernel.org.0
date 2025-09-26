Return-Path: <linux-acpi+bounces-17341-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85118BA360F
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Sep 2025 12:38:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 458A53A6678
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Sep 2025 10:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33E3727A47F;
	Fri, 26 Sep 2025 10:38:38 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48CBB2F2913;
	Fri, 26 Sep 2025 10:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758883118; cv=none; b=NqxJHXJbbWTapEFGA39mPMPL84q3X6nhGN1rHU7NHVy3UME7oORdtDeoKgmAKEhRpHPC/b7fovP2HnTtB/CzS2oBzNLXVqRVcQgxsRWBicgZn6XuStk3AijrthiN5lw7g0fLUaYAohRXShF77KDsq4BAuPmnMK3LBDlokFOWR6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758883118; c=relaxed/simple;
	bh=YDS4s5RkJHdkLKbCqClrPdikIVhL3WpPUyoR1o2gSvo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lm+E6GF7HzKXxdTv0YHmKmR//6+AFYAvvxjGubc4Bok0ZqeuCFYMddQtO8pzyJTNVZpR1iuLcYIdn+0NND/I1g9dM0iRT+23s89qC+DiR3GKH1s3bvsmbw2r5Ixre03gYO8ApjsoCO42ZuGvOFUwb99dCPs1tpKCahuknTe+Dpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3C746168F;
	Fri, 26 Sep 2025 03:38:27 -0700 (PDT)
Received: from raptor (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F14293F5A1;
	Fri, 26 Sep 2025 03:38:32 -0700 (PDT)
Date: Fri, 26 Sep 2025 11:38:30 +0100
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: Marc Zyngier <maz@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-acpi@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	James Clark <james.clark@linaro.org>,
	Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: Re: [PATCH v3 00/26] genirq: Add support for percpu_devid IRQ
 affinity
Message-ID: <aNZtJoFrOv8dHlkV@raptor>
References: <20250922082833.2038905-1-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250922082833.2038905-1-maz@kernel.org>

Hi,

Tested this on a rockpro64 - 4xA53 + 2xA72.

On kernel v6.17-rc5, using perf to profile iperf3 for 10 seconds, the top
overhead symbol was _raw_spinlock_irq_restore() and the PMU wasn't using NMIs
(checked by printing has_nmi after armpmu_request_irq()).

With this series, same test, *irq_restore() overhead dropped to about 1% on the
little core, below 1% on the big core, and the PMU was using NMIs.

Thanks,
Alex

On Mon, Sep 22, 2025 at 09:28:07AM +0100, Marc Zyngier wrote:
> This is the third version of this series, originally posted at [1],
> which aims at allowing percpu_devid interrupt requests on the basis of
> an affinity mask. See the original submission for the details of why
> this is a desirable outcome.
> 
> From v2, we have some tidying up, thanks to Jonathan's review -- see
> changelog for details.
> 
> FWIW, I've pushed a branch at [3].
> 
> * From v2 [2]:
> 
>   - Turned of_node_to_fwnode() usage to of_fwnode_handle() (Jonathan)
> 
>   - Added a patch to finally kill of_node_to_fwnode()
> 
>   - Tidied-up documentation, comments and formatting (Jonathan)
> 
>   - Collected ABs and Rbs, with thanks (Jonathan, Suzuki, Sven)
> 
> * From v1 [1]:
> 
>   - Fixed NMI handling by getting rid of the NMI-specific flow
>     handler, which was pretty useless anyway (Will)
> 
>   - As a result, killed a metric buttload worth of GICv3 code
> 
>   - Moved irq_fwspec out of irq_fwspec_info, and passed it as a
>     parameter to irq_get_fwspec_info(), renamed from irq_get_info(),
>     and applied some generous sanitisation of the structure (Thomas)
> 
>   - Dropped the rather useless fwspec validity flag (Thomas)
> 
>   - Rejigged the PMU per-CPU handling to better deal with the DT/ACPI
>     differences, and drop some now useless patches (Will)
> 
>   - Plenty of cosmetic rework (Raphael, Thomas)
> 
> [1] https://lore.kernel.org/r/20250908163127.2462948-1-maz@kernel.org
> [2] https://lore.kernel.org/r/20250915085702.519996-1-maz@kernel.org
> [3] git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git irq/ppi-affinity

