Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8A398C408
	for <lists+linux-acpi@lfdr.de>; Tue, 13 Aug 2019 23:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbfHMV7Y (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 13 Aug 2019 17:59:24 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:58580 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726155AbfHMV7X (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 13 Aug 2019 17:59:23 -0400
Received: from 79.184.255.155.ipv4.supernova.orange.pl (79.184.255.155) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.275)
 id 470f59cd6541f77a; Tue, 13 Aug 2019 23:59:21 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Al Stone <ahs3@redhat.com>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] ACPI / CPPC: do not require the _PSD method when using CPPC
Date:   Tue, 13 Aug 2019 23:59:21 +0200
Message-ID: <521915646.RcUJINxfhL@kreacher>
In-Reply-To: <20190805170338.29493-1-ahs3@redhat.com>
References: <20190805170338.29493-1-ahs3@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Monday, August 5, 2019 7:03:38 PM CEST Al Stone wrote:
> According to the ACPI 6.3 specification, the _PSD method is optional
> when using CPPC.  The underlying assumption appears to be that each CPU
> can change frequency independently from all other CPUs; _PSD is provided
> to tell the OS that some processors can NOT do that.
> 
> However, the acpi_get_psd() function returns -ENODEV if there is no _PSD
> method present, or an ACPI error status if an error occurs when evaluating
> _PSD, if present.  This essentially makes _PSD mandatory when using CPPC,
> in violation of the specification, and only on Linux.
> 
> This has forced some firmware writers to provide a dummy _PSD, even though
> it is irrelevant, but only because Linux requires it; other OSPMs follow
> the spec.  We really do not want to have OS specific ACPI tables, though.
> 
> So, correct acpi_get_psd() so that it does not return an error if there
> is no _PSD method present, but does return a failure when the method can
> not be executed properly.  This allows _PSD to be optional as it should
> be.
> 
> Signed-off-by: Al Stone <ahs3@redhat.com>
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> Cc: Len Brown <lenb@kernel.org>
> ---
>  drivers/acpi/cppc_acpi.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index 15f103d7532b..e9ecfa13e997 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -365,10 +365,13 @@ static int acpi_get_psd(struct cpc_desc *cpc_ptr, acpi_handle handle)
>  	union acpi_object  *psd = NULL;
>  	struct acpi_psd_package *pdomain;
>  
> -	status = acpi_evaluate_object_typed(handle, "_PSD", NULL, &buffer,
> -			ACPI_TYPE_PACKAGE);
> -	if (ACPI_FAILURE(status))
> -		return -ENODEV;
> +	if (acpi_has_method(handle, "_PSD")) {

It would be better to compare the status below to AE_NOT_FOUND
and return 0 if that's the case.

A couple of code lines could be saved this way at least.

> +		status = acpi_evaluate_object_typed(handle, "_PSD", NULL,
> +						    &buffer, ACPI_TYPE_PACKAGE);
> +		if (ACPI_FAILURE(status))
> +			return -ENODEV;
> +	} else
> +		return 0;		/* _PSD is optional */
>  
>  	psd = buffer.pointer;
>  	if (!psd || psd->package.count != 1) {
> 




