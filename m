Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 918B62BBFE7
	for <lists+linux-acpi@lfdr.de>; Sat, 21 Nov 2020 15:28:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727835AbgKUO1o (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 21 Nov 2020 09:27:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:50441 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727531AbgKUO1n (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Sat, 21 Nov 2020 09:27:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605968861;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I6J3CFPa6tD+HSofD8tcjcXRTFclUnvVy0S97JTMikM=;
        b=CGRVSb+Nw1IEkXuYxa7YEUpW7OBFDrnmv6lC/NYZdV/Tk0rwu7Dtk0UiXRDNZbiHEsmfgu
        CnoY5XB0ER372sxOqfIJEkf1uXZPJa0Se4h/CxefduUyOYk/5v/FVlk+sh/V6vTaoaSXsU
        9DNz+78t/18B52yI83Pj1Oe3Ojs95/c=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-576-N9NjRuqmMNGZgImnkRXsVg-1; Sat, 21 Nov 2020 09:27:40 -0500
X-MC-Unique: N9NjRuqmMNGZgImnkRXsVg-1
Received: by mail-ed1-f69.google.com with SMTP id v7so4833926edy.4
        for <linux-acpi@vger.kernel.org>; Sat, 21 Nov 2020 06:27:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=I6J3CFPa6tD+HSofD8tcjcXRTFclUnvVy0S97JTMikM=;
        b=Ll/yTU90EoGGmJ/Qr1Xl4adYN9tXgGkKmu9EYBSOlfmVkvGCad4+SMzYGmEiUgv7ys
         v88x6piOkQLHwkVQRUckynDs5ftpiYfmfhgsuYgyev2YXmJRoc1uLn/N2Vgqjrb2WhlO
         ODvDguaUAwhrQpGquFq1+FR9j6jNvWHGia1DE2hOyLP3asTtj4d399KvubsrBuMAKPny
         lqsJNX+32S67BsgttpHkCKdOWxI1oJOIOaIma9v5jU6pw7qYthx6tHFeCRtmO+2H00iX
         XPu4tjyMQA1IxUWQeiS9JiTaRSv4u3MGJu97oQbwxaiiaKc8CahNojDRyNg+nrfeKU7Z
         J9rg==
X-Gm-Message-State: AOAM533f3qxXLh6URjFe2tuQo6eSnKqJGuNY+3ZnMAgveBQO1HdOQ5p2
        tKsC/xq13F2P+EDZ81yS8iED0ZQnJDZYyDNB5Eh9ZLkS59uszsmE4PKzzU0juH069zLdzxkFWOH
        yNp+UE1/LV0xXvb4+8RUeEg==
X-Received: by 2002:a17:906:4712:: with SMTP id y18mr35993635ejq.51.1605968858874;
        Sat, 21 Nov 2020 06:27:38 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx1qAnebKymK+pyT4JAQ5QTkWsY3FZNVj7U9WtSJWXKnvEvq3hI5rxyzxkfklLG94YQhKHa8A==
X-Received: by 2002:a17:906:4712:: with SMTP id y18mr35993611ejq.51.1605968858623;
        Sat, 21 Nov 2020 06:27:38 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-6c10-fbf3-14c4-884c.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:6c10:fbf3:14c4:884c])
        by smtp.gmail.com with ESMTPSA id b21sm2504825ejg.93.2020.11.21.06.27.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Nov 2020 06:27:38 -0800 (PST)
Subject: Re: [PATCH v3] ACPI: platform-profile: Add platform profile support
To:     =?UTF-8?Q?Barnab=c3=a1s_P=c5=91cze?= <pobrn@protonmail.com>,
        Mark Pearson <markpearson@lenovo.com>
Cc:     "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "mario.limonciello@dell.com" <mario.limonciello@dell.com>,
        "eliadevito@gmail.com" <eliadevito@gmail.com>,
        "hadess@hadess.net" <hadess@hadess.net>,
        "bberg@redhat.com" <bberg@redhat.com>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "dvhart@infradead.org" <dvhart@infradead.org>
References: <markpearson@lenovo.com>
 <20201115004402.342838-1-markpearson@lenovo.com>
 <nRyY5CKaU6WrkbMiM25gTT_bJlrQjTY_UCcQkj8ty-2mPEMVZd4BB9KwrRp7z4GaE3TTOFCXuXnt0_7J_Tj50syusBxTmS5yNZAvYX02X74=@protonmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <761671b3-ad26-230b-e709-05ce3bd69498@redhat.com>
Date:   Sat, 21 Nov 2020 15:27:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <nRyY5CKaU6WrkbMiM25gTT_bJlrQjTY_UCcQkj8ty-2mPEMVZd4BB9KwrRp7z4GaE3TTOFCXuXnt0_7J_Tj50syusBxTmS5yNZAvYX02X74=@protonmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 11/20/20 8:50 PM, Barnabás Pőcze wrote:
> Hi
> 
> 
> 2020. november 15., vasárnap 1:44 keltezéssel, Mark Pearson írta:
> 
>> [...]
>> +int platform_profile_register(struct platform_profile_handler *pprof)
>> +{
>> +	mutex_lock(&profile_lock);
>> +	/* We can only have one active profile */
>> +	if (cur_profile) {
>> +		mutex_unlock(&profile_lock);
>> +		return -EEXIST;
>> +	}
>> +
>> +	cur_profile = pprof;
>> +	mutex_unlock(&profile_lock);
>> +	return sysfs_create_group(acpi_kobj, &platform_profile_group);
>> +}
>> +EXPORT_SYMBOL_GPL(platform_profile_register);
>> +
>> +int platform_profile_unregister(void)
>> +{
>> +	mutex_lock(&profile_lock);
>> +	sysfs_remove_group(acpi_kobj, &platform_profile_group);
>> +	cur_profile = NULL;
>> +	mutex_unlock(&profile_lock);
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(platform_profile_unregister);
>> [...]
> 
> 
> I just realized that the sysfs attributes are only created if a profile provider
> is registered, and it is removed when the provide unregisters itself. I believe
> it would be easier for system daemons if those attributes existed from module load
> to module unload since they can just just open the file and watch it using poll,
> select, etc. If it goes away when the provider unregisters itself, then I believe
> a more complicated mechanism (like inotify) would need to be implemented in the
> daemons to be notified when a new provider is registered. Thus my suggestion
> for the next iteration is to create the sysfs attributes on module load,
> and delete them on unload.
> 
> What do you think?

Actually I asked Mark to move this to the register / unregister time since
having a non functioning files in sysfs is a bit weird.

You make a good point about userspace having trouble figuring when this will
show up though (I'm not worried about removal that will normally never happen).

I would expect all modules to be loaded before any interested daemons load,
but that is an assumption and I must admit that that is a bit racy.

Bastien, what do you think about Barnabás' suggestion to always have the
files present and use poll (POLL_PRI) on it to see when it changes, listing
maybe "none" as available profiles when there is no provider?

Regards,

Hans

