Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39297782F3B
	for <lists+linux-acpi@lfdr.de>; Mon, 21 Aug 2023 19:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234098AbjHURN3 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Mon, 21 Aug 2023 13:13:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230360AbjHURN2 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 21 Aug 2023 13:13:28 -0400
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F9C5113;
        Mon, 21 Aug 2023 10:13:04 -0700 (PDT)
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-56e280cc606so504508eaf.1;
        Mon, 21 Aug 2023 10:13:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692637983; x=1693242783;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XlnPSJHhkBXVNpPjVaRUHf+giLiXCwdP3rlNy/7aC0Y=;
        b=OtlaSz8y5tv5SdJ+ny8iXuylaw8F/Xj0GLhx3S36y9sQ0IzUWRCI/e3IZlR0zNiUBM
         TJV/klYXgfn9NKFfcBjfSa+Yn53fo5kDXhwpKIeBHJS3CKSKmjq4mU66g+sBxS5Daz98
         xNNvRF7bt7+ilUHSnbVjU1WwNsXbXoLVXmU85M71fNvxHIWogFR0Kn4eIYeuipAS5nlu
         Lx0mo/S57rpq32fIi8VYjnmCXuu/AWnteAdYNeFd/VvBTF4f+4M2n3AxCD+RYmemFEzT
         fATosprbp0agnv88ixgVgH7+meHn9bS+T69gWnLZfQ9a71emlBeRfBCIKpb1GkOs5lSU
         VruA==
X-Gm-Message-State: AOJu0Yz/esbG+BMsx1c1IChK+cAtx8g1FlOeTjKiN9IeO2I3fvzJuXPL
        8QgJXHaM5ZJlk2FwL2gHlLVoUdCF7PHHATXRx+g=
X-Google-Smtp-Source: AGHT+IH/bN0yriWqMcZUFRw307hjYWDbxCwfVM6kJe0hedemvwdStnc1gf5EmRl0c87mzWEAyYIy3VcXREfvRfYdIDc=
X-Received: by 2002:a4a:bc82:0:b0:569:a08a:d9c5 with SMTP id
 m2-20020a4abc82000000b00569a08ad9c5mr6195383oop.0.1692637983505; Mon, 21 Aug
 2023 10:13:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230810234856.2580143-1-avadhut.naik@amd.com>
 <a0ab4d07-fb73-418b-b88d-c3ad6aa4cf49@intel.com> <655c916e-356c-03e3-6c67-aa40886dd5e2@amd.com>
 <CAJZ5v0j0R1GK=0z+LJd_PSh4zDv9Ydw2YA7HWm1R5wjCUsbbYQ@mail.gmail.com> <1c579c96-5010-4e5b-aa27-afb4f4f6746a@amd.com>
In-Reply-To: <1c579c96-5010-4e5b-aa27-afb4f4f6746a@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 21 Aug 2023 19:12:47 +0200
Message-ID: <CAJZ5v0iPRCJLH5bkKyhjUq_tmjmR6R73fhUm3JnKptcm1cn9fQ@mail.gmail.com>
Subject: Re: [PATCH] ACPI: PHAT: Add Platform Health Assessment Table support
To:     "Limonciello, Mario" <mario.limonciello@amd.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Avadhut Naik <avadnaik@amd.com>,
        "Wilczynski, Michal" <michal.wilczynski@intel.com>,
        Avadhut Naik <avadhut.naik@amd.com>, lenb@kernel.org,
        linux-acpi@vger.kernel.org, yazen.ghannam@amd.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Aug 21, 2023 at 7:06 PM Limonciello, Mario
<mario.limonciello@amd.com> wrote:
>
>
>
> On 8/18/2023 2:49 AM, Rafael J. Wysocki wrote:
> > On Thu, Aug 17, 2023 at 10:43 PM Avadhut Naik <avadnaik@amd.com> wrote:
> >>
> >> Hi,
> >>
> >> On 8/16/2023 06:35, Wilczynski, Michal wrote:
> >>> Hi,
> >>>
> >>> On 8/11/2023 1:48 AM, Avadhut Naik wrote:
> >>>> ACPI Platform Health Assessment Table (PHAT) enables a platform to expose
> >>>> an extensible set of platform health related telemetry. The telemetry is
> >>>> exposed through Firmware Version and Firmware Health Data Records which
> >>>> provide version data and health-related information of their associated
> >>>> components respectively.
> >>>>
> >>>> Additionally, the platform also provides Reset Reason Health Record in
> >>>> the PHAT table highlighting the cause of last system reset or boot in case
> >>>> of both expected and unexpected events. Vendor-specific data capturing the
> >>>> underlying state of the system during reset can also be optionally provided
> >>>> through the record.[1]
> >>>>
> >>>> Add support to parse the PHAT table during system bootup and have its
> >>>> information logged into the dmesg buffer.
> >>>>
> >>>> [1] ACPI specification 6.5, section 5.2.31.5
> >>>>
> >>>> Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
> >>>> ---
> >>>>   .../admin-guide/kernel-parameters.txt         |   4 +
> >>>>   drivers/acpi/Kconfig                          |   9 +
> >>>>   drivers/acpi/Makefile                         |   1 +
> >>>>   drivers/acpi/phat.c                           | 270 ++++++++++++++++++
> >>>>   include/acpi/actbl2.h                         |  18 ++
> >>>>   5 files changed, 302 insertions(+)
> >>>>   create mode 100644 drivers/acpi/phat.c
> >>>>
> >>>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> >>>> index 722b6eca2e93..33b932302ece 100644
> >>>> --- a/Documentation/admin-guide/kernel-parameters.txt
> >>>> +++ b/Documentation/admin-guide/kernel-parameters.txt
> >>>> @@ -4490,6 +4490,10 @@
> >>>>                       allocator.  This parameter is primarily for debugging
> >>>>                       and performance comparison.
> >>>>
> >>>> +    phat_disable=   [ACPI]
> >>>> +                    Disable PHAT table parsing and logging of Firmware
> >>>> +                    Version and Health Data records.
> >>>> +
> >>>>       pirq=           [SMP,APIC] Manual mp-table setup
> >>>>                       See Documentation/arch/x86/i386/IO-APIC.rst.
> >>>>
> >>>> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> >>>> index 00dd309b6682..06a7dd6e5a40 100644
> >>>> --- a/drivers/acpi/Kconfig
> >>>> +++ b/drivers/acpi/Kconfig
> >>>> @@ -96,6 +96,15 @@ config ACPI_FPDT
> >>>>         This table provides information on the timing of the system
> >>>>         boot, S3 suspend and S3 resume firmware code paths.
> >>>>
> >>>> +config ACPI_PHAT
> >>>> +    bool "ACPI Platform Health Assessment Table (PHAT) support"
> >>>> +    depends on X86_64 || ARM64
> >>>> +    help
> >>>> +      Enable support for Platform Health Assessment Table (PHAT).
> >>>> +      This table exposes an extensible set of platform health
> >>>> +      related telemetry through Firmware Version and Firmware Health
> >>>> +      Data Records.
> >>>> +
> >>>>   config ACPI_LPIT
> >>>>       bool
> >>>>       depends on X86_64
> >>>> diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
> >>>> index 3fc5a0d54f6e..93a4ec57ba6d 100644
> >>>> --- a/drivers/acpi/Makefile
> >>>> +++ b/drivers/acpi/Makefile
> >>>> @@ -69,6 +69,7 @@ acpi-$(CONFIG_ACPI_WATCHDOG)       += acpi_watchdog.o
> >>>>   acpi-$(CONFIG_ACPI_PRMT)    += prmt.o
> >>>>   acpi-$(CONFIG_ACPI_PCC)             += acpi_pcc.o
> >>>>   acpi-$(CONFIG_ACPI_FFH)             += acpi_ffh.o
> >>>> +acpi-$(CONFIG_ACPI_PHAT)    += phat.o
> >>>>
> >>>>   # Address translation
> >>>>   acpi-$(CONFIG_ACPI_ADXL)    += acpi_adxl.o
> >>>> diff --git a/drivers/acpi/phat.c b/drivers/acpi/phat.c
> >>>> new file mode 100644
> >>>> index 000000000000..6006dd7615fa
> >>>> --- /dev/null
> >>>> +++ b/drivers/acpi/phat.c
> >>>> @@ -0,0 +1,270 @@
> >>>> +// SPDX-License-Identifier: GPL-2.0
> >>>> +/*
> >>>> + * Platform Health Assessment Table (PHAT) support
> >>>> + *
> >>>> + * Copyright (C) 2023 Advanced Micro Devices, Inc.
> >>>> + *
> >>>> + * Author: Avadhut Naik <avadhut.naik@amd.com>
> >>>> + *
> >>>> + * This file implements parsing of the Platform Health Assessment Table
> >>>> + * through which a platform can expose an extensible set of platform
> >>>> + * health related telemetry. The telemetry is exposed through Firmware
> >>>> + * Version Data Records and Firmware Health Data Records. Additionally,
> >>>> + * a platform, through system firmware, also exposes Reset Reason Health
> >>>> + * Record to inform the operating system of the cause of last system
> >>>> + * reset or boot.
> >>>> + *
> >>>> + * For more information on PHAT, please refer to ACPI specification
> >>>> + * version 6.5, section 5.2.31
> >>>> + */
> >>>> +
> >>>> +#include <linux/acpi.h>
> >>>> +
> >>>> +static int phat_disable __initdata;
> >>>> +static const char *prefix = "ACPI PHAT: ";
> >>>
> >>> Wouldn't it be better if you used pr_fmt macro instead ?
> >>>
> >>          Have explained below.
> >>>> +
> >>>> +/* Reset Reason Health Record GUID */
> >>>> +static const guid_t reset_guid =
> >>>> +    GUID_INIT(0x7a014ce2, 0xf263, 0x4b77,
> >>>> +              0xb8, 0x8a, 0xe6, 0x33, 0x6b, 0x78, 0x2c, 0x14);
> >>>> +
> >>>> +static struct { u8 mask; const char *str; } const reset_sources[] = {
> >>>> +    {BIT(0), "Unknown source"},
> >>>> +    {BIT(1), "Hardware Source"},
> >>>> +    {BIT(2), "Firmware Source"},
> >>>> +    {BIT(3), "Software initiated reset"},
> >>>> +    {BIT(4), "Supervisor initiated reset"},
> >>>> +};
> >>>> +
> >>>> +static struct { u8 val; const char *str; } const reset_reasons[] = {
> >>>> +    {0, "UNKNOWN"},
> >>>> +    {1, "COLD BOOT"},
> >>>> +    {2, "COLD RESET"},
> >>>> +    {3, "WARM RESET"},
> >>>> +    {4, "UPDATE"},
> >>>> +    {32, "UNEXPECTED RESET"},
> >>>> +    {33, "FAULT"},
> >>>> +    {34, "TIMEOUT"},
> >>>> +    {35, "THERMAL"},
> >>>> +    {36, "POWER LOSS"},
> >>>> +    {37, "POWER BUTTON"},
> >>>> +};
> >>>> +
> >>>> +/*
> >>>> + * Print the last PHAT Version Element associated with a Firmware
> >>>> + * Version Data Record.
> >>>> + * Firmware Version Data Record consists of an array of PHAT Version
> >>>> + * Elements with each entry in the array representing a modification
> >>>> + * undertaken on a given platform component.
> >>>> + * In the event the array has multiple entries, minimize logs on the
> >>>> + * console and print only the last version element since it denotes
> >>>> + * the currently running instance of the component.
> >>>> + */
> >>>> +static int phat_version_data_parse(const char *pfx,
> >>>> +                               struct acpi_phat_version_data *version)
> >>>> +{
> >>>> +    char newpfx[64];
> >>>> +    u32 num_elems = version->element_count - 1;
> >>>> +    struct acpi_phat_version_element *element;
> >>>> +    int offset = sizeof(struct acpi_phat_version_data);
> >>>> +
> >>>> +    if (!version->element_count) {
> >>>> +            pr_info("%sNo PHAT Version Elements found.\n", prefix);
> >>>> +            return 0;
> >>>> +    }
> >>>> +
> >>>> +    offset += num_elems * sizeof(struct acpi_phat_version_element);
> >>>> +    element = (void *)version + offset;
> >>>> +
> >>>> +    pr_info("%sPHAT Version Element:\n", pfx);
> >>>> +    snprintf(newpfx, sizeof(newpfx), "%s ", pfx);
> >>>> +    pr_info("%sComponent ID: %pUl\n", newpfx, element->guid);
> >>>> +    pr_info("%sVersion: 0x%llx\n", newpfx, element->version_value);
> >>>> +    snprintf(newpfx, sizeof(newpfx), KERN_INFO "%s ", pfx);
> >>>> +    print_hex_dump(newpfx, "Producer ID: ", DUMP_PREFIX_NONE, 16, 4,
> >>>> +                   &element->producer_id, sizeof(element->producer_id), true);
> >>>
> >>> I do have to admit that all this dancing with pfx and newpfx confuses me. Couldn't you
> >>> just use pr_fmt for everything printed using pr_* family of functions ? print_hex_dump()
> >>> is not impacted by pr_fmt, as it just uses printk to do it's printing.
> >>>
> >> I had considered using pr_fmt initially but since the ACPI spec says that PHAT health records,
> >> especially reset reason health record is intended to complement existing fault reporting
> >> mechanisms like BERT Tables, CPER, decided to have their outputs in identical formats, like has
> >> been implemented in cper_estatus_print().
> >>
> >>>> +
> >>>> +    return 0;
> >>>> +}
> >>>> +
> >>>> +/*
> >>>> + * Print the Reset Reason Health Record
> >>>> + */
> >>>> +static int phat_reset_reason_parse(const char *pfx,
> >>>> +                               struct acpi_phat_health_data *record)
> >>>> +{
> >>>> +    int idx;
> >>>> +    void *data;
> >>>> +    u32 data_len;
> >>>> +    char newpfx[64];
> >>>> +    struct acpi_phat_reset_reason *rr;
> >>>> +    struct acpi_phat_vendor_reset_data *vdata;
> >>>> +
> >>>> +    rr = (void *)record + record->device_specific_offset;
> >>>> +
> >>>> +    for (idx = 0; idx < ARRAY_SIZE(reset_sources); idx++) {
> >>>> +            if (!rr->reset_source) {
> >>>> +                    pr_info("%sUnknown Reset Source.\n", pfx);
> >>>> +                    break;
> >>>> +            }
> >>>> +            if (rr->reset_source & reset_sources[idx].mask) {
> >>>> +                    pr_info("%sReset Source: 0x%x\t%s\n", pfx, reset_sources[idx].mask,
> >>>> +                            reset_sources[idx].str);
> >>>> +                    /* According to ACPI v6.5 Table 5.168, Sub-Source is
> >>>> +                     * defined only for Software initiated reset.
> >>>> +                     */
> >>>> +                    if (idx == 0x3 && rr->reset_sub_source)
> >>>> +                            pr_info("%sReset Sub-Source: %s\n", pfx,
> >>>> +                                    rr->reset_sub_source == 0x1 ?
> >>>> +                                    "Operating System" : "Hypervisor");
> >>>> +                    break;
> >>>> +            }
> >>>> +    }
> >>>> +
> >>>> +    for (idx = 0; idx < ARRAY_SIZE(reset_reasons); idx++) {
> >>>> +            if (rr->reset_reason == reset_reasons[idx].val) {
> >>>> +                    pr_info("%sReset Reason: 0x%x\t%s\n", pfx, reset_reasons[idx].val,
> >>>> +                            reset_reasons[idx].str);
> >>>> +                    break;
> >>>> +            }
> >>>> +    }
> >>>> +
> >>>> +    if (!rr->vendor_count)
> >>>> +            return 0;
> >>>> +
> >>>> +    pr_info("%sReset Reason Vendor Data:\n", pfx);
> >>>> +    vdata = (void *)rr + sizeof(*rr);
> >>>> +
> >>>> +    for (idx = 0; idx < rr->vendor_count; idx++) {
> >>>> +            snprintf(newpfx, sizeof(newpfx), "%s ", pfx);
> >>>> +            data_len = vdata->length - sizeof(*vdata);
> >>>> +            data = (void *)vdata + sizeof(*vdata);
> >>>> +            pr_info("%sVendor Data ID: %pUl\n", newpfx, vdata->vendor_id);
> >>>> +            pr_info("%sRevision: 0x%x\n", newpfx, vdata->revision);
> >>>> +            snprintf(newpfx, sizeof(newpfx), KERN_INFO "%s ", pfx);
> >>>> +            print_hex_dump(newpfx, "Data: ", DUMP_PREFIX_NONE, 16, 4,
> >>>> +                           data, data_len, false);
> >>>> +            vdata = (void *)vdata + vdata->length;
> >>>> +    }
> >>>> +
> >>>> +    return 0;
> >>>> +}
> >>>> +
> >>>> +/*
> >>>> + * Print the Firmware Health Data Record.
> >>>> + */
> >>>> +static int phat_health_data_parse(const char *pfx,
> >>>> +                              struct acpi_phat_health_data *record)
> >>>> +{
> >>>> +    void *data;
> >>>> +    u32 data_len;
> >>>> +    char newpfx[64];
> >>>> +
> >>>> +    pr_info("%sHealth Records.\n", pfx);
> >>>> +    snprintf(newpfx, sizeof(newpfx), "%s ", pfx);
> >>>> +    pr_info("%sDevice Signature: %pUl\n", newpfx, record->device_guid);
> >>>> +
> >>>> +    switch (record->health) {
> >>>> +    case ACPI_PHAT_ERRORS_FOUND:
> >>>> +            pr_info("%sAmHealthy: Errors found\n", newpfx);
> >>>> +            break;
> >>>> +    case ACPI_PHAT_NO_ERRORS:
> >>>> +            pr_info("%sAmHealthy: No errors found.\n", newpfx);
> >>>> +            break;
> >>>> +    case ACPI_PHAT_UNKNOWN_ERRORS:
> >>>> +            pr_info("%sAmHealthy: Unknown.\n", newpfx);
> >>>> +            break;
> >>>> +    case ACPI_PHAT_ADVISORY:
> >>>> +            pr_info("%sAmHealthy: Advisory – additional device-specific data exposed.\n",
> >>>> +                    newpfx);
> >>>> +            break;
> >>>> +    default:
> >>>> +            break;
> >>>> +    }
> >>>> +
> >>>> +    if (!record->device_specific_offset)
> >>>> +            return 0;
> >>>> +
> >>>> +    /* Reset Reason Health Record has a unique GUID and is created as
> >>>> +     * a Health Record in the PHAT table. Check if this Health Record
> >>>> +     * is a Reset Reason Health Record.
> >>>> +     */
> >>>> +    if (guid_equal((guid_t *)record->device_guid, &reset_guid)) {
> >>>> +            phat_reset_reason_parse(newpfx, record);
> >>>> +            return 0;
> >>>> +    }
> >>>> +
> >>>> +    data = (void *)record + record->device_specific_offset;
> >>>> +    data_len = record->header.length - record->device_specific_offset;
> >>>> +    snprintf(newpfx, sizeof(newpfx), KERN_INFO "%s ", pfx);
> >>>> +    print_hex_dump(newpfx, "Device Data: ", DUMP_PREFIX_NONE, 16, 4,
> >>>> +                   data, data_len, false);
> >>>> +
> >>>> +    return 0;
> >>>> +}
> >>>> +
> >>>> +static int parse_phat_table(const char *pfx, struct acpi_table_phat *phat_tab)
> >>>> +{
> >>>> +    char newpfx[64];
> >>>> +    u32 offset = sizeof(*phat_tab);
> >>>> +    struct acpi_phat_header *phat_header;
> >>>> +
> >>>> +    snprintf(newpfx, sizeof(newpfx), "%s ", pfx);
> >>>> +
> >>>> +    while (offset < phat_tab->header.length) {
> >>>> +            phat_header = (void *)phat_tab + offset;
> >>>> +            switch (phat_header->type) {
> >>>> +            case ACPI_PHAT_TYPE_FW_VERSION_DATA:
> >>>> +                    phat_version_data_parse(newpfx, (struct acpi_phat_version_data *)
> >>>> +                        phat_header);
> >>>> +                    break;
> >>>> +            case ACPI_PHAT_TYPE_FW_HEALTH_DATA:
> >>>> +                    phat_health_data_parse(newpfx, (struct acpi_phat_health_data *)
> >>>> +                        phat_header);
> >>>> +                    break;
> >>>> +            default:
> >>>> +                    break;
> >>>> +            }
> >>>> +            offset += phat_header->length;
> >>>> +    }
> >>>> +    return 0;
> >>>> +}
> >>>> +
> >>>> +static int __init setup_phat_disable(char *str)
> >>>> +{
> >>>> +    phat_disable = 1;
> >>>> +    return 1;
> >>>> +}
> >>>> +__setup("phat_disable", setup_phat_disable);
> >>>> +
> >>>> +static int __init acpi_phat_init(void)
> >>>> +{
> >>>> +    acpi_status status;
> >>>> +    struct acpi_table_phat *phat_tab;
> >>>> +
> >>>> +    if (acpi_disabled)
> >>>> +            return 0;
> >>>> +
> >>>> +    if (phat_disable) {
> >>>> +            pr_err("%sPHAT support has been disabled.\n", prefix);
> >>>> +            return 0;
> >>>> +    }
> >>>> +
> >>>> +    status = acpi_get_table(ACPI_SIG_PHAT, 0,
> >>>> +                            (struct acpi_table_header **)&phat_tab);
> >>>> +
> >>>> +    if (status == AE_NOT_FOUND) {
> >>>> +            pr_info("%sPHAT Table not found.\n", prefix);
> >>>> +            return 0;
> >>>> +    } else if (ACPI_FAILURE(status)) {
> >>>> +            pr_err("%sFailed to get PHAT Table: %s.\n", prefix,
> >>>> +                   acpi_format_exception(status));
> >>>> +            return -EINVAL;
> >>>> +    }
> >>>> +
> >>>> +    pr_info("%sPlatform Telemetry Records.\n", prefix);
> >>>> +    parse_phat_table(prefix, phat_tab);
> >>>
> >>> So for now you're only dumping tables to the dmesg output ?
> >>> Are you planning to create some sysfs interfaces similar to let's
> >>> say EINJ ?
> >>>
> >> Yes, for now, the output is being posted to dmesg only.
> >
> > So it is not particularly useful for anything practical.
> >
> >> If there is a consensus, we can have the information exported through
> >> sysfs too.
> >
> > That depends on how you want to use it which should be explained in
> > the patch changelog.
> >
> > Now it's basically "it's there, so dump it" which leads to the obvious
> > question: "Who's going to need it?"
> >
>
> I was just talking to some colleagues about PHAT recently as well.
>
> The use case that jumps out is "system randomly rebooted while I was
> doing XYZ".  You don't know what happened, but you keep using your
> system.  Then it happens again.
>
> If the reason for the random reboot is captured to dmesg you can cross
> reference your journal from the next boot after any random reboot and
> get the reason for it.  If a user reports this to a Gitlab issue tracker
> or Bugzilla it can be helpful in establishing a pattern.
>
> >> The below location may be appropriate in that case:
> >> /sys/firmware/acpi/
> >
> > Yes, it may. >
> >> We already have FPDT and BGRT being exported from there.
> >
> > In fact, all of the ACPI tables can be retrieved verbatim from
> > /sys/firmware/acpi/tables/ already, so why exactly do you want the
> > kernel to parse PHAT in particular?
> >
>
> It's not to say that /sys/firmware/acpi/PHAT isn't useful, but having
> something internal to the kernel "automatically" parsing it and saving
> information to a place like the kernel log that is already captured by
> existing userspace tools I think is "more" useful.

What existing user space tools do you mean?  Is there anything already
making use of the kernel's PHAT output?

And why can't user space simply parse PHAT by itself?

There are multiple ACPI tables that could be dumped into the kernel
log, but they aren't.  Guess why.
