Return-Path: <linux-acpi+bounces-2297-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E05D80DB21
	for <lists+linux-acpi@lfdr.de>; Mon, 11 Dec 2023 20:52:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D1C928239F
	for <lists+linux-acpi@lfdr.de>; Mon, 11 Dec 2023 19:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8733537EE;
	Mon, 11 Dec 2023 19:52:51 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CD73D2;
	Mon, 11 Dec 2023 11:52:49 -0800 (PST)
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6d9f4682c7bso404565a34.1;
        Mon, 11 Dec 2023 11:52:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702324368; x=1702929168;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=shxc1fqYRYQGn0MQr4gOJAnY5PC0ECh8gGcd5gbYepM=;
        b=PjbSw0vv51/y19nexWN70ndxFKOOMoNqhRLg65WjyFTVfQ+/CL4WYXiajnEBHKt8Pa
         kOhzOFdT8XuFhJuYArj0x0fOjb6qiH1lakXlq81W/BdbmH7x0QGzzPp2+wS/9jduUQFx
         1UeW0E7UhRKei+vqYIVEd+ofXdsh8wj3eHQmQDKvYGMB0UdkqF0n965RfWrMIsdhpiXc
         PFlerj41b4zHNFxdgSGmAca9MjOsOX+x2aYvQ8finIZjy0uQ1VgVO+KO6oFeWkLmImVr
         qXtSETW0C8G8rEVxC0QjxjYtBx/iOp5TVFwCRtsPLqpFXoD7i64qLC3eEdmoQdzMAksn
         PINg==
X-Gm-Message-State: AOJu0Yxu/abKvJmzQJUv6KQ7P1t3O5cqc6hN2M825dGUj3ARI8r4XDs4
	TlUUANmcxIRCFtio8cpVQVN28xuDsgmum3imxeg=
X-Google-Smtp-Source: AGHT+IGjJ9dqMdEvqbPS4C+aNBObN65m/Uv+AIgbHvjx5d2sI4uQBJx39nF2HMC2W+Wq43gY2UcNwwiDLRyn45Z6BNI=
X-Received: by 2002:a05:6820:2a18:b0:590:9027:7ab0 with SMTP id
 dr24-20020a0568202a1800b0059090277ab0mr7447038oob.0.1702324368365; Mon, 11
 Dec 2023 11:52:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231211104855.558096-1-vincent.guittot@linaro.org>
In-Reply-To: <20231211104855.558096-1-vincent.guittot@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 11 Dec 2023 20:52:37 +0100
Message-ID: <CAJZ5v0i37gGqt=oGC4BxJ4hT5pxhAdL7dPxGf7w3D8THqwAOwQ@mail.gmail.com>
Subject: Re: [PATCH v7 0/7] consolidate and cleanup CPU capacity
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	sudeep.holla@arm.com, gregkh@linuxfoundation.org, rafael@kernel.org, 
	mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com, 
	viresh.kumar@linaro.org, lenb@kernel.org, robert.moore@intel.com, 
	lukasz.luba@arm.com, ionela.voinescu@arm.com, pierre.gondois@arm.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-pm@vger.kernel.org, 
	linux-acpi@vger.kernel.org, conor.dooley@microchip.com, suagrfillet@gmail.com, 
	ajones@ventanamicro.com, lftan@kernel.org, beata.michalska@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 11, 2023 at 11:49=E2=80=AFAM Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> This is the 1st part of consolidating how the max compute capacity is
> used in the scheduler and how we calculate the frequency for a level of
> utilization.
>
> Fix some unconsistancy when computing frequency for an utilization. There
> can be a mismatch between energy model and schedutil.
>
> Next step will be to make a difference between the original
> max compute capacity of a CPU and what is currently available when
> there is a capping applying forever (i.e. seconds or more).
>
> Changes since v6:
> - Rebase on tip/sched/core and fix a conflict
> - Add tags
>
> Changes since v5:
> - Remove useless return in freq_inv_set_max_ratio()
> - Add tags
>
> Changes since v4:
> - Capitalize the verb in subject
> - Remove usless parentheses in cppc_get_dmi_max_khz()
> - Use freq_ref pattern everywhere
> - Fix MHz / kHz units conversion for cppc_cpufreq
> - Move default definition of arch_scale_freq_ref() in
>   include/linux/sched/topology.h beside arch_scale_cpu_capacity
>   which faces similar default declaration behavior. This location covers
>   all cases with arch and CONFIG_* which was not the case with previous
>   attempts.
>
> Changes since v3:
> - Split patch 5 cpufreq/cppc
> - Fix topology_init_cpu_capacity_cppc()
> - Fix init if AMU ratio
> - Added some tags
>
> Changes since v2:
> - Remove the 1st patch which has been queued in tip
> - Rework how to initialize the reference frequency for cppc_cpufreq and
>   change topology_init_cpu_capacity_cppc() to also set capacity_ref_freq
> - Add a RFC to convert AMU to use arch_scale_freq_ref and move the config
>   of the AMU ratio to be done when intializing cpu capacity and
>   capacity_ref_freq
> - Added some tags
>
> Changes since v1:
> - Fix typos
> - Added changes in cpufreq to use arch_scale_freq_ref() when calling
>   arch_set_freq_scale (patch 3).
> - arch_scale_freq_ref() is always defined and returns 0 (as proposed
>   by Ionela) when not defined by the arch. This simplifies the code with
>   the addition of patch 3.
> - Simplify Energy Model which always uses arch_scale_freq_ref(). The
>   latter returns 0 when not defined by arch instead of last item of the
>   perf domain. This is not a problem because the function is only defined
>   for compilation purpose in this case and we don't care about the
>   returned value. (patch 5)
> - Added changes in cppc cpufreq to set capacity_ref_freq (patch 6)
> - Added reviewed tag for patch 1 which got a minor change but not for
>   others as I did some changes which could make previous reviewed tag
>   no more relevant.
>
> Vincent Guittot (7):
>   topology: Add a new arch_scale_freq_reference
>   cpufreq: Use the fixed and coherent frequency for scaling capacity
>   cpufreq/schedutil: Use a fixed reference frequency
>   energy_model: Use a fixed reference frequency
>   cpufreq/cppc: Move and rename cppc_cpufreq_{perf_to_khz|khz_to_perf}
>   cpufreq/cppc: Set the frequency used for computing the capacity
>   arm64/amu: Use capacity_ref_freq to set AMU ratio

This series touches multiple places, but mostly schedutil, cpufreq and
the EM, so please let me know if you want me to pick it up.

