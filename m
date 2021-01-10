Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FDF42F07E6
	for <lists+linux-acpi@lfdr.de>; Sun, 10 Jan 2021 16:09:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbhAJPJK (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 10 Jan 2021 10:09:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:38340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726932AbhAJPJB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sun, 10 Jan 2021 10:09:01 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5F77F22AAE;
        Sun, 10 Jan 2021 15:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1610291300;
        bh=34h9XEcoyG0a79tBf0gNmOm8EBxK+Yu03mrFZdXwVGY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B4hhSjh128MIKlkunuIdFSNKBomwgy0FcJlokV4EXXM0xxgghL29dFCxohN7LMLvs
         NuxNE2VHx3orzO+YhnmpD2mTnv056UT3vjYAncfDa0J/lEB0sZUBW8/xc5qXLao0co
         mW8EBLOvq0JLKGUReJGSE6zkyYsdJNs6YxQErWuo=
Date:   Sun, 10 Jan 2021 16:09:34 +0100
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
Subject: Re: [PATCH v5 03/15] device property: Return true in
 fwnode_device_is_available for NULL ops
Message-ID: <X/sYrpHzJVpqrRis@kroah.com>
References: <20210107132838.396641-1-djrscally@gmail.com>
 <20210107132838.396641-4-djrscally@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210107132838.396641-4-djrscally@gmail.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Jan 07, 2021 at 01:28:26PM +0000, Daniel Scally wrote:
> Some types of fwnode_handle do not implement the device_is_available()
> check, such as those created by software_nodes. There isn't really a
> meaningful way to check for the availability of a device that doesn't
> actually exist, so if the check isn't implemented just assume that the
> "device" is present.
> 
> Suggested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> Signed-off-by: Daniel Scally <djrscally@gmail.com>
> ---
> Changes in v5:
> 
> 	- Changed the commit subject
> 

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
