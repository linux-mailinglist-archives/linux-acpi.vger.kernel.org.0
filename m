Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4678F88C78
	for <lists+linux-acpi@lfdr.de>; Sat, 10 Aug 2019 19:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726147AbfHJRZz (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 10 Aug 2019 13:25:55 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:41679 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbfHJRZz (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 10 Aug 2019 13:25:55 -0400
Received: by mail-ot1-f65.google.com with SMTP id o101so9883339ota.8
        for <linux-acpi@vger.kernel.org>; Sat, 10 Aug 2019 10:25:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=dmrs5pFCBj9On+SbjBpOAPXKaVn0DvMCZgTb4mfkLts=;
        b=AwPcdpf/hJOXkhb8eMwWFbwSC/qFbc5QJ/+3F0OdWLhZqcNbOvUFUoI+PV5L1akCU8
         lPF/CuAG7kd0PKKRZvBAS/+q2q/2iJvkB4s4S0DdyVLgXPynDz5Jnl0fX42nffjApdXV
         r678nc2Z2v0P3SfjQmfQcfoMg6pVGVaouF+P5Vru8fx0zjEpP9GoTqBECRDELH6IoNl6
         D+dRXvy5xk2x53Nj70c7As9NbqiNS/YSsrzIaw2+aarMAdZIg20ljVBWVF9ePfyhyLSB
         frUXLdoGgsS7H9HvI9bLDbTZw26IhECyQN4SfvjHy7l5hFImlzWlAUQrwvSd1aDE0p/L
         ipGQ==
X-Gm-Message-State: APjAAAX5JQR6Y6syceLa2K/yUA+4TTQrGhklHMyJD5TTrN4qFLkmbQEK
        jOEyINkYSY4ULQy4B22/FY3Jew==
X-Google-Smtp-Source: APXvYqxzNa3AT+XtXWSe12rwllYzVp6a5m/K3d0vXyVaEBlsvIRPrdQWFY2OazBw2Glf8Ldnx0zU+w==
X-Received: by 2002:a05:6638:c8:: with SMTP id w8mr3295587jao.52.1565457954493;
        Sat, 10 Aug 2019 10:25:54 -0700 (PDT)
Received: from masetto.ahs3 (c-67-165-232-89.hsd1.co.comcast.net. [67.165.232.89])
        by smtp.gmail.com with ESMTPSA id x23sm8466137iob.36.2019.08.10.10.25.53
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Sat, 10 Aug 2019 10:25:53 -0700 (PDT)
Reply-To: ahs3@redhat.com
Subject: Re: [PATCH] ACPI / CPPC: do not require the _PSD method when using
 CPPC
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
References: <20190805170338.29493-1-ahs3@redhat.com>
 <20190807114118.GJ16546@e107155-lin>
From:   Al Stone <ahs3@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <b873db68-a130-ed7f-83e0-4491b1c0ff53@redhat.com>
Date:   Sat, 10 Aug 2019 11:25:53 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190807114118.GJ16546@e107155-lin>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 8/7/19 5:41 AM, Sudeep Holla wrote:
> On Mon, Aug 05, 2019 at 11:03:38AM -0600, Al Stone wrote:
>> According to the ACPI 6.3 specification, the _PSD method is optional
>> when using CPPC.  The underlying assumption appears to be that each CPU
>> can change frequency independently from all other CPUs; _PSD is provided
>> to tell the OS that some processors can NOT do that.
>>
>> However, the acpi_get_psd() function returns -ENODEV if there is no _PSD
>> method present, or an ACPI error status if an error occurs when evaluating
>> _PSD, if present.  This essentially makes _PSD mandatory when using CPPC,
>> in violation of the specification, and only on Linux.
>>
>> This has forced some firmware writers to provide a dummy _PSD, even though
>> it is irrelevant, but only because Linux requires it; other OSPMs follow
>> the spec.  We really do not want to have OS specific ACPI tables, though.
>>
>> So, correct acpi_get_psd() so that it does not return an error if there
>> is no _PSD method present, but does return a failure when the method can
>> not be executed properly.  This allows _PSD to be optional as it should
>> be.
>>
> 
> Makes sense to me. FWIW,
> 
> Reviewed-by: Sudeep Holla < sudeep.holla@arm.com>
> 
> --
> Regards,
> Sudeep
> 

Thanks for the review, Sudeep.  All the ARM systems I've seen seem to
have a _PSD so this hasn't been an issue there.  Some newer platforms
coming out are starting to use CPPC, though, and took the spec at face
value :).

-- 
ciao,
al
-----------------------------------
Al Stone
Software Engineer
Red Hat, Inc.
ahs3@redhat.com
-----------------------------------
