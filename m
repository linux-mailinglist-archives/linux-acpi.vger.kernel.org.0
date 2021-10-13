Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55CE942C820
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Oct 2021 19:55:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbhJMR5I convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Wed, 13 Oct 2021 13:57:08 -0400
Received: from mail-ot1-f52.google.com ([209.85.210.52]:38418 "EHLO
        mail-ot1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbhJMR5H (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 13 Oct 2021 13:57:07 -0400
Received: by mail-ot1-f52.google.com with SMTP id w10-20020a056830280a00b0054e4e6c85a6so4780291otu.5;
        Wed, 13 Oct 2021 10:55:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=oS3tMYHzB7LhB21Ic4iFAEOKCEF426yFBlRc491FDVE=;
        b=bS1QnvHNDV1hWsmQImjR+WKgZtCPdVQqmXYvqehOgy4x70qp/O94GbDevAkEgvAiH3
         6qF9KeDs0UQBe6JvevBScZN3zNUkHU5pY5N0qlnJ2W/QcOaz6n/nM+niaurBgdT/4MC5
         rvhF5UcytNmTbhS2CrDMZHGoRlMFGuWrn1jxeQumxypA2CM2j9ohS+39x0CE+ydlpugr
         TscrWz/7R6Bf97MgOc3vDTxa0oE0t3mdVbp4aZoBi+Cfc4nK1x9ETaW1fGGVTKY5+LaF
         F/56FZA96RX09d6inIuYTo84aLPnVo1kvjSPYRiiSmPuDCyTD01DG8Bto3U9JjHRZgFB
         lsvA==
X-Gm-Message-State: AOAM530J0l5yyI8kvsMbgq6hlHiFz1LqDlhL8VruX2LCXd9XIZQ53IRY
        nnVT3eLw18HFEdrN2xYAvKVF5rbwEHZ9wjy/g5s=
X-Google-Smtp-Source: ABdhPJzo9m/b83+CS3TFJMoqXcf1bcknV7vPQPCh3AZV1zoL87Yr+8nBVtdGk3hoZs6BhxqwcM32pvXFO+ipCNGfi0c=
X-Received: by 2002:a05:6830:1af0:: with SMTP id c16mr546149otd.16.1634147703297;
 Wed, 13 Oct 2021 10:55:03 -0700 (PDT)
MIME-Version: 1.0
References: <20211008030529.223682-1-andrealmeid@collabora.com>
 <20211008030529.223682-2-andrealmeid@collabora.com> <20211013113359.redeyos4bc4p5pen@earth.universe>
In-Reply-To: <20211013113359.redeyos4bc4p5pen@earth.universe>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 13 Oct 2021 19:54:52 +0200
Message-ID: <CAJZ5v0h0BonJCrOm7PnK66JpnbLgsBTmL-RefGPhi=6mZC--gQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] acpi: battery: Accept charges over the design
 capacity as full
To:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@collabora.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        krisman@collabora.com,
        "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>,
        Hans de Goede <hdegoede@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Oct 13, 2021 at 1:34 PM Sebastian Reichel
<sebastian.reichel@collabora.com> wrote:
>
> Hi,
>
> On Fri, Oct 08, 2021 at 12:05:29AM -0300, André Almeida wrote:
> > Some buggy firmware and/or brand new batteries can support a charge that's
> > slightly over the reported design capacity. In such cases, the kernel will
> > report to userspace that the charging state of the battery is "Unknown",
> > when in reality the battery charge is "Full", at least from the design
> > capacity point of view. Make the fallback condition accepts capacities
> > over the designed capacity so userspace knows that is full.
> >
> > Signed-off-by: André Almeida <andrealmeid@collabora.com>
> > ---
> >  drivers/acpi/battery.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
> > index dae91f906cea..8afa85d6eb6a 100644
> > --- a/drivers/acpi/battery.c
> > +++ b/drivers/acpi/battery.c
> > @@ -169,7 +169,7 @@ static int acpi_battery_is_charged(struct acpi_battery *battery)
> >               return 1;
> >
> >       /* fallback to using design values for broken batteries */
> > -     if (battery->design_capacity == battery->capacity_now)
> > +     if (battery->design_capacity <= battery->capacity_now)
> >               return 1;
> >
> >       /* we don't do any sort of metric based on percentages */
>
> Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Applied as 5.16 material, thanks!
