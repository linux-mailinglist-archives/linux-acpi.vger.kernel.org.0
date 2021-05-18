Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 505C1387997
	for <lists+linux-acpi@lfdr.de>; Tue, 18 May 2021 15:12:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349405AbhERNN3 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 18 May 2021 09:13:29 -0400
Received: from foss.arm.com ([217.140.110.172]:51732 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231490AbhERNN3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 18 May 2021 09:13:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 31A93D6E;
        Tue, 18 May 2021 06:12:11 -0700 (PDT)
Received: from e113632-lin (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B68D83F73B;
        Tue, 18 May 2021 06:12:09 -0700 (PDT)
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
Subject: Re: [PATCH 0/3] arch_topology, ACPI: populate cpu capacity from CPPC
In-Reply-To: <20210514095339.12979-1-ionela.voinescu@arm.com>
References: <20210514095339.12979-1-ionela.voinescu@arm.com>
Date:   Tue, 18 May 2021 14:12:03 +0100
Message-ID: <87fsyk190c.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 14/05/21 10:53, Ionela Voinescu wrote:
> Hi all,
>
> These are a few trivial patches to populate cpu capacity information
> using performance information from ACPI's CPPC.
>
> I've tied this functionality to the existing function
> init_freq_invariance_cppc() called in acpi_cppc_processor_probe().
> This function is renamed to a more generic arch_init_invariance_cppc().
>
> The patches have been build tested on x86 and more thoroughly tested on
> Juno R2 (arm64), which uses the new functionality, with the following
> results:
>
>
> root@ubuntu:~# dmesg | grep cpu_capacity
> [    2.157494] init_cpu_capacity_cppc: CPU0 cpu_capacity=38300 (raw).
> [    2.163699] init_cpu_capacity_cppc: CPU1 cpu_capacity=38300 (raw).
> [    2.169899] init_cpu_capacity_cppc: CPU2 cpu_capacity=38300 (raw).
> [    2.176098] init_cpu_capacity_cppc: CPU3 cpu_capacity=38300 (raw).
> [    2.182296] init_cpu_capacity_cppc: CPU4 cpu_capacity=102400 (raw).
> [    2.188581] init_cpu_capacity_cppc: CPU5 cpu_capacity=102400 (raw).
> [    2.194867] cpu_capacity: capacity_scale=102400
> [    2.199409] cpu_capacity: CPU0 cpu_capacity=383
> [    2.203952] cpu_capacity: CPU1 cpu_capacity=383
> [    2.208495] cpu_capacity: CPU2 cpu_capacity=383
> [    2.213037] cpu_capacity: CPU3 cpu_capacity=383
> [    2.217580] cpu_capacity: CPU4 cpu_capacity=1024
> [    2.222209] cpu_capacity: CPU5 cpu_capacity=1024
> [    2.226886] init_cpu_capacity_cppc: cpu_capacity initialization done
>
> root@ubuntu:~# tail -n +1 /sys/devices/system/cpu/cpu*/cpu_capacity
> ==> /sys/devices/system/cpu/cpu0/cpu_capacity <==
> 383
> ==> /sys/devices/system/cpu/cpu1/cpu_capacity <==
> 383
> ==> /sys/devices/system/cpu/cpu2/cpu_capacity <==
> 383
> ==> /sys/devices/system/cpu/cpu3/cpu_capacity <==
> 383
> ==> /sys/devices/system/cpu/cpu4/cpu_capacity <==
> 1024
> ==> /sys/devices/system/cpu/cpu5/cpu_capacity <==
> 1024
>
> All works as expected even if ACPI processor support is built as a
> module.
>

Tested on my Ampere eMAG; this all seems to work fine except for some
scheduler debug stuff that gets confused; see

  http://lore.kernel.org/r/20210518130725.3563132-1-valentin.schneider@arm.com

With that in mind:
Tested-by: Valentin Schneider <valentin.schneider@arm.com>
