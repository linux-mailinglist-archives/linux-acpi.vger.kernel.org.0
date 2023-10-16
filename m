Return-Path: <linux-acpi+bounces-660-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41A547CA81E
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Oct 2023 14:38:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A9BE1C20975
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Oct 2023 12:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAD3226E10
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Oct 2023 12:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cs7JmvWN"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454CE16438
	for <linux-acpi@vger.kernel.org>; Mon, 16 Oct 2023 10:59:19 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98C2795;
	Mon, 16 Oct 2023 03:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=P5ifjwAGWvwt8UdPAGRFDaEieTTOaEIZSTQ8cKCMbcA=; b=cs7JmvWNb3ISfTeRVqrLDJ3hb6
	4ejwBMKbJkO52e9dcJ0rJy3p6TH/1AcjMnL3vbVyA3AT3LgrwqkXMvgecAumcGpwX92Nrq7hlN8eY
	xRX9RPg6sT8dmS172NUE3cZRZk0ldfrB74gOYnO3otY0BZYHEocfAtWm18AWU+zKy4pSzNszJJ7/4
	5oVtl1bL+1sSPuDZmzmsLkrkKbm6QR27dHMPH0Vo27gdhhJ1DSVzYQ+7KIGcttZQ0pgdlsy9kA/lz
	IExW1dYrYUX+pblYqRwDdd0hDvaunDI1tg7W6TsWAVi3oLqE/4scNTbUWWk1Oka/KccmsJ68uIcqq
	9xfrY0Aw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1qsLJ6-005woe-0M;
	Mon, 16 Oct 2023 10:58:47 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 39C6B3005AA; Mon, 16 Oct 2023 12:58:45 +0200 (CEST)
Date: Mon, 16 Oct 2023 12:58:45 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Meng, Li (Jassmine)" <Li.Meng@amd.com>
Cc: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	"Huang, Ray" <Ray.Huang@amd.com>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"Fontenot, Nathan" <Nathan.Fontenot@amd.com>,
	"Sharma, Deepak" <Deepak.Sharma@amd.com>,
	"Deucher, Alexander" <Alexander.Deucher@amd.com>,
	"Limonciello, Mario" <Mario.Limonciello@amd.com>,
	"Huang, Shimmer" <Shimmer.Huang@amd.com>,
	"Yuan, Perry" <Perry.Yuan@amd.com>,
	"Du, Xiaojian" <Xiaojian.Du@amd.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Borislav Petkov <bp@alien8.de>,
	Oleksandr Natalenko <oleksandr@natalenko.name>,
	"Karny, Wyes" <Wyes.Karny@amd.com>
Subject: Re: [RESEND PATCH V9 3/7] cpufreq: amd-pstate: Enable amd-pstate
 preferred core supporting.
Message-ID: <20231016105845.GA33217@noisy.programming.kicks-ass.net>
References: <20231013033118.3759311-1-li.meng@amd.com>
 <20231013033118.3759311-4-li.meng@amd.com>
 <20231013160128.GB36211@noisy.programming.kicks-ass.net>
 <DM4PR12MB6351E2E9504B57BD40DAE985F7D7A@DM4PR12MB6351.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM4PR12MB6351E2E9504B57BD40DAE985F7D7A@DM4PR12MB6351.namprd12.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 16, 2023 at 06:20:53AM +0000, Meng, Li (Jassmine) wrote:
> > > +static void amd_pstate_init_prefcore(struct amd_cpudata *cpudata) {
> > > +     int ret, prio;
> > > +     u32 highest_perf;
> > > +     static u32 max_highest_perf = 0, min_highest_perf = U32_MAX;
> >
> > What serializes these things?
> >
> > Also, *why* are you using u32 here, what's wrong with something like:
> >
> >         int max_hp = INT_MIN, min_hp = INT_MAX;
> >
> [Meng, Li (Jassmine)]
> We use ITMT architecture to utilize preferred core features.
> Therefore, we need to try to be consistent with Intel's implementation
> as much as possible.  For details, please refer to the
> intel_pstate_set_itmt_prio function in file intel_pstate.c. (Line 355)
> 
> I think using the data type of u32 is consistent with the data
> structures of cppc_perf_ctrls and amd_cpudata etc.

Rafael, should we fix intel_pstate too?

The point is, that sched_asym_prefer(), the final consumer of these
values uses int and thus an explicitly signed compare.

Using u32 and U32_MAX anywhere near the setting the priority makes
absolutely no sense.

If you were to have the high bit set, things do not behave as expected.

Also, same question as to the amd folks; what serializes those static
variables?

