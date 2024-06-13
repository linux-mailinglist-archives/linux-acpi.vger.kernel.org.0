Return-Path: <linux-acpi+bounces-6371-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D8219069E7
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Jun 2024 12:25:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C45D1C21DF5
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Jun 2024 10:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00A8C142623;
	Thu, 13 Jun 2024 10:25:42 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23FC51422D3;
	Thu, 13 Jun 2024 10:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718274341; cv=none; b=S7On+OAqDm/94S4ESIJNoFul3xqs9IZhEbQ+yn9u9SUtSnCptxGW1wfvokcfhwqfuBwaCrZr50jiYzCggcXGNdmTejvPhqVqQbEXo9Yy/dK3HFsgOXZKufoBGs8JHF7ouCRCahQ5VIiRoYUxVEzFdtECd6MKc/Y4TEWunFg54XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718274341; c=relaxed/simple;
	bh=KtXAkkxHbXDmoA9cutCloZ9Q2FYGxfTpeV8PuyjnI28=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cty0giMZS4QnDdWp+pAmK1hZO10ARtQsaB8GAZpge16C4uc8c5sF9lKDNbxiHABJuKcEj8gqLvAUrlyy1EaDnUKsixOoTh8rcQLU315hmj7GMrmcImI0TMXevt6xZHIx5EF9lqroX4hAwrMrQH6fdDTHDs0KdKAoPkx0Wl+UPRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4W0JMj1zwXz6JB2R;
	Thu, 13 Jun 2024 18:20:49 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 0736C140A70;
	Thu, 13 Jun 2024 18:25:30 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 13 Jun
 2024 11:25:29 +0100
Date: Thu, 13 Jun 2024 11:25:27 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>, "Catalin
 Marinas" <catalin.marinas@arm.com>, <linux-acpi@vger.kernel.org>,
	<linux-arch@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
	<linuxarm@huawei.com>
CC: Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>, <loongarch@lists.linux.dev>,
	<x86@kernel.org>, Russell King <linux@armlinux.org.uk>, "Rafael J . Wysocki"
	<rafael@kernel.org>, "Miguel Luis" <miguel.luis@oracle.com>, James Morse
	<james.morse@arm.com>, "Salil Mehta" <salil.mehta@huawei.com>, Jean-Philippe
 Brucker <jean-philippe@linaro.org>, Hanjun Guo <guohanjun@huawei.com>, Gavin
 Shan <gshan@redhat.com>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	<justin.he@arm.com>, <jianyong.wu@arm.com>, Karl Heubaum
	<karl.heubaum@oracle.com>
Subject: Re: [PATCH v10 00/19] ACPI/arm64: add support for virtual cpu
 hotplug
Message-ID: <20240613112511.00006331@huawei.com>
In-Reply-To: <20240529133446.28446-1-Jonathan.Cameron@huawei.com>
References: <20240529133446.28446-1-Jonathan.Cameron@huawei.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Wed, 29 May 2024 14:34:27 +0100
Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

> v10:
> - Make acpi_processor_set_per_cpu() return 0 / error rather than bool
>   to simplify error handling at the call sites.
>   (Thanks to both Rafael and Gavin who commented on this)
> - Gather tags.
> - Rebase on v6.10-rc1
> 
> The approach to the GICv3 changes stablized very late in the 6.10 cycle.
> Subject to Marc taking a final look at those, I think we are now
> in a good state wrt to those and the ACPI parts. The remaining code
> that hasn't received review tags from the relevant maintainers
> is the arm64 specific arch_register_cpu().  Given I think this will go
> through the arm64 tree, hopefully they have just been waiting for
> everything else to be ready.

Marc, Will, Catalin,

Any comments on this series?  We definitely want to finally land this
in 6.11!

Marc, in practice I think you already gave feedback on the the GICv3
changes in here as part of the discussions in the earlier version threads,
but if you have time for a final glance through it would be much appreciated.
Thanks for all your earlier help on this btw.

Will, Catalin.  There is an arch part, however it's just avoiding (for now)
earlier approach of making this common to all architectures after push back
from Rafael on the ACPI part, so more of an architecture specific
implementation choice than really anything to do with the architecture.
I'm currently assuming this will go through your tree.

Thanks,

Jonathan

> 
> It is only arch specific to the extent that Rafael suggested we limit
> the potential impacts of the deferred calling of these functions
> to be isolated to ARM64 for now.  This is done by having them return
> -EPROBE_DEFER, on ACPI systems, until the ACPI interpreter is
> available and can be used to query _STA.
> 
> Thanks to everyone who has been involved in development, testing and
> review of this series - the complex tag chains reflect some of that.
> Fingers crossed we are approaching the end of this particular saga.
> 
> Updated version of James' original introduction.
> 
> This series adds what looks like cpuhotplug support to arm64 for use in
> virtual machines. It does this by moving the cpu_register() calls for
> architectures that support ACPI into an arch specific call made from
> the ACPI processor driver.
>  
> The kubernetes folk really want to be able to add CPUs to an existing VM,
> in exactly the same way they do on x86. The use-case is pre-booting guests
> with one CPU, then adding the number that were actually needed when the
> workload is provisioned.
> 
> Wait? Doesn't arm64 support cpuhotplug already!?
> In the arm world, cpuhotplug gets used to mean removing the power from a CPU.
> The CPU is offline, and remains present. For x86, and ACPI, cpuhotplug
> has the additional step of physically removing the CPU, so that it isn't
> present anymore.
>  
> Arm64 doesn't support this, and can't support it: CPUs are really a slice
> of the SoC, and there is not enough information in the existing ACPI tables
> to describe which bits of the slice also got removed. Without a reference
> machine: adding this support to the spec is a wild goose chase.
>  
> Critically: everything described in the firmware tables must remain present.
>  
> For a virtual machine this is easy as all the other bits of 'virtual SoC'
> are emulated, so they can (and do) remain present when a vCPU is 'removed'.
> 
> On a system that supports cpuhotplug the MADT has to describe every possible
> CPU at boot. Under KVM, the vGIC needs to know about every possible vCPU before
> the guest is started.
> With these constraints, virtual-cpuhotplug is really just a hypervisor/firmware
> policy about which CPUs can be brought online.
>  
> This series adds support for virtual-cpuhotplug as exactly that: firmware
> policy. This may even work on a physical machine too; for a guest the part of
> firmware is played by the VMM. (typically Qemu).
>  
> PSCI support is modified to return 'DENIED' if the CPU can't be brought
> online/enabled yet. The CPU object's _STA method's enabled bit is used to
> indicate firmware's current disposition. If the CPU has its enabled bit clear,
> it will not be registered with sysfs, and attempts to bring it online will
> fail. The notifications that _STA has changed its value then work in the same
> way as physical hotplug, and firmware can cause the CPU to be registered some
> time later, allowing it to be brought online.
>  
> This creates something that looks like cpuhotplug to user-space and the
> kernel beyond arm64 architecture specific code, as the sysfs
> files appear and disappear, and the udev notifications look the same.
>  
> One notable difference is the CPU present mask, which is exposed via sysfs.
> Because the CPUs remain present throughout, they can still be seen in that mask.
> This value does get used by webbrowsers to estimate the number of CPUs
> as the CPU online mask is constantly changed on mobile phones.
>  
> Linux is tolerant of PSCI returning errors, as its always been allowed to do
> that. To avoid confusing OS that can't tolerate this, we needed an additional
> bit in the MADT GICC flags. This series copies ACPI_MADT_ONLINE_CAPABLE, which
> appears to be for this purpose, but calls it ACPI_MADT_GICC_CPU_CAPABLE as it
> has a different bit position in the GICC.
>  
> This code is unconditionally enabled for all ACPI architectures, though for
> now only arm64 will have deferred the cpu_register() calls.
> 
> If folk want to play along at home, you'll need a copy of Qemu that supports this.
> https://github.com/salil-mehta/qemu.git virt-cpuhp-armv8/rfc-v2
> 
> Replace your '-smp' argument with something like:
>  | -smp cpus=1,maxcpus=3,cores=3,threads=1,sockets=1
>  
>  then feed the following to the Qemu montior;
>  | (qemu) device_add driver=host-arm-cpu,core-id=1,id=cpu1
>  | (qemu) device_del cpu1
> 
> James Morse (7):
>   ACPI: processor: Register deferred CPUs from acpi_processor_get_info()
>   ACPI: Add post_eject to struct acpi_scan_handler for cpu hotplug
>   arm64: acpi: Move get_cpu_for_acpi_id() to a header
>   irqchip/gic-v3: Don't return errors from gic_acpi_match_gicc()
>   irqchip/gic-v3: Add support for ACPI's disabled but 'online capable'
>     CPUs
>   arm64: document virtual CPU hotplug's expectations
>   cpumask: Add enabled cpumask for present CPUs that can be brought
>     online
> 
> Jean-Philippe Brucker (1):
>   arm64: psci: Ignore DENIED CPUs
> 
> Jonathan Cameron (11):
>   ACPI: processor: Simplify initial onlining to use same path for cold
>     and hotplug
>   cpu: Do not warn on arch_register_cpu() returning -EPROBE_DEFER
>   ACPI: processor: Drop duplicated check on _STA (enabled + present)
>   ACPI: processor: Return an error if acpi_processor_get_info() fails in
>     processor_add()
>   ACPI: processor: Fix memory leaks in error paths of processor_add()
>   ACPI: processor: Move checks and availability of acpi_processor
>     earlier
>   ACPI: processor: Add acpi_get_processor_handle() helper
>   ACPI: scan: switch to flags for acpi_scan_check_and_detach()
>   arm64: acpi: Harden get_cpu_for_acpi_id() against missing CPU entry
>   arm64: arch_register_cpu() variant to check if an ACPI handle is now
>     available.
>   arm64: Kconfig: Enable hotplug CPU on arm64 if ACPI_PROCESSOR is
>     enabled.
> 
>  .../ABI/testing/sysfs-devices-system-cpu      |   6 +
>  Documentation/arch/arm64/cpu-hotplug.rst      |  79 ++++++++++
>  Documentation/arch/arm64/index.rst            |   1 +
>  arch/arm64/Kconfig                            |   1 +
>  arch/arm64/include/asm/acpi.h                 |  12 ++
>  arch/arm64/kernel/acpi.c                      |  22 +++
>  arch/arm64/kernel/acpi_numa.c                 |  11 --
>  arch/arm64/kernel/psci.c                      |   2 +-
>  arch/arm64/kernel/smp.c                       |  59 +++++++-
>  drivers/acpi/acpi_processor.c                 | 141 ++++++++++--------
>  drivers/acpi/processor_core.c                 |   3 +-
>  drivers/acpi/processor_driver.c               |  43 ++----
>  drivers/acpi/scan.c                           |  47 +++++-
>  drivers/base/cpu.c                            |  12 +-
>  drivers/irqchip/irq-gic-v3.c                  |  57 +++++--
>  include/acpi/acpi_bus.h                       |   1 +
>  include/acpi/processor.h                      |   2 +-
>  include/linux/acpi.h                          |  12 +-
>  include/linux/cpumask.h                       |  25 ++++
>  kernel/cpu.c                                  |   3 +
>  20 files changed, 404 insertions(+), 135 deletions(-)
>  create mode 100644 Documentation/arch/arm64/cpu-hotplug.rst
> 


