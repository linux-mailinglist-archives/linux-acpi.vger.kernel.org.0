Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E62CA105350
	for <lists+linux-acpi@lfdr.de>; Thu, 21 Nov 2019 14:40:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbfKUNks (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 21 Nov 2019 08:40:48 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34265 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726574AbfKUNks (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 21 Nov 2019 08:40:48 -0500
Received: by mail-lj1-f194.google.com with SMTP id 139so3300238ljf.1
        for <linux-acpi@vger.kernel.org>; Thu, 21 Nov 2019 05:40:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eCCZXy15Ke3YP18ucAIqbA0mWkR+WxJUSl5t9RH/ZkA=;
        b=j+1m2oyq/F/jUHmrcPk5/rdBGps9GSTdgzBspP4/OUaMClsP3ukcHbu0Z7HRroZnDC
         k9fcepsG0+itsdQrbqCB+JEzPg1WyLTEXeA6qfS+2qaEOLcJwY+cx2yRaRu7vy48SpZz
         XpeB9A8/wRiqL8R+ZmocoJJxfX3olRK9euZxnRYcChRv8nQh5JS8qMkU2OWnm7ISFmCy
         Jow/ruuO2u1k0WA7AxEHfs/MWYNXpkfvbSCe498Ssw7T/+5n5Pl4rO0TKy8UVrAHelFt
         L75/Fg+IiNHaX/8DfenpUGVs4YY6oY/LB/9K6r53cwXtRQlj5lmBv1DdE4AJxQCV6AJf
         8KkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eCCZXy15Ke3YP18ucAIqbA0mWkR+WxJUSl5t9RH/ZkA=;
        b=VvPDp8x6DY1h7BJswYLhBrYwUtHrtrN2Z/GRQv4K0tcmgO+x/K9KoSvXwQbr802/X8
         wPQaeRmojYD6KD4x4gOVYeTjzB5SV88AXpr5Zo53v4fX3yFqCSfKTr75HfSUtJXHQVxR
         OGlx3fQUXZfZW6OALj54MrbWYHX8JLAUi3T5aAPHkYzymDy42SLghQQJ5V1GUpV91nNT
         6WkcBfrG00hbLdGjA27UyGCmmPiRCVqvEOy1OWNorxlkKaAYR1qQLWzx6BcVoglglXox
         e/uMttwndXzDo3zFnBb8xSKXHwWXxQMvKqW2J0CVBON1ttl+ncRQ/MFKulYzxVpJH/5T
         Cxyg==
X-Gm-Message-State: APjAAAXKuW9Oa7S29GpL2+h+bLXoqnJTDBE6Tb55JoUbTi/mjNzJlLzE
        gWN0w/X4lVLiXhzcEy4u5UA/J5xsQL1aLux8b3wJHw==
X-Google-Smtp-Source: APXvYqwojWqPLg30PlZCllqtNJPsVF7wdnwAO33m9dMefIGBlzSQsjboqg52gVh5Nn1STfX1gDwSSonm0PdkMjtWyE8=
X-Received: by 2002:a2e:161b:: with SMTP id w27mr7550745ljd.183.1574343644918;
 Thu, 21 Nov 2019 05:40:44 -0800 (PST)
MIME-Version: 1.0
References: <20191114100804.15148-1-hdegoede@redhat.com> <20191114100804.15148-2-hdegoede@redhat.com>
In-Reply-To: <20191114100804.15148-2-hdegoede@redhat.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 21 Nov 2019 14:40:33 +0100
Message-ID: <CACRpkdbksXTfaWJ2B51SWZYBf6itqYKxfUfAAtqt0hXQsUt_GQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] pinctrl: cherryview: Add GPIO <-> pin mapping
 ranges via callback
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Nov 14, 2019 at 11:08 AM Hans de Goede <hdegoede@redhat.com> wrote:

> When IRQ chip is instantiated via GPIO library flow, the few functions,
> in particular the ACPI event registration mechanism, on some of ACPI based
> platforms expect that the pin ranges are initialized to that point.
>
> Add GPIO <-> pin mapping ranges via callback in the GPIO library flow.
>
> Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Patch applied.

Yours,
Linus Walleij
