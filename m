Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA9B542DE9E
	for <lists+linux-acpi@lfdr.de>; Thu, 14 Oct 2021 17:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbhJNPvO (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 14 Oct 2021 11:51:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:44912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229637AbhJNPvO (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 14 Oct 2021 11:51:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 20C1061056;
        Thu, 14 Oct 2021 15:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634226548;
        bh=a3JcxM71CVB05VvViVHQVBOD6Bz6eNuIKXi1gKlyjjg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=MwTdX/IgGRWJ//0GUeNWVRl+i9DLeNaIKn2uFD+EzaiCJiEpiyPMR3JORWiF+fpiR
         ZDCOt+71+7J03w+bmjJNO8y9Iw6c+jT5+YxiiXTH9X06KqlTiNRclL7vRq5v9ppYaH
         JJUx7jwD3FqAy0+MOdVlYsW6ZXbiBCXkNnELlgZXkMl+N5xPert5E5oJDJK+TOT5r3
         iAKX9DpMamZapJMJ5ys/28rtSPSQyXEZCOeBN8iH+NosFMGw1399BL84IBxIFUExAz
         HzVForcPMsxrSz9IK0+PSp/u3Cln/+HyhRyhxe1wAHJ3AIDXD0C1bUS32lA4FZNPae
         gNFBRTbffxKrw==
Date:   Thu, 14 Oct 2021 10:49:06 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Myron Stowe <myron.stowe@redhat.com>,
        Juha-Pekka Heikkila <juhapekka.heikkila@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Benoit =?iso-8859-1?Q?Gr=E9goire?= <benoitg@coeus.ca>,
        Hui Wang <hui.wang@canonical.com>
Subject: Re: [PATCH v3] x86/PCI: Ignore E820 reservations for bridge windows
 on newer systems
Message-ID: <20211014154906.GA2029160@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211014110357.17957-1-hdegoede@redhat.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Oct 14, 2021 at 01:03:57PM +0200, Hans de Goede wrote:
> Some BIOS-es contain a bug where they add addresses which map to system RAM
> in the PCI bridge memory window returned by the ACPI _CRS method, see
> commit 4dc2287c1805 ("x86: avoid E820 regions when allocating address
> space").
> 
> To avoid this Linux by default excludes E820 reservations when allocating
> addresses since 2010. Windows however ignores E820 reserved regions for PCI
> mem allocations, so in hindsight Linux honoring them is a problem.

This is a problem not because Windows ignores E820, but because the
spec does not support excluding based on E820.  We should cite the
spec and include the relevant text here.

> Recently (2020) some systems have shown-up with E820 reservations which
> cover the entire _CRS returned PCI bridge memory window, causing all
> attempts to assign memory to PCI BARs which have not been setup by the
> BIOS to fail. For example here are the relevant dmesg bits from a
> Lenovo IdeaPad 3 15IIL 81WE:
> 
>  [mem 0x000000004bc50000-0x00000000cfffffff] reserved
>  pci_bus 0000:00: root bus resource [mem 0x65400000-0xbfffffff window]
> 
> Ideally Linux would fully stop honoring E820 reservations for PCI mem
> allocations, but then the old systems this was added for will regress.
> Instead keep the old behavior for old systems, while ignoring the E820
> reservations like Windows does for any systems from now on.
> 
> Old systems are defined here as BIOS year < 2018, this was chosen to
> make sure that pci_use_e820 will not be set on the currently affected
> systems, while at the same time also taking into account that the
> systems for which the E820 checking was originally added may have
> received BIOS updates for quite a while (esp. CVE related ones),
> giving them a more recent BIOS year then 2010.
> 
> Also add pci=no_e820 and pci=use_e820 options to allow overriding
> the BIOS year heuristic.
> 
> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=206459
> BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1868899
> BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1871793
> BugLink: https://bugs.launchpad.net/bugs/1878279
> BugLink: https://bugs.launchpad.net/bugs/1931715
> BugLink: https://bugs.launchpad.net/bugs/1932069
> BugLink: https://bugs.launchpad.net/bugs/1921649
> Cc: Benoit Gr�goire <benoitg@coeus.ca>
> Cc: Hui Wang <hui.wang@canonical.com>
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v3:
> - Commit msg tweaks (drop dmesg timestamps, typo fix)
> - Use "defined(CONFIG_...)" instead of "defined CONFIG_..."
> - Add Mika's Reviewed-by
> 
> Changes in v2:
> - Replace the per model DMI quirk approach with disabling E820 reservations
>   checking for all systems with a BIOS year >= 2018
> - Add documentation for the new kernel-parameters to
>   Documentation/admin-guide/kernel-parameters.txt
> ---
> Other patches trying to address the same issue:
> https://lore.kernel.org/r/20210624095324.34906-1-hui.wang@canonical.com
> https://lore.kernel.org/r/20200617164734.84845-1-mika.westerberg@linux.intel.com
> V1 patch:
> https://lore.kernel.org/r/20211005150956.303707-1-hdegoede@redhat.com
> ---
>  .../admin-guide/kernel-parameters.txt         |  6 ++++
>  arch/x86/include/asm/pci_x86.h                | 10 +++++++
>  arch/x86/kernel/resource.c                    |  4 +++
>  arch/x86/pci/acpi.c                           | 29 +++++++++++++++++++
>  arch/x86/pci/common.c                         |  6 ++++
>  5 files changed, 55 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 43dc35fe5bc0..969cde5d74c8 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -3949,6 +3949,12 @@
>  				please report a bug.
>  		nocrs		[X86] Ignore PCI host bridge windows from ACPI.
>  				If you need to use this, please report a bug.
> +		use_e820	[X86] Honor E820 reservations when allocating
> +				PCI host bridge memory. If you need to use this,
> +				please report a bug.
> +		no_e820		[X86] ignore E820 reservations when allocating
> +				PCI host bridge memory. If you need to use this,
> +				please report a bug.

Inconsistent capitalization.

Should use same terminology as nocrs, i.e., "PCI host bridge windows",
not "PCI host bridge memory".

I don't think "Honor E820 reservations" is the right way to describe
this.  It's not a question of upholding something we *should* be
doing.  That would be a matter of working around a BIOS defect.
Maybe something like this:

  Use E820 reservations to exclude parts of PCI host bridge windows.
  This is a workaround for BIOS defects in host bridge _CRS methods.
  If you need to use this, please report a bug to
  linux-pci@vger.kernel.org so we can apply it automatically.

Not 100% sure we need "no_e820" since that should be the default.  But
I guess it's conceivable some system might need it.  I just hate
adding additional things for people to try and then spread the
resulting misinformation as a "fix" on random forums.

>  		routeirq	Do IRQ routing for all PCI devices.
>  				This is normally done in pci_enable_device(),
>  				so this option is a temporary workaround
> diff --git a/arch/x86/include/asm/pci_x86.h b/arch/x86/include/asm/pci_x86.h
> index 490411dba438..0bb4e7dd0ffc 100644
> --- a/arch/x86/include/asm/pci_x86.h
> +++ b/arch/x86/include/asm/pci_x86.h
> @@ -39,6 +39,8 @@ do {						\
>  #define PCI_ROOT_NO_CRS		0x100000
>  #define PCI_NOASSIGN_BARS	0x200000
>  #define PCI_BIG_ROOT_WINDOW	0x400000
> +#define PCI_USE_E820		0x800000
> +#define PCI_NO_E820		0x1000000
>  
>  extern unsigned int pci_probe;
>  extern unsigned long pirq_table_addr;
> @@ -64,6 +66,8 @@ void pcibios_scan_specific_bus(int busn);
>  
>  /* pci-irq.c */
>  
> +struct pci_dev;
> +
>  struct irq_info {
>  	u8 bus, devfn;			/* Bus, device and function */
>  	struct {
> @@ -232,3 +236,9 @@ static inline void mmio_config_writel(void __iomem *pos, u32 val)
>  # define x86_default_pci_init_irq	NULL
>  # define x86_default_pci_fixup_irqs	NULL
>  #endif
> +
> +#if defined(CONFIG_PCI) && defined(CONFIG_ACPI)
> +extern bool pci_use_e820;
> +#else
> +#define pci_use_e820 false
> +#endif
> diff --git a/arch/x86/kernel/resource.c b/arch/x86/kernel/resource.c
> index 9b9fb7882c20..e8dc9bc327bd 100644
> --- a/arch/x86/kernel/resource.c
> +++ b/arch/x86/kernel/resource.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include <linux/ioport.h>
>  #include <asm/e820/api.h>
> +#include <asm/pci_x86.h>
>  
>  static void resource_clip(struct resource *res, resource_size_t start,
>  			  resource_size_t end)
> @@ -28,6 +29,9 @@ static void remove_e820_regions(struct resource *avail)
>  	int i;
>  	struct e820_entry *entry;
>  
> +	if (!pci_use_e820)
> +		return;
> +
>  	for (i = 0; i < e820_table->nr_entries; i++) {
>  		entry = &e820_table->entries[i];
>  
> diff --git a/arch/x86/pci/acpi.c b/arch/x86/pci/acpi.c
> index 948656069cdd..6c2febe84b6f 100644
> --- a/arch/x86/pci/acpi.c
> +++ b/arch/x86/pci/acpi.c
> @@ -21,6 +21,8 @@ struct pci_root_info {
>  
>  static bool pci_use_crs = true;
>  static bool pci_ignore_seg = false;
> +/* Consumed in arch/x86/kernel/resource.c */
> +bool pci_use_e820 = false;
>  
>  static int __init set_use_crs(const struct dmi_system_id *id)
>  {
> @@ -160,6 +162,33 @@ void __init pci_acpi_crs_quirks(void)
>  	       "if necessary, use \"pci=%s\" and report a bug\n",
>  	       pci_use_crs ? "Using" : "Ignoring",
>  	       pci_use_crs ? "nocrs" : "use_crs");
> +
> +	/*
> +	 * Some BIOS-es contain a bug where they add addresses which map to system
> +	 * RAM in the PCI bridge memory window returned by the ACPI _CRS method, see
> +	 * commit 4dc2287c1805 ("x86: avoid E820 regions when allocating address space").
> +	 * To avoid this Linux by default excludes E820 reservations when allocating
> +	 * addresses since 2010. Windows however ignores E820 reserved regions for
> +	 * PCI mem allocations, so in hindsight Linux honoring them is a problem.
> +	 * In 2020 some systems have shown-up with E820 reservations which cover the
> +	 * entire _CRS returned PCI bridge memory window, causing all attempts to
> +	 * assign memory to PCI BARs to fail if Linux honors the E820 reservations.
> +	 *
> +	 * Ideally Linux would fully stop honoring E820 reservations for PCI mem
> +	 * allocations, but then the old systems this was added for will regress.
> +	 * Instead keep the old behavior for old systems, while ignoring the E820
> +	 * reservations like Windows does for any systems from now on.

Wrap this to fit in 80 columns like the rest of the file.  More
important for the file to be internally consistent than any new
guidelines.

> +	 */
> +	if (year >= 0 && year < 2018)
> +		pci_use_e820 = true;
> +
> +	if (pci_probe & PCI_NO_E820)
> +		pci_use_e820 = false;
> +	else if (pci_probe & PCI_USE_E820)
> +		pci_use_e820 = true;
> +
> +	printk(KERN_INFO "PCI: %s E820 reservations for host bridge windows\n",
> +	       pci_use_e820 ? "Honoring" : "Ignoring");
>  }
>  
>  #ifdef	CONFIG_PCI_MMCONFIG
> diff --git a/arch/x86/pci/common.c b/arch/x86/pci/common.c
> index 3507f456fcd0..091ec7e94fcb 100644
> --- a/arch/x86/pci/common.c
> +++ b/arch/x86/pci/common.c
> @@ -595,6 +595,12 @@ char *__init pcibios_setup(char *str)
>  	} else if (!strcmp(str, "nocrs")) {
>  		pci_probe |= PCI_ROOT_NO_CRS;
>  		return NULL;
> +	} else if (!strcmp(str, "use_e820")) {
> +		pci_probe |= PCI_USE_E820;
> +		return NULL;
> +	} else if (!strcmp(str, "no_e820")) {
> +		pci_probe |= PCI_NO_E820;
> +		return NULL;

Why does pci_probe have to be involved here?  Couldn't we just set
pci_use_e820 directly?

Same argument applies to PCI_USE__CRS and PCI_ROOT_NO_CRS of course,
and I probably added those, so maybe there was a reason, or maybe I
just screwed up that too.

>  #ifdef CONFIG_PHYS_ADDR_T_64BIT
>  	} else if (!strcmp(str, "big_root_window")) {
>  		pci_probe |= PCI_BIG_ROOT_WINDOW;
> -- 
> 2.31.1
> 
