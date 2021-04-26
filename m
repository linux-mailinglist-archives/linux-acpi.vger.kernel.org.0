Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD57236ABB3
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Apr 2021 06:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbhDZE5q (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 26 Apr 2021 00:57:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:42740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229469AbhDZE5q (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 26 Apr 2021 00:57:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9E3C861360;
        Mon, 26 Apr 2021 04:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619413025;
        bh=oF5wTcVUbe3ITjsBTum2WMqyBNYZSs4s3HRFniDzF6I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gI1tY4u0dkEsqk7lL/9IJ+cSkvkBf7k+buPby21z5W+FJ88Et37I0dl4f3EPUDuY2
         yUbkiFZeXThhswjtaYrhM3GhJZuhODBqpQ33pGgjIWsnRWU6BB0jDXATgA+ks7Rk/Q
         Pk6P+qxevkaCaY5eUpvP5PHH/RAtH2v+1pUqDXJ9ncyXzDS8dAG0V8UXyVscg6iblp
         Ed28Bx219ANuJYhPvfmhHL3V+WOU8tHXD4YwNmsBBKJSK/7r4WPO4YtPvjLmVi/G6k
         uTd7IDE1oVNhReVEKp/m8xpI7v30iRsQRMcsVimJOmXHSJGhQ1iMRvYlKPJAcknDRi
         HMlgwGB1eeCyA==
Date:   Mon, 26 Apr 2021 07:57:01 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Anupama K Patil <anupamakpatil123@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Adam <developer@arusty.dev>, bkkarthik@pesu.pes.edu,
        gregkh@linuxfoundation.org, kernelnewbies@kernelnewbies.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] drivers: pnp: proc.c: Removed unnecessary varibles
Message-ID: <YIZIHR0ZQPXFkOH1@unreal>
References: <20210422180322.7wlyg63kv3n2k6id@ubuntu>
 <ea09f455-a00f-a13d-29d8-e3f9790dba56@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea09f455-a00f-a13d-29d8-e3f9790dba56@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Apr 23, 2021 at 03:08:03PM -0600, Shuah Khan wrote:
> On 4/22/21 12:03 PM, Anupama K Patil wrote:
> > de, e are two variables of the type 'struct proc_dir_entry'
> > which can be removed to save memory. This also fixes a coding style
> > issue reported by checkpatch where we are suggested to make assignment
> > outside the if statement.
> > 
> 
> Sounds like a reasonable change.

It is unclear how much changes to ISA code are welcomed.
According to the Wikipedia, even Windows Vista disabled ISA PnP by default.
https://en.wikipedia.org/wiki/Legacy_Plug_and_Play#Specifications

> 
> > Signed-off-by: Anupama K Patil <anupamakpatil123@gmail.com>
> > ---
> >   drivers/pnp/isapnp/proc.c | 13 ++++++-------
> >   1 file changed, 6 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/pnp/isapnp/proc.c b/drivers/pnp/isapnp/proc.c
> > index 785a796430fa..1ae458c02656 100644
> > --- a/drivers/pnp/isapnp/proc.c
> > +++ b/drivers/pnp/isapnp/proc.c
> > @@ -57,21 +57,20 @@ static const struct proc_ops isapnp_proc_bus_proc_ops = {
> >   static int isapnp_proc_attach_device(struct pnp_dev *dev)
> >   {
> >   	struct pnp_card *bus = dev->card;
> > -	struct proc_dir_entry *de, *e;
> >   	char name[16];
> > -	if (!(de = bus->procdir)) {
> > +	if (!bus->procdir) {
> >   		sprintf(name, "%02x", bus->number);
> 
> It would make sense to change this to scnprintf()
> 
> > -		de = bus->procdir = proc_mkdir(name, isapnp_proc_bus_dir);
> > -		if (!de)
> > +		bus->procdir = proc_mkdir(name, isapnp_proc_bus_dir);
> > +		if (!bus->procdir)
> >   			return -ENOMEM;
> >   	}
> >   	sprintf(name, "%02x", dev->number);
> 
> It would make sense to change this to scnprintf()
> 
> > -	e = dev->procent = proc_create_data(name, S_IFREG | S_IRUGO, de,
> > +	dev->procent = proc_create_data(name, S_IFREG | S_IRUGO, bus->procdir,
> >   					    &isapnp_proc_bus_proc_ops, dev);
> > -	if (!e)
> > +	if (!dev->procent)
> >   		return -ENOMEM;
> 
> Shouldn't the procdir be deleted when proc_create_data() fails?

It needs but only if proc_mkdir() was called in this function.

Thanks

> 
> > -	proc_set_size(e, 256);
> > +	proc_set_size(dev->procent, 256);
> >   	return 0;
> >   }
> > 
> 
> Note that isapnp_proc_init() doesn't check isapnp_proc_attach_device()
> return and handle errors and cleanup.
> 
> thanks,
> -- Shuah
> 
> 
> 
> _______________________________________________
> Kernelnewbies mailing list
> Kernelnewbies@kernelnewbies.org
> https://lists.kernelnewbies.org/mailman/listinfo/kernelnewbies
