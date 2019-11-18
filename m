Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D7B3100B4F
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Nov 2019 19:18:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726216AbfKRSSF (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 18 Nov 2019 13:18:05 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22245 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726836AbfKRSSA (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 18 Nov 2019 13:18:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574101079;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7a2sQxq8FNQ+8pCSuYp/IMTI0Z9YDDsR/zvu9j4ygdY=;
        b=ZVanbobA11V1hDb5+9BHBGY/2YejnhKQbQLd6yx7/3rk2PSEmqsLwDds1vYsbyZxyf/xbA
        PJXgQmheSzO9yn2AWZMu4Ml2fUaxInwfX2+OB22v8eZYeIFZevcHDRQL9V5xxHOdi34C8N
        zUVmYsNpmhQMM9A1Bi7eCabVc+WiyEk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-1-kREUAVHfMwy59ZhodnpjzQ-1; Mon, 18 Nov 2019 13:17:58 -0500
Received: by mail-wm1-f70.google.com with SMTP id f11so212209wmc.8
        for <linux-acpi@vger.kernel.org>; Mon, 18 Nov 2019 10:17:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uW103q4WGDWPJKaH/HSYdC7bLmZl02TtSh9WC4TZwDo=;
        b=OwAqrhWox8e9+R1dx4jM06jnzBH7/aM9TDm+djlJGdP4xECt/OOlIt4vmAs2JMiWNA
         2RWsaTQeZnWveUhi9q4G+shIFV5Izrsu7lvEsNLRUJBYYoPDq1u2NJ1dl8u+hAaHSc7o
         UsEbw5HF4EByHmW53U3dXPm3bVqzboKps84tTHVbIAWeKj1hhB7/7vDrHbyLOTNhYMjQ
         rjhwqgBSYoIf6ZtFsa+qZTjjGWm+U/x7aqkFNkx4wSDU/pTapr7epI6Sx8KYBwqwrx1O
         eZulYcjvS36aNu/zqyBEz6ddBJlt3mO5EriQqA+00VozzCQQ2DHGgCl6JREnOAcUlflo
         LhZQ==
X-Gm-Message-State: APjAAAXEZk0ozMDxoqfpM7/x+gZkxd3BOsL/rrX8hDtpY1wR6iq08GBF
        mKF+Lo0KDsLGEDP2l/a+e6w9ggb1nB23xkYkIGCLzDXEt+aObSIQr+nMshtmUoBvkb0vdizYvsB
        v3AtIUOFYALiN0MMEpDU9hg==
X-Received: by 2002:a7b:c549:: with SMTP id j9mr535961wmk.88.1574101076598;
        Mon, 18 Nov 2019 10:17:56 -0800 (PST)
X-Google-Smtp-Source: APXvYqxS+VYwrV074+uErw6DHjBLFk267Ko2kapa1u8wEoZcfEixmi4NHs2dcG3Pdk+bEypXrLmUqA==
X-Received: by 2002:a7b:c549:: with SMTP id j9mr535935wmk.88.1574101076356;
        Mon, 18 Nov 2019 10:17:56 -0800 (PST)
Received: from shalem.localdomain (84-106-84-65.cable.dynamic.v4.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id f17sm155985wmj.40.2019.11.18.10.17.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Nov 2019 10:17:55 -0800 (PST)
Subject: Re: [PATCH 0/1] pinctrl: baytrail: Really serialize all register
 accesses
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org
References: <20191118142020.22256-1-hdegoede@redhat.com>
 <20191118172320.GX32742@smile.fi.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <55af4a58-f5f9-0346-45ea-15e970a32415@redhat.com>
Date:   Mon, 18 Nov 2019 19:17:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20191118172320.GX32742@smile.fi.intel.com>
Content-Language: en-US
X-MC-Unique: kREUAVHfMwy59ZhodnpjzQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 18-11-2019 18:23, Andy Shevchenko wrote:
> On Mon, Nov 18, 2019 at 03:20:19PM +0100, Hans de Goede wrote:
>> Hi All,
>>
>> First let me copy-paste a bit of the commit msg for background:
>>
>> ---begin commit msg---
>> Commit 39ce8150a079 ("pinctrl: baytrail: Serialize all register access")
>> added a spinlock around all register accesses because:
>>
>> "There is a hardware issue in Intel Baytrail where concurrent GPIO regis=
ter
>>   access might result reads of 0xffffffff and writes might get dropped
>>   completely."
>>
>> Testing has shown that this does not catch all cases, there are still
>> 2 problems remaining
>>
>> 1) The original fix uses a spinlock per byt_gpio device / struct,
>> additional testing has shown that this is not sufficient concurent
>> accesses to 2 different GPIO banks also suffer from the same problem.
>>
>> This commit fixes this by moving to a single global lock.
>>
>> 2) The original fix did not add a lock around the register accesses in
>> the suspend/resume handling.
>>
>> Since pinctrl-baytrail.c is using normal suspend/resume handlers,
>> interrupts are still enabled during suspend/resume handling. Nothing
>> should be using the GPIOs when they are being taken down, _but_ the
>> GPIOs themselves may still cause interrupts, which are likely to
>> use (read) the triggering GPIO. So we need to protect against
>> concurrent GPIO register accesses in the suspend/resume handlers too.
>>
>> This commit fixes this by adding the missing spin_lock / unlock calls.
>> ---end commit msg---
>>
>> I was discussing the problem at my local hackerspace yesterday with
>> someone who knows quite a bit low-level details about Intel CPUs.
>> He said that on "big" core's all the GPIO islands sit behind the IOSF
>> and that there is a bridge which make their registers look like regular
>> mmio registers.
>>
>> I wonder if the same is happening on BYT, that would point to an issue
>> with concurent accesses being done through the IOSF bridge, which would
>> explain why I've found that we need a single global lock for all GPIO
>> islands (*).
>=20
>> But that in turn would mean that we really need global lock
>> for _all_ accesses done through the IOSF bridge, not just GPIO register
>> accesses...  Which would explain why on some machines BYT has never been
>> really stable with Linux.
>=20
> I don't think so. The Cherriview seems inherited the same silicon issue (=
see
> comment near to chv_lock), though it seems to be fixed for all new hardwa=
re
> (Skylake+).

Ah, interestingly enough pinctrl-cherryview.c already uses a global
lock and it also already protects suspend and resume, well at least
that shows that my baytrail patch seems sound / the right thing to do.

>> Can someone at Intel with access to internal docs about BYT dig a bit in=
to
>> the docs and see if 1. this theory makes sense, 2. if it does if there u=
s
>> anything else behind the IOSF for which we also need to serialize access=
es?
>=20
> Unfortunately I have no time to dig into this right now.

Ok.

Regards,

Hans

