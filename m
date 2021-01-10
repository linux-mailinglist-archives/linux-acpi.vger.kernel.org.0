Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65F682F07EB
	for <lists+linux-acpi@lfdr.de>; Sun, 10 Jan 2021 16:09:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbhAJPJ0 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 10 Jan 2021 10:09:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:38564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727025AbhAJPJ0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sun, 10 Jan 2021 10:09:26 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1120022AAF;
        Sun, 10 Jan 2021 15:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1610291325;
        bh=/glk8U1bakNGNVL370JWrT5oii7OE5yQ+brBSwUU9QA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2jYjHUuyW/S4CACnfpGW+b3pEsKVitsZcQ5Ll939xYmOAZWYICcPvg+tFjfKRCvwl
         VnYkPiI22QDKCRU3xV1gUbDvKCyorl8mWWin9z2fCnVkrIevUUzKuQYxXSO1xC+XlY
         y5/0JQGMGK/2L79KuxnOxgaOB0VqUVMEgDeERaXU=
Date:   Sun, 10 Jan 2021 16:09:58 +0100
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
Subject: Re: [PATCH v5 01/15] software_node: Fix refcounts in
 software_node_get_next_child()
Message-ID: <X/sYxq9AhQbF4j74@kroah.com>
References: <20210107132838.396641-1-djrscally@gmail.com>
 <20210107132838.396641-2-djrscally@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210107132838.396641-2-djrscally@gmail.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Jan 07, 2021 at 01:28:24PM +0000, Daniel Scally wrote:
> The software_node_get_next_child() function currently does not hold
> references to the child software_node that it finds or put the ref that
> is held against the old child - fix that.
> 
> Fixes: 59abd83672f7 ("drivers: base: Introducing software nodes to the firmware node framework")
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> Signed-off-by: Daniel Scally <djrscally@gmail.com>
> ---
> Changes in v5:

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
