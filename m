Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B40E61DB97
	for <lists+linux-acpi@lfdr.de>; Sat,  5 Nov 2022 16:18:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbiKEPSt (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 5 Nov 2022 11:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbiKEPSt (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 5 Nov 2022 11:18:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 598151EEC7
        for <linux-acpi@vger.kernel.org>; Sat,  5 Nov 2022 08:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667661474;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/rCTfuLsYK7FsuNYJ+vw1vyoF4YfeZl9Zo3CJbd2Tf8=;
        b=WUXwbnXRD8XHt2jpo9wP7oIPaxrhJaAU9ZqB6lvFlJJzjB3n7BMgRoM6cYqmnjEtFc9S+g
        9PKm0q0eS5UZ/wnti2QcuK0ZJr+c5LRM4YEHyOWFSCW1rp0TwvHy0Wgtg4r+LJRAmCuQBO
        m0C7useKtAcHShWTNtSENhOk/dz8WMs=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-82-gUgTnJt0P_qKj6Kvs9iO9g-1; Sat, 05 Nov 2022 11:17:53 -0400
X-MC-Unique: gUgTnJt0P_qKj6Kvs9iO9g-1
Received: by mail-ej1-f70.google.com with SMTP id jg27-20020a170907971b00b007ad9892f5f6so4804426ejc.7
        for <linux-acpi@vger.kernel.org>; Sat, 05 Nov 2022 08:17:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/rCTfuLsYK7FsuNYJ+vw1vyoF4YfeZl9Zo3CJbd2Tf8=;
        b=s7mYNkh+r00+cyPVZ381AzAUwVpM2bKFSvHwUU4RZ+Z9PirtDo72mtxXXuRgfOZmVp
         oyAy/upZpZ20fggtIcvuRLLgXht5rCDZcY+eo91Yo9OBoox0Q0LYaMfkgz3s0eA2jhQU
         lmwW0KckkMoON1km3827c0Q/oeMCEldrAqdyExmnbhml5pYf2x/rKmw4KkVcPOSnmhyy
         qeAi/bXaa0tCywDN65VmGXijdDR0O/96XCNc/LhSzi548ttJxlEuHhkB83xbUt63SsX1
         NXoM2OUhygb65rUe9aK9lFSnATYuS5Vd/v5eh6G6OC/SBosmZjF63V7v5wM/oWR9mj5w
         Ztxw==
X-Gm-Message-State: ACrzQf0FcPgjzWWUNaI6W29Mpjuqsw0/hxCKfVMi6ouU11efWOmuVKNd
        sFBMoaggpQDlayYvoFAY6L1WV9aNKzLtkrG9Hxg/ZrjKQGTu1Ffai0zEpr81xdNLjW71nRQBBxn
        yD9RX8xMO9H/dz+VtFohakQ==
X-Received: by 2002:a17:906:dac3:b0:780:a242:2f14 with SMTP id xi3-20020a170906dac300b00780a2422f14mr38844190ejb.668.1667661469920;
        Sat, 05 Nov 2022 08:17:49 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7BTiCUlzTHc13wxzHPS/WUjkHlBABS6uZlbFjmQ/wc6bP7VXbiY4RKcV9VAvsjXdNRbTNAEQ==
X-Received: by 2002:a17:906:dac3:b0:780:a242:2f14 with SMTP id xi3-20020a170906dac300b00780a2422f14mr38844180ejb.668.1667661469759;
        Sat, 05 Nov 2022 08:17:49 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id y9-20020aa7d509000000b0045ce419ecffsm1282393edq.58.2022.11.05.08.17.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Nov 2022 08:17:48 -0700 (PDT)
Message-ID: <c364cee1-4309-ebc2-9aa3-ff467fe0096f@redhat.com>
Date:   Sat, 5 Nov 2022 16:17:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [RFC 0/2] ACPI: video: prefer native over vendor
Content-Language: en-US, nl
To:     "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Matthew Garrett <mjg59@srcf.ucam.org>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org
References: <20221105145258.12700-1-hdegoede@redhat.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20221105145258.12700-1-hdegoede@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 11/5/22 15:52, Hans de Goede wrote:
> Hi Rafael, Matthew,
> 
> Here is a second attempt at always registering only a single
> /sys/class/backlight device per panel.
> 
> This first round of testing has shown that native works well even on
> systems so old that the don't have acpi_video backlight control support.
> 
> This patch series makes native be preferred over vendor, which should
> avoid the problems seen with the 6.1 changes before the fixes.
> 
> ATM there is one known model where this will cause a regression,
> the Sony Vaio PCG-FRV3 from 2003. I plan to add a DMI quirk for that
> in the next version of this series, but I'm waiting for some more
> testing (to check that the vendor interface does actually work) first.
> 
> I will also do another blogpost, focussing on asking users to see
> if they have a laptop which provides a combination of vendor + native
> backlight interfaces, which may be impacted by this series. This is
> the main reason why this is a RFC for now.

The blogpost requesting testing of laptops with a combination
of vendor + native backlight interfaces can be found here:

https://hansdegoede.dreamwidth.org/27024.html

Regards,

Hans


