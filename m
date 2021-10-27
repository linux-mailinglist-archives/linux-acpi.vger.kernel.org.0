Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF1B843CD36
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Oct 2021 17:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238032AbhJ0PPO (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 27 Oct 2021 11:15:14 -0400
Received: from mail-oi1-f181.google.com ([209.85.167.181]:39494 "EHLO
        mail-oi1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236706AbhJ0PPO (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 27 Oct 2021 11:15:14 -0400
Received: by mail-oi1-f181.google.com with SMTP id s190so3073663oie.6;
        Wed, 27 Oct 2021 08:12:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vzqpbg4IN60rjb+VTJsYtCoIP/kbPBOABnpW5V5iDJ8=;
        b=X/pPy4FFa9htWjHjGgY8xRsHjTguBnfWsxq6dcl1RVQxQztMzCWLEqCXhfe5BsHiJe
         oR7gyAM0/CoBZfAc2Wzbi0QzbYpxTTizvTmVZG0IRLnhlKFtv2cAlyoVGMmKJoYIlgIe
         7tXdBMMLwkN9874s1beUNgq7Fuz+4o9D7MrgxTsk8PjSfQJXdX/HErvLilrG7t2mDoZj
         2DN6chJJOxF3P/Po4PVWM3wXJFuG0Kx7i59j9LvzurBVVGV6NDSJuQ+sAMNET8FTNyZM
         auxuQYkhRonpyi5ykvCyaGsnCfszqv2eDUwZKMS5XV7tYeIbUh3EVLNVjyVxDiqAU1c/
         p9uA==
X-Gm-Message-State: AOAM5302oCwnmG8O+jFakin6voPdgjR5KoT7wZyKJjfWcdO73OcoZ2kY
        pzpjTMe67EfOmSb/w7a0TeIxiiN8weFSQQpyVok=
X-Google-Smtp-Source: ABdhPJzqnHuBY7IrOfOgtphvHFZdZCMYbu9OGOF93TELQ9LyW+c/FKrh01o8Fzss/0xCaLjq2Z7Ggqq7aSqpINB2sSA=
X-Received: by 2002:aca:5c5:: with SMTP id 188mr3995145oif.154.1635347568493;
 Wed, 27 Oct 2021 08:12:48 -0700 (PDT)
MIME-Version: 1.0
References: <20211026171313.50-1-mario.limonciello@amd.com> <CACRpkdYAv5w5AfKPQgCqXgKSYnS7wvCkE3qTj_Q9hyvOS=xsvQ@mail.gmail.com>
In-Reply-To: <CACRpkdYAv5w5AfKPQgCqXgKSYnS7wvCkE3qTj_Q9hyvOS=xsvQ@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 27 Oct 2021 17:12:37 +0200
Message-ID: <CAJZ5v0hZxtdYw9-NbSXtROn0kROG3D6V2u7TAaHTW5ccz_i9hA@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] ACPI: Add stubs for wakeup handler functions
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Mario Limonciello <mario.limonciello@amd.com>,
        Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        "open list:PIN CONTROL SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Nehal Shah <Nehal-bakulchandra.Shah@amd.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Oct 27, 2021 at 12:11 AM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Tue, Oct 26, 2021 at 7:13 PM Mario Limonciello
> <mario.limonciello@amd.com> wrote:
>
> > The commit ddfd9dcf270c ("ACPI: PM: Add acpi_[un]register_wakeup_handler()")
> > added new functions for drivers to use during the s2idle wakeup path, but
> > didn't add stubs for when CONFIG_ACPI wasn't set.
> >
> > Add those stubs in for other drivers to be able to use.
> >
> > Fixes: ddfd9dcf270c ("ACPI: PM: Add acpi_[un]register_wakeup_handler()")
> > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>
> I need an ACK from an ACPI maintainer to take this with the
> other fix into the pinctrl tree.

There you are:

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
