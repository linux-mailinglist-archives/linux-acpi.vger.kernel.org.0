Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 402B8388B04
	for <lists+linux-acpi@lfdr.de>; Wed, 19 May 2021 11:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231747AbhESJuG (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 19 May 2021 05:50:06 -0400
Received: from foss.arm.com ([217.140.110.172]:56788 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231150AbhESJuG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 19 May 2021 05:50:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 102BE101E;
        Wed, 19 May 2021 02:48:47 -0700 (PDT)
Received: from localhost (unknown [10.1.195.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A3B263F719;
        Wed, 19 May 2021 02:48:46 -0700 (PDT)
Date:   Wed, 19 May 2021 10:48:45 +0100
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/3] arm64, topology: enable use of
 init_cpu_capacity_cppc()
Message-ID: <20210519094845.GB21501@arm.com>
References: <20210514095339.12979-1-ionela.voinescu@arm.com>
 <20210514095339.12979-4-ionela.voinescu@arm.com>
 <97b515ea-3daa-5252-ca6b-1acacb0e5ade@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97b515ea-3daa-5252-ca6b-1acacb0e5ade@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Friday 14 May 2021 at 18:17:00 (+0200), Dietmar Eggemann wrote:
> On 14/05/2021 11:53, Ionela Voinescu wrote:
> 
> [...]
> 
> > +#ifdef CONFIG_ACPI_CPPC_LIB
> > +#define arch_init_invariance_cppc init_cpu_capacity_cppc
> > +#endif
> 
> The prefix `topology_` was meant to indicate that those functions come
> from drivers/base/arch_topology.c. You probably refrained from it since
> 
> topology_init_cpu_capacity_cppc()
> 
> is a pretty long function name ... Still more consistent though.
> 

I'll rename it, thanks!

Ionela.

> [...]
> 
