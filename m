Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D37153794B1
	for <lists+linux-acpi@lfdr.de>; Mon, 10 May 2021 18:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231271AbhEJQ7i convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Mon, 10 May 2021 12:59:38 -0400
Received: from mail-ot1-f46.google.com ([209.85.210.46]:44604 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbhEJQ7h (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 10 May 2021 12:59:37 -0400
Received: by mail-ot1-f46.google.com with SMTP id r26-20020a056830121ab02902a5ff1c9b81so15031976otp.11;
        Mon, 10 May 2021 09:58:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Mdc3Kqk0NZP6BpgdgGjdHCFYVjpYe4qGua4+BuVWq3U=;
        b=l7YBAiIdtNYZeuSDdYLPznMeVlXiYkRwLnZ+auGq/8thP/EquALfpi3xkhwdPcWZ28
         y70Qxs/SfxybT/QJqc9PZg64PJLUS5zHTVScKoKxdOvY/7ichQn/20kB1+ghTMy/OKXe
         yhgSGbPJfPbqDIJVUDptqK5sQomRlggQAhh/KTUPF88pRItdMsCPMidU7nHgUoWEhsqA
         2RgxV8h16e2YVRmb3YLSu1VSYnHdwvvF1Z6zCZg/D84HRnVU36r88j/w3hYBNeWXMJTg
         xiWkAySVVpTB4e/CqR2BRVLteOazYo8Q367SQtM7oGrsBs62tHecLv7uLPCI9ybAYdoW
         xu5g==
X-Gm-Message-State: AOAM532HIHqQFOHrZzmDvn3n7j0DiL6Z6mIwzYNakLFlH+ZwduG3i0Ob
        cCulULPDTMDIUyCpBS8ht0dLVITK4ynIOwWc55k=
X-Google-Smtp-Source: ABdhPJwHzdHYxbhgDXy0Jlitwnn2q7MwIUVmnIfa1aCkQ/ysTB9d4cRsHs5OHjTLKJEO0JjcwB7tLKlN5ORnFbZ8ekk=
X-Received: by 2002:a9d:3bcb:: with SMTP id k69mr22880619otc.206.1620665910887;
 Mon, 10 May 2021 09:58:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210422192937.707500-1-sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20210422192937.707500-1-sathyanarayanan.kuppuswamy@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 10 May 2021 18:58:19 +0200
Message-ID: <CAJZ5v0hbAaFtRxuyR2B6YBUfV6eGWmDrZnTisd9j5H0UNurqrg@mail.gmail.com>
Subject: Re: [PATCH 1/1] ACPICA: Add SVKL table headers
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

On Thu, Apr 22, 2021 at 9:29 PM Kuppuswamy Sathyanarayanan
<sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>
> ACPICA commit b5e6bcf69dbb9877481992d5ce86008cfb94f5b8
>
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
>
> Link: https://github.com/acpica/acpica/commit/b5e6bcf6
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Signed-off-by: Bob Moore <robert.moore@intel.com>
> Signed-off-by: Erik Kaneda <erik.kaneda@intel.com>

Erik, what's the plan regarding this patch and the other ACPICA change
requisite for this series?

Are they going to be part of the next ACPICA release and am I going to
receive them the usual way?

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
