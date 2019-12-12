Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D872211D8FF
	for <lists+linux-acpi@lfdr.de>; Thu, 12 Dec 2019 23:03:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731198AbfLLWDu (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 12 Dec 2019 17:03:50 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:55846 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730779AbfLLWDu (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 12 Dec 2019 17:03:50 -0500
Received: from 79.184.255.82.ipv4.supernova.orange.pl (79.184.255.82) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.320)
 id d1780aa828de6562; Thu, 12 Dec 2019 23:03:47 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
Cc:     x86@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, len.brown@intel.com, pavel@ucw.cz,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        Cao jin <caoj.fnst@cn.fujitsu.com>, linux-acpi@vger.kernel.org
Subject: Re: [RFC PATCH] x86/acpi: Drop duplicate BOOT table initialization
Date:   Thu, 12 Dec 2019 23:03:47 +0100
Message-ID: <24266640.LfmLNjZWAc@kreacher>
In-Reply-To: <20191115092424.17356-1-ruansy.fnst@cn.fujitsu.com>
References: <20191115092424.17356-1-ruansy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Friday, November 15, 2019 10:24:24 AM CET Shiyang Ruan wrote:
> From: Cao jin <caoj.fnst@cn.fujitsu.com>
> 
> ACPI BOOT table is initialized in both acpi_boot_table_init &
> acpi_boot_init of setup_arch, but its usage is quite late at the end of
> start_kernel. It should be safe to drop one of them. Since it is less
> related with table init, drop it from there.

Well, "It should be safe to drop one of them" is kind of a weak justification.

I need to be convinced that one of them is redundant.  At this point I am not.

> Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>
> Cc: <linux-acpi@vger.kernel.org>
> Signed-off-by: Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
> ---
>  arch/x86/kernel/acpi/boot.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> It existed since git repo is built, so it might has its reason? The
> patch is not tested since I don't have BOOT table in my firmware.
> 
> diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
> index 04205ce127a1..ca1c15bb0b48 100644
> --- a/arch/x86/kernel/acpi/boot.c
> +++ b/arch/x86/kernel/acpi/boot.c
> @@ -1558,8 +1558,6 @@ void __init acpi_boot_table_init(void)
>  		return;
>  	}
>  
> -	acpi_table_parse(ACPI_SIG_BOOT, acpi_parse_sbf);
> -
>  	/*
>  	 * blacklist may disable ACPI entirely
>  	 */
> 




