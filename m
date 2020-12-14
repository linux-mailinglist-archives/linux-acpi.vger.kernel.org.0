Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E79A82D9C3E
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Dec 2020 17:15:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407329AbgLNQOD (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 14 Dec 2020 11:14:03 -0500
Received: from mx2.suse.de ([195.135.220.15]:35218 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2440048AbgLNQMq (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 14 Dec 2020 11:12:46 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B7A35AC7F;
        Mon, 14 Dec 2020 16:12:04 +0000 (UTC)
Date:   Mon, 14 Dec 2020 17:11:58 +0100
From:   Mian Yousaf Kaukab <ykaukab@suse.de>
To:     Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     rjw@rjwysocki.net, viresh.kumar@linaro.org, lenb@kernel.org,
        yousaf.kaukab@suse.com, jeremy.linton@arm.com, lukasz.luba@arm.com,
        valentin.schneider@arm.com, linux-acpi@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/4]  cppc_cpufreq: fix, clarify and improve support
Message-ID: <20201214161158.GA11066@suse.de>
References: <20201214123823.3949-1-ionela.voinescu@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201214123823.3949-1-ionela.voinescu@arm.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Dec 14, 2020 at 12:38:19PM +0000, Ionela Voinescu wrote:
> Hi guys,
> 
> I'm sending v2 of some of the patches at [1] in light of the discussions
> at [2].
> 
> v2:
>  - Patches 1-3 are trivial rebase on linux next 20201211, with conflicts
>    fixed after eliminating what previously was "[PATCH 4/8] cppc_cpufreq:
>    replace per-cpu structures with lists." Therefore, I have kept
>    Viresh's acks.
> 
>  - Patch 4 is a merge between:
>      - [PATCH 4/8] cppc_cpufreq: replace per-cpu structures with lists
>      - [PATCH] cppc_cpufreq: optimise memory allocation for HW and NONE
>        coordination
>    both found at [1].
> 
>    This functionality was introducing the problem at [2] and it's fixed
>    in this version by bailing out of driver registration if a _CPC entry
>    is not found for a CPU.
> 
>    Yousaf, it would be great if you can test this and make sure it
>    matches your expectations.
> 
>    Rafael, Viresh if you think this last patch introduces too many
>    changes, you can skip it for 5.11 which is around the corner and
>    have more time for review for 5.12. I've added more eyes in the review
>    list.
> 
> 
> All patches are based on linux next 20201211 after patch at [3] is
> applied.
> 
> [1] https://lore.kernel.org/linux-pm/20201105125524.4409-1-ionela.voinescu@arm.com/#t
> [2] https://lore.kernel.org/linux-pm/20201210142139.20490-1-yousaf.kaukab@suse.com/
> [3] https://lore.kernel.org/linux-pm/20201214120740.10948-1-ionela.voinescu@arm.com/
> 
> Ionela Voinescu (4):
>   cppc_cpufreq: use policy->cpu as driver of frequency setting
>   cppc_cpufreq: clarify support for coordination types
>   cppc_cpufreq: expose information on frequency domains
>   cppc_cpufreq: replace per-cpu data array with a list
> 
>  .../ABI/testing/sysfs-devices-system-cpu      |   3 +-
>  drivers/acpi/cppc_acpi.c                      | 141 ++++++------
>  drivers/cpufreq/cppc_cpufreq.c                | 204 ++++++++++--------
>  include/acpi/cppc_acpi.h                      |   6 +-
>  4 files changed, 181 insertions(+), 173 deletions(-)

For the whole series:
Tested-by: Mian Yousaf Kaukab <ykaukab@suse.de>
