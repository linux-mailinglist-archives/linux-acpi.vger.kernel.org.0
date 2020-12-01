Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A27C2CA7B9
	for <lists+linux-acpi@lfdr.de>; Tue,  1 Dec 2020 17:05:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403845AbgLAQFD (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 1 Dec 2020 11:05:03 -0500
Received: from foss.arm.com ([217.140.110.172]:45436 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388182AbgLAQFD (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 1 Dec 2020 11:05:03 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1C0311042;
        Tue,  1 Dec 2020 08:04:09 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 713343F575;
        Tue,  1 Dec 2020 08:04:06 -0800 (PST)
References: <20201201025944.18260-1-song.bao.hua@hisilicon.com> <20201201025944.18260-3-song.bao.hua@hisilicon.com>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Barry Song <song.bao.hua@hisilicon.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, rjw@rjwysocki.net,
        lenb@kernel.org, gregkh@linuxfoundation.org,
        Jonathan.Cameron@huawei.com, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linuxarm@huawei.com, xuwei5@huawei.com, prime.zeng@hisilicon.com
Subject: Re: [RFC PATCH v2 2/2] scheduler: add scheduler level for clusters
In-reply-to: <20201201025944.18260-3-song.bao.hua@hisilicon.com>
Date:   Tue, 01 Dec 2020 16:04:04 +0000
Message-ID: <jhj1rg9v7gr.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


On 01/12/20 02:59, Barry Song wrote:
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 1a68a05..ae8ec910 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6106,6 +6106,37 @@ static inline int select_idle_smt(struct task_struct *p, int target)
>  
>  #endif /* CONFIG_SCHED_SMT */
>  
> +#ifdef CONFIG_SCHED_CLUSTER
> +/*
> + * Scan the local CLUSTER mask for idle CPUs.
> + */
> +static int select_idle_cluster(struct task_struct *p, int target)
> +{
> +	int cpu;
> +
> +	/* right now, no hardware with both cluster and smt to run */
> +	if (sched_smt_active())
> +		return -1;
> +
> +	for_each_cpu_wrap(cpu, cpu_cluster_mask(target), target) {

Gating this behind this new config only leveraged by arm64 doesn't make it
very generic. Note that powerpc also has this newish "CACHE" level which
seems to overlap in function with your "CLUSTER" one (both are arch
specific, though).

I think what you are after here is an SD_SHARE_PKG_RESOURCES domain walk,
i.e. scan CPUs by increasing cache "distance". We already have it in some
form, as we scan SMT & LLC domains; AFAICT LLC always maps to MC, except
for said powerpc's CACHE thingie.

*If* we are to generally support more levels with SD_SHARE_PKG_RESOURCES,
we could say frob something into select_idle_cpu(). I'm thinking of
something like the incomplete, untested below: 

---
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ae7ceba8fd4f..70692888db00 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6120,7 +6120,7 @@ static inline int select_idle_smt(struct task_struct *p, struct sched_domain *sd
 static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int target)
 {
 	struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
-	struct sched_domain *this_sd;
+	struct sched_domain *this_sd, *child = NULL;
 	u64 avg_cost, avg_idle;
 	u64 time;
 	int this = smp_processor_id();
@@ -6150,14 +6150,22 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
 
 	time = cpu_clock(this);
 
-	cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
+	do {
+		/* XXX: sd should start as SMT's parent */
+		cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
+		if (child)
+			cpumask_andnot(cpus, cpus, sched_domain_span(child));
+
+		for_each_cpu_wrap(cpu, cpus, target) {
+			if (!--nr)
+				return -1;
+			if (available_idle_cpu(cpu) || sched_idle_cpu(cpu))
+				break;
+		}
 
-	for_each_cpu_wrap(cpu, cpus, target) {
-		if (!--nr)
-			return -1;
-		if (available_idle_cpu(cpu) || sched_idle_cpu(cpu))
-			break;
-	}
+		child = sd;
+		sd = sd->parent;
+	} while (sd && sd->flags & SD_SHARE_PKG_RESOURCES);
 
 	time = cpu_clock(this) - time;
 	update_avg(&this_sd->avg_scan_cost, time);
