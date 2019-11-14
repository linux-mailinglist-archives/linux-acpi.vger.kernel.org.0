Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0E8DFCCEF
	for <lists+linux-acpi@lfdr.de>; Thu, 14 Nov 2019 19:16:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbfKNSQr (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 14 Nov 2019 13:16:47 -0500
Received: from mail-oi1-f179.google.com ([209.85.167.179]:42109 "EHLO
        mail-oi1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbfKNSQr (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 14 Nov 2019 13:16:47 -0500
Received: by mail-oi1-f179.google.com with SMTP id i185so6142120oif.9
        for <linux-acpi@vger.kernel.org>; Thu, 14 Nov 2019 10:16:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wvqurK7a932jk70RwRxJ5ZW5KyXSIqlC/BqkNRUD8ss=;
        b=LuEqP0sfMUaQJHbFyQ31n8LGkDc7RiegU5z2PDFCR00oANR64rqVeYQhwiwNRY717c
         4NwpMuqxGiUCCn0AM2yVLt2sT+vZWo+/5JeIic/VNHyR446vR3Qe0KpGPseRtpLLd7lt
         LdQVYQTCfn13xxSeT5naDclSxMqalQ61Y11lhPYUuvmgZ+XyGGdtsa+ckI/oCILEp0XL
         xiKgqCKnIo/Z5RJmsm04uILdplYDX4IhMYzZznrmgs7tgZhWXbVfcLuuAURLKeYsKGMr
         WzxGYzOvPmo1w3Df0fEIrcQmQD/7X1xTxhMx1MBwRY2pcVxmQJHPIPWGKD6iQUJgITZE
         fEsw==
X-Gm-Message-State: APjAAAV9mQlCyjsD+SMhTK3lOl+7fTJoLI5YfEFHnQMSnnkCnaNn/RGs
        7/EFUcZgR9hMUXS6MBegWdrLUYPzXr5DV8qql5A=
X-Google-Smtp-Source: APXvYqzTQW05rjxeEx4ZjriQSyyTFpbjzOOLeCArfYKKX9takpXv9z2UY9MsZkv+XYUWSjj2x662v83XL8jSXpfUKz8=
X-Received: by 2002:a05:6808:901:: with SMTP id w1mr4712328oih.57.1573755406471;
 Thu, 14 Nov 2019 10:16:46 -0800 (PST)
MIME-Version: 1.0
References: <b509514b-f831-4288-9852-25385da45c9c@www.fastmail.com>
 <CAJZ5v0iZ9pR8ou95q2kQnawWWmuOqpnEivRVx4H12sa4FGveSg@mail.gmail.com>
 <cd3bd414-50c8-4751-8370-6a17b3b338f6@www.fastmail.com> <CAJZ5v0hN2PrFUQkWtTB2DfDVtyGubS+iPRU7WA1wM--1R+N7kQ@mail.gmail.com>
 <2a86e8b1-c631-4705-885e-779997589751@www.fastmail.com>
In-Reply-To: <2a86e8b1-c631-4705-885e-779997589751@www.fastmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 14 Nov 2019 19:16:35 +0100
Message-ID: <CAJZ5v0hzwsuxZUKc-QdxwOnJ6xmVHBccg2ubaOYUmhnPMQKEAQ@mail.gmail.com>
Subject: Re: how to disable the "button" kernel module?
To:     Bruno Dantas <kernel@dantas.airpost.net>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Nov 14, 2019 at 4:58 PM Bruno Dantas <kernel@dantas.airpost.net> wrote:
>
> > Anyway, you can try to echo the lid device name to
> > /sys/bus/acpi/drivers/button/unbind to unbind the button driver from
> > the lid device.
> >
> > That name should be something like PNP0C0D:00 (note that you need to
> > escape the colon when in a shell).
>
> Thank you, Rafael. I've tried that, but some applications (e.g., xscreensaver) are still somehow able to detect the lid switch state. In the case of xscreensaver, it still refuses to start playing the video animations if the lid is closed.
>
> > I wonder why?
> >
> If the driver is unbinded, how can an application possibly know the lid switch state?

I don't know.

You can try to unbind all devices handled by the button driver and see
if that makes any difference.  That would be as good as unloading it.

> I asked the xscreensaver developer how his application queries the lid switch state and he said that it doesn't. So there you have it--there's some voodoo going on.

If the panel is automatically turned off by the platform when closing
the lid, the GPU driver will see that and may notify user space in
theory.  I'm not a GPU expert, though.

> I have two toddlers and a baby that crawl around, so I often have to close the laptop lid during
> long-running commands to keep the kids from pressing random keys and wreaking havoc.
> If I can't predict the effect that closing the lid will have on applications, I would like to completely disable it.
>
> (I'd disable the lid switch at the level of the BIOS if I could, but I use Libreboot and this is not an option AFAIK.)

You can definitely prevent the button driver from handling any events
(by unbinding it from all devices that it is bound to), but that may
not be sufficient for what you want to achieve.
