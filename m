Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE88369BE1
	for <lists+linux-acpi@lfdr.de>; Fri, 23 Apr 2021 23:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244027AbhDWVJZ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 23 Apr 2021 17:09:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244205AbhDWVIn (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 23 Apr 2021 17:08:43 -0400
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E8B1C06138F
        for <linux-acpi@vger.kernel.org>; Fri, 23 Apr 2021 14:08:05 -0700 (PDT)
Received: by mail-oo1-xc35.google.com with SMTP id d16-20020a4a3c100000b02901f0590a614eso3128611ooa.8
        for <linux-acpi@vger.kernel.org>; Fri, 23 Apr 2021 14:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=A22TFll9Blm6PfGJntS755LasWSXUim+ApdH7q9KXpA=;
        b=R5TEIv7r4kLuU5GuMWuxRcVR6NDvYx2skoH8US3RTsgU/Fbp/2PVhgI2qB1oIuefno
         7jxT4w0OVfBtyKsNLQx3nU/NuBSntlMycnPfjjUb59ce/gDpthHN9M7whlXmWdynzzV4
         mE5U3vaTyTDVk98Qw56lnGFYnGuEwSIbthXUM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=A22TFll9Blm6PfGJntS755LasWSXUim+ApdH7q9KXpA=;
        b=JbCrL6FG83uw/lTjrRmBFukhkyMdsLp1KIiu3IReO89RLOpKESLlAkpXekxLG67WHB
         /P2U7qgsOw2WoW8JARWLu0jOOrS/FlLp2Q0C5a7bcl7SLKUqe9YxASANYWgctLzg/3Ms
         H4lOoJfRv/wYoUMKy902CC1cbQdCckw/khzkYtXfvvFBvC0K0mXj1MxUmOgqaOvInmAO
         sEhsBuHIn2wAP33DJMmp9tc3godLxYpQXIfKydFv5kACX+zJjW6zCIDbqmekfyoU+eSf
         mDiVlV7fdHSDTBtjzXrXVVkf4SXdxrDjYs9EikyXMdDsZd2A3GCGDNlVYRg2twJGecA7
         uTjw==
X-Gm-Message-State: AOAM533y3GNEGYPMzPd3TR4RHr4QlKkUUmhzGjE2fjqxmByp1L2/9Ipd
        x48iXQPlOd3jgSaQBT78YEwv9A==
X-Google-Smtp-Source: ABdhPJzmW7K55h27yHhlG31k1T2j2EBi0KXXkEuGIYledi+3ZceYb0qhnae+2xECf/+H2U4zaV+zUA==
X-Received: by 2002:a4a:2f09:: with SMTP id p9mr4337857oop.70.1619212084733;
        Fri, 23 Apr 2021 14:08:04 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id r19sm1482819oie.58.2021.04.23.14.08.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Apr 2021 14:08:04 -0700 (PDT)
Subject: Re: [PATCH] drivers: pnp: proc.c: Removed unnecessary varibles
To:     Anupama K Patil <anupamakpatil123@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Adam <developer@arusty.dev>, bkkarthik@pesu.pes.edu,
        gregkh@linuxfoundation.org, kernelnewbies@kernelnewbies.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210422180322.7wlyg63kv3n2k6id@ubuntu>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <ea09f455-a00f-a13d-29d8-e3f9790dba56@linuxfoundation.org>
Date:   Fri, 23 Apr 2021 15:08:03 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210422180322.7wlyg63kv3n2k6id@ubuntu>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 4/22/21 12:03 PM, Anupama K Patil wrote:
> de, e are two variables of the type 'struct proc_dir_entry'
> which can be removed to save memory. This also fixes a coding style
> issue reported by checkpatch where we are suggested to make assignment
> outside the if statement.
> 

Sounds like a reasonable change.

> Signed-off-by: Anupama K Patil <anupamakpatil123@gmail.com>
> ---
>   drivers/pnp/isapnp/proc.c | 13 ++++++-------
>   1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/pnp/isapnp/proc.c b/drivers/pnp/isapnp/proc.c
> index 785a796430fa..1ae458c02656 100644
> --- a/drivers/pnp/isapnp/proc.c
> +++ b/drivers/pnp/isapnp/proc.c
> @@ -57,21 +57,20 @@ static const struct proc_ops isapnp_proc_bus_proc_ops = {
>   static int isapnp_proc_attach_device(struct pnp_dev *dev)
>   {
>   	struct pnp_card *bus = dev->card;
> -	struct proc_dir_entry *de, *e;
>   	char name[16];
>   
> -	if (!(de = bus->procdir)) {
> +	if (!bus->procdir) {
>   		sprintf(name, "%02x", bus->number);

It would make sense to change this to scnprintf()

> -		de = bus->procdir = proc_mkdir(name, isapnp_proc_bus_dir);
> -		if (!de)
> +		bus->procdir = proc_mkdir(name, isapnp_proc_bus_dir);
> +		if (!bus->procdir)
>   			return -ENOMEM;
>   	}
>   	sprintf(name, "%02x", dev->number);

It would make sense to change this to scnprintf()

> -	e = dev->procent = proc_create_data(name, S_IFREG | S_IRUGO, de,
> +	dev->procent = proc_create_data(name, S_IFREG | S_IRUGO, bus->procdir,
>   					    &isapnp_proc_bus_proc_ops, dev);
> -	if (!e)
> +	if (!dev->procent)
>   		return -ENOMEM;

Shouldn't the procdir be deleted when proc_create_data() fails?

> -	proc_set_size(e, 256);
> +	proc_set_size(dev->procent, 256);
>   	return 0;
>   }
>   
> 

Note that isapnp_proc_init() doesn't check isapnp_proc_attach_device()
return and handle errors and cleanup.

thanks,
-- Shuah


