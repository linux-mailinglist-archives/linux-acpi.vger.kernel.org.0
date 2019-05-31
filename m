Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A842030B6A
	for <lists+linux-acpi@lfdr.de>; Fri, 31 May 2019 11:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726376AbfEaJZV (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 31 May 2019 05:25:21 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:47667 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbfEaJZV (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 31 May 2019 05:25:21 -0400
Received: from 79.184.255.225.ipv4.supernova.orange.pl (79.184.255.225) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.213)
 id 91eb984658eeb43f; Fri, 31 May 2019 11:25:19 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Lenny Szubowicz <lszubowi@redhat.com>
Cc:     lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: ACPI / LPIT: Correct LPIT end address for lpit_process()
Date:   Fri, 31 May 2019 11:25:18 +0200
Message-ID: <5685193.jDmapNlNO2@kreacher>
In-Reply-To: <a988c4cf340e9ae91d942bce02218de6e9c9815c.camel@linux.intel.com>
References: <20190502200052.26754-1-lszubowi@redhat.com> <a988c4cf340e9ae91d942bce02218de6e9c9815c.camel@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tuesday, May 7, 2019 1:46:15 AM CEST Srinivas Pandruvada wrote:
> On Thu, 2019-05-02 at 16:00 -0400, Lenny Szubowicz wrote:
> > Correct the LPIT end address which is passed into lpit_process()
> > and the end address limit test in lpit_process().
> > 
> > The LPI state descriptor subtables follow the fixed sized
> > acpi_lpit_header up to the end of the LPIT. The last LPI state
> > descriptor can end at exactly the end of the LPIT.
> > 
> > Note that this is a fix to a latent problem. Although incorrect,
> > the unpatched version works because the passed in end address
> > is just slightly beyond the actual end of the LPIT and the size
> > of the ACPI LPIT header is smaller than the size of the only
> > currently defined LPI state descriptor, acpi_lpit_native.
> > 
> > Signed-off-by: Lenny Szubowicz <lszubowi@redhat.com>
> Reviewed-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> 
> > ---
> >  drivers/acpi/acpi_lpit.c | 7 +++----
> >  1 file changed, 3 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/acpi/acpi_lpit.c b/drivers/acpi/acpi_lpit.c
> > index e43cb71b6972..8b170a07908a 100644
> > --- a/drivers/acpi/acpi_lpit.c
> > +++ b/drivers/acpi/acpi_lpit.c
> > @@ -137,7 +137,7 @@ static void lpit_update_residency(struct
> > lpit_residency_info *info,
> >  
> >  static void lpit_process(u64 begin, u64 end)
> >  {
> > -	while (begin + sizeof(struct acpi_lpit_native) < end) {
> > +	while (begin + sizeof(struct acpi_lpit_native) <= end) {
> >  		struct acpi_lpit_native *lpit_native = (struct
> > acpi_lpit_native *)begin;
> >  
> >  		if (!lpit_native->header.type && !lpit_native-
> > >header.flags) {
> > @@ -156,7 +156,6 @@ static void lpit_process(u64 begin, u64 end)
> >  void acpi_init_lpit(void)
> >  {
> >  	acpi_status status;
> > -	u64 lpit_begin;
> >  	struct acpi_table_lpit *lpit;
> >  
> >  	status = acpi_get_table(ACPI_SIG_LPIT, 0, (struct
> > acpi_table_header **)&lpit);
> > @@ -164,6 +163,6 @@ void acpi_init_lpit(void)
> >  	if (ACPI_FAILURE(status))
> >  		return;
> >  
> > -	lpit_begin = (u64)lpit + sizeof(*lpit);
> > -	lpit_process(lpit_begin, lpit_begin + lpit->header.length);
> > +	lpit_process((u64)lpit + sizeof(*lpit),
> > +		     (u64)lpit + lpit->header.length);
> >  }
> 
> 

Patch applied, thanks!



