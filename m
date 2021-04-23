Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D686B36923A
	for <lists+linux-acpi@lfdr.de>; Fri, 23 Apr 2021 14:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbhDWMh2 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Fri, 23 Apr 2021 08:37:28 -0400
Received: from mail-oi1-f171.google.com ([209.85.167.171]:46680 "EHLO
        mail-oi1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbhDWMh2 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 23 Apr 2021 08:37:28 -0400
Received: by mail-oi1-f171.google.com with SMTP id m13so49014241oiw.13;
        Fri, 23 Apr 2021 05:36:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nJ2OENXUaqO5OvyjBXD2rLeFTuSglGfC0qMGdtDgRkw=;
        b=Rk342W3AcqNXK0yHixDFgEIJZRAVXsJBpYok5es+m7S5yiCshixL8/BsbYkrk5fwpT
         DL/MNm3nY4FV+o6/1H+21l3ghhu8BIvEo8EcF0/QjPq6cF7uJw2gNVLkNJ0ruEJLroVW
         Sm7KeGsEPhb3/Hr6fxInDbB69x2uwmpWH84E3MDJiyUoSm0Oz19hQy/RBTZEqWNGElwF
         f8BNj4YxFm6ZgxtRv4PuY0MHGdOoAXZR8War8TLPGtG5mK0eXaMPIm7D8dduq7jGRqqw
         TgfkJeyQ2HBRlFs5pLxljbyfft4Gcp5ACuUuNFvBH2b4eCoKmSWpqHX3Jn7g+MmR/Qgk
         BF3A==
X-Gm-Message-State: AOAM533TghNtjMJMSeJgJ2ufVxBYMnsQlxyIU2zRxk1K9ACejH7YmEeo
        s1o9hVVoZRgX/Uh/oQATGs1aguDUYI/6D4C/bY8V87R4
X-Google-Smtp-Source: ABdhPJzDYD7KjutDPZHrpNnk02KtkunUs7btU2Xb2RB5NIkPp8RmCAtiFM6FVL9TfUBmDge2EHvgWN3TiYbrA9aSMQ8=
X-Received: by 2002:aca:5fc3:: with SMTP id t186mr2564757oib.69.1619181411373;
 Fri, 23 Apr 2021 05:36:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210422214930.716596-1-sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20210422214930.716596-1-sathyanarayanan.kuppuswamy@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 23 Apr 2021 14:36:38 +0200
Message-ID: <CAJZ5v0gH-Zg7YZPf9joaMt1zfYfNkUGpo596=9QEJ1NKAw87qQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] ACPICA: Add SVKL table headers
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>
Cc:     Rafael J Wysocki <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Apr 22, 2021 at 11:49 PM Kuppuswamy Sathyanarayanan
<sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>
> ACPICA commit b5e6bcf69dbb9877481992d5ce86008cfb94f5b8

Evidently, this is ACPICA material, so I'm expecting to receive this
patch from Erik within the normal ACPICA development process, so I'm
not sure what the purpose of this submission is.

Has this patch been posted here for reference only?

> SVKL (Storage Volume Key Location Table) is used by BIOS/Firmware
> to share storage volume encryption key's with OS. It will be used
> by userspace to decrypt and mount encrypted drives.
>
> So add SVKL table signature and add it to known signatures array
> support SVKL.
>
> You can find details about the SVKL table in TDX specfication
> titled "Guest-Host-Communication Interface (GHCI) for Intel
> Trust Domain Extensions (Intel® TDX)", sec 4.4 and in ACPI
> specification r6.4, sec 5.2.6.
>
> https://software.intel.com/content/dam/develop/external/us/en/documents/intel-tdx-guest-hypervisor-communication-interface.pdf
>
> Cc: Robert Moore <robert.moore@intel.com>
> Cc: Erik Kaneda <erik.kaneda@intel.com>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Link: https://github.com/acpica/acpica/commit/b5e6bcf6
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> ---
>  include/acpi/actbl2.h | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
>
> diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
> index d6478c430c99..83a9d8b68e3a 100644
> --- a/include/acpi/actbl2.h
> +++ b/include/acpi/actbl2.h
> @@ -43,6 +43,7 @@
>  #define ACPI_SIG_SDEI           "SDEI" /* Software Delegated Exception Interface Table */
>  #define ACPI_SIG_SDEV           "SDEV" /* Secure Devices table */
>  #define ACPI_SIG_NHLT           "NHLT" /* Non-HDAudio Link Table */
> +#define ACPI_SIG_SVKL           "SVKL" /* Storage Volume Key Location Table */
>
>  /*
>   * All tables must be byte-packed to match the ACPI specification, since
> @@ -1713,6 +1714,35 @@ struct acpi_sdev_pcie_path {
>         u8 function;
>  };
>
> +/*******************************************************************************
> + *
> + * SVKL - Storage Volume Key Location Table (ACPI 6.4)
> + *        Version 1
> + *
> + ******************************************************************************/
> +
> +struct acpi_table_svkl {
> +       struct acpi_table_header header;        /* Common ACPI table header */
> +       u32 count;
> +};
> +
> +struct acpi_svkl_header {
> +       u16 type;
> +       u16 format;
> +       u32 size;
> +       u64 address;
> +};
> +
> +enum acpi_svkl_type {
> +       ACPI_SVKL_TYPE_MAIN_STORAGE = 0,
> +       ACPI_SVKL_TYPE_RESERVED = 1     /* 1 and greater are reserved */
> +};
> +
> +enum acpi_svkl_format {
> +       ACPI_SVKL_FORMAT_RAW_BINARY = 0,
> +       ACPI_SVKL_FORMAT_RESERVED = 1   /* 1 and greater are reserved */
> +};
> +
>  /* Reset to default packing */
>
>  #pragma pack()
> --
> 2.25.1
>
