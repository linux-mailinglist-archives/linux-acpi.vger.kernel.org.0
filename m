Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B9FC18F21
	for <lists+linux-acpi@lfdr.de>; Thu,  9 May 2019 19:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbfEIR3Y (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 9 May 2019 13:29:24 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36780 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726620AbfEIR3X (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 9 May 2019 13:29:23 -0400
Received: by mail-wr1-f67.google.com with SMTP id o4so4176738wra.3;
        Thu, 09 May 2019 10:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0eIlVQbWI8g5JXbhGDz/v6qz2yMoeFekelRAxpCY1YE=;
        b=NSUaoglHXJt16ZWloR1KWtWq1rgzB5CHkigcbLVc+puUPpjdFq2WYMuC1a5knL7aFJ
         3wxIQztS9NNSU9V3DxZQLoZQMKHPtFB69zFaaKkySYVOSH7dYTjkZVfL67HVjFXuODa9
         bEIdkT+wZFp0RiX9KR0vco6XUDrWy8j1FB6SiyUyz4Q8t+4UGIQovIwR6JE3UVwub+dv
         gTW4nnb+z7jE8v1+Cw18BXbrCEjLgsQaF/r1w8hIGCWgnIdTYTK346uEu5TLyp+aiaAY
         VfOWDsgWq6K2IHeXm9JDkJIwygPauiMtPXK1BAXONydqH1+vOWwLjOQ8Oy1sao8XVa04
         D4tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0eIlVQbWI8g5JXbhGDz/v6qz2yMoeFekelRAxpCY1YE=;
        b=Co3CTFG+tYv4flGI7F2mZppzpW/PSPPnPLV3HjWIpkc3oSRLGW7UEJXx6qPWafWsm3
         fODeVf40ahYsGbOljYbCE5puQ7NPua0MkidB1aIabaJdbK+gM7A1m5VEseTHiRebMx0x
         o4wZ1G1oL85MVz23Mk/UqJh/y0ZHDrKv6gwu4b8F0/+mMn6CCljr0/kkodLl5cTmtOor
         RhLY9XzXexxifWIfBOcF6WxAfewu5Oz7xnnHERZQM2gx89my9c4/oGFMNDmQaxVeDKHV
         YlmuX2mvBCfC+/whbyam8dZOVXHhjQqrHuv/Kzd+5YBOXkcNKtVDbJ4rfWrfp+P6xj3a
         4eRQ==
X-Gm-Message-State: APjAAAVCZV0T4r1z7gDpUnRlFpXIsp7lG+J0eF73KGvq6EOaukqTIrIo
        h5DCe273+5/X81V4L7v9zZSkflKX
X-Google-Smtp-Source: APXvYqzjfj+RreaXw8yHYTh6pXAQ6mVMdLnN/rIqvVyhV0RIB+0kNNk0YZiXlxO710miCsBAY05muA==
X-Received: by 2002:a5d:468b:: with SMTP id u11mr4239147wrq.276.1557422961352;
        Thu, 09 May 2019 10:29:21 -0700 (PDT)
Received: from [192.168.20.141] ([194.99.104.18])
        by smtp.gmail.com with ESMTPSA id s11sm8019211wrb.71.2019.05.09.10.29.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 10:29:20 -0700 (PDT)
Subject: Re: [PATCH v3 04/11] platform/x86: asus-wmi: Improve DSTS WMI method
 ID detection
To:     Daniel Drake <drake@endlessm.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Corentin Chary <corentin.chary@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        acpi4asus-user <acpi4asus-user@lists.sourceforge.net>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
References: <7acd57fe-604a-a96a-4ca2-a25bc88d6405@gmail.com>
 <d6ee51cc-eb0f-2bb9-fef9-f8b4bf849076@gmail.com>
 <CAHp75VfMXAyUpWTrEHnv1NcQcHch+RHehWYTjk6KMTbXbtppPg@mail.gmail.com>
 <CAD8Lp46tCfi3ZCmmXZv3-ZDbon+6P8qC4GPR9Bt3uFFr=Sn4Cw@mail.gmail.com>
From:   Yurii Pavlovskyi <yurii.pavlovskyi@gmail.com>
Message-ID: <92518192-8cf0-7529-0c05-4b3e44ce04b7@gmail.com>
Date:   Thu, 9 May 2019 19:29:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAD8Lp46tCfi3ZCmmXZv3-ZDbon+6P8qC4GPR9Bt3uFFr=Sn4Cw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 08.05.19 15:36, Andy Shevchenko wrote:> On Fri, Apr 19, 2019 at 1:08 PM
Yurii Pavlovskyi
> <yurii.pavlovskyi@gmail.com> wrote:
>>         int rv;
>> +       char *wmi_uid;
>
> Keep them in reversed spruce order.

What do you mean by that? Do you mean like this?
+ char *wmi_uid;
int rv;
int err;

>> +#define ASUS_WMI_METHODID_DSTS         0x53544344 /* Device STatuS
(DCTS) */
>
> It's not clear from the description what 'C' stands for.
> Is there any specification which describes the difference and actual
> abbreviations?
>
Not that I know of. Daniel had written some research in the previous
version thread regarding where it is used, but as I understand from current
implementation the functional difference is not really there, as it serves
the same purpose as DSTS, just for another hardware.

On 09.05.19 08:08, Daniel Drake wrote:
> For clarity I think the constants could be renamed as
> ASUS_WMI_METHODID_DCTS and ASUS_WMI_METHODID_DSTS.
>
Agree, that'll be better.

Thanks,
Yurii
