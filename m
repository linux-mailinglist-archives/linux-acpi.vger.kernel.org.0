Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05C0A21CA90
	for <lists+linux-acpi@lfdr.de>; Sun, 12 Jul 2020 19:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729133AbgGLRJu (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 12 Jul 2020 13:09:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:34170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728844AbgGLRJu (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sun, 12 Jul 2020 13:09:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8DFDF20702;
        Sun, 12 Jul 2020 17:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594573790;
        bh=a848+2Ogmip7OA1pq5ZWFjhMfOh9SLYFsM119KDBbhQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OZqzQZEoZxSAGSrZFfXjXZQUtkypTiKs2Oet5qlnQPBEPa6ZT4u2d206gYnjrbJlG
         BxemuBXiEumBOik0eAXItqnjOv/68W9VGr6zWzI0KQhtqMhYMb+hxYxeobXV6CpOk6
         myjlUwl2om3T4Vi71OVbj9wKlmHuif0siks+8bGo=
Date:   Sun, 12 Jul 2020 19:09:45 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-nvdimm@lists.01.org, "Rafael J. Wysocki" <rafael@kernel.org>,
        peterz@infradead.org, vishal.l.verma@intel.com,
        dave.hansen@linux.intel.com, ard.biesheuvel@linaro.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, hch@lst.de, joao.m.martins@oracle.com
Subject: Re: [PATCH v2 17/22] drivers/base: Make device_find_child_by_name()
 compatible with sysfs inputs
Message-ID: <20200712170945.GA194499@kroah.com>
References: <159457116473.754248.7879464730875147365.stgit@dwillia2-desk3.amr.corp.intel.com>
 <159457125753.754248.6000936585361264069.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <159457125753.754248.6000936585361264069.stgit@dwillia2-desk3.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sun, Jul 12, 2020 at 09:27:37AM -0700, Dan Williams wrote:
> Use sysfs_streq() in device_find_child_by_name() to allow it to use a
> sysfs input string that might contain a trailing newline.
> 
> The other "device by name" interfaces,
> {bus,driver,class}_find_device_by_name(), already account for sysfs
> strings.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/base/core.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 67d39a90b45c..5d31b962c898 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -3078,7 +3078,7 @@ struct device *device_find_child_by_name(struct device *parent,
>  
>  	klist_iter_init(&parent->p->klist_children, &i);
>  	while ((child = next_device(&i)))
> -		if (!strcmp(dev_name(child), name) && get_device(child))
> +		if (sysfs_streq(dev_name(child), name) && get_device(child))

Who wants to call this function with a name passed from userspace?

Not objecting to it, just curious...

thanks,

greg k-h
