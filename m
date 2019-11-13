Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 929D0FAE60
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Nov 2019 11:20:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbfKMKUw (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 13 Nov 2019 05:20:52 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:35383 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726107AbfKMKUv (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 13 Nov 2019 05:20:51 -0500
Received: by mail-ot1-f65.google.com with SMTP id z6so1157246otb.2;
        Wed, 13 Nov 2019 02:20:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7Lvja61wwJEkxFUoNesZ7CUJfOp6AZA3UJFpr6tZxyM=;
        b=Vahx1NVOfVngUdWpiVbr8W7QMs1jlP9JWvUBvMyttiC9/GvubEkW0+uiJUPe9tZxwG
         7dINTQlveyGH9wxuZ1ecFRwDc237Wo/kq9KHsACePsL+VXOi80zOxGOYPDJrq3w2WPe8
         HlW9zN2uwxv3Lz6GteEbLf8Bt2Vb/dT89PFnBXulIA58i1/ek/GU0pLpyixsYlVEcKoo
         o7siEm6oPxQ0V4QHjnMTrt7F+FI9mI7B/bvqHT7L3m6K9fjm9FDVP0KDG6bcZQuegrCW
         RplF6Td/GKT+rMwra1pqHLn2pjK3GVH2IBu86ZCs14ohBPUMuqLq9hGKwSh9G5dim9rp
         +/yQ==
X-Gm-Message-State: APjAAAXU3eaX7kiIe7J/PjQV5xBoodCGZlbWmqQvVW3dlQQ/DuhMfV8Y
        UEsO+dz5CnV+gR1njp4OLmVgpbN9FmpezhmuIfY=
X-Google-Smtp-Source: APXvYqx7+iaSr/YFYkN/OL/jLYa0u92ocpHWjpBLM/QT3evJcxb2dZgQ4dGsiKKKGXO464GduvcJf5QQBQnKxv9uLdE=
X-Received: by 2002:a9d:7d01:: with SMTP id v1mr2015836otn.167.1573640449727;
 Wed, 13 Nov 2019 02:20:49 -0800 (PST)
MIME-Version: 1.0
References: <20191113023559.62295-1-saravanak@google.com> <20191113023559.62295-2-saravanak@google.com>
In-Reply-To: <20191113023559.62295-2-saravanak@google.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 13 Nov 2019 11:20:38 +0100
Message-ID: <CAJZ5v0j=tpZDe5JU+tBRRmtgK=Vuj7UTzqB2Ravg-BctcP6u+Q@mail.gmail.com>
Subject: Re: [PATCH v1] driver core: Clarify documentation for fwnode_operations.add_links()
To:     Saravana Kannan <saravanak@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Nov 13, 2019 at 3:36 AM Saravana Kannan <saravanak@google.com> wrote:
>
> The wording was a bit ambiguous. So update it to make it clear.
>
> Signed-off-by: Saravana Kannan <saravanak@google.com>

Looks better with this change IMO:

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  include/linux/fwnode.h | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
>
> diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
> index 766ff9bb5876..23df37f85398 100644
> --- a/include/linux/fwnode.h
> +++ b/include/linux/fwnode.h
> @@ -94,15 +94,16 @@ struct fwnode_reference_args {
>   *             available suppliers.
>   *
>   *             Return 0 if device links have been successfully created to all
> - *             the suppliers this device needs to create device links to or if
> - *             the supplier information is not known.
> + *             the known suppliers of this device or if the supplier
> + *             information is not known.
>   *
> - *             Return -ENODEV if and only if the suppliers needed for probing
> - *             the device are not yet available to create device links to.
> + *             Return -ENODEV if the suppliers needed for probing this device
> + *             have not been registered yet (because device links can only be
> + *             created to devices registered with the driver core).
>   *
> - *             Return -EAGAIN if there are suppliers that need to be linked to
> - *             that are not yet available but none of those suppliers are
> - *             necessary for probing this device.
> + *             Return -EAGAIN if some of the suppliers of this device have not
> + *             been registered yet, but none of those suppliers are necessary
> + *             for probing the device.
>   */
>  struct fwnode_operations {
>         struct fwnode_handle *(*get)(struct fwnode_handle *fwnode);
> --
> 2.24.0.rc1.363.gb1bccd3e3d-goog
>
