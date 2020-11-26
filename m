Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC842C5701
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Nov 2020 15:23:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389606AbgKZOWm (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 26 Nov 2020 09:22:42 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:37299 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388748AbgKZOWl (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 26 Nov 2020 09:22:41 -0500
Received: by mail-ot1-f68.google.com with SMTP id l36so2008731ota.4;
        Thu, 26 Nov 2020 06:22:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l/8D9WFF6uoCxIH5bJTkTPAuqHAGOXGHPtVcJcM9tAM=;
        b=H3yBuipHmrk0iXiXfWuE5UM9xj2tJnoyx2EiIkI0XMOWV5SYBkJbPwA1qPdUy8vaoM
         bQdGqKkSSsoAN7Ag/HSX443s9GLDMDPXcypdmgWJFzm1sjLaBzkkwdnvxWz0wfdYyhki
         L9mp3XSwSGl2lG5tJ1Guu/GdTq2pDmQTcBmk6FaPdnEdnQDk2lUHXT2h7d7DxYgsPLJy
         tiJcuv+95uHL9pXm82OIz9KHtbxMh3aByUAHot4uQYq+dMl8pZncix0b8CY83hRjymjl
         CZJ+vmYajc4XNUASRz4Xmucy+hV4Y86Hu1h7oGp5ZOGP1rImbDhxGdbTc9gMlel6MEJz
         NpnQ==
X-Gm-Message-State: AOAM531uT6NiulsCxWfHpyhGsmIRYoCkjZjAP8pF0Tcv+zPUiFDqljWt
        2TVeePp2nh835G8l5TOoV82GJzv61EiWvOylAaKSbOLvd+I=
X-Google-Smtp-Source: ABdhPJys38w9OvApwAja0CkxKOfNKCnHuVh+7i3C1I1VHXg118hTb6IzbuWhGP12UBvbgjr8A1Sjx+hE+QezLuPv/9Q=
X-Received: by 2002:a05:6830:2385:: with SMTP id l5mr2435614ots.321.1606400560949;
 Thu, 26 Nov 2020 06:22:40 -0800 (PST)
MIME-Version: 1.0
References: <1606353994-10348-1-git-send-email-tangyouling@loongson.cn>
In-Reply-To: <1606353994-10348-1-git-send-email-tangyouling@loongson.cn>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 26 Nov 2020 15:22:27 +0100
Message-ID: <CAJZ5v0hbLh3EKGmy-wCvE_z_BBnWBmnyN+5onL_n2R6VK3BDdg@mail.gmail.com>
Subject: Re: [PATCH v2] acpi: Fix use-after-free in acpi_ipmi.c
To:     Youling Tang <tangyouling@loongson.cn>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Nov 26, 2020 at 2:26 AM Youling Tang <tangyouling@loongson.cn> wrote:
>
> kfree() has been called inside put_device so anther kfree would cause a
> use-after-free bug.
>
> Signed-off-by: Youling Tang <tangyouling@loongson.cn>
> ---
>  drivers/acpi/acpi_ipmi.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/acpi/acpi_ipmi.c b/drivers/acpi/acpi_ipmi.c
> index 9d6c0fc..18edf8b 100644
> --- a/drivers/acpi/acpi_ipmi.c
> +++ b/drivers/acpi/acpi_ipmi.c
> @@ -142,7 +142,6 @@ static void ipmi_dev_release(struct acpi_ipmi_device *ipmi_device)
>  {
>         ipmi_destroy_user(ipmi_device->user_interface);
>         put_device(ipmi_device->dev);

Does putting ipmi_device->dev (which is a different object than
ipmi_device itself) really cause ipmi_device to be freed
automatically?  If not, the change below will introduce a memory leak.

> -       kfree(ipmi_device);
>  }
>
>  static void ipmi_dev_release_kref(struct kref *kref)
> --
