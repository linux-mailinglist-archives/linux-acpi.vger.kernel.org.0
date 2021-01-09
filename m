Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0060A2EFD03
	for <lists+linux-acpi@lfdr.de>; Sat,  9 Jan 2021 03:07:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbhAICGe (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 8 Jan 2021 21:06:34 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:46330 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbhAICGd (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 8 Jan 2021 21:06:33 -0500
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id E47E5DA;
        Sat,  9 Jan 2021 03:05:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1610157951;
        bh=3C6AcKaQ28W0d8SFp8xX6ui92oKV6RZKhjeUdRjBMv4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GYob7zshPlWvmaMFxP9kUXrNy9CvKHDGpxLZtabi5UABghp+AWFnZK2IbwxemBXci
         dvWTtH6au24GQ0ofaBBmKLQeQrVB2iDwLF//5dtX95PaXtkHmXGJuOxi+cF3ibgk5X
         OqLwSaCFpikznZaUJAkDRaBytKUkWztL3Op+gWmE=
Date:   Sat, 9 Jan 2021 04:05:38 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc:     Daniel Scally <djrscally@gmail.com>, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-media@vger.kernel.org,
        devel@acpica.org, lenb@kernel.org, gregkh@linuxfoundation.org,
        mchehab@kernel.org, sergey.senozhatsky@gmail.com,
        yong.zhi@intel.com, sakari.ailus@linux.intel.com,
        bingbu.cao@intel.com, tian.shu.qiu@intel.com,
        robert.moore@intel.com, erik.kaneda@intel.com, pmladek@suse.com,
        rostedt@goodmis.org, andriy.shevchenko@linux.intel.com,
        linux@rasmusvillemoes.dk,
        laurent.pinchart+renesas@ideasonboard.com,
        jacopo+renesas@jmondi.org, kieran.bingham+renesas@ideasonboard.com,
        hverkuil-cisco@xs4all.nl, m.felsch@pengutronix.de,
        niklas.soderlund+renesas@ragnatech.se,
        prabhakar.mahadev-lad.rj@bp.renesas.com, slongerbeam@gmail.com,
        heikki.krogerus@linux.intel.com,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v5 07/15] device property: Define format macros for ports
 and endpoints
Message-ID: <X/kPck60UO/NYuRa@pendragon.ideasonboard.com>
References: <20210107132838.396641-1-djrscally@gmail.com>
 <20210107132838.396641-8-djrscally@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210107132838.396641-8-djrscally@gmail.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Rafael,

Could you please let us know with an Acked-by if this patch can be
merged through the linux-media tree for v5.12 ? The cover letter
contains additional details (in a nutshell, this is a cross-tree series
and we would like to avoid topic branches).

On Thu, Jan 07, 2021 at 01:28:30PM +0000, Daniel Scally wrote:
> OF, ACPI and software_nodes all implement graphs including nodes for ports
> and endpoints. These are all intended to be named with a common schema,
> as "port@n" and "endpoint@n" where n is an unsigned int representing the
> index of the node. To ensure commonality across the subsystems, provide a
> set of macros to define the format.
> 
> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Daniel Scally <djrscally@gmail.com>
> ---
> Changes in v5:
> 
> 	- Changed commit subject
> 
>  include/linux/fwnode.h | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
> index fde4ad97564c..77414e431e89 100644
> --- a/include/linux/fwnode.h
> +++ b/include/linux/fwnode.h
> @@ -50,6 +50,13 @@ struct fwnode_endpoint {
>  	const struct fwnode_handle *local_fwnode;
>  };
>  
> +/*
> + * ports and endpoints defined as software_nodes should all follow a common
> + * naming scheme; use these macros to ensure commonality.
> + */
> +#define SWNODE_GRAPH_PORT_NAME_FMT		"port@%u"
> +#define SWNODE_GRAPH_ENDPOINT_NAME_FMT		"endpoint@%u"
> +
>  #define NR_FWNODE_REFERENCE_ARGS	8
>  
>  /**

-- 
Regards,

Laurent Pinchart
