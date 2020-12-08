Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71E3D2D2D69
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Dec 2020 15:46:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729601AbgLHOpE (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 8 Dec 2020 09:45:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:49196 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727716AbgLHOpD (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 8 Dec 2020 09:45:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607438616;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Cfa7wLpbxuEZq+R+bI/0NtkJcPb3sJm2JZkzYyHbJ5Q=;
        b=HVah9qDgV+SP6M9VQgyO1bv/7XqZ0qJnL+CF0iSf2QeIBmI2kkFd5FbxMAuaMKjdtl29VW
        TybudDAYnpRzeQ99knKrm+L0Ttfkh/e/n66vsKBCoh2+vBFl71Q2C2lXu9sZZtdC3m8+6H
        49qClm+dOi8cr1mDk2wf1sCfirjdkJE=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-368-MkQ1sPE-MhWvUUURVkOGKw-1; Tue, 08 Dec 2020 09:43:35 -0500
X-MC-Unique: MkQ1sPE-MhWvUUURVkOGKw-1
Received: by mail-ed1-f69.google.com with SMTP id cq17so4059712edb.17
        for <linux-acpi@vger.kernel.org>; Tue, 08 Dec 2020 06:43:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Cfa7wLpbxuEZq+R+bI/0NtkJcPb3sJm2JZkzYyHbJ5Q=;
        b=YeYVFAy4IXjRDOxPj7nzNPpUidpaImGo4XQ78SNsYN7RdYGvEQOXnQeNjGPsqzRKSp
         UPGHWwZQ9B+gjOCfDglYoZLJspyK6AXNkOZ0Gv+38aZ157Ue1TfGjy6I7pRC2b5RdSjy
         sELIlMHdlaMdyywAzgFJSm8TQdOgR+hcntcuHFSBTYcdHs6Rxq2S72l3+EI7cqh+CSxO
         xL5wNSkr3Fn8n6U7McmNMLkf9xCxLKLYXq5Y7N8pcREmZQupqlaIrs+wRLjIztRNizvx
         AjAsqYRNpZRxC44MQopaKEcHAk68wZkAnPh51ehzTauX5ozhHwB40HNR+Em0GABMeVb0
         hlAw==
X-Gm-Message-State: AOAM53224YX2J8bsUTaPoBtj5A1ziEotACVdcs2y9hu1xWodUsqKOzUK
        DjNt6ktmwh3IzTVBeZ2qy05pgvwSOQ1jRqkwdnlNE5nCKhVuL7QXPun+DU4PJRRqsP8tFzi/Ckr
        VGyQmau9+0rvxKjXDgJVRTaegRncQ67SZztHLE2DJQx58Yagejq6qClAli95jxBxLCLIDo+4y6g
        ==
X-Received: by 2002:aa7:c355:: with SMTP id j21mr15707889edr.338.1607438613816;
        Tue, 08 Dec 2020 06:43:33 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxVK8XivqJ/1pcRHYJCIxWdI292tXW8b7gOaiPbwlEw7m6LZ2VDFHJf49ClPgz7+ckFHOSH7g==
X-Received: by 2002:aa7:c355:: with SMTP id j21mr15707853edr.338.1607438613544;
        Tue, 08 Dec 2020 06:43:33 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id d14sm18083317edn.31.2020.12.08.06.43.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Dec 2020 06:43:32 -0800 (PST)
Subject: Re: [PATCH v2 1/9] platform/surface: Add Surface Aggregator subsystem
To:     Maximilian Luz <luzmaximilian@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Mark Gross <mgross@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        =?UTF-8?Q?Barnab=c3=a1s_P=c5=91cze?= <pobrn@protonmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        =?UTF-8?Q?Bla=c5=be_Hrastnik?= <blaz@mxxn.io>,
        Dorian Stoll <dorian.stoll@tmsp.io>,
        platform-driver-x86@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-acpi@vger.kernel.org
References: <20201203212640.663931-1-luzmaximilian@gmail.com>
 <20201203212640.663931-2-luzmaximilian@gmail.com>
 <fd24d99a-e4f4-2030-e9bb-bcd549ce4bb9@redhat.com>
 <ac50a0c7-806e-d949-6440-620ec966099a@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <9748d778-b5e9-c80c-5968-a77b3203d769@redhat.com>
Date:   Tue, 8 Dec 2020 15:43:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <ac50a0c7-806e-d949-6440-620ec966099a@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 12/8/20 3:37 PM, Maximilian Luz wrote:

<snip>

>>> +
>>> +    obj = acpi_evaluate_dsm_typed(handle, &SSAM_SSH_DSM_GUID,
>>> +                      SSAM_SSH_DSM_REVISION, func, NULL,
>>> +                      ACPI_TYPE_INTEGER);
>>> +    if (!obj)
>>> +        return -EIO;
>>> +
>>> +    val = obj->integer.value;
>>> +    ACPI_FREE(obj);
>>> +
>>> +    if (val > U32_MAX)
>>> +        return -ERANGE;
>>> +
>>> +    *ret = val;
>>> +    return 0;
>>> +}
> 
> [...]
> 
>>> +/**
>>> + * ssam_controller_start() - Start the receiver and transmitter threads of the
>>> + * controller.
>>> + * @ctrl: The controller.
>>> + *
>>> + * Note: When this function is called, the controller should be properly
>>> + * hooked up to the serdev core via &struct serdev_device_ops. Please refer
>>> + * to ssam_controller_init() for more details on controller initialization.
>>> + *
>>> + * This function must be called from an exclusive context with regards to the
>>> + * state, if necessary, by locking the controller via ssam_controller_lock().
>>
>> Again you are being a bit hand-wavy (I assume you know what I mean by that)
>> wrt the locking requirements. If possible I would prefer clearly spelled out
>> locking requirements in the form of "this and that lock must be held when
>> calling this function". Preferably backed-up by lockdep_assert-s asserting
>> these conditions.
> 
> The reason for this is that this function specifically is currently only
> called during initialization, when the controller has not been published
> yet, i.e. when we have an exclusive reference to the controller.
> 
> I'll change this to fully enforce locking (with lockdep_assert).
> 
>> And maybe if you are a bit stricter with always holding the lock when
>> calling this, you can also drop the WRITE_ONCE and the comment about it
>> (in all places where you do this).
> 
> The WRITE_ONCE is only there to ensure that the basic test in
> ssam_request_sync_submit() can be done. I always try to be explicit
> about access that can happen without the respective locks being held.

Yes I saw the matching READ_ONCE later on (as the comment indicated
I would), which made it more obvious to me why the WRITE_ONCE is here,'
so maybe I should have gone back and updated this comment.

Anyways, keeping the WRITE_ONCE + READ_ONCE for this is fine.

> Unfortunately it's not feasible to hold the reader lock in
> ssam_request_sync_submit() due to reentrancy. Specifically, as the lock,
> if at all (i.e. if this is not a client driver bound to the controller),
> must be held not only during submission but until the request has been
> completed. Note that if we would hold the lock during submission, this
> is just a smoke-test.

Ack.

<more snip>

Regards,

Hans

