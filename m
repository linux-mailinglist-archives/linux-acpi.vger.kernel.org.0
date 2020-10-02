Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B365C281880
	for <lists+linux-acpi@lfdr.de>; Fri,  2 Oct 2020 19:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726017AbgJBRDF (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 2 Oct 2020 13:03:05 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:43680 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbgJBRDF (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 2 Oct 2020 13:03:05 -0400
Received: by mail-ot1-f67.google.com with SMTP id n61so2004157ota.10
        for <linux-acpi@vger.kernel.org>; Fri, 02 Oct 2020 10:03:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7CIlX7BLKx3mfpWeL5R/FKBM8L55G8uLfcJXAXkNSMU=;
        b=GtTt67ub4+8QK/uw3os6yVvyI2rx8qreg9/uYmP5075OZGo6aTxuVtLpnRMHYQWAFS
         T7bOfuh5H3XY8qag+ltE+/8JZrNea72O5ZP6+QGY4QCd7rHkB2lSVPBWE1gNyZ8kKKqK
         qhNfeKFNwSisQrJwX1On5njfm5PxtYZ6XmFFsfGcQkvYen3Xdosk7o9WXdeRbaN6Xlzc
         ZiMB9QwGg8mJbmFIFSo4EyYwG9e3a6iGGezHaDFRWid92tHwnbfB77HoT5tdLUtgeLd4
         ZSxGXdhjNiZB6pS+8Z5GoVMk+5ErBk4vmoNYA/tVWTjgUZdnTr5abOzUEZ7awCCfOKkU
         F2hw==
X-Gm-Message-State: AOAM530cpIg5dQeupUALr6LuNJ40JedZD/KVzANAV3jyRF1x9fK6SsOW
        +8zxcflyp9zLh+LbKkIxw2lHjm9nz22rMXcgF8y+TMZO
X-Google-Smtp-Source: ABdhPJzs8MMeVz5XY4VlVRHpTXxYw50+pRT8sZd0UOj8UTT+BIRDpRT0ocpicMmRpAbLwp8rWUeCCiU8Vb7erpn7kaY=
X-Received: by 2002:a05:6830:150a:: with SMTP id k10mr2276633otp.167.1601658182439;
 Fri, 02 Oct 2020 10:03:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200927215042.GA281693@decadent.org.uk>
In-Reply-To: <20200927215042.GA281693@decadent.org.uk>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 2 Oct 2020 19:02:51 +0200
Message-ID: <CAJZ5v0gmUQw3U2yC3tQZWaZE-7DV2LUffa=dxRrF+PK5AMPAjg@mail.gmail.com>
Subject: Re: [PATCH] ACPI / extlog: Check for RDMSR failure
To:     Ben Hutchings <ben@decadent.org.uk>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        971058@bugs.debian.org, jim@photojim.ca
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Sep 28, 2020 at 12:27 AM Ben Hutchings <ben@decadent.org.uk> wrote:
>
> extlog_init() uses rdmsrl() to read an MSR, which on older CPUs
> provokes a error message at boot:
>
>     unchecked MSR access error: RDMSR from 0x179 at rIP: 0xcd047307 (native_read_msr+0x7/0x40)
>
> Use rdmsrl_safe() instead, and return -ENODEV if it fails.
>
> Reported-by: jim@photojim.ca
> References: https://bugs.debian.org/971058
> Cc: stable@vger.kernel.org
> Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
> ---
>  drivers/acpi/acpi_extlog.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c
> index f138e12b7b82..72f1fb77abcd 100644
> --- a/drivers/acpi/acpi_extlog.c
> +++ b/drivers/acpi/acpi_extlog.c
> @@ -222,9 +222,9 @@ static int __init extlog_init(void)
>         u64 cap;
>         int rc;
>
> -       rdmsrl(MSR_IA32_MCG_CAP, cap);
> -
> -       if (!(cap & MCG_ELOG_P) || !extlog_get_l1addr())
> +       if (rdmsrl_safe(MSR_IA32_MCG_CAP, &cap) ||
> +           !(cap & MCG_ELOG_P) ||
> +           !extlog_get_l1addr())
>                 return -ENODEV;
>
>         rc = -EINVAL;

Applied as 5.10 material, thanks!
