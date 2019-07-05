Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 032BE6034B
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Jul 2019 11:43:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727275AbfGEJnl (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 5 Jul 2019 05:43:41 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:45835 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726568AbfGEJnl (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 5 Jul 2019 05:43:41 -0400
Received: from 79.184.254.216.ipv4.supernova.orange.pl (79.184.254.216) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.267)
 id d34c4fd5c247d611; Fri, 5 Jul 2019 11:43:39 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     robert.moore@intel.com, erik.schmauss@intel.com
Cc:     "Laster K." <officiallazerl0rd@gmail.com>,
        rafael.j.wysocki@intel.com, lenb@kernel.org,
        linux-acpi@vger.kernel.org, devel@acpica.org
Subject: Re: [PATCH] ACPICA: Fix compilation with bare-metal toolchian
Date:   Fri, 05 Jul 2019 11:43:38 +0200
Message-ID: <2847939.QcJ3fIVZhg@kreacher>
In-Reply-To: <CAMhj-NcA8J8rD1PC6mH+HAjBdv2H532UB5aB5-0Y6VWtUh=8-g@mail.gmail.com>
References: <CAMhj-NcA8J8rD1PC6mH+HAjBdv2H532UB5aB5-0Y6VWtUh=8-g@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Saturday, June 22, 2019 11:03:54 PM CEST Laster K. wrote:
> An ifdef expects to be compiled with full-fledged Linux toolchain,
> but it's common to compile kernel with just bare-metal toolchain
> which doesn't define __linux__. So, also add __KERNEL__ check.
> 
> Signed-off-by: Laster K. (lazerl0rd) <officiallazerl0rd@gmail.com>
> ---
> Apologies for the multiple/spammed e-mails, I was having mail client issues.
> 
>  include/acpi/platform/acenv.h   | 2 +-
>  include/acpi/platform/acenvex.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/acpi/platform/acenv.h b/include/acpi/platform/acenv.h
> index 35ab3f87cc29..b69319198cb8 100644
> --- a/include/acpi/platform/acenv.h
> +++ b/include/acpi/platform/acenv.h
> @@ -148,7 +148,7 @@
> 
>  #endif
> 
> -#if defined(_LINUX) || defined(__linux__)
> +#if defined(_LINUX) || defined(__KERNEL__) || defined(__linux__)
>  #include <acpi/platform/aclinux.h>
> 
>  #elif defined(_APPLE) || defined(__APPLE__)
> diff --git a/include/acpi/platform/acenvex.h b/include/acpi/platform/acenvex.h
> index 2e36c8344897..c7697a47e33f 100644
> --- a/include/acpi/platform/acenvex.h
> +++ b/include/acpi/platform/acenvex.h
> @@ -19,7 +19,7 @@
>   *
>   *****************************************************************************/
> 
> -#if defined(_LINUX) || defined(__linux__)
> +#if defined(_LINUX) || defined(__KERNEL__) || defined(__linux__)
>  #include <acpi/platform/aclinuxex.h>
> 
>  #elif defined(__DragonFly__)
> 

Erik, Bob, any input here?



