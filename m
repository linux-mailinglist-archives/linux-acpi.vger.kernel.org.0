Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8943DD2B18
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Oct 2019 15:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388238AbfJJNTF (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 10 Oct 2019 09:19:05 -0400
Received: from mail-wr1-f51.google.com ([209.85.221.51]:40589 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388329AbfJJNTC (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 10 Oct 2019 09:19:02 -0400
Received: by mail-wr1-f51.google.com with SMTP id h4so7880217wrv.7;
        Thu, 10 Oct 2019 06:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cU2Z1he193fGQfwYVGWXirAJ34kU3C29gXJ8rRkJamw=;
        b=vPGKjlfQDkdDEt4C1sBLoyEU4P8EUM8qOBnrSZsBimJeNmaKLK/JhWxhEWBJujWcBk
         TIoicQuLtu0gL3aHzwrxyTGZrteoEn8ke3zp/bC2itrXLmOk3/ct7dPmd/X8QQqabT1u
         6upmvGlnnYWezEJZeFz9dFBleVuhZZseRoLlN5njRp5vLP30W8yur6mm8i2T79zyyD1J
         5+4/CtDyrK0eOI5L+sEp6Gm75DOHhN0Z3c9O9P1cNJl9UaTz2sJV/wTEIQWTzvhD7fPz
         UZd1h1oporKC8j+1LcFkhkORaf06CCY3JDP/deap43PBVdW5wiCghbMfg3qcfiPVDxwm
         YOaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cU2Z1he193fGQfwYVGWXirAJ34kU3C29gXJ8rRkJamw=;
        b=rEGlQJgrq2LmpANuG9fOhrvRSdPL9PKlVNSqvoe3RvXCdjB2hyI4kKI8Uu1+lfM8Mz
         m3RgT4Z04G6IE9YMvrIiLcDYugf/JkQC3cUZSLTQeOCpDSwq5ggrtDUitSVe1Ib+j0Fg
         HchJ3+44+Ew0qtzgJaX4Tu7wz17FmjwJCTDUowJvmxwW7UuGdk+DKbamE4NPfsH6y+qf
         aSrLljbEgKqNlx4gifkur4q0UjUZv/mfVKXElWOq475hhXM8XW8IpMI+N1jFt56ewXU+
         01/crhZUllP/WzBSU/UqQdSOTDVZDTiL4yascHcAPOGDYdHmFfGLDGsKptYdc0DuIi1o
         oIgA==
X-Gm-Message-State: APjAAAWBojZL/c9kNc8zmzdq8yE+YBIbembMjzZRssdtRHTv19RVdYkM
        0ECVdghcyuEWyyLYjJqi5HWF1sFr
X-Google-Smtp-Source: APXvYqyY34PXFOxPL+JOw98k0b9U39Y6bs5YHdz8yme77Kl47Ru/r1ga+iLNYRV2qXw3PlaP7QHB9Q==
X-Received: by 2002:adf:9cca:: with SMTP id h10mr8249674wre.339.1570713540365;
        Thu, 10 Oct 2019 06:19:00 -0700 (PDT)
Received: from [192.168.2.202] (pD9EA3280.dip0.t-ipconnect.de. [217.234.50.128])
        by smtp.gmail.com with ESMTPSA id r65sm7208546wmr.9.2019.10.10.06.18.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Oct 2019 06:18:59 -0700 (PDT)
Subject: Re: [PATCH v2] serdev: Add ACPI devices by ResourceSource field
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Johan Hovold <johan@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-serial@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190924162226.1493407-1-luzmaximilian@gmail.com>
 <03d11e04-aaad-4851-c7d6-feaf62793670@redhat.com>
From:   Maximilian Luz <luzmaximilian@gmail.com>
Message-ID: <84883ba0-ec01-9114-5c4a-e468cf85dfec@gmail.com>
Date:   Thu, 10 Oct 2019 15:18:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <03d11e04-aaad-4851-c7d6-feaf62793670@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 10/10/19 12:22 PM, Hans de Goede wrote:
> This patch looks good to me and it works on my test hw with serial
> attached BT HCI:
> 
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> Tested-by: Hans de Goede <hdegoede@redhat.com>
> 
> Regards,
> 
> Hans

Awesome, thank you!

Regards,

Maximilian
