Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 601072F60EF
	for <lists+linux-acpi@lfdr.de>; Thu, 14 Jan 2021 13:15:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729099AbhANMPH (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 14 Jan 2021 07:15:07 -0500
Received: from mail-oi1-f169.google.com ([209.85.167.169]:45417 "EHLO
        mail-oi1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728394AbhANMPH (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 14 Jan 2021 07:15:07 -0500
Received: by mail-oi1-f169.google.com with SMTP id f132so5624627oib.12;
        Thu, 14 Jan 2021 04:14:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N9a/fEJBQ8EKU9Sx9nqvztNjfJU08nsUnc68QxM+gI0=;
        b=txBiCk3+e96gRhDgM9ZIJ5hGOycHyPpUGFU31b7UElOS4i7FFYw1bbQUKR/f1XtPqh
         5rzk4Fz9TMmXWwX1IxzVlflq6LynF996VMlXDScQw/6QEN39W32eOJ0t2gFhPtL0LXsX
         3Im2HO4X8ynoB0NNR5VImJNaPZqgJlq6QCmHor4unc2GXKV6shSKKnZwLypJIibnAC9x
         wyF2SHKGYlKj4PcFHXNuYXwkydQvyUcUpO9u68kRlIsHvlMLj5g6Yxcdh2tDwVUze2H9
         rbAAD6j4ZyBov0e/zZJx9rEC8/bPmUF2FYXnENkQNv4lvaLgWzWjychbqi+PeAp4qGKL
         j2SQ==
X-Gm-Message-State: AOAM533k2XV0noqsXtrUDckLMdGS6T9fc7XLu7HsULPSG97OSgl7hYXM
        CiBU9lSJKKUwfTNr69Adgvwy35tJULc3DAWi4gw=
X-Google-Smtp-Source: ABdhPJwnOu4NivPEtE8UVzJUtYv6p12q9l3jiDfhNWRCmVri46I6u9UoJeA+CkIB1VbyIjBuoZaslNZOspFi5TDKBrY=
X-Received: by 2002:aca:4892:: with SMTP id v140mr2383078oia.71.1610626466163;
 Thu, 14 Jan 2021 04:14:26 -0800 (PST)
MIME-Version: 1.0
References: <20210114071923.14920-1-qiuxu.zhuo@intel.com>
In-Reply-To: <20210114071923.14920-1-qiuxu.zhuo@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 14 Jan 2021 13:14:13 +0100
Message-ID: <CAJZ5v0j0JABf3mx2wv5Z7tQY8f0pjWVMwH2mCYWVN_siJ-ziFg@mail.gmail.com>
Subject: Re: [PATCH 1/1] Documentation: ACPI: EINJ: Fix error type value for
 PCIe error
To:     Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Huang Ying <ying.huang@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Jan 14, 2021 at 8:20 AM Qiuxu Zhuo <qiuxu.zhuo@intel.com> wrote:
>
> Fix the error type value for PCI Express uncorrectable non-fatal
> error to 0x00000080 and fix the error type value for PCI Express
> uncorrectable fatal error to 0x00000100.
>
> See Advanced Configuration and Power Interface Specification,
> version 6.2, table "18-409 Error Type Definition".
>
> Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> Reported-by: Lijian Zhao <lijian.zhao@intel.com>
> ---
> The error type values used in file drivers/acpi/apei/einj.c
> function available_error_type_show() are correct.
>
>
>  Documentation/firmware-guide/acpi/apei/einj.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/firmware-guide/acpi/apei/einj.rst b/Documentation/firmware-guide/acpi/apei/einj.rst
> index e588bccf5158..c042176e1707 100644
> --- a/Documentation/firmware-guide/acpi/apei/einj.rst
> +++ b/Documentation/firmware-guide/acpi/apei/einj.rst
> @@ -50,8 +50,8 @@ The following files belong to it:
>    0x00000010        Memory Uncorrectable non-fatal
>    0x00000020        Memory Uncorrectable fatal
>    0x00000040        PCI Express Correctable
> -  0x00000080        PCI Express Uncorrectable fatal
> -  0x00000100        PCI Express Uncorrectable non-fatal
> +  0x00000080        PCI Express Uncorrectable non-fatal
> +  0x00000100        PCI Express Uncorrectable fatal
>    0x00000200        Platform Correctable
>    0x00000400        Platform Uncorrectable non-fatal
>    0x00000800        Platform Uncorrectable fatal
> --

Applied as 5.11-rc material with a couple of minor edits in the subject, thanks!
