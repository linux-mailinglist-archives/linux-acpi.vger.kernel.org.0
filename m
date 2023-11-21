Return-Path: <linux-acpi+bounces-1699-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77AC67F33EF
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Nov 2023 17:38:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E76A51F22F99
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Nov 2023 16:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B47555C35
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Nov 2023 16:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cvNqDZoY"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B3549F81;
	Tue, 21 Nov 2023 15:43:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A914C433C8;
	Tue, 21 Nov 2023 15:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700581439;
	bh=m9kkL9A22jnuerrDu70VmA1coTYVI+8/zZjiYsSHxqw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cvNqDZoY4W722oGmOQZw/jvyISy5utwgaaeSJjSZMkzV4A1x1liWax90Y+iH7qo1j
	 6zF7rXGixD1L9DAgjxGJ+JqHuw7ImcN8uzHCUHForxEqwqdrerklY6hU13btIOPMOi
	 uzTBjkFASm/zkDulnlWCb31185VjZCxa/i/YlzwcXTQhyReTaRnO2Z53HQyGjv128+
	 rQ5EZvKPryRnLWyW+rFQ7mePv4rpWCvCucoqNhZO0c1isQ5wfIgtP9ihfImmYYBRuq
	 OI8g/noZWYIDGOYKyC130qRxIrCWYB1S87CyyBWp1aXF7WS0zdQoRcBi1a5Tqn2pF6
	 E9+ihDlyORpRA==
Date: Tue, 21 Nov 2023 15:43:50 +0000
From: Will Deacon <will@kernel.org>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: linux@armlinux.org.uk, catalin.marinas@arm.com,
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	sudeep.holla@arm.com, gregkh@linuxfoundation.org, rafael@kernel.org,
	mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
	viresh.kumar@linaro.org, lenb@kernel.org, robert.moore@intel.com,
	lukasz.luba@arm.com, ionela.voinescu@arm.com,
	pierre.gondois@arm.com, beata.michalska@arm.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-pm@vger.kernel.org,
	linux-acpi@vger.kernel.org, conor.dooley@microchip.com,
	suagrfillet@gmail.com, ajones@ventanamicro.com, lftan@kernel.org
Subject: Re: [PATCH v6 7/7] arm64/amu: Use capacity_ref_freq to set AMU ratio
Message-ID: <20231121154349.GA1938@willie-the-truck>
References: <20231109101438.1139696-1-vincent.guittot@linaro.org>
 <20231109101438.1139696-8-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231109101438.1139696-8-vincent.guittot@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Thu, Nov 09, 2023 at 11:14:38AM +0100, Vincent Guittot wrote:
> Use the new capacity_ref_freq to set the ratio that is used by AMU for
> computing the arch_scale_freq_capacity().
> This helps to keep everything aligned using the same reference for
> computing CPUs capacity.
> 
> The default value of the ratio (stored in per_cpu(arch_max_freq_scale))
> ensures that arch_scale_freq_capacity() returns max capacity until it is
> set to its correct value with the cpu capacity and capacity_ref_freq.
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> Acked-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  arch/arm64/kernel/topology.c  | 26 +++++++++++++-------------
>  drivers/base/arch_topology.c  | 12 +++++++++++-
>  include/linux/arch_topology.h |  1 +
>  3 files changed, 25 insertions(+), 14 deletions(-)

Acked-by: Will Deacon <will@kernel.org>

Will

