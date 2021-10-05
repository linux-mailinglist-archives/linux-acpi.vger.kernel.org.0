Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65A26422E08
	for <lists+linux-acpi@lfdr.de>; Tue,  5 Oct 2021 18:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236088AbhJEQgC (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 5 Oct 2021 12:36:02 -0400
Received: from foss.arm.com ([217.140.110.172]:42440 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230445AbhJEQgC (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 5 Oct 2021 12:36:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4E4406D;
        Tue,  5 Oct 2021 09:34:11 -0700 (PDT)
Received: from e113632-lin (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1F0733F766;
        Tue,  5 Oct 2021 09:34:07 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Barry Song <21cnbao@gmail.com>, dietmar.eggemann@arm.com,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, vincent.guittot@linaro.org
Cc:     aubrey.li@linux.intel.com, bp@alien8.de, bristot@redhat.com,
        bsegall@google.com, catalin.marinas@arm.com,
        gregkh@linuxfoundation.org, guodong.xu@linaro.org, hpa@zytor.com,
        jonathan.cameron@huawei.com, juri.lelli@redhat.com,
        lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linuxarm@huawei.com,
        mark.rutland@arm.com, mgorman@suse.de, msys.mizuma@gmail.com,
        prime.zeng@hisilicon.com, rjw@rjwysocki.net, rostedt@goodmis.org,
        song.bao.hua@hisilicon.com, sudeep.holla@arm.com,
        tglx@linutronix.de, rafael@kernel.org, tim.c.chen@linux.intel.com,
        will@kernel.org, x86@kernel.org, yangyicong@huawei.com,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Tian Tao <tiantao6@hisilicon.com>
Subject: Re: [PATCH RESEND 1/3] topology: Represent clusters of CPUs within a die
In-Reply-To: <20210924085104.44806-2-21cnbao@gmail.com>
References: <20210924085104.44806-1-21cnbao@gmail.com> <20210924085104.44806-2-21cnbao@gmail.com>
Date:   Tue, 05 Oct 2021 17:33:59 +0100
Message-ID: <87o883l9c8.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 24/09/21 20:51, Barry Song wrote:
>  void update_siblings_masks(unsigned int cpuid)
>  {
>       struct cpu_topology *cpu_topo, *cpuid_topo = &cpu_topology[cpuid];
> @@ -617,6 +622,11 @@ void update_siblings_masks(unsigned int cpuid)
>               if (cpuid_topo->package_id != cpu_topo->package_id)
>                       continue;
>
> +		if (cpuid_topo->cluster_id == cpu_topo->cluster_id) {
> +			cpumask_set_cpu(cpu, &cpuid_topo->cluster_sibling);
> +			cpumask_set_cpu(cpuid, &cpu_topo->cluster_sibling);
> +		}
> +

Hm so without cluster information (e.g. DT system), we have
->cluster_id=-1, we'll essentially copy the package mask into the cluster
mask.

The exposed cluster mask is still <= package mask which is sensible. Are we
fine with that, or do we need/want the mask to be empty in the -1 case? I'm
guessing userspace tools should check for either id!=-1 or if the exclusive
disjucntion of cluster vs package masks is non-empty.
