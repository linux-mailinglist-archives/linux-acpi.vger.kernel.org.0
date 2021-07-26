Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 958C73D53BA
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Jul 2021 09:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232065AbhGZGfL (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 26 Jul 2021 02:35:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60141 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231785AbhGZGfL (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 26 Jul 2021 02:35:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627283740;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Jr/kMfXd7N5bZI/UQn9TvwHA89sVmHJDTUMbSHF8LRE=;
        b=XmI1Y9sm7oip0o1JxE5yuOa24ymaVrzR/FGHtOSjABEYss7o/+Z4mKMGT+0Xv5n465xP3l
        3YcSWIY8FJphu6aJefKZYD3AAtfK9AbsrUEwhwmUagJE/UBfgbjrlKBeVKOx+JsSxw7Fsb
        uX+HlrnL52jPCFygqraP4++q52zIcnE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-491-l12-i7nXNGGwkQNxOLwuww-1; Mon, 26 Jul 2021 03:15:39 -0400
X-MC-Unique: l12-i7nXNGGwkQNxOLwuww-1
Received: by mail-wr1-f72.google.com with SMTP id v18-20020adfe2920000b029013bbfb19640so4316394wri.17
        for <linux-acpi@vger.kernel.org>; Mon, 26 Jul 2021 00:15:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Jr/kMfXd7N5bZI/UQn9TvwHA89sVmHJDTUMbSHF8LRE=;
        b=I4ArmrosxyV+DEx0pjqTWxiesHNVtyd/jY6Ge85lQLC9VWXUeArKA7MSsXrF7jq6MQ
         VvIH83lIc9BEjT145J1dqVfJdsb4vFykTh77KPxd/gyKLdgz4rLdZgB6h+4+iQrfihfW
         lFoEshMQTdQPKeU72t+PIrcLBwfulKKDuWPUY981FcSP5SRP2m2LFyYgKCHy7C9yztli
         WSThaRsBHMl3fpqyZJK5kiEqkpU8h19vea3ZjnQahCGYWHZ8VLdn+jVhV8avBNzYkHik
         fjCs+Xiutp6sTSCUmkxU3ve7qGjtJpLwk/mCGn2l7W6MSRO9+POnxzgFJvDvcpydjJ2K
         XAMg==
X-Gm-Message-State: AOAM5334dYiM06PCcTDi16yBC8XymPIE+kxQREIOnOkP/IH5MUYSvzuF
        loNQr7VtJ0vlCsJ5Jzhs6ojXrXRp/WarHJ2HyFBD6DhiVCU4ODHiqNtZeji/s1KO8HBNj5QXqyB
        s03sprQphDq+svfyPV/UIVnBnLJHCIlftuAs006PF/6eqRGJcbHVhCSaEJo919yGnF4qPEg==
X-Received: by 2002:adf:f592:: with SMTP id f18mr17191538wro.179.1627283737857;
        Mon, 26 Jul 2021 00:15:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwa09nmyWHVmVAQphE1ddip761fZbYJ84EB5R4AJvFqDggQmhIVrwytnke9AYAcp72nUCMKuQ==
X-Received: by 2002:adf:f592:: with SMTP id f18mr17191488wro.179.1627283737550;
        Mon, 26 Jul 2021 00:15:37 -0700 (PDT)
Received: from [192.168.3.132] (p4ff23b33.dip0.t-ipconnect.de. [79.242.59.51])
        by smtp.gmail.com with ESMTPSA id l18sm12476411wme.29.2021.07.26.00.15.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jul 2021 00:15:37 -0700 (PDT)
Subject: Re: [PATCH v2 2/9] mm/memory_hotplug: introduce "auto-movable" online
 policy
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Marek Kedzierski <mkedzier@redhat.com>,
        Hui Zhu <teawater@gmail.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mike Rapoport <rppt@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        virtualization@lists.linux-foundation.org,
        linux-acpi@vger.kernel.org
References: <20210723125210.29987-1-david@redhat.com>
 <20210723125210.29987-3-david@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <cd67a188-6d87-2d99-cfb8-2c4964e6087e@redhat.com>
Date:   Mon, 26 Jul 2021 09:15:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210723125210.29987-3-david@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

>   
> +struct auto_movable_stats {
> +	unsigned long kernel_early_pages;
> +	unsigned long movable_pages;
> +};
> +
> +static void auto_movable_stats_account_zone(struct auto_movable_stats *stats,
> +					    struct zone *zone)
> +{
> +	if (zone_idx(zone) == ZONE_MOVABLE) {
> +		stats->movable_pages += zone->present_pages;
> +	} else {
> +		/*
> +		 * CMA pages (never on hotplugged memory) behave like
> +		 * ZONE_MOVABLE.
> +		 */
> +		stats->movable_pages += zone->cma_pages;
> +		stats->kernel_early_pages += zone->present_early_pages;
> +		stats->kernel_early_pages -= zone->cma_pages;
> +	}
> +}

The following on top to make it compile without CONFIG_CMA (thanks Randy):

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index bfdaa28eb86f..fa1a0afd32ba 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -741,13 +741,15 @@ static void auto_movable_stats_account_zone(struct auto_movable_stats *stats,
         if (zone_idx(zone) == ZONE_MOVABLE) {
                 stats->movable_pages += zone->present_pages;
         } else {
+               stats->kernel_early_pages += zone->present_early_pages;
+#ifdef CONFIG_CMA
                 /*
                  * CMA pages (never on hotplugged memory) behave like
                  * ZONE_MOVABLE.
                  */
                 stats->movable_pages += zone->cma_pages;
-               stats->kernel_early_pages += zone->present_early_pages;
                 stats->kernel_early_pages -= zone->cma_pages;
+#endif /* CONFIG_CMA */
         }
  }
  struct auto_movable_group_stats {



-- 
Thanks,

David / dhildenb

