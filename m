Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9F055289F8
	for <lists+linux-acpi@lfdr.de>; Mon, 16 May 2022 18:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234205AbiEPQMv convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Mon, 16 May 2022 12:12:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238418AbiEPQMu (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 16 May 2022 12:12:50 -0400
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C2C038783;
        Mon, 16 May 2022 09:12:49 -0700 (PDT)
Received: by mail-yb1-f175.google.com with SMTP id v71so2804946ybi.4;
        Mon, 16 May 2022 09:12:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qEqxnWrxCVe9LU1d252kjCh2wbd2c/RZQjkiUrmX/cE=;
        b=fDo+JhHawCbZrJlyTr5SnlAH3wwatX5rlwHgcDxBzZm6q19nixYorntbAmJLRqmWo+
         a90sikQX69KRopUM+L2IogQDvfGw4dcEEXhZtArNB0MvAp9OjKw7lALKHZeTAQ7zX3yv
         0nx/2YVy/vU5ktxHwxPYqo15o+Z5u4pExZ6qvrQDwsaZh/xAkWUGSKLnRnt+NdEFgkYr
         dC0dQNG1OzNyhu/e1V1Um2PO/13XcOkEHFVhlJr+M42a2Sn0it6lji5iLc2xmiWCRnAc
         VstUNozajUrHymcavqge/N+87wzq7v1czVxti8OqLbAjVq1tpr8BZZ86ztEufhDrmTNu
         OmrA==
X-Gm-Message-State: AOAM531TA3QpBar3QbdC/YBGA9wsXN6wxiQ/YjJh5Oc37hqcnSpU9+j8
        Z2jivIY0RExbMMoqGMTDifUO53nL3fzZ7+uCX60=
X-Google-Smtp-Source: ABdhPJw/Qo2BEqJPfDJDZUeT5xLZT1mXle0HTx8OjP8Tw/2jof9Jewm8ew+7IcRal3ZcN+3sYEV9olfnw4R71dBddQw=
X-Received: by 2002:a25:7717:0:b0:64d:854f:2da4 with SMTP id
 s23-20020a257717000000b0064d854f2da4mr7413092ybc.633.1652717568068; Mon, 16
 May 2022 09:12:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220512202511.34197-1-hdegoede@redhat.com> <20220512202511.34197-2-hdegoede@redhat.com>
In-Reply-To: <20220512202511.34197-2-hdegoede@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 16 May 2022 18:12:36 +0200
Message-ID: <CAJZ5v0jaFciDpnw7_+2sU9SfUkKR-FNjGB=5ok397goLtfo6BQ@mail.gmail.com>
Subject: Re: [PATCH v8 1/1] x86/PCI: Ignore E820 reservations for bridge
 windows on future systems
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Myron Stowe <myron.stowe@redhat.com>,
        Juha-Pekka Heikkila <juhapekka.heikkila@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        =?UTF-8?Q?Benoit_Gr=C3=A9goire?= <benoitg@coeus.ca>,
        Hui Wang <hui.wang@canonical.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, May 12, 2022 at 10:25 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Some BIOS-es contain bugs where they add addresses which are already
> used in some other manner to the PCI host bridge window returned by
> the ACPI _CRS method. To avoid this Linux by default excludes
> E820 reservations when allocating addresses since 2010, see:
> commit 4dc2287c1805 ("x86: avoid E820 regions when allocating address
> space").
>
> Recently (2019) some systems have shown-up with E820 reservations which
> cover the entire _CRS returned PCI bridge memory window, causing all
> attempts to assign memory to PCI BARs which have not been setup by the
> BIOS to fail. For example here are the relevant dmesg bits from a
> Lenovo IdeaPad 3 15IIL 81WE:
>
>  [mem 0x000000004bc50000-0x00000000cfffffff] reserved
>  pci_bus 0000:00: root bus resource [mem 0x65400000-0xbfffffff window]
>
> The ACPI specifications appear to allow this new behavior:
>
> The relationship between E820 and ACPI _CRS is not really very clear.
> ACPI v6.3, sec 15, table 15-374, says AddressRangeReserved means:
>
>   This range of addresses is in use or reserved by the system and is
>   not to be included in the allocatable memory pool of the operating
>   system's memory manager.
>
> and it may be used when:
>
>   The address range is in use by a memory-mapped system device.
>
> Furthermore, sec 15.2 says:
>
>   Address ranges defined for baseboard memory-mapped I/O devices, such
>   as APICs, are returned as reserved.
>
> A PCI host bridge qualifies as a baseboard memory-mapped I/O device,
> and its apertures are in use and certainly should not be included in
> the general allocatable pool, so the fact that some BIOS-es reports
> the PCI aperture as "reserved" in E820 doesn't seem like a BIOS bug.
>
> So it seems that the excluding of E820 reserved addresses is a mistake.
>
> Ideally Linux would fully stop excluding E820 reserved addresses,
> but then various old systems will regress. Instead keep the old behavior
> for old systems, while ignoring the E820 reservations for any future
> systems.
>
> That is ignore E820 reservations starting with systems with
> a DMI BIOS year >= 2023.
>
> And use DMI quirks for existing systems on which excluding E820
> reservations from the _CRS returned bridge window is an issue.
>
> Also add pci=no_e820 and pci=use_e820 options to allow overriding
> the BIOS year + DMI matching logic.
>
> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=206459
> BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1868899
> BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1871793
> BugLink: https://bugs.launchpad.net/bugs/1878279
> BugLink: https://bugs.launchpad.net/bugs/1880172
> BugLink: https://bugs.launchpad.net/bugs/1884232
> BugLink: https://bugs.launchpad.net/bugs/1921649
> BugLink: https://bugs.launchpad.net/bugs/1931715
> BugLink: https://bugs.launchpad.net/bugs/1932069
> Cc: Benoit Grégoire <benoitg@coeus.ca>
> Cc: Hui Wang <hui.wang@canonical.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
> Changes in v8:
> - Change the cut-off for no longer excluding E820 reservations from
>   the bridge window to BIOS year >= 2023 so that this only applies to
>   upcoming systems.
> - Use DMI quirks for existing systems on which excluding E820
>   reservations from the _CRS returned bridge window is an issue.
>
> Changes in v7:
> - Re-add the pci=use_e820 and pci=no_e820 kernel cmdline options since it
>   turns out that some newer laptops still need pci=use_e820
> - Add DMI quirks for known newer laptops which need pci=use_e820
>
> Changes in v6:
> - Remove the possibility to change the behavior from the commandline
>   because of worries that users may use this to paper over other problems
>
> Changes in v5:
> - Drop mention of Windows behavior from the commit msg, replace with a
>   reference to the specs
> - Improve documentation in Documentation/admin-guide/kernel-parameters.txt
> - Reword the big comment added, use "PCI host bridge window" in it and drop
>   all refences to Windows
>
> Changes in v4:
> - Rewrap the big comment block to fit in 80 columns
> - Add Rafael's Acked-by
> - Add Cc: stable@vger.kernel.org
>
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
>  .../admin-guide/kernel-parameters.txt         |   9 ++
>  arch/x86/include/asm/pci_x86.h                |   2 +
>  arch/x86/pci/acpi.c                           | 109 +++++++++++++++++-
>  arch/x86/pci/common.c                         |   8 ++
>  4 files changed, 126 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 3f1cc5e317ed..2477b639d5c4 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -4066,6 +4066,15 @@
>                                 please report a bug.
>                 nocrs           [X86] Ignore PCI host bridge windows from ACPI.
>                                 If you need to use this, please report a bug.
> +               use_e820        [X86] Use E820 reservations to exclude parts of
> +                               PCI host bridge windows. This is a workaround
> +                               for BIOS defects in host bridge _CRS methods.
> +                               If you need to use this, please report a bug to
> +                               <linux-pci@vger.kernel.org>.
> +               no_e820         [X86] Ignore E820 reservations for PCI host
> +                               bridge windows. This is the default on modern
> +                               hardware. If you need to use this, please report
> +                               a bug to <linux-pci@vger.kernel.org>.
>                 routeirq        Do IRQ routing for all PCI devices.
>                                 This is normally done in pci_enable_device(),
>                                 so this option is a temporary workaround
> diff --git a/arch/x86/include/asm/pci_x86.h b/arch/x86/include/asm/pci_x86.h
> index a0627dfae541..ce3fd3311772 100644
> --- a/arch/x86/include/asm/pci_x86.h
> +++ b/arch/x86/include/asm/pci_x86.h
> @@ -42,6 +42,8 @@ do {                                          \
>  #define PCI_ROOT_NO_CRS                0x100000
>  #define PCI_NOASSIGN_BARS      0x200000
>  #define PCI_BIG_ROOT_WINDOW    0x400000
> +#define PCI_USE_E820           0x800000
> +#define PCI_NO_E820            0x1000000
>
>  extern unsigned int pci_probe;
>  extern unsigned long pirq_table_addr;
> diff --git a/arch/x86/pci/acpi.c b/arch/x86/pci/acpi.c
> index 562c81a51ea0..125c55b58d7e 100644
> --- a/arch/x86/pci/acpi.c
> +++ b/arch/x86/pci/acpi.c
> @@ -20,6 +20,7 @@ struct pci_root_info {
>  #endif
>  };
>
> +static bool pci_use_e820 = true;
>  static bool pci_use_crs = true;
>  static bool pci_ignore_seg;
>
> @@ -42,6 +43,13 @@ static int __init set_ignore_seg(const struct dmi_system_id *id)
>         return 0;
>  }
>
> +static int __init set_no_e820(const struct dmi_system_id *id)
> +{
> +       printk(KERN_INFO "PCI: %s detected: ignoring e820 regions\n", id->ident);
> +       pci_use_e820 = false;
> +       return 0;
> +}
> +
>  static const struct dmi_system_id pci_crs_quirks[] __initconst = {
>         /* http://bugzilla.kernel.org/show_bug.cgi?id=14183 */
>         {
> @@ -136,6 +144,74 @@ static const struct dmi_system_id pci_crs_quirks[] __initconst = {
>                         DMI_MATCH(DMI_PRODUCT_NAME, "HP xw9300 Workstation"),
>                 },
>         },
> +
> +       /*
> +        * Most Lenovo models with "IIL" in their DMI_PRODUCT_VERSION have
> +        * an E820 reservation which covers the entire _CRS returned 32 bit
> +        * PCI bridge memory window, causing all attempts to assign memory to
> +        * 32 bit PCI bars which have not been setup by the BIOS to fail.
> +        * Specifically this often causes some of the I2C controllers to not
> +        * work breaking touchpad support and/or this may cause issues when
> +        * hotplugging thunderbolt connected devices.
> +        *
> +        * This DMI match entry covers the following DMI_PRODUCT_VERSION-s with
> +        * an E820 reservation which covers the entire 32 bit bridge window:
> +        * "IdeaPad 3 14IIL05", "IdeaPad 3 15IIL05", "IdeaPad 3 17IIL05",
> +        * "IdeaPad 5 14IIL05", "IdeaPad 5 15IIL05",
> +        * "IdeaPad Slim 7 14IIL05", "IdeaPad Slim 7 15IIL05",
> +        * "Lenovo BS145-15IIL",
> +        * "Lenovo IdeaPad S145-15IIL", "Lenovo IdeaPad S340-14IIL",
> +        * "Lenovo IdeaPad S340-15IIL", "Lenovo IdeaPad C340-15IIL",
> +        * "Lenovo V14-IIL", "Lenovo V15-IIL", "Lenovo V17-IIL",
> +        * "Lenovo Yoga S740-14IIL", "Lenovo Yoga C940-14IIL",
> +        * "Yoga Slim 7 14IIL05", "Yoga Slim 7 15IIL05"
> +        *
> +        * On some of these the bridge's _CRS method *sometimes* (under unknown
> +        * conditions) has a 64 bit [mem 0x4000000000-0x7fffffffff window].
> +        * This avoids some of the issues, but even then there are still issues
> +        * with assigning some 32 bit only BARs such as some Thunderbolt devs,
> +        * the 00:1f.5 BIOS SPI controller and BAR6 of some nvidia gfx.
> +        *
> +        * This entry also covers the following DMI_PRODUCT_VERSION-s which do
> +        * not need pci_use_e820=false. This quirk is a no-op for these models,
> +        * because there is no overlap between E820 regions and _CRS windows:
> +        * "IdeaPad Flex 5 14IIL05", "IdeaPad Flex 5 15IIL05",
> +        * "Lenovo ThinkBook 14-IIL", "Lenovo ThinkBook 15-IIL",
> +        * "Lenovo Yoga S940-14IIL"
> +        *
> +        * This entry fixes issues reported in the following bugs:
> +        * https://bugzilla.kernel.org/show_bug.cgi?id=206459
> +        * https://bugzilla.redhat.com/show_bug.cgi?id=1871793
> +        * https://bugzilla.redhat.com/show_bug.cgi?id=1868899
> +        * https://bugs.launchpad.net/bugs/1878279
> +        * https://bugs.launchpad.net/bugs/1880172
> +        * https://bugs.launchpad.net/bugs/1921649
> +        * https://bugs.launchpad.net/bugs/1931715
> +        * https://bugs.launchpad.net/bugs/1932069
> +        */
> +       {
> +               .callback = set_no_e820,
> +               .ident = "Lenovo *IIL* product version",
> +               .matches = {
> +                       DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> +                       DMI_MATCH(DMI_PRODUCT_VERSION, "IIL"),
> +               },
> +       },
> +
> +       /*
> +        * The Acer Spin 5 (SP513-54N) has the same E820 reservation covering
> +        * the entire _CRS 32 bit window issue as the Lenovo *IIL* models.
> +        * https://bugs.launchpad.net/bugs/1884232
> +        */
> +       {
> +               .callback = set_no_e820,
> +               .ident = "Acer Spin 5 (SP513-54N)",
> +               .matches = {
> +                       DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
> +                       DMI_MATCH(DMI_PRODUCT_NAME, "Spin SP513-54N"),
> +               },
> +       },
> +
>         {}
>  };
>
> @@ -146,6 +222,24 @@ void __init pci_acpi_crs_quirks(void)
>         if (year >= 0 && year < 2008 && iomem_resource.end <= 0xffffffff)
>                 pci_use_crs = false;
>
> +       /*
> +        * Some BIOS-es contain bugs where they add addresses which are already
> +        * used in some other manner to the PCI host bridge window returned by
> +        * the ACPI _CRS method. To avoid this Linux by default excludes
> +        * E820 reservations when allocating addresses since 2010.
> +        * In 2019 some systems have shown-up with E820 reservations which cover
> +        * the entire _CRS returned PCI host bridge window, causing all attempts
> +        * to assign memory to PCI BARs to fail if Linux uses E820 reservations.
> +        *
> +        * Ideally Linux would fully stop using E820 reservations, but then
> +        * various old systems will regress. Instead stop using E820 reservations
> +        * for new systems with a DMI BIOS year >= 2023;
> +        * and use DMI quirks for existing systems on which excluding E820
> +        * reservations is known to cause issues.
> +        */
> +       if (year >= 2023)
> +               pci_use_e820 = false;
> +
>         dmi_check_system(pci_crs_quirks);
>
>         /*
> @@ -161,6 +255,15 @@ void __init pci_acpi_crs_quirks(void)
>                "if necessary, use \"pci=%s\" and report a bug\n",
>                pci_use_crs ? "Using" : "Ignoring",
>                pci_use_crs ? "nocrs" : "use_crs");
> +
> +       /* "pci=use_e820"/"pci=no_e820" on the kernel cmdline takes precedence */
> +       if (pci_probe & PCI_NO_E820)
> +               pci_use_e820 = false;
> +       else if (pci_probe & PCI_USE_E820)
> +               pci_use_e820 = true;
> +
> +       printk(KERN_INFO "PCI: %s E820 reservations for host bridge windows\n",
> +              pci_use_e820 ? "Using" : "Ignoring");
>  }
>
>  #ifdef CONFIG_PCI_MMCONFIG
> @@ -301,8 +404,10 @@ static int pci_acpi_root_prepare_resources(struct acpi_pci_root_info *ci)
>
>         status = acpi_pci_probe_root_resources(ci);
>
> -       resource_list_for_each_entry(entry, &ci->resources)
> -               remove_e820_regions(&device->dev, entry->res);
> +       if (pci_use_e820) {
> +               resource_list_for_each_entry(entry, &ci->resources)
> +                       remove_e820_regions(&device->dev, entry->res);
> +       }
>
>         if (pci_use_crs) {
>                 resource_list_for_each_entry_safe(entry, tmp, &ci->resources)
> diff --git a/arch/x86/pci/common.c b/arch/x86/pci/common.c
> index 9e1e6b8d8876..ddb798603201 100644
> --- a/arch/x86/pci/common.c
> +++ b/arch/x86/pci/common.c
> @@ -595,6 +595,14 @@ char *__init pcibios_setup(char *str)
>         } else if (!strcmp(str, "nocrs")) {
>                 pci_probe |= PCI_ROOT_NO_CRS;
>                 return NULL;
> +       } else if (!strcmp(str, "use_e820")) {
> +               pci_probe |= PCI_USE_E820;
> +               add_taint(TAINT_FIRMWARE_WORKAROUND, LOCKDEP_STILL_OK);
> +               return NULL;
> +       } else if (!strcmp(str, "no_e820")) {
> +               pci_probe |= PCI_NO_E820;
> +               add_taint(TAINT_FIRMWARE_WORKAROUND, LOCKDEP_STILL_OK);
> +               return NULL;
>  #ifdef CONFIG_PHYS_ADDR_T_64BIT
>         } else if (!strcmp(str, "big_root_window")) {
>                 pci_probe |= PCI_BIG_ROOT_WINDOW;
> --
> 2.36.0
>
