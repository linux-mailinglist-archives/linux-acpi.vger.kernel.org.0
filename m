Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B60530AF80
	for <lists+linux-acpi@lfdr.de>; Mon,  1 Feb 2021 19:37:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233013AbhBASgv (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 1 Feb 2021 13:36:51 -0500
Received: from smtprelay0174.hostedemail.com ([216.40.44.174]:43840 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232955AbhBASg2 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 1 Feb 2021 13:36:28 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id C9901182CF66A;
        Mon,  1 Feb 2021 18:35:37 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:973:988:989:1260:1261:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2198:2199:2393:2559:2562:2691:2828:2895:3138:3139:3140:3141:3142:3352:3622:3865:3867:3868:3870:3872:3874:4321:5007:7576:7652:7875:10004:10400:10848:11026:11232:11473:11658:11914:12043:12296:12297:12438:12740:12895:13069:13311:13357:13439:13894:14181:14659:14721:21080:21212:21451:21611:21627:21660:30054:30064:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: sound29_52137f3275c4
X-Filterd-Recvd-Size: 2116
Received: from [192.168.1.159] (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Mon,  1 Feb 2021 18:35:35 +0000 (UTC)
Message-ID: <ab62890a1128b0d3109553208379015fcb36e0c7.camel@perches.com>
Subject: Re: [PATCH v1 2/5] ACPI: battery: Clean up printing messages
From:   Joe Perches <joe@perches.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Erik Kaneda <erik.kaneda@intel.com>
Date:   Mon, 01 Feb 2021 10:35:33 -0800
In-Reply-To: <1996712.1aSbzQgNOC@kreacher>
References: <2367702.B5bJTmGzJm@kreacher> <1996712.1aSbzQgNOC@kreacher>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, 2021-02-01 at 19:16 +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Replace the ACPI_DEBUG_PRINT() and ACPI_EXCEPTION() instances
> in battery.c with acpi_handle_debug() and acpi_handle_info() calls,
> respectively, drop the _COMPONENT and ACPI_MODULE_NAME() definitions
> that are not used any more, drop the no longer needed
> ACPI_BATTERY_COMPONENT definition from the headers and update the
> documentation accordingly.
> 
> While at it, update the pr_fmt() definition and drop the unneeded
> PREFIX sybmbol definition from battery.c.
[]
> --- linux-pm.orig/drivers/acpi/battery.c
[]
> @@ -466,7 +460,8 @@ static int extract_package(struct acpi_b
>  static int acpi_battery_get_status(struct acpi_battery *battery)
>  {
>  	if (acpi_bus_get_status(battery->device)) {
> -		ACPI_EXCEPTION((AE_INFO, AE_ERROR, "Evaluating _STA"));
> +		acpi_handle_info(battery->device->handle,
> +				 "_STA evaluation failed\n");

I believe this changes the logging level from KERN_ERR to KERN_INFO.

Perhaps this and others should instead use acpi_handle_err()


