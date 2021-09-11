Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCCB9407609
	for <lists+linux-acpi@lfdr.de>; Sat, 11 Sep 2021 12:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235559AbhIKKPi (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 11 Sep 2021 06:15:38 -0400
Received: from foss.arm.com ([217.140.110.172]:45396 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235443AbhIKKPi (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sat, 11 Sep 2021 06:15:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C8D351FB;
        Sat, 11 Sep 2021 03:14:25 -0700 (PDT)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0D71D3F5A1;
        Sat, 11 Sep 2021 03:14:23 -0700 (PDT)
Date:   Sat, 11 Sep 2021 11:14:18 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Jia He <justin.he@arm.com>, Will Deacon <will@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Harb Abdulhamid <harb@amperecomputing.com>
Subject: Re: [PATCH v2] Revert "ACPI: Add memory semantics to
 acpi_os_map_memory()"
Message-ID: <20210911101418.GA32028@lpieralisi>
References: <20210910122820.26886-1-justin.he@arm.com>
 <20210910143223.6705-1-justin.he@arm.com>
 <CAMj1kXG6Gu=g8P902NB2b+OvzqwJQPqQewYX5UwMiXALYAFkDw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXG6Gu=g8P902NB2b+OvzqwJQPqQewYX5UwMiXALYAFkDw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Sep 10, 2021 at 07:28:49PM +0200, Ard Biesheuvel wrote:
> On Fri, 10 Sept 2021 at 16:32, Jia He <justin.he@arm.com> wrote:
> >
> > This reverts commit 437b38c51162f8b87beb28a833c4d5dc85fa864e.
> >
> > After this commit, a boot panic is alway hit on an Ampere EMAG server
> > with call trace as follows:
> >  Internal error: synchronous external abort: 96000410 [#1] SMP
> >  Modules linked in:
> >  CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.14.0+ #462
> >  Hardware name: MiTAC RAPTOR EV-883832-X3-0001/RAPTOR, BIOS 0.14 02/22/2019
> >  pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> > [...snip...]
> >  Call trace:
> >   acpi_ex_system_memory_space_handler+0x26c/0x2c8
> >   acpi_ev_address_space_dispatch+0x228/0x2c4
> >   acpi_ex_access_region+0x114/0x268
> >   acpi_ex_field_datum_io+0x128/0x1b8
> >   acpi_ex_extract_from_field+0x14c/0x2ac
> >   acpi_ex_read_data_from_field+0x190/0x1b8
> >   acpi_ex_resolve_node_to_value+0x1ec/0x288
> >   acpi_ex_resolve_to_value+0x250/0x274
> >   acpi_ds_evaluate_name_path+0xac/0x124
> >   acpi_ds_exec_end_op+0x90/0x410
> >   acpi_ps_parse_loop+0x4ac/0x5d8
> >   acpi_ps_parse_aml+0xe0/0x2c8
> >   acpi_ps_execute_method+0x19c/0x1ac
> >   acpi_ns_evaluate+0x1f8/0x26c
> >   acpi_ns_init_one_device+0x104/0x140
> >   acpi_ns_walk_namespace+0x158/0x1d0
> >   acpi_ns_initialize_devices+0x194/0x218
> >   acpi_initialize_objects+0x48/0x50
> >   acpi_init+0xe0/0x498
> >
> > As mentioned by Lorenzo:
> >   "We are forcing memory semantics mappings to PROT_NORMAL_NC, which
> >   eMAG does not like at all and I'd need to understand why. It looks
> >   like the issue happen in SystemMemory Opregion handler."
> >
> > Hence just revert it before everything is clear.
> >
> 
> Can we try to find the root cause first? -rc1 is not even out yet, and
> reverting it now means we can not resubmit it until the next merge
> window.

Yes, absolutely. We need to understand where the problem is, because it
looks like we can't map SystemMemory Opregion with NORMAL_NC if the PA
is not in the EFI map, that's a problem (ie how can we determine the
right memory attributes for SystemMemory Operation regions then) but
let's not speculate and find what the issue is first.

Lorenzo
