Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 528BA440E7D
	for <lists+linux-acpi@lfdr.de>; Sun, 31 Oct 2021 13:58:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbhJaNAd (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 31 Oct 2021 09:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbhJaNAc (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 31 Oct 2021 09:00:32 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0723C061570;
        Sun, 31 Oct 2021 05:58:00 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 1so19037274ljv.2;
        Sun, 31 Oct 2021 05:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TA6d7M3LHM9SuI1wIVm/Ylw65AVnuTrxrE8hG0L+h/w=;
        b=lgzkHqpL3OhYUvqaqGnsAh6hh3upxZRGVjXQESDsstM3PbOEluLZvHaae+2vY35gZT
         L0tZ7+uuJ1N+JWUn9a2D35FGntkRnskt2kCSyejPOflQg6cHHPORIZG27DUyRYT02aa8
         jNd07Dk5/QI5ukbaUGUj4Tw7v+HBvGyszcps6hqVJugdZZdfUVUpYdWXrCZGP4q6AdKq
         YgTc7zyaPMvXVmJMgAw/19Rh1J6za6D1bvRO1gN4E4EfoDPhWj5sTO5Kxk9QjZ+pYL+M
         16OUPHL2ymRDH5hSPEpNSvD9g3JiRSUbVO2WpAnM9aBMTSCj2PF4sKKRxmAriKAVe9Lo
         c8Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TA6d7M3LHM9SuI1wIVm/Ylw65AVnuTrxrE8hG0L+h/w=;
        b=Uuf8ousGTXk3EluJfTgHwk37HIKvi19KiHcLgv4/dFSxwdlYVd08JaCIrk/JWx7mtt
         +cO2Mr7CSTdHhMXaUKPyRZgEKhVtUKcEEEllsIBCx2wurla3tCEJzo9/J6Zm/9I80zxf
         C6LOsYHX+mmy3vx6t8i2pkbkMVlfzSvzRfqyZRNlvaFVCS+BiJ70YWJoOREk2UV2PJNy
         rEeem1alEZPmOBvEzHLXfp9s2HvKdfZjEIbTeAcN7VbEo6QK6KYwFskxr5o8brC0Han6
         0NgofkOKw+YqYIJl13e2m6mKYCRCuxl/N3B8tcWYgLZ68IuyWHdxqgV44PkZdiAGGLLd
         +/fQ==
X-Gm-Message-State: AOAM533Tyk2mil29tFEK1b0qwiOTPigEV/6QalJ7gu0F6lOFFhy9Kbvg
        qcRdUHpYChaQbTyQALf+GtKgVCW4wxRsw/NtkjY=
X-Google-Smtp-Source: ABdhPJwZt88JpwfFKC89QrKsOUKDOwUvKeT3ezfPpc1Z4mfC8xGn5XutAUvCcpuivonNsY+SeRGNhGHzYHFriQHVwHo=
X-Received: by 2002:a2e:8605:: with SMTP id a5mr25591487lji.107.1635685079348;
 Sun, 31 Oct 2021 05:57:59 -0700 (PDT)
MIME-Version: 1.0
References: <20211031090208.6564-1-hdegoede@redhat.com>
In-Reply-To: <20211031090208.6564-1-hdegoede@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 31 Oct 2021 14:57:23 +0200
Message-ID: <CAHp75Ve5zUxsB4L613FEE=2cPK8XopLYVC7Ew5Z23r2Xqq-cyA@mail.gmail.com>
Subject: Re: [PATCH] power: supply: bq27xxx: Fix kernel crash on IRQ handler
 register error
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Sebastian Reichel <sre@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Andrew F . Davis" <afd@ti.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sun, Oct 31, 2021 at 11:07 AM Hans de Goede <hdegoede@redhat.com> wrote:
>
> When registering the IRQ handler fails, do not just return the error code,
> this will free the devm_kalloc-ed data struct while leaving the queued

devm_kzalloc()-ed?

(main point is z/m/etc in the function name)

> work queued and the registered power_supply registered with both of them
> now pointing to free-ed memory, resulting in various kernel crashes
> soon afterwards.
>
> Instead properly tear-down things on IRQ handler register errors.


-- 
With Best Regards,
Andy Shevchenko
