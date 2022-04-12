Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A5434FE88A
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Apr 2022 21:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237235AbiDLTZj (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 12 Apr 2022 15:25:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233281AbiDLTZi (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 12 Apr 2022 15:25:38 -0400
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDC0728E18;
        Tue, 12 Apr 2022 12:23:19 -0700 (PDT)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-2ec04a2ebadso92916167b3.12;
        Tue, 12 Apr 2022 12:23:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fJUyWVquXV03Ry/tx3y9z0Rro6A6gcTsDJ2a1oTssRE=;
        b=lANiqzU1x/jufqUyFvzhMXyLwYarpeM6MLH4VdAGPDWsrSrEX+Q/LBm2C8enyzYDCk
         zIhyefOJUJyJK7f/IccrZpNJPiuElX9RI2nGlW2gXQK3URMhtkjcpk6Z+kZHHaiWW0Ch
         wJVt7HS/CYGYm6FaPCQG7uYoGOACCT4hcUwc3VbQxH5A9Bwl7gQKprSaV6LZUYPUHcdS
         RbRxkijXx0AlOspqRXJcGA4TFP0pfVj5CYZPtYXfraP66YlPc8OSju2SmRXZKqu+xtpT
         tXjXI/OxEVDxFGTRnDUqZXG1OmlH0zV3nbvCKVJCRzmRvNxRWIj7T02XdKrf1FjOV/DK
         ph7w==
X-Gm-Message-State: AOAM530mlWwShM7yGN/jgRQZEpViEBjpZhBu6UgmBOP+vS7VWfVJrytn
        dmYlDwe1mmPiiR92CW58FojuZrBAlDkOjzz48vs=
X-Google-Smtp-Source: ABdhPJwQVewnY+chD5k6PT908ZYoGSauH8hVblRGj4Nt2npLy6HppGoPDYG4Um32kmyjJqyV2hFOnmnSofzwMoo3WTU=
X-Received: by 2002:a81:ece:0:b0:2ec:9f8:acba with SMTP id 197-20020a810ece000000b002ec09f8acbamr11210841ywo.149.1649791399168;
 Tue, 12 Apr 2022 12:23:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220406023746.2807328-1-vishal.l.verma@intel.com> <20220406023746.2807328-2-vishal.l.verma@intel.com>
In-Reply-To: <20220406023746.2807328-2-vishal.l.verma@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 12 Apr 2022 21:23:08 +0200
Message-ID: <CAJZ5v0io-Py0Rx3t8mabyhhvdndAUdWhpg6f6oBHh4toHZPAxw@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] PCI/ACPI: add a helper for retrieving _OSC Control DWORDs
To:     Vishal Verma <vishal.l.verma@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-cxl@vger.kernel.org,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Robert Moore <robert.moore@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>, a.manzanares@samsung.com,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Apr 6, 2022 at 4:38 AM Vishal Verma <vishal.l.verma@intel.com> wrote:
>
> During _OSC negotiation, when the 'Control' DWORD is needed from the
> result buffer after running _OSC, a couple of places performed manual
> pointer arithmetic to offset into the right spot in the raw buffer.
> Add a acpi_osc_ctx_get_pci_control() helper to use the #define'd
> DWORD offsets to fetch the DWORDs needed from @acpi_osc_context, and
> replace the above instances of the open-coded arithmetic.
>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Suggested-by: Davidlohr Bueso <dave@stgolabs.net>
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>

Please feel free to add

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

to this patch.

Or I can take this series unless Bjorn wants to do that.

Bjorn, please let me know what you prefer here.

> ---
>  include/linux/acpi.h    | 13 +++++++++++++
>  drivers/acpi/bus.c      |  2 +-
>  drivers/acpi/pci_root.c |  2 +-
>  3 files changed, 15 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 6274758648e3..ff4d1fdd9009 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -607,6 +607,13 @@ extern u32 osc_sb_native_usb4_control;
>  #define OSC_PCI_EXPRESS_LTR_CONTROL            0x00000020
>  #define OSC_PCI_EXPRESS_DPC_CONTROL            0x00000080
>
> +static inline u32 acpi_osc_ctx_get_pci_control(struct acpi_osc_context *context)
> +{
> +       u32 *ret = context->ret.pointer;
> +
> +       return ret[OSC_CONTROL_DWORD];
> +}
> +
>  #define ACPI_GSB_ACCESS_ATTRIB_QUICK           0x00000002
>  #define ACPI_GSB_ACCESS_ATTRIB_SEND_RCV         0x00000004
>  #define ACPI_GSB_ACCESS_ATTRIB_BYTE            0x00000006
> @@ -1003,6 +1010,12 @@ static inline int acpi_register_wakeup_handler(int wake_irq,
>  static inline void acpi_unregister_wakeup_handler(
>         bool (*wakeup)(void *context), void *context) { }
>
> +struct acpi_osc_context;
> +static inline u32 acpi_osc_ctx_get_pci_control(struct acpi_osc_context *context)
> +{
> +       return 0;
> +}
> +
>  #endif /* !CONFIG_ACPI */
>
>  #ifdef CONFIG_ACPI_HOTPLUG_IOAPIC
> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> index 07f604832fd6..4992e05cf429 100644
> --- a/drivers/acpi/bus.c
> +++ b/drivers/acpi/bus.c
> @@ -405,7 +405,7 @@ static void acpi_bus_osc_negotiate_usb_control(void)
>         }
>
>         osc_sb_native_usb4_control =
> -               control & ((u32 *)context.ret.pointer)[OSC_CONTROL_DWORD];
> +               control &  acpi_osc_ctx_get_pci_control(&context);
>
>         acpi_bus_decode_usb_osc("USB4 _OSC: OS supports", control);
>         acpi_bus_decode_usb_osc("USB4 _OSC: OS controls",
> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> index b76db99cced3..40a74ff3fa02 100644
> --- a/drivers/acpi/pci_root.c
> +++ b/drivers/acpi/pci_root.c
> @@ -185,7 +185,7 @@ static acpi_status acpi_pci_run_osc(acpi_handle handle,
>
>         status = acpi_run_osc(handle, &context);
>         if (ACPI_SUCCESS(status)) {
> -               *retval = *((u32 *)(context.ret.pointer + 8));
> +               *retval = acpi_osc_ctx_get_pci_control(&context);
>                 kfree(context.ret.pointer);
>         }
>         return status;
> --
> 2.35.1
>
