Return-Path: <linux-acpi+bounces-961-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E38D27D6BF9
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Oct 2023 14:36:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B87B281A29
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Oct 2023 12:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52B7C27EDC
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Oct 2023 12:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ShRhgn2D"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AAEE1CF95
	for <linux-acpi@vger.kernel.org>; Wed, 25 Oct 2023 12:25:28 +0000 (UTC)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10174CE;
	Wed, 25 Oct 2023 05:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=0wTA7EeJs4xuSZ97h4c5/blM/USRCJ+BXefRyNT99tw=; b=ShRhgn2DXJdLX76dHr3VQxbSf7
	mFxcr6xwaq+vkA2qJ4ZUZnL34a7vY3YFzTpoz0fjdHWrObng8cbuM+O6oN1SpgVXPubDF9GaOE49X
	ABcOYCAjzW+xa+GAnD4i1QBOoEVgG3bT/mi8v77iD4ogtuJqnsU7lfxshcuGn8AtnFOigkavn5W5P
	RRBbGph+s7u2GyOCHWa83RKz5Lm3Zh57K+wv7EYdRDgLNs071NJ0iVIuGgS/+3EslY2YkS41axKjG
	aD7sA+2ZylxLeimfBn1ZyIhazlnggrizRxKMmfLjf39GjwmD2xZrBeX8WMlpuYVfmekSUJD83BqIA
	X6gtUFZw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1qvcwR-008ibE-In; Wed, 25 Oct 2023 12:24:55 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 3C8AE30047C; Wed, 25 Oct 2023 14:24:55 +0200 (CEST)
Date: Wed, 25 Oct 2023 14:24:55 +0200
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
	linux-acpi@vger.kernel.org, conor.dooley@microchip.com,
	suagrfillet@gmail.com, ajones@ventanamicro.com, lftan@kernel.org
Subject: Re: [PATCH v3 5/6] cpufreq/cppc: set the frequency used for
 computing the capacity
Message-ID: <20231025122455.GE31201@noisy.programming.kicks-ass.net>
References: <20231018162540.667646-1-vincent.guittot@linaro.org>
 <20231018162540.667646-6-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018162540.667646-6-vincent.guittot@linaro.org>

On Wed, Oct 18, 2023 at 06:25:39PM +0200, Vincent Guittot wrote:
> Save the frequency associated to the performance that has been used when
> initializing the capacity of CPUs.
> Also, cppc cpufreq driver can register an artificial energy model. In such
> case, it needs the frequency for this compute capacity.
> We moved and renamed cppc_perf_to_khz and cppc_perf_to_khz to use them

perf_to_khz and khz_to_perf presumably :-)

> outside cppc_cpufreq in topology_init_cpu_capacity_cppc().

