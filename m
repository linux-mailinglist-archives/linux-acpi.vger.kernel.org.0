Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B89E2F07E7
	for <lists+linux-acpi@lfdr.de>; Sun, 10 Jan 2021 16:09:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbhAJPJB (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 10 Jan 2021 10:09:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:38338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726929AbhAJPJB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sun, 10 Jan 2021 10:09:01 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 06CCB22AAC;
        Sun, 10 Jan 2021 15:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1610291291;
        bh=F3EeeseoQ50cEe+lhsHfw5cqy1qVtLLWQEchAr4nMxY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P/YOFwuACcFFkW1sbvVMAq2oXxhTWyrkCFCQU6Vm6LXJkpNP0yG2JnJvGPq76Y6Eb
         S/d/OcVJyfbQDsHAbC/kpZmhkuDp5R0TGrAgNOhompGy9Nq1elfuUENu/pcjmX9r5N
         fV411KolbF3CROc/HFVsf4MIBnnK6j6pNggslI+Q=
Date:   Sun, 10 Jan 2021 16:09:25 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Daniel Scally <djrscally@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-media@vger.kernel.org, devel@acpica.org, rjw@rjwysocki.net,
        lenb@kernel.org, mchehab@kernel.org, sergey.senozhatsky@gmail.com,
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
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH v5 04/15] device property: Call
 fwnode_graph_get_endpoint_by_id() for fwnode->secondary
Message-ID: <X/sYpT+RFV7iPops@kroah.com>
References: <20210107132838.396641-1-djrscally@gmail.com>
 <20210107132838.396641-5-djrscally@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210107132838.396641-5-djrscally@gmail.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Jan 07, 2021 at 01:28:27PM +0000, Daniel Scally wrote:
> This function is used to find fwnode endpoints against a device. In
> some instances those endpoints are software nodes which are children of
> fwnode->secondary. Add support to fwnode_graph_get_endpoint_by_id() to
> find those endpoints by recursively calling itself passing the ptr to
> fwnode->secondary in the event no endpoint is found for the primary.
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> Signed-off-by: Daniel Scally <djrscally@gmail.com>
> ---
> Changes in v5:
> 
> 	- Changed the commit subject
> 
>  drivers/base/property.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
