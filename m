Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A4F49FEB8
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Aug 2019 11:41:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbfH1Jl3 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 28 Aug 2019 05:41:29 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:47566 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbfH1Jl3 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 28 Aug 2019 05:41:29 -0400
Received: from 79.184.255.249.ipv4.supernova.orange.pl (79.184.255.249) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.275)
 id 7b10398278d4b489; Wed, 28 Aug 2019 11:41:27 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: Re: [PATCH v1] device property: Remove duplicate test for NULL
Date:   Wed, 28 Aug 2019 11:41:27 +0200
Message-ID: <31368540.TH3YnxWdOO@kreacher>
In-Reply-To: <20190823203227.75639-1-andriy.shevchenko@linux.intel.com>
References: <20190823203227.75639-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Friday, August 23, 2019 10:32:27 PM CEST Andy Shevchenko wrote:
> There is no need to check twice for a NULL in fwnode_call_bool_op().
> 
> Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  include/linux/fwnode.h | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
> index a11c8c56c78b..ababd6bc82f3 100644
> --- a/include/linux/fwnode.h
> +++ b/include/linux/fwnode.h
> @@ -110,10 +110,11 @@ struct fwnode_operations {
>  	(fwnode ? (fwnode_has_op(fwnode, op) ?				\
>  		   (fwnode)->ops->op(fwnode, ## __VA_ARGS__) : -ENXIO) : \
>  	 -EINVAL)
> -#define fwnode_call_bool_op(fwnode, op, ...)				\
> -	(fwnode ? (fwnode_has_op(fwnode, op) ?				\
> -		   (fwnode)->ops->op(fwnode, ## __VA_ARGS__) : false) : \
> -	 false)
> +
> +#define fwnode_call_bool_op(fwnode, op, ...)		\
> +	(fwnode_has_op(fwnode, op) ?			\
> +	 (fwnode)->ops->op(fwnode, ## __VA_ARGS__) : false)
> +
>  #define fwnode_call_ptr_op(fwnode, op, ...)		\
>  	(fwnode_has_op(fwnode, op) ?			\
>  	 (fwnode)->ops->op(fwnode, ## __VA_ARGS__) : NULL)
> 

Applied, thanks!




