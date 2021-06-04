Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E82A39B9D0
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Jun 2021 15:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbhFDN1o (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 4 Jun 2021 09:27:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:54112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230124AbhFDN1n (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 4 Jun 2021 09:27:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AC103613F1;
        Fri,  4 Jun 2021 13:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1622813141;
        bh=nOdyAZuKEqdBs2+ZiPaHKTV7E6qaKyPyzOTfb2hCaeU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LAFUj4C0x8bLPCddaYg3bYeTzPp98GiIzRPM+/d/ap8Kcf8Htn4DchoiJRCRZdO1y
         9m/mQOZYLr7tYJVCAMmoXedn/QKIW6b26gQYCPEmpXXFy7JN+gRs5J7XR3TZ3+Vggv
         4K8XLu7d8661AMdAbn77rTt5jyf/4ykyoeDBXi2o=
Date:   Fri, 4 Jun 2021 15:25:38 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v1 1/1] device property: Unify access to of_node
Message-ID: <YLop0g8+ZZt60HYC@kroah.com>
References: <20210604131343.62016-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210604131343.62016-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Jun 04, 2021 at 04:13:43PM +0300, Andy Shevchenko wrote:
> Historically we have a few variants how we access dev->fwnode
> and dev->of_node. Some of the functions during development
> gained different versions of the getters. Unify access to of_node
> and as a side change slightly refactor ACPI specific branches.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/base/property.c  | 29 +++++++++++++----------------
>  include/linux/property.h |  2 +-
>  2 files changed, 14 insertions(+), 17 deletions(-)

Less code and const structures are always a win.  If I get an ack from
Rafael I will merge this in my tree.

thanks,
greg k-h
