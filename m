Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9838380DFC
	for <lists+linux-acpi@lfdr.de>; Fri, 14 May 2021 18:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233266AbhENQSX (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 14 May 2021 12:18:23 -0400
Received: from foss.arm.com ([217.140.110.172]:52058 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233418AbhENQSP (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 14 May 2021 12:18:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1B6AD1764;
        Fri, 14 May 2021 09:17:04 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 302443F73B;
        Fri, 14 May 2021 09:17:02 -0700 (PDT)
Subject: Re: [PATCH 3/3] arm64, topology: enable use of
 init_cpu_capacity_cppc()
To:     Ionela Voinescu <ionela.voinescu@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20210514095339.12979-1-ionela.voinescu@arm.com>
 <20210514095339.12979-4-ionela.voinescu@arm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <97b515ea-3daa-5252-ca6b-1acacb0e5ade@arm.com>
Date:   Fri, 14 May 2021 18:17:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210514095339.12979-4-ionela.voinescu@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 14/05/2021 11:53, Ionela Voinescu wrote:

[...]

> +#ifdef CONFIG_ACPI_CPPC_LIB
> +#define arch_init_invariance_cppc init_cpu_capacity_cppc
> +#endif

The prefix `topology_` was meant to indicate that those functions come
from drivers/base/arch_topology.c. You probably refrained from it since

topology_init_cpu_capacity_cppc()

is a pretty long function name ... Still more consistent though.

[...]

