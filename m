Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94A458C3FC
	for <lists+linux-acpi@lfdr.de>; Tue, 13 Aug 2019 23:57:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725903AbfHMV5C (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 13 Aug 2019 17:57:02 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:44096 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726155AbfHMV5C (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 13 Aug 2019 17:57:02 -0400
Received: from 79.184.255.155.ipv4.supernova.orange.pl (79.184.255.155) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.275)
 id 792c27eccea206a6; Tue, 13 Aug 2019 23:57:00 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     ahs3@redhat.com
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] ACPI / CPPC: do not require the _PSD method when using CPPC
Date:   Tue, 13 Aug 2019 23:57:00 +0200
Message-ID: <3154828.dzdK0YMts5@kreacher>
In-Reply-To: <d60f5bed-ca91-fc72-2e4d-309fb8f42960@redhat.com>
References: <20190805170338.29493-1-ahs3@redhat.com> <d60f5bed-ca91-fc72-2e4d-309fb8f42960@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tuesday, August 13, 2019 4:00:56 PM CEST Al Stone wrote:
> On 8/5/19 11:03 AM, Al Stone wrote:
> > According to the ACPI 6.3 specification, the _PSD method is optional
> > when using CPPC.  The underlying assumption appears to be that each CPU
> > can change frequency independently from all other CPUs; _PSD is provided
> > to tell the OS that some processors can NOT do that.
> > 
> > However, the acpi_get_psd() function returns -ENODEV if there is no _PSD
> > method present, or an ACPI error status if an error occurs when evaluating
> > _PSD, if present.  This essentially makes _PSD mandatory when using CPPC,
> > in violation of the specification, and only on Linux.
> > 
> > This has forced some firmware writers to provide a dummy _PSD, even though
> > it is irrelevant, but only because Linux requires it; other OSPMs follow
> > the spec.  We really do not want to have OS specific ACPI tables, though.
> > 
> > So, correct acpi_get_psd() so that it does not return an error if there
> > is no _PSD method present, but does return a failure when the method can
> > not be executed properly.  This allows _PSD to be optional as it should
> > be.
> > 
> > Signed-off-by: Al Stone <ahs3@redhat.com>
> > Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> > Cc: Len Brown <lenb@kernel.org>
> > ---
> >  drivers/acpi/cppc_acpi.c | 11 +++++++----
> >  1 file changed, 7 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> > index 15f103d7532b..e9ecfa13e997 100644
> > --- a/drivers/acpi/cppc_acpi.c
> > +++ b/drivers/acpi/cppc_acpi.c
> > @@ -365,10 +365,13 @@ static int acpi_get_psd(struct cpc_desc *cpc_ptr, acpi_handle handle)
> >  	union acpi_object  *psd = NULL;
> >  	struct acpi_psd_package *pdomain;
> >  
> > -	status = acpi_evaluate_object_typed(handle, "_PSD", NULL, &buffer,
> > -			ACPI_TYPE_PACKAGE);
> > -	if (ACPI_FAILURE(status))
> > -		return -ENODEV;
> > +	if (acpi_has_method(handle, "_PSD")) {
> > +		status = acpi_evaluate_object_typed(handle, "_PSD", NULL,
> > +						    &buffer, ACPI_TYPE_PACKAGE);
> > +		if (ACPI_FAILURE(status))
> > +			return -ENODEV;
> > +	} else
> > +		return 0;		/* _PSD is optional */
> >  
> >  	psd = buffer.pointer;
> >  	if (!psd || psd->package.count != 1) {
> > 
> 
> Rafael,
> 
> Any other comments?

Yes (they will be sent separately).

> Would it be possible to pull this into an -rc?
> I'd really like to avoid anyone else having to ship Linux-specific
> DSDTs and SSDTs.

You won't achieve that through this patch alone, because they will
also want older kernels that don't include it to run on their platforms.

Thanks,
Rafael



