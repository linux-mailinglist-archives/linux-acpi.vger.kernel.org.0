Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEF792C4483
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Nov 2020 16:53:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731876AbgKYPx2 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 25 Nov 2020 10:53:28 -0500
Received: from mail-oo1-f66.google.com ([209.85.161.66]:41749 "EHLO
        mail-oo1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731875AbgKYPx2 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 25 Nov 2020 10:53:28 -0500
Received: by mail-oo1-f66.google.com with SMTP id i7so587001oot.8;
        Wed, 25 Nov 2020 07:53:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PNhYIgX8FOwGy2xl/K8QSb5oEiZJ1td6uMEUfwL7wx4=;
        b=QRgNpfs60ByMH6Xua7pctE78afOIWRD4QygaPAFbk2i5US50/YJfbrpdS5cC9Vx0r3
         NzeBiyBYpWunhX1UjmUC7rar7Fcbv+vqp3RJGs4XVlXwXbv7/88MIG35WoXaBaQobygK
         yXrK7JWmE3SX0lTezbSc0Lf7iRSxBu5Rgc66IlNBJ46VlqMlsU4I387EvAvSiKVU5sfk
         NMJb+1iiBDFjAk/wBz3bZg8udl4HthyVLVwevjZOGUZIaay6ZCXoEQT83YUm3KWmAL3r
         7q54GgwPDLeEIBtFLU93S2StfVquwaKk47H0zBrCBTLMl9YsQXMD2sEyse65BDtS5iT2
         7GoQ==
X-Gm-Message-State: AOAM531Q2x2jRDcKVbtuPnhGHdq4pbaqr2+fWS9aEWa2YE3uIpai42ao
        /ub1asce9OzeRMOzgVc0f/fQkCHUnPPhbN6iFDk=
X-Google-Smtp-Source: ABdhPJzmfVwwG5eqRnSGE8YKnJBW8hSugSvPbpjI9wQAduyysnYM0ilPUBlcPjpAohDu11nSefE+hFiSgjEh+8JhhO8=
X-Received: by 2002:a4a:aac4:: with SMTP id e4mr3191645oon.2.1606319607628;
 Wed, 25 Nov 2020 07:53:27 -0800 (PST)
MIME-Version: 1.0
References: <1606222266-11685-1-git-send-email-tangyouling@loongson.cn>
In-Reply-To: <1606222266-11685-1-git-send-email-tangyouling@loongson.cn>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 25 Nov 2020 16:53:16 +0100
Message-ID: <CAJZ5v0i2RYpw-rxvGWXzetiaSO34EH6x3TN5-O2npZM25Kww7w@mail.gmail.com>
Subject: Re: [PATCH] acpi: Fix use-after-free in acpi_ipmi.c
To:     Youling Tang <tangyouling@loongson.cn>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Nov 24, 2020 at 1:51 PM Youling Tang <tangyouling@loongson.cn> wrote:
>
> kfree() has been called inside put_device so anther kfree would cause a
> use-after-free bug.
>
> Signed-off-by: Youling Tang <tangyouling@loongson.cn>
> ---
>  drivers/acpi/acpi_ipmi.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/acpi/acpi_ipmi.c b/drivers/acpi/acpi_ipmi.c
> index 9d6c0fc..72902b6 100644
> --- a/drivers/acpi/acpi_ipmi.c
> +++ b/drivers/acpi/acpi_ipmi.c
> @@ -130,7 +130,6 @@ ipmi_dev_alloc(int iface, struct device *dev, acpi_handle handle)
>                                ipmi_device, &user);
>         if (err) {
>                 put_device(dev);
> -               kfree(ipmi_device);

dev doesn't point to the same object in memory as ipmi_device, though,
if I'm not mistaken.

Please double check that and resend the patch if you are sure that it
is correct.

>                 return NULL;
>         }
>         ipmi_device->user_interface = user;
> @@ -142,7 +141,6 @@ static void ipmi_dev_release(struct acpi_ipmi_device *ipmi_device)
>  {
>         ipmi_destroy_user(ipmi_device->user_interface);
>         put_device(ipmi_device->dev);
> -       kfree(ipmi_device);
>  }
>
>  static void ipmi_dev_release_kref(struct kref *kref)
> --
> 2.1.0
>
