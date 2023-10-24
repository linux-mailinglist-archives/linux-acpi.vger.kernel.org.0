Return-Path: <linux-acpi+bounces-874-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EFDFC7D4E0F
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Oct 2023 12:37:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D0C31C20B13
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Oct 2023 10:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D66026287
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Oct 2023 10:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y1wxrMZy"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B47D224EA
	for <linux-acpi@vger.kernel.org>; Tue, 24 Oct 2023 09:57:02 +0000 (UTC)
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0597DC
	for <linux-acpi@vger.kernel.org>; Tue, 24 Oct 2023 02:56:59 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id ada2fe7eead31-457c2e44f20so1695275137.1
        for <linux-acpi@vger.kernel.org>; Tue, 24 Oct 2023 02:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698141418; x=1698746218; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ZmQw87wWu1ilebiZdLFiZTY4pr7HbiJ8vUC+a+GPRs=;
        b=Y1wxrMZy1k/4FBm8A2U476YZIHerlSRC/2lZEGR3TsdTro02PKRW9bEEBrI+OrX2jZ
         x2O8pPR63iXPR79TfbMTP+2C6IsLwpYjWJyYkwUFE0a5pK8cVU+mxATxae2dhXHSafQ2
         +HGVzVHt7HkKWb4QOZFVDb41tkfA+jSfeCwkM/G8OfAm3ACV/STR+eDTQE5z+P+DK82U
         fWSB24SRol9vRk9f3S8AAf//8zzDVOyOr3K5WrmyxLMsGNYoZ96/yZYxXahdbZmRrlX+
         6Q2ahxHTvVJxO3c9Ue4d/o4TOEP+iYl0cumWmsWUmKnrPTsaOHZiAZwBTkrddvfLXKYc
         nA9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698141418; x=1698746218;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9ZmQw87wWu1ilebiZdLFiZTY4pr7HbiJ8vUC+a+GPRs=;
        b=e7z06PW/mzLVsja43B8rp3+44NkWfdOYkCmQ5lmfPS+y3RTfWLorP+m+Y4kFJQsSZo
         4SSmjw0GAnFAqh0AdPTe/qQokyAo3VCB8HpaB3RD0bb0K+kclDq49SqUKL/8UG9RH9kZ
         UNcMnIZ+u0rmrUQujga0JkruNdqIrIVWhWc9YmSHUoFlGbv8DdhkKaq/8hMEPUoCzbE7
         mw9X9zWYoL2E7NX7EVaGhSx2M2vUww77JIpWhYx4cQi9dR10Byf5hHDaiBq3YnclGQs0
         Y9o0rt6rWvIQHoEZWQXwyivpQU8AejnZR9lhkEqvnFfGpHICD8BkElyS2aSsBTUnTZYR
         L58w==
X-Gm-Message-State: AOJu0Yz2L5b0A8aCzK4BF10tTWtwF+CqgJPrSmH3DGR9UGOq0BBbRVwB
	8V3NmEa3q3SXkCtTaLau37agja+id1kLHWok50TQjA==
X-Google-Smtp-Source: AGHT+IF/FMkfyP/7/zLROy5Ws/WEeWc1OLNc41dw+XpTZWtkqgbB228Ev9XsffAxvviNM6m98X3y97EFL0UsiFArJ7o=
X-Received: by 2002:a67:ac48:0:b0:45a:67da:658 with SMTP id
 n8-20020a67ac48000000b0045a67da0658mr5359507vsh.33.1698141418696; Tue, 24 Oct
 2023 02:56:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231018162540.667646-1-vincent.guittot@linaro.org>
 <20231018162540.667646-6-vincent.guittot@linaro.org> <CAJZ5v0hS7bdUv=-k4ut2Fw0LYfB7Hb1_rro7UOVTRq4=JLNchg@mail.gmail.com>
 <60497d6d-dfe3-4edc-9553-311fdd9c63d0@arm.com>
In-Reply-To: <60497d6d-dfe3-4edc-9553-311fdd9c63d0@arm.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Tue, 24 Oct 2023 11:56:46 +0200
Message-ID: <CAKfTPtCogPYyfe2aoNQE4BLRM+++3ezdx-3NsVFFMBKnZNWfiw@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] cpufreq/cppc: set the frequency used for computing
 the capacity
To: Pierre Gondois <pierre.gondois@arm.com>
Cc: linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	sudeep.holla@arm.com, gregkh@linuxfoundation.org, mingo@redhat.com, 
	peterz@infradead.org, juri.lelli@redhat.com, dietmar.eggemann@arm.com, 
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, bristot@redhat.com, 
	vschneid@redhat.com, viresh.kumar@linaro.org, lenb@kernel.org, 
	robert.moore@intel.com, lukasz.luba@arm.com, ionela.voinescu@arm.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-pm@vger.kernel.org, 
	linux-acpi@vger.kernel.org, acpica-devel@lists.linuxfoundation.org, 
	conor.dooley@microchip.com, suagrfillet@gmail.com, ajones@ventanamicro.com, 
	lftan@kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 20 Oct 2023 at 18:05, Pierre Gondois <pierre.gondois@arm.com> wrote=
:
>
> Hello Vincent,
>
> On 10/18/23 19:26, Rafael J. Wysocki wrote:
> > On Wed, Oct 18, 2023 at 6:25=E2=80=AFPM Vincent Guittot
> > <vincent.guittot@linaro.org> wrote:
> >>
> >> Save the frequency associated to the performance that has been used wh=
en
> >> initializing the capacity of CPUs.
> >> Also, cppc cpufreq driver can register an artificial energy model. In =
such
> >> case, it needs the frequency for this compute capacity.
> >> We moved and renamed cppc_perf_to_khz and cppc_perf_to_khz to use them
> >> outside cppc_cpufreq in topology_init_cpu_capacity_cppc().
> >>
> >> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> >
> > For the changes in drivers/acpi/cppc_acpi.c :
> >
> > Acked-by: Rafael J. Wysocki <rafael@kernel.org>
> >
> >> ---
> >>   drivers/acpi/cppc_acpi.c       |  93 ++++++++++++++++++++++
> >>   drivers/base/arch_topology.c   |  15 +++-
> >>   drivers/cpufreq/cppc_cpufreq.c | 141 ++++++-------------------------=
--
> >>   include/acpi/cppc_acpi.h       |   2 +
> >>   4 files changed, 133 insertions(+), 118 deletions(-)
> >>
>
> [snip]
>
> >> diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology=
.c
> >> index 9a073c2d2086..2372ce791bb4 100644
> >> --- a/drivers/base/arch_topology.c
> >> +++ b/drivers/base/arch_topology.c
> >> @@ -350,6 +350,7 @@ bool __init topology_parse_cpu_capacity(struct dev=
ice_node *cpu_node, int cpu)
> >>   void topology_init_cpu_capacity_cppc(void)
> >>   {
> >>          struct cppc_perf_caps perf_caps;
> >> +       u64 capacity, capacity_scale;
>
> I think capacity_scale should be initialized to 0 here,
> since it is used to find the max value of raw_capacity[cpu].

yes

>
> >>          int cpu;
> >>
> >>          if (likely(!acpi_cpc_valid()))
> >> @@ -365,6 +366,10 @@ void topology_init_cpu_capacity_cppc(void)
> >>                      (perf_caps.highest_perf >=3D perf_caps.nominal_pe=
rf) &&
> >>                      (perf_caps.highest_perf >=3D perf_caps.lowest_per=
f)) {
> >>                          raw_capacity[cpu] =3D perf_caps.highest_perf;
> >> +                       capacity_scale =3D max_t(u64, capacity_scale, =
raw_capacity[cpu]);
> >> +
> >> +                       per_cpu(capacity_ref_freq, cpu) =3D cppc_perf_=
to_khz(&perf_caps, raw_capacity[cpu]);
>
> I think capacity_ref_freq in in Hz, so the freq should be multiplied by 1=
000 .

yes, I forgot the *1000. I'm going to add * HZ_PER_KHZ

>
> With these two modifications, the patches worked well on a cppc-based pla=
tform.
>
> Sorry I forgot to detail what it was. It's a modified Juno with CPPC enab=
led. AMUs are not
> enabled, so the CPPC performance counters are not handled correctly and F=
IE cannot be enabled,
> but it is possible to change frequencies.
>
> The _CPC objects are setup as:
> little CPUs:
> - lowest_freq =3D 450 (MHz)
> - nominal_freq =3D 800 (MHz)
> - highest_perf =3D 383 * 1000
> - nominal_perf =3D 322 * 1000
> - lowest_perf =3D 181 * 1000
> - lowest_nonlinear_perf =3D 181 * 1000
>
> big CPUs:
> - lowest_freq =3D 600 (MHz)
> - nominal_freq =3D 1200 (MHz)
> - highest_perf =3D 1024 * 1000
> - nominal_perf =3D 833 * 1000
> - lowest_perf =3D 512 * 1000
> - lowest_nonlinear_perf =3D 512 * 1000
>
> As a remainder, available frequencies are:
> - little CPUs: 450, 800, 950 MHz
> - big CPUs: 600, 1000, 1200 Mhz
> So the platform is setup to have the last frequency as a boost frequency =
(for testing).
>
> ----
>
> Just to make a note of 2 potential side-issues for later (independent fro=
m these patches):
>
> - When testing with boosted/non-bossted frequencies, it didn't seem that =
cpu_overutilized()
>    was taking the maximum frequency into consideration. This might mean t=
hat when lowering the
>    maximum frequency of a policy, the maximum capacity of the CPUs of thi=
s policy is used
>    to detect over-utilization.
>    I would have thought that the over-utilization threshold would be lowe=
red at the same time.

No it's not, It will be part of a next step patchset. This patchset
aims to consolidate and use the same reference so we can then easily
propagate changes if needed

>
> - Similarly for EAS, the energy computation doesn't take into account the=
 maximum frequency
>    of the policy. This should mean that EAS is taking into consideration =
frequencies that
>    are not actually available.
>
>
> Regards,
> Pierre

