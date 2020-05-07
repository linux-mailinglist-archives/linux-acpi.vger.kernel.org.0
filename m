Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7D5A1C86B4
	for <lists+linux-acpi@lfdr.de>; Thu,  7 May 2020 12:30:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725910AbgEGKan (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 7 May 2020 06:30:43 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:39350 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbgEGKan (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 7 May 2020 06:30:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588847442;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8jYlXVIeYwPIAaTa/8NGwUOA9TXF5pyDMIzCVjgMxm8=;
        b=aMSq1J1o6wF4uC5rBWIhP0LlYVufwCrastgC53GHxqKYF1HYjd4+O8dVkPEfsfokB9Pfh8
        p9OTVE8PsXLKtoTFMM8K276695/Npeo+peauEEDbBEWIi3k0kfVmt/qA0z/coL7lscs3hZ
        OOmAwn0dLLKunMrbIIduOYdiCSwdBpA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-3-OjWIjcf6MwmMXZSDF7dAiQ-1; Thu, 07 May 2020 06:30:40 -0400
X-MC-Unique: OjWIjcf6MwmMXZSDF7dAiQ-1
Received: by mail-wr1-f70.google.com with SMTP id f2so3169398wrm.9
        for <linux-acpi@vger.kernel.org>; Thu, 07 May 2020 03:30:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8jYlXVIeYwPIAaTa/8NGwUOA9TXF5pyDMIzCVjgMxm8=;
        b=AiM3riC2i7u3Engi0t5XkdAtRQJ4Dv3Q9uMdQYYSXIGXLnabjKMsZi8qTL5qhDVOxu
         kBflRIome4DHqWWZOCtyT0miJS33D33FJ48bIppk0JSQKSxz9TuzxEdFfUIyBFEc1xBf
         UfuoMjirwvZFhu5FdII9vLXlM80hySkIp+UUDMC5X41WsShQ8GaGjY1TtV7cuHHDUJpd
         vJ4xfbkCri5yGUn+Mrto8fAIu/TuuR7kkZ7LemYlfHQoNG8qziaf0Pu5oJFa9EtvOgv3
         DzAKQ9AWEhZWruMVY+bkzSC4mOAceoVTokgTe/IpH0IwWpOqH0epqPNWIZ7BTnqxo+Yu
         qa3w==
X-Gm-Message-State: AGi0Puav16oRml8tjmp0sCsfH+XEC2fq25HzT1sfdex4MYkKDaTRAndo
        iC23HPLfmr+yCF429TjJFJvYqMCaYV7Yi5kz4DPY/nq1PgWFP5/mzZlNwoWlmSClCqMD3T0QoaV
        MtLfZekVKzC+H6zAuC1udzw==
X-Received: by 2002:a5d:5642:: with SMTP id j2mr3913176wrw.52.1588847439005;
        Thu, 07 May 2020 03:30:39 -0700 (PDT)
X-Google-Smtp-Source: APiQypLYsFyxuTZc14Fgz1L9YXfTpaCsMoR+ZYvt4JlYFVWwq/uNI7MbYeDdYuumr/g0A43oTs6NUA==
X-Received: by 2002:a5d:5642:: with SMTP id j2mr3913158wrw.52.1588847438835;
        Thu, 07 May 2020 03:30:38 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id q187sm7512995wma.41.2020.05.07.03.30.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 May 2020 03:30:38 -0700 (PDT)
Subject: Re: [PATCH 1/3] ACPI / utils: Add acpi_evaluate_reg() helper
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-gpio@vger.kernel.org
References: <20200505132128.19476-1-hdegoede@redhat.com>
 <20200505132128.19476-2-hdegoede@redhat.com>
 <20200505154205.GR185537@smile.fi.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <3a8682dc-5423-d057-4289-929a84f28f94@redhat.com>
Date:   Thu, 7 May 2020 12:30:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200505154205.GR185537@smile.fi.intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 5/5/20 5:42 PM, Andy Shevchenko wrote:
> On Tue, May 05, 2020 at 03:21:26PM +0200, Hans de Goede wrote:
>> With a recent fix to the pinctrl-cherryview driver we know have
>> 2 drivers open-coding the parameter building / passing for calling
>> _REG on an ACPI handle.
>>
>> Add a helper for this, so that these 2 drivers can be converted to this
>> helper.
> 
> Suggested-by?

Right sorry about that I will fix this for v2.

 >> + * @function: Parameter to pass to _REG one of ACPI_REG_CONNECT or
 >> + *            ACPI_REG_DISCONNECT
 >
 > Is it enum or definitions? If former can we refer to it?

These are #define-s.

Regards,

Hans

