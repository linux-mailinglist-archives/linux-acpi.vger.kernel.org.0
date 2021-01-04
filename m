Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E4872E9762
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Jan 2021 15:36:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727126AbhADOgD (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 4 Jan 2021 09:36:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:48425 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726419AbhADOgD (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 4 Jan 2021 09:36:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609770876;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MlGNmue/OEcc+LrokQ5uW+ClGR/N9N2hz5xtfGyMhr8=;
        b=SB3T5wEVE9a1BhpX+e46rGYN7csXHpDLYnqOAavVskWOI2NKrLtT1ttwz1Rlf0r8mGvIO8
        SqqqFqYQQM3IBhtuGEfgRLlCM4+ufZQ4Om4qGxWGRPpOjMAW3t8uQvlSMeCg3BsUzgua10
        ysHQ03OL9G9a7CRdd603qZiBOJZjiLU=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-588-YRrB2X3HNV2wdbBkqBF6iQ-1; Mon, 04 Jan 2021 09:34:34 -0500
X-MC-Unique: YRrB2X3HNV2wdbBkqBF6iQ-1
Received: by mail-ej1-f69.google.com with SMTP id r26so7013333ejx.6
        for <linux-acpi@vger.kernel.org>; Mon, 04 Jan 2021 06:34:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MlGNmue/OEcc+LrokQ5uW+ClGR/N9N2hz5xtfGyMhr8=;
        b=IzbliPbSelnbcjCR1tn4zeY2ahVjR0S/docavW32Q4uV3JekS/bvzBw6x7Cpk/XvAt
         9J18j+b2jmXlasnt39IYnpbtHwymZxggDwo2D3OrvhlgodyU9ULLjTwdprI688cu+6c7
         yXVTlVOWAFCfgwDhX9aWtGiX53SRQ6/LliQTSqOLcH6sg3Q+Nt9q3QwKR7QeierE3bgZ
         aJtb3xpvPEbdl0WpUtYGuY91pLCmQhcNS32Knaqw/5hl1SzRPQ5Sgde6mxcibB6gXK8T
         smpovCA6gDD22d8th5PDSCS+YEYJ8Bhm28rHevg+AOyFxHCsLQ2azQMgE2LTMqPx1mmx
         g86Q==
X-Gm-Message-State: AOAM533X8zdHe+6a9Z2KMP2LmtzZcS/HC7mp33VzgrDWePSRCm2U6vtL
        ANO3kxr6+DQ1WEhBV76fIgyd+cwF6N8uDH6dmyoR8s47fG7ggzvq5N3NUD+1iwMTy6cmCn5fFGW
        G0F9nqP2lLMxeOnMshmpZNA==
X-Received: by 2002:a17:906:b09a:: with SMTP id x26mr42799381ejy.199.1609770872624;
        Mon, 04 Jan 2021 06:34:32 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyznHvL5Jm3vifHBDmK8iYArUSZMyjWRdPfXkd44h1PErXhEC1aVo64TNJev5ys8eLkIEsggA==
X-Received: by 2002:a17:906:b09a:: with SMTP id x26mr42799366ejy.199.1609770872506;
        Mon, 04 Jan 2021 06:34:32 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-37a3-353b-be90-1238.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:37a3:353b:be90:1238])
        by smtp.gmail.com with ESMTPSA id v24sm44039398edw.23.2021.01.04.06.34.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Jan 2021 06:34:32 -0800 (PST)
Subject: Re: [PATCH 0/2] IdeaPad platform profile support
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>,
        platform-driver-x86@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Mark Gross <mgross@linux.intel.com>,
        Ike Panhc <ike.pan@canonical.com>,
        Mark Pearson <markpearson@lenovo.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210101125629.20974-1-jiaxun.yang@flygoat.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <35ac853a-266c-6944-6e5e-6286456865e3@redhat.com>
Date:   Mon, 4 Jan 2021 15:34:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20210101125629.20974-1-jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 1/1/21 1:56 PM, Jiaxun Yang wrote:
> Tested on Lenovo Yoga-14SARE Chinese Edition.
> 
> Jiaxun Yang (2):
>   ACPI: platform-profile: Introduce data parameter to handler
>   platform/x86: ideapad-laptop: DYTC Platform profile support
> 
>  drivers/acpi/platform_profile.c       |   4 +-
>  drivers/platform/x86/Kconfig          |   1 +
>  drivers/platform/x86/ideapad-laptop.c | 281 ++++++++++++++++++++++++++
>  include/linux/platform_profile.h      |   5 +-
>  4 files changed, 287 insertions(+), 4 deletions(-)


Thank you for your series, unfortunately the
"ACPI: platform-profile: Introduce data parameter to handler"
patch causes a conflict with the pending:
"[PATCH v8 3/3] platform/x86: thinkpad_acpi: Add platform profile support"
patch.

But I do agree that adding that data parameter makes sense, so
it might be best to merge:

"ACPI: platform-profile: Introduce data parameter to handler"

First and then rebase the thinkpad_acpi patch on top.

Rafael, do you think you could add:

"ACPI: platform-profile: Introduce data parameter to handler"

To the 2 ACPI: platform-profile patches which you already have pending for 5.11-rc# ?

Regards,

Hans

