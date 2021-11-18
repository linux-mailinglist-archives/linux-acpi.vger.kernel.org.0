Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEBB4455FD4
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Nov 2021 16:49:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232201AbhKRPwr (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 18 Nov 2021 10:52:47 -0500
Received: from mail-ot1-f51.google.com ([209.85.210.51]:42858 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232145AbhKRPwr (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 18 Nov 2021 10:52:47 -0500
Received: by mail-ot1-f51.google.com with SMTP id g91-20020a9d12e4000000b0055ae68cfc3dso11625428otg.9;
        Thu, 18 Nov 2021 07:49:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l7l9oCuRb77iXqEE70dsBDNDveq2BFPuAqZsg/fhzeo=;
        b=yz/PM6v6YnFhLE9WS/5giRQrEt2LBATEM2A9TNhr1+HbHj9JOYmfbpPVnuxycBeWMi
         PkmziNkFdMhURpizdt4BNq0RaIVzTV4VWve7Sfc/xgN9IGlrkHFIsLrRp8D+7839lebf
         WtKZBLUHKRKy5C75406T4RANLQy7R2YOnlXKzSQDSDb+2jY6dDVeA31JRGfI6mZA+/KS
         HO4rUoAIHiGJ6PvVhHpLvFmJQzZNtDsPwrEMKnDsWLmwdyPsqBK2kL4LysIRWE1Rc8bZ
         4E/nUSjOVGbNsmA0WbYvTOHpw5e0BfEdYUDVb75ZOLvOduBrkebr3sOfCKHLnRQUVR1j
         uLXg==
X-Gm-Message-State: AOAM5327/2sPnutvh5WUlZf8zMgS+mtFhf/1aiawg/4+k0cx1ycFz9Xx
        pLfHCifjSIFzx0dn01Q7vX70q+9l5RIZ6w0Sn0r/trUDj1I=
X-Google-Smtp-Source: ABdhPJxmPi7+69fRdSgGpSSwptMkNeh5l4y3m0ZqBUGbDlwXJpedaYqXiHaZJylU8HUb1quSlNH94xMIMlprvHy7PTQ=
X-Received: by 2002:a9d:a64:: with SMTP id 91mr21783319otg.198.1637250586685;
 Thu, 18 Nov 2021 07:49:46 -0800 (PST)
MIME-Version: 1.0
References: <cover.1635953446.git.yu.c.chen@intel.com> <68d1c452bbf7f742793cb39ebb66f6b4ba6a3fb3.1635953446.git.yu.c.chen@intel.com>
In-Reply-To: <68d1c452bbf7f742793cb39ebb66f6b4ba6a3fb3.1635953446.git.yu.c.chen@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 18 Nov 2021 16:49:35 +0100
Message-ID: <CAJZ5v0gKu3JtCGThZKx87rQJeW+xK=ZkSD47kaP+N8Qr8Pq-Tw@mail.gmail.com>
Subject: Re: [PATCH v8 1/4] efi: Introduce EFI_FIRMWARE_MANAGEMENT_CAPSULE_HEADER
 and corresponding structures
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>, Len Brown <lenb@kernel.org>,
        Ashok Raj <ashok.raj@intel.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        Aubrey Li <aubrey.li@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Nov 3, 2021 at 4:44 PM Chen Yu <yu.c.chen@intel.com> wrote:
>
> Platform Firmware Runtime Update image starts with UEFI headers, and the
> headers are defined in UEFI specification, but some of them have not been
> defined in the kernel yet.
>
> For example, the header layout of a capsule file looks like this:
>
> EFI_CAPSULE_HEADER
> EFI_FIRMWARE_MANAGEMENT_CAPSULE_HEADER
> EFI_FIRMWARE_MANAGEMENT_CAPSULE_IMAGE_HEADER
> EFI_FIRMWARE_IMAGE_AUTHENTICATION
>
> These structures would be used by the Platform Firmware Runtime Update
> driver to parse the format of capsule file to verify if the corresponding
> version number is valid.

Why does the driver need to do that?

The firmware will reject the update if the version is invalid anyway, won't it?

> The EFI_CAPSULE_HEADER has been defined in the
> kernel, however the rest are not, thus introduce corresponding UEFI
> structures accordingly.

I would change the above in the following way:

"EFI_CAPSULE_HEADER has been defined in the kernel, but the other
structures have not been defined yet, so do that."

> Besides, EFI_FIRMWARE_MANAGEMENT_CAPSULE_HEADER
> and EFI_FIRMWARE_MANAGEMENT_CAPSULE_IMAGE_HEADER are required to be packed
> in the uefi specification.

> Ard has pointed out that, the __packed
> attribute does indicate to the compiler that the entire thing can appear
> misaligned in memory. So if one follows the other in the capsule header,
> the __packed attribute may be appropriate to ensure that the second one
> is not accessed using misaligned loads and stores.

"For this reason, use the __packed attribute to indicate to the
compiler that the entire structure can appear misaligned in memory (as
suggested by Ard) in case one of them follows the other directly in a
capsule header."

>
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> ---
> v8: Use efi_guid_t instead of guid_t. (Andy Shevchenko)
> v7: Use __packed instead of pragma pack(1). (Greg Kroah-Hartman, Ard Biesheuve)
> v6: No change since v5.
> v5: No change since v4.
> v4: Revise the commit log to make it more clear. (Rafael J. Wysocki)
> ---
>  include/linux/efi.h | 46 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 46 insertions(+)
>
> diff --git a/include/linux/efi.h b/include/linux/efi.h
> index 6b5d36babfcc..1ec73c5ab6c9 100644
> --- a/include/linux/efi.h
> +++ b/include/linux/efi.h
> @@ -148,6 +148,52 @@ typedef struct {
>         u32 imagesize;
>  } efi_capsule_header_t;
>
> +/* EFI_FIRMWARE_MANAGEMENT_CAPSULE_HEADER */
> +struct efi_manage_capsule_header {
> +       u32 ver;
> +       u16 emb_drv_cnt;
> +       u16 payload_cnt;
> +       /*
> +        * Variable array indicated by number of
> +        * (emb_drv_cnt + payload_cnt)

* Variable-size array of the size given by the sum of
* emb_drv_cnt and payload_cnt.

> +        */
> +       u64 offset_list[];
> +} __packed;
> +
> +/* EFI_FIRMWARE_MANAGEMENT_CAPSULE_IMAGE_HEADER */
> +struct efi_manage_capsule_image_header {
> +       u32 ver;
> +       efi_guid_t image_type_id;
> +       u8 image_index;
> +       u8 reserved_bytes[3];
> +       u32 image_size;
> +       u32 vendor_code_size;
> +       /* ver = 2. */

What does this mean?

> +       u64 hw_ins;
> +       /* ver = v3. */

And same here?

> +       u64 capsule_support;
> +} __packed;
> +
> +/* WIN_CERTIFICATE */
> +struct win_cert {
> +       u32 len;
> +       u16 rev;
> +       u16 cert_type;
> +};
> +
> +/* WIN_CERTIFICATE_UEFI_GUID */
> +struct win_cert_uefi_guid {
> +       struct win_cert hdr;
> +       efi_guid_t cert_type;
> +       u8 cert_data[];
> +};
> +
> +/* EFI_FIRMWARE_IMAGE_AUTHENTICATIO */

The "N" character at the end is missing.

> +struct efi_image_auth {
> +       u64 mon_count;
> +       struct win_cert_uefi_guid auth_info;
> +};
> +
>  /*
>   * EFI capsule flags
>   */
> --
