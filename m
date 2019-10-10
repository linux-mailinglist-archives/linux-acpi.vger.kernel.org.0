Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EFF9DD33DA
	for <lists+linux-acpi@lfdr.de>; Fri, 11 Oct 2019 00:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726065AbfJJWUe (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 10 Oct 2019 18:20:34 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:65011 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbfJJWUe (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 10 Oct 2019 18:20:34 -0400
Received: from 79.184.255.36.ipv4.supernova.orange.pl (79.184.255.36) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.292)
 id 86c559199dc39aa4; Fri, 11 Oct 2019 00:20:31 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Daniel Black <daniel@linux.ibm.com>
Cc:     Len Brown <lenb@kernel.org>,
        "open list:ACPI" <linux-acpi@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] acpi/hmat: ACPI_HMAT_MEMORY_PD_VALID is deprecated in ACPI-6.3
Date:   Fri, 11 Oct 2019 00:20:31 +0200
Message-ID: <5172949.9bKdBNxvUS@kreacher>
In-Reply-To: <20190806042440.16445-1-daniel@linux.ibm.com>
References: <20190806042440.16445-1-daniel@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tuesday, August 6, 2019 6:24:39 AM CEST Daniel Black wrote:
> ACPI-6.3 corresponds to when hmat revision was bumped from
> 1 to 2. In this version ACPI_HMAT_MEMORY_PD_VALID was
> deprecated and made reserved.
> 
> As such in revision 2+ we shouldn't be testing this flag.
> 
> This is as per ACPI-6.3, 5.2.27.3, Table 5-145
> "Memory Proximity Domain Attributes Structure"
> for Flags.
> 
> Signed-off-by: Daniel Black <daniel@linux.ibm.com>
> ---
>  drivers/acpi/hmat/hmat.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/hmat/hmat.c b/drivers/acpi/hmat/hmat.c
> index 96b7d39a97c6..e938e34673d9 100644
> --- a/drivers/acpi/hmat/hmat.c
> +++ b/drivers/acpi/hmat/hmat.c
> @@ -382,7 +382,7 @@ static int __init hmat_parse_proximity_domain(union acpi_subtable_headers *heade
>  		pr_info("HMAT: Memory Flags:%04x Processor Domain:%d Memory Domain:%d\n",
>  			p->flags, p->processor_PD, p->memory_PD);
>  
> -	if (p->flags & ACPI_HMAT_MEMORY_PD_VALID) {
> +	if (p->flags & ACPI_HMAT_MEMORY_PD_VALID && hmat_revision == 1) {
>  		target = find_mem_target(p->memory_PD);
>  		if (!target) {
>  			pr_debug("HMAT: Memory Domain missing from SRAT\n");
> 

Applied as a fix for 5.4, thanks!



