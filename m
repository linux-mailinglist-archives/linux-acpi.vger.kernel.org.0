Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ACFE2BBCEF
	for <lists+linux-acpi@lfdr.de>; Sat, 21 Nov 2020 05:14:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726324AbgKUEOR (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 20 Nov 2020 23:14:17 -0500
Received: from mail1.bemta24.messagelabs.com ([67.219.250.115]:47256 "EHLO
        mail1.bemta24.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725944AbgKUEOR (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 20 Nov 2020 23:14:17 -0500
Received: from [100.112.133.178] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-4.bemta.az-b.us-west-2.aws.symcld.net id 48/7A-49214-51498BF5; Sat, 21 Nov 2020 04:14:13 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGKsWRWlGSWpSXmKPExsWS8eIhj67olB3
  xBp/2i1jsvy5h0bXQwGLh/VOsFl+/3Wa3eHN8OpPF8n39jBZNnU1sFp87JrNYrN7zgtli7Zd5
  bBZnTl9ideD2mDRzBrPHzll32T1+bVvD4rF5hZbHvJOBHj1tm5g83u+7yuax5Wo7i8fnTXIBn
  FGsmXlJ+RUJrBmfJq1lKugTqHg+ez1TA+Mm3i5GLg4hgf+MEs9Xz2KFcF4yStw+18TcxcjJIS
  wQI/Fj72SWLkYODhEBe4kXT4JAapgFmlkkmm89YIJouMooMXHNJUaQBjYBbYktW36xgdi8ArY
  Sy2beYAexWQRUJX78aWICsUUFwiXWL1nJCFEjKHFy5hMWkEGcAl2MEpN3XmAFSTALWEjMnH+e
  EcIWl7j1ZD4ThC0v0bx1Nth1EgKKEvvuX2SBsBMklr28wzyBUXAWkrmzkIyahWTULCSjFjCyr
  GI0TyrKTM8oyU3MzNE1NDDQNTQ00jU0NtI1M9ZLrNJN0ist1i1PLS7RNdJLLC/WK67MTc5J0c
  tLLdnECIzOlIIW+x2MM9580DvEKMnBpCTKW5G0I16ILyk/pTIjsTgjvqg0J7X4EKMMB4eSBK/
  TZKCcYFFqempFWmYOMFHApCU4eJREeLVA0rzFBYm5xZnpEKlTjIpS4rzCIAkBkERGaR5cGyw5
  XWKUlRLmZWRgYBDiKUgtys0sQZV/xSjOwagkzHtkEtAUnsy8Erjpr4AWMwEt3i4CtrgkESEl1
  cCkEd/IvuXARtdT1/cW9V781bfv8IwvLqdbim/6H7O7vn65UIeQ2o/7nRvkLqo9+2z4a2JMnZ
  vu7rPLbioU3feYxnm8Pvjp4khel4v/G5cZx15et//74mWi95zf83qGmv/L3pu2Mrg8k1u2h20
  Ne7Oo+xXB0+suXXucdttMdhrLn9XBGYcjA8T+M/Mz/HYpeaQRUCTUW/BitY3Aif/Od+X1T0/b
  uS1A93L8pbhSMweVnC3nZsxKUGk5vv7J0cVVrRq6vg9kJ13fKHPsaxdf3eMKpR97rc/1nru76
  uE+u0XFbRdd5/zXKxflk0k76rTP/m9/yLF375IOXzFpMt7FE/X04k333G/JClFWSo486zaeUm
  Ipzkg01GIuKk4EAJ4dIJbJAwAA
X-Env-Sender: markpearson@lenovo.com
X-Msg-Ref: server-22.tower-355.messagelabs.com!1605932052!35062!1
X-Originating-IP: [104.232.225.12]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.60.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 29451 invoked from network); 21 Nov 2020 04:14:13 -0000
Received: from unknown (HELO lenovo.com) (104.232.225.12)
  by server-22.tower-355.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 21 Nov 2020 04:14:13 -0000
Received: from reswpmail04.lenovo.com (unknown [10.62.32.23])
        (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by Forcepoint Email with ESMTPS id B61C6492923CCD901C04;
        Fri, 20 Nov 2020 23:14:11 -0500 (EST)
Received: from localhost.localdomain (10.38.107.236) by reswpmail04.lenovo.com
 (10.62.32.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2044.4; Fri, 20 Nov
 2020 20:14:10 -0800
Subject: Re: [External] Re: [PATCH v3] ACPI: platform-profile: Add platform
 profile support
To:     =?UTF-8?Q?Barnab=c3=a1s_P=c5=91cze?= <pobrn@protonmail.com>
CC:     "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
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
From:   Mark Pearson <markpearson@lenovo.com>
Message-ID: <7533ec90-9c8a-d7f8-8987-d0dc23826ade@lenovo.com>
Date:   Fri, 20 Nov 2020 23:14:09 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <nRyY5CKaU6WrkbMiM25gTT_bJlrQjTY_UCcQkj8ty-2mPEMVZd4BB9KwrRp7z4GaE3TTOFCXuXnt0_7J_Tj50syusBxTmS5yNZAvYX02X74=@protonmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.38.107.236]
X-ClientProxiedBy: reswpmail04.lenovo.com (10.62.32.23) To
 reswpmail04.lenovo.com (10.62.32.23)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



On 20/11/2020 14:50, Barnabás Pőcze wrote:
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
> 
> 
> Regards,
> Barnabás Pőcze
> 
Good point. I'd like to have input from user space as to their 
preference - it seems like a simple enough change to make and I'm happy 
to go with what their preferences are. Bastien - would this make life 
easier for you?

Perhaps when the provider unregisters it sends a sysfs_notify and user 
space can look and detect/handle that condition (I think it will get 
EOPNOTSUPP on the next read). Is there something cleverer it can do?

Thanks
Mark
