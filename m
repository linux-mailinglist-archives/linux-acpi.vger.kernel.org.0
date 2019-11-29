Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61E0410D48E
	for <lists+linux-acpi@lfdr.de>; Fri, 29 Nov 2019 12:10:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726215AbfK2LKd (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 29 Nov 2019 06:10:33 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:27692 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725892AbfK2LKc (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 29 Nov 2019 06:10:32 -0500
X-IronPort-AV: E=Sophos;i="5.69,257,1571673600"; 
   d="scan'208";a="79277873"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 29 Nov 2019 19:10:30 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id EF8FE406AB15;
        Fri, 29 Nov 2019 19:02:01 +0800 (CST)
Received: from [10.167.226.60] (10.167.226.60) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1395.4; Fri, 29 Nov 2019 19:10:27 +0800
Subject: Re: [RFC PATCH] x86/acpi: Drop duplicate BOOT table initialization
To:     Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>, <x86@kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <rjw@rjwysocki.net>, <len.brown@intel.com>, <pavel@ucw.cz>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <hpa@zytor.com>, <linux-acpi@vger.kernel.org>
References: <20191115092424.17356-1-ruansy.fnst@cn.fujitsu.com>
From:   Cao jin <caoj.fnst@cn.fujitsu.com>
Message-ID: <2459727a-62b8-658e-1bf4-a59be4d93004@cn.fujitsu.com>
Date:   Fri, 29 Nov 2019 19:11:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191115092424.17356-1-ruansy.fnst@cn.fujitsu.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.226.60]
X-ClientProxiedBy: G08CNEXCHPEKD06.g08.fujitsu.local (10.167.33.205) To
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206)
X-yoursite-MailScanner-ID: EF8FE406AB15.AA7DB
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: caoj.fnst@cn.fujitsu.com
X-Spam-Status: No
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Ping?

-- 
Sincerely,
Cao jin

On 11/15/19 5:24 PM, Shiyang Ruan wrote:
> From: Cao jin <caoj.fnst@cn.fujitsu.com>
> 
> ACPI BOOT table is initialized in both acpi_boot_table_init &
> acpi_boot_init of setup_arch, but its usage is quite late at the end of
> start_kernel. It should be safe to drop one of them. Since it is less
> related with table init, drop it from there.
> 
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


