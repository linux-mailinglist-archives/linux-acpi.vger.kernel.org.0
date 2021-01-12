Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F8752F2EC0
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Jan 2021 13:11:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727952AbhALMLw (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 12 Jan 2021 07:11:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:25578 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729397AbhALMLw (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 12 Jan 2021 07:11:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610453425;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NZcfuIkSfijuGWfxInzpq+l4A2mSAx/w0ty9n0COzTo=;
        b=Xo6pedTaB+7fGmpoIYRUnDSiVIMdTbsFhkVBWQ7eWTXDb5KgSmHH11OdWjVlFz++Et7El0
        DrsZ1V6x2zfhPueyePtyLew7MdUeDfRoSJztHPRKuTDtN4l73ru9OVp3/n1d/HkTcs7GOB
        r6iKOxBdlhSmt10/voTTcO0nRk8wkGc=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-268-9Rni5KZBOiiDJylLD8IgZg-1; Tue, 12 Jan 2021 07:10:24 -0500
X-MC-Unique: 9Rni5KZBOiiDJylLD8IgZg-1
Received: by mail-ej1-f71.google.com with SMTP id u25so927079ejf.3
        for <linux-acpi@vger.kernel.org>; Tue, 12 Jan 2021 04:10:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NZcfuIkSfijuGWfxInzpq+l4A2mSAx/w0ty9n0COzTo=;
        b=aCgosni3GkPOJXV3iuOvY8Czf2wGeUvKd3pPMuOSfK5kB5DBF7P2OCGsTfFHNPTxsV
         xfZGYGeeaSnE2cVoCImfspctoHfETP5FpfYnjmRhRDj2d9SBX0MkXPjR/RTkko+5uFSa
         yVqpK6YnC1qdG4NozyYxfvnUYyAqRinxUPFdY6+/qjAKOe5rPaOPTEQPykLz/9HZk+Nq
         8fCLCsZfF0EiwtIoGOi7hD7WpBIaxhkex1WEMmOWzecagDKEfF+oJ3O3Vbm6Z+DjX+X2
         GEVOhSjmsQEG1UZ+62K6TXGr+OfO8ZdXkG5Vaok6mNYwaJwbwRAopRP9M8Z7nMazWu3G
         tKDA==
X-Gm-Message-State: AOAM531PxdM/BeYofgjH0xo8lKe6mCQRH58WLPVEqwLOkIgJF8vHpWCN
        6V6AuXWHYvOYMCjs8vPkFKFDVc0qUXXuSNqRuJb0jdM4oTuIFg1oRnMiwEzXrDMhVxcCTtRxZgk
        dpYzFrZRT9xqUPy+uCjQ8hw==
X-Received: by 2002:a50:fc83:: with SMTP id f3mr3207131edq.219.1610453420965;
        Tue, 12 Jan 2021 04:10:20 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwVmcf5yD1UBcXS9zLqzd4HS+LUSsB107z2DJ9q1J1ELacsiWEgharWo+d9R554Z2iIUj5Fuw==
X-Received: by 2002:a50:fc83:: with SMTP id f3mr3207116edq.219.1610453420798;
        Tue, 12 Jan 2021 04:10:20 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-37a3-353b-be90-1238.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:37a3:353b:be90:1238])
        by smtp.gmail.com with ESMTPSA id v16sm1307446eds.64.2021.01.12.04.10.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jan 2021 04:10:20 -0800 (PST)
Subject: Re: [pm:bleeding-edge 20/29] drivers/acpi/platform_profile.c:67:33:
 error: passing 'const struct platform_profile_handler to parameter of type
 'struct platform_profile_handler discards qualifiers
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>,
        kernel test robot <lkp@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     kbuild-all@lists.01.org, clang-built-linux@googlegroups.com,
        linux-acpi@vger.kernel.org, devel@acpica.org,
        linux-pm@vger.kernel.org
References: <202101081623.CGkLO3Kx-lkp@intel.com>
 <5e7a4d87-52ef-e487-9cc2-8e7094beaa08@redhat.com>
 <106d7891-230f-18e1-1b0f-cb6a62cf0387@flygoat.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <01442a77-7d87-5a12-d7b8-4fe397a37464@redhat.com>
Date:   Tue, 12 Jan 2021 13:10:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <106d7891-230f-18e1-1b0f-cb6a62cf0387@flygoat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 1/12/21 1:07 PM, Jiaxun Yang wrote:
> 在 2021/1/12 下午6:42, Hans de Goede 写道:
>> Hi,
>>
>> On 1/8/21 9:52 AM, kernel test robot wrote:
> [...]
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> All errors (new ones prefixed by >>):
>>
> [...]
>>>     2 errors generated.
> 
> Oops, thanks for the reminder, I should exclude 0day CI from mail filter.
> It's wired that GCC didn't say anything about it.
> 
>> Ugh, so that means that the current version of the
>> "ACPI: platform-profile: Pass profile pointer to driver callbacks"
>> patch is no good. Since this is causing compile errors I assume
>> that it will be dropped from the bleeding-edge branch.
>> Is that right Rafael?
> 
> I'm not familiar with x86pdx and ACPI workflow.
> Should I resend the patch or send a fixup patch?

I believe a new version of the patch is best, then Rafael can
replace the broken patch. We want to avoid having a commit in
git history which does not compile in some cases, because that
creates problems when git bisecting.

Regards,

Hans

