Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88D6A3A9EA4
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Jun 2021 17:11:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234460AbhFPPNU (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 16 Jun 2021 11:13:20 -0400
Received: from mail-ot1-f43.google.com ([209.85.210.43]:35379 "EHLO
        mail-ot1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234390AbhFPPNU (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Jun 2021 11:13:20 -0400
Received: by mail-ot1-f43.google.com with SMTP id 7-20020a9d0d070000b0290439abcef697so2829483oti.2;
        Wed, 16 Jun 2021 08:11:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2tNS+SX5Cd8wquTO79BQgrSrDCQz8oAeXDAIQqfgP9w=;
        b=FBGPHekCfkTbffym0CKdWpW00Lsjrbg2DF7gTpJKrKkRtwfrXtVi9f6UkNZSstj8Zu
         UquI+360IOZ+uEXontHo8mVIRvQVWug/QvHgLmgCFhb97m+dXUV+5Zr9rfS+eUGO8MtM
         6uxDyDEPOEfn/22IfJF15ijfM4iHAHx4cAYeJ0P5+MMtyYPGMWiEGNjv2IiWnbGY2YuC
         pVMV32Wyy19cNSWSJZxCmvSIpVqvGrszwElXO/t02MqM3rb52CD5nC43iVLtss2CLtzw
         +T+VCJbKrCjQRINjhMekGdb+bq80Bre8l2HCf/oQkp30ZXL3JwZfkNpf7aUuQDjwOs75
         piBQ==
X-Gm-Message-State: AOAM533xPYIenS4/Ji24JLl65uiPuecFc+SDdPJSw7koyS/yOkscwyBD
        FYECrQ5yNpXXTTb/XiqtzJpFEPJ/MX/S2AUqXIhg4WRV42A=
X-Google-Smtp-Source: ABdhPJwehP1inuW1Dc4CyJMV2hvjrf+MTLtwOr0SDgd++yvba1nGLRNPyJTHl//2TodfscIcIm7CNKLAGts2vH/vRj4=
X-Received: by 2002:a9d:6c4d:: with SMTP id g13mr302741otq.321.1623856273053;
 Wed, 16 Jun 2021 08:11:13 -0700 (PDT)
MIME-Version: 1.0
References: <3140195.44csPzL39Z@kreacher> <1881350.PYKUYFuaPT@kreacher> <f46533e2-1ebe-0130-9323-b045da6ea62d@redhat.com>
In-Reply-To: <f46533e2-1ebe-0130-9323-b045da6ea62d@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 16 Jun 2021 17:11:01 +0200
Message-ID: <CAJZ5v0gZ2Fbff_g_v8t46-957=U_1nGe22sP9W=Hc-dohG8=Jg@mail.gmail.com>
Subject: Re: [PATCH 2/5] ACPI: scan: Make acpi_walk_dep_device_list()
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Jun 16, 2021 at 4:41 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 6/16/21 4:22 PM, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Because acpi_walk_dep_device_list() is only called by the code in the
> > file in which it is defined, make it static, drop the export of it
> > and drop its header from acpi.h.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Actually, acpi_walk_dep_device_list() was split out as a
> helper function used to implement acpi_dev_clear_dependencies()
> because it will be used outside of drivers/acpi.

Not exactly.

> Specifically it will be used in the new intel_skl_int3472 driver:
> https://patchwork.kernel.org/project/platform-driver-x86/patch/20210603224007.120560-6-djrscally@gmail.com/

That driver will use acpi_dev_get_first_consumer_dev() which is based
on acpi_walk_dep_device_list(), but still defined in
drivers/acpi/scan.c.

> Which I plan to merge into pdx86/for-next today, I've just merged
> your linux-pm/acpi-scan PULL-req which exports acpi_walk_dep_device_list()
> as preparation for this.

No, the acpi_walk_dep_device_list() is a leftover there AFAICS.

If it needs to be exported in the future, that still can be done.  ATM
the export isn't necessary.

Thanks!
