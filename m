Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F083A9CC1A
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Aug 2019 11:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729755AbfHZJED (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 26 Aug 2019 05:04:03 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:46039 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727816AbfHZJED (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 26 Aug 2019 05:04:03 -0400
Received: from 79.184.255.249.ipv4.supernova.orange.pl (79.184.255.249) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.275)
 id 2a08382a4b647c7c; Mon, 26 Aug 2019 11:04:01 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        James Morse <james.morse@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>, Borislav Petkov <bp@suse.de>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v1] ACPI / APEI: Get rid of NULL_UUID_LE constant
Date:   Mon, 26 Aug 2019 11:04:01 +0200
Message-ID: <1860012.04uLkyF2MU@kreacher>
In-Reply-To: <20190717105543.76244-1-andriy.shevchenko@linux.intel.com>
References: <20190717105543.76244-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wednesday, July 17, 2019 12:55:43 PM CEST Andy Shevchenko wrote:
> This is a missed part of the commit 5b53696a30d5
> ("ACPI / APEI: Switch to use new generic UUID API"), i.e.
> replacing old definition with a global constant variable.
> 
> Cc: Borislav Petkov <bp@suse.de>
> Cc: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/acpi/apei/ghes.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index a66e00fe31fe..451269a2f47c 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -483,7 +483,7 @@ static void ghes_do_proc(struct ghes *ghes,
>  	int sev, sec_sev;
>  	struct acpi_hest_generic_data *gdata;
>  	guid_t *sec_type;
> -	guid_t *fru_id = &NULL_UUID_LE;
> +	const guid_t *fru_id = &guid_null;
>  	char *fru_text = "";
>  
>  	sev = ghes_severity(estatus->error_severity);
> 

Applied, thanks!




