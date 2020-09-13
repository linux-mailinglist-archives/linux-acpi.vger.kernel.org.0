Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD4E52681B4
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Sep 2020 00:33:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725949AbgIMWdc (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 13 Sep 2020 18:33:32 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:41349 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbgIMWd1 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 13 Sep 2020 18:33:27 -0400
Received: from mail-pj1-f69.google.com ([209.85.216.69])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <alex.hung@canonical.com>)
        id 1kHaYm-0000Bt-Ct
        for linux-acpi@vger.kernel.org; Sun, 13 Sep 2020 22:33:24 +0000
Received: by mail-pj1-f69.google.com with SMTP id q12so1527487pjg.9
        for <linux-acpi@vger.kernel.org>; Sun, 13 Sep 2020 15:33:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rEKlKZmh/1YZMbvfsNtQ59gLQC9wICTVNrBlPswdPyM=;
        b=ZMC8IEhi7O/+2En3YexD1kyaNRqc6OoxB+1w1yXkHJVv4RyEqHSApFQBzXSRDj24SP
         PrZFcfjCwWOgWft6iQjbfrcGyii0XK9SlUt6VJJVlve5t3kuLBYVGnk9C0OgQpgQISRx
         St6oZlMAObykGXIbAH3DgIsQ5JsSB5Wa84PmP/5uLky575+FQ9VIBuVDV/HhazLRKuSZ
         JVI5eEjqW/qklWY5KKz3BCOet579wPx9bbeZ+/mMHlZc69ut1eZRUHA/I/cz3B2z86xp
         hMUgCyn4IHS1kfmDAemw8kPZKsIR+JKybaXnwnPBYZ5C+F3p5PBtlcO9Xk89gEgNnw7D
         6nQg==
X-Gm-Message-State: AOAM530uwwgyF4pCbOg8cHLAp3IUWzFgvDtQTPD1EvRbSlisPoiKE7VM
        ivELjFb8q9+BLiz7XIGzjuQkYCL0pX+QkAytV9NfaqXomYHou8s35nzuEbGo7oNOsE4NlWfzlCU
        nj2B2kCZ82s+WDMzK+wBEsVhRtFXC/yfrOSqEsCo=
X-Received: by 2002:a17:90a:2ec8:: with SMTP id h8mr11530599pjs.173.1600036402794;
        Sun, 13 Sep 2020 15:33:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzosOtxUbpPgTZbDQitLsYRQmDKVbBLcnbz36bOMEnqd19xG9jTA7kwvfXHZfIm0tWP+W4A3w==
X-Received: by 2002:a17:90a:2ec8:: with SMTP id h8mr11530584pjs.173.1600036402461;
        Sun, 13 Sep 2020 15:33:22 -0700 (PDT)
Received: from [192.168.0.119] (d66-222-144-129.abhsia.telus.net. [66.222.144.129])
        by smtp.gmail.com with ESMTPSA id c3sm8428906pfo.120.2020.09.13.15.33.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Sep 2020 15:33:21 -0700 (PDT)
Subject: Re: [PATCH] ACPI: video: use ACPI backlight for HP 635 Notebook
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org,
        All applicable <stable@vger.kernel.org>
References: <20200911221420.21692-1-alex.hung@canonical.com>
 <20200912064900.GB558156@kroah.com>
From:   Alex Hung <alex.hung@canonical.com>
Message-ID: <dcd820c5-619c-bd18-4d38-4a4cab38a2f4@canonical.com>
Date:   Sun, 13 Sep 2020 16:33:20 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200912064900.GB558156@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2020-09-12 12:49 a.m., Greg KH wrote:
> On Fri, Sep 11, 2020 at 04:14:20PM -0600, Alex Hung wrote:
>> Default backlight interface is AMD's radeon_bl0 which does not work on
>> this system. As a result, let's for ACPI backlight interface for this
>> system.
>>
>> BugLink: https://bugs.launchpad.net/bugs/1894667
>>
>> Cc: All applicable <stable@vger.kernel.org>
>> Signed-off-by: Alex Hung <alex.hung@canonical.com>
>> ---
>>  drivers/acpi/video_detect.c | 9 +++++++++
>>  1 file changed, 9 insertions(+)
>>
>> diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
>> index 2499d7e..05047a3 100644
>> --- a/drivers/acpi/video_detect.c
>> +++ b/drivers/acpi/video_detect.c
>> @@ -282,6 +282,15 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
>>  		DMI_MATCH(DMI_PRODUCT_NAME, "530U4E/540U4E"),
>>  		},
>>  	},
>> +	/* https://bugs.launchpad.net/bugs/1894667 */
>> +	{
>> +	 .callback = video_detect_force_video,
>> +	 .ident = "HP 635 Notebook",
>> +	 .matches = {
>> +		DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
>> +		DMI_MATCH(DMI_PRODUCT_NAME, "HP 635 Notebook PC"),
>> +		},
>> +	},
>>  
>>  	/* Non win8 machines which need native backlight nevertheless */
>>  	{
>> -- 
>> 2.7.4
>>
> 
> <formletter>
> 
> This is not the correct way to submit patches for inclusion in the
> stable kernel tree.  Please read:
>     https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
> for how to do this properly.
> 
> </formletter>
> 

Sorry about this.

I will send V2 to correct it to "Cc: stable@vger.kernel.org"


-- 
Cheers,
Alex Hung
