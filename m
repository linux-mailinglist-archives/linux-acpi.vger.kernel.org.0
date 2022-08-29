Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3776D5A5440
	for <lists+linux-acpi@lfdr.de>; Mon, 29 Aug 2022 20:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbiH2S6j (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 29 Aug 2022 14:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiH2S6j (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 29 Aug 2022 14:58:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BA2A79A7F
        for <linux-acpi@vger.kernel.org>; Mon, 29 Aug 2022 11:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661799517;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QigUbwKYB9hYRdfQ0906p1xIihInPjDJ99xgckC/HgA=;
        b=EVhvpdnAugzuBuEkPMVPENO3ll3KgslICSZXe+g9NbfC9bkvmva+H5mFgq6r19fomyCUHT
        /0rJvpyioeypAK3mmWgXijIb1UkFlu0j8IYAGZT0lJ1gVPD7ngwOcJdHdQz88upfWhehWU
        Lwvi7xESaEJVedB9+iwVAnSCc9aKG2M=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-50-pUYr9DZ0MSqkezuMaem7WA-1; Mon, 29 Aug 2022 14:58:35 -0400
X-MC-Unique: pUYr9DZ0MSqkezuMaem7WA-1
Received: by mail-ej1-f71.google.com with SMTP id sb14-20020a1709076d8e00b0073d48a10e10so2736525ejc.16
        for <linux-acpi@vger.kernel.org>; Mon, 29 Aug 2022 11:58:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=QigUbwKYB9hYRdfQ0906p1xIihInPjDJ99xgckC/HgA=;
        b=h38xanXfbOfHJeewMeKoFeoYgt9j745TRIQyIUyJwgf5HBdNuPs58YVFMXmJ1ylArZ
         LxGYS1UcR2gZdkBG88RzXXQga8z7Mmqevtm9wRGFLWjtDhgqPASo5ECiABIZaxQk2eYo
         +jBY+XxafIuOtMDpK3vaQcZoQXuZrRGfwpdK+Ns5i7nxEOLpQWtkLkaXVvRokh4FJriv
         Rfv0KPi8PlMWJPyPhLPVj8onunOcNRipMXiOlBILAZ8uUkhODENCymeohS9zal8tTz01
         OxKyL3tl1iYx0ktFtA3HI6B/82s4ungVatDOjP/OZgvR3VJ4lOTWyFQm4qJKXYxqTV0+
         kVHQ==
X-Gm-Message-State: ACgBeo3yvKGY6RGZTxoeFrUb5XzeWveJD347szugBBNmiDWWdWTJdIkS
        KRfZr3jf5e1Mv2RN1JV7/u6xCybg5bpbDdo5ftvFfFqVAqNF+oEkDRN7CsB0DsBpxGzZyqcXz9x
        jyOxzV+Kzgns3TgfzPl7DhA==
X-Received: by 2002:a05:6402:22d0:b0:447:9c9a:f6b9 with SMTP id dm16-20020a05640222d000b004479c9af6b9mr18135246edb.296.1661799514720;
        Mon, 29 Aug 2022 11:58:34 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6qMZYyBCoP2IPOME06GeP6o91AZp69gxvTNBMqUSdwemh8jjiFzM8jg8j2h1Elcj4enouy5w==
X-Received: by 2002:a05:6402:22d0:b0:447:9c9a:f6b9 with SMTP id dm16-20020a05640222d000b004479c9af6b9mr18135233edb.296.1661799514522;
        Mon, 29 Aug 2022 11:58:34 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id o20-20020a170906769400b0073306218484sm1341451ejm.26.2022.08.29.11.58.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Aug 2022 11:58:33 -0700 (PDT)
Message-ID: <68b1c4fd-56a4-8de6-62ec-98bd6ef8b169@redhat.com>
Date:   Mon, 29 Aug 2022 20:58:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 1/1] ACPI: video: Add Toshiba Satellite/Portege Z830 quirk
Content-Language: en-US
To:     Arvid Norlander <lkml@vorpal.se>, linux-acpi@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>
References: <20220824184950.631520-1-lkml@vorpal.se>
 <20220824184950.631520-2-lkml@vorpal.se>
 <d097b844-8fe4-3469-2137-9e8407348175@redhat.com>
 <3863cad2-1910-b377-011b-4970eeb68e13@vorpal.se>
 <91260f39-27d9-222b-53e7-41ab4bb412a3@redhat.com>
 <9640be14-b478-5887-9057-de2796eccd6b@redhat.com>
 <ef3046e5-f402-3d33-8d94-4d9f87ceadd5@vorpal.se>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <ef3046e5-f402-3d33-8d94-4d9f87ceadd5@vorpal.se>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 8/29/22 20:30, Arvid Norlander wrote:
> Hi,
> 
> On 2022-08-29 16:12, Hans de Goede wrote:
>> Hi,
>>
> 
> <snip>
> 
>>
>> Arvid, here is a git branch with my backlight-refactor for you
>> to test:
>>
>> https://github.com/jwrdegoede/linux-sunxi/commits/backlight-refactor-for-arvid
>>
>> If you can give this a test spin (without any special kernel
>> commandline options) then that would be great.
> 
> I'll set up a PKGBUILD and get this built (I'm building on other computers).
> It may take a couple of days before I get around to that however. I hope
> this is okay with you.

Yes that is fine, thank you.

Regards,

Hans

