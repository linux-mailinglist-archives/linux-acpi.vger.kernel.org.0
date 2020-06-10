Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACE931F5D6E
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Jun 2020 22:56:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726134AbgFJU46 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 10 Jun 2020 16:56:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbgFJU46 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 10 Jun 2020 16:56:58 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EE6EC03E96B
        for <linux-acpi@vger.kernel.org>; Wed, 10 Jun 2020 13:56:57 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id n24so4187861ejd.0
        for <linux-acpi@vger.kernel.org>; Wed, 10 Jun 2020 13:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wkhkcPvpAeE4x4kAO1HjblduVWOEiZ+eHHO4eca07FY=;
        b=IgN05Fh0uREALZZU/s8t66dRm0ApTxlnvcL6Nnx/SwIGy9zTKN1m9HDCNywJFvcZ2U
         1xEVjk51dwqTD6l0sgKb+Vtjqr4s6SbTFzUJ0kDAKBXdGB7diNzJzQphVdL+BPgjm0Ga
         CNO9Wx8KMuwTuBeK1fJ+X3/7/j11L4DzwfyzA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wkhkcPvpAeE4x4kAO1HjblduVWOEiZ+eHHO4eca07FY=;
        b=r6tN9risyyFKfocOUwcEOQkKk7yqkmorWEeq58MY9N2zzNVQkcxk0Pg/se4XpzlHmD
         QobXQJ/cYIwXlaQmfMUF/Z/xec0cop83z+qCaDarsJ8EpCUZvUGf7OIE+LX4Y2sF5isL
         6H3Bh2NX6ltgI8RYua3CimeVFqZ3m/twNrCBntbBt6U/9Xr86KslUjUcoN74xDbqttcF
         ntAvSkWvtwjCX01gfOhYYaxEXujc5pn38ySMRRsTz05H8AiuI7ZROrmMaY8QPCcGIS0U
         qw1BpImyjiFJM0Ca9l05jfMr5iiqGVlm6G6VVXdbe8sR8B54119VaKHybhoHeR4SWBx+
         y9oQ==
X-Gm-Message-State: AOAM533D0ybYaD6Usop7StiusP2FBumYR+VsObC9ohUsUyTr66fGxYDz
        4z2WD7PmSSj9hBlDG+S0UMtYzioenUM=
X-Google-Smtp-Source: ABdhPJy13xrY9TZl3mxhIwv+Ax089/CQ0yY2PEE9deIfL6ztXhj1VkXH21r07Na8WyNvXUXZPqJuLA==
X-Received: by 2002:a17:906:7247:: with SMTP id n7mr5249612ejk.105.1591822615463;
        Wed, 10 Jun 2020 13:56:55 -0700 (PDT)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id o20sm581572ejx.102.2020.06.10.13.56.55
        for <linux-acpi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jun 2020 13:56:55 -0700 (PDT)
Received: by mail-ed1-f50.google.com with SMTP id p18so2406375eds.7
        for <linux-acpi@vger.kernel.org>; Wed, 10 Jun 2020 13:56:55 -0700 (PDT)
X-Received: by 2002:a2e:b5d7:: with SMTP id g23mr2510079ljn.70.1591822118508;
 Wed, 10 Jun 2020 13:48:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200610004455-mutt-send-email-mst@kernel.org>
In-Reply-To: <20200610004455-mutt-send-email-mst@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 10 Jun 2020 13:48:22 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiyR6X=SkHXMM3BWcePBryF4pmBNYMFWAnz5CfZwAp_Wg@mail.gmail.com>
Message-ID: <CAHk-=wiyR6X=SkHXMM3BWcePBryF4pmBNYMFWAnz5CfZwAp_Wg@mail.gmail.com>
Subject: Re: [GIT PULL] virtio: features, fixes
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     KVM list <kvm@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        Netdev <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        anshuman.khandual@arm.com, anthony.yznaga@oracle.com,
        arei.gonglei@huawei.com, Qian Cai <cai@lca.pw>,
        clabbe@baylibre.com, Dan Williams <dan.j.williams@intel.com>,
        David Miller <davem@davemloft.net>,
        David Hildenbrand <david@redhat.com>, dyoung@redhat.com,
        Markus Elfring <elfring@users.sourceforge.net>,
        Alexander Potapenko <glider@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        guennadi.liakhovetski@linux.intel.com,
        Johannes Weiner <hannes@cmpxchg.org>,
        Herbert Xu <herbert@gondor.apana.org.au>, hulkci@huawei.com,
        imammedo@redhat.com, Jason Wang <jasowang@redhat.com>,
        Juergen Gross <jgross@suse.com>, kernelfans@gmail.com,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Len Brown <lenb@kernel.org>, lingshan.zhu@intel.com,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        kernel test robot <lkp@intel.com>, longpeng2@huawei.com,
        matej.genci@nutanix.com, Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@kernel.org>,
        Michal Hocko <mhocko@suse.com>, osalvador@suse.com,
        Oscar Salvador <osalvador@suse.de>,
        pankaj.gupta.linux@gmail.com, pasha.tatashin@soleen.com,
        Pasha Tatashin <pavel.tatashin@microsoft.com>,
        Rafael Wysocki <rafael@kernel.org>,
        Wei Yang <richard.weiyang@gmail.com>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Mike Rapoport <rppt@linux.ibm.com>,
        stable <stable@vger.kernel.org>, stefanha@redhat.com,
        teawaterz@linux.alibaba.com, Vlastimil Babka <vbabka@suse.cz>,
        zou_wei@huawei.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Jun 9, 2020 at 9:45 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
>   I also upgraded the machine I used to sign
> the tag (didn't change the key) - hope the signature is still ok. If not
> pls let me know!

All looks normal as far as I can tell,

                Linus
