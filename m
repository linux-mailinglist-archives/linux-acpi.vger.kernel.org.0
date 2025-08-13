Return-Path: <linux-acpi+bounces-15632-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A36BB247C1
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Aug 2025 12:56:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6439C1AA7FDE
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Aug 2025 10:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AADD62F5322;
	Wed, 13 Aug 2025 10:55:56 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA45221277;
	Wed, 13 Aug 2025 10:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755082556; cv=none; b=PYG2l/cUyI+JC4SAlD9pnFoslg7/07KyBVa59nPbgAWqhIIx3EyxvIWY0g5dDTfuoNiAZvsXoITVcpcaqPreJ/ZVWvscjbRntpJrgszbNuVXnoQDrPJV4RgeAmbRlELneQnFV2hF3KSty5i8TLmQqdZygIK/L1ikPZ8SUmwSeKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755082556; c=relaxed/simple;
	bh=aAOWSyLd3a+OefNauWnbfg+j1F9KxO967PQXIBalszw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gHfR+uPMMP5D1kFKvV0PXc8LLFPsCk6SEGIeWKbVKwpePpcmCH84yCrnvixpA7S+mBOsuWD6DQvMZzSSZZv+CziHIThfuEvzRM1fgt9JbGKD65FaHNwOrSuyDNWiOjA0xVhBCwOB73vY1eGd1H0N+9a21p9fwaeoR6p7Rk5/lt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com; spf=none smtp.mailfrom=foss.arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=foss.arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9F78512FC;
	Wed, 13 Aug 2025 03:55:45 -0700 (PDT)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BE9C03F63F;
	Wed, 13 Aug 2025 03:55:51 -0700 (PDT)
Date: Wed, 13 Aug 2025 11:55:48 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Marc Zyngier <maz@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Sudeep Holla <sudeep.holla@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Alexandru Elisei <alexandru.elisei@arm.com>,
	Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 0/4] clocksource: Add standalone MMIO ARM arch timer
 driver
Message-ID: <20250813-macho-snobbish-alpaca-ff07fa@sudeepholla>
References: <20250807160243.1970533-1-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250807160243.1970533-1-maz@kernel.org>

+Alexandru

On Thu, Aug 07, 2025 at 05:02:39PM +0100, Marc Zyngier wrote:
> For the past 10 years, both Mark and I have been lamenting about the
> sorry state of the badly named "arch_timer" driver, and about the way
> the MMIO part is intricately weaved into the system-register part.
> 
> The time has finally come to have a stab at it.
> 
> This small series simply creates a new timer driver for the MMIO arch
> timer, and only that. It is an actual driver, and not some kludge that
> has to run super early (that's what the per-CPU timers are for). This
> allows, in turn, a pretty large cleanup of the per-CPU driver, though
> there is more to come -- one thing at a time.
> 
> As an added bonus, we get a clocksource, which the original code
> didn't provide. Just in case it might be useful. The end-result is far
> more readable, and about 100 lines smaller.
> 

(Tested it on Juno R2 and FVP in both DT and ACPI boot)

Tested-by: Sudeep Holla <sudeep.holla@arm.com>
Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

Alexandru found it useful(avoids some unexpected hang IIUC) in his setup
based on bootwrapper which doesn't initialise MMIO timers.

-- 
Regards,
Sudeep

