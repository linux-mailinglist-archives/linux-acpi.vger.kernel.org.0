Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5500B36C530
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Apr 2021 13:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235443AbhD0Lge (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 27 Apr 2021 07:36:34 -0400
Received: from foss.arm.com ([217.140.110.172]:51174 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235225AbhD0Lge (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 27 Apr 2021 07:36:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E5514D6E;
        Tue, 27 Apr 2021 04:35:50 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3997B3F694;
        Tue, 27 Apr 2021 04:35:45 -0700 (PDT)
Subject: Re: [RFC PATCH v6 3/4] scheduler: scan idle cpu in cluster for tasks
 within one LLC
To:     Barry Song <song.bao.hua@hisilicon.com>,
        tim.c.chen@linux.intel.com, catalin.marinas@arm.com,
        will@kernel.org, rjw@rjwysocki.net, vincent.guittot@linaro.org,
        bp@alien8.de, tglx@linutronix.de, mingo@redhat.com,
        lenb@kernel.org, peterz@infradead.org, rostedt@goodmis.org,
        bsegall@google.com, mgorman@suse.de
Cc:     msys.mizuma@gmail.com, valentin.schneider@arm.com,
        gregkh@linuxfoundation.org, jonathan.cameron@huawei.com,
        juri.lelli@redhat.com, mark.rutland@arm.com, sudeep.holla@arm.com,
        aubrey.li@linux.intel.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        x86@kernel.org, xuwei5@huawei.com, prime.zeng@hisilicon.com,
        guodong.xu@linaro.org, yangyicong@huawei.com,
        liguozhu@hisilicon.com, linuxarm@openeuler.org, hpa@zytor.com
References: <20210420001844.9116-1-song.bao.hua@hisilicon.com>
 <20210420001844.9116-4-song.bao.hua@hisilicon.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <80f489f9-8c88-95d8-8241-f0cfd2c2ac66@arm.com>
Date:   Tue, 27 Apr 2021 13:35:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210420001844.9116-4-song.bao.hua@hisilicon.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 20/04/2021 02:18, Barry Song wrote:

[...]

> @@ -5786,11 +5786,12 @@ static void record_wakee(struct task_struct *p)
>   * whatever is irrelevant, spread criteria is apparent partner count exceeds
>   * socket size.
>   */
> -static int wake_wide(struct task_struct *p)
> +static int wake_wide(struct task_struct *p, int cluster)
>  {
>  	unsigned int master = current->wakee_flips;
>  	unsigned int slave = p->wakee_flips;
> -	int factor = __this_cpu_read(sd_llc_size);
> +	int factor = cluster ? __this_cpu_read(sd_cluster_size) :
> +		__this_cpu_read(sd_llc_size);

I don't see that the wake_wide() change has any effect here. None of the
sched domains has SD_BALANCE_WAKE set so a wakeup (WF_TTWU) can never
end up in the slow path.
Have you seen a diff when running your `lmbench stream` workload in what
wake_wide() returns when you use `sd cluster size` instead of `sd llc
size` as factor?

I guess for you,  wakeups are now subdivided into faster (cluster = 4
CPUs) and fast (llc = 24 CPUs) via sis(), not into fast (sis()) and slow
(find_idlest_cpu()).

>  
>  	if (master < slave)
>  		swap(master, slave);

[...]

> @@ -6745,6 +6748,12 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
>  	int want_affine = 0;
>  	/* SD_flags and WF_flags share the first nibble */
>  	int sd_flag = wake_flags & 0xF;
> +	/*
> +	 * if cpu and prev_cpu share LLC, consider cluster sibling rather
> +	 * than llc. this is typically true while tasks are bound within
> +	 * one numa
> +	 */
> +	int cluster = sched_cluster_active() && cpus_share_cache(cpu, prev_cpu, 0);

So you changed from scanning cluster before LLC to scan either cluster
or LLC.

And this is based on whether `this_cpu` and `prev_cpu` are sharing LLC
or not. So you only see an effect when running the workload with
`numactl -N X ...`.

>  
>  	if (wake_flags & WF_TTWU) {
>  		record_wakee(p);
> @@ -6756,7 +6765,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
>  			new_cpu = prev_cpu;
>  		}
>  
> -		want_affine = !wake_wide(p) && cpumask_test_cpu(cpu, p->cpus_ptr);
> +		want_affine = !wake_wide(p, cluster) && cpumask_test_cpu(cpu, p->cpus_ptr);
>  	}
>  
>  	rcu_read_lock();
> @@ -6768,7 +6777,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
>  		if (want_affine && (tmp->flags & SD_WAKE_AFFINE) &&
>  		    cpumask_test_cpu(prev_cpu, sched_domain_span(tmp))) {
>  			if (cpu != prev_cpu)
> -				new_cpu = wake_affine(tmp, p, cpu, prev_cpu, sync);
> +				new_cpu = wake_affine(tmp, p, cpu, prev_cpu, sync, cluster);
>  
>  			sd = NULL; /* Prefer wake_affine over balance flags */
>  			break;
> @@ -6785,7 +6794,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
>  		new_cpu = find_idlest_cpu(sd, p, cpu, prev_cpu, sd_flag);
>  	} else if (wake_flags & WF_TTWU) { /* XXX always ? */
>  		/* Fast path */
> -		new_cpu = select_idle_sibling(p, prev_cpu, new_cpu);
> +		new_cpu = select_idle_sibling(p, prev_cpu, new_cpu, cluster);
>  
>  		if (want_affine)
>  			current->recent_used_cpu = cpu;

[...]
