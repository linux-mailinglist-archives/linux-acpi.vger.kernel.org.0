Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3197469A7D0
	for <lists+linux-acpi@lfdr.de>; Fri, 17 Feb 2023 10:07:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbjBQJHc (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 17 Feb 2023 04:07:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjBQJHb (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 17 Feb 2023 04:07:31 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62E3A60A7D
        for <linux-acpi@vger.kernel.org>; Fri, 17 Feb 2023 01:06:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676624794;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QYBgjTMjZdGOtt6bx76zu2DLo3upoWvpTnwIk+crChA=;
        b=GSIE2yV0pSYAPwfnKhm+J/hbBW/g3y0mAAu3VtxXA3i13Bm0Bcjl99TO75hZfoAoc8embN
        I1DUv8fM2SKM3+LqFub61pl7QSpdKq80Lzj4HpLQwFIxeYXELsZeHsvn3dKtYzOv2BLTNi
        nVvHqQhVcvcDy89/s0fdVYp6AUl6Lr8=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-149-WpQKdVAGNWm-93z-oGs77A-1; Fri, 17 Feb 2023 04:06:33 -0500
X-MC-Unique: WpQKdVAGNWm-93z-oGs77A-1
Received: by mail-qv1-f71.google.com with SMTP id f1-20020ad442c1000000b0056c228fa15cso2577995qvr.4
        for <linux-acpi@vger.kernel.org>; Fri, 17 Feb 2023 01:06:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QYBgjTMjZdGOtt6bx76zu2DLo3upoWvpTnwIk+crChA=;
        b=DPMOQSILa1dbyQ3LOIHrsrsWiKIHOD6VWgE4V6fQvg7jahUn/fRaqlpvE//VP8TNtT
         vh+BzkfkR0mskhrqCBS0mmzDKODYKNME2hIVke5pT8/oRt8UhCOi3lXAiGt457wxh5J3
         I3Qc9WMbIhVjKQkh1sMjSp6h0heOCvyXEvztZf2DpjD+dMX+9Jd0EBNZ7EOu1QymLeYz
         y9Q9OrLLlElcgVNpwxCuzsIkQRVwl5/mRfv7u2AXS7NvfNc75gPZlAfK5Eghl2Oh1IOC
         l5o07xopFs2peXk5cx+BvPT1eH4Q6G1+1+KrWxE8C0+M4XemrUgakMm/qEaIR0ST/GGN
         xO2g==
X-Gm-Message-State: AO0yUKUW1pvc/rDyVJThpJUzS1mWgZD9nZ96CXm1Yai9lQTYqRjeeWLP
        K3cQmpOMt8QigsQrFDV7i3zMEJuQfT7sK/DhjzTc2KtADHYWQrGJedLDhlz1M3ZAwCoz73Zz5k9
        UUihZDE7+RYDH2bZ1BvajWw==
X-Received: by 2002:a05:6214:21a9:b0:56e:fef4:7ff1 with SMTP id t9-20020a05621421a900b0056efef47ff1mr6224983qvc.21.1676624792393;
        Fri, 17 Feb 2023 01:06:32 -0800 (PST)
X-Google-Smtp-Source: AK7set9dksCLRvkGtOCr4ORausUUH6GVWvsZbSk/a25QvYMl9pl4wePTorQHv5gsaTW5qe3V949j8g==
X-Received: by 2002:a05:6214:21a9:b0:56e:fef4:7ff1 with SMTP id t9-20020a05621421a900b0056efef47ff1mr6224956qvc.21.1676624792049;
        Fri, 17 Feb 2023 01:06:32 -0800 (PST)
Received: from localhost.localdomain ([151.29.151.163])
        by smtp.gmail.com with ESMTPSA id i65-20020a37b844000000b00705cef9b84asm2814791qkf.131.2023.02.17.01.06.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 01:06:31 -0800 (PST)
Date:   Fri, 17 Feb 2023 10:06:27 +0100
From:   Juri Lelli <juri.lelli@redhat.com>
To:     linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-rt-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@linaro.org>
Subject: Re: [ANNOUNCE][CFP] Power Management and Scheduling in the Linux
 Kernel V edition (OSPM-summit 2023)
Message-ID: <Y+9Dk69B/PSMp3Lp@localhost.localdomain>
References: <Y8lFkbJ6nluNdVYO@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8lFkbJ6nluNdVYO@localhost.localdomain>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi All,

On 19/01/23 14:28, Juri Lelli wrote:
> Power Management and Scheduling in the Linux Kernel (OSPM-summit) V edition
> 
> April 17-19, 2023
> Universita Politecnica delle Marche, Facolta di Economia
> Ancona, Italy
> 
> ---
> 
> .:: FOCUS
> 
> After a couple of years break, OSPM is back! In a different venue.
> 
> The V edition of the Power Management and Scheduling in the Linux Kernel
> (OSPM) summit aims at fostering discussions on power management and
> (real-time) scheduling techniques. Summit will be held in Ancona (Italy)
> on April 17-19, 2023.

...

> .:: ATTENDING
> 
> Attending the OSPM-summit is free of charge, but registration to the
> event is mandatory. The event can allow a maximum of 50 people (so, be
> sure to register early!).

Registrations are now open. Please use the link below to register. Don't
hesitate to reply to me privately if you experience problems with
the process.

https://forms.gle/QbRhGS3HWXinKBZq7

Also, website of the event is now online. Refer to that for logistic
information.

https://retis.sssup.it/ospm-summit/

You can find below the list of accepted topics.

https://docs.google.com/spreadsheets/d/10AJFQporrCPH9Gn6-MaRotdfO4Hm4LG6dVAoDrQdj5A/edit?usp=sharing

For registered attendees, a draft schedule will be available in the next
couple of weeks (tentatively :).

Looking forward to meeting you in Ancona!

Best,
Juri

