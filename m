Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 078481357A1
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Jan 2020 12:08:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730522AbgAILIZ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 9 Jan 2020 06:08:25 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:33358 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730521AbgAILIY (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 9 Jan 2020 06:08:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578568103;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gdER25NKHzO7PNWA2X0xOynVrkCRDD8R87T3Ujm85/0=;
        b=DJJlM2JGwlHrhWPJvM3JQAVYHfbMV5tP31hnYSzWE7NQXer+SQYdFQvgNRWbqlGEN7eny7
        fUODmzb1GfSS6E7AEz4Bakix6B4PyDAmCOAnhffikz1Rm+T1CtdMK5nnvj2j3XhQJ84aIq
        gRhuKAUcLNf4fCmJB+mGhgpvLeSZQeo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-283-3PI2X--mPc2uvcW3JRVLdA-1; Thu, 09 Jan 2020 06:08:22 -0500
X-MC-Unique: 3PI2X--mPc2uvcW3JRVLdA-1
Received: by mail-wm1-f72.google.com with SMTP id t4so785590wmf.2
        for <linux-acpi@vger.kernel.org>; Thu, 09 Jan 2020 03:08:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gdER25NKHzO7PNWA2X0xOynVrkCRDD8R87T3Ujm85/0=;
        b=AMUWtGTfg72xxQYuA9ALOTqr+O55SHpWUm9pzq4WW94LztyhLzwXq2HMghj2ZXd9bq
         J/KqjQY9VJaFaHpgIzmIsnaQ13IwLENHp92IWR53GmJq7zEqStwr6WdfyYQKbQVbHPjO
         CKqPatPVuLg8kmcdBsnoJ3mY4toPLl/EtumbXHr2HDTNHBhPitB83pcrJegYgFucBDZx
         0cLj7/J3c7OtqOok911vKttA9Yyg/+6965Zj3Fe13NNGLQiSdlK/CPyUCNYiNJuu6ely
         vZ34XUcMuaADZcAS8J/8rDe6svpErjNs2PG1UegvlyJsXCvj8BaiRbSUADbmmAejoZ5S
         LP4g==
X-Gm-Message-State: APjAAAULiOzB86G+Ts5vsfdaw4MX7uHcISjkiCnluZTOn75Q8n38/NcQ
        1NHKWtLm3ISl/Yb0PZ5a/9YKtLuE+BwWjUd+c2c2JaF4kI646WebJjZDCKwS+T98HSa/Q4PrA/F
        jm8BOCD0iGx6QiJ/NagW2Rw==
X-Received: by 2002:a1c:20d6:: with SMTP id g205mr4229363wmg.38.1578568101171;
        Thu, 09 Jan 2020 03:08:21 -0800 (PST)
X-Google-Smtp-Source: APXvYqzV+HpvZzMnhDG1/nvE/ODroUja7OE02ypl4zwnj4Un2RVrjJFMj4c0q81IWYwGeffY243U+A==
X-Received: by 2002:a1c:20d6:: with SMTP id g205mr4229324wmg.38.1578568100878;
        Thu, 09 Jan 2020 03:08:20 -0800 (PST)
Received: from shalem.localdomain (2001-1c00-0c0c-fe00-7e79-4dac-39d0-9c14.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:7e79:4dac:39d0:9c14])
        by smtp.gmail.com with ESMTPSA id a14sm8210096wrx.81.2020.01.09.03.08.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jan 2020 03:08:20 -0800 (PST)
Subject: Re: [PATCH v3] pinctrl: baytrail: Replace WARN with dev_info_once
 when setting direct-irq pin to output
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bastien Nocera <hadess@hadess.net>,
        Dmitry Mastykin <mastichi@gmail.com>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org
References: <20200101145243.15912-1-hdegoede@redhat.com>
 <20200108174745.GG32742@smile.fi.intel.com>
 <f1ace666-1c57-0688-9737-d3ab2f5a1073@redhat.com>
 <20200109102100.GK32742@smile.fi.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <9d6d5a74-b9b0-1cc8-1347-24d96961dd6d@redhat.com>
Date:   Thu, 9 Jan 2020 12:08:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200109102100.GK32742@smile.fi.intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 09-01-2020 11:21, Andy Shevchenko wrote:
> On Thu, Jan 09, 2020 at 10:05:47AM +0100, Hans de Goede wrote:
>> On 08-01-2020 18:47, Andy Shevchenko wrote:
>>> On Wed, Jan 01, 2020 at 03:52:43PM +0100, Hans de Goede wrote:
> 
> ...
> 
>>>>    		/*
>>>>    		 * Before making any direction modifications, do a check if gpio
>>>>    		 * is set for direct IRQ.  On baytrail, setting GPIO to output
>>>>    		 * does not make sense, so let's at least warn the caller before
>>>
>>> ...if it's a warning, perhaps do a warning instead of info?
>>> Otherwise, we probably need to change a comment here.
>>
>> I went with info on purpose since this will trigger on all BYT devices with
>> a Goodix touchscreens of which we have quite a few, so my vote goes to maybe
>> the comment. Note that although the log level is info (because it is somewhat
>> expected to happen), the content of the log msg is still warning-ish.
>>
>> I guess we could replace "let's at least warn the caller before" with
>> "let's at least let the caller know before"
> 
> What about simple 'warn -> inform' ?
> (I can update myself)

Works for me, thanks.

Regards,

Hans



> 
>>>>    		 * they shoot themselves in the foot.
>>>>    		 */
>>>> -		WARN(readl(conf_reg) & BYT_DIRECT_IRQ_EN,
>>>> -		     "Potential Error: Setting GPIO with direct_irq_en to output");
>>>> +		dev_info_once(vg->dev, "Potential Error: Setting GPIO with direct_irq_en to output");
> 

