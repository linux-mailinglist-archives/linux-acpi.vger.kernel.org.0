Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4843278EA7
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Sep 2020 18:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728524AbgIYQdO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Fri, 25 Sep 2020 12:33:14 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:42481 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729286AbgIYQdN (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 25 Sep 2020 12:33:13 -0400
Received: by mail-ot1-f68.google.com with SMTP id m13so2841966otl.9
        for <linux-acpi@vger.kernel.org>; Fri, 25 Sep 2020 09:33:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bs7mnlP4b/URIswvZTOnALYLTix0lxWqIN7c5PmfLao=;
        b=r0CCAuoUSqm2DzHjCr9MSUr4CwK3208mO/7rPzPduiKJxf3x2jbCAqNKUprINZoFBi
         ScanmU9VRolzLXXF1yDdjP3H7kIrhcXVaPv5LYyqTLB2XcuLicilJvtBA1NPR1Voc0tB
         hJlWySTF52LzrxzGzWzioBM5Dj5+fD5jBGFLiopHvGoftOsfh+2nbu+7UgoXvRQSTUY/
         6+PFDrAuPGwn5enuxTthwwhgW6umn3XeMtAsOWrampjGPBUoUlt3PB2DHsPGVve29FLX
         TjrWLeEDbs88mqGm74YOMKdg4Tlg6KwWwkOiPQGdltxZY6lQrnH8etdnBuje657fs2Rl
         c1eQ==
X-Gm-Message-State: AOAM533u3GQP68AbbTTX0/NBRHmHnmgKyPK2ko+0GN5hCjfWOT5DbQV2
        LH3YPT32tP4ePKMnYmOPUMAfhxViZ6WElxZ86aw=
X-Google-Smtp-Source: ABdhPJxiTXXKmigHXv6twbVL+TRTl5DZuTLpCmEKbXrEcf2kILgUbHpjCd2QWyxUfJuvtNUpGo6YNpgIVVDDbb99O2U=
X-Received: by 2002:a05:6830:150a:: with SMTP id k10mr827066otp.167.1601051592857;
 Fri, 25 Sep 2020 09:33:12 -0700 (PDT)
MIME-Version: 1.0
References: <6_vrlQfVYcRdLYK5BlS8E-_nRAXwCcIc-A2BAszjnowG_e4C-wMy6rdjbZZ0DzCJOMzHZfYUnhaHZfRIXFNE9Vp-23q9R2j305D26c3-EMA=@protonmail.com>
In-Reply-To: <6_vrlQfVYcRdLYK5BlS8E-_nRAXwCcIc-A2BAszjnowG_e4C-wMy6rdjbZZ0DzCJOMzHZfYUnhaHZfRIXFNE9Vp-23q9R2j305D26c3-EMA=@protonmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 25 Sep 2020 18:33:02 +0200
Message-ID: <CAJZ5v0hgiLWp00ThMTfugxv_RJcGjt3VULbaCL9rXWFtuj-nbw@mail.gmail.com>
Subject: Re: [PATCH] ACPI: battery.h: include linux/power_supply.h
To:     =?UTF-8?B?QmFybmFiw6FzIFDFkWN6ZQ==?= <pobrn@protonmail.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Sep 25, 2020 at 11:38 AM Barnabás Pőcze <pobrn@protonmail.com> wrote:
>
> acpi/battery.h uses 'struct power_supply *', but fails to
> include/create any declaration of the type. Include linux/
> power_supply.h to fix that.
>
> Signed-off-by: Barnabás Pőcze <pobrn@protonmail.com>
> ---
>  include/acpi/battery.h | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/include/acpi/battery.h b/include/acpi/battery.h
> index 5d8f5d910c82..b8d56b702c7a 100644
> --- a/include/acpi/battery.h
> +++ b/include/acpi/battery.h
> @@ -2,6 +2,8 @@
>  #ifndef __ACPI_BATTERY_H
>  #define __ACPI_BATTERY_H
>
> +#include <linux/power_supply.h>
> +
>  #define ACPI_BATTERY_CLASS "battery"
>
>  #define ACPI_BATTERY_NOTIFY_STATUS     0x80
> --

Applied as 5.10 material with minor subject edit, thanks!
