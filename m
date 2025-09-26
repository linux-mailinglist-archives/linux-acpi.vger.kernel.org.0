Return-Path: <linux-acpi+bounces-17335-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF6DBA355E
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Sep 2025 12:23:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02F4D7AF1B3
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Sep 2025 10:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A73B42EB87B;
	Fri, 26 Sep 2025 10:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WTjcAfb8"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824E522D4F9
	for <linux-acpi@vger.kernel.org>; Fri, 26 Sep 2025 10:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758882189; cv=none; b=qavd3j0jrdcz0Qu0/6bb6mXygNHIMcKQGxRcopC+uiNyC55Q0GUKtjv7UyeOvydbRlBjs8k8nhmesTG4Vd2xSFWQ0cM2IRLC7lpIwHrvPrDZvOBPbhcZFD78hYlEDt252m5YI2MyIuEGUNI5cCugPgL/xSdAAmWv6d2K6SYJA0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758882189; c=relaxed/simple;
	bh=wc1iT4jT8QYf12SNibn89XD5uwpvV5JIemr/1m+RcpU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NI7hmAKBpuK0iRS1fHI4JCUstj6jZ3Ez1INJYXWapCECDTw9EShh/gGqlLawIHVD/nXqV7sa2ijHoZ6I8O5hfIoJnorkOlh7CFwXrrR4/88X0oVQ7EkfW2WtCzqjf/cVtm2adh+VRUlTbN8FiNFBwt3DrUurbdAnlpe/MCrUtVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WTjcAfb8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31E7DC4CEF7
	for <linux-acpi@vger.kernel.org>; Fri, 26 Sep 2025 10:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758882189;
	bh=wc1iT4jT8QYf12SNibn89XD5uwpvV5JIemr/1m+RcpU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=WTjcAfb8OoE7Tv9Ibjw+dVeLWgDXPmAVBSpWI4eO9LNlqqgAiuwnBkt14U0e/YtsV
	 K4OKpsFFRqidF5Hqni/LL6PQ5BnXjvwqJmq+SrqtgftlueREh9LbMpyCYqmpHwk12v
	 CZAXpGxXR60wGPTuAY38/QxMrZb7G7g4UuI4zYNSVpXT8jPxB62l3Ez1WrMnI+Btbk
	 pSs/fn36/diUurRcEtRmDtKMJkFIyYvdBxQHdiT/ox4nzWCwSLG0DVApNWTniSLMc/
	 9SdUP0gWKihVD/jUukQxvAJcgQEU6aBeDE7ITRPs5TcFFnyErSodLHFTRAnYYsI3Hx
	 6POMTz+ygIqpA==
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-624ffdf77b8so356669eaf.3
        for <linux-acpi@vger.kernel.org>; Fri, 26 Sep 2025 03:23:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVns9gymmRSo4FIytjjLgAR15AiVOsztnISG0sNosYVo65iJfn8CADiLICWoNfMp46vJinUttRHVVuG@vger.kernel.org
X-Gm-Message-State: AOJu0YzGnb0ssf4hz7xze9AB3PEdrUWor8eG/a43PlPkWGBSgl8s3j6h
	keqw63/obMW040JtUHB2DpqrQRNLh5a/yYoeXQbwNfV4q+xlUHeU8iYdDzWzH8twqpuo7cl7fdc
	KJBBgRB7wdH4QnOVv1pNtkZDvO+/xVRE=
X-Google-Smtp-Source: AGHT+IFfRxDAOzsyijqQBhKzBDonbGr4KKO2QNMSyM7669C59c/wNl2AlMCYY1pi6PVHDKEz3EJxmLo66uDOtzzOJNE=
X-Received: by 2002:a05:6820:16a8:b0:639:4656:f9a3 with SMTP id
 006d021491bc7-63a361be79dmr2840692eaf.4.1758882188413; Fri, 26 Sep 2025
 03:23:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8605612.T7Z3S40VBb@rafael.j.wysocki> <3925838.kQq0lBPeGt@rafael.j.wysocki>
 <12773788.O9o76ZdvQC@rafael.j.wysocki> <9637c2c2-823d-457f-b9bd-c7acd762bf88@hisilicon.com>
In-Reply-To: <9637c2c2-823d-457f-b9bd-c7acd762bf88@hisilicon.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 26 Sep 2025 12:22:57 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gVNa3ARV58pvJmDxE7VUNZe6Bxh=FoPwJ-4=a136XUNA@mail.gmail.com>
X-Gm-Features: AS18NWBq29R0R47Y1q_1PGF14CENNNci8eqHEXsk24JfrzWWO_TsSOEZhNrTyew
Message-ID: <CAJZ5v0gVNa3ARV58pvJmDxE7VUNZe6Bxh=FoPwJ-4=a136XUNA@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] ACPI: CPPC: Do not use CPUFREQ_ETERNAL as an error value
To: Jie Zhan <zhanjie9@hisilicon.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	Mario Limonciello <mario.limonciello@amd.com>, Shawn Guo <shawnguo@kernel.org>, 
	Qais Yousef <qyousef@layalina.io>, LKML <linux-kernel@vger.kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Pierre Gondois <pierre.gondois@arm.com>, 
	Linux ACPI <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 26, 2025 at 11:30=E2=80=AFAM Jie Zhan <zhanjie9@hisilicon.com> =
wrote:
>
>
>
> On 9/26/2025 1:23 AM, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Instead of using CPUFREQ_ETERNAL for signaling an error condition
> > in cppc_get_transition_latency(), change the return value type of
> > that function to int and make it return a proper negative error
> > code on failures.
> >
> > No intentional functional impact.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> A minor comment inline.  Other than that,
> Reviewed-by: Jie Zhan <zhanjie9@hisilicon.com>

Thanks!

> > ---
> >
> > v1 -> v2:
> >    * Change cppc_get_transition_latency() return value data type to int
> >    * Make it return -ENODATA on errors (Mario)
> >    * Update its callers accordingly
> >    * Adjust the subject and changelog
> >    * Add a missing empty code line to cppc_get_transition_latency()
> >
> > The modifications of this patch don't affect any other patches in the s=
eries:
> >
> > https://lore.kernel.org/linux-pm/8605612.T7Z3S40VBb@rafael.j.wysocki/
> >
> > ---
> >  drivers/acpi/cppc_acpi.c       |   15 ++++++++-------
> >  drivers/cpufreq/amd-pstate.c   |    8 ++++----
> >  drivers/cpufreq/cppc_cpufreq.c |    4 ++--
> >  include/acpi/cppc_acpi.h       |    6 +++---
> >  4 files changed, 17 insertions(+), 16 deletions(-)
> >
> > --- a/drivers/acpi/cppc_acpi.c
> > +++ b/drivers/acpi/cppc_acpi.c
> > @@ -1876,7 +1876,7 @@ EXPORT_SYMBOL_GPL(cppc_set_perf);
> >   * If desired_reg is in the SystemMemory or SystemIo ACPI address spac=
e,
> >   * then assume there is no latency.
> >   */
> > -unsigned int cppc_get_transition_latency(int cpu_num)
> > +int cppc_get_transition_latency(int cpu_num)
> >  {
> >       /*
> >        * Expected transition latency is based on the PCCT timing values
> > @@ -1889,31 +1889,32 @@ unsigned int cppc_get_transition_latency
> >        *              completion of a command before issuing the next c=
ommand,
> >        *              in microseconds.
> >        */
> > -     unsigned int latency_ns =3D 0;
> >       struct cpc_desc *cpc_desc;
> >       struct cpc_register_resource *desired_reg;
> >       int pcc_ss_id =3D per_cpu(cpu_pcc_subspace_idx, cpu_num);
> >       struct cppc_pcc_data *pcc_ss_data;
> > +     int latency_ns =3D 0;
> >
> >       cpc_desc =3D per_cpu(cpc_desc_ptr, cpu_num);
> >       if (!cpc_desc)
> > -             return CPUFREQ_ETERNAL;
> > +             return -ENODATA;
> >
> >       desired_reg =3D &cpc_desc->cpc_regs[DESIRED_PERF];
> >       if (CPC_IN_SYSTEM_MEMORY(desired_reg) || CPC_IN_SYSTEM_IO(desired=
_reg))
> >               return 0;
> > +
> An extra line here.

Yes, and it is intentional (see the changes between v1 and v2).

> Alternatively, can we cleanup a bit:

That can be done.

> if (!CPC_IN_PCC(desired_reg) || pcc_ss_id < 0)
>         return -ENODATA;
>
> >       else if (!CPC_IN_PCC(desired_reg))
> > -             return CPUFREQ_ETERNAL;
> > +             return -ENODATA;
> >
> >       if (pcc_ss_id < 0)
> > -             return CPUFREQ_ETERNAL;
> > +             return -ENODATA;
> >
> >       pcc_ss_data =3D pcc_data[pcc_ss_id];
> >       if (pcc_ss_data->pcc_mpar)
> >               latency_ns =3D 60 * (1000 * 1000 * 1000 / pcc_ss_data->pc=
c_mpar);
> >
> > -     latency_ns =3D max(latency_ns, pcc_ss_data->pcc_nominal * 1000);
> > -     latency_ns =3D max(latency_ns, pcc_ss_data->pcc_mrtt * 1000);
> > +     latency_ns =3D max_t(int, latency_ns, pcc_ss_data->pcc_nominal * =
1000);
> > +     latency_ns =3D max_t(int, latency_ns, pcc_ss_data->pcc_mrtt * 100=
0);
> >
> >       return latency_ns;
> >  }
> > --- a/drivers/cpufreq/amd-pstate.c
> > +++ b/drivers/cpufreq/amd-pstate.c
> > @@ -872,10 +872,10 @@ static void amd_pstate_update_limits(str
> >   */
> >  static u32 amd_pstate_get_transition_delay_us(unsigned int cpu)
> >  {
> > -     u32 transition_delay_ns;
> > +     int transition_delay_ns;
> >
> >       transition_delay_ns =3D cppc_get_transition_latency(cpu);
> > -     if (transition_delay_ns =3D=3D CPUFREQ_ETERNAL) {
> > +     if (transition_delay_ns < 0) {
> >               if (cpu_feature_enabled(X86_FEATURE_AMD_FAST_CPPC))
> >                       return AMD_PSTATE_FAST_CPPC_TRANSITION_DELAY;
> >               else
> > @@ -891,10 +891,10 @@ static u32 amd_pstate_get_transition_del
> >   */
> >  static u32 amd_pstate_get_transition_latency(unsigned int cpu)
> >  {
> > -     u32 transition_latency;
> > +     int transition_latency;
> >
> >       transition_latency =3D cppc_get_transition_latency(cpu);
> > -     if (transition_latency  =3D=3D CPUFREQ_ETERNAL)
> > +     if (transition_latency < 0)
> >               return AMD_PSTATE_TRANSITION_LATENCY;
> >
> >       return transition_latency;
> > --- a/drivers/cpufreq/cppc_cpufreq.c
> > +++ b/drivers/cpufreq/cppc_cpufreq.c
> > @@ -310,9 +310,9 @@ static int cppc_verify_policy(struct cpu
> >
> >  static unsigned int get_transition_latency_from_cppc(unsigned int cpu)
> >  {
> > -     unsigned int transition_latency_ns =3D cppc_get_transition_latenc=
y(cpu);
> > +     int transition_latency_ns =3D cppc_get_transition_latency(cpu);
> >
> > -     if (transition_latency_ns =3D=3D CPUFREQ_ETERNAL)
> > +     if (transition_latency_ns < 0)
> >               return CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS / NSEC_PER_U=
SEC;
> >
> >       return transition_latency_ns / NSEC_PER_USEC;
> > --- a/include/acpi/cppc_acpi.h
> > +++ b/include/acpi/cppc_acpi.h
> > @@ -160,7 +160,7 @@ extern unsigned int cppc_khz_to_perf(str
> >  extern bool acpi_cpc_valid(void);
> >  extern bool cppc_allow_fast_switch(void);
> >  extern int acpi_get_psd_map(unsigned int cpu, struct cppc_cpudata *cpu=
_data);
> > -extern unsigned int cppc_get_transition_latency(int cpu);
> > +extern int cppc_get_transition_latency(int cpu);
> >  extern bool cpc_ffh_supported(void);
> >  extern bool cpc_supported_by_cpu(void);
> >  extern int cpc_read_ffh(int cpunum, struct cpc_reg *reg, u64 *val);
> > @@ -216,9 +216,9 @@ static inline bool cppc_allow_fast_switc
> >  {
> >       return false;
> >  }
> > -static inline unsigned int cppc_get_transition_latency(int cpu)
> > +static inline int cppc_get_transition_latency(int cpu)
> >  {
> > -     return CPUFREQ_ETERNAL;
> > +     return -ENODATA;
> >  }
> >  static inline bool cpc_ffh_supported(void)
> >  {
> >
> >
> >
> >
>

