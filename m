Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B463E2CA7B7
	for <lists+linux-acpi@lfdr.de>; Tue,  1 Dec 2020 17:05:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389215AbgLAQEm (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 1 Dec 2020 11:04:42 -0500
Received: from foss.arm.com ([217.140.110.172]:45396 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388988AbgLAQEl (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 1 Dec 2020 11:04:41 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 71A2F101E;
        Tue,  1 Dec 2020 08:03:55 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B232E3F575;
        Tue,  1 Dec 2020 08:03:52 -0800 (PST)
References: <20201201025944.18260-1-song.bao.hua@hisilicon.com> <20201201025944.18260-2-song.bao.hua@hisilicon.com>
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
Subject: Re: [RFC PATCH v2 1/2] topology: Represent clusters of CPUs within a die.
In-reply-to: <20201201025944.18260-2-song.bao.hua@hisilicon.com>
Date:   Tue, 01 Dec 2020 16:03:46 +0000
Message-ID: <jhj360pv7h9.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


On 01/12/20 02:59, Barry Song wrote:
> That means the cost to transfer ownership of a cacheline between CPUs
> within a cluster is lower than between CPUs in different clusters on
> the same die. Hence, it can make sense to tell the scheduler to use
> the cache affinity of the cluster to make better decision on thread
> migration.
>
> This patch simply exposes this information to userspace libraries
> like hwloc by providing cluster_cpus and related sysfs attributes.
> PoC of HWLOC support at [2].
>
> Note this patch only handle the ACPI case.
>

AIUI this requires PPTT to describe your system like so:

 {Processor nodes}             {Caches}

       [Node0] ----------------> [L3]
          ^
          |
      [Cluster0] ---------------> []
          ^
          |
        [CPU0] ------------> [L1] -> [L2]

which is a bit odd, because there is that middling level without any
private resources. I suppose right now this is the only way to describe
this kind of cache topology via PPTT, but is that widespread?


Now, looking at the Ampere eMAG's PPTT, this has a "similar" shape. The
topology is private L1, L2 shared by pairs of CPUs, shared L3 [1].

If I parse the PPTT thing right this is encoded as:

 {Processor nodes}            {Caches}

      [Cluster0] -------------> ([L3] not present in my PPTT for some reason)
          ^
          |
      [  Pair0  ] ------------> [L2]
        ^     ^
        |     |
        |  [CPU1] ------------> [L1]
      [CPU0] -----------------> [L1] 

So you could spin the same story there were first scanning the pair and
then the cluster could help.

[1]: https://en.wikichip.org/wiki/ampere_computing/emag/8180

> Special consideration is needed for SMT processors, where it is
> necessary to move 2 levels up the hierarchy from the leaf nodes
> (thus skipping the processor core level).
>
> Currently the ID provided is the offset of the Processor
> Hierarchy Nodes Structure within PPTT.  Whilst this is unique
> it is not terribly elegant so alternative suggestions welcome.
>

Skimming through the spec, this sounds like something the ID structure
(Type 2) could be used for. However in v1 Jonathan and Sudeep talked about
UID's / DSDT, any news on that?

> Note that arm64 / ACPI does not provide any means of identifying
> a die level in the topology but that may be unrelate to the cluster
> level.
>
> [1] ACPI Specification 6.3 - section 5.2.29.1 processor hierarchy node
>     structure (Type 0)
> [2] https://github.com/hisilicon/hwloc/tree/linux-cluster
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
