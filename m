Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15CC62B995D
	for <lists+linux-acpi@lfdr.de>; Thu, 19 Nov 2020 18:37:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728672AbgKSRf5 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 19 Nov 2020 12:35:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728175AbgKSRf4 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 19 Nov 2020 12:35:56 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B6F2C0613CF;
        Thu, 19 Nov 2020 09:35:56 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id y4so6701433edy.5;
        Thu, 19 Nov 2020 09:35:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RsLldTWt03SahwoT1u6jHBmnbvDuG2f1cJeVhx0lFZ8=;
        b=SFwmYQB+4kmPYts35/QnmiJX0+vl5jvjmY0xEwO5yDf/g4dSemKlTPwdszyGBcplGz
         fccg8jT13IuNz8CsGrzCHYfXlqXLFJ0iXB5ArnK+Ki4KRbWeMH1RMjY4AnOHQPrUVj3M
         Bs/1z+L8yMtUGeKUIhmEilTpZ1psIsVJzx0gEw+kHdoiBnRHeFhqWY/ggycQ5dMTTTID
         vNAkAlxvytqCTTKlej3JsLZaqUkCW0sWW6t50kxdW6KKBoDSg7w4owv4BRNEdA29R3hN
         svwLv+iaHIdLPTnqH8xb1KPr8AFcukyU0pd/5xA2rriNNeKx7iMbZK2V41Icucn0W4Wf
         rixA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RsLldTWt03SahwoT1u6jHBmnbvDuG2f1cJeVhx0lFZ8=;
        b=T7Zt5ItrJF8BU+BFbS1bSbRNLblva5bSGq8is9JFHNxlsRwe0f1NoRzTNGTNmzdrRU
         pXnEDcZJySUOxftT5QwtdOBqMWO8B9qjMX33qw9u8/JTeEdY/jqZUWHLPEmjSmfCr8ug
         NGY5BIbBNblSGjI6RQPC3n8CZrKva5f1aGxeCUfMSLnPrgOiCpzQ6zELjCcQO880pwj2
         axlIlg/erTSuzu+Atcwy92y4dsRx2WiuRbMyxobGEy8ERIQZnis0CgfQicRN05ATs8tW
         2Bi8azfuyIwN3bl3H+JleRBZQmGaPQRZy6+O1F/3gUOpJFktZCfFr9sosSCiBVvCNN8Y
         VeKw==
X-Gm-Message-State: AOAM532b8mKyNXoLq8x1t46PmvrMf1JPJfn/ADEsPG+sYLBwhsmcKMTX
        GTz/qev2ALHTToLZ5bLjFi8gT8zeqVk=
X-Google-Smtp-Source: ABdhPJx8xcX+oCllV118F+qizS9a6k5G+ecvcPOmKCsWERgrd3uKaRzfuwnJs53h5xdlOCJBs6H0Cw==
X-Received: by 2002:a05:6402:1119:: with SMTP id u25mr33723485edv.37.1605807354723;
        Thu, 19 Nov 2020 09:35:54 -0800 (PST)
Received: from [192.168.2.202] (pd9ea3084.dip0.t-ipconnect.de. [217.234.48.132])
        by smtp.gmail.com with ESMTPSA id a1sm66889edk.52.2020.11.19.09.35.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Nov 2020 09:35:53 -0800 (PST)
Subject: Re: [PATCH 1/9] platform/surface: Add Surface Aggregator subsystem
To:     =?UTF-8?Q?Barnab=c3=a1s_P=c5=91cze?= <pobrn@protonmail.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        =?UTF-8?Q?Bla=c5=be_Hrastnik?= <blaz@mxxn.io>,
        Dorian Stoll <dorian.stoll@tmsp.io>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
References: <20201115192143.21571-1-luzmaximilian@gmail.com>
 <20201115192143.21571-2-luzmaximilian@gmail.com>
 <nJyowYoxGM_0dU6iqDLowrPuVIErZbgZLAkXASFlEKvvSkgGtLxGQ7wGFDpXAaqAc3wourELsji6s3lO7N4aHOb8sK0wI500Oq5ZMdeZwJ8=@protonmail.com>
 <68af3474-b576-da7e-2b11-3aa4c319cceb@gmail.com>
 <5Qk-wNPtfpjNiK7HHId4qBNTWj9K_2h7fNe15o2J80gZsrSOfVYoKzdzPE8-r3NT7PLjxIgx08YLv2s38CWROho_womMqN2yGl3v13dJlMg=@protonmail.com>
From:   Maximilian Luz <luzmaximilian@gmail.com>
Message-ID: <dc6cc00a-4761-96e7-78f6-99dbf2447bad@gmail.com>
Date:   Thu, 19 Nov 2020 18:35:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <5Qk-wNPtfpjNiK7HHId4qBNTWj9K_2h7fNe15o2J80gZsrSOfVYoKzdzPE8-r3NT7PLjxIgx08YLv2s38CWROho_womMqN2yGl3v13dJlMg=@protonmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 11/19/20 4:54 PM, Barnabás Pőcze wrote:
> Hi

[...]

>>>> +enum ssam_ssh_tc {
>>>> +	/* Known SSH/EC target categories. */
>>>> +				// category 0x00 is invalid for EC use
>>>> +	SSAM_SSH_TC_SAM = 0x01,	// generic system functionality, real-time clock
>>>> +	SSAM_SSH_TC_BAT = 0x02,	// battery/power subsystem
>>>> +	SSAM_SSH_TC_TMP = 0x03,	// thermal subsystem
>>>> +	SSAM_SSH_TC_PMC = 0x04,
>>>> +	SSAM_SSH_TC_FAN = 0x05,
>>>> +	SSAM_SSH_TC_PoM = 0x06,
>>>> +	SSAM_SSH_TC_DBG = 0x07,
>>>> +	SSAM_SSH_TC_KBD = 0x08,	// legacy keyboard (Laptop 1/2)
>>>> +	SSAM_SSH_TC_FWU = 0x09,
>>>> +	SSAM_SSH_TC_UNI = 0x0a,
>>>> +	SSAM_SSH_TC_LPC = 0x0b,
>>>> +	SSAM_SSH_TC_TCL = 0x0c,
>>>> +	SSAM_SSH_TC_SFL = 0x0d,
>>>> +	SSAM_SSH_TC_KIP = 0x0e,
>>>> +	SSAM_SSH_TC_EXT = 0x0f,
>>>> +	SSAM_SSH_TC_BLD = 0x10,
>>>> +	SSAM_SSH_TC_BAS = 0x11,	// detachment system (Surface Book 2/3)
>>>> +	SSAM_SSH_TC_SEN = 0x12,
>>>> +	SSAM_SSH_TC_SRQ = 0x13,
>>>> +	SSAM_SSH_TC_MCU = 0x14,
>>>> +	SSAM_SSH_TC_HID = 0x15,	// generic HID input subsystem
>>>> +	SSAM_SSH_TC_TCH = 0x16,
>>>> +	SSAM_SSH_TC_BKL = 0x17,
>>>> +	SSAM_SSH_TC_TAM = 0x18,
>>>> +	SSAM_SSH_TC_ACC = 0x19,
>>>> +	SSAM_SSH_TC_UFI = 0x1a,
>>>> +	SSAM_SSH_TC_USC = 0x1b,
>>>> +	SSAM_SSH_TC_PEN = 0x1c,
>>>> +	SSAM_SSH_TC_VID = 0x1d,
>>>> +	SSAM_SSH_TC_AUD = 0x1e,
>>>> +	SSAM_SSH_TC_SMC = 0x1f,
>>>> +	SSAM_SSH_TC_KPD = 0x20,
>>>> +	SSAM_SSH_TC_REG = 0x21,
>>>> +};
>>>
>>> Is it known what these abbreviations stand for? Maybe I missed them?
>>
>> The comments state all we really know about these (through observation
>> and experimentation). The table itself has been extracted from the
>> Windows driver, but the abbreviations and values are all we're getting
>> from it.
> 
> I see, thanks for the clarification. For some reason, I believed the
> "Known SSH/EC target categories" comment means that those are known, as in,
> it is known what they are for, etc., not just the abbreviation.

Right, that can be misunderstood, sorry. It's probably best if I add a
comment explaining that in a bit more detail and noting where those
values and abbreviations come from.

Thanks,
Max
