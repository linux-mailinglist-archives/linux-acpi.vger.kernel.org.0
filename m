Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 130DA43B79D
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Oct 2021 18:53:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234339AbhJZQzS (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 26 Oct 2021 12:55:18 -0400
Received: from mail-oi1-f172.google.com ([209.85.167.172]:43620 "EHLO
        mail-oi1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231967AbhJZQzO (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 26 Oct 2021 12:55:14 -0400
Received: by mail-oi1-f172.google.com with SMTP id o4so21508747oia.10;
        Tue, 26 Oct 2021 09:52:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yNZ/UOTIH4xrxWIHxjd5MYdbywWkjMFoii+8HdR5Ka0=;
        b=omTVE9wZOM8qTmzswlFnEvaJDqPcfHGK7aoUr5hkYeLO+iyJWBWlsCfUAqJ9aamORS
         AF7isdNmmtFFraRQeFVhHiF7FYRvkpZFvMdj2UCYD6scMKn1Qb2ibbSBpLy5//JKN72H
         F9415SPPDo2CbBnUM3HQ2zRPDoqipPyajSa1J87IaC09xwnlvhjGYTjpKxc77PvP2r8i
         I5cNlXUpz2+sF7vcrDIkcTBAhqbrQkCH5boNRnZu/WrFI23vpiLl7ebnppbsxJ/N4DDL
         tCipGnueN5OEtue/7d+yqTyCDHIgV/fXM3KkBXefGAS6Sz/0RjsASz/JVUgqZ/eVeY8A
         rWog==
X-Gm-Message-State: AOAM533yijqmzpnqMw8P4t1ZjccIiOJ8MBLwSLUdjmCrQ8+NMzDeRask
        2N0rnrbbBvreSxuSuVp4QGbKhiEjNI3/5USwpCE=
X-Google-Smtp-Source: ABdhPJwFzfyvlvh0F2VQsJdmVbDAk+5j0B75M2C3W7Em9cDS3TKXrXMlAIZNvNVjYYbvCvolbqwDOZZayemXY0cNgwE=
X-Received: by 2002:aca:5c5:: with SMTP id 188mr18362216oif.154.1635267170287;
 Tue, 26 Oct 2021 09:52:50 -0700 (PDT)
MIME-Version: 1.0
References: <20211026162954.89811-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20211026162954.89811-1-andriy.shevchenko@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 26 Oct 2021 18:52:39 +0200
Message-ID: <CAJZ5v0hKkwkYkBJX7nyALbp2cXohOPThV-rkSM7rzn186-2vJQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] device property: Drop redundant NULL checks
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        YE Chengfeng <cyeaa@connect.ust.hk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Oct 26, 2021 at 6:30 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> In cases when functions are called via fwnode operations,
> we already know that this is software node we are dealing
> with, hence no need to check if it's NULL, it can't be,
>
> Reported-by: YE Chengfeng <cyeaa@connect.ust.hk>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

or please let me know if I need to pick this up.

> ---
>  drivers/base/swnode.c | 6 ------
>  1 file changed, 6 deletions(-)
>
> diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
> index c46f6a8e14d2..4debcea4fb12 100644
> --- a/drivers/base/swnode.c
> +++ b/drivers/base/swnode.c
> @@ -413,9 +413,6 @@ software_node_get_name(const struct fwnode_handle *fwnode)
>  {
>         const struct swnode *swnode = to_swnode(fwnode);
>
> -       if (!swnode)
> -               return "(null)";
> -
>         return kobject_name(&swnode->kobj);
>  }
>
> @@ -507,9 +504,6 @@ software_node_get_reference_args(const struct fwnode_handle *fwnode,
>         int error;
>         int i;
>
> -       if (!swnode)
> -               return -ENOENT;
> -
>         prop = property_entry_get(swnode->node->properties, propname);
>         if (!prop)
>                 return -ENOENT;
> --
> 2.33.0
>
