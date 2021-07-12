Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 781293C624E
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Jul 2021 20:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233424AbhGLSGf (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 12 Jul 2021 14:06:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:35938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229907AbhGLSGe (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 12 Jul 2021 14:06:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BDFBA60FE9;
        Mon, 12 Jul 2021 18:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1626113026;
        bh=LkvW1JLK2NT6i1fjYtvOCiy9MWLBrAy006sVsMDFBX4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J+zXDS2kb4sDgxf6GXaH9W0z7o2xp7O64QQyQK4zRqGfQiDIj1LQVD3y1PRbJhq5B
         dGI0rHKGS2dOSX2dIgMbO/MBak3NCD2yx8CUjuaaltZzGC4WHW6w41XiuHEKx6gDOJ
         x3mgZsmdmWzBXpw26mQfooxCDqq7AT+shySBlcA8=
Date:   Mon, 12 Jul 2021 20:03:43 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Krogerus, Heikki" <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH v1 5/6] software nodes: Split software_node_notify()
Message-ID: <YOyD/4kdvd77PzLy@kroah.com>
References: <2780027.e9J7NaK4W3@kreacher>
 <5627033.MhkbZ0Pkbq@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5627033.MhkbZ0Pkbq@kreacher>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Jul 12, 2021 at 07:27:12PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Split software_node_notify_remove) out of software_node_notify()
> and make device_platform_notify() call the latter on device addition
> and the former on device removal.
> 
> While at it, put the headers of the above functions into base.h,
> because they don't need to be present in a global header file.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/base/base.h      |    3 ++
>  drivers/base/core.c      |    9 +++---
>  drivers/base/swnode.c    |   61 ++++++++++++++++++++++++-----------------------
>  include/linux/property.h |    2 -
>  4 files changed, 39 insertions(+), 36 deletions(-)
> 
> Index: linux-pm/drivers/base/swnode.c
> ===================================================================
> --- linux-pm.orig/drivers/base/swnode.c
> +++ linux-pm/drivers/base/swnode.c
> @@ -11,6 +11,8 @@
>  #include <linux/property.h>
>  #include <linux/slab.h>
>  
> +#include "base.h"
> +
>  struct swnode {
>  	struct kobject kobj;
>  	struct fwnode_handle fwnode;
> @@ -1053,7 +1055,7 @@ int device_add_software_node(struct devi
>  	 * balance.
>  	 */
>  	if (device_is_registered(dev))
> -		software_node_notify(dev, KOBJ_ADD);
> +		software_node_notify(dev);

Should this now be called "software_node_notify_add()" to match up with:

>  	if (device_is_registered(dev))
> -		software_node_notify(dev, KOBJ_REMOVE);
> +		software_node_notify_remove(dev);

The other being called "_remove"?

Makes it more obvious to me :)

thanks,

greg k-h
