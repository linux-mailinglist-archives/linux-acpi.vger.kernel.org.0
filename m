Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D8DB3C62B8
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Jul 2021 20:38:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235550AbhGLSlR (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 12 Jul 2021 14:41:17 -0400
Received: from mail-ot1-f51.google.com ([209.85.210.51]:40556 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbhGLSlR (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 12 Jul 2021 14:41:17 -0400
Received: by mail-ot1-f51.google.com with SMTP id v32-20020a0568300920b02904b90fde9029so5248382ott.7;
        Mon, 12 Jul 2021 11:38:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OfP+6Rrz6prKhoktB8ixeQydnflXhUAdxrSN54Ktda8=;
        b=UV5oY51P1Ig8+GehKVnSzw74BAy8AdzUFI0ciNInDyD1HgqSX1WYIxwj5nbGy29iVS
         KStDGIlZPirsvdl31YrsD36xI+m6xqxFYjU5bsWORUnJ9eamrpFRJ3pHNCmZ35aTlOEJ
         EHfDQcLhgnpzVqyGGw2jL75E5toDCUs7PLR/cR3fR108tO3e7OvYhc/ehoe9ol/Ch4+y
         NMSc2GDgIoSZiMNeg3vW3lZfyT/PPiRto1A0PZe3AoboPMv9i8k2i/o7ryS4LBvPEKYv
         QA4QROmoa6uBeDQAUbdwBIzxe5DsYQ+Lfl98eJC1tmg+9a65nWp6F1bui+6LPAAM5MMe
         Lduw==
X-Gm-Message-State: AOAM5325fcSe7Y76OqJ1WPWSCD9/jBnU49nDh3smLSucb/40J7Wgay2Z
        TSS8lLCcUT6km+sqfH8doyfiS2koqZYtnC80Knc=
X-Google-Smtp-Source: ABdhPJxg7KyxFQDe8hxq4zei6XKoc19bFdHy2c0MLDj+pJsPh2K6KXNkl5ghnbX+CB0zpu9/iQsORBXoUh02bs3VdAM=
X-Received: by 2002:a9d:604e:: with SMTP id v14mr327437otj.260.1626115108554;
 Mon, 12 Jul 2021 11:38:28 -0700 (PDT)
MIME-Version: 1.0
References: <2780027.e9J7NaK4W3@kreacher> <8790139.CDJkKcVGEf@kreacher> <YOyLj4/s9Sclo/Wl@smile.fi.intel.com>
In-Reply-To: <YOyLj4/s9Sclo/Wl@smile.fi.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 12 Jul 2021 20:38:17 +0200
Message-ID: <CAJZ5v0jF=T2djhVT0ZY0hdThez=S7w6XeJfnBz38HfO2FXQcKw@mail.gmail.com>
Subject: Re: [PATCH v1 4/6] ACPI: glue: Eliminate acpi_platform_notify()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Krogerus, Heikki" <heikki.krogerus@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Jul 12, 2021 at 8:36 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Mon, Jul 12, 2021 at 07:25:55PM +0200, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Get rid of acpi_platform_notify() which is redundant and
> > make device_platform_notify() in the driver core call
> > acpi_device_notify() and acpi_device_notify_remove() directly.
>
> > +     if (action == KOBJ_ADD)
> > +             acpi_device_notify(dev);
> > +     else if (action == KOBJ_REMOVE)
> > +             acpi_device_notify_remove(dev);
>
> In most of the cases we are using switch-case approach with
> KOBJ_ADD/KOBJ_REMOVE. Would it make sense to keep that pattern?

Well, this goes away in the next patches anyway.
