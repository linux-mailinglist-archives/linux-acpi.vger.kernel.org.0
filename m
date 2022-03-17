Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 527824DBD74
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Mar 2022 04:19:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbiCQDVB (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 16 Mar 2022 23:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231169AbiCQDVA (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Mar 2022 23:21:00 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99C8822B37
        for <linux-acpi@vger.kernel.org>; Wed, 16 Mar 2022 20:19:44 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id f8so5758914pfj.5
        for <linux-acpi@vger.kernel.org>; Wed, 16 Mar 2022 20:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V5xusi+OdOE4U+aGCQlSegh3Khhemow/6MQ3vlhYqqQ=;
        b=2n8BxxXy4uiA2VDRvBFuHlxpSCLpZXQivbRGbDBzCQp9XRtSDMpTQF5tubvDhIp1gA
         JA6XJUZ+KESUpzDjydKXor25KhqnLfeydsaUHCpxEOiiPiM0qc+7+reHzHBRrz00E0UJ
         yaga3BJz4Hc/LlZKqLVYZZYiZQf8z1X2QXygrFVlc7pDbWUetXit9yGOkJBJyUPQO6XB
         xWSm1nYri4f/CdX1642kfmqdld4POAAuwpgQmJZ8dOQDMdBRicFBlgcZduOVnszzm6jY
         Gfi9I5q0fpCB+w39PXnUTRhuJ/rw49nAfCmLYH8ioKUk0y+X7syPGxId2FnrujwTVuZ8
         euLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V5xusi+OdOE4U+aGCQlSegh3Khhemow/6MQ3vlhYqqQ=;
        b=skjiZYOhOtBVHyu9e2VU48fMlFaXBlSxKgleAyhxfztgeICvghwKQwz84X2jH8l/I1
         Mq4Kq9zxeN3vT/euBrXF9Z1IZZo6Pishv5TWgTUypt2JSo9rZ3+EbpQ6DBpQ2aFUnP1M
         ucd/2cu1kCNWXUHA9UfjWeK5d9dAKZkRoFtFgm0AAOJr0RSKpectlkey4ntvGr/rIh1/
         m2Nb23l91y27XjlWD8Vdi3anVAx1v441pst44AV5a9I3FkwKKpir0TFljI4GUv7fAI24
         /outwTb2gYkR83OGmD2VW5OzOnwBbbVKGKdhof5WUIozOrVbarMNfB8LU272z7gJe2YA
         nUSw==
X-Gm-Message-State: AOAM530hfv3r3lIguHOdiHeI7Mhu0qesnfXYURWb0rBOWD5v9zzvXlx2
        IETT3rNYZjeD5WLzfZOxoeXish3Yhy/MuOMOo7uYrsDZwiVaww==
X-Google-Smtp-Source: ABdhPJyomtAW4Rk1lcfX+0j8Pil/dDd1TPtjotfTwSyueLUiwU/ncT8Yz+nAx6b9R+/A70PK17pvZEoVOC56UFlGekc=
X-Received: by 2002:a63:2a43:0:b0:376:4b9:f7e0 with SMTP id
 q64-20020a632a43000000b0037604b9f7e0mr1985335pgq.437.1647487184110; Wed, 16
 Mar 2022 20:19:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220317002704.1835870-1-vishal.l.verma@intel.com> <20220317002704.1835870-3-vishal.l.verma@intel.com>
In-Reply-To: <20220317002704.1835870-3-vishal.l.verma@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 16 Mar 2022 20:19:33 -0700
Message-ID: <CAPcyv4iOOrefEF5QOrZyvPYJ9_5GuhpMKPeSbvVXci=qGevmBw@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] acpi/pci_root: negotiate CXL _OSC
To:     Vishal Verma <vishal.l.verma@intel.com>
Cc:     linux-cxl@vger.kernel.org, Linux ACPI <linux-acpi@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Robert Moore <robert.moore@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Mar 16, 2022 at 5:27 PM Vishal Verma <vishal.l.verma@intel.com> wrote:
>
> Add full support for negotiating _OSC as defined in the CXL 2.0 spec, as
> applicable to CXL-enabled platforms. Advertise support for the CXL
> features we support - 'CXL 2.0 port/device register access', 'Protocol
> Error Reporting', and 'CL Native Hot Plug'. Request control for 'CXL
> Memory Error Reporting'. The requests are dependent on CONFIG_* based
> pre-requisites, and prior PCI enabling, similar to how the standard PCI
> _OSC bits are determined.

Might want to add a clarification here of why this just reflects the
PCIe support into the similar CXL fields. For example:

The CXL specification does not define any additional constraints on
the hotplug flow beyond PCIe native hotplug, so a kernel that supports
native PCIe hotplug, supports CXL hotplug. For error handling protocol
and link errors just use PCIe AER. There is nascent support for
amending AER events with CXL specific status [1], but there's
otherwise no additional OS responsibility for CXL errors beyond PCIe
AER. CXL Memory Errors behave the same as typical memory errors so
CONFIG_MEMORY_FAILURE is sufficient to indicate support to platform
firmware.

[1]: https://lore.kernel.org/linux-cxl/164740402242.3912056.8303625392871313860.stgit@dwillia2-desk3.amr.corp.intel.com/

>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Robert Moore <robert.moore@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
> ---
>  include/linux/acpi.h    |  11 +++
>  include/acpi/acpi_bus.h |   6 +-
>  drivers/acpi/pci_root.c | 147 ++++++++++++++++++++++++++++++++++------
>  3 files changed, 143 insertions(+), 21 deletions(-)
>
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 6274758648e3..1717ccc265d7 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -554,6 +554,8 @@ acpi_status acpi_run_osc(acpi_handle handle, struct acpi_osc_context *context);
>  #define OSC_QUERY_DWORD                                0       /* DWORD 1 */
>  #define OSC_SUPPORT_DWORD                      1       /* DWORD 2 */
>  #define OSC_CONTROL_DWORD                      2       /* DWORD 3 */
> +#define OSC_CXL_SUPPORT_DWORD                  3       /* DWORD 4 */
> +#define OSC_CXL_CONTROL_DWORD                  4       /* DWORD 5 */
>
>  /* _OSC Capabilities DWORD 1: Query/Control and Error Returns (generic) */
>  #define OSC_QUERY_ENABLE                       0x00000001  /* input */
> @@ -607,6 +609,15 @@ extern u32 osc_sb_native_usb4_control;
>  #define OSC_PCI_EXPRESS_LTR_CONTROL            0x00000020
>  #define OSC_PCI_EXPRESS_DPC_CONTROL            0x00000080
>
> +/* CXL _OSC: Capabilities DWORD 4: Support Field */
> +#define OSC_CXL_1_1_PORT_REG_ACCESS_SUPPORT    0x00000001
> +#define OSC_CXL_2_0_PORT_DEV_REG_ACCESS_SUPPORT        0x00000002
> +#define OSC_CXL_PER_SUPPORT                    0x00000004
> +#define OSC_CXL_NATIVE_HP_SUPPORT              0x00000008
> +
> +/* CXL _OSC: Capabilities DWORD 5: Control Field */
> +#define OSC_CXL_ERROR_REPORTING_CONTROL                0x00000001
> +
>  #define ACPI_GSB_ACCESS_ATTRIB_QUICK           0x00000002
>  #define ACPI_GSB_ACCESS_ATTRIB_SEND_RCV         0x00000004
>  #define ACPI_GSB_ACCESS_ATTRIB_BYTE            0x00000006
> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> index 768ef1584055..5776d4c1509a 100644
> --- a/include/acpi/acpi_bus.h
> +++ b/include/acpi/acpi_bus.h
> @@ -588,8 +588,10 @@ struct acpi_pci_root {
>         bool cxl_osc_disable;
>         struct resource secondary;      /* downstream bus range */
>
> -       u32 osc_support_set;    /* _OSC state of support bits */
> -       u32 osc_control_set;    /* _OSC state of control bits */
> +       u32 osc_support_set;            /* _OSC state of support bits */
> +       u32 osc_control_set;            /* _OSC state of control bits */
> +       u32 cxl_osc_support_set;        /* _OSC state of CXL support bits */
> +       u32 cxl_osc_control_set;        /* _OSC state of CXL control bits */
>         phys_addr_t mcfg_addr;
>  };
>
> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> index 2d834504096b..c916318b11a0 100644
> --- a/drivers/acpi/pci_root.c
> +++ b/drivers/acpi/pci_root.c
> @@ -142,6 +142,17 @@ static struct pci_osc_bit_struct pci_osc_control_bit[] = {
>         { OSC_PCI_EXPRESS_DPC_CONTROL, "DPC" },
>  };
>
> +static struct pci_osc_bit_struct cxl_osc_support_bit[] = {
> +       { OSC_CXL_1_1_PORT_REG_ACCESS_SUPPORT, "CXL11PortRegAccess" },
> +       { OSC_CXL_2_0_PORT_DEV_REG_ACCESS_SUPPORT, "CXL20PortDevRegAccess" },
> +       { OSC_CXL_PER_SUPPORT, "CXLProtocolErrorReporting" },
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
>  static bool is_pcie(struct acpi_pci_root *root)
>  {
>         return strcmp(acpi_device_hid(root->device), "PNP0A08") == 0;
> @@ -199,8 +222,19 @@ static int cap_length(struct acpi_pci_root *root)
>         return sizeof(u32) * 3;
>  }
>
> +static u32 acpi_osc_ctx_get_pci_control(struct acpi_osc_context *context)
> +{
> +       return *((u32 *)(context->ret.pointer + 8));
> +}
> +
> +static u32 acpi_osc_ctx_get_cxl_control(struct acpi_osc_context *context)
> +{
> +       return *((u32 *)(context->ret.pointer + 16));
> +}
> +
>  static acpi_status acpi_pci_run_osc(struct acpi_pci_root *root,
> -                                   const u32 *capbuf, u32 *retval)
> +                                   const u32 *capbuf, u32 *pci_control,
> +                                   u32 *cxl_control)
>  {
>         struct acpi_osc_context context = {
>                 .uuid_str = to_uuid(root),
> @@ -212,18 +246,20 @@ static acpi_status acpi_pci_run_osc(struct acpi_pci_root *root,
>
>         status = acpi_run_osc(root->device->handle, &context);
>         if (ACPI_SUCCESS(status)) {
> -               *retval = *((u32 *)(context.ret.pointer + 8));
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
> -       u32 result, capbuf[6];
> +       u32 pci_result, cxl_result, capbuf[8];
>
>         support |= root->osc_support_set;
>
> @@ -231,11 +267,21 @@ static acpi_status acpi_pci_query_osc(struct acpi_pci_root *root,
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
> @@ -358,6 +404,8 @@ EXPORT_SYMBOL_GPL(acpi_get_pci_dev);
>   * @handle: ACPI handle of a PCI root bridge (or PCIe Root Complex).
>   * @mask: Mask of _OSC bits to request control of, place to store control mask.
>   * @support: _OSC supported capability.
> + * @cxl_mask: Mask of CXL _OSC control bits, place to store control mask.
> + * @cxl_support: CXL _OSC supported capability.
>   *
>   * Run _OSC query for @mask and if that is successful, compare the returned
>   * mask of control bits with @req.  If all of the @req bits are set in the
> @@ -368,12 +416,14 @@ EXPORT_SYMBOL_GPL(acpi_get_pci_dev);
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
> -       u32 ctrl, capbuf[6];
> +       u32 ctrl, cxl_ctrl, capbuf[8];
>
>         if (!mask)
>                 return AE_BAD_PARAMETER;
> @@ -385,20 +435,35 @@ static acpi_status acpi_pci_osc_control_set(acpi_handle handle, u32 *mask, u32 s
>         ctrl   = *mask;
>         *mask |= root->osc_control_set;
>
> +       if (is_cxl(root)) {
> +               cxl_ctrl   = *cxl_mask;
> +               *mask |= root->osc_control_set;
> +       }
> +
>         /* Need to check the available controls bits before requesting them. */
>         do {
> -               status = acpi_pci_query_osc(root, support, mask);
> +               status = acpi_pci_query_osc(root, support, mask, cxl_support,
> +                                           cxl_mask);
>                 if (ACPI_FAILURE(status))
>                         return status;
> -               if (ctrl == *mask)
> -                       break;
> -               decode_osc_control(root, "platform does not support",
> -                                  ctrl & ~(*mask));
> +               if (is_cxl(root)) {
> +                       if ((ctrl == *mask) && (cxl_ctrl == *cxl_mask))
> +                               break;
> +                       decode_cxl_osc_control(root, "platform does not support",
> +                                          cxl_ctrl & ~(*cxl_mask));
> +               } else {
> +                       if (ctrl == *mask)
> +                               break;
> +                       decode_osc_control(root, "platform does not support",
> +                                          ctrl & ~(*mask));
> +               }
>                 ctrl = *mask;
> -       } while (*mask);
> +               cxl_ctrl = *cxl_mask;
> +       } while (*mask || *cxl_mask);
>
>         /* No need to request _OSC if the control was already granted. */
> -       if ((root->osc_control_set & ctrl) == ctrl)
> +       if (((root->osc_control_set & ctrl) == ctrl) &&
> +           ((root->cxl_osc_control_set & cxl_ctrl) == cxl_ctrl))
>                 return AE_OK;
>
>         if ((ctrl & req) != req) {
> @@ -410,11 +475,17 @@ static acpi_status acpi_pci_osc_control_set(acpi_handle handle, u32 *mask, u32 s
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
> @@ -440,6 +511,18 @@ static u32 calculate_support(void)
>         return support;
>  }
>
> +static u32 calculate_cxl_support(void)
> +{
> +       u32 support;
> +
> +       support = OSC_CXL_2_0_PORT_DEV_REG_ACCESS_SUPPORT;
> +       support |= OSC_CXL_PER_SUPPORT;

I would expect this one to be gated by pci_aer_available() since these
errors are reported by PCIe AER.

Perhaps also s/PER/PORT_ERROR/? I keep reading PER like 'per' as in 'per-cpu'.

> +       if (IS_ENABLED(CONFIG_HOTPLUG_PCI_PCIE))
> +               support |= OSC_CXL_NATIVE_HP_SUPPORT;
> +
> +       return support;
> +}
> +
>  static u32 calculate_control(void)
>  {
>         u32 control;
> @@ -471,6 +554,16 @@ static u32 calculate_control(void)
>         return control;
>  }
>
> +static u32 calculate_cxl_control(void)
> +{
> +       u32 control;
> +
> +       if (pci_aer_available())
> +               control |= OSC_CXL_ERROR_REPORTING_CONTROL;

In this case the error handling is for memory errors, so this one should be:

if (IS_ENABLED(CONFIG_MEMORY_FAILURE))
        control |= OSC_CXL_ERROR_REPORTING_CONTROL;

...other than that looks good to me.

> +
> +       return control;
> +}
> +
>  static bool os_control_query_checks(struct acpi_pci_root *root, u32 support)
>  {
>         struct acpi_device *device = root->device;
> @@ -492,6 +585,7 @@ static bool os_control_query_checks(struct acpi_pci_root *root, u32 support)
>  static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm)
>  {
>         u32 support, control = 0, requested = 0;
> +       u32 cxl_support, cxl_control = 0, cxl_requested = 0;
>         acpi_status status;
>         struct acpi_device *device = root->device;
>         acpi_handle handle = device->handle;
> @@ -515,10 +609,20 @@ static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm)
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
> @@ -547,6 +651,11 @@ static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm)
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
