Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 098804F46CA
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Apr 2022 01:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239517AbiDEUow (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 5 Apr 2022 16:44:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390859AbiDEPb7 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 5 Apr 2022 11:31:59 -0400
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77B4A47557;
        Tue,  5 Apr 2022 06:39:15 -0700 (PDT)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-2e64a6b20eeso136279587b3.3;
        Tue, 05 Apr 2022 06:39:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xu8dCP9+ges59hYAud7ZVJg5s22Xz6FJgwXRQOOm3bk=;
        b=cNliRDg6ky+fj9yhXXEFqJPUFqZacpuj56+l/XOh472FbqD7sJMHndEeRdBmbbLwTO
         VuhzkQAK/hT22FC1QcxJOeYBsin8bVh3/4QrcEZhxu8lK4MOnr72mCdeYLLwCr5pixAy
         YLcL1pUHAAni8DIBGOnf3FSmGIx8G9FxaJTEiKOTazL5oYKDlVc5lEliTKtcJG7gTukE
         9p8dmqcMOIn9K5VLvfW3C90DVEf4fDE0Szh5a1jgb9fNC5QwcglHQTFZxwWJDQ8dpfGd
         RLKgWHCfW3jr5p1W/po8z3O/pKoodOkp9lZyi4oaMYlctLTcb+3nHkcEiJD+Ojq++kA6
         KGgA==
X-Gm-Message-State: AOAM5321jKesubEy+LJ2XlVFqhzQHNA46x7d8YKKTdxvMPwtAVb4Z1lf
        OBTVdZwxC9GvVnzCsZZJrKfcc/05nBPw3RsNrvA=
X-Google-Smtp-Source: ABdhPJzba05Bydu6AYZ9ZGbyamM84Ar4fPOHIUcmSa0oeKSfqw32ZxwpZ4BNKw0VOpDEm+P2Kg7XAPjSLhopOECX7Hc=
X-Received: by 2002:a81:1b97:0:b0:2db:640f:49d8 with SMTP id
 b145-20020a811b97000000b002db640f49d8mr2606206ywb.326.1649165954470; Tue, 05
 Apr 2022 06:39:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220331202022.1823174-1-vishal.l.verma@intel.com> <20220331202022.1823174-2-vishal.l.verma@intel.com>
In-Reply-To: <20220331202022.1823174-2-vishal.l.verma@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 5 Apr 2022 15:39:03 +0200
Message-ID: <CAJZ5v0h3nUxQ=d8kUrJ=mdkFHyVkopPyFQ1MbJKXmdpzy1cBJA@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] PCI/ACPI: add a helper for retrieving _OSC Control DWORDs
To:     Vishal Verma <vishal.l.verma@intel.com>
Cc:     linux-cxl@vger.kernel.org,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Robert Moore <robert.moore@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
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

On Thu, Mar 31, 2022 at 10:20 PM Vishal Verma <vishal.l.verma@intel.com> wrote:
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
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

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
