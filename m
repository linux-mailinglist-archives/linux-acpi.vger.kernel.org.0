Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACE2291915
	for <lists+linux-acpi@lfdr.de>; Sun, 18 Aug 2019 20:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbfHRS7N (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 18 Aug 2019 14:59:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46804 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726247AbfHRS7N (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sun, 18 Aug 2019 14:59:13 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3797A2A09C4
        for <linux-acpi@vger.kernel.org>; Sun, 18 Aug 2019 18:59:13 +0000 (UTC)
Received: by mail-wr1-f72.google.com with SMTP id w11so4042628wru.17
        for <linux-acpi@vger.kernel.org>; Sun, 18 Aug 2019 11:59:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rLnw+O344r+V6G+bSidLmsGPxTIhpm+W7MqHjsCtkcU=;
        b=AG0CGXujUsFksTey8vSd29dScgvzMgtcy1H1vC39frN8ve5kjwpyCWxiA+lo5gvbAR
         vSSnJOKkEmNfXonpPYM9r3htuWjHsAhsimSPp8ssWLtujCyCGYJZJnHHcbebJkm3/akV
         Amrgmh9tC8W+Ctj/6fF3yNYC4rKngi62IEt95GSmkKveomIOzBOKKkZaXQaS2NYlUaNu
         kOQNkfYSxzrAhgvLVk0GLbtJDOf2bYdRBIlSmw4hsR3Am0PCd6FKtdUq3GdPvYAtODqE
         +dbcEfXCl93T67auTOr8k0M5Lc01/f2h+Ak3dLV3uXnzDjoDkOmKmxTf2e1Buggv2p1A
         2+Ew==
X-Gm-Message-State: APjAAAW6k9SpRvo+X1HDvBOlK4CfPAXRo92KmhwGJxpTtn93wIbwg+Id
        gxjaQEg/EeeSTO2UcUiRX+KDmKS/FKI0FR83kXce/cZx5mPmGKV348M+xEuyxUc3GUX5PBg/SWw
        FkSTI3DsKeFrTM5jbGOWH7g==
X-Received: by 2002:adf:9d8b:: with SMTP id p11mr21383316wre.226.1566154752037;
        Sun, 18 Aug 2019 11:59:12 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwCda0oiQniE8VTTJFhm/VcFLZnJgyLuV1Uw2JLit2LXkvDt7KgGz4+bry6gm1vc/dhnCQ+Hw==
X-Received: by 2002:adf:9d8b:: with SMTP id p11mr21383299wre.226.1566154751896;
        Sun, 18 Aug 2019 11:59:11 -0700 (PDT)
Received: from shalem.localdomain (84-106-84-65.cable.dynamic.v4.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id s2sm10777294wrp.32.2019.08.18.11.59.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Aug 2019 11:59:10 -0700 (PDT)
Subject: Re: [PATCH] Skip deferred request irqs for devices known to fail
To:     Ian W MORRISON <ianwmorrison@gmail.com>
Cc:     benjamin.tissoires@redhat.com, mika.westerberg@linux.intel.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20190322110515.21499-1-ianwmorrison@gmail.com>
 <b5a7b895-e08d-f432-8606-4d8c776d4a8a@redhat.com>
 <CAFXWsS9UYYz0HaYPgLAUZ0OaUE9gb25bT0+PSuexY9Nn05rY8Q@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <c144cbd0-1773-14cd-62c9-6f41eab5894a@redhat.com>
Date:   Sun, 18 Aug 2019 20:59:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAFXWsS9UYYz0HaYPgLAUZ0OaUE9gb25bT0+PSuexY9Nn05rY8Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Ian, et. al.,

On 23-03-19 04:39, Ian W MORRISON wrote:
> Hi Hans,
> 
>> IMHO we need to root-cause this problem a bit more before applying this
>> kludge.
>>
>> Can you provide an ACPI dump of one of the affected machines ?
>>
> 
> Attached is an ACPI dump.

First of all sorry for taking way too long to get back to you on this.

So I've taken a look at all the _AEI code in the DSDT, a whole bunch of
it seems copy and pasted from various tablets, but nothing really
stands out as being a likely cause of this.

As such I guess we may need to go with the blacklist patch you suggested
which sucks, but having these devices not boot sucks even harder.

I guess this problem did not magically fix it self in the mean time
(with newer kernels) ?

Can you resubmit your patch with Andy's review remarks addressed?

In case you've lost Andy's reply I will reproduce the review remarks
below.

Regards,

Hans

p.s.

Andy's review remarks as promised:

 >  #include <linux/interrupt.h>
 >  #include <linux/mutex.h>
 >  #include <linux/pinctrl/pinctrl.h>
 > +#include <linux/dmi.h>

This should be in order.

 >  /* Run deferred acpi_gpiochip_request_irqs() */
 > +/* but exclude devices known to fail */

/*
  * This should be done in the similar style
  * as for multi-line comments. Like this one.
  */

 > +	dmi_id = dmi_first_match(skip_deferred_request_irqs_table);
 > +

Redundant blank line.

 > +	if (! dmi_id) {

No space here, however, better to write positive conditional.

