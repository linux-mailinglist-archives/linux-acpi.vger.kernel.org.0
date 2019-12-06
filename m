Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2F8B115149
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Dec 2019 14:48:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726171AbfLFNsX (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 6 Dec 2019 08:48:23 -0500
Received: from mail-wr1-f46.google.com ([209.85.221.46]:43623 "EHLO
        mail-wr1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbfLFNsX (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 6 Dec 2019 08:48:23 -0500
Received: by mail-wr1-f46.google.com with SMTP id d16so7786974wre.10
        for <linux-acpi@vger.kernel.org>; Fri, 06 Dec 2019 05:48:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FAMT5MsfQCbX8RSCYEHlD4zDdhmee8GUTAni07GkLwY=;
        b=SaFhrgKF3mq1MzVxEgm5cCOo80zHalbTQS542I5e4DgAbmtGewDx4wRm9pzUV7feKR
         z86ATpRBrbgzmKti2s0zefK+Zm5M4K13CjhOW7+RfxbR+8FJvzJV60/84c4HOiA7y6jp
         GNfv6iDaAo2tyd5huj9QR/pvD9gxRaVqpmPD85jp94FWrMGRGmg5aMUQo98w7BowMjs7
         socrgYtXQWy06IfZLAO6nImmvtbMWKgJe8DLiH7novELJbcDTTuISfVadvbWrOCvAM6b
         eQGRbvNGO1XxdgnQYtdHrVmmeNczOdRqQn/UY7SSO4GKNn7bHDdtnv01lAJJHyy9SiyE
         oFkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FAMT5MsfQCbX8RSCYEHlD4zDdhmee8GUTAni07GkLwY=;
        b=UjiV8ia3dYVIgvRIgDtWz6flXxt56t0cugsiGFgeyj1NIhZUAQeuPZCF+z4zNj62TR
         /tfMdOntmUeUUWWPj4CLMqQ3I+wlXpoZhIuNzGBbHQCl9shKg0/xuWhuUIGt22dRf9Sf
         hG39cqoeNB0+uk9rEzp7+tPv+UnLCwZ99I7jAkzqJIgbnggexsXaaFcCLxVS6zZyoR3J
         hCm1VntDo0MphU9qs/ulOXuASDf1MciEp0NdKOXUUZZdaIxK8jwIHjyE8DzFmIG/wWQ5
         33i4FjA7konApc/HPSUO2KaPJEEwwD0yuMNhWu+/DxahVJZeg0RhZ/Cxx31YGcPcOPPa
         zFow==
X-Gm-Message-State: APjAAAUJvAA4aX1EhBPxS6sw3qa8sn4B2ZlJcswaNceFWw1GcREl0/qU
        O9mrguUBICw6I+CTvsTi1Po=
X-Google-Smtp-Source: APXvYqwPYYs+rzMJr+HunbbVAZc0opJG3i2+mSsSHrZD3AjY4vJJTBu8iycja5JshRQhh5Toq+3P9A==
X-Received: by 2002:adf:fa0b:: with SMTP id m11mr15774256wrr.98.1575640101920;
        Fri, 06 Dec 2019 05:48:21 -0800 (PST)
Received: from [192.168.2.202] (pD9E5AB28.dip0.t-ipconnect.de. [217.229.171.40])
        by smtp.gmail.com with ESMTPSA id p9sm3567447wmg.45.2019.12.06.05.48.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Dec 2019 05:48:21 -0800 (PST)
Subject: Re: PROBLEM: Calling ObjectType on buffer field reports type integer
To:     "Kaneda, Erik" <erik.kaneda@intel.com>,
        "Moore, Robert" <robert.moore@intel.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>
Cc:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>
References: <3ef42aa1-196d-f3db-0e5d-2fd84c198242@gmail.com>
 <CF6A88132359CE47947DB4C6E1709ED53C5942CA@ORSMSX122.amr.corp.intel.com>
 <51e156ec-c2ed-84be-13c0-99a213e1d4b7@gmail.com>
 <CF6A88132359CE47947DB4C6E1709ED53C595C50@ORSMSX122.amr.corp.intel.com>
 <88077d9c-b2b7-5fc6-37e9-fa12d6aebe73@gmail.com>
 <CF6A88132359CE47947DB4C6E1709ED53C614AA8@ORSMSX122.amr.corp.intel.com>
 <c6511010-f160-a2ee-1b89-46df051a85e4@gmail.com>
 <94F2FBAB4432B54E8AACC7DFDE6C92E3B96B196C@ORSMSX110.amr.corp.intel.com>
 <94F2FBAB4432B54E8AACC7DFDE6C92E3B96B1A77@ORSMSX110.amr.corp.intel.com>
 <CF6A88132359CE47947DB4C6E1709ED53C68481C@ORSMSX122.amr.corp.intel.com>
 <20f023a8-67f2-71dd-266d-700012c05b39@gmail.com>
 <CF6A88132359CE47947DB4C6E1709ED53C688D60@ORSMSX122.amr.corp.intel.com>
 <DM6PR11MB3612787F2B1143C658168A26F0420@DM6PR11MB3612.namprd11.prod.outlook.com>
 <6fc2767d-4f48-dc7f-1bc1-6d0a2014b8f4@gmail.com>
 <DM6PR11MB3612BE55D4E70040DEB102DCF05C0@DM6PR11MB3612.namprd11.prod.outlook.com>
From:   Maximilian Luz <luzmaximilian@gmail.com>
Message-ID: <eee7a218-8def-df83-36d0-b4799050e10f@gmail.com>
Date:   Fri, 6 Dec 2019 14:48:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <DM6PR11MB3612BE55D4E70040DEB102DCF05C0@DM6PR11MB3612.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 12/6/19 12:57 AM, Kaneda, Erik wrote:
> Your solution looks very similar to my patch.
> In AcpiDsInitBufferField, I would prefer to use a new field "is_create_field" or something like that. AML_FIELD_ACCESS_BUFFER
> does get used in other parts of ACPICA so let's create and use a new field in the object union.
> 
> Go ahead and re-submit the patch with the above changes. I'll edit your explanation with more details and include this in
> the next ACPICA release. It'll land in linux after the release.

Thank you!

I've re-submitted the patch with the requested changes and included your
comments.

Regards,
Maximilian
