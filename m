Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B9E4732923
	for <lists+linux-acpi@lfdr.de>; Fri, 16 Jun 2023 09:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245465AbjFPHpz (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 16 Jun 2023 03:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245342AbjFPHpr (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 16 Jun 2023 03:45:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF0142947
        for <linux-acpi@vger.kernel.org>; Fri, 16 Jun 2023 00:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686901501;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wHh80tHevfpfGpsYLMJr0xWQFhLc1pRS6PbFj4Uk1xM=;
        b=hSlF18pZx70udS9rSRLrnBWkDg3YUU8L5mUR3Q8ODr78q7mMfloGaBHNE5IhgA8MjjESvg
        TQ0pKSG0lQIA5CXKiKK+3+GWz7gD/dIVfk0IZrrUH4UUekMztzJ3KPCEDzFp9dVBDKXR1G
        seWMy6CfpU7Ltkoe7JlprgAYqS4eSa8=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-599-VOIu_VQbN0u-6Es4DbXO4g-1; Fri, 16 Jun 2023 03:44:54 -0400
X-MC-Unique: VOIu_VQbN0u-6Es4DbXO4g-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-4ec790b902bso302203e87.1
        for <linux-acpi@vger.kernel.org>; Fri, 16 Jun 2023 00:44:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686901493; x=1689493493;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :content-language:references:cc:to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wHh80tHevfpfGpsYLMJr0xWQFhLc1pRS6PbFj4Uk1xM=;
        b=EVjdqIbXayda+IhEb26Ud7nUiIIx845oy+7Oarw5SXrIHbxrVECYD4RD8VPAg4Y3+C
         ttBo31NhW1IH3y2ssoQOqD7AsMJWMCg1WOOI557s5n82V0FvflB1VCzLH8R+ZObei0XM
         0HDXuVFrTMWvSbSlTZFJlNMZKyw4p4IgZKJpUgYX0OKvezaSJblhDoXYlbKBPLNGJ31k
         zAE+SfwyhHqOLpGPlkgc4D5CpCSd+1pP0imWWSfagGGkCuh9EnGd+gwJF2BKKfWwgQIa
         xMKQdOeKPQ0QdSLar+Gb0beC66ZfcpNNcS2u2oqt9GTbsLTvezWU/Fty8YuUV/zanggv
         6GBg==
X-Gm-Message-State: AC+VfDywFx6Ic+9dZVxJjjT/XJ0P2ClVWLGuBtstQbYOSyBhSgqBeOlE
        lOQ3HLZWf8in1OytMAFa6/tgjqp4FEH4UVb76hZUXXKB42ZbewVKUYMzlVHCg+NpVoeUVyI74iV
        eeAxjbCgj2eE0phxorKY+Ww==
X-Received: by 2002:ac2:4d93:0:b0:4f8:4961:7610 with SMTP id g19-20020ac24d93000000b004f849617610mr755644lfe.43.1686901492815;
        Fri, 16 Jun 2023 00:44:52 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4V2KwN13A0iu+AAg7e0iRwh6yMnxJrHrSMfwNZ/+rksVbEc+zvz9ZHK23cYpe/zyiH2IoeHg==
X-Received: by 2002:ac2:4d93:0:b0:4f8:4961:7610 with SMTP id g19-20020ac24d93000000b004f849617610mr755629lfe.43.1686901492450;
        Fri, 16 Jun 2023 00:44:52 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:9800:59ba:1006:9052:fb40? (p200300cbc707980059ba10069052fb40.dip0.t-ipconnect.de. [2003:cb:c707:9800:59ba:1006:9052:fb40])
        by smtp.gmail.com with ESMTPSA id q3-20020adff503000000b002ca864b807csm22936582wro.0.2023.06.16.00.44.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jun 2023 00:44:52 -0700 (PDT)
Message-ID: <29c9b998-f453-59f2-5084-9b4482b489cf@redhat.com>
Date:   Fri, 16 Jun 2023 09:44:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
To:     Vishal Verma <vishal.l.verma@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, nvdimm@lists.linux.dev,
        linux-cxl@vger.kernel.org, Huang Ying <ying.huang@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
References: <20230613-vv-kmem_memmap-v1-0-f6de9c6af2c6@intel.com>
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH 0/3] mm: use memmap_on_memory semantics for dax/kmem
In-Reply-To: <20230613-vv-kmem_memmap-v1-0-f6de9c6af2c6@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 16.06.23 00:00, Vishal Verma wrote:
> The dax/kmem driver can potentially hot-add large amounts of memory
> originating from CXL memory expanders, or NVDIMMs, or other 'device
> memories'. There is a chance there isn't enough regular system memory
> available to fit ythe memmap for this new memory. It's therefore
> desirable, if all other conditions are met, for the kmem managed memory
> to place its memmap on the newly added memory itself.
> 
> Arrange for this by first allowing for a module parameter override for
> the mhp_supports_memmap_on_memory() test using a flag, adjusting the
> only other caller of this interface in dirvers/acpi/acpi_memoryhotplug.c,
> exporting the symbol so it can be called by kmem.c, and finally changing
> the kmem driver to add_memory() in chunks of memory_block_size_bytes().

1) Why is the override a requirement here? Just let the admin configure 
it then then add conditional support for kmem.

2) I recall that there are cases where we don't want the memmap to land 
on slow memory (which online_movable would achieve). Just imagine the 
slow PMEM case. So this might need another configuration knob on the 
kmem side.


I recall some discussions on doing that chunk handling internally (so 
kmem can just perform one add_memory() and we'd split that up internally).

-- 
Cheers,

David / dhildenb

