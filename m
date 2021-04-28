Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D9CA36D71D
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Apr 2021 14:17:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbhD1MSD (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 28 Apr 2021 08:18:03 -0400
Received: from mail1.perex.cz ([77.48.224.245]:56924 "EHLO mail1.perex.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234355AbhD1MSD (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 28 Apr 2021 08:18:03 -0400
Received: from mail1.perex.cz (localhost [127.0.0.1])
        by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 9D113A004B;
        Wed, 28 Apr 2021 14:17:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 9D113A004B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
        t=1619612237; bh=jApOZ5WCX2DyFFc/CN9VUh3CS1nh2H/Au0dQM1cOiK8=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=XNm9e7qQXhFZzcPm4dHc5DSFzi00z6lI+4d6CULDSDgTofAO6lDnZ6SjcVBeSLRG6
         Ru/X+/86QUzFXck9l4JPoSy8auC3do2xWZvINYSgKzdUPlQoUwoAGFoWwY362CyFZJ
         hcqz+vOmq9Ia2k6Wt4xid4UK8OmVGkODj+hucX6Q=
Received: from p1gen2.localdomain (unknown [192.168.100.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: perex)
        by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
        Wed, 28 Apr 2021 14:17:07 +0200 (CEST)
Subject: Re: [PATCH] drivers: pnp: proc.c: Removed unnecessary varibles
To:     Anupama K Patil <anupamakpatil123@gmail.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, Adam <developer@arusty.dev>,
        bkkarthik@pesu.pes.edu, gregkh@linuxfoundation.org,
        kernelnewbies@kernelnewbies.org,
        linux-kernel-mentees@lists.linuxfoundation.org
References: <20210422180322.7wlyg63kv3n2k6id@ubuntu>
From:   Jaroslav Kysela <perex@perex.cz>
Message-ID: <b28f6a3d-0752-a85e-bfe0-a5eb8d92c229@perex.cz>
Date:   Wed, 28 Apr 2021 14:17:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210422180322.7wlyg63kv3n2k6id@ubuntu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Dne 22. 04. 21 v 20:03 Anupama K Patil napsal(a):
> de, e are two variables of the type 'struct proc_dir_entry'
> which can be removed to save memory. This also fixes a coding style
> issue reported by checkpatch where we are suggested to make assignment
> outside the if statement.
> 
> Signed-off-by: Anupama K Patil <anupamakpatil123@gmail.com>

The change is straight without any functionality modification.

Reviewed-by: Jaroslav Kysela <perex@perex.cz>

> ---
>  drivers/pnp/isapnp/proc.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/pnp/isapnp/proc.c b/drivers/pnp/isapnp/proc.c
> index 785a796430fa..1ae458c02656 100644
> --- a/drivers/pnp/isapnp/proc.c
> +++ b/drivers/pnp/isapnp/proc.c
> @@ -57,21 +57,20 @@ static const struct proc_ops isapnp_proc_bus_proc_ops = {
>  static int isapnp_proc_attach_device(struct pnp_dev *dev)
>  {
>  	struct pnp_card *bus = dev->card;
> -	struct proc_dir_entry *de, *e;
>  	char name[16];
>  
> -	if (!(de = bus->procdir)) {
> +	if (!bus->procdir) {
>  		sprintf(name, "%02x", bus->number);
> -		de = bus->procdir = proc_mkdir(name, isapnp_proc_bus_dir);
> -		if (!de)
> +		bus->procdir = proc_mkdir(name, isapnp_proc_bus_dir);
> +		if (!bus->procdir)
>  			return -ENOMEM;
>  	}
>  	sprintf(name, "%02x", dev->number);
> -	e = dev->procent = proc_create_data(name, S_IFREG | S_IRUGO, de,
> +	dev->procent = proc_create_data(name, S_IFREG | S_IRUGO, bus->procdir,
>  					    &isapnp_proc_bus_proc_ops, dev);
> -	if (!e)
> +	if (!dev->procent)
>  		return -ENOMEM;
> -	proc_set_size(e, 256);
> +	proc_set_size(dev->procent, 256);
>  	return 0;
>  }
>  
> 


-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
