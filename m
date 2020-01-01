Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4069412DF31
	for <lists+linux-acpi@lfdr.de>; Wed,  1 Jan 2020 15:51:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbgAAOv6 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 1 Jan 2020 09:51:58 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:39184 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725872AbgAAOv6 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 1 Jan 2020 09:51:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1577890316;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9gqQr/+c9pqV5pQvS4YN/PwQEOwT63BT34eIfRYUFd4=;
        b=NzRSDNi7yeHzjhWunNFFfrbeMi6MWfD0xoWY6iOGlxBM21odbzoPd2e5VbYSREJ3kCBtjp
        2zjxgpTciVwLmZI70EVQQ85V2Jnad8yE6ekcHzM1OBxPoDwRL8+17k4hUnvmJQT9+w+hjQ
        vN3Q/9oKetw4WlbjUXE4pix5vqsuCPA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-205-moB-7eVhNfWMxR69K-Uleg-1; Wed, 01 Jan 2020 09:51:55 -0500
X-MC-Unique: moB-7eVhNfWMxR69K-Uleg-1
Received: by mail-wr1-f69.google.com with SMTP id k18so19427461wrw.9
        for <linux-acpi@vger.kernel.org>; Wed, 01 Jan 2020 06:51:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9gqQr/+c9pqV5pQvS4YN/PwQEOwT63BT34eIfRYUFd4=;
        b=moH/sGBWkQaRue3p1EoW02qZpjx8IHSbkLz8IAxRGCWHJGrnQkm/H+X3iitv4GAhRR
         wOFW4COmwWiZa/OKf0Pogl1PY4LuUpGOxlHULQSkm7oXEQB2LHAhv/ky1JHwEsx0ObyM
         1Z67oq/reExh8B3hY/S5A0U8IdX4+N1vSX5SQSEaWM47AjYjY3ZbmPwjxZz6PQHfOCZ8
         lPbgFBcT65YXRBkJ9SXqnZY5GNqcgMyHob1CU1dFatJfVkLffc8Kv+GhhwP/1Kadb6vn
         vnCoGHJpGNXpqmdl+rmnEGlq5IWP4JHj5C2VB9V2429jL4haMkxScDcwp90YcFxWqGE6
         e+tg==
X-Gm-Message-State: APjAAAWkVAgwDC9YQ8beUc+3rKPX6/ZRn4OlwucVsz/SnX+J+0J3KTOH
        Wrh9lnn2Lb3fGzNC+T8zXziM8hEZ4xUh5CbDgUr2BmGI13Yd4WgiYiGA2+XGZ8PveD6yGOiWBY4
        /PDsjPonMrdbKl17ig148cg==
X-Received: by 2002:adf:f288:: with SMTP id k8mr82138648wro.301.1577890314432;
        Wed, 01 Jan 2020 06:51:54 -0800 (PST)
X-Google-Smtp-Source: APXvYqz7Dj2aGS6ChUGPgxfcCnqaDTOZ3W5KDIc9GFjuuirLshpd149g1xVtsfAnqadyi+tNp8Mn8Q==
X-Received: by 2002:adf:f288:: with SMTP id k8mr82138621wro.301.1577890314237;
        Wed, 01 Jan 2020 06:51:54 -0800 (PST)
Received: from shalem.localdomain (2001-1c00-0c0c-fe00-7e79-4dac-39d0-9c14.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:7e79:4dac:39d0:9c14])
        by smtp.gmail.com with ESMTPSA id z4sm5657541wma.2.2020.01.01.06.51.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jan 2020 06:51:53 -0800 (PST)
Subject: Re: [PATCH v2] pinctrl: baytrail: Remove WARN when setting direct-irq
 pin to output
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bastien Nocera <hadess@hadess.net>,
        Dmitry Mastykin <mastichi@gmail.com>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org
References: <20191225132812.90889-1-hdegoede@redhat.com>
 <20191227141220.GA2628@lahna.fi.intel.com>
 <acafef49-bd32-6900-01d2-f6adccabe201@redhat.com>
 <20191230100844.GC2628@lahna.fi.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <d56d3764-e82a-4969-6579-d4d3a17a1d3d@redhat.com>
Date:   Wed, 1 Jan 2020 15:51:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20191230100844.GC2628@lahna.fi.intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 30-12-2019 11:08, Mika Westerberg wrote:
> On Fri, Dec 27, 2019 at 11:47:38PM +0100, Hans de Goede wrote:
>> The problem is that we hit this path everytime we output a value on the
>> pin. I guess we can change the WARN to dev_info_once() if you prefer that.
> 
> Yes, I think dev_info_once() would be fine.

Ok, version 3 replacing the WARN() with a dev_info_once coming up.

Regards,

Hans

