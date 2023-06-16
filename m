Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA17373292E
	for <lists+linux-acpi@lfdr.de>; Fri, 16 Jun 2023 09:47:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244624AbjFPHru (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 16 Jun 2023 03:47:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234069AbjFPHrt (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 16 Jun 2023 03:47:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 987D91FD5
        for <linux-acpi@vger.kernel.org>; Fri, 16 Jun 2023 00:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686901623;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U5bYwqNSLrXJiQtrIMo72MYJh3QZB8KMtEIiq6QD74Q=;
        b=O6rHtbnxDD7a3gBxnAwDVtF7MZUo9b4EmqW8FNX9H4mC3cpbLYXIl7RBfl3z4Cz4Rr+syS
        zqfR6Ma4kIYgbTggNbc9wqIZVPDANMSG3kDtzyYMb9DnIcXeqGqPQ9xGqAyzCnO0U2BXmk
        le906kEMUy2CywyEUT04E1xTWH2qT8E=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-151-AHgZd5hPPWmAwJCH61YFcw-1; Fri, 16 Jun 2023 03:47:02 -0400
X-MC-Unique: AHgZd5hPPWmAwJCH61YFcw-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-3f80e7e15b0so1808595e9.2
        for <linux-acpi@vger.kernel.org>; Fri, 16 Jun 2023 00:47:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686901621; x=1689493621;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U5bYwqNSLrXJiQtrIMo72MYJh3QZB8KMtEIiq6QD74Q=;
        b=URmpAp+TPR6X9FodZjT8/AIFEwzdjRrAVoCFqAnZHlnh2wQVGuqklOz3rEvBZwroRr
         7RYslbqtRFlHdYGX48IXQ1rgHiE0r0OslEizCRgPlAOvRIxJ8VwZFA4PGYc8i+8ehFzS
         Ht1Gz207VeusvnAymlSVlPSvcyfEZw8JBEUgW1g3U8/urO01p4NfLKF57zN58pM5JwQ7
         TWDY1xq6ND2UzZnb6I2r9aSWKyXfkVPxR+6CXaSht/Yt7tQOwf2SA6tp89jJ9QGDdn6Q
         grV5AS9drURaqp5XNMoL03hTYHE80iscJoWaVjq4/GBaSA5afurxhpb/OSBaLaMTQkfP
         iaBg==
X-Gm-Message-State: AC+VfDygUpm4f+wZGtB0lS7nW0Gl5wWtRPkbumBBzQOZX7GI5unpXLf9
        HieqB+/M5qk0kNxyJ/e7/eQ//fPfxCFOVVcDzdxDam7r25r+ZEtlgrnKlBSu9eOUrqL/eIj3v+v
        Sr6kTZlgAHhwaEfpArdU18g==
X-Received: by 2002:a7b:cd98:0:b0:3f6:766:f76f with SMTP id y24-20020a7bcd98000000b003f60766f76fmr925951wmj.36.1686901621071;
        Fri, 16 Jun 2023 00:47:01 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6FjFAGg0EAY/fN2yFOMKdsON/pGAcgKV47j+V2XrsGwOYGSddhs9zmuejwHx2MuQTEuN5LJg==
X-Received: by 2002:a7b:cd98:0:b0:3f6:766:f76f with SMTP id y24-20020a7bcd98000000b003f60766f76fmr925931wmj.36.1686901620728;
        Fri, 16 Jun 2023 00:47:00 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:9800:59ba:1006:9052:fb40? (p200300cbc707980059ba10069052fb40.dip0.t-ipconnect.de. [2003:cb:c707:9800:59ba:1006:9052:fb40])
        by smtp.gmail.com with ESMTPSA id d22-20020a1c7316000000b003f80946116dsm1356132wmb.45.2023.06.16.00.46.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jun 2023 00:47:00 -0700 (PDT)
Message-ID: <0ea4728a-8601-bf75-1921-bcde0818aac3@redhat.com>
Date:   Fri, 16 Jun 2023 09:46:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/3] mm/memory_hotplug: Allow an override for the
 memmap_on_memory param
Content-Language: en-US
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
 <20230613-vv-kmem_memmap-v1-1-f6de9c6af2c6@intel.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230613-vv-kmem_memmap-v1-1-f6de9c6af2c6@intel.com>
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
> For memory hotplug to consider MHP_MEMMAP_ON_MEMORY behavior, the
> 'memmap_on_memory' module parameter was a hard requirement.
> 
> In preparation for the dax/kmem driver to use memmap_on_memory
> semantics, arrange for the module parameter check to be bypassed via the
> appropriate mhp_flag.
> 
> Recall that the kmem driver could contribute huge amounts of hotplugged
> memory originating from special purposes devices such as CXL memory
> expanders. In some cases memmap_on_memory may be the /only/ way this new
> memory can be hotplugged. Hence it makes sense for kmem to have a way to
> force memmap_on_memory without depending on a module param, if all the
> other conditions for it are met.

Just let the admin configure it. After all, an admin is involved in 
configuring the dax/kmem device to begin with. If add_memory() fails you 
could give a useful hint to the admin.

-- 
Cheers,

David / dhildenb

