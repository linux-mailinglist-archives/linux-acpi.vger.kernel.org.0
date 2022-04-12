Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 664874FE888
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Apr 2022 21:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348092AbiDLTXj (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 12 Apr 2022 15:23:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346746AbiDLTXh (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 12 Apr 2022 15:23:37 -0400
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23BA71DA49;
        Tue, 12 Apr 2022 12:21:19 -0700 (PDT)
Received: by mail-yb1-f172.google.com with SMTP id g34so14908174ybj.1;
        Tue, 12 Apr 2022 12:21:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gw5IAxP5wwSPpENhRjjidH9+RtItsa5DqkuktOavN4Y=;
        b=0G/ofGDQnMln+nLd7QDSbShh/YvvtYbc4Yk6dX7HIN8mmveht4QYhiV32GJUFsjwld
         /TzKS9tewuczC1l7Vx88W10BX4N/0CbNHwlSpamibt2QORIk42lxiWLuYnwAb4vNZq+V
         9/7BzHb3eJUS7IX7h9HnkTDuOWRbLxufyvWaL6qwTJoEKSDAQ0aq6XpqNrXvyLeDw7C9
         mL3tDzHWamTFvxvBBrqPLoJv5kDOtLqQa5SZ7nD2sNxfL4Q2HgBQy+0VwsxudOmlzv/n
         K11XPbVSO5v+eGx3/SzLXyV2iQMGLu1YOxcqPpARBmqrNiuCxEfsv4QO+ZUD3bCEygAk
         nDtg==
X-Gm-Message-State: AOAM5301jgxfX0OANyHcDCeP45HIaUBw+vvnknbNQikzplYoRoRRfkKG
        rlnl1lO9jDwiptf/oXLw4fUF8eNcdcqb4HbsEDM=
X-Google-Smtp-Source: ABdhPJyAqyCtOxWuA/ZkUMZbmHIZDmkUxgHj1FRCnuNTtiOwS1P/XUlYdjZ2OdaFC3OzMGMJRxeMwIzlghz9ccrGQ1A=
X-Received: by 2002:a05:6902:187:b0:63d:9c95:edca with SMTP id
 t7-20020a056902018700b0063d9c95edcamr25990787ybh.81.1649791278363; Tue, 12
 Apr 2022 12:21:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220406023746.2807328-1-vishal.l.verma@intel.com> <20220406023746.2807328-3-vishal.l.verma@intel.com>
In-Reply-To: <20220406023746.2807328-3-vishal.l.verma@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 12 Apr 2022 21:21:07 +0200
Message-ID: <CAJZ5v0gWGDM1-_Kyikq8hmtVg9tA=6dv4jDMCGMbFqeuqhzF-A@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] PCI/ACPI: Prefer CXL _OSC instead of PCIe _OSC for
 CXL host bridges
To:     Vishal Verma <vishal.l.verma@intel.com>
Cc:     linux-cxl@vger.kernel.org,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Robert Moore <robert.moore@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
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
> From: Dan Williams <dan.j.williams@intel.com>
>
> OB In preparation for negotiating OS control of CXL _OSC features, do the
> minimal enabling to use CXL _OSC to handle the base PCIe feature
> negotiation. Recall that CXL _OSC is a super-set of PCIe _OSC and the
> CXL 2.0 specification mandates: "If a CXL Host Bridge device exposes CXL
> _OSC, CXL aware OSPM shall evaluate CXL _OSC and not evaluate PCIe
> _OSC."
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

Please feel free to add

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

to this patch.

> ---
>  include/linux/acpi.h    |  4 +++
>  include/acpi/acpi_bus.h |  6 ++++
>  drivers/acpi/pci_root.c | 69 ++++++++++++++++++++++++++++++++---------
>  3 files changed, 64 insertions(+), 15 deletions(-)
>
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index ff4d1fdd9009..fc40da914315 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -550,6 +550,10 @@ struct acpi_osc_context {
>
>  acpi_status acpi_run_osc(acpi_handle handle, struct acpi_osc_context *context);
>
> +/* Number of _OSC capability DWORDS depends on bridge type */
> +#define OSC_PCI_CAPABILITY_DWORDS              3
> +#define OSC_CXL_CAPABILITY_DWORDS              5
> +
>  /* Indexes into _OSC Capabilities Buffer (DWORDs 2 & 3 are device-specific) */
>  #define OSC_QUERY_DWORD                                0       /* DWORD 1 */
>  #define OSC_SUPPORT_DWORD                      1       /* DWORD 2 */
> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> index ca88c4706f2b..9413d2389711 100644
> --- a/include/acpi/acpi_bus.h
> +++ b/include/acpi/acpi_bus.h
> @@ -581,10 +581,16 @@ int unregister_acpi_bus_type(struct acpi_bus_type *);
>  int acpi_bind_one(struct device *dev, struct acpi_device *adev);
>  int acpi_unbind_one(struct device *dev);
>
> +enum acpi_bridge_type {
> +       ACPI_BRIDGE_TYPE_PCIE = 1,
> +       ACPI_BRIDGE_TYPE_CXL,
> +};
> +
>  struct acpi_pci_root {
>         struct acpi_device * device;
>         struct pci_bus *bus;
>         u16 segment;
> +       int bridge_type;
>         struct resource secondary;      /* downstream bus range */
>
>         u32 osc_support_set;    /* _OSC state of support bits */
> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> index 40a74ff3fa02..b50b5de231c2 100644
> --- a/drivers/acpi/pci_root.c
> +++ b/drivers/acpi/pci_root.c
> @@ -170,20 +170,45 @@ static void decode_osc_control(struct acpi_pci_root *root, char *msg, u32 word)
>                         ARRAY_SIZE(pci_osc_control_bit));
>  }
>
> -static u8 pci_osc_uuid_str[] = "33DB4D5B-1FF7-401C-9657-7441C03DD766";
> +static inline bool is_pcie(struct acpi_pci_root *root)
> +{
> +       return root->bridge_type == ACPI_BRIDGE_TYPE_PCIE;
> +}
>
> -static acpi_status acpi_pci_run_osc(acpi_handle handle,
> +static inline bool is_cxl(struct acpi_pci_root *root)
> +{
> +       return root->bridge_type == ACPI_BRIDGE_TYPE_CXL;
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
> +               return sizeof(u32) * OSC_CXL_CAPABILITY_DWORDS;
> +       return sizeof(u32) * OSC_PCI_CAPABILITY_DWORDS;
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
>                 *retval = acpi_osc_ctx_get_pci_control(&context);
>                 kfree(context.ret.pointer);
> @@ -196,7 +221,7 @@ static acpi_status acpi_pci_query_osc(struct acpi_pci_root *root,
>                                         u32 *control)
>  {
>         acpi_status status;
> -       u32 result, capbuf[3];
> +       u32 result, capbuf[OSC_CXL_CAPABILITY_DWORDS];
>
>         support |= root->osc_support_set;
>
> @@ -204,10 +229,18 @@ static acpi_status acpi_pci_query_osc(struct acpi_pci_root *root,
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
> +               root->bridge_type = ACPI_BRIDGE_TYPE_PCIE;
> +               goto retry;
>         }
>         return status;
>  }
> @@ -338,7 +371,7 @@ static acpi_status acpi_pci_osc_control_set(acpi_handle handle, u32 *mask, u32 s
>         u32 req = OSC_PCI_EXPRESS_CAPABILITY_CONTROL;
>         struct acpi_pci_root *root;
>         acpi_status status;
> -       u32 ctrl, capbuf[3];
> +       u32 ctrl, capbuf[OSC_CXL_CAPABILITY_DWORDS];
>
>         if (!mask)
>                 return AE_BAD_PARAMETER;
> @@ -375,7 +408,7 @@ static acpi_status acpi_pci_osc_control_set(acpi_handle handle, u32 *mask, u32 s
>         capbuf[OSC_QUERY_DWORD] = 0;
>         capbuf[OSC_SUPPORT_DWORD] = root->osc_support_set;
>         capbuf[OSC_CONTROL_DWORD] = ctrl;
> -       status = acpi_pci_run_osc(handle, capbuf, mask);
> +       status = acpi_pci_run_osc(root, capbuf, mask);
>         if (ACPI_FAILURE(status))
>                 return status;
>
> @@ -454,8 +487,7 @@ static bool os_control_query_checks(struct acpi_pci_root *root, u32 support)
>         return true;
>  }
>
> -static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm,
> -                                bool is_pcie)
> +static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm)
>  {
>         u32 support, control = 0, requested = 0;
>         acpi_status status;
> @@ -506,7 +538,7 @@ static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm,
>                 *no_aspm = 1;
>
>                 /* _OSC is optional for PCI host bridges */
> -               if ((status == AE_NOT_FOUND) && !is_pcie)
> +               if (status == AE_NOT_FOUND && !is_pcie(root))
>                         return;
>
>                 if (control) {
> @@ -529,7 +561,7 @@ static int acpi_pci_root_add(struct acpi_device *device,
>         acpi_handle handle = device->handle;
>         int no_aspm = 0;
>         bool hotadd = system_state == SYSTEM_RUNNING;
> -       bool is_pcie;
> +       const char *acpi_hid;
>
>         root = kzalloc(sizeof(struct acpi_pci_root), GFP_KERNEL);
>         if (!root)
> @@ -587,8 +619,15 @@ static int acpi_pci_root_add(struct acpi_device *device,
>
>         root->mcfg_addr = acpi_pci_root_get_mcfg_addr(handle);
>
> -       is_pcie = strcmp(acpi_device_hid(device), "PNP0A08") == 0;
> -       negotiate_os_control(root, &no_aspm, is_pcie);
> +       acpi_hid = acpi_device_hid(root->device);
> +       if (strcmp(acpi_hid, "PNP0A08") == 0)
> +               root->bridge_type = ACPI_BRIDGE_TYPE_PCIE;
> +       else if (strcmp(acpi_hid, "ACPI0016") == 0)
> +               root->bridge_type = ACPI_BRIDGE_TYPE_CXL;
> +       else
> +               dev_dbg(&device->dev, "Assuming non-PCIe host bridge\n");
> +
> +       negotiate_os_control(root, &no_aspm);
>
>         /*
>          * TBD: Need PCI interface for enumeration/configuration of roots.
> --
> 2.35.1
>
