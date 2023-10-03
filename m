Return-Path: <linux-acpi+bounces-357-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C367D7B667B
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Oct 2023 12:33:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 691752816D7
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Oct 2023 10:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5032720336
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Oct 2023 10:33:27 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E26CD278
	for <linux-acpi@vger.kernel.org>; Tue,  3 Oct 2023 09:45:48 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0DD9BB0;
	Tue,  3 Oct 2023 02:45:47 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2B7AFC15;
	Tue,  3 Oct 2023 02:46:25 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7FB2D3F5A1;
	Tue,  3 Oct 2023 02:45:45 -0700 (PDT)
Date: Tue, 3 Oct 2023 10:45:43 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: "Pawandeep Oza (QUIC)" <quic_poza@quicinc.com>
Cc: 'Will Deacon' <will@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"rafael@kernel.org" <rafael@kernel.org>,
	"lenb@kernel.org" <lenb@kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v8] cpuidle, ACPI: Evaluate LPI arch_flags for broadcast
 timer
Message-ID: <20231003094543.oinq2onehefxdrbw@bogus>
References: <20230918172140.2825357-1-quic_poza@quicinc.com>
 <20230929150459.GA30623@willie-the-truck>
 <CH0PR02MB8073FBB64A196EEEFED11BB7F6C5A@CH0PR02MB8073.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CH0PR02MB8073FBB64A196EEEFED11BB7F6C5A@CH0PR02MB8073.namprd02.prod.outlook.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 02, 2023 at 07:22:57PM +0000, Pawandeep Oza (QUIC) wrote:
>
>
> -----Original Message-----
> From: Will Deacon <will@kernel.org>
> Sent: Friday, September 29, 2023 8:05 AM
> To: Pawandeep Oza (QUIC) <quic_poza@quicinc.com>
> Cc: sudeep.holla@arm.com; catalin.marinas@arm.com; rafael@kernel.org; lenb@kernel.org; linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org; linux-acpi@vger.kernel.org
> Subject: Re: [PATCH v8] cpuidle, ACPI: Evaluate LPI arch_flags for broadcast timer
>
> On Mon, Sep 18, 2023 at 10:21:40AM -0700, Oza Pawandeep wrote:
> > Arm(r) Functional Fixed Hardware Specification defines LPI states, which
> > provide an architectural context loss flags field that can be used to
> > describe the context that might be lost when an LPI state is entered.
> >
> > - Core context Lost
> >         - General purpose registers.
> >         - Floating point and SIMD registers.
> >         - System registers, include the System register based
> >         - generic timer for the core.
> >         - Debug register in the core power domain.
> >         - PMU registers in the core power domain.
> >         - Trace register in the core power domain.
> > - Trace context loss
> > - GICR
> > - GICD
> >
> > Qualcomm's custom CPUs preserves the architectural state, including
> > keeping the power domain for local timers active.
> > when core is power gated, the local timers are sufficient to wake the
> > core up without needing broadcast timer.
> >
> > The patch fixes the evaluation of cpuidle arch_flags, and moves only
> > to broadcast timer if core context lost is defined in ACPI LPI.
> >
> > Fixes: a36a7fecfe607 ("Add support for Low Power Idle(LPI) states")
> > Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
> > Acked-by: Rafael J. Wysocki <rafael@kernel.org>
> > Signed-off-by: Oza Pawandeep <quic_poza@quicinc.com>
> > ---
> > diff --git a/drivers/acpi/processor_idle.c
> > b/drivers/acpi/processor_idle.c index dc615ef6550a..5c1d13eecdd1
> > 100644
> > --- a/drivers/acpi/processor_idle.c
> > +++ b/drivers/acpi/processor_idle.c
> > @@ -1217,8 +1217,7 @@ static int acpi_processor_setup_lpi_states(struct acpi_processor *pr)
> >  		strscpy(state->desc, lpi->desc, CPUIDLE_DESC_LEN);
> >  		state->exit_latency = lpi->wake_latency;
> >  		state->target_residency = lpi->min_residency;
> > -		if (lpi->arch_flags)
> > -			state->flags |= CPUIDLE_FLAG_TIMER_STOP;
> > +		arch_update_idle_state_flags(lpi->arch_flags, &state->flags);
>
> Hmm, I know Rafael has Acked this, but I think this is pretending to be more
> generic than it really is. While passing in a pointer to the flags field
> allows the arch code to set and clear arbitrary flags, we're calling this
> before we've set CPUIDLE_FLAG_RCU_IDLE, so that cannot be changed.
>
> Why not just name it like it is and return the arch flags directly:
>
> 	state->flags |= arch_get_idle_state_flags(lpi->arch_flags);
>
> Oza:
>
> ?

Not sure if this "?" is by mistake or you didn't follow Will's comment.

The point made was that it is cleaner for arch code to just provide the
flags that needs to be set via some helper like 'arch_get_idle_state_flags()'
rather than set/update itself via 'arch_update_idle_state_flags()' like
you have in this patch.

I completely agree with Will as this is much cleaner and arch code just
returns the requested flags and the core code is still in charge to update
the flags.

--
Regards,
Sudeep

