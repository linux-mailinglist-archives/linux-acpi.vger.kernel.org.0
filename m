Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5F913140E0
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Feb 2021 21:49:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234424AbhBHUsw (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 8 Feb 2021 15:48:52 -0500
Received: from smtprelay0124.hostedemail.com ([216.40.44.124]:59598 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233439AbhBHUqi (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 8 Feb 2021 15:46:38 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id C66FA18484D83;
        Mon,  8 Feb 2021 20:45:33 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:973:988:989:1260:1261:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1540:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3870:3873:3874:4321:4605:5007:7652:7875:7974:10004:10400:10848:11026:11232:11473:11658:11914:12043:12291:12297:12438:12683:12740:12895:13069:13311:13357:13439:13894:14110:14181:14659:14721:21080:21212:21611:21627:21660:30029:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:6,LUA_SUMMARY:none
X-HE-Tag: rice92_5b00f7527601
X-Filterd-Recvd-Size: 1747
Received: from [192.168.1.159] (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Mon,  8 Feb 2021 20:45:32 +0000 (UTC)
Message-ID: <337f970b0643d2f67f9a388ff8bbddcf673a1c6b.camel@perches.com>
Subject: Re: [PATCH v1 2/2] ACPI: OSL: Clean up printing messages
From:   Joe Perches <joe@perches.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Hanjun Gou <gouhanjun@huawei.com>
Date:   Mon, 08 Feb 2021 12:45:31 -0800
In-Reply-To: <3297462.0emgCRZMdL@kreacher>
References: <4653881.kBYL0eE9gL@kreacher> <3297462.0emgCRZMdL@kreacher>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, 2021-02-08 at 19:59 +0100, Rafael J. Wysocki wrote:
> Replace the ACPI_DEBUG_PRINT() instance in osl.c unrelated to the
> ACPICA debug with acpi_handle_debug(), add a pr_fmt() definition
> to osl.c and replace direct printk() usage in that file with the
> suitable pr_*() calls.
[]
> ===================================================================
> --- linux-pm.orig/drivers/acpi/osl.c
> +++ linux-pm/drivers/acpi/osl.c
[]
> @@ -528,13 +531,13 @@ acpi_os_predefined_override(const struct
>  
> 
>  	*new_val = NULL;
>  	if (!memcmp(init_val->name, "_OS_", 4) && strlen(acpi_os_name)) {
> -		printk(KERN_INFO PREFIX "Overriding _OS definition to '%s'\n",
> +		pr_info("Overriding _OS definition to '%s'\n",
>  		       acpi_os_name);

If you do more of these, perhaps rewrap lines to 80 columns when possible.

		pr_info("Overriding _OS definition to '%s'\n", acpi_os_name);

etc...


