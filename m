Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 711383C6253
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Jul 2021 20:04:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234900AbhGLSGz (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 12 Jul 2021 14:06:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:36076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234933AbhGLSGz (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 12 Jul 2021 14:06:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9E8E9611C1;
        Mon, 12 Jul 2021 18:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1626113046;
        bh=tSb6DQiuoOKUATxaFNI+lbb5KcWBZEHJUOZoO1nojng=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Xp1umJtjcKTS4aN2Ze6YimBtfv1nQZzHdul6D4CcnwVfHTpIXn3wgadfdjaWMPA9L
         SBKeKZrwYkY2fKjQHQL8hgAghnLP8bAgwrp3QR+4uLesPiboSv1QURzKeu3yHeMGkp
         9yimTwdNuZi6vnUnOqUNDOiFSxKSgt32kwZs2ZM8=
Date:   Mon, 12 Jul 2021 20:04:03 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Krogerus, Heikki" <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH v1 6/6] driver core: Split device_platform_notify()
Message-ID: <YOyEE4vasE1Daf0H@kroah.com>
References: <2780027.e9J7NaK4W3@kreacher>
 <7971483.NyiUUSuA9g@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7971483.NyiUUSuA9g@kreacher>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Jul 12, 2021 at 07:28:16PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Split device_platform_notify_remove) out of device_platform_notify()
> and call the latter on device addition and the former on device
> removal.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/base/core.c |   37 +++++++++++++++++--------------------
>  1 file changed, 17 insertions(+), 20 deletions(-)

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
