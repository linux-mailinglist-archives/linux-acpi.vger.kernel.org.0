Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36DD04F46D8
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Apr 2022 01:19:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241853AbiDEUqM (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 5 Apr 2022 16:46:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1392188AbiDEPft (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 5 Apr 2022 11:35:49 -0400
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4EF6113;
        Tue,  5 Apr 2022 06:47:37 -0700 (PDT)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-2eb46d33db9so83315327b3.12;
        Tue, 05 Apr 2022 06:47:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Kpj5H/ONbjNqMagoOWuzPrgVmm66wqLMrF02mwgAmpo=;
        b=OrGuzQkdX87ycKXQGFFn9wFwATzVOUB8UBmxSCdZ/i1HMvyzf3eqwe8Q6ZfzrGDCkD
         4ZgOAdBHfr/BVY8piIsHuZ1TD/EhKP85nQJH2l1zUAZA6X331jBHBfQyrdQKDaQZM2x0
         OVFU7N7JGxAy6hiIwtmL5d45XVRH+qJfy50pLoGgxZc582EgZV0U5fkCpG3LVUUA96pR
         tq2FwB+YUcGmLxC1N7DmaTSIRCiyFeqid0vIUsgB/ZxG1sUJsCD5xJRjhDmUiUhzB2j4
         S/oIQCDbyYLRE0KYYN2o4TqydYh/FKBsDPginrXHibb9K8pkGrS96K7QarRPibQXwbRy
         oucw==
X-Gm-Message-State: AOAM533HV70dvH4QASm/2K4hMhdxS3kWif3K6/++rezSt+lIgkKXjHWy
        CEMDkS5hmpJ2twyyjtdekvZtDA2FHh4aEcXGhWs=
X-Google-Smtp-Source: ABdhPJzfEdjVgt9Yq4ho6UFYSWq/ei57AZIDDya7yTDU7iEHuC2ceka/83Uel44Ball5UZYkhXii4ZWAly82slEhlV0=
X-Received: by 2002:a81:1549:0:b0:2eb:3dc7:bd16 with SMTP id
 70-20020a811549000000b002eb3dc7bd16mr2779780ywv.7.1649166457145; Tue, 05 Apr
 2022 06:47:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220331202022.1823174-1-vishal.l.verma@intel.com> <20220331202022.1823174-3-vishal.l.verma@intel.com>
In-Reply-To: <20220331202022.1823174-3-vishal.l.verma@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 5 Apr 2022 15:47:26 +0200
Message-ID: <CAJZ5v0hfTXkHQE2j8B00Qvn1vuW0a-5AoUG-dSJvCH5PW70AZw@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] PCI/ACPI: Use CXL _OSC instead of PCIe _OSC
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

First off, I would change the subject to something like "Prefer CXL
_OSC to PCI _OSC for CXL host bridges".  As is, it kind of suggests
that the CXL _OSC is preferred in all cases.

On Thu, Mar 31, 2022 at 10:20 PM Vishal Verma <vishal.l.verma@intel.com> wrote:
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
> ---
>  include/linux/acpi.h    |  4 +++
>  include/acpi/acpi_bus.h |  6 ++++
>  drivers/acpi/pci_root.c | 70 ++++++++++++++++++++++++++++++++---------
>  3 files changed, 65 insertions(+), 15 deletions(-)
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
> index 40a74ff3fa02..5d33bc61fe44 100644
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
> @@ -587,8 +619,16 @@ static int acpi_pci_root_add(struct acpi_device *device,
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
> +               dev_warn(&device->dev, "unknown bridge type with hid: %s\n",
> +                        acpi_hid);

Second, because "device" is an ACPI device object and it has a _HID,
its name should include the ID in this case, so including it into the
message once more is redundant.

Also, if this is neither PCIe nor CXL, it should be a "legacy" PCI
host bridge and that is not an error, so maybe use dev_dbg("Assuming
non-PCIe host bridge\n")?

> +
> +       negotiate_os_control(root, &no_aspm);
>
>         /*
>          * TBD: Need PCI interface for enumeration/configuration of roots.
> --
