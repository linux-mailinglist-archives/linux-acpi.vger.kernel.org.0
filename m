Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 633442F07CE
	for <lists+linux-acpi@lfdr.de>; Sun, 10 Jan 2021 16:09:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbhAJPIU (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 10 Jan 2021 10:08:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:37994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726723AbhAJPIU (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sun, 10 Jan 2021 10:08:20 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 41E8F22AB0;
        Sun, 10 Jan 2021 15:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1610291259;
        bh=xttBw4mUlK1lvEwL0uPYIYpq4RDu7OXwOwOhhm+UpCA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lRiM+GaaUFQ+LhFPUCk3QjbQ7JoVT3l65GcWseQbqIwLM2f3ml0O9Og8d/mCbj/l/
         GUXa0rNJB87JromcSyKKlukafIf2t85TwFCu+7c4iMndiQmC/Nk0FmNfjbGLj8kSHe
         qEfXU412cUAb8HdVfZ+eHmRDhqrxLDcUriiW379M=
Date:   Sun, 10 Jan 2021 16:08:53 +0100
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
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v5 08/15] software_node: Add support for fwnode_graph*()
 family of functions
Message-ID: <X/sYhat7AJLmfc78@kroah.com>
References: <20210107132838.396641-1-djrscally@gmail.com>
 <20210107132838.396641-9-djrscally@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210107132838.396641-9-djrscally@gmail.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Jan 07, 2021 at 01:28:31PM +0000, Daniel Scally wrote:
> From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> 
> This implements the remaining .graph_*() callbacks in the fwnode
> operations structure for the software nodes. That makes the
> fwnode_graph_*() functions available in the drivers also when software
> nodes are used.
> 
> The implementation tries to mimic the "OF graph" as much as possible, but
> there is no support for the "reg" device property. The ports will need to
> have the index in their  name which starts with "port@" (for example
> "port@0", "port@1", ...) and endpoints will use the index of the software
> node that is given to them during creation. The port nodes can also be
> grouped under a specially named "ports" subnode, just like in DT, if
> necessary.
> 
> The remote-endpoints are reference properties under the endpoint nodes
> that are named "remote-endpoint".
> 
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Co-developed-by: Daniel Scally <djrscally@gmail.com>
> Signed-off-by: Daniel Scally <djrscally@gmail.com>
> ---
> Changes in v5:
> 
> 	- Cosmetic changes only

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
