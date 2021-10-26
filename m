Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B70743B7F3
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Oct 2021 19:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236431AbhJZRPk (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 26 Oct 2021 13:15:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:56156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230160AbhJZRPh (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 26 Oct 2021 13:15:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AF09B60F92;
        Tue, 26 Oct 2021 17:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1635268393;
        bh=nOCVu678W4dA/ITLKp2dEO7RE6qj6Rq765OYOa2ByWA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OHOBV0ubE/WHGQLuaK+VT6+Lm0Gji3nam0KnzOwMUvfRgIj4zp2r+eDwk/l6lM8V+
         YDUioDDPT0CGic+rhZyMz3eHGDrXhXDcTeukMPEbxCHEwuHhaG2eO3qNQcYO5K2lwq
         /omDfKhyLONueRhvFmHVAqmgGPi9GVyK0rZ7zNpo=
Date:   Tue, 26 Oct 2021 19:13:11 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        YE Chengfeng <cyeaa@connect.ust.hk>
Subject: Re: [PATCH v1 1/1] device property: Drop redundant NULL checks
Message-ID: <YXg3J4I6Tw8NAMuE@kroah.com>
References: <20211026162954.89811-1-andriy.shevchenko@linux.intel.com>
 <CAJZ5v0hKkwkYkBJX7nyALbp2cXohOPThV-rkSM7rzn186-2vJQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hKkwkYkBJX7nyALbp2cXohOPThV-rkSM7rzn186-2vJQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Oct 26, 2021 at 06:52:39PM +0200, Rafael J. Wysocki wrote:
> On Tue, Oct 26, 2021 at 6:30 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > In cases when functions are called via fwnode operations,
> > we already know that this is software node we are dealing
> > with, hence no need to check if it's NULL, it can't be,
> >
> > Reported-by: YE Chengfeng <cyeaa@connect.ust.hk>
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> or please let me know if I need to pick this up.

I can take it, thanks!

greg k-h
