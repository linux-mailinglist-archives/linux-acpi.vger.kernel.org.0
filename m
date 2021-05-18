Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B7E4387999
	for <lists+linux-acpi@lfdr.de>; Tue, 18 May 2021 15:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349386AbhERNNg (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 18 May 2021 09:13:36 -0400
Received: from foss.arm.com ([217.140.110.172]:51750 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231490AbhERNNf (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 18 May 2021 09:13:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DA511D6E;
        Tue, 18 May 2021 06:12:17 -0700 (PDT)
Received: from e113632-lin (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6DD873F73B;
        Tue, 18 May 2021 06:12:16 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Ionela Voinescu <ionela.voinescu@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/3] arch_topology: obtain cpu capacity using information from CPPC
In-Reply-To: <20210514095339.12979-3-ionela.voinescu@arm.com>
References: <20210514095339.12979-1-ionela.voinescu@arm.com> <20210514095339.12979-3-ionela.voinescu@arm.com>
Date:   Tue, 18 May 2021 14:12:14 +0100
Message-ID: <87eee41901.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 14/05/21 10:53, Ionela Voinescu wrote:
> +#ifdef CONFIG_ACPI_CPPC_LIB
> +#include <acpi/cppc_acpi.h>
> +
> +void init_cpu_capacity_cppc(void)
> +{
> +	struct cppc_perf_caps perf_caps;
> +	int cpu;
> +
> +	if (likely(acpi_disabled || !acpi_cpc_valid()))
> +		return;
> +
> +	raw_capacity = kcalloc(num_possible_cpus(), sizeof(*raw_capacity),
> +			       GFP_KERNEL);

Per the below loop, the memory shouldn't need to be cleared.

> +	if (!raw_capacity)
> +		return;
> +
> +	for_each_possible_cpu(cpu) {
> +		if (!cppc_get_perf_caps(cpu, &perf_caps)) {
> +			raw_capacity[cpu] = perf_caps.highest_perf;
> +			pr_debug("%s: CPU%d cpu_capacity=%u (raw).\n",
> +				 __func__, cpu, raw_capacity[cpu]);
> +		} else {
> +			pr_err("%s: CPU%d missing highest performance.\n",
> +				 __func__, cpu);
> +			pr_err("%s: fallback to 1024 for all CPUs\n",
> +				 __func__);
> +			goto exit;
> +		}
> +	}
> +
> +	topology_normalize_cpu_scale();
> +	schedule_work(&update_topology_flags_work);
> +	pr_debug("%s: cpu_capacity initialization done\n", __func__);
> +
> +exit:
> +	free_raw_capacity();
> +}
> +#endif
