Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C47F3AF6A3
	for <lists+linux-acpi@lfdr.de>; Mon, 21 Jun 2021 22:07:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231566AbhFUUJY (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 21 Jun 2021 16:09:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230515AbhFUUJX (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 21 Jun 2021 16:09:23 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5786EC061756
        for <linux-acpi@vger.kernel.org>; Mon, 21 Jun 2021 13:07:09 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id q190so31020673qkd.2
        for <linux-acpi@vger.kernel.org>; Mon, 21 Jun 2021 13:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=uBcdR0T+6KroutNYMXOLUP20+jwr0Bv2TkyvivOjBOc=;
        b=Llc1ViRs+26Si+5pYXSSZGx/Cgwbg7/QDSkW/yA/rlz2p0Vz7LafzFfK0E+7dg1l44
         f1vFlzurto0Wt3PZeez+/hA/ilrgLwjl+sXDUm1dIK5ndz4HtewYPyvsKDdUX5A11WCc
         F6GbURD2KJGrWRPAXSk/CXQTldnzv6UWwAVKF9J2umJMh/IBZ+20V6dx6USyExZxJBOG
         CrmA4fB9UAswNUn1cqi7olhJGZd4eu6/b5mi9G0PCY3xHLz+H3UW2w0XlFi9I747XdYS
         LprI+tELmaTdMSpyO/Z4LEEttCDjA+BY3kzDCjYzn6+5NQ/1lPGHhDEDq/d9RX+R112y
         W69Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=uBcdR0T+6KroutNYMXOLUP20+jwr0Bv2TkyvivOjBOc=;
        b=dWt93lxx2sDcawKIXwA8aMax9nuamwzH6vogH2JwIGjuDh8pbfIKun0edSP+bIb5f5
         Meeg+28PrULu7cJSm2kupPWok1F+3lLlwTVA5nnLBysQ/tinK7KH6DoZkyWqtiaTQmLn
         IQB062pC8aZxmNjpPzoFNcJNcz9WRFXAMN5HY2RCWSe5zAOD6CqXXtgEsydK8obMbCvu
         9z6hUgCN+nfVND+FdenmDHLah81rKpHdyxParZGz/+xL1hhDrpoDhOb6P4THF+93rsHR
         5TUYnH22CPVObA+yYdFPH82XHA7OR2px1D/n3jwGBcQuFIZ9uamyHUvQpIl0pc5gMr0h
         vQag==
X-Gm-Message-State: AOAM531eoLWVFCDDFZUGZKG9UeddWajvygl37m1VHD5b8GC4VfBFZwU7
        +Z15q5Y1brxHC73vuH5cBrNQYHo5VUtd2TQMn7u6xZC750k=
X-Google-Smtp-Source: ABdhPJyRra2aDo3AX87HCjr8lM2KabmMsSTYoEoQwTRYAJauaAv8llGm5dNBTl1f53WymEQRQlHF9PkBfzbu+cFqK3s=
X-Received: by 2002:a37:a1d5:: with SMTP id k204mr424751qke.300.1624306028406;
 Mon, 21 Jun 2021 13:07:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210621200459.3558199-1-mw@semihalf.com>
In-Reply-To: <20210621200459.3558199-1-mw@semihalf.com>
From:   Marcin Wojtas <mw@semihalf.com>
Date:   Mon, 21 Jun 2021 22:06:58 +0200
Message-ID: <CAPv3WKctDU7WOxHzeHc49-G_h42qX-pUpinJN2CVHNoRH86QHw@mail.gmail.com>
Subject: Re: [net-next: PATCH v3 1/1] ACPI: SPCR: Add new 16550-compatible
 Serial Port Subtype
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        devel@acpica.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Apologies for the patch prefix, of course it's a first version and
unrelated to the networking subsystem.

Best regards,
Marcin


pon., 21 cze 2021 o 22:05 Marcin Wojtas <mw@semihalf.com> napisa=C5=82(a):
>
> The Microsoft Debug Port Table 2 (DBG2) specification revision
> May 31, 2017 adds support for 16550-compatible Serial Port
> Subtype with parameters defined in Generic Address Structure (GAS) [1]
>
> Add its support in SPCR parsing routine.
>
> [1] https://docs.microsoft.com/en-us/windows-hardware/drivers/bringup/acp=
i-debug-port-table
>
> Signed-off-by: Marcin Wojtas <mw@semihalf.com>
> ---
>  include/acpi/actbl1.h | 1 +
>  drivers/acpi/spcr.c   | 1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
> index ce59903c2695..f746012eba8d 100644
> --- a/include/acpi/actbl1.h
> +++ b/include/acpi/actbl1.h
> @@ -498,6 +498,7 @@ struct acpi_dbg2_device {
>  #define ACPI_DBG2_ARM_SBSA_GENERIC  0x000E
>  #define ACPI_DBG2_ARM_DCC           0x000F
>  #define ACPI_DBG2_BCM2835           0x0010
> +#define ACPI_DBG2_16550_WITH_GAS    0x0012
>
>  #define ACPI_DBG2_1394_STANDARD     0x0000
>
> diff --git a/drivers/acpi/spcr.c b/drivers/acpi/spcr.c
> index 88460bacd5ae..25c2d0be953e 100644
> --- a/drivers/acpi/spcr.c
> +++ b/drivers/acpi/spcr.c
> @@ -136,6 +136,7 @@ int __init acpi_parse_spcr(bool enable_earlycon, bool=
 enable_console)
>                 break;
>         case ACPI_DBG2_16550_COMPATIBLE:
>         case ACPI_DBG2_16550_SUBSET:
> +       case ACPI_DBG2_16550_WITH_GAS:
>                 uart =3D "uart";
>                 break;
>         default:
> --
> 2.29.0
>
