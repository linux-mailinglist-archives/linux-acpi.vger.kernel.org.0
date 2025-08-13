Return-Path: <linux-acpi+bounces-15635-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C41F8B2488C
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Aug 2025 13:37:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE6351B6000D
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Aug 2025 11:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 953602F0689;
	Wed, 13 Aug 2025 11:35:39 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A7CCC2D1;
	Wed, 13 Aug 2025 11:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755084939; cv=none; b=AIOLxoGqddJZ51Wa3ObKeIfEP/FvmpDZupkGqF/w/yjppQhiBK5TRn25pS6fSGnGdg7l4w2r4y2E1gcixihzbezcDvDp1hfPPGsdHYYEUQ5vjZwkwBjsUVg9A5SdjFKcW2TtdTux0FZq0XZnkjuGhET4BCeQZ+ufmVrmfaFVE5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755084939; c=relaxed/simple;
	bh=Vk9N3hmeSjURiuFT0AuHUJEe3nkb1shrWR3PfY+VcWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XnFsggm5MbvByNkWfGfZSj2zL6Nt7Xgix1J7nhMH9p7ggscMynPwFOl9tCKgsVRdCfSZNfmRcCGHL3jcR1svy7P0mrRDcUG3Eiarvx2jDnqxZrkIvebZMVa21u/UdrKNYFE8nigia39sS33r/ENHs5RzF+nmPT2+wujFPLrp0hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8F0EF12FC;
	Wed, 13 Aug 2025 04:35:28 -0700 (PDT)
Received: from raptor (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 922E53F738;
	Wed, 13 Aug 2025 04:35:34 -0700 (PDT)
Date: Wed, 13 Aug 2025 12:35:31 +0100
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Mark Rutland <mark.rutland@arm.com>, alexandru.elisei@arm.com
Subject: Re: [PATCH 0/4] clocksource: Add standalone MMIO ARM arch timer
 driver
Message-ID: <aJx4g8z3l438Qgnv@raptor>
References: <20250807160243.1970533-1-maz@kernel.org>
 <20250813-macho-snobbish-alpaca-ff07fa@sudeepholla>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813-macho-snobbish-alpaca-ff07fa@sudeepholla>

Hello,

On Wed, Aug 13, 2025 at 11:55:48AM +0100, Sudeep Holla wrote:
> +Alexandru
> 
> On Thu, Aug 07, 2025 at 05:02:39PM +0100, Marc Zyngier wrote:
> > For the past 10 years, both Mark and I have been lamenting about the
> > sorry state of the badly named "arch_timer" driver, and about the way
> > the MMIO part is intricately weaved into the system-register part.
> > 
> > The time has finally come to have a stab at it.
> > 
> > This small series simply creates a new timer driver for the MMIO arch
> > timer, and only that. It is an actual driver, and not some kludge that
> > has to run super early (that's what the per-CPU timers are for). This
> > allows, in turn, a pretty large cleanup of the per-CPU driver, though
> > there is more to come -- one thing at a time.
> > 
> > As an added bonus, we get a clocksource, which the original code
> > didn't provide. Just in case it might be useful. The end-result is far
> > more readable, and about 100 lines smaller.
> > 
> 
> (Tested it on Juno R2 and FVP in both DT and ACPI boot)
> 
> Tested-by: Sudeep Holla <sudeep.holla@arm.com>
> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
> 
> Alexandru found it useful(avoids some unexpected hang IIUC) in his setup
> based on bootwrapper which doesn't initialise MMIO timers.

Just FYI, this is the testing that I did.

Without this series, if firmware (boot-wrapper-aarch64 in my testing) doesn't
configure access to the memory-mapped timer:

[    0.000000] arch_timer: Unable to find a suitable frame in timer @ 0x000000002a810000
[    0.000000] Failed to initialize '/timer@2a810000': -22
..
[    0.528000] kvm [1]: kvm_arch_timer: uninitialized timecounter
..
# ls /dev/kvm
ls: cannot access '/dev/kvm': No such file or directory

With this series, if firmware doesn't configure access to the memory-mapped
timer:

[    0.549399] kvm [1]: Hyp nVHE mode initialized successfully
..
[    2.018050] arch-timer-mmio 2a810000.timer: Unable to find a suitable frame in timer @ 0x000000002a810000
[    2.018123] arch-timer-mmio 2a810000.timer: probe with driver arch-timer-mmio failed with error -22
..
# ls /dev/kvm
/dev/kvm

Thanks,
Alex

