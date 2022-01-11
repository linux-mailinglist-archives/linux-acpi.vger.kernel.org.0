Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF9448B112
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Jan 2022 16:41:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239797AbiAKPlO (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 11 Jan 2022 10:41:14 -0500
Received: from mail-qv1-f52.google.com ([209.85.219.52]:37766 "EHLO
        mail-qv1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240342AbiAKPlO (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 11 Jan 2022 10:41:14 -0500
Received: by mail-qv1-f52.google.com with SMTP id fo11so18692242qvb.4
        for <linux-acpi@vger.kernel.org>; Tue, 11 Jan 2022 07:41:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nVWe3LtF0BYJTdqqHf1HISednEA4SAbVZxMHIuyMMrg=;
        b=owSpxoZGgiKWQ+5h4t7ocvsugL097gDwvvGUENiWMV+974LaEmS4sEnt+YvSM27xPl
         xqdELPvTjwY05KajkzTQQQzN4kAqQcjIGIjfH2rR0wbNSYPfIvFJr89nJAK6aHb8D/Mg
         MVOUByVPAMmKYjKbDGoeFJl3TFcOe0a4zmCTP+McXxA1xOmK9OHSseCdcHfnSInhkXbM
         45vEpS/kFmJGrJCo7R3yKLuTA/aYWMTijvPKax0gtEVRHHgu3ptaysKruKfOiCaalRxP
         DUaYrwBe7bbUp8rHpbfM/YkoSjOGjGYoa46SA1nuCYUQHzgetSQz98x80Di6OpzzKiCI
         gY2Q==
X-Gm-Message-State: AOAM53379CBjwlBt1cBCF/ce1jwI91PcuN+xVpFXBBBdyJOHofM0+Hb2
        1BzafUEkQDnMXN881QcM/tnhCBG9rBIw+S4ypM5nDPL9
X-Google-Smtp-Source: ABdhPJy0Ub+gNZSgkZ+GrcJSaIONU1xemHOZfiL7RrGEDqINL63Y9MLdI7MmevxbZk4z6Z+NyYVYMmm/dzMB3h1BrI8=
X-Received: by 2002:a05:6214:508b:: with SMTP id kk11mr4313064qvb.61.1641915673148;
 Tue, 11 Jan 2022 07:41:13 -0800 (PST)
MIME-Version: 1.0
References: <20220105174714.15723-1-mlangsdo@redhat.com>
In-Reply-To: <20220105174714.15723-1-mlangsdo@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 11 Jan 2022 16:41:02 +0100
Message-ID: <CAJZ5v0gYKCtFLb+CtR4aSXcbhuNNY45JdosSNkcuCifjQXgU0w@mail.gmail.com>
Subject: Re: [PATCH] ACPI: SPCR: check if table->serial_port.access_width is
 too wide
To:     Mark Langsdorf <mlangsdo@redhat.com>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Jan 5, 2022 at 6:47 PM Mark Langsdorf <mlangsdo@redhat.com> wrote:
>
> If table->serial_port.access_width is more than 29, it causes
> undefined behavior when ACPI_ACCESS_BIT_WIDTH shifts it to
> (1 << ((size) + 2)):
>
> [    0.000000] UBSAN: Undefined behaviour in drivers/acpi/spcr.c:114:11
> [    0.000000] shift exponent 102 is too large for 32-bit type 'int'
>
> Use the new ACPI_ACCESS_ defines to test that serial_port.access_width
> is less than 30 and set it to 6 if it is not.
>
> Signed-off-by: Mark Langsdorf <mlangsdo@redhat.com>
> ---
>  drivers/acpi/spcr.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/spcr.c b/drivers/acpi/spcr.c
> index 25c2d0be953e..d589543875b8 100644
> --- a/drivers/acpi/spcr.c
> +++ b/drivers/acpi/spcr.c
> @@ -107,8 +107,13 @@ int __init acpi_parse_spcr(bool enable_earlycon, bool enable_console)
>                 pr_info("SPCR table version %d\n", table->header.revision);
>
>         if (table->serial_port.space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY) {
> -               switch (ACPI_ACCESS_BIT_WIDTH((
> -                       table->serial_port.access_width))) {
> +               u32 bit_width = table->serial_port.access_width;
> +
> +               if (bit_width > ACPI_ACCESS_BIT_MAX) {
> +                       pr_err("Unacceptable wide SPCR Access Width.  Defaulting to byte size\n");
> +                       bit_width = ACPI_ACCESS_BIT_DEFAULT;
> +               }
> +               switch (ACPI_ACCESS_BIT_WIDTH((bit_width))) {
>                 default:
>                         pr_err("Unexpected SPCR Access Width.  Defaulting to byte size\n");
>                         fallthrough;
> --

Applied as 5.17-rc material, thanks!
