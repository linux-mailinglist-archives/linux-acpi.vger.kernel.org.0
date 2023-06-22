Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0D4C73A24E
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jun 2023 15:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbjFVN4i (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 22 Jun 2023 09:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231157AbjFVN4g (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 22 Jun 2023 09:56:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88B3D1FFE
        for <linux-acpi@vger.kernel.org>; Thu, 22 Jun 2023 06:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687442144;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p6G7WiAZOcQ9lIcGNb7i76CvK3NP16OpxiaWi+YzEms=;
        b=AQZgWWdMEnBTlrd7B7AcDbx5NvfPRHw33tvKh9nH5ZQPVpHA6VTIkC3e0GN1IgKFxPoyus
        9w0r0MXg1RTO2T1922AcH1A/F0PSg6n5qPAMmIi1BYIyejpD6txY3u2vkpWFPcE5FDpOa2
        BpLXR5GQkde6vfHsU12KmfAO3oxXhtY=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-311-kHFb8nFVNuCgYADIOpcEHg-1; Thu, 22 Jun 2023 09:55:43 -0400
X-MC-Unique: kHFb8nFVNuCgYADIOpcEHg-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-4edc7406cb5so5200208e87.3
        for <linux-acpi@vger.kernel.org>; Thu, 22 Jun 2023 06:55:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687442141; x=1690034141;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p6G7WiAZOcQ9lIcGNb7i76CvK3NP16OpxiaWi+YzEms=;
        b=hJY7L/Wzfs14MmB8zB9vs3kPg/LlFUOZ9hV7xNhH/tNQ8YoE2f6zvoqNcdPen4HEiD
         4hec5HhvDFbgyZANyI30ODJbuNsuZ9sNkaMdoUyUdzzQR3fEf9HvBSKQ4kzW3IXKXQjg
         R64xr0/XC6JSxdVX6P+TJCGt1LpY9YnQ8FXnl7VX9GN0nbovERYvh/6KBHLNkoFOENBR
         umed5qfibxqfgVKlkcmcvOtQkl+QcKCgTlzGVUDU2JIv8JYLpAzw8GlEO6Li+3oAvQL9
         oPJrF3jgyq6whQZ6hwuApjwlj45+nRZQbPxPo6UKy7pYpIz61zPXjK18J6qKbzFGRowV
         4giA==
X-Gm-Message-State: AC+VfDy619wsLNFEdhZAFphe5F3bZ6z6uhGA0oDUW9kAcRYf/2AN8Vaf
        XNSLyIhDwruQ0FeP0+GUdI090V9UnOZo4D2tsCGEuTvEg5aWt88ZXbiU/nf2a1Yu100fA6QaAsp
        U0iucIQvCMg5og33SIzFSZw==
X-Received: by 2002:a05:6512:2e7:b0:4f8:71ca:bb15 with SMTP id m7-20020a05651202e700b004f871cabb15mr9177804lfq.48.1687442141566;
        Thu, 22 Jun 2023 06:55:41 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4B3PJA6vAcVuODvAd1+uWbP6euZQ43Yz3zVopBeuZdQAZiCsBeOr4t+6/ZZr44BUky2qiISA==
X-Received: by 2002:a05:6512:2e7:b0:4f8:71ca:bb15 with SMTP id m7-20020a05651202e700b004f871cabb15mr9177762lfq.48.1687442140970;
        Thu, 22 Jun 2023 06:55:40 -0700 (PDT)
Received: from [192.168.3.108] (p4ff23922.dip0.t-ipconnect.de. [79.242.57.34])
        by smtp.gmail.com with ESMTPSA id z5-20020a1c4c05000000b003fa78d1055esm399654wmf.21.2023.06.22.06.55.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jun 2023 06:55:40 -0700 (PDT)
Message-ID: <39fe2152-c4fc-6b8e-90e8-1060234a1943@redhat.com>
Date:   Thu, 22 Jun 2023 15:55:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 0/3] mm: use memmap_on_memory semantics for dax/kmem
Content-Language: en-US
To:     "Verma, Vishal L" <vishal.l.verma@intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "osalvador@suse.de" <osalvador@suse.de>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Cc:     "Huang, Ying" <ying.huang@intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
References: <20230613-vv-kmem_memmap-v1-0-f6de9c6af2c6@intel.com>
 <29c9b998-f453-59f2-5084-9b4482b489cf@redhat.com>
 <b61a9efdff30fbff9477369ded05d133e0de7335.camel@intel.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <b61a9efdff30fbff9477369ded05d133e0de7335.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 21.06.23 21:32, Verma, Vishal L wrote:
> On Fri, 2023-06-16 at 09:44 +0200, David Hildenbrand wrote:
>> On 16.06.23 00:00, Vishal Verma wrote:
>>> The dax/kmem driver can potentially hot-add large amounts of memory
>>> originating from CXL memory expanders, or NVDIMMs, or other 'device
>>> memories'. There is a chance there isn't enough regular system memory
>>> available to fit ythe memmap for this new memory. It's therefore
>>> desirable, if all other conditions are met, for the kmem managed memory
>>> to place its memmap on the newly added memory itself.
>>>
>>> Arrange for this by first allowing for a module parameter override for
>>> the mhp_supports_memmap_on_memory() test using a flag, adjusting the
>>> only other caller of this interface in dirvers/acpi/acpi_memoryhotplug.c,
>>> exporting the symbol so it can be called by kmem.c, and finally changing
>>> the kmem driver to add_memory() in chunks of memory_block_size_bytes().
>>
>> 1) Why is the override a requirement here? Just let the admin configure
>> it then then add conditional support for kmem.
> 
> Configure it in the current way using the module parameter to
> memory_hotplug? The whole module param check feels a bit awkward,
> especially since memory_hotplug is builtin, the only way to supply the
> param is on the kernel command line as opposed to a modprobe config.

Yes, and that's nothing special. Runtime toggling is not implemented.

> 
> The goal with extending mhp_supports_memmap_on_memory() to check for
> support with or without consideration for the module param is that it
> makes it a bit more flexible for callers like kmem.

Not convinced yet that the global parameter should be bypassed TBH. And 
if so, this should be a separate patch on top that is completely 
optional for the remainder of the series.


In any case, there has to be some admin control over that, because

1) You usually don't want vmemmap on potentially slow memory
2) Using memmap-on-memory prohibits gigantic pages from forming on that 
memory (when runtime-allocating them).

So "just doing that" without any config knob is problematic.

-- 
Cheers,

David / dhildenb

