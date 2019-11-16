Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B390FFF3FB
	for <lists+linux-acpi@lfdr.de>; Sat, 16 Nov 2019 17:41:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727825AbfKPQlu (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 16 Nov 2019 11:41:50 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53758 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727687AbfKPQlu (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 16 Nov 2019 11:41:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573922509;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rieJJMhberbdtMUK9h8xQqVA5re21QebbZ42Q+bEccA=;
        b=JJlofetzEZhZmx4Nzcf8QDZZysZ46yJRCzZAdyCkSFuONj4X1Vy64oF8J8R6FLaH4X3FtV
        sdIti0jYJrVZWcW9WiXfva5WiSmGHkc5KQGOYhkCfyQcoRuDwN0u8CFDT1iW6PBCN5awTW
        pf6r5yXlDd584M+d+IF2TXcRBxF19dE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-262-Li7ZPIWRMx6iPd8LgKer_Q-1; Sat, 16 Nov 2019 11:41:46 -0500
Received: by mail-wr1-f69.google.com with SMTP id v6so11516463wrm.18
        for <linux-acpi@vger.kernel.org>; Sat, 16 Nov 2019 08:41:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qP9qXptu1iumfZdm4TD6Ahp2yjsqgBao1/DCi2rpxH0=;
        b=pjCrger/XSWz7D9RbrNj//vGtQ1qGBVB8mJP0rg4zwHDfYnqYvuVU4UJSaFu6PgXV+
         FnlLKqHrdWsl4dbFKgRsO2zkiHFia6P0Q2agIt0Pi3N2jaoFoVW3BqasW0R7GR0OAytM
         1Pdad6iUaxDiYzPDhI9HtBLuOVMgzWSWnfRJdgtLU7N1j4gy6r0nEsThi8/GCDIMEF9o
         d7CEsEcOze6KUcnb08zovU+DQUnxUQzn9A1XJ0+DooF2QeKyRcoJXGsbJaP4tXfzEspj
         Yhd1ckCAz3Sh0PNgmnLjuv1pSEOQwBuxmwnCG6qcWv9OUCxHx0d9QrynPCzZ5lW6+MA7
         b1yw==
X-Gm-Message-State: APjAAAWWpePq1PL+PpQzKhanao6pucCmAi1fCLEMbrG7YDggW/mp7N7V
        FyHUdWsosKCzI0d1wV6uD2Ld+HF0SXVdxW0jTZ9+FzfSaD8nfgYmJ0BmRzXNitGir1zBhdFko0O
        bsRdF8dYgBimV/iu9JrbLqg==
X-Received: by 2002:a05:6000:1206:: with SMTP id e6mr21516276wrx.113.1573922505272;
        Sat, 16 Nov 2019 08:41:45 -0800 (PST)
X-Google-Smtp-Source: APXvYqwBEdg1RV6Rn9vhpufQzBH4HFASZZ+VzcZmLE4ePDmmdJUuzFmiMVrJ28S+UR8Oz8LAXb5eFA==
X-Received: by 2002:a05:6000:1206:: with SMTP id e6mr21516258wrx.113.1573922505036;
        Sat, 16 Nov 2019 08:41:45 -0800 (PST)
Received: from shalem.localdomain (84-106-84-65.cable.dynamic.v4.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id t13sm15322975wrr.88.2019.11.16.08.41.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Nov 2019 08:41:44 -0800 (PST)
Subject: Re: [PATCH v2] i2c: acpi: Force bus speed to 400KHz if a Silead
 touchscreen is present
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org,
        youling 257 <youling257@gmail.com>
References: <20191113182938.279299-1-hdegoede@redhat.com>
 <20191114204815.GC7213@kunai>
 <c67a085b-8013-ef03-b5b2-431ea64ca97a@redhat.com>
 <20191115205641.GA8973@kunai>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <d340cd7b-c819-58a0-f5ee-efe0665cf4df@redhat.com>
Date:   Sat, 16 Nov 2019 17:41:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20191115205641.GA8973@kunai>
Content-Language: en-US
X-MC-Unique: Li7ZPIWRMx6iPd8LgKer_Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 15-11-2019 21:56, Wolfram Sang wrote:
>=20
>> Well it is configuring the bus at a speed where not all devices
>> can work, where as there is another speed where all devices do work.
>> With that said I'm open to a different wording for the warning. Feel
>> free to modify this before you add it to your tree.
>=20
> Changed the message to "DSDT uses known not-working I2C bus speed %d,
> forcing it to %d\n" and applied to for-current, thanks!

The new message sounds good to me, thanks.

Regards,

Hans

