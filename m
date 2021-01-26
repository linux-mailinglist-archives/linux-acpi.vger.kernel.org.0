Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 999E5304C9A
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Jan 2021 23:51:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730396AbhAZWuM (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 26 Jan 2021 17:50:12 -0500
Received: from mail-ot1-f43.google.com ([209.85.210.43]:38269 "EHLO
        mail-ot1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389919AbhAZS2f (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 26 Jan 2021 13:28:35 -0500
Received: by mail-ot1-f43.google.com with SMTP id s2so14980411otp.5;
        Tue, 26 Jan 2021 10:28:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qvmjRU4vLqrugRhSX00gkIjq8wIoIE/XEIcN8DtiKuE=;
        b=SAGnkRyXVlf1GZPQKEWnL40rNe90j1c0ewT/y0pGvNGaQ7qbZwv1IqPWRoUHsV0tJO
         smRhp+FQL5yn+R9V9CeRKFgX4NF2Tqekz5YgyhGMGwrABCnFHKQ2BoenZLHv27fdK83i
         ni0qihsAIZIBMrdqMIlKLczufKjZdMjR4+dOMB7czsddPBZO2oJL0rV2ksezMEESgkc7
         4WmRj9fG4XmON1Imd85Ag+Da2sAcDWxwfQjKGuj8xAnMk0ESzYXnmc+q/obYWaQ4FTQe
         yolY1ososnjh02iBL56TTkjQvNVLTOLmFrD87hcfq/5SYEoxDqmkszloOFJSfVN5xxJL
         AIUw==
X-Gm-Message-State: AOAM5317INulFbDe6xhOYb3dD3go47Yw1z57ASUJQbBW8hx+WHDKvPnC
        DtFk3JOggoCrcEUHEFhBCGIOimkIY+vaQGEuegQ=
X-Google-Smtp-Source: ABdhPJx9LhMbNU6k3LrL4EYj7kHNDp6IURievBPQQGwcjjjGCzdjHTollhV6O/srU4Q32A0xpH0mQcrpAELah6EDIwA=
X-Received: by 2002:a9d:1710:: with SMTP id i16mr4839780ota.260.1611685673920;
 Tue, 26 Jan 2021 10:27:53 -0800 (PST)
MIME-Version: 1.0
References: <20210126155723.9388-1-mika.westerberg@linux.intel.com> <20210126155723.9388-6-mika.westerberg@linux.intel.com>
In-Reply-To: <20210126155723.9388-6-mika.westerberg@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 26 Jan 2021 19:27:42 +0100
Message-ID: <CAJZ5v0i3b5Ke_a3JEGVaYz6htRvmCPaN2cshB-XiQD2p-iQ+Wg@mail.gmail.com>
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

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

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
