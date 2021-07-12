Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36C773C62A6
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Jul 2021 20:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233456AbhGLSd2 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 12 Jul 2021 14:33:28 -0400
Received: from mail-oo1-f49.google.com ([209.85.161.49]:38408 "EHLO
        mail-oo1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235896AbhGLSd2 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 12 Jul 2021 14:33:28 -0400
Received: by mail-oo1-f49.google.com with SMTP id 128-20020a4a11860000b029024b19a4d98eso4751347ooc.5;
        Mon, 12 Jul 2021 11:30:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xKrseyYc1Gbw05E0Nye9XfJ0bvWgcnYYHkIdcR15OXI=;
        b=ZpxKpk83fas8++i/dQE6je6HNuIrR4Pw34oJMw6MjYmfG7Td5LBAqn5AE0EwqwRW+N
         nBNY5duc+KS8jLxuN4ZkJzh5ph6EpCXdLZUXZWmge0XfdN6fkeVty2ZOSLMD8F8a4PTL
         sAygiMXFKAOBegPlMmvM7lYA0XFSzcmlOai7EjNqQ6HJcxsZ8ObZoQX4QzeFAqr/AKC2
         PcU6WU+n45z0REl/XYZ6GT6lMsOzCrocNVUqYX+cp9g2QrbVdwglaaVzX1MbRHHTOeVW
         s1ApkvIdBJ0ggCDAIwqs1wkusuj/PTYRo0ya0EWJUXGjcMo+WzgEX+7G34hDYcrZKt/N
         2W6g==
X-Gm-Message-State: AOAM531i7fhBalro2+VFhBhHt+THQWtbkiNFUJMCwJ/y2J7HSpYpc7sy
        BmouNUogp9+9lzVze+9YNtjpDH5eRiCzNzncfyY=
X-Google-Smtp-Source: ABdhPJwBlYr+nUyx4NsW3xaarbwoII/Yd/qdXdYDJd9jLPdD9OyMUBFJIa7rE6vdmgrZmiodZPncsbwUIjKWsuI52lg=
X-Received: by 2002:a4a:55cd:: with SMTP id e196mr463755oob.2.1626114639087;
 Mon, 12 Jul 2021 11:30:39 -0700 (PDT)
MIME-Version: 1.0
References: <2780027.e9J7NaK4W3@kreacher> <7971483.NyiUUSuA9g@kreacher> <YOyEE4vasE1Daf0H@kroah.com>
In-Reply-To: <YOyEE4vasE1Daf0H@kroah.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 12 Jul 2021 20:30:28 +0200
Message-ID: <CAJZ5v0geANvWU=mbUSzBWx51oiSTSe5vE7-1aLq3SMUhNUcHtw@mail.gmail.com>
Subject: Re: [PATCH v1 6/6] driver core: Split device_platform_notify()
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Krogerus, Heikki" <heikki.krogerus@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Jul 12, 2021 at 8:04 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Mon, Jul 12, 2021 at 07:28:16PM +0200, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Split device_platform_notify_remove) out of device_platform_notify()
> > and call the latter on device addition and the former on device
> > removal.
> >
> > No intentional functional impact.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  drivers/base/core.c |   37 +++++++++++++++++--------------------
> >  1 file changed, 17 insertions(+), 20 deletions(-)
>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Thank you!
