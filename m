Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A56B042DC18
	for <lists+linux-acpi@lfdr.de>; Thu, 14 Oct 2021 16:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbhJNOzb convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Thu, 14 Oct 2021 10:55:31 -0400
Received: from mail-ot1-f44.google.com ([209.85.210.44]:40759 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231894AbhJNOza (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 14 Oct 2021 10:55:30 -0400
Received: by mail-ot1-f44.google.com with SMTP id s18-20020a0568301e1200b0054e77a16651so8560974otr.7;
        Thu, 14 Oct 2021 07:53:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=o/tgaaJBpU01iDTOgSWsceoICPpmbYuVbW0XGR9rgOc=;
        b=Osn61shf9bSFVJzJiOr1OOPwTdE5HcP7N8iTMlf2xOXT5hihlpUYgt2/qlaulqek4L
         vZroZoXn5L6THE9VZ1T4EZd1EVc9gRCrDngSQbzLKbI0UhC5Ui5FLpfQCQuSmyAhrNLx
         4QU0i9NqPaQA9mTNqb0zwlIPdXBiL+I294dH6fIszXWLMIkCiukPoGX8iEM2I1cZsfU7
         q7N3ntQhWrKb461BIczm4YT9mRA3EPca2u0gyd6Qpd3lFjd2oEfYPtVOSOiaj26DoePD
         N5BIYle5Dbe7++Vsei/9KNnj+oz21Q/L5TZshNbXEZ1ynXvcQgpH1jjcCJ7hsEWc+d8w
         JnSA==
X-Gm-Message-State: AOAM530hIkpWZCLCeOsAuDZBnpfX7MKwPxklE/7107GMCT6wq7zOdhG2
        wl7hHxluUHW3U+b+7mXooqELzsasqBi4Skq8RdxgGyD8
X-Google-Smtp-Source: ABdhPJxplpUm5m+oFNv68uD8CD5oq/TRTPYSGiS4gLpSbtWglHcpKbGk5NO9n//6Fc1ghB6wz+HOS8lLkcjdnvzN6H0=
X-Received: by 2002:a9d:65c1:: with SMTP id z1mr2768080oth.198.1634223204005;
 Thu, 14 Oct 2021 07:53:24 -0700 (PDT)
MIME-Version: 1.0
References: <20211014110357.17957-1-hdegoede@redhat.com> <CAJZ5v0hiQXhLs4Y2ij_8YaVupmWYdTEYBpJLFg1CPk6RocP1_A@mail.gmail.com>
 <22c25ecc-c43e-53e6-0aa1-51e548406363@redhat.com> <CAJZ5v0jXEHtuXE0ByHxNYzMiaVN=yL4P-0N1-8RhKQVb16H=3g@mail.gmail.com>
 <ecf473c8-233e-50c3-ce3c-99bc2f4accd8@redhat.com>
In-Reply-To: <ecf473c8-233e-50c3-ce3c-99bc2f4accd8@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 14 Oct 2021 16:53:12 +0200
Message-ID: <CAJZ5v0jCpcv2U1xVrHZLzXSuyxNBAw4SUnZ57RfBzMAHS2o7_A@mail.gmail.com>
Subject: Re: [PATCH v3] x86/PCI: Ignore E820 reservations for bridge windows
 on newer systems
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Myron Stowe <myron.stowe@redhat.com>,
        Juha-Pekka Heikkila <juhapekka.heikkila@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Benoit_Gr=C3=A9goire?= <benoitg@coeus.ca>,
        Hui Wang <hui.wang@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Oct 14, 2021 at 4:21 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 10/14/21 2:06 PM, Rafael J. Wysocki wrote:
> > On Thu, Oct 14, 2021 at 1:24 PM Hans de Goede <hdegoede@redhat.com> wrote:
> >>
> >> Hi,
> >>
> >> On 14-10-2021 13:14, Rafael J. Wysocki wrote:
> >>> On Thu, Oct 14, 2021 at 1:04 PM Hans de Goede <hdegoede@redhat.com> wrote:
> >>>>
> >>>> Some BIOS-es contain a bug where they add addresses which map to system RAM
> >>>> in the PCI bridge memory window returned by the ACPI _CRS method, see
> >>>> commit 4dc2287c1805 ("x86: avoid E820 regions when allocating address
> >>>> space").
> >>>>
> >>>> To avoid this Linux by default excludes E820 reservations when allocating
> >>>> addresses since 2010. Windows however ignores E820 reserved regions for PCI
> >>>> mem allocations, so in hindsight Linux honoring them is a problem.
> >>>>
> >>>> Recently (2020) some systems have shown-up with E820 reservations which
> >>>> cover the entire _CRS returned PCI bridge memory window, causing all
> >>>> attempts to assign memory to PCI BARs which have not been setup by the
> >>>> BIOS to fail. For example here are the relevant dmesg bits from a
> >>>> Lenovo IdeaPad 3 15IIL 81WE:
> >>>>
> >>>>  [mem 0x000000004bc50000-0x00000000cfffffff] reserved
> >>>>  pci_bus 0000:00: root bus resource [mem 0x65400000-0xbfffffff window]
> >>>>
> >>>> Ideally Linux would fully stop honoring E820 reservations for PCI mem
> >>>> allocations, but then the old systems this was added for will regress.
> >>>> Instead keep the old behavior for old systems, while ignoring the E820
> >>>> reservations like Windows does for any systems from now on.
> >>>>
> >>>> Old systems are defined here as BIOS year < 2018, this was chosen to
> >>>> make sure that pci_use_e820 will not be set on the currently affected
> >>>> systems, while at the same time also taking into account that the
> >>>> systems for which the E820 checking was originally added may have
> >>>> received BIOS updates for quite a while (esp. CVE related ones),
> >>>> giving them a more recent BIOS year then 2010.
> >>>>
> >>>> Also add pci=no_e820 and pci=use_e820 options to allow overriding
> >>>> the BIOS year heuristic.
> >>>>
> >>>> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=206459
> >>>> BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1868899
> >>>> BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1871793
> >>>> BugLink: https://bugs.launchpad.net/bugs/1878279
> >>>> BugLink: https://bugs.launchpad.net/bugs/1931715
> >>>> BugLink: https://bugs.launchpad.net/bugs/1932069
> >>>> BugLink: https://bugs.launchpad.net/bugs/1921649
> >>>> Cc: Benoit Grégoire <benoitg@coeus.ca>
> >>>> Cc: Hui Wang <hui.wang@canonical.com>
> >>>> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> >>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> >>>
> >>> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >>
> >> Thank you.
> >>
> >>> with one tiny nit below.
> >>>
> >>> Or please let me know if you want me to pick this up.
> >>
> >> Since all of the changes are under arch/x86/ I expect the x86/tip
> >> folks to pick this up ?
> >
> > OK
> >
> >>>
> >>>> ---
> >>>> Changes in v3:
> >>>> - Commit msg tweaks (drop dmesg timestamps, typo fix)
> >>>> - Use "defined(CONFIG_...)" instead of "defined CONFIG_..."
> >>>> - Add Mika's Reviewed-by
> >>>>
> >>>> Changes in v2:
> >>>> - Replace the per model DMI quirk approach with disabling E820 reservations
> >>>>   checking for all systems with a BIOS year >= 2018
> >>>> - Add documentation for the new kernel-parameters to
> >>>>   Documentation/admin-guide/kernel-parameters.txt
> >>>> ---
> >>>> Other patches trying to address the same issue:
> >>>> https://lore.kernel.org/r/20210624095324.34906-1-hui.wang@canonical.com
> >>>> https://lore.kernel.org/r/20200617164734.84845-1-mika.westerberg@linux.intel.com
> >>>> V1 patch:
> >>>> https://lore.kernel.org/r/20211005150956.303707-1-hdegoede@redhat.com
> >>>> ---
> >>>>  .../admin-guide/kernel-parameters.txt         |  6 ++++
> >>>>  arch/x86/include/asm/pci_x86.h                | 10 +++++++
> >>>>  arch/x86/kernel/resource.c                    |  4 +++
> >>>>  arch/x86/pci/acpi.c                           | 29 +++++++++++++++++++
> >>>>  arch/x86/pci/common.c                         |  6 ++++
> >>>>  5 files changed, 55 insertions(+)
> >>>>
> >>>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> >>>> index 43dc35fe5bc0..969cde5d74c8 100644
> >>>> --- a/Documentation/admin-guide/kernel-parameters.txt
> >>>> +++ b/Documentation/admin-guide/kernel-parameters.txt
> >>>> @@ -3949,6 +3949,12 @@
> >>>>                                 please report a bug.
> >>>>                 nocrs           [X86] Ignore PCI host bridge windows from ACPI.
> >>>>                                 If you need to use this, please report a bug.
> >>>> +               use_e820        [X86] Honor E820 reservations when allocating
> >>>> +                               PCI host bridge memory. If you need to use this,
> >>>> +                               please report a bug.
> >>>> +               no_e820         [X86] ignore E820 reservations when allocating
> >>>> +                               PCI host bridge memory. If you need to use this,
> >>>> +                               please report a bug.
> >>>>                 routeirq        Do IRQ routing for all PCI devices.
> >>>>                                 This is normally done in pci_enable_device(),
> >>>>                                 so this option is a temporary workaround
> >>>> diff --git a/arch/x86/include/asm/pci_x86.h b/arch/x86/include/asm/pci_x86.h
> >>>> index 490411dba438..0bb4e7dd0ffc 100644
> >>>> --- a/arch/x86/include/asm/pci_x86.h
> >>>> +++ b/arch/x86/include/asm/pci_x86.h
> >>>> @@ -39,6 +39,8 @@ do {                                          \
> >>>>  #define PCI_ROOT_NO_CRS                0x100000
> >>>>  #define PCI_NOASSIGN_BARS      0x200000
> >>>>  #define PCI_BIG_ROOT_WINDOW    0x400000
> >>>> +#define PCI_USE_E820           0x800000
> >>>> +#define PCI_NO_E820            0x1000000
> >>>>
> >>>>  extern unsigned int pci_probe;
> >>>>  extern unsigned long pirq_table_addr;
> >>>> @@ -64,6 +66,8 @@ void pcibios_scan_specific_bus(int busn);
> >>>>
> >>>>  /* pci-irq.c */
> >>>>
> >>>> +struct pci_dev;
> >>>> +
> >>>>  struct irq_info {
> >>>>         u8 bus, devfn;                  /* Bus, device and function */
> >>>>         struct {
> >>>> @@ -232,3 +236,9 @@ static inline void mmio_config_writel(void __iomem *pos, u32 val)
> >>>>  # define x86_default_pci_init_irq      NULL
> >>>>  # define x86_default_pci_fixup_irqs    NULL
> >>>>  #endif
> >>>> +
> >>>> +#if defined(CONFIG_PCI) && defined(CONFIG_ACPI)
> >>>> +extern bool pci_use_e820;
> >>>> +#else
> >>>> +#define pci_use_e820 false
> >>>> +#endif
> >>>> diff --git a/arch/x86/kernel/resource.c b/arch/x86/kernel/resource.c
> >>>> index 9b9fb7882c20..e8dc9bc327bd 100644
> >>>> --- a/arch/x86/kernel/resource.c
> >>>> +++ b/arch/x86/kernel/resource.c
> >>>> @@ -1,6 +1,7 @@
> >>>>  // SPDX-License-Identifier: GPL-2.0
> >>>>  #include <linux/ioport.h>
> >>>>  #include <asm/e820/api.h>
> >>>> +#include <asm/pci_x86.h>
> >>>>
> >>>>  static void resource_clip(struct resource *res, resource_size_t start,
> >>>>                           resource_size_t end)
> >>>> @@ -28,6 +29,9 @@ static void remove_e820_regions(struct resource *avail)
> >>>>         int i;
> >>>>         struct e820_entry *entry;
> >>>>
> >>>> +       if (!pci_use_e820)
> >>>> +               return;
> >>>> +
> >>>>         for (i = 0; i < e820_table->nr_entries; i++) {
> >>>>                 entry = &e820_table->entries[i];
> >>>>
> >>>> diff --git a/arch/x86/pci/acpi.c b/arch/x86/pci/acpi.c
> >>>> index 948656069cdd..6c2febe84b6f 100644
> >>>> --- a/arch/x86/pci/acpi.c
> >>>> +++ b/arch/x86/pci/acpi.c
> >>>> @@ -21,6 +21,8 @@ struct pci_root_info {
> >>>>
> >>>>  static bool pci_use_crs = true;
> >>>>  static bool pci_ignore_seg = false;
> >>>> +/* Consumed in arch/x86/kernel/resource.c */
> >>>> +bool pci_use_e820 = false;
> >>>>
> >>>>  static int __init set_use_crs(const struct dmi_system_id *id)
> >>>>  {
> >>>> @@ -160,6 +162,33 @@ void __init pci_acpi_crs_quirks(void)
> >>>>                "if necessary, use \"pci=%s\" and report a bug\n",
> >>>>                pci_use_crs ? "Using" : "Ignoring",
> >>>>                pci_use_crs ? "nocrs" : "use_crs");
> >>>> +
> >>>> +       /*
> >>>> +        * Some BIOS-es contain a bug where they add addresses which map to system
> >>>> +        * RAM in the PCI bridge memory window returned by the ACPI _CRS method, see
> >>>> +        * commit 4dc2287c1805 ("x86: avoid E820 regions when allocating address space").
> >>>> +        * To avoid this Linux by default excludes E820 reservations when allocating
> >>>> +        * addresses since 2010. Windows however ignores E820 reserved regions for
> >>>> +        * PCI mem allocations, so in hindsight Linux honoring them is a problem.
> >>>> +        * In 2020 some systems have shown-up with E820 reservations which cover the
> >>>> +        * entire _CRS returned PCI bridge memory window, causing all attempts to
> >>>> +        * assign memory to PCI BARs to fail if Linux honors the E820 reservations.
> >>>> +        *
> >>>> +        * Ideally Linux would fully stop honoring E820 reservations for PCI mem
> >>>> +        * allocations, but then the old systems this was added for will regress.
> >>>> +        * Instead keep the old behavior for old systems, while ignoring the E820
> >>>> +        * reservations like Windows does for any systems from now on.
> >>>> +        */
> >>>> +       if (year >= 0 && year < 2018)
> >>>> +               pci_use_e820 = true;
> >>>> +
> >>>> +       if (pci_probe & PCI_NO_E820)
> >>>> +               pci_use_e820 = false;
> >>>> +       else if (pci_probe & PCI_USE_E820)
> >>>> +               pci_use_e820 = true;
> >>>> +
> >>>> +       printk(KERN_INFO "PCI: %s E820 reservations for host bridge windows\n",
> >>>> +              pci_use_e820 ? "Honoring" : "Ignoring");
> >>>
> >>> Why not pr_info()?
> >>
> >> This file is using printk(KERN_... consistently everywhere. I'm just following
> >> the existing style here. I very much dislike mixing styles in a single file.
> >
> > In this particular case, it isn't just a matter of style.
>
> Without a #define pr_fmt in the file there is no functional difference.
>
> > Also, if what is regarded as a good practice has changed since the
> > file was created, should new code added to it be prevented from
> > following the new good practice, because the old code didn't follow
> > it?
>
> That is a non trivial question to answer, e.g. using devm_ functions
> while the rest of the driver is not using them can be tricky and it
> might be better to convert the whole driver over to devm_ use in one go.

Right.

> >> If we want to change this for this file then IMHO the right thing to do would
> >> be a follow up patch changing all the printk-s at once.
> >
> > I would do the pr_info() here in this patch and change the rest of the
> > file to follow in a subsequent patch.
>
> All printk's in this file are prefixed with "PCI: " so converting to
> pr_info() should probably involve adding this:
>
> #define pr_fmt(fmt) "PCI: " fmt
>
> So should I add that already while using pr_info() in this patch,
> which would look weird / look like an unrelated change?
>
> Or should I not add that and manually add the "PCI: " prefix,
> requiring the pr_info to still be replaced in a subsequent patch
> converting the rest over to pr_info() ?
>
> IMHO it makes the most sense to keep printk here and then
> replace the printk with a pr_info, dropping the "PCI: "
> prefix in a subsequent patch converting all the printk-s.
>
> That would also make the subsequent patch cleaner, because
> replacing a pr_info with a pr_info in that patch would
> look weird.

OK
