Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C72413D1A2
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Jun 2019 18:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405512AbfFKQDS (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 11 Jun 2019 12:03:18 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:34067 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405510AbfFKQDR (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 11 Jun 2019 12:03:17 -0400
Received: by mail-io1-f67.google.com with SMTP id k8so10362428iot.1
        for <linux-acpi@vger.kernel.org>; Tue, 11 Jun 2019 09:03:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=0mWSyTQJvoed04iwSAjNkm9jUTEiqeLoFtV8kHFixFA=;
        b=i77wmHdAbIdKm8Ngoo5cTpQXGXm6N6wSQ8JEjszdISPV1dS0glZqv6uDLvA8W65TGi
         CoDSt0XG8JtTwlwYygxq4Hsnlp0Rj15tHDYkx/liNfXBm3NVjvVhRGyhUoZdDWQn/T4p
         79G0nIkEWIrysZebTIpYiGOA5w5v4FQp4dcYtWyAVzTrJy4q3EcGTxHYxFuq3GPoRT2R
         4mI//mdGwsVrm79amgDWluaC55C4f4GArBvv35vOFYZUZ0hKf09PowGB7Bvmzt+1cVH6
         cSozrTzwabnI2iBj7dmqcd4C6pw1jbQdN1p4L2rBws5FvN9TZDrTlnS36OTLuj063EPI
         4TTg==
X-Gm-Message-State: APjAAAV9mWKjL7pIOwthtFhEL4vZD/TqXqUuFYK0ZsrjhSTJzFjT0U8K
        n9GNWBJKpKC+1lRz8WbAk8ygNA==
X-Google-Smtp-Source: APXvYqw7vh3o407Y7teYmLsSLtYLUHcQTYDz1NEf5mJ53lbtx1grZJAj348tE76u5CSzFDgrrUb7Ig==
X-Received: by 2002:a6b:c90c:: with SMTP id z12mr42308195iof.11.1560268996957;
        Tue, 11 Jun 2019 09:03:16 -0700 (PDT)
Received: from masetto.ahs3 (c-67-165-232-89.hsd1.co.comcast.net. [67.165.232.89])
        by smtp.gmail.com with ESMTPSA id b8sm4968332ioj.16.2019.06.11.09.03.16
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Jun 2019 09:03:16 -0700 (PDT)
Reply-To: ahs3@redhat.com
Subject: Re: [RFC PATCH] ACPI / processors: allow a processor device _UID to
 be a string
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190610200734.1182-1-ahs3@redhat.com>
 <20190611125258.GA16445@e107155-lin>
From:   Al Stone <ahs3@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <5ea4f403-853f-5067-4e9b-a8aabec5b1cd@redhat.com>
Date:   Tue, 11 Jun 2019 10:03:15 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190611125258.GA16445@e107155-lin>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 6/11/19 6:53 AM, Sudeep Holla wrote:
> On Mon, Jun 10, 2019 at 02:07:34PM -0600, Al Stone wrote:
>> In the ACPI specification, section 6.1.12, a _UID may be either an
>> integer or a string object.  Up until now, when defining processor
>> Device()s in ACPI (_HID ACPI0007), only integers were allowed even
>> though this ignored the specification.  As a practical matter, it
>> was not an issue.
>>
>> Recently, some DSDTs have shown up that look like this:
>>
>>   Device (XX00)
>>   {
>> 	Name (_HID, "ACPI0007" /* Processor Device */)
>>         Name (_UID, "XYZZY-XX00")
>>         .....
>>   }
>>
>> which is perfectly legal.  However, the kernel will report instead:
>>
> 
> I am not sure how this can be perfectly legal from specification
> perspective. It's legal with respect to AML namespace but then the
> other condition of this matching with entries in static tables like
> MADT is not possible where there are declared to be simple 4 byte
> integer/word. Same is true for even ACPI0010, the processor container
> objects which need to match entries in PPTT,
> 
> ACPI Processor UID(in MADT): The OS associates this GICC(applies even
> for APIC and family) Structure with a processor device object in
> the namespace when the _UID child object of the processor device
> evaluates to a numeric value that matches the numeric value in this
> field.
> 
> So for me that indicates it can't be string unless you have some ways to
> match those _UID entries to ACPI Processor ID in MADT and PPTT.
> 
> Let me know if I am missing to consider something here.
> 
> --
> Regards,
> Sudeep
> 

Harumph.  I think what we have here is a big mess in the spec, but
that is exactly why this is an RFC.

The MADT can have any of ~16 different subtables, as you note.  Of
those, only these require a numeric _UID:

   -- Type 0x0: Processor Local APIC
   -- Type 0x4: Local APIC NMI [0]
   -- Type 0x7: Processor Local SAPIC [1]
   -- Type 0x9: Processor Local x2APIC
   -- Type 0xa: Local x2APIC NMI [0]
   -- Type 0xb: GICC

Note [0]: a value of !0x0 is also allowed, indicating all processors
     [1]: this has two fields that could be interpreted as an ID when
          used together

It does not appear that you could build a usable system without any
of these subtables -- but perhaps someone knows of incantations that
could -- which is why I thought a string _UID might be viable.

If we consider the PPTT too, then yeah, _UID must be an integer for
some devices.

Thanks for the feedback; it forced me to double-check my thinking about
the MADT.  The root cause of the issue is not the kernel in this case,
but a lack of clarity in the spec -- or at least implied requirements
that probably need to be explicit.  I'll send in a spec change.

-- 
ciao,
al
-----------------------------------
Al Stone
Software Engineer
Red Hat, Inc.
ahs3@redhat.com
-----------------------------------
