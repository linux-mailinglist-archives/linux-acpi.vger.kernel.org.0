Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD4E44C16BF
	for <lists+linux-acpi@lfdr.de>; Wed, 23 Feb 2022 16:27:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242063AbiBWP2M (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 23 Feb 2022 10:28:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242026AbiBWP2G (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 23 Feb 2022 10:28:06 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 373C859A5D
        for <linux-acpi@vger.kernel.org>; Wed, 23 Feb 2022 07:27:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645630057;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kH8WIN2Y5/0MeVxcsZQrx8+wnwcyD8nghWH8KM7iDsA=;
        b=LfNSe/pAhnvlWBYSh+R2TLxrxjK4o2/+KFyPHcTrn6yO4SR0ABvvHiKr1+y73t95GWgHFH
        oXIl0aYRKQeeVTvWJ/59LhuU7xOgBKMDQZcABQ+PSw+xjlLZPvJVm6ibw1pb52frksknpI
        GvKhnp0DYYtagEidnpUQ45Re7haWMLA=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-618-izc52rZdPf6-9Laa-508Vw-1; Wed, 23 Feb 2022 10:27:36 -0500
X-MC-Unique: izc52rZdPf6-9Laa-508Vw-1
Received: by mail-ed1-f71.google.com with SMTP id l24-20020a056402231800b00410f19a3103so13792290eda.5
        for <linux-acpi@vger.kernel.org>; Wed, 23 Feb 2022 07:27:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=kH8WIN2Y5/0MeVxcsZQrx8+wnwcyD8nghWH8KM7iDsA=;
        b=x1t/qVvS1LfvicsMMQ61PfVcLA4sp41usuY+9QWwUBnVxI/7k0bF011GRD5a4PiMMB
         oiQdT2CZLVHFJ/lldapJYfKyZkk0SSpQaB5+cwCGc/gQmJUC7drD+gc7Zt6n/ETXOLsX
         rDpVrgS2JELCD4bIlnhvUoKgtRG2klLXwXS97DAzvHvOAup/IOM/biuY57z8KIpHuGdD
         l6D5s1AZTaBA1dWMOZrq/JEW9yCiNtvWnl5gkFeyauRdAh4zqPsD5fRrfv9+5nfOZO6J
         B/Y6GqEe/1zbMah1+Q2BkSyA6zqyidBTulcF2fa/8oHCbANs9WWFCCe1ULZtlufYXe+c
         Icug==
X-Gm-Message-State: AOAM533X47SveIVX6oOipR5fLmHCMN7zCvAOmubAcdqaY7yFDFjmYGLp
        s/b4CwwdwF5QI4IDgYXly0ssEYvnU3fll6KRVlunW9ReK8SyEP/QlOQcFvsVGdqgbTNzvCKvKGN
        DDwTt6iDairJHwBpT7eVGMw==
X-Received: by 2002:a17:906:b052:b0:6ce:88a5:e42a with SMTP id bj18-20020a170906b05200b006ce88a5e42amr192696ejb.237.1645630055141;
        Wed, 23 Feb 2022 07:27:35 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz57LXSr95exnXVUq8ZiXc7mHpA+5ceGpA7rB1clicZS90nENA1DfPGFMyeysD3j/UErNATAw==
X-Received: by 2002:a17:906:b052:b0:6ce:88a5:e42a with SMTP id bj18-20020a170906b05200b006ce88a5e42amr192678ejb.237.1645630054986;
        Wed, 23 Feb 2022 07:27:34 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1? (2001-1c00-0c1e-bf00-1db8-22d3-1bc9-8ca1.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1])
        by smtp.gmail.com with ESMTPSA id c11sm12486585edx.42.2022.02.23.07.27.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Feb 2022 07:27:34 -0800 (PST)
Message-ID: <d7c8a9fe-5c9b-2c9d-3731-c735da795bf8@redhat.com>
Date:   Wed, 23 Feb 2022 16:27:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [RFC 10/10] net: sfp: add support for fwnode
Content-Language: en-US
To:     Andrew Lunn <andrew@lunn.ch>,
        =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>
Cc:     "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Wolfram Sang <wsa@kernel.org>, Peter Rosin <peda@axentia.se>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-i2c@vger.kernel.org,
        netdev@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
References: <20220221162652.103834-1-clement.leger@bootlin.com>
 <20220221162652.103834-11-clement.leger@bootlin.com>
 <YhPSkz8+BIcdb72R@smile.fi.intel.com> <20220222142513.026ad98c@fixe.home>
 <YhYZAc5+Q1rN3vhk@smile.fi.intel.com>
 <888f9f1a-ca5a-1250-1423-6c012ec773e2@redhat.com>
 <YhYriwvHJKjrDQRf@shell.armlinux.org.uk>
 <4d611fe8-b82a-1709-507a-56be94263688@redhat.com>
 <20220223151436.4798e5ad@fixe.home> <YhZRgnPG5Yd8mvc/@lunn.ch>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <YhZRgnPG5Yd8mvc/@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 2/23/22 16:23, Andrew Lunn wrote:
>> As Russell asked, I'm also really interested if someone has a solution
>> to reuse device-tree description (overlays ?) to describe such
>> hardware. However, the fact that CONFIG_OF isn't enabled on x86 config
>> seems a bit complicated on this side.
> 
> It does work, intel even used it for one of there tiny x86 SoCs. Maybe
> it was Newton?

IIRC those SoCs did not use standard EFI/ACPI though, but rather some
other special firmware, I think it was SFI ?  This is not so much about
the CPU architecture as it is about the firmware/bootloader <->
OS interface.

Note I'm not saying this can not be done with EFI/ACPI systems, but
I think it has never been tried.

Regards,

Hans

