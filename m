Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5BA43007AE
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Jan 2021 16:46:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728686AbhAVPoT (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 22 Jan 2021 10:44:19 -0500
Received: from mail-oi1-f181.google.com ([209.85.167.181]:38087 "EHLO
        mail-oi1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729061AbhAVPnx (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 22 Jan 2021 10:43:53 -0500
Received: by mail-oi1-f181.google.com with SMTP id h6so5022370oie.5
        for <linux-acpi@vger.kernel.org>; Fri, 22 Jan 2021 07:43:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3tCOg3okVXxN4m8sE7gb5HcmfkJY6SxmMVeADSFNIJw=;
        b=sNHk2WPbgV1SGQKYSpa/cVvCBAot60BGoNRIr9Vmrep/ES26/4UsDl4hTetYQYE+WG
         l8yTyhvguqGf9PJSPa5IjkPjrk4OEMrSia6a37gGiCvMwX/JiH3M22X3ZNI7InT01vJS
         pav0SglavW6m9KOkb2OtsMqlHQAp+YhwW4qwOs0cnsBQl5HgKJPPJOSvz9U2VFLn88ms
         OBJRiQhZPiCsVw3qbpBuvnGFD4A4K85jEEqP/0gYTAELbk2oxJjGOy5dJDujg04Xr/uH
         YGuGc8jVZ3zxm5JYTgXw/fR26IjqU/NcQ/JVjPUGx0FeZZr+31LcR7qZdcPfZV2Ijx8T
         sCrg==
X-Gm-Message-State: AOAM533/G+cEV2OgCuLmjI3zhxmVpH7w0JgRf6xlMxxbAZM4UgSiEvrn
        RuHGicW6E9mvH2C/tDucimTfQqNRLPcK70M8TmToGyXL
X-Google-Smtp-Source: ABdhPJz4LPVw46Riuoja80y2dnxG9tOOeUlr7cQ2s/FQ31chkB+UILRZCR+fX4KNOnkTV0JO6sK5/M5KWAtflJYE0RQ=
X-Received: by 2002:aca:fc84:: with SMTP id a126mr3679096oii.71.1611330192364;
 Fri, 22 Jan 2021 07:43:12 -0800 (PST)
MIME-Version: 1.0
References: <20210115100220.21686-1-rui.zhang@intel.com>
In-Reply-To: <20210115100220.21686-1-rui.zhang@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 22 Jan 2021 16:43:01 +0100
Message-ID: <CAJZ5v0izPwooX6vnuN6Lfx1etDqBfyoucGV3iEs+Tp5GQi16JQ@mail.gmail.com>
Subject: Re: [PATCH] ACPI: introduce support for FPDT table
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Todd Brandt <todd.e.brandt@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Jan 15, 2021 at 10:51 AM Zhang Rui <rui.zhang@intel.com> wrote:
>
> ACPI Firmware Performance Data Table (FPDT) provides information about
> firmware performance during system boot, S3 suspend and S3 resume.
>
> Have the kernel parse the FPDT table, and expose the firmware
> performance data to userspace as sysfs attributes under
> /sys/firmware/acpi/fpdt/.
>
> Tested-by: Todd Brandt <todd.e.brandt@linux.intel.com>
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>

Applied as 5.12 material with a minor adjustment of the Kconfig entry, thanks!

> ---
>  Documentation/ABI/testing/sysfs-firmware-acpi |  43 +++
>  drivers/acpi/Kconfig                          |   8 +
>  drivers/acpi/Makefile                         |   1 +
>  drivers/acpi/acpi_fpdt.c                      | 263 ++++++++++++++++++
>  4 files changed, 315 insertions(+)
>  create mode 100644 drivers/acpi/acpi_fpdt.c
>
> diff --git a/Documentation/ABI/testing/sysfs-firmware-acpi b/Documentation/ABI/testing/sysfs-firmware-acpi
> index b16d30a71709..819939d858c9 100644
> --- a/Documentation/ABI/testing/sysfs-firmware-acpi
> +++ b/Documentation/ABI/testing/sysfs-firmware-acpi
> @@ -1,3 +1,46 @@
> +What:          /sys/firmware/acpi/fpdt/
> +Date:          Jan 2021
> +Contact:       Zhang Rui <rui.zhang@intel.com>
> +Description:
> +               ACPI Firmware Performance Data Table (FPDT) provides
> +               information for firmware performance data for system boot,
> +               S3 suspend and S3 resume. This sysfs entry contains the
> +               performance data retrieved from the FPDT.
> +
> +               boot:
> +                       firmware_start_ns: Timer value logged at the beginning
> +                               of firmware image execution. In nanoseconds.
> +                       bootloader_load_ns: Timer value logged just prior to
> +                               loading the OS boot loader into memory.
> +                               In nanoseconds.
> +                       bootloader_launch_ns: Timer value logged just prior to
> +                               launching the currently loaded OS boot loader
> +                               image. In nanoseconds.
> +                       exitbootservice_start_ns: Timer value logged at the
> +                               point when the OS loader calls the
> +                               ExitBootServices function for UEFI compatible
> +                               firmware. In nanoseconds.
> +                       exitbootservice_end_ns: Timer value logged at the point
> +                               just prior to the OS loader gaining control
> +                               back from the ExitBootServices function for
> +                               UEFI compatible firmware. In nanoseconds.
> +               suspend:
> +                       suspend_start_ns: Timer value recorded at the previous
> +                               OS write to SLP_TYP upon entry to S3. In
> +                               nanoseconds.
> +                       suspend_end_ns: Timer value recorded at the previous
> +                               firmware write to SLP_TYP used to trigger
> +                               hardware entry to S3. In nanoseconds.
> +               resume:
> +                       resume_count: A count of the number of S3 resume cycles
> +                               since the last full boot sequence.
> +                       resume_avg_ns: Average timer value of all resume cycles
> +                               logged since the last full boot sequence,
> +                               including the most recent resume. In nanoseconds.
> +                       resume_prev_ns: Timer recorded at the end of the previous
> +                               platform runtime firmware S3 resume, just prior to
> +                               handoff to the OS waking vector. In nanoseconds.
> +
>  What:          /sys/firmware/acpi/bgrt/
>  Date:          January 2012
>  Contact:       Matthew Garrett <mjg@redhat.com>
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index ebcf534514be..84930fa2dc32 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -87,6 +87,14 @@ config ACPI_SPCR_TABLE
>           This table provides information about the configuration of the
>           earlycon console.
>
> +config ACPI_FPDT
> +       bool "ACPI Firmware Performance Data Table(FPDT)"
> +       depends on X86_64
> +       help
> +         Enable support for the Firmware Performance Data Table (FPDT).
> +         This table provides information on the timing of the system
> +         boot, S3 suspend and S3 resume firmware code paths.
> +
>  config ACPI_LPIT
>         bool
>         depends on X86_64
> diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
> index 076894a3330f..eb93bb7b6479 100644
> --- a/drivers/acpi/Makefile
> +++ b/drivers/acpi/Makefile
> @@ -57,6 +57,7 @@ acpi-$(CONFIG_X86)            += x86/utils.o
>  acpi-$(CONFIG_X86)             += x86/s2idle.o
>  acpi-$(CONFIG_DEBUG_FS)                += debugfs.o
>  acpi-y                         += acpi_lpat.o
> +acpi-$(CONFIG_ACPI_FPDT)       += acpi_fpdt.o
>  acpi-$(CONFIG_ACPI_LPIT)       += acpi_lpit.o
>  acpi-$(CONFIG_ACPI_GENERIC_GSI) += irq.o
>  acpi-$(CONFIG_ACPI_WATCHDOG)   += acpi_watchdog.o
> diff --git a/drivers/acpi/acpi_fpdt.c b/drivers/acpi/acpi_fpdt.c
> new file mode 100644
> index 000000000000..b8108117262a
> --- /dev/null
> +++ b/drivers/acpi/acpi_fpdt.c
> @@ -0,0 +1,263 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +/*
> + * FPDT support for exporting boot and suspend/resume performance data
> + *
> + * Copyright (C) 2021 Intel Corporation. All rights reserved.
> + */
> +
> +#define pr_fmt(fmt) "ACPI FPDT: " fmt
> +
> +#include <linux/acpi.h>
> +
> +/*
> + * FPDT contains ACPI table header and a number of fpdt_subtable_entries.
> + * Each fpdt_subtable_entry points to a subtable: FBPT or S3PT.
> + * Each FPDT subtable (FBPT/S3PT) is composed of a fpdt_subtable_header
> + * and a number of fpdt performance records.
> + * Each FPDT performance record is composed of a fpdt_record_header and
> + * performance data fields, for boot or suspend or resume phase.
> + */
> +enum fpdt_subtable_type {
> +       SUBTABLE_FBPT,
> +       SUBTABLE_S3PT,
> +};
> +
> +struct fpdt_subtable_entry {
> +       u16 type;               /* refer to enum fpdt_subtable_type */
> +       u8 length;
> +       u8 revision;
> +       u32 reserved;
> +       u64 address;            /* physical address of the S3PT/FBPT table */
> +};
> +
> +struct fpdt_subtable_header {
> +       u32 signature;
> +       u32 length;
> +};
> +
> +enum fpdt_record_type {
> +       RECORD_S3_RESUME,
> +       RECORD_S3_SUSPEND,
> +       RECORD_BOOT,
> +};
> +
> +struct fpdt_record_header {
> +       u16 type;               /* refer to enum fpdt_record_type */
> +       u8 length;
> +       u8 revision;
> +};
> +
> +struct resume_performance_record {
> +       struct fpdt_record_header header;
> +       u32 resume_count;
> +       u64 resume_prev;
> +       u64 resume_avg;
> +} __attribute__((packed));
> +
> +struct boot_performance_record {
> +       struct fpdt_record_header header;
> +       u32 reserved;
> +       u64 firmware_start;
> +       u64 bootloader_load;
> +       u64 bootloader_launch;
> +       u64 exitbootservice_start;
> +       u64 exitbootservice_end;
> +} __attribute__((packed));
> +
> +struct suspend_performance_record {
> +       struct fpdt_record_header header;
> +       u64 suspend_start;
> +       u64 suspend_end;
> +} __attribute__((packed));
> +
> +
> +static struct resume_performance_record *record_resume;
> +static struct suspend_performance_record *record_suspend;
> +static struct boot_performance_record *record_boot;
> +
> +#define FPDT_ATTR(phase, name) \
> +static ssize_t name##_show(struct kobject *kobj,       \
> +                struct kobj_attribute *attr, char *buf)        \
> +{      \
> +       return sprintf(buf, "%llu\n", record_##phase->name);    \
> +}      \
> +static struct kobj_attribute name##_attr =     \
> +__ATTR(name##_ns, 0444, name##_show, NULL)
> +
> +FPDT_ATTR(resume, resume_prev);
> +FPDT_ATTR(resume, resume_avg);
> +FPDT_ATTR(suspend, suspend_start);
> +FPDT_ATTR(suspend, suspend_end);
> +FPDT_ATTR(boot, firmware_start);
> +FPDT_ATTR(boot, bootloader_load);
> +FPDT_ATTR(boot, bootloader_launch);
> +FPDT_ATTR(boot, exitbootservice_start);
> +FPDT_ATTR(boot, exitbootservice_end);
> +
> +static ssize_t resume_count_show(struct kobject *kobj,
> +                                struct kobj_attribute *attr, char *buf)
> +{
> +       return sprintf(buf, "%u\n", record_resume->resume_count);
> +}
> +
> +static struct kobj_attribute resume_count_attr =
> +__ATTR_RO(resume_count);
> +
> +static struct attribute *resume_attrs[] = {
> +       &resume_count_attr.attr,
> +       &resume_prev_attr.attr,
> +       &resume_avg_attr.attr,
> +       NULL
> +};
> +
> +static const struct attribute_group resume_attr_group = {
> +       .attrs = resume_attrs,
> +       .name = "resume",
> +};
> +
> +static struct attribute *suspend_attrs[] = {
> +       &suspend_start_attr.attr,
> +       &suspend_end_attr.attr,
> +       NULL
> +};
> +
> +static const struct attribute_group suspend_attr_group = {
> +       .attrs = suspend_attrs,
> +       .name = "suspend",
> +};
> +
> +static struct attribute *boot_attrs[] = {
> +       &firmware_start_attr.attr,
> +       &bootloader_load_attr.attr,
> +       &bootloader_launch_attr.attr,
> +       &exitbootservice_start_attr.attr,
> +       &exitbootservice_end_attr.attr,
> +       NULL
> +};
> +
> +static const struct attribute_group boot_attr_group = {
> +       .attrs = boot_attrs,
> +       .name = "boot",
> +};
> +
> +static struct kobject *fpdt_kobj;
> +
> +static int fpdt_process_subtable(u64 address, u32 subtable_type)
> +{
> +       struct fpdt_subtable_header *subtable_header;
> +       struct fpdt_record_header *record_header;
> +       char *signature = (subtable_type == SUBTABLE_FBPT ? "FBPT" : "S3PT");
> +       u32 length, offset;
> +       int result;
> +
> +       subtable_header = acpi_os_map_memory(address, sizeof(*subtable_header));
> +       if (!subtable_header)
> +               return -ENOMEM;
> +
> +       if (strncmp((char *)&subtable_header->signature, signature, 4)) {
> +               pr_info(FW_BUG "subtable signature and type mismatch!\n");
> +               return -EINVAL;
> +       }
> +
> +       length = subtable_header->length;
> +       acpi_os_unmap_memory(subtable_header, sizeof(*subtable_header));
> +
> +       subtable_header = acpi_os_map_memory(address, length);
> +       if (!subtable_header)
> +               return -ENOMEM;
> +
> +       offset = sizeof(*subtable_header);
> +       while (offset < length) {
> +               record_header = (void *)subtable_header + offset;
> +               offset += record_header->length;
> +
> +               switch (record_header->type) {
> +               case RECORD_S3_RESUME:
> +                       if (subtable_type != SUBTABLE_S3PT) {
> +                               pr_err(FW_BUG "Invalid record %d for subtable %s\n",
> +                                    record_header->type, signature);
> +                               return -EINVAL;
> +                       }
> +                       if (record_resume) {
> +                               pr_err("Duplicate resume performance record found.\n");
> +                               continue;
> +                       }
> +                       record_resume = (struct resume_performance_record *)record_header;
> +                       result = sysfs_create_group(fpdt_kobj, &resume_attr_group);
> +                       if (result)
> +                               return result;
> +                       break;
> +               case RECORD_S3_SUSPEND:
> +                       if (subtable_type != SUBTABLE_S3PT) {
> +                               pr_err(FW_BUG "Invalid %d for subtable %s\n",
> +                                    record_header->type, signature);
> +                               continue;
> +                       }
> +                       if (record_suspend) {
> +                               pr_err("Duplicate suspend performance record found.\n");
> +                               continue;
> +                       }
> +                       record_suspend = (struct suspend_performance_record *)record_header;
> +                       result = sysfs_create_group(fpdt_kobj, &suspend_attr_group);
> +                       if (result)
> +                               return result;
> +                       break;
> +               case RECORD_BOOT:
> +                       if (subtable_type != SUBTABLE_FBPT) {
> +                               pr_err(FW_BUG "Invalid %d for subtable %s\n",
> +                                    record_header->type, signature);
> +                               return -EINVAL;
> +                       }
> +                       if (record_boot) {
> +                               pr_err("Duplicate boot performance record found.\n");
> +                               continue;
> +                       }
> +                       record_boot = (struct boot_performance_record *)record_header;
> +                       result = sysfs_create_group(fpdt_kobj, &boot_attr_group);
> +                       if (result)
> +                               return result;
> +                       break;
> +
> +               default:
> +                       pr_err(FW_BUG "Invalid record %d found.\n", record_header->type);
> +                       return -EINVAL;
> +               }
> +       }
> +       return 0;
> +}
> +
> +void acpi_init_fpdt(void)
> +{
> +       acpi_status status;
> +       struct acpi_table_header *header;
> +       struct fpdt_subtable_entry *subtable;
> +       u32 offset = sizeof(*header);
> +
> +       status = acpi_get_table(ACPI_SIG_FPDT, 0, &header);
> +
> +       if (ACPI_FAILURE(status))
> +               return;
> +
> +       fpdt_kobj = kobject_create_and_add("fpdt", acpi_kobj);
> +       if (!fpdt_kobj)
> +               return;
> +
> +       while (offset < header->length) {
> +               subtable = (void *)header + offset;
> +               switch (subtable->type) {
> +               case SUBTABLE_FBPT:
> +               case SUBTABLE_S3PT:
> +                       fpdt_process_subtable(subtable->address,
> +                                             subtable->type);
> +                       break;
> +               default:
> +                       pr_info(FW_BUG, "Invalid subtable type %d found.\n",
> +                              subtable->type);
> +                       return;
> +               }
> +               offset += sizeof(*subtable);
> +       }
> +}
> +
> +fs_initcall(acpi_init_fpdt);
> --
> 2.17.1
>
