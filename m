Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5006F107B06
	for <lists+linux-acpi@lfdr.de>; Sat, 23 Nov 2019 00:01:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbfKVXAm (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 22 Nov 2019 18:00:42 -0500
Received: from mail-wm1-f45.google.com ([209.85.128.45]:40920 "EHLO
        mail-wm1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726719AbfKVXAm (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 22 Nov 2019 18:00:42 -0500
Received: by mail-wm1-f45.google.com with SMTP id y5so9432989wmi.5
        for <linux-acpi@vger.kernel.org>; Fri, 22 Nov 2019 15:00:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BUxF9aYNK7iP725HgBCg1pMp9QeEBXlRD1qbAxxrE10=;
        b=GnkiQ9fnY+s6+pIqB64/Ou9ED63LagszZ0f+tCv1h9slEqkoqrC8ANwcfEZrhAf0Fb
         555wBFTnLHwMesYYWkOoypHwKtnrFspekmqyN5fkiIu4lPyfJEKtGYX5MX42pgKlF9Wz
         4hB41zjeVFeprMBmQIUgigTNHjjuALdEfKfobRaffxHf2oW5VNHjO2CAAekBbShD14PV
         ruOuvdXW1BdiO1xip3HMmQb/j0GxBCyR0r6IsoIArLUZvlxyp13nGFTlr24OsdA5jLkL
         rgE0M/K6vWhU2jQKzrN5vpAb30J6VHOds/yYuCkoM/+SemxpNHZrUGft01zwzhFqn/T/
         33UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BUxF9aYNK7iP725HgBCg1pMp9QeEBXlRD1qbAxxrE10=;
        b=JR77Hk5IO6ip/bRXlDcCTBKaDJSF/tf/EndoYlfyTKdujkWQ4mjI5X08kRcYUDLlMN
         u2YH4wYex1dfgMoqbyHpA7ZJaJ+c5TtgdiysOCdoSG9D8hN2BWrarexksLa9BpMY06Be
         ZPq/lM31misTom0ptcwlKT7dGMpSQiOrSzU45Sbi4IKmlt/uwQnBI3Czx4xyhJ7cWNXX
         eZuOu3bwvwOCQZtJUyRZCZ48DBvgxhRaPxjW+4wFEEfX0vCMrN02cRhA3v2AT0yLW5HB
         5Z38V4aCcKdFuvysNs0tPTq2hLPIZ82Io9cBi3rXR5411fXNkIsqG5ez10kXp5GbZJOt
         ws0Q==
X-Gm-Message-State: APjAAAWWMXjxMMH3g2azQC+L+tfe8uGEycwxnq1G2Mw/zAstAeYOP91L
        ryMXT+x30eHKHh9zVizDQw0=
X-Google-Smtp-Source: APXvYqwDqDOmqZaguSK6VsU0AbLekgoPaJAtMH4FvkDoG9Kgt2rM7AgdqnRo2cCbPLef+8HgNe+cDg==
X-Received: by 2002:a1c:560b:: with SMTP id k11mr19762862wmb.153.1574463638077;
        Fri, 22 Nov 2019 15:00:38 -0800 (PST)
Received: from [192.168.2.202] (pD9E5A9AC.dip0.t-ipconnect.de. [217.229.169.172])
        by smtp.gmail.com with ESMTPSA id z4sm552345wmf.36.2019.11.22.15.00.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Nov 2019 15:00:37 -0800 (PST)
Subject: Re: PROBLEM: Calling ObjectType on buffer field reports type integer
To:     "Moore, Robert" <robert.moore@intel.com>,
        "Schmauss, Erik" <erik.schmauss@intel.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>
Cc:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>
References: <3ef42aa1-196d-f3db-0e5d-2fd84c198242@gmail.com>
 <CF6A88132359CE47947DB4C6E1709ED53C592D47@ORSMSX122.amr.corp.intel.com>
 <CF6A88132359CE47947DB4C6E1709ED53C59405C@ORSMSX122.amr.corp.intel.com>
 <fe4bcc1c-5c15-caa6-ce01-a5df962ff008@gmail.com>
 <CF6A88132359CE47947DB4C6E1709ED53C5942CA@ORSMSX122.amr.corp.intel.com>
 <51e156ec-c2ed-84be-13c0-99a213e1d4b7@gmail.com>
 <CF6A88132359CE47947DB4C6E1709ED53C595C50@ORSMSX122.amr.corp.intel.com>
 <88077d9c-b2b7-5fc6-37e9-fa12d6aebe73@gmail.com>
 <CF6A88132359CE47947DB4C6E1709ED53C614AA8@ORSMSX122.amr.corp.intel.com>
 <c6511010-f160-a2ee-1b89-46df051a85e4@gmail.com>
 <94F2FBAB4432B54E8AACC7DFDE6C92E3B96B196C@ORSMSX110.amr.corp.intel.com>
 <94F2FBAB4432B54E8AACC7DFDE6C92E3B96B1A77@ORSMSX110.amr.corp.intel.com>
From:   Maximilian Luz <luzmaximilian@gmail.com>
Message-ID: <adea0818-bee0-a57c-e347-98a7fb24e844@gmail.com>
Date:   Sat, 23 Nov 2019 00:00:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <94F2FBAB4432B54E8AACC7DFDE6C92E3B96B1A77@ORSMSX110.amr.corp.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


On 11/22/19 11:07 PM, Moore, Robert wrote:
> I'm not seeing this problem. For example:
>      Method (DS01)
>      {
>          Name(BUFZ, Buffer(48){})
>          CreateField(BUFZ, 192, 69, DST0)
>          Store (ObjectType (DST0), Debug)
>      }
> 
> Acpiexec dsdt.aml
> Eval DS01
> Evaluating \DS01
> ACPI Debug:  0x000000000000000E
> 
> 0x0E is in fact type "buffer field".

Hi,

unfortunately, the bug is a bit more convoluted, here's a minimal
example:

     Method (DS01)
     {
         Name(BUFZ, Buffer(48){})
         CreateField(BUFZ, 192, 32, DST0)
         Local0 = DST0
         Store (ObjectType (Local0), Debug)
     }

It is based on the combination of CreateField with length smaller or
equal to the maximum integer size and the assignment of the field to a
local variable. For me, this yields

Eval DS01
Evaluating \DS01
ACPI Debug:  0x0000000000000001

As already iterated, this should be the correct behavior according to
spec, but causes failures on Microsoft Surface devices.

For reference, I've added two links to the relevant parts in the DSDT of
the MS Surface Book 2: In short, MS identifies errors by the type of a
local variable which is supposed to either contain a payload (buffer) or
an error value (integer). This local variable (Local4) is previously
assigned from a buffer field [1] containing some payload data. However
on Linux, if the payload data is smaller than or equal to 64 bits, the
type of the variable is integer and the transaction gets misidentified
as having failed [2].

[1]: https://github.com/qzed/surfacebook2-dsdt/blob/fa0ca7c7cba8fb0da1e79c282f9a9f4a12eaaa17/dsdt.dsl#L15396-L15397
[2]: https://github.com/qzed/surfacebook2-dsdt/blob/fa0ca7c7cba8fb0da1e79c282f9a9f4a12eaaa17/dsdt.dsl#L15427

In hindsight, the subject line is not describing the actual problem very
well, I apologize for that.

Thanks,
Maximilian

