Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8C5C25FA6E
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Sep 2020 14:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728792AbgIGMXU (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 7 Sep 2020 08:23:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:41854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729304AbgIGMXR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 7 Sep 2020 08:23:17 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E39FB2137B;
        Mon,  7 Sep 2020 12:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599481397;
        bh=W4V9kVZfecfE8xIBo6XS9gugVAs/6HAok3326/9CEcI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mBctklgWtGVWv4ELibkECQtm0Z21EkvcN4Gem+PNpj6TKQDFqI1E2BLx0TnramhvA
         MHD42DzigNYdFsbnfNCurcLW4nA3hxvvOpx5jWWgreRGPJRuUeSIdQx9C+jDE120BO
         mM+jbBwF5nWgon0RrDDQCS8tPt37DIbKd/8nxAEw=
Date:   Mon, 7 Sep 2020 14:23:31 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Move fwnode_connection_find_match() under
 drivers/base/property.c
Message-ID: <20200907122331.GA2029056@kroah.com>
References: <20200907120532.37611-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200907120532.37611-1-heikki.krogerus@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Sep 07, 2020 at 03:05:30PM +0300, Heikki Krogerus wrote:
> This is second version of this series. I forgot to remove the file
> from Documentation/driver-api/index.rst. Hopefully these are now OK.
> 
> The original cover letter:
> 
> Hi,
> 
> This was the last patch in my series that removed struct
> device_connection [1]. It's now split into two separate patches.
> 
> [1] https://lore.kernel.org/lkml/20200904125123.83725-1-heikki.krogerus@linux.intel.com/
> 
> thanks,
> 
> *** BLURB HERE ***

But you do have a blurb!  :)

Anyway, thanks for the update, both now applied.

greg k-h
