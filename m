Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E12A54E5912
	for <lists+linux-acpi@lfdr.de>; Wed, 23 Mar 2022 20:24:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244371AbiCWTZe (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 23 Mar 2022 15:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239696AbiCWTZd (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 23 Mar 2022 15:25:33 -0400
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3F084B1FD;
        Wed, 23 Mar 2022 12:24:02 -0700 (PDT)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-2e5969bdf31so28785817b3.8;
        Wed, 23 Mar 2022 12:24:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8+zCtweuUbk4pYR9zUHGHyQzp2u1D5wKnQ/kurzCtyM=;
        b=fCSZayMG+amqRbOsv3s5xetcyidbbaIjGo9cpnBeYfjlxOsv5W7c/bOLwOhXcGdCDj
         UCSAxg3jpQEV+6Q4Sv8w0Xmb/kLzAHRUrXT2J0RW1T8Q2djp/kMz7uzT0BMQFlo4XsP0
         vCud80Uvabwyan4ZtBv/QT4GaOXO1pyKjSTKVEIE4uSE78ybyhoxZa4vSmHk+n7UiExZ
         unQrzQpZ2P9Ym1rdv965iBzX5eLcERFemNqYxGqh9CyNTNmDA7tTk9NOhp8QMshSbut2
         oZiFSINj62GZ44Zf68aj8eYm6SpUljf6jY+lVcwHYNZ5qBx2Fb7vpgCNYFztbNvy09uL
         UjpQ==
X-Gm-Message-State: AOAM531RHLAEQfKhLtC6wtYyDkcKvbSdBosM/9mHFpOx1M6QRUNM75nm
        gQFH2Dbiya9t6Jd3xQ4LX6M+/fGRApprgO+h2go=
X-Google-Smtp-Source: ABdhPJyzDIRtViBqyHSnrm4bzq19tDPYSyLPu+mqsWcfy1IeCI5C/0EGrJqTJCiKUbwX5zViKY/OVeFvR9rCV9DxHg4=
X-Received: by 2002:a81:5cf:0:b0:2e5:7477:168e with SMTP id
 198-20020a8105cf000000b002e57477168emr1557991ywf.149.1648063441953; Wed, 23
 Mar 2022 12:24:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220318213004.2287428-1-vishal.l.verma@intel.com> <20220318213004.2287428-2-vishal.l.verma@intel.com>
In-Reply-To: <20220318213004.2287428-2-vishal.l.verma@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 23 Mar 2022 20:23:50 +0100
Message-ID: <CAJZ5v0j42Fd4X=GEHDMS6_bxcaT8ncU5vh6+pUjCGhGrD9U0vA@mail.gmail.com>
Subject: Re: [PATCH 1/2] PCI/ACPI: Use CXL _OSC instead of PCIe _OSC
To:     Vishal Verma <vishal.l.verma@intel.com>
Cc:     linux-cxl@vger.kernel.org,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Robert Moore <robert.moore@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
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

On Fri, Mar 18, 2022 at 10:30 PM Vishal Verma <vishal.l.verma@intel.com> wrote:
>
> From: Dan Williams <dan.j.williams@intel.com>
>
> Rather than pass a boolean flag alongside @root to all the helper
> functions that need to consider PCIe specifics, add is_pcie() and
> is_cxl() helper functions to check the flavor of @root. This also
> allows for dynamic fallback to PCIe _OSC in cases where an attempt to
> use CXL _OXC fails. This can happen on CXL 1.1 platforms that publish
> ACPI0016 devices to indicate CXL host bridges, but do not publish the
> optional CXL _OSC method. CXL _OSC is mandatory for CXL 2.0 hosts.
>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Robert Moore <robert.moore@intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
> ---
>  include/acpi/acpi_bus.h |  1 +
>  drivers/acpi/pci_root.c | 62 +++++++++++++++++++++++++++++++----------
>  2 files changed, 48 insertions(+), 15 deletions(-)
>
> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> index ca88c4706f2b..768ef1584055 100644
> --- a/include/acpi/acpi_bus.h
> +++ b/include/acpi/acpi_bus.h
> @@ -585,6 +585,7 @@ struct acpi_pci_root {
>         struct acpi_device * device;
>         struct pci_bus *bus;
>         u16 segment;
> +       bool cxl_osc_disable;
>         struct resource secondary;      /* downstream bus range */
>
>         u32 osc_support_set;    /* _OSC state of support bits */
> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> index b76db99cced3..2d834504096b 100644
> --- a/drivers/acpi/pci_root.c
> +++ b/drivers/acpi/pci_root.c
> @@ -170,20 +170,47 @@ static void decode_osc_control(struct acpi_pci_root *root, char *msg, u32 word)
>                         ARRAY_SIZE(pci_osc_control_bit));
>  }
>
> -static u8 pci_osc_uuid_str[] = "33DB4D5B-1FF7-401C-9657-7441C03DD766";
> +static bool is_pcie(struct acpi_pci_root *root)
> +{
> +       return strcmp(acpi_device_hid(root->device), "PNP0A08") == 0;
> +}
>
> -static acpi_status acpi_pci_run_osc(acpi_handle handle,
> +static bool is_cxl(struct acpi_pci_root *root)
> +{
> +       if (root->cxl_osc_disable)
> +               return false;
> +       return strcmp(acpi_device_hid(root->device), "ACPI0016") == 0;

One more thing.

This will cause the device ID matching to take place every time
is_cxl() is called which seems a bit excessive to me (and the same
applies to the PCIe counterpart).

IMV it would make sense to have a "bridge_type" field instead of
cxl_osc_disable in acpi_pci_root and use that for all of the checks.

Moreover, IIUC every CXL bridge is also a PCIe one, so the
"bridge_type" could be say 1 for PCIe and 2 for CXL and checks like
"bridge_type >= PCIe" would cover both these types then.

> +}
> +
> +static u8 pci_osc_uuid_str[] = "33DB4D5B-1FF7-401C-9657-7441C03DD766";
> +static u8 cxl_osc_uuid_str[] = "68F2D50B-C469-4d8A-BD3D-941A103FD3FC";
> +
> +static char *to_uuid(struct acpi_pci_root *root)
> +{
> +       if (is_cxl(root))
> +               return cxl_osc_uuid_str;
> +       return pci_osc_uuid_str;
> +}
> +
> +static int cap_length(struct acpi_pci_root *root)
> +{
> +       if (is_cxl(root))
> +               return sizeof(u32) * 6;
> +       return sizeof(u32) * 3;
> +}
> +
> +static acpi_status acpi_pci_run_osc(struct acpi_pci_root *root,
>                                     const u32 *capbuf, u32 *retval)
>  {
>         struct acpi_osc_context context = {
> -               .uuid_str = pci_osc_uuid_str,
> +               .uuid_str = to_uuid(root),
>                 .rev = 1,
> -               .cap.length = 12,
> +               .cap.length = cap_length(root),
>                 .cap.pointer = (void *)capbuf,
>         };
>         acpi_status status;
>
> -       status = acpi_run_osc(handle, &context);
> +       status = acpi_run_osc(root->device->handle, &context);
>         if (ACPI_SUCCESS(status)) {
>                 *retval = *((u32 *)(context.ret.pointer + 8));
>                 kfree(context.ret.pointer);
> @@ -196,7 +223,7 @@ static acpi_status acpi_pci_query_osc(struct acpi_pci_root *root,
>                                         u32 *control)
>  {
>         acpi_status status;
> -       u32 result, capbuf[3];
> +       u32 result, capbuf[6];
>
>         support |= root->osc_support_set;
>
> @@ -204,10 +231,18 @@ static acpi_status acpi_pci_query_osc(struct acpi_pci_root *root,
>         capbuf[OSC_SUPPORT_DWORD] = support;
>         capbuf[OSC_CONTROL_DWORD] = *control | root->osc_control_set;
>
> -       status = acpi_pci_run_osc(root->device->handle, capbuf, &result);
> +retry:
> +       status = acpi_pci_run_osc(root, capbuf, &result);
>         if (ACPI_SUCCESS(status)) {
>                 root->osc_support_set = support;
>                 *control = result;
> +       } else if (is_cxl(root)) {
> +               /*
> +                * CXL _OSC is optional on CXL 1.1 hosts. Fall back to PCIe _OSC
> +                * upon any failure using CXL _OSC.
> +                */
> +               root->cxl_osc_disable = true;
> +               goto retry;
>         }
>         return status;
>  }
> @@ -338,7 +373,7 @@ static acpi_status acpi_pci_osc_control_set(acpi_handle handle, u32 *mask, u32 s
>         u32 req = OSC_PCI_EXPRESS_CAPABILITY_CONTROL;
>         struct acpi_pci_root *root;
>         acpi_status status;
> -       u32 ctrl, capbuf[3];
> +       u32 ctrl, capbuf[6];
>
>         if (!mask)
>                 return AE_BAD_PARAMETER;
> @@ -375,7 +410,7 @@ static acpi_status acpi_pci_osc_control_set(acpi_handle handle, u32 *mask, u32 s
>         capbuf[OSC_QUERY_DWORD] = 0;
>         capbuf[OSC_SUPPORT_DWORD] = root->osc_support_set;
>         capbuf[OSC_CONTROL_DWORD] = ctrl;
> -       status = acpi_pci_run_osc(handle, capbuf, mask);
> +       status = acpi_pci_run_osc(root, capbuf, mask);
>         if (ACPI_FAILURE(status))
>                 return status;
>
> @@ -454,8 +489,7 @@ static bool os_control_query_checks(struct acpi_pci_root *root, u32 support)
>         return true;
>  }
>
> -static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm,
> -                                bool is_pcie)
> +static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm)
>  {
>         u32 support, control = 0, requested = 0;
>         acpi_status status;
> @@ -506,7 +540,7 @@ static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm,
>                 *no_aspm = 1;
>
>                 /* _OSC is optional for PCI host bridges */
> -               if ((status == AE_NOT_FOUND) && !is_pcie)
> +               if ((status == AE_NOT_FOUND) && !is_pcie(root))
>                         return;
>
>                 if (control) {
> @@ -529,7 +563,6 @@ static int acpi_pci_root_add(struct acpi_device *device,
>         acpi_handle handle = device->handle;
>         int no_aspm = 0;
>         bool hotadd = system_state == SYSTEM_RUNNING;
> -       bool is_pcie;
>
>         root = kzalloc(sizeof(struct acpi_pci_root), GFP_KERNEL);
>         if (!root)
> @@ -587,8 +620,7 @@ static int acpi_pci_root_add(struct acpi_device *device,
>
>         root->mcfg_addr = acpi_pci_root_get_mcfg_addr(handle);
>
> -       is_pcie = strcmp(acpi_device_hid(device), "PNP0A08") == 0;
> -       negotiate_os_control(root, &no_aspm, is_pcie);
> +       negotiate_os_control(root, &no_aspm);
>
>         /*
>          * TBD: Need PCI interface for enumeration/configuration of roots.
> --
> 2.35.1
>
