Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 565DC402C9C
	for <lists+linux-acpi@lfdr.de>; Tue,  7 Sep 2021 18:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234165AbhIGQJM (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 7 Sep 2021 12:09:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:40170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233616AbhIGQJL (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 7 Sep 2021 12:09:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1873C610F8;
        Tue,  7 Sep 2021 16:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631030885;
        bh=+XUCUxmVZqrkeWQiAtqsrdieKePiVa7v7Tc20Xzu/cA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Z9uJ9uamG+TxC5oI+hex4/KHMad87D6dj/mdyTfVT9IyP0K1k+wZHZNPD5mCgF691
         rebALfHxaPbhUExlsKman46AXL2WTRLrugYXvVSCZJQFHXe6rZ8pyA56pQODBOGwu7
         tY1K9ShEMV24mJGuGnJ8kAhVbolItxkrC/KuuhgC7ffg+ggLuu0RCig1IoNwS3VUtM
         sbKsQ5iNxtJVDc7VKFf+56Xm09WFQBHmQ7sA74Itdz7IE6McM1xHoekwKiwbFvZXWd
         mr/oiuTquhK3hkREAXwF7TPIF6BiAOyoMUAggcD5pmF33txeFDP1qf+wTrzU4+Yn+g
         WUnHqikAXy4Aw==
Received: by mail-oo1-f51.google.com with SMTP id y47-20020a4a9832000000b00290fb9f6d3fso3070612ooi.3;
        Tue, 07 Sep 2021 09:08:05 -0700 (PDT)
X-Gm-Message-State: AOAM5324mIuPamTWovJZG2l070NhM9fukd2sxONWRHQVqRVGCM6iAWrY
        25YWujfQgNPY3b0fGD4Psgp0RvZe3ip/2CWcMNk=
X-Google-Smtp-Source: ABdhPJzqToxL6bKT4xsblMgM5ZKybY9eEq2toDlAHtdDNlpaBaQW+gWhNmuG7nQSB1Z1vRGXVw+yIC1Itb1DVOgVhv0=
X-Received: by 2002:a05:6820:16a8:: with SMTP id bc40mr457673oob.63.1631030884426;
 Tue, 07 Sep 2021 09:08:04 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1631025237.git.yu.c.chen@intel.com> <14bb2fa2c49934c627aec07077b96720d46b5202.1631025237.git.yu.c.chen@intel.com>
In-Reply-To: <14bb2fa2c49934c627aec07077b96720d46b5202.1631025237.git.yu.c.chen@intel.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 7 Sep 2021 18:06:28 +0200
X-Gmail-Original-Message-ID: <CAMj1kXH-S5t0kYfTELU_kmhK_Nzmf1WAdZTEGfSFUsDmbG7MYA@mail.gmail.com>
Message-ID: <CAMj1kXH-S5t0kYfTELU_kmhK_Nzmf1WAdZTEGfSFUsDmbG7MYA@mail.gmail.com>
Subject: Re: [PATCH 2/5][RFC] efi: Introduce EFI_FIRMWARE_MANAGEMENT_CAPSULE_HEADER
 and corresponding structures
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Aubrey Li <aubrey.li@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, 7 Sept 2021 at 17:12, Chen Yu <yu.c.chen@intel.com> wrote:
>
> Platform Firmware Runtime Update image starts with UEFI headers, and the headers
> are defined in UEFI specification, but some of them have not been defined in the
> kernel yet.
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
> version number is valid. The EFI_CAPSULE_HEADER has been defined in the
> kernel, however the rest are not, thus introduce corresponding UEFI structures
> accordingly.
>
> The reason why efi_manage_capsule_header_t and efi_manage_capsule_image_header_t
> are packedi might be that:
> According to the uefi spec,
> [Figure 23-6 Firmware Management and Firmware Image Management headers]
> EFI_FIRMWARE_MANAGEMENT_CAPSULE_HEADER is located at the lowest offset within
> the body of the capsule. And this structure is designed to be unaligned to save
> space, because in this way the adjacent drivers and binary payload elements could
> start on byte boundary with no padding. And the
> EFI_FIRMWARE_MANAGEMENT_CAPSULE_IMAGE_HEADER is at the head of each payload, so
> packing this structure also makes room for more data.
>
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>

Who is going to use these definitions? I only see this patch, where is
the rest of the series?

> ---
>  include/linux/efi.h | 50 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 50 insertions(+)
>
> diff --git a/include/linux/efi.h b/include/linux/efi.h
> index 6b5d36babfcc..19ff834e1388 100644
> --- a/include/linux/efi.h
> +++ b/include/linux/efi.h
> @@ -148,6 +148,56 @@ typedef struct {
>         u32 imagesize;
>  } efi_capsule_header_t;
>
> +#pragma pack(1)
> +
> +/* EFI_FIRMWARE_MANAGEMENT_CAPSULE_HEADER */
> +typedef struct {
> +       u32     ver;
> +       u16     emb_drv_cnt;
> +       u16     payload_cnt;
> +       /*
> +        * Variable array indicated by number of
> +        * (emb_drv_cnt + payload_cnt)
> +        */
> +       u64     offset_list[];
> +} efi_manage_capsule_header_t;
> +
> +/* EFI_FIRMWARE_MANAGEMENT_CAPSULE_IMAGE_HEADER */
> +typedef struct {
> +       u32     ver;
> +       guid_t  image_type_id;
> +       u8      image_index;
> +       u8      reserved_bytes[3];
> +       u32     image_size;
> +       u32     vendor_code_size;
> +       /* ver = 2. */
> +       u64     hw_ins;
> +       /* ver = v3. */
> +       u64     capsule_support;
> +} efi_manage_capsule_image_header_t;
> +
> +#pragma pack()
> +
> +/* WIN_CERTIFICATE */
> +typedef struct {
> +       u32     len;
> +       u16     rev;
> +       u16     cert_type;
> +} win_cert_t;
> +
> +/* WIN_CERTIFICATE_UEFI_GUID */
> +typedef struct {
> +       win_cert_t      hdr;
> +       guid_t          cert_type;
> +       u8              cert_data[];
> +} win_cert_uefi_guid_t;
> +
> +/* EFI_FIRMWARE_IMAGE_AUTHENTICATIO */
> +typedef struct {
> +       u64                             mon_count;
> +       win_cert_uefi_guid_t            auth_info;
> +} efi_image_auth_t;
> +
>  /*
>   * EFI capsule flags
>   */
> --
> 2.25.1
>
