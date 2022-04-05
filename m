Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 570A94F46C6
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Apr 2022 01:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230375AbiDEUoO (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 5 Apr 2022 16:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443854AbiDEPkX (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 5 Apr 2022 11:40:23 -0400
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3442210E55E;
        Tue,  5 Apr 2022 07:00:53 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id o62so8457318ybo.2;
        Tue, 05 Apr 2022 07:00:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yiir21C1PlzdK+gf2MIb+hCEldfraLm9hTeR5KlUN+4=;
        b=NzANIfLIVz7ltwMgi8k3ZB0ugaRxbITILpThWNCl23s4b27zHSKFm2TaT7yyeO/WiF
         Fu/LRTudqKoHf6c9DZr60QiLk7n6/W/JdLCZWVuvVoUXFu4RhcvLCo9RH4gMt1devjNg
         /cEstKdmjkBY27sITUXdE/xPxobS5DEzhlEZt/sn/lSwArPhnCByEfFCAxfRuP2rSxOl
         T/ha5KGp7yzrqRHjVPWArtskS1OBQlE1b9oIx3Dq4aL/tNcZPnAny148ftuV8S0IVERV
         WQ58a0kMP96FBecJHOIv+c00DeIkVOauS+9zxMHfBWMg/A9Sv6UMEKy7EaAkf34Tf+5n
         M+Hw==
X-Gm-Message-State: AOAM533CzvXfSP+QdSABEpjbGVmPeMYxmvihDmKz2CT6R90w02cjweOa
        hM8fhquQfbzSuw0Vt4otU6fEiycOXlwGmYICGa1UGVEfvkk=
X-Google-Smtp-Source: ABdhPJy8dUEmBTbLgJoNptgzgnB9nwMf+ms4NcDmsfJbCx94xZIiFReLi2bmjNBTfGTCDmWvXuTiVHCIqbmTrIMLvX8=
X-Received: by 2002:a25:9d8a:0:b0:633:9668:c48a with SMTP id
 v10-20020a259d8a000000b006339668c48amr2734365ybp.153.1649167252094; Tue, 05
 Apr 2022 07:00:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220331202022.1823174-1-vishal.l.verma@intel.com> <20220331202022.1823174-4-vishal.l.verma@intel.com>
In-Reply-To: <20220331202022.1823174-4-vishal.l.verma@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 5 Apr 2022 16:00:40 +0200
Message-ID: <CAJZ5v0haSXXDXaJdWEqpwS=b8r2HQzffKCoVpeDbxY9No5QXfw@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] PCI/ACPI: negotiate CXL _OSC
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
> Add full support for negotiating _OSC as defined in the CXL 2.0 spec, as
> applicable to CXL-enabled platforms. Advertise support for the CXL
> features we support - 'CXL 2.0 port/device register access', 'Protocol
> Error Reporting', and 'CXL Native Hot Plug'. Request control for 'CXL
> Memory Error Reporting'. The requests are dependent on CONFIG_* based
> prerequisites, and prior PCI enabling, similar to how the standard PCI
> _OSC bits are determined.
>
> The CXL specification does not define any additional constraints on
> the hotplug flow beyond PCIe native hotplug, so a kernel that supports
> native PCIe hotplug, supports CXL hotplug. For error handling protocol
> and link errors just use PCIe AER. There is nascent support for
> amending AER events with CXL specific status [1], but there's
> otherwise no additional OS responsibility for CXL errors beyond PCIe
> AER. CXL Memory Errors behave the same as typical memory errors so
> CONFIG_MEMORY_FAILURE is sufficient to indicate support to platform
> firmware.
>
> [1]: https://lore.kernel.org/linux-cxl/164740402242.3912056.8303625392871313860.stgit@dwillia2-desk3.amr.corp.intel.com/
>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Robert Moore <robert.moore@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
> ---
>  include/linux/acpi.h    |  28 +++++++-
>  include/acpi/acpi_bus.h |   6 +-
>  drivers/acpi/pci_root.c | 145 ++++++++++++++++++++++++++++++++++------
>  3 files changed, 157 insertions(+), 22 deletions(-)
>
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index fc40da914315..cf360b9642d9 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -554,10 +554,15 @@ acpi_status acpi_run_osc(acpi_handle handle, struct acpi_osc_context *context);
>  #define OSC_PCI_CAPABILITY_DWORDS              3
>  #define OSC_CXL_CAPABILITY_DWORDS              5
>
> -/* Indexes into _OSC Capabilities Buffer (DWORDs 2 & 3 are device-specific) */
> +/*
> + * Indexes into _OSC Capabilities Buffer
> + * DWORDs 2 & 3 are device-specific, and 4 & 5 are specific to CXL platforms

Say "DWORDs 2 through 5 are device-specific" and you don't need to
mention CXL here.

> + */
>  #define OSC_QUERY_DWORD                                0       /* DWORD 1 */
>  #define OSC_SUPPORT_DWORD                      1       /* DWORD 2 */
>  #define OSC_CONTROL_DWORD                      2       /* DWORD 3 */
> +#define OSC_CXL_SUPPORT_DWORD                  3       /* DWORD 4 */
> +#define OSC_CXL_CONTROL_DWORD                  4       /* DWORD 5 */

I would rename the last two symbols as OSC_EXT_SUPPORT_DWORD and
OSC_EXT_CONTROL_DWORD (see below for an explanation).

>
>  /* _OSC Capabilities DWORD 1: Query/Control and Error Returns (generic) */
>  #define OSC_QUERY_ENABLE                       0x00000001  /* input */
> @@ -611,6 +616,15 @@ extern u32 osc_sb_native_usb4_control;
>  #define OSC_PCI_EXPRESS_LTR_CONTROL            0x00000020
>  #define OSC_PCI_EXPRESS_DPC_CONTROL            0x00000080
>
> +/* CXL _OSC: Capabilities DWORD 4: Support Field */
> +#define OSC_CXL_1_1_PORT_REG_ACCESS_SUPPORT    0x00000001
> +#define OSC_CXL_2_0_PORT_DEV_REG_ACCESS_SUPPORT        0x00000002
> +#define OSC_CXL_PROTOCOL_ERR_REPORTING_SUPPORT 0x00000004
> +#define OSC_CXL_NATIVE_HP_SUPPORT              0x00000008
> +
> +/* CXL _OSC: Capabilities DWORD 5: Control Field */
> +#define OSC_CXL_ERROR_REPORTING_CONTROL                0x00000001
> +
>  static inline u32 acpi_osc_ctx_get_pci_control(struct acpi_osc_context *context)
>  {
>         u32 *ret = context->ret.pointer;
> @@ -618,6 +632,13 @@ static inline u32 acpi_osc_ctx_get_pci_control(struct acpi_osc_context *context)
>         return ret[OSC_CONTROL_DWORD];
>  }
>
> +static inline u32 acpi_osc_ctx_get_cxl_control(struct acpi_osc_context *context)
> +{
> +       u32 *ret = context->ret.pointer;
> +
> +       return ret[OSC_CXL_CONTROL_DWORD];
> +}
> +
>  #define ACPI_GSB_ACCESS_ATTRIB_QUICK           0x00000002
>  #define ACPI_GSB_ACCESS_ATTRIB_SEND_RCV         0x00000004
>  #define ACPI_GSB_ACCESS_ATTRIB_BYTE            0x00000006
> @@ -1020,6 +1041,11 @@ static inline u32 acpi_osc_ctx_get_pci_control(struct acpi_osc_context *context)
>         return 0;
>  }
>
> +static inline u32 acpi_osc_ctx_get_cxl_control(struct acpi_osc_context *context)
> +{
> +       return 0;
> +}
> +
>  #endif /* !CONFIG_ACPI */
>
>  #ifdef CONFIG_ACPI_HOTPLUG_IOAPIC
> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> index 9413d2389711..0fdd913c1fd7 100644
> --- a/include/acpi/acpi_bus.h
> +++ b/include/acpi/acpi_bus.h
> @@ -593,8 +593,10 @@ struct acpi_pci_root {
>         int bridge_type;
>         struct resource secondary;      /* downstream bus range */
>
> -       u32 osc_support_set;    /* _OSC state of support bits */
> -       u32 osc_control_set;    /* _OSC state of control bits */
> +       u32 osc_support_set;            /* _OSC state of support bits */
> +       u32 osc_control_set;            /* _OSC state of control bits */
> +       u32 cxl_osc_support_set;        /* _OSC state of CXL support bits */
> +       u32 cxl_osc_control_set;        /* _OSC state of CXL control bits */

Well, could these two be renamed to osc_ext_support_set and
osc_ext_controle_set ("ext" for "extended"), respectively?

At the acpi_bus.h level, CXL is irrelevant and expecting all of the
prospective readers of it to find out what CXL means seems a bit
excessive.

Otherwise, the changes in this patch look reasonable to me.

>         phys_addr_t mcfg_addr;
>  };
>
> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> index 5d33bc61fe44..a2e74db28e30 100644
> --- a/drivers/acpi/pci_root.c
> +++ b/drivers/acpi/pci_root.c
> @@ -142,6 +142,17 @@ static struct pci_osc_bit_struct pci_osc_control_bit[] = {
>         { OSC_PCI_EXPRESS_DPC_CONTROL, "DPC" },
>  };
>
> +static struct pci_osc_bit_struct cxl_osc_support_bit[] = {
> +       { OSC_CXL_1_1_PORT_REG_ACCESS_SUPPORT, "CXL11PortRegAccess" },
> +       { OSC_CXL_2_0_PORT_DEV_REG_ACCESS_SUPPORT, "CXL20PortDevRegAccess" },
> +       { OSC_CXL_PROTOCOL_ERR_REPORTING_SUPPORT, "CXLProtocolErrorReporting" },
> +       { OSC_CXL_NATIVE_HP_SUPPORT, "CXLNativeHotPlug" },
> +};
> +
> +static struct pci_osc_bit_struct cxl_osc_control_bit[] = {
> +       { OSC_CXL_ERROR_REPORTING_CONTROL, "CXLMemErrorReporting" },
> +};
> +
>  static void decode_osc_bits(struct acpi_pci_root *root, char *msg, u32 word,
>                             struct pci_osc_bit_struct *table, int size)
>  {
> @@ -170,6 +181,18 @@ static void decode_osc_control(struct acpi_pci_root *root, char *msg, u32 word)
>                         ARRAY_SIZE(pci_osc_control_bit));
>  }
>
> +static void decode_cxl_osc_support(struct acpi_pci_root *root, char *msg, u32 word)
> +{
> +       decode_osc_bits(root, msg, word, cxl_osc_support_bit,
> +                       ARRAY_SIZE(cxl_osc_support_bit));
> +}
> +
> +static void decode_cxl_osc_control(struct acpi_pci_root *root, char *msg, u32 word)
> +{
> +       decode_osc_bits(root, msg, word, cxl_osc_control_bit,
> +                       ARRAY_SIZE(cxl_osc_control_bit));
> +}
> +
>  static inline bool is_pcie(struct acpi_pci_root *root)
>  {
>         return root->bridge_type == ACPI_BRIDGE_TYPE_PCIE;
> @@ -198,7 +221,8 @@ static int cap_length(struct acpi_pci_root *root)
>  }
>
>  static acpi_status acpi_pci_run_osc(struct acpi_pci_root *root,
> -                                   const u32 *capbuf, u32 *retval)
> +                                   const u32 *capbuf, u32 *pci_control,
> +                                   u32 *cxl_control)
>  {
>         struct acpi_osc_context context = {
>                 .uuid_str = to_uuid(root),
> @@ -210,18 +234,20 @@ static acpi_status acpi_pci_run_osc(struct acpi_pci_root *root,
>
>         status = acpi_run_osc(root->device->handle, &context);
>         if (ACPI_SUCCESS(status)) {
> -               *retval = acpi_osc_ctx_get_pci_control(&context);
> +               *pci_control = acpi_osc_ctx_get_pci_control(&context);
> +               if (is_cxl(root))
> +                       *cxl_control = acpi_osc_ctx_get_cxl_control(&context);
>                 kfree(context.ret.pointer);
>         }
>         return status;
>  }
>
> -static acpi_status acpi_pci_query_osc(struct acpi_pci_root *root,
> -                                       u32 support,
> -                                       u32 *control)
> +static acpi_status acpi_pci_query_osc(struct acpi_pci_root *root, u32 support,
> +                                     u32 *control, u32 cxl_support,
> +                                     u32 *cxl_control)
>  {
>         acpi_status status;
> -       u32 result, capbuf[OSC_CXL_CAPABILITY_DWORDS];
> +       u32 pci_result, cxl_result, capbuf[OSC_CXL_CAPABILITY_DWORDS];
>
>         support |= root->osc_support_set;
>
> @@ -229,11 +255,21 @@ static acpi_status acpi_pci_query_osc(struct acpi_pci_root *root,
>         capbuf[OSC_SUPPORT_DWORD] = support;
>         capbuf[OSC_CONTROL_DWORD] = *control | root->osc_control_set;
>
> +       if (is_cxl(root)) {
> +               cxl_support |= root->cxl_osc_support_set;
> +               capbuf[OSC_CXL_SUPPORT_DWORD] = cxl_support;
> +               capbuf[OSC_CXL_CONTROL_DWORD] = *cxl_control | root->cxl_osc_control_set;
> +       }
> +
>  retry:
> -       status = acpi_pci_run_osc(root, capbuf, &result);
> +       status = acpi_pci_run_osc(root, capbuf, &pci_result, &cxl_result);
>         if (ACPI_SUCCESS(status)) {
>                 root->osc_support_set = support;
> -               *control = result;
> +               *control = pci_result;
> +               if (is_cxl(root)) {
> +                       root->cxl_osc_support_set = cxl_support;
> +                       *cxl_control = cxl_result;
> +               }
>         } else if (is_cxl(root)) {
>                 /*
>                  * CXL _OSC is optional on CXL 1.1 hosts. Fall back to PCIe _OSC
> @@ -356,6 +392,8 @@ EXPORT_SYMBOL_GPL(acpi_get_pci_dev);
>   * @handle: ACPI handle of a PCI root bridge (or PCIe Root Complex).
>   * @mask: Mask of _OSC bits to request control of, place to store control mask.
>   * @support: _OSC supported capability.
> + * @cxl_mask: Mask of CXL _OSC control bits, place to store control mask.
> + * @cxl_support: CXL _OSC supported capability.
>   *
>   * Run _OSC query for @mask and if that is successful, compare the returned
>   * mask of control bits with @req.  If all of the @req bits are set in the
> @@ -366,12 +404,14 @@ EXPORT_SYMBOL_GPL(acpi_get_pci_dev);
>   * _OSC bits the BIOS has granted control of, but its contents are meaningless
>   * on failure.
>   **/
> -static acpi_status acpi_pci_osc_control_set(acpi_handle handle, u32 *mask, u32 support)
> +static acpi_status acpi_pci_osc_control_set(acpi_handle handle, u32 *mask,
> +                                           u32 support, u32 *cxl_mask,
> +                                           u32 cxl_support)
>  {
>         u32 req = OSC_PCI_EXPRESS_CAPABILITY_CONTROL;
>         struct acpi_pci_root *root;
>         acpi_status status;
> -       u32 ctrl, capbuf[OSC_CXL_CAPABILITY_DWORDS];
> +       u32 ctrl, cxl_ctrl = 0, capbuf[OSC_CXL_CAPABILITY_DWORDS];
>
>         if (!mask)
>                 return AE_BAD_PARAMETER;
> @@ -383,20 +423,42 @@ static acpi_status acpi_pci_osc_control_set(acpi_handle handle, u32 *mask, u32 s
>         ctrl   = *mask;
>         *mask |= root->osc_control_set;
>
> +       if (is_cxl(root)) {
> +               cxl_ctrl = *cxl_mask;
> +               *cxl_mask |= root->cxl_osc_control_set;
> +       }
> +
>         /* Need to check the available controls bits before requesting them. */
>         do {
> -               status = acpi_pci_query_osc(root, support, mask);
> +               u32 pci_missing = 0, cxl_missing = 0;
> +
> +               status = acpi_pci_query_osc(root, support, mask, cxl_support,
> +                                           cxl_mask);
>                 if (ACPI_FAILURE(status))
>                         return status;
> -               if (ctrl == *mask)
> -                       break;
> -               decode_osc_control(root, "platform does not support",
> -                                  ctrl & ~(*mask));
> +               if (is_cxl(root)) {
> +                       if (ctrl == *mask && cxl_ctrl == *cxl_mask)
> +                               break;
> +                       pci_missing = ctrl & ~(*mask);
> +                       cxl_missing = cxl_ctrl & ~(*cxl_mask);
> +               } else {
> +                       if (ctrl == *mask)
> +                               break;
> +                       pci_missing = ctrl & ~(*mask);
> +               }
> +               if (pci_missing)
> +                       decode_osc_control(root, "platform does not support",
> +                                          pci_missing);
> +               if (cxl_missing)
> +                       decode_cxl_osc_control(root, "CXL platform does not support",
> +                                          cxl_missing);
>                 ctrl = *mask;
> -       } while (*mask);
> +               cxl_ctrl = *cxl_mask;
> +       } while (*mask || *cxl_mask);
>
>         /* No need to request _OSC if the control was already granted. */
> -       if ((root->osc_control_set & ctrl) == ctrl)
> +       if ((root->osc_control_set & ctrl) == ctrl &&
> +           (root->cxl_osc_control_set & cxl_ctrl) == cxl_ctrl)
>                 return AE_OK;
>
>         if ((ctrl & req) != req) {
> @@ -408,11 +470,17 @@ static acpi_status acpi_pci_osc_control_set(acpi_handle handle, u32 *mask, u32 s
>         capbuf[OSC_QUERY_DWORD] = 0;
>         capbuf[OSC_SUPPORT_DWORD] = root->osc_support_set;
>         capbuf[OSC_CONTROL_DWORD] = ctrl;
> -       status = acpi_pci_run_osc(root, capbuf, mask);
> +       if (is_cxl(root)) {
> +               capbuf[OSC_CXL_SUPPORT_DWORD] = root->cxl_osc_support_set;
> +               capbuf[OSC_CXL_CONTROL_DWORD] = cxl_ctrl;
> +       }
> +
> +       status = acpi_pci_run_osc(root, capbuf, mask, cxl_mask);
>         if (ACPI_FAILURE(status))
>                 return status;
>
>         root->osc_control_set = *mask;
> +       root->cxl_osc_control_set = *cxl_mask;
>         return AE_OK;
>  }
>
> @@ -438,6 +506,19 @@ static u32 calculate_support(void)
>         return support;
>  }
>
> +static u32 calculate_cxl_support(void)
> +{
> +       u32 support;
> +
> +       support = OSC_CXL_2_0_PORT_DEV_REG_ACCESS_SUPPORT;
> +       if (pci_aer_available())
> +               support |= OSC_CXL_PROTOCOL_ERR_REPORTING_SUPPORT;
> +       if (IS_ENABLED(CONFIG_HOTPLUG_PCI_PCIE))
> +               support |= OSC_CXL_NATIVE_HP_SUPPORT;
> +
> +       return support;
> +}
> +
>  static u32 calculate_control(void)
>  {
>         u32 control;
> @@ -469,6 +550,16 @@ static u32 calculate_control(void)
>         return control;
>  }
>
> +static u32 calculate_cxl_control(void)
> +{
> +       u32 control = 0;
> +
> +       if (IS_ENABLED(CONFIG_MEMORY_FAILURE))
> +               control |= OSC_CXL_ERROR_REPORTING_CONTROL;
> +
> +       return control;
> +}
> +
>  static bool os_control_query_checks(struct acpi_pci_root *root, u32 support)
>  {
>         struct acpi_device *device = root->device;
> @@ -490,6 +581,7 @@ static bool os_control_query_checks(struct acpi_pci_root *root, u32 support)
>  static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm)
>  {
>         u32 support, control = 0, requested = 0;
> +       u32 cxl_support = 0, cxl_control = 0, cxl_requested = 0;
>         acpi_status status;
>         struct acpi_device *device = root->device;
>         acpi_handle handle = device->handle;
> @@ -513,10 +605,20 @@ static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm)
>         if (os_control_query_checks(root, support))
>                 requested = control = calculate_control();
>
> -       status = acpi_pci_osc_control_set(handle, &control, support);
> +       if (is_cxl(root)) {
> +               cxl_support = calculate_cxl_support();
> +               decode_cxl_osc_support(root, "OS supports", cxl_support);
> +               cxl_requested = cxl_control = calculate_cxl_control();
> +       }
> +
> +       status = acpi_pci_osc_control_set(handle, &control, support,
> +                                         &cxl_control, cxl_support);
>         if (ACPI_SUCCESS(status)) {
>                 if (control)
>                         decode_osc_control(root, "OS now controls", control);
> +               if (cxl_control)
> +                       decode_cxl_osc_control(root, "OS now controls",
> +                                          cxl_control);
>
>                 if (acpi_gbl_FADT.boot_flags & ACPI_FADT_NO_ASPM) {
>                         /*
> @@ -545,6 +647,11 @@ static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm)
>                         decode_osc_control(root, "OS requested", requested);
>                         decode_osc_control(root, "platform willing to grant", control);
>                 }
> +               if (cxl_control) {
> +                       decode_cxl_osc_control(root, "OS requested", cxl_requested);
> +                       decode_cxl_osc_control(root, "platform willing to grant",
> +                                          cxl_control);
> +               }
>
>                 dev_info(&device->dev, "_OSC: platform retains control of PCIe features (%s)\n",
>                          acpi_format_exception(status));
> --
> 2.35.1
>
