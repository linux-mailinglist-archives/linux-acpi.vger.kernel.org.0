Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD16958D50
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Jun 2019 23:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726502AbfF0VrC (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 27 Jun 2019 17:47:02 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:52154 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726441AbfF0VrC (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 27 Jun 2019 17:47:02 -0400
Received: from 79.184.254.216.ipv4.supernova.orange.pl (79.184.254.216) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.267)
 id db20b9a18c2deace; Thu, 27 Jun 2019 23:46:58 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH v2, resend] device property: Add helpers to count items in an array
Date:   Thu, 27 Jun 2019 23:46:58 +0200
Message-ID: <8241229.JvE1M4mS3H@kreacher>
In-Reply-To: <20190613165951.64148-1-andriy.shevchenko@linux.intel.com>
References: <20190613165951.64148-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thursday, June 13, 2019 6:59:51 PM CEST Andy Shevchenko wrote:
> The usual pattern to allocate the necessary space for an array of properties is
> to count them first by calling:
> 
>   count = device_property_read_uXX_array(dev, propname, NULL, 0);
>   if (count < 0)
> 	return count;
> 
> Introduce helpers device_property_count_uXX() to count items by supplying hard
> coded last two parameters to device_property_readXX_array().
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> ---
>  include/linux/property.h | 44 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
> 
> diff --git a/include/linux/property.h b/include/linux/property.h
> index 088d4db7e949..dbacf17fff2e 100644
> --- a/include/linux/property.h
> +++ b/include/linux/property.h
> @@ -148,6 +148,26 @@ static inline int device_property_read_u64(struct device *dev,
>  	return device_property_read_u64_array(dev, propname, val, 1);
>  }
>  
> +static inline int device_property_count_u8(struct device *dev, const char *propname)
> +{
> +	return device_property_read_u8_array(dev, propname, NULL, 0);
> +}
> +
> +static inline int device_property_count_u16(struct device *dev, const char *propname)
> +{
> +	return device_property_read_u16_array(dev, propname, NULL, 0);
> +}
> +
> +static inline int device_property_count_u32(struct device *dev, const char *propname)
> +{
> +	return device_property_read_u32_array(dev, propname, NULL, 0);
> +}
> +
> +static inline int device_property_count_u64(struct device *dev, const char *propname)
> +{
> +	return device_property_read_u64_array(dev, propname, NULL, 0);
> +}
> +
>  static inline bool fwnode_property_read_bool(const struct fwnode_handle *fwnode,
>  					     const char *propname)
>  {
> @@ -178,6 +198,30 @@ static inline int fwnode_property_read_u64(const struct fwnode_handle *fwnode,
>  	return fwnode_property_read_u64_array(fwnode, propname, val, 1);
>  }
>  
> +static inline int fwnode_property_count_u8(const struct fwnode_handle *fwnode,
> +					   const char *propname)
> +{
> +	return fwnode_property_read_u8_array(fwnode, propname, NULL, 0);
> +}
> +
> +static inline int fwnode_property_count_u16(const struct fwnode_handle *fwnode,
> +					    const char *propname)
> +{
> +	return fwnode_property_read_u16_array(fwnode, propname, NULL, 0);
> +}
> +
> +static inline int fwnode_property_count_u32(const struct fwnode_handle *fwnode,
> +					    const char *propname)
> +{
> +	return fwnode_property_read_u32_array(fwnode, propname, NULL, 0);
> +}
> +
> +static inline int fwnode_property_count_u64(const struct fwnode_handle *fwnode,
> +					    const char *propname)
> +{
> +	return fwnode_property_read_u64_array(fwnode, propname, NULL, 0);
> +}
> +
>  /**
>   * struct property_entry - "Built-in" device property representation.
>   * @name: Name of the property.
> 

Applied, thanks!



