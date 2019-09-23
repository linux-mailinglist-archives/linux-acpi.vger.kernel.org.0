Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C271BBC47
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Sep 2019 21:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728122AbfIWTb1 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 23 Sep 2019 15:31:27 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38128 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726777AbfIWTb1 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 23 Sep 2019 15:31:27 -0400
Received: by mail-wr1-f65.google.com with SMTP id l11so15270851wrx.5;
        Mon, 23 Sep 2019 12:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/u25N3gHfsTDJPYdD/hTi62pENC5BVXXgjv47C0lP/k=;
        b=qRK1tygtCBLHiE6DS1on7tacCNq0Gd7D72jK5Q9Sl/CXIQbzxXLX6mq4AjrNU4StZA
         dt67BXWyl3u4RpLlNskpluftuY1YLOisQGeSWoiXwNbT3ISU0Hq5VWcGEFyv9D+xq75+
         oBtlYSR9nMaVZDKO1Bdc8MHN3Nn/cNmGO49JGHQ20A/uDnUmrvG6kcPlWRpJDOQOWaTe
         eJoIsZiMnRJVsRF6972C3+MaB1TWgNW3MyZyfcdlwVaFYq3p5B6S4Tge7FQo6LVjrZtp
         V1XR7Qdkixn7abrI2GmUM3wIx/Dw+5bI0s+MV5Os3mGjyYNCFl67ejbp+g6HLLLsHCm+
         Dpmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/u25N3gHfsTDJPYdD/hTi62pENC5BVXXgjv47C0lP/k=;
        b=bet5IeIf6QGfAfmpxlKSslC0YcP5mJhFVre/LGlY8+ehCmSCmmUoqBj5bWPiGEu+Kr
         jWSNtSu9dZnv54cKnVY3UL9YHLepx6Anu8sgiEZybevMwv1aDYIshzvWSxXZfiWKD2+p
         05jb8sVywUVnx9kcl/4ZhLtGRcA+7hRutMB9FTAtwQd9c9rPgMgXYzOiSE38yIBvM31t
         39xsdAz6fNPZinuuRhBY7FvWPWlqU06xV8Gk03huCGAhgiPvZuV6y3CaPmrqY+pHB4h/
         QmI8C40eqcBgw0xAlBn9F62igAgbdgA8shjZRcvOtorJvzpAr5tl8Hj2FGE2ZRTe6wVL
         uWaw==
X-Gm-Message-State: APjAAAXRjdDEl+v66F9ABm6edF14pFUEeQ0MhyPM8VEMbt6xXJZcQQ7F
        PzFVgd0BoE8nJ89r7SANMZo/YGaX
X-Google-Smtp-Source: APXvYqxIiADK/MrK+mJXCxMz8ucZ/7OhB4IveJF4KfE4gr/KyrRv9rbDpN04djHGmLNBUjwdgCAGPw==
X-Received: by 2002:adf:e28e:: with SMTP id v14mr759822wri.184.1569267084507;
        Mon, 23 Sep 2019 12:31:24 -0700 (PDT)
Received: from [192.168.2.202] (pD9E5A92F.dip0.t-ipconnect.de. [217.229.169.47])
        by smtp.gmail.com with ESMTPSA id q124sm21927916wma.5.2019.09.23.12.31.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2019 12:31:23 -0700 (PDT)
Subject: Re: [PATCH] serdev: Add ACPI devices by ResourceSource field
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Johan Hovold <johan@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-serial@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190919195624.1140941-1-luzmaximilian@gmail.com>
 <50b016a1-ed4a-b848-4658-a05731727d7e@redhat.com>
 <4c2cc8b7-8541-0912-3162-399777dc8dd2@gmail.com>
 <8bed7cde-1f59-c5bf-9506-757dd89ad594@redhat.com>
From:   Maximilian Luz <luzmaximilian@gmail.com>
Message-ID: <91a3e827-0ab7-3bd9-5d65-bd5cae2c367c@gmail.com>
Date:   Mon, 23 Sep 2019 21:31:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <8bed7cde-1f59-c5bf-9506-757dd89ad594@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 9/23/19 10:14 AM, Hans de Goede wrote:
> Ack, this is what drivers/i2c/i2c-core-acpi.c is doing and more in general
> all ACPI enumeration code always first checks _STA before doing anything
> else, so I think it would be best to do this here too.
> 
> Actually I think it might be best to fully copy how drivers/i2c/i2c-core-acpi.c
> does things.

Right, I will do that then.

Thanks,

Maximilian
