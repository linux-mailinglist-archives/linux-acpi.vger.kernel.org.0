Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1745FF09B9
	for <lists+linux-acpi@lfdr.de>; Tue,  5 Nov 2019 23:43:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730274AbfKEWnR (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 5 Nov 2019 17:43:17 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:44080 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730054AbfKEWnR (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 5 Nov 2019 17:43:17 -0500
Received: from 79.184.254.83.ipv4.supernova.orange.pl (79.184.254.83) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.292)
 id a9bbc4ee93b8efe5; Tue, 5 Nov 2019 23:43:13 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Len Brown <lenb@kernel.org>, kernel-team@android.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH v1 3/5] driver core: Allow fwnode_operations.add_links to differentiate errors
Date:   Tue, 05 Nov 2019 23:43:08 +0100
Message-ID: <7640808.4Pc6YCm0Y9@kreacher>
In-Reply-To: <20191028220027.251605-4-saravanak@google.com>
References: <20191028220027.251605-1-saravanak@google.com> <20191028220027.251605-4-saravanak@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Monday, October 28, 2019 11:00:24 PM CET Saravana Kannan wrote:
> When add_links() still has suppliers that it needs to link to in the
> future, this patch allows it to differentiate between suppliers that are
> needed for probing vs suppliers that are needed for sync_state()
> correctness.

I guess you mean that it will return different error codes in the different
cases.

> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
>  drivers/base/core.c    | 12 ++++++++----
>  include/linux/fwnode.h | 13 +++++++++----
>  2 files changed, 17 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 48cd43a91ce6..e6d3e6d485da 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -2297,7 +2297,7 @@ int device_add(struct device *dev)
>  	struct device *parent;
>  	struct kobject *kobj;
>  	struct class_interface *class_intf;
> -	int error = -EINVAL;
> +	int error = -EINVAL, fw_ret;
>  	struct kobject *glue_dir = NULL;
>  
>  	dev = get_device(dev);
> @@ -2413,9 +2413,13 @@ int device_add(struct device *dev)
>  	 */
>  	device_link_add_missing_supplier_links();
>  
> -	if (fwnode_has_op(dev->fwnode, add_links)
> -	    && fwnode_call_int_op(dev->fwnode, add_links, dev))
> -		device_link_wait_for_mandatory_supplier(dev, true);
> +	if (fwnode_has_op(dev->fwnode, add_links)) {

fw_ret can be defined here and I'd just call it "ret".

> +		fw_ret = fwnode_call_int_op(dev->fwnode, add_links, dev);
> +		if (fw_ret == -ENODEV)
> +			device_link_wait_for_mandatory_supplier(dev);
> +		else if (fw_ret)
> +			device_link_wait_for_optional_supplier(dev);
> +	}
>  
>  	bus_probe_device(dev);
>  	if (parent)
> diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
> index 25bb81f8ded8..a19134eae5a5 100644
> --- a/include/linux/fwnode.h
> +++ b/include/linux/fwnode.h
> @@ -96,10 +96,15 @@ struct fwnode_reference_args {
>   *		available suppliers.
>   *
>   *		Return 0 if device links have been successfully created to all
> - *		the suppliers of this device or if the supplier information is
> - *		not known. Return an error if and only if the supplier
> - *		information is known but some of the suppliers are not yet
> - *		available to create device links to.
> + *		the suppliers this device needs to create device links to or if
> + *		the supplier information is not known.

"the known suppliers of this device or if the supplier information is not known."

> + *
> + *		Return -ENODEV if and only if the suppliers needed for probing
> + *		the device are not yet available to create device links to.

It would be more precise to say something like this:

"Return -ENODEV if an attempt to create a device link to one of the device's
suppliers needed for probing it fails."

> + *
> + *		Return -EAGAIN if there are suppliers that need to be linked to
> + *		that are not yet available but none of those suppliers are
> + *		necessary for probing this device.

"Return -EAGAIN if attempts to create device links to some of the device's
suppliers have failed, but those suppliers are not necessary for probing the
device."

>   */
>  struct fwnode_operations {
>  	struct fwnode_handle *(*get)(struct fwnode_handle *fwnode);
> 




