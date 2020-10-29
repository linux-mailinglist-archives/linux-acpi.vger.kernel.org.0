Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7266929E7B4
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Oct 2020 10:46:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbgJ2Jqo (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 29 Oct 2020 05:46:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36876 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726002AbgJ2Jqo (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 29 Oct 2020 05:46:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603964803;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v4juQfAx3LxBzTcqekjK+MOSoDZx1NTXS/wKZYQGOXo=;
        b=LK9phlxHhIvI3B603Us6mzSVBuplg1RWGtGfKwCvMEtUptCOkedY1hkoGm5yrQRU1KVEP2
        nK3Hv+AtDfly1She7KLOmtJ1b+TM6XAk5blBfq2BbXaK4YPF0XsGRY/jxZ2W+ee1BFOAeN
        i0n15t7KH2zucFCYYYDdZMcl//V3q/k=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-185-bloCCQCPP2OKG4PaJG7bDQ-1; Thu, 29 Oct 2020 05:46:41 -0400
X-MC-Unique: bloCCQCPP2OKG4PaJG7bDQ-1
Received: by mail-ed1-f71.google.com with SMTP id v7so273084edy.4
        for <linux-acpi@vger.kernel.org>; Thu, 29 Oct 2020 02:46:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=v4juQfAx3LxBzTcqekjK+MOSoDZx1NTXS/wKZYQGOXo=;
        b=AhUMhLDJjjb1IvhI3KdKxMDPiOctCXF2UxPeMgVEcfHtlIq67dGiB/Rl2W2y2Y0zMZ
         GTtdm0ti5BXTC5mYJrOQMfONQu/j4frN5g2lJXG/25EUFDlfP8tyIwg3hYo44sDWeg16
         jqayj67rfN44Qy35A1ogPbU9YYbzZHmZuohzyJwX/t3pUf0dyfa8faKDl/PVqkKijmlj
         sRsdvdeFwnEoGNltw3eRGkms7awf3GiBASksOeBlfmfmTooWpj3hRIXaFLIWJrLczFFJ
         b3XdqkNETE8F7aRZLWG+ZckByz+aZbGUtQsT3m6rAUcPCuZOC277KG3NFa90wcU8BEJk
         ynog==
X-Gm-Message-State: AOAM5322C4haTuOzJjgzC1ld0trzfTC+Hk+MBQqA4JCIOVVF1UbaBi7K
        TKGUVGkJClo7C81egFHEjZtdLYEBU19N8evF/GquoiQ65x2DgSOTStlhjD6KUCv1+x0NaDiYZvM
        SRuy/a8LCL+twC73eebsVYQ==
X-Received: by 2002:a05:6402:1691:: with SMTP id a17mr2984357edv.264.1603964800377;
        Thu, 29 Oct 2020 02:46:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzKE7w0otUI+gbsHiZO1jXP8ILglLHS0/NREeyAFavkgmdFK4zjz2UD5PtGB/B2pPdy0w21NQ==
X-Received: by 2002:a05:6402:1691:: with SMTP id a17mr2984338edv.264.1603964800185;
        Thu, 29 Oct 2020 02:46:40 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-6c10-fbf3-14c4-884c.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:6c10:fbf3:14c4:884c])
        by smtp.gmail.com with ESMTPSA id p20sm1140405ejd.78.2020.10.29.02.46.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Oct 2020 02:46:39 -0700 (PDT)
Subject: Re: [External] Re: [PATCH] Documentation: Add documentation for new
 platform_profile sysfs attribute
To:     Mark Pearson <markpearson@lenovo.com>,
        Bastien Nocera <hadess@hadess.net>
Cc:     dvhart@infradead.org, mgross@linux.intel.com,
        mario.limonciello@dell.com, eliadevito@gmail.com, bberg@redhat.com,
        linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <markpearson@lenovo.com>
 <20201027164219.868839-1-markpearson@lenovo.com>
 <5ca1ae238b23a611b8a490c244fd93cdcc36ef79.camel@hadess.net>
 <d5f0bcba-5366-87da-d199-a85d59ba6c1c@redhat.com>
 <b3e61ee4-3fca-ce06-2216-977586baae4e@lenovo.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <ebeec472-3310-c560-e8bf-2b33c480333b@redhat.com>
Date:   Thu, 29 Oct 2020 10:46:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <b3e61ee4-3fca-ce06-2216-977586baae4e@lenovo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 10/29/20 1:55 AM, Mark Pearson wrote:
> Thanks Hans and Bastien,
> 
> On 28/10/2020 13:23, Hans de Goede wrote:

<big snip>

>>> Is there another file which explains whether those sysfs value will
>>> contain a trailing linefeed?
>>
>> sysfs APIs are typically created so that they can be used from the shell,
>> so on read a newline will be added. On write a newline at the end
>> typically is allowed, but ignored. There are even special helper functions
>> to deal with properly ignoring the newline on write.
>>
>> Regards,
>>
>> Hans
>>
>>
> OK - does that need to actually be specified here? Or is that just something I keep in mind for the implementation?

IMHO it does not belong in the sysfs API docs for the platform_profile
stuff. But I guess it would be good to document it somewhere in some
generic syfs API rules/expectations document (with a note that their
might be exceptions).

Ideally we would already have such a file somewhere, but I don't know
if we do (I did not look). So if you feel like it (and such a file does
not exist yet) then I guess a patch adding such a doc file would be good.

Regards,

Hans

