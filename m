Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C5343C6255
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Jul 2021 20:04:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235771AbhGLSHR (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 12 Jul 2021 14:07:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:36208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234933AbhGLSHR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 12 Jul 2021 14:07:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6C7CA610E6;
        Mon, 12 Jul 2021 18:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1626113067;
        bh=IAh+lDuPli6NxbCHtzVCiLcEYGqT24fgxwCSUYEE61g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YCUM8X0ai/AHCd/pBcre5lry/gabE5xegqrINuT9wDnQHGiAlDPSzOE3A5sQgYK/2
         ZZzpiVnpV+GHMxP1YrEV5T7ZvYbQReydnetQsUEuyDDzF9pt3y9GXKERbfEka4chQj
         okmICmGuIsYAk7i9bL5Myh0f1ok4Wtx5d3V54ge4=
Date:   Mon, 12 Jul 2021 20:04:25 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Krogerus, Heikki" <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH v1 0/6] ACPI: glue / driver core: Eliminate
 acpi_platform_notify() and split device_platform_notify()
Message-ID: <YOyEKT/Ma9xPOpy7@kroah.com>
References: <2780027.e9J7NaK4W3@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2780027.e9J7NaK4W3@kreacher>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Jul 12, 2021 at 07:19:57PM +0200, Rafael J. Wysocki wrote:
> Hi Greg et al,
> 
> This series doesn't change functionality (at least not intentionally), but
> it get rids of a few unneeded checks, parameter passing etc.
> 
> Patches [1-2/6] simplify the ACPI "glue" code.
> 
> Patch [3/6] renames a couple of ACPI functions to avoid name collisions going
> forward.
> 
> Patch [4/6] gets rid of acpi_platform_notify().
> 
> Patch [5/6] rearranges the software nodes code along the lines of what happens
> to the ACPI "glue" code in patch [4/6].
> 
> Patch [6/6] deals with device_platform_notify().
> 
> Please review and let me know if there are any concerns regarding this.

Looks good, I only had one small naming comment on patch 5/6.

thanks,

greg k-h
