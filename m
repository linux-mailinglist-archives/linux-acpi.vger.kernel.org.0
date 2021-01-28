Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E46E1308226
	for <lists+linux-acpi@lfdr.de>; Fri, 29 Jan 2021 00:57:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbhA1X5V (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 28 Jan 2021 18:57:21 -0500
Received: from smtprelay0108.hostedemail.com ([216.40.44.108]:53636 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229530AbhA1X5V (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 28 Jan 2021 18:57:21 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id E910418014495;
        Thu, 28 Jan 2021 23:56:39 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:973:988:989:1260:1261:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:1801:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3870:3871:3872:4321:4605:5007:6119:7652:7875:7903:10004:10400:10848:11026:11232:11658:11783:11914:12043:12296:12297:12555:12740:12895:12986:13069:13200:13229:13311:13357:13439:13894:14096:14097:14181:14659:14721:21080:21433:21451:21627:30041:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: glass70_2c03527275a3
X-Filterd-Recvd-Size: 2803
Received: from [192.168.1.159] (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf10.hostedemail.com (Postfix) with ESMTPA;
        Thu, 28 Jan 2021 23:56:38 +0000 (UTC)
Message-ID: <955a079a3d15228ce9aeba8720dccae2dc7dfb7c.camel@perches.com>
Subject: Re: [PATCH -next] acpi: fpdt: drop errant comma in pr_info()
From:   Joe Perches <joe@perches.com>
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        Zhang Rui <rui.zhang@intel.com>
Date:   Thu, 28 Jan 2021 15:56:37 -0800
In-Reply-To: <20210128232528.21117-1-rdunlap@infradead.org>
References: <20210128232528.21117-1-rdunlap@infradead.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, 2021-01-28 at 15:25 -0800, Randy Dunlap wrote:
> Drop a mistaken comma in the pr_info() args to prevent the
> build warning.
> 
> ../drivers/acpi/acpi_fpdt.c: In function 'acpi_init_fpdt':
> ../include/linux/kern_levels.h:5:18: warning: too many arguments for format [-Wformat-extra-args]
> ../drivers/acpi/acpi_fpdt.c:255:4: note: in expansion of macro 'pr_info'
>     pr_info(FW_BUG, "Invalid subtable type %d found.\n",
[]
> --- linux-next-20210128.orig/drivers/acpi/acpi_fpdt.c
> +++ linux-next-20210128/drivers/acpi/acpi_fpdt.c
> @@ -252,7 +252,7 @@ void acpi_init_fpdt(void)
>  					      subtable->type);
>  			break;
>  		default:
> -			pr_info(FW_BUG, "Invalid subtable type %d found.\n",
> +			pr_info(FW_BUG "Invalid subtable type %d found.\n",
>  			       subtable->type);

Another question would be why is the pr_info when all the other
FW_BUG uses in this file are pr_err

One would think it's at least a defect of some time.
I would think it should at least be pr_notice or pr_warn

Documentation/admin-guide/kernel-parameters.txt-                        1 (KERN_ALERT)          action must be taken immediately
Documentation/admin-guide/kernel-parameters.txt-                        2 (KERN_CRIT)           critical conditions
Documentation/admin-guide/kernel-parameters.txt-                        3 (KERN_ERR)            error conditions
Documentation/admin-guide/kernel-parameters.txt-                        4 (KERN_WARNING)        warning conditions
Documentation/admin-guide/kernel-parameters.txt-                        5 (KERN_NOTICE)         normal but significant condition
Documentation/admin-guide/kernel-parameters.txt:                        6 (KERN_INFO)           informational
Documentation/admin-guide/kernel-parameters.txt-                        7 (KERN_DEBUG)          debug-level messages


