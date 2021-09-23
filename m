Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E50EB415FC0
	for <lists+linux-acpi@lfdr.de>; Thu, 23 Sep 2021 15:28:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241176AbhIWN3c (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 23 Sep 2021 09:29:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:42696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241259AbhIWN3a (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 23 Sep 2021 09:29:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4AB9361107;
        Thu, 23 Sep 2021 13:27:56 +0000 (UTC)
Date:   Thu, 23 Sep 2021 14:27:53 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Jia He <justin.he@arm.com>
Cc:     Will Deacon <will@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Ard Biesheuvel <ardb@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, devel@acpica.org,
        Jeremy Linton <jeremy.linton@arm.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Harb Abdulhamid <harb@amperecomputing.com>
Subject: Re: [PATCH v3] Revert "ACPI: Add memory semantics to
 acpi_os_map_memory()"
Message-ID: <YUyA2U8H0vLEqr3/@arm.com>
References: <20210923033557.19100-1-justin.he@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210923033557.19100-1-justin.he@arm.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Sep 23, 2021 at 11:35:57AM +0800, Jia He wrote:
> This reverts commit 437b38c51162f8b87beb28a833c4d5dc85fa864e.
> 
> The memory semantics added in commit 437b38c51162 causes SystemMemory
> Operation region, whose address range is not described in the EFI memory
> map to be mapped as NormalNC memory on arm64 platforms (through
> acpi_os_map_memory() in acpi_ex_system_memory_space_handler()).
> 
> This triggers the following abort on an ARM64 Ampere eMAG machine,
> because presumably the physical address range area backing the Opregion
> does not support NormalNC memory attributes driven on the bus.
> 
>  Internal error: synchronous external abort: 96000410 [#1] SMP
>  Modules linked in:
>  CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.14.0+ #462
>  Hardware name: MiTAC RAPTOR EV-883832-X3-0001/RAPTOR, BIOS 0.14 02/22/2019
>  pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [...snip...]
>  Call trace:
>   acpi_ex_system_memory_space_handler+0x26c/0x2c8
>   acpi_ev_address_space_dispatch+0x228/0x2c4
>   acpi_ex_access_region+0x114/0x268
>   acpi_ex_field_datum_io+0x128/0x1b8
>   acpi_ex_extract_from_field+0x14c/0x2ac
>   acpi_ex_read_data_from_field+0x190/0x1b8
>   acpi_ex_resolve_node_to_value+0x1ec/0x288
>   acpi_ex_resolve_to_value+0x250/0x274
>   acpi_ds_evaluate_name_path+0xac/0x124
>   acpi_ds_exec_end_op+0x90/0x410
>   acpi_ps_parse_loop+0x4ac/0x5d8
>   acpi_ps_parse_aml+0xe0/0x2c8
>   acpi_ps_execute_method+0x19c/0x1ac
>   acpi_ns_evaluate+0x1f8/0x26c
>   acpi_ns_init_one_device+0x104/0x140
>   acpi_ns_walk_namespace+0x158/0x1d0
>   acpi_ns_initialize_devices+0x194/0x218
>   acpi_initialize_objects+0x48/0x50
>   acpi_init+0xe0/0x498
> 
> If the Opregion address range is not present in the EFI memory map there
> is no way for us to determine the memory attributes to use to map it -
> defaulting to NormalNC does not work (and it is not correct on a memory
> region that may have read side-effects) and therefore commit
> 437b38c51162 should be reverted, which means reverting back to the
> original behavior whereby address ranges that are mapped using
> acpi_os_map_memory() default to the safe devicenGnRnE attributes on
> ARM64 if the mapped address range is not defined in the EFI memory map.
> 
> Fixes: 437b38c51162 ("ACPI: Add memory semantics to acpi_os_map_memory()")
> Signed-off-by: Jia He <justin.he@arm.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: Hanjun Guo <guohanjun@huawei.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Cc: Harb Abdulhamid <harb@amperecomputing.com>

Since I acked the original patch, I'm acking its revert as well:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
