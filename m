Return-Path: <linux-acpi+bounces-957-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 681ED7D6BEB
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Oct 2023 14:35:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21BE9281ADB
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Oct 2023 12:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8E90EEBC
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Oct 2023 12:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="X/M+QWAi"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E2320B19
	for <linux-acpi@vger.kernel.org>; Wed, 25 Oct 2023 11:54:12 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C698512A;
	Wed, 25 Oct 2023 04:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Iw+hAI2RZyKf3pkny9wI5k8uvYF1PKP6s1iFZu6PRHc=; b=X/M+QWAi63DcW2qYREzSvndZwt
	7X/GeKDC8gewFlEre7f8MPiHWzeV5zv0CdaZCAebgzUIbA8eplVsZ0IzgTNUe2Y2/CYgrCJKgvKfh
	yul1Lx8JtKZwmk0bzufa6faCwQJ6nZb8kg6kdcf4cx45FHJ5JcaA6V7bwMnd4Z1SSaGgRbwmT5mGc
	zZyhiIAv3k99+T1uE1JqCkX6I20Pga7G/rX+pIW76zuCiOPsEHyR7CnBK/cvRRCzvptNwSU1GXd6Q
	1qyuRg9+8ce32XB5Ht4ddRMmc+rvKQ7UkFGGMyp8cniRP6wklfpbEO7pD2cIsmwJf/tnACOgsauPi
	9KX6P0nQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1qvcRw-00GJda-1u;
	Wed, 25 Oct 2023 11:53:24 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 4192C30047C; Wed, 25 Oct 2023 13:53:24 +0200 (CEST)
Date: Wed, 25 Oct 2023 13:53:24 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org,
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	sudeep.holla@arm.com, gregkh@linuxfoundation.org, rafael@kernel.org,
	mingo@redhat.com, juri.lelli@redhat.com, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	bristot@redhat.com, vschneid@redhat.com, viresh.kumar@linaro.org,
	lenb@kernel.org, robert.moore@intel.com, lukasz.luba@arm.com,
	ionela.voinescu@arm.com, pierre.gondois@arm.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-pm@vger.kernel.org,
	linux-acpi@vger.kernel.org, acpica-devel@lists.linuxfoundation.org,
	conor.dooley@microchip.com, suagrfillet@gmail.com,
	ajones@ventanamicro.com, lftan@kernel.org
Subject: Re: [PATCH v3 3/6] cpufreq/schedutil: use a fixed reference frequency
Message-ID: <20231025115324.GC31201@noisy.programming.kicks-ass.net>
References: <20231018162540.667646-1-vincent.guittot@linaro.org>
 <20231018162540.667646-4-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018162540.667646-4-vincent.guittot@linaro.org>

On Wed, Oct 18, 2023 at 06:25:37PM +0200, Vincent Guittot wrote:

> +static __always_inline
> +unsigned long get_capacity_ref_freq(struct cpufreq_policy *policy)
> +{
> +	unsigned int freq = arch_scale_freq_ref(policy->cpu);
> +
> +	if (freq)
> +		return freq;
> +
> +	if (arch_scale_freq_invariant())
> +		return policy->cpuinfo.max_freq;
> +
> +	return policy->cur;
> +}

Hmm, what should x86 do here? I know it mostly doesn't use these things,
but would it make sense to stick the base frequency in ?

