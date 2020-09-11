Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69B5A267620
	for <lists+linux-acpi@lfdr.de>; Sat, 12 Sep 2020 00:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725864AbgIKWqj (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 11 Sep 2020 18:46:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbgIKWqg (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 11 Sep 2020 18:46:36 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B7F4C061573;
        Fri, 11 Sep 2020 15:46:34 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id e23so15732982eja.3;
        Fri, 11 Sep 2020 15:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gbxJusHa2ym32357/sjUgbn9JJl0P0vMCQtSAk0Gnio=;
        b=cdlNGLvBwkeurTCdGiNOGiHltEFZihUT6VgLFi9uXhsR6x9Dx8u4ttJKSgLb2BBC+Q
         5p+pkiHfB82ZkiMR8avAXWOgdJvZvRhBfn4gikdy+e1puDpb7O3r+RRJhB6vqWmSXuyC
         r8H4NYwV73wTAul/X39Np79cwLxVsrMBzzdyibs619qPaQhPMkTFBP62auibLJVg58MI
         ckyBqEjfVvmG0n3DFk04Eow2Rw6SaV4+D8w9vWs17UnGg8L/Lemlk34477gCrcXt0TJZ
         0gI44XFiZ/LmFir93GyWnOJLDit6gnDQERmI9mBCr9J713FfmwiNaL7DoJx3MLOMwrDj
         +AeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gbxJusHa2ym32357/sjUgbn9JJl0P0vMCQtSAk0Gnio=;
        b=g7MethISIz7QSdPVUXMd+J0mKFLInxvCetl6IfpW7JQT83wODZ49pw6JP51Kbc4x9N
         ysuflQdqnS011k1WPF9kmZXBHmYmR9Rf3qPx0GPjvDIi7RzdoEQEOHyN7LSr5dXw0DrT
         dGRs9N1XhqrgxYCHEd+jZXohpNJFTvc4aW5eD/oNSmLaeBRHT9Dax/abHNb1uEttxbK6
         LVkCD6LqjtQb8FdGZHyk2yQef73xRu2czXEFc6cj3P9AE6zWVdRSG7+BPfNr0BaSNADF
         rPtzKmr5c/1ShukZ4en0qiQDoXc6OsQDv8eAiEQFMFRsYXcxk5hMc9o4hRwDsEXEoRPz
         gU2Q==
X-Gm-Message-State: AOAM532JcBCKBkrwU/2ZATNz1WSBTW8i7W/NZTGXkwZ+4ku8qIgQVYSl
        M+EOiRn+OZfvuxZcOBg9c0vXE93GPRU=
X-Google-Smtp-Source: ABdhPJzudBeaRIE3una4rTedZgekcU1R4Zmo6A6qfrjJ/Y6UEosPhy2ToP+s2KKrHujZyEkpOieQ5w==
X-Received: by 2002:a17:906:1d08:: with SMTP id n8mr4244935ejh.236.1599864392562;
        Fri, 11 Sep 2020 15:46:32 -0700 (PDT)
Received: from [192.168.2.202] (pd9e5a3c2.dip0.t-ipconnect.de. [217.229.163.194])
        by smtp.gmail.com with ESMTPSA id nm7sm2238957ejb.70.2020.09.11.15.46.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Sep 2020 15:46:31 -0700 (PDT)
Subject: Re: [PATCH] platform/x86: Add Driver to set up lid GPEs on MS Surface
 device
To:     mgross@linux.intel.com
Cc:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Gayatri Kammela <gayatri.kammela@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200908171934.1661509-1-luzmaximilian@gmail.com>
 <20200911221053.GF103884@mtg-dev.jf.intel.com>
From:   Maximilian Luz <luzmaximilian@gmail.com>
Message-ID: <e6125bee-d42e-f485-295a-8b9ad6777d4a@gmail.com>
Date:   Sat, 12 Sep 2020 00:46:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200911221053.GF103884@mtg-dev.jf.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 9/12/20 12:10 AM, mark gross wrote:
> Surface devices are tablets with detachable keyboards.  they don't really
> have a "lid" as the tablet is the "lid".

The Surface Laptop series doesn't have a detachable keyboard, yet still
requires this. Arguably, the Surface Books are also more laptop than
tablet (at least that's the way I use mine...). Finally, on the actual
tablets (Surface Pro series) the lid switch detects when the keyboard
cover is opened (or at least that's what I have been told, I don't
own/have access to a Pro series device).

Regardless of that, this patch is intended to provide the same behavior
as found on Windows, for all devices included in this patch, which is:
When you open the lid, or in case of the Pro series fold away the
keyboard cover, the device wakes from suspend/s2idle. Without this
patch, that doesn't work.

> I'm just questioning if the creator of the device designed it the way they did
> maybe we should think twice about doing this.

As far as I can tell, the intended behavior is to wake the device when
the lid is opened, which on the Laptops and Books is a more conventional
lid and on the Pros constitutes opening the cover.

I'm open for any alternative though.

Also please note that I've already sent a v2 of this patch with Andy's
comments addressed: https://lore.kernel.org/patchwork/patch/1303997/

--
Regards,
Max
