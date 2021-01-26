Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2518D304C94
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Jan 2021 23:49:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728353AbhAZWsK (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 26 Jan 2021 17:48:10 -0500
Received: from mail-ot1-f48.google.com ([209.85.210.48]:33500 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728630AbhAZRg2 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 26 Jan 2021 12:36:28 -0500
Received: by mail-ot1-f48.google.com with SMTP id 63so17002905oty.0;
        Tue, 26 Jan 2021 09:35:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y4MZlxTgr1y+nqOu/OjLC7KHQ5wHLIHJGpmEYBmPiRs=;
        b=hEHoUK7oaagYZUjsgCmXB4c5Dm0F0gRc83Ku1uIEEwt56634lFkdxseoF9RpEnJbbI
         VKR4RsqkP0qvJwkeAczt0wed3lOHBhuyJGh448dSN980He5tuq8VsPqUld0lyfEkkzWY
         OZp/CflNmTzw98Ql9rFXmKidxjvH9j9LkKJNozTKoHrJBRWIbCz4YowKNoWXU4++1IXd
         S7L2nNziye++lYMGXo/pqfTLZ4abUoqazsUWP2Iy1iyo0fWzIVG4CDiqisLQh539+q6Q
         2icSU18dfOJuH3HveJrSjCfNsXZMif1mywmCw/R/klA78D7AOY1YXZw9+CEEA8/Ottak
         ySmw==
X-Gm-Message-State: AOAM530xqvV584xImJsVEYiZ6eVSOBRSbvyTqlMzJc3C3Sqa73pNebvF
        HISrdGTRNKstZ9Inb1VldNpazdkUHLDZ3O/KOlk=
X-Google-Smtp-Source: ABdhPJzlX1zKxSTJBe5bjxy3H4uME9cKlbC6MeoWF44t35lmpNNlUaqdkDC2PhdDXEFmSEyaB/9NJCAv890F9HVjIEk=
X-Received: by 2002:a9d:7a4a:: with SMTP id z10mr4894094otm.206.1611682531457;
 Tue, 26 Jan 2021 09:35:31 -0800 (PST)
MIME-Version: 1.0
References: <20210126155723.9388-1-mika.westerberg@linux.intel.com> <20210126155723.9388-6-mika.westerberg@linux.intel.com>
In-Reply-To: <20210126155723.9388-6-mika.westerberg@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 26 Jan 2021 18:35:20 +0100
Message-ID: <CAJZ5v0jT4crr7fyQE4oVijvTU0hhKOEUvDLziPZZ7J0Hvjrj2w@mail.gmail.com>
Subject: Re: [PATCH 5/6] ACPI: Add support for native USB4 control _OSC
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     "open list:ULTRA-WIDEBAND (UWB) SUBSYSTEM:" 
        <linux-usb@vger.kernel.org>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        Mario Limonciello <mario.limonciello@dell.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Christian Kellner <christian@kellner.me>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Jan 26, 2021 at 5:01 PM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> ACPI 6.4 introduced a new _OSC capability that is used negotiate native
> connection manager support. Connection manager is the entity that is
> responsible for tunneling over the USB4 fabric. If the platform rejects
> the native access then firmware based connection manager is used.
>
> The new _OSC also includes a set of bits that can be used to disable
> certain tunnel types such as PCIe for security reasons for instance.
>
> This implements the new USB4 _OSC so that we try to negotiate native
> USB4 support if the Thunderbolt/USB4 (CONFIG_USB4) driver is enabled.
> Drivers can determine what was negotiated by checking two new variables
> exposed in this patch.
>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
>  drivers/acpi/bus.c   | 76 ++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/acpi.h | 10 ++++++
>  2 files changed, 86 insertions(+)
>
> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> index ca7c7b2bf56e..f7ad2d283e51 100644
> --- a/drivers/acpi/bus.c
> +++ b/drivers/acpi/bus.c
> @@ -281,6 +281,12 @@ bool osc_sb_apei_support_acked;
>  bool osc_pc_lpi_support_confirmed;
>  EXPORT_SYMBOL_GPL(osc_pc_lpi_support_confirmed);
>
> +/*
> + * ACPI 6.4 Operating System Capabilities for USB.
> + */
> +bool osc_sb_native_usb4_support_confirmed;
> +EXPORT_SYMBOL_GPL(osc_sb_native_usb4_support_confirmed);
> +
>  static u8 sb_uuid_str[] = "0811B06E-4A27-44F9-8D60-3CBBC22E7B48";
>  static void acpi_bus_osc_negotiate_platform_control(void)
>  {
> @@ -317,6 +323,9 @@ static void acpi_bus_osc_negotiate_platform_control(void)
>         if (IS_ENABLED(CONFIG_SCHED_MC_PRIO))
>                 capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_CPC_DIVERSE_HIGH_SUPPORT;
>
> +       if (IS_ENABLED(CONFIG_USB4))
> +               capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_NATIVE_USB4_SUPPORT;
> +
>         if (!ghes_disable)
>                 capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_APEI_SUPPORT;
>         if (ACPI_FAILURE(acpi_get_handle(NULL, "\\_SB", &handle)))
> @@ -348,8 +357,74 @@ static void acpi_bus_osc_negotiate_platform_control(void)
>                         capbuf_ret[OSC_SUPPORT_DWORD] & OSC_SB_APEI_SUPPORT;
>                 osc_pc_lpi_support_confirmed =
>                         capbuf_ret[OSC_SUPPORT_DWORD] & OSC_SB_PCLPI_SUPPORT;
> +               osc_sb_native_usb4_support_confirmed =
> +                       capbuf_ret[OSC_SUPPORT_DWORD] & OSC_SB_NATIVE_USB4_SUPPORT;
> +       }
> +
> +       kfree(context.ret.pointer);
> +}
> +
> +/*
> + * Native control of USB4 capabilities. If any of the tunneling bits is
> + * set it means OS is in control and we use software based connection
> + * manager.
> + */
> +u32 osc_sb_native_usb4_control;
> +EXPORT_SYMBOL_GPL(osc_sb_native_usb4_control);
> +
> +static void acpi_bus_decode_usb_osc(const char *msg, u32 bits)
> +{
> +       printk(KERN_INFO PREFIX "%s USB3%c DisplayPort%c PCIe%c XDomain%c\n", msg,
> +              (bits & OSC_USB_USB3_TUNNELING) ? '+' : '-',
> +              (bits & OSC_USB_DP_TUNNELING) ? '+' : '-',
> +              (bits & OSC_USB_PCIE_TUNNELING) ? '+' : '-',
> +              (bits & OSC_USB_XDOMAIN) ? '+' : '-');
> +}
> +
> +static u8 sb_usb_uuid_str[] = "23A0D13A-26AB-486C-9C5F-0FFA525A575A";
> +static void acpi_bus_osc_negotiate_usb_control(void)
> +{
> +       u32 capbuf[3];
> +       struct acpi_osc_context context = {
> +               .uuid_str = sb_usb_uuid_str,
> +               .rev = 1,
> +               .cap.length = sizeof(capbuf),
> +               .cap.pointer = capbuf,
> +       };
> +       acpi_handle handle;
> +       acpi_status status;
> +       u32 control;
> +
> +       if (!osc_sb_native_usb4_support_confirmed)
> +               return;
> +
> +       if (ACPI_FAILURE(acpi_get_handle(NULL, "\\_SB", &handle)))
> +               return;
> +
> +       control = OSC_USB_USB3_TUNNELING | OSC_USB_DP_TUNNELING |
> +                 OSC_USB_PCIE_TUNNELING | OSC_USB_XDOMAIN;
> +
> +       capbuf[OSC_QUERY_DWORD] = 0;
> +       capbuf[OSC_SUPPORT_DWORD] = 0;
> +       capbuf[OSC_CONTROL_DWORD] = control;
> +
> +       status = acpi_run_osc(handle, &context);

This is the same _OSC that is evaluated in
acpi_bus_osc_negotiate_platform_control(), right?

So shouldn't the capbuf[OSC_SUPPORT_DWORD] be whatever is negotiated
through acpi_bus_osc_negotiate_platform_control()?  At least that
would be consistent with acpi_pci_osc_control_set().

And if this was done I'm not sure if the change in the previous patch
would be needed then?

> +       if (ACPI_FAILURE(status))
> +               return;
> +
> +       if (context.ret.length != sizeof(capbuf)) {
> +               printk(KERN_INFO PREFIX "USB4 _OSC: returned invalid length buffer\n");
> +               goto out_free;
>         }
>
> +       osc_sb_native_usb4_control =
> +               control & ((u32 *)context.ret.pointer)[OSC_CONTROL_DWORD];
> +
> +       acpi_bus_decode_usb_osc("USB4 _OSC: OS supports", control);
> +       acpi_bus_decode_usb_osc("USB4 _OSC: OS controls",
> +                               osc_sb_native_usb4_control);
> +
> +out_free:
>         kfree(context.ret.pointer);
>  }
>
> @@ -1188,6 +1263,7 @@ static int __init acpi_bus_init(void)
>          * so it must be run after ACPI_FULL_INITIALIZATION
>          */
>         acpi_bus_osc_negotiate_platform_control();
> +       acpi_bus_osc_negotiate_usb_control();
>
>         /*
>          * _PDC control method may load dynamic SSDT tables,
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 2630c2e953f7..ac68c2d4e393 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -546,9 +546,19 @@ acpi_status acpi_run_osc(acpi_handle handle, struct acpi_osc_context *context);
>  #define OSC_SB_OSLPI_SUPPORT                   0x00000100
>  #define OSC_SB_CPC_DIVERSE_HIGH_SUPPORT                0x00001000
>  #define OSC_SB_GENERIC_INITIATOR_SUPPORT       0x00002000
> +#define OSC_SB_NATIVE_USB4_SUPPORT             0x00040000
>
>  extern bool osc_sb_apei_support_acked;
>  extern bool osc_pc_lpi_support_confirmed;
> +extern bool osc_sb_native_usb4_support_confirmed;
> +
> +/* USB4 Capabilities */
> +#define OSC_USB_USB3_TUNNELING                 0x00000001
> +#define OSC_USB_DP_TUNNELING                   0x00000002
> +#define OSC_USB_PCIE_TUNNELING                 0x00000004
> +#define OSC_USB_XDOMAIN                                0x00000008
> +
> +extern u32 osc_sb_native_usb4_control;
>
>  /* PCI Host Bridge _OSC: Capabilities DWORD 2: Support Field */
>  #define OSC_PCI_EXT_CONFIG_SUPPORT             0x00000001
> --
> 2.29.2
>
