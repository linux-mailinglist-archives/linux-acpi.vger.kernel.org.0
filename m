Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22CD81A98BD
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Apr 2020 11:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895444AbgDOJYW (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 15 Apr 2020 05:24:22 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:37026 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2895441AbgDOJYV (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 15 Apr 2020 05:24:21 -0400
Received: by mail-oi1-f195.google.com with SMTP id r25so3058376oij.4;
        Wed, 15 Apr 2020 02:24:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PeBwwUHexbq/B0mllpXl205PmqHG/3tGbcfB95WXpZk=;
        b=IWlILqMAoTKQSWSI8IDWMp6nVligMUztlOrGi0xClI07bE/qiBqpScu11d6QwI7hLT
         UzwElrqEz5Cez2IehCwiejPGUSRczWvUGxjEmGrqO5MCnzptk6vJUfol8YT6yCL/jaIL
         2IbAQnZsZVbxeOOZsA7ocEPp7KeaJsGeReC2MsQryWwlrQyztN8DV/DnsDlO5N8pK5w/
         tIiyzP2XElF9eIOOIdtC/mM3i/LT0Z3gTH3j8ZQKHsUDyv5kU14E8T/RX46l6mDztMFD
         FQ8T2/OGJcGs5gKJ5P8rm3VozfKuu8HQ5Dx1J2BYM06/fwD+OsjRBsQWjcZqwOHfqwbC
         F0IA==
X-Gm-Message-State: AGi0PuaPiwbjl7p2vW85Ay8h1lRCkPw8mfjm45IkIxtCECdN8k3MyyeY
        YPdFoNKnlOX059X4ZU31TBCPLH2F9+v1h181dYY=
X-Google-Smtp-Source: APiQypJZrPtk9CTp5eBsivxylrSi0zfKsT9ogsSyvEIjXIEYZWQOgAkgP4CZqwUp9bBm3A0h4TeoQrnfXPtaDIa1khU=
X-Received: by 2002:a05:6808:81:: with SMTP id s1mr559297oic.68.1586942660307;
 Wed, 15 Apr 2020 02:24:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200415084933.6251-1-yanaijie@huawei.com>
In-Reply-To: <20200415084933.6251-1-yanaijie@huawei.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 15 Apr 2020 11:24:09 +0200
Message-ID: <CAJZ5v0ie67VHR40GjHnnAmW3fnO0V3ypLvsy9HSnq9_zR1bEMA@mail.gmail.com>
Subject: Re: [PATCH] ACPICA: make acpi_protocol_lengths static
To:     Jason Yan <yanaijie@huawei.com>,
        Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>
Cc:     Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hulk Robot <hulkci@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Apr 15, 2020 at 10:23 AM Jason Yan <yanaijie@huawei.com> wrote:
>
> Fix the following sparse warning:
>
> drivers/acpi/acpica/exfield.c:25:10: warning: symbol
> 'acpi_protocol_lengths' was not declared. Should it be static?
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Jason Yan <yanaijie@huawei.com>

Erik, Bob, this one is yours. :-)

> ---
>  drivers/acpi/acpica/exfield.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/acpica/exfield.c b/drivers/acpi/acpica/exfield.c
> index e85eb31e5075..3323a2ba6a31 100644
> --- a/drivers/acpi/acpica/exfield.c
> +++ b/drivers/acpi/acpica/exfield.c
> @@ -22,7 +22,7 @@ ACPI_MODULE_NAME("exfield")
>   */
>  #define ACPI_INVALID_PROTOCOL_ID        0x80
>  #define ACPI_MAX_PROTOCOL_ID            0x0F
> -const u8 acpi_protocol_lengths[] = {
> +static const u8 acpi_protocol_lengths[] = {
>         ACPI_INVALID_PROTOCOL_ID,       /* 0 - reserved */
>         ACPI_INVALID_PROTOCOL_ID,       /* 1 - reserved */
>         0x00,                   /* 2 - ATTRIB_QUICK */
> --
> 2.21.1
>
