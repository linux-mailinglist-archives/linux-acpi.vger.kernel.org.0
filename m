Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3FE33C9BF0
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Jul 2021 11:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbhGOJiP (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 15 Jul 2021 05:38:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236202AbhGOJiO (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 15 Jul 2021 05:38:14 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 336BEC061760
        for <linux-acpi@vger.kernel.org>; Thu, 15 Jul 2021 02:35:21 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id p22so4636739pfh.8
        for <linux-acpi@vger.kernel.org>; Thu, 15 Jul 2021 02:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QXkiqMT/glRYwyHPQoyx3aDo7nh/1KZKgmUiqtcAPDY=;
        b=MzDY4nkv0QsPl3RRx5bPYDTbkke6SLjvc2oe/RSnFjWPoG5T8dKKOpymsgn9qnMEo5
         sHqxBMigOcqDJef4hC+9JXoGQOaC8weUX9BDwb4LL9Bd7P0Krz13fdt/z7yzOy3r9d5S
         rG3d/tO8xgT4XztexfXgIp3IDYBeGN9W+twCbHxAaE97054zyI195LlstTaa9miNyIXM
         ZtVHwqJ28F/LP7I/1SsMcG0zjwTSwJpQ0xkHBDByyigddb4j1A3R2obUCxlnJQF5ykQN
         Ztp7XfV6waqivs0muPAXuxlF2/iTY49SqqzHdAHr2xrNm0uZ88d8P0soxXfEf0udttiW
         YxVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QXkiqMT/glRYwyHPQoyx3aDo7nh/1KZKgmUiqtcAPDY=;
        b=gQe3l7iowuyRlRKA8y2rIDCrV9DuBN5PKv2Xtugpcyo2xAJGc09mKDLESnIaXRGIKO
         yZcgt98d25eDFpEgIPZg1aHMGE+RvnvaMtZ0dm47OKRMjz0OMevQA2VrczJ0SCfFN1D8
         TfQGIxyFljBYfFV2d0aEzzzU5PBDbmQyHUyBEcevJehRr4YKp0IL1CT0NRviEei+DTQr
         +251lwnO1r4xOOuEPsmGZlEe5zNlocV9iflQ4GitFeizmUijswoe1zQpHMNO5CsQd93P
         Pr6MmJLbrA9lIPjsry7v3eZEKDHawdnBApEFgCB1IE/lXEfW9or3Ah53ltpiSViOJVwe
         svGQ==
X-Gm-Message-State: AOAM531WqLLV4cmQnNi0GduRpJpTOJvVgZ9FgMD52mmBLKTqgyGtvUJ6
        b3SGYXN3ajPJ7c2ex/sCHh6Ga2fMqU+WpXUtvGpS2w==
X-Google-Smtp-Source: ABdhPJy2uQJqyr3RFS9AkYE3fVuTqbnURkqwNQ1RLEW+9aA5TH6NCB5ZJZS9dFUK64ivUOQm56b4e/NNJvAz5zqRy3A=
X-Received: by 2002:a05:6a00:1508:b029:332:3aab:d842 with SMTP id
 q8-20020a056a001508b02903323aabd842mr3528446pfu.59.1626341720657; Thu, 15 Jul
 2021 02:35:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210712124052.26491-1-david@redhat.com> <20210712124052.26491-2-david@redhat.com>
In-Reply-To: <20210712124052.26491-2-david@redhat.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Thu, 15 Jul 2021 17:34:44 +0800
Message-ID: <CAMZfGtVtUZphhNiKEZ2Xj7gTbkG0YaV5oxPRy-Kiw+J_NO9=ag@mail.gmail.com>
Subject: Re: [PATCH v1 1/4] mm/memory_hotplug: use "unsigned long" for PFN in zone_for_pfn_range()
To:     David Hildenbrand <david@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
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
        Heiko Carstens <hca@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Catalin Marinas <catalin.marinas@arm.com>,
        virtualization@lists.linux-foundation.org,
        linux-acpi@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Anton Blanchard <anton@ozlabs.org>,
        Ard Biesheuvel <ardb@kernel.org>, Baoquan He <bhe@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Borislav Petkov <bp@alien8.de>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Dave Jiang <dave.jiang@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jia He <justin.he@arm.com>, Joe Perches <joe@perches.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Michel Lespinasse <michel@lespinasse.org>,
        Nathan Lynch <nathanl@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Paul Mackerras <paulus@samba.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Pierre Morel <pmorel@linux.ibm.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Rich Felker <dalias@libc.org>,
        Scott Cheloha <cheloha@linux.ibm.com>,
        Sergei Trofimovich <slyfox@gentoo.org>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Will Deacon <will@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Jul 12, 2021 at 8:42 PM David Hildenbrand <david@redhat.com> wrote:
>
> Checkpatch complained on a follow-up patch that we are using "unsigned"
> here, which defaults to "unsigned int" and checkpatch is correct.
>
> Use "unsigned long" instead, just as we do in other places when handling
> PFNs. This can bite us once we have physical addresses in the range of
> multiple TB.
>
> Fixes: e5e689302633 ("mm, memory_hotplug: display allowed zones in the preferred ordering")
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>
