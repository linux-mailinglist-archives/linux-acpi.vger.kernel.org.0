Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BE85174977
	for <lists+linux-acpi@lfdr.de>; Sat, 29 Feb 2020 21:58:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727169AbgB2U57 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 29 Feb 2020 15:57:59 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:59442 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726663AbgB2U56 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Sat, 29 Feb 2020 15:57:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583009877;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=grkL4cK36yhQ8pKdn5AWpPmByRCbwaCyrviGJG1XD54=;
        b=HFNNs7Tq0eePTZ32gR+C1srFJTOEHmFK/5e1dYcYPzO2ntDTmmxagAZuf20taOpctSNDmM
        bQrxjjbsNrVjDIMO5sX4b5z20hH6Rfc0zg8fcSsq4uOsxHI3WMnwmXLizlACwj4QvurXqC
        Uo7kH++8vE6S50Jgu8907MneO4fOF5o=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-378-z9atdDxhM-qzNBMvZT0GGg-1; Sat, 29 Feb 2020 15:57:55 -0500
X-MC-Unique: z9atdDxhM-qzNBMvZT0GGg-1
Received: by mail-wr1-f71.google.com with SMTP id c6so3308248wrm.18
        for <linux-acpi@vger.kernel.org>; Sat, 29 Feb 2020 12:57:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=grkL4cK36yhQ8pKdn5AWpPmByRCbwaCyrviGJG1XD54=;
        b=WpRn3+l+g1Idp8EKu3clslTZJLjSdWTFjhkz4PUyjXEG/V62QGFd5I0FqSgYjJXvLk
         oITDjjlEvsgA3SHudew+SpFRuInBuK+zclHsz+lpWWYCDFE6CBv3whU/Zn9h1/aBzCeN
         miWLAk5RlCJxuKlfjFtjHzonfimnEvMsdhHOryFMaeKJTzPNaIkLv+5RcO7MiW8d7NWY
         hizvulvNgX5OXmmMjJaPQaw2FjLxFtrsCkKF6odlndcTCA/SFTybrAMp1hjVr3a5LyzR
         jQu+m52UBRVMgD58nG1v3rnrxZLHuOTGRgmuPmMg1/ES85VCjBY0Cl6iOHUETL7qQop6
         0niQ==
X-Gm-Message-State: APjAAAVlia+GOm8nrSQUcy5D884osKPUQwE/cZeo+vOLpYpO9Fktse36
        gZ+GGgzoZJTxKBH5BinWVM1ToiVfofgP91GgtJB3Dxoq/RKFEzOkKOk40LM9IWbouxSBnZ2LWLa
        V8zQmbTxBn9t+WQ2mX8YsKw==
X-Received: by 2002:adf:fcc4:: with SMTP id f4mr12645583wrs.247.1583009874239;
        Sat, 29 Feb 2020 12:57:54 -0800 (PST)
X-Google-Smtp-Source: APXvYqxPvtTPPm3BpDSKVd+9jIKsf1LtljBDmV1DoLIVXvSaB5EIwbizX9zavy0NQwR82A2rfmIapA==
X-Received: by 2002:adf:fcc4:: with SMTP id f4mr12645569wrs.247.1583009874059;
        Sat, 29 Feb 2020 12:57:54 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-fc7e-fd47-85c1-1ab3.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:fc7e:fd47:85c1:1ab3])
        by smtp.gmail.com with ESMTPSA id s1sm19071282wro.66.2020.02.29.12.57.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Feb 2020 12:57:53 -0800 (PST)
Subject: Re: [PATCH resend 2/3] gpiolib: acpi: Rename honor_wakeup option to
 ignore_wake, add extra quirk
From:   Hans de Goede <hdegoede@redhat.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Marc Lehmann <schmorp@schmorp.de>, linux-gpio@vger.kernel.org,
        linux-acpi@vger.kernel.org
References: <20200225102753.8351-1-hdegoede@redhat.com>
 <20200225102753.8351-3-hdegoede@redhat.com>
 <20200225105437.GG10400@smile.fi.intel.com>
 <e0c39a89-bcac-4315-d764-5853eb77537d@redhat.com>
 <20200225123425.GK10400@smile.fi.intel.com>
 <20200225125700.GL10400@smile.fi.intel.com>
 <44cc5510-571c-21c4-1855-f3141f72eaa3@redhat.com>
Message-ID: <ac38ee83-5edf-2ee0-8cec-a0b4367054a8@redhat.com>
Date:   Sat, 29 Feb 2020 21:57:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <44cc5510-571c-21c4-1855-f3141f72eaa3@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 2/28/20 12:22 PM, Hans de Goede wrote:
> Hi,
> 
> On 2/25/20 1:57 PM, Andy Shevchenko wrote:
>> On Tue, Feb 25, 2020 at 02:34:25PM +0200, Andy Shevchenko wrote:
>>> On Tue, Feb 25, 2020 at 12:26:04PM +0100, Hans de Goede wrote:
>>
>>> Let's do it as a list of pairs, but in slightly different format (I see some
>>> potential to derive a generic parser, based on users described in
>>> Documentation/admin-guide/kernel-parameters.txt), i.e.
>>>
>>>     ignore_wake=pin:controller[,pin:controller[,...]]
>>
>> Another possible format
>>
>>     ignore_wake=controller@pin[;controller@pin[;...]]
> 
> I like this one, the other one with the pin first feels wrong, the pin is
> part of the controller, not the other way around.
> 
> I will rework the patch series to use the ignore_wake=controller@pin format.

Just a quick note. I've changed the separator from ; to , for some reason
grub, at least as used in Fedora with Fedora's grub2 BLS (boot loader spec)
implementation does not like it when there is a ; in the kernel commandline.

I will also send an email about this to Fedora grub maintainer, but for
now it is easiest to just avoid the problem.

Regards,

Hans

