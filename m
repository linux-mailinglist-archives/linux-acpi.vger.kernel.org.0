Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BCABF97BD
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Nov 2019 18:55:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbfKLRz3 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 12 Nov 2019 12:55:29 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:46966 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbfKLRz3 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 12 Nov 2019 12:55:29 -0500
Received: by mail-ot1-f66.google.com with SMTP id n23so15060354otr.13
        for <linux-acpi@vger.kernel.org>; Tue, 12 Nov 2019 09:55:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tCv2FQBw3uAaqPVc/dzQiuHcwn8UohPz3qZnrpSfyuQ=;
        b=C+ntd6G4tkppkODd3gwiKjTQhhK2l2MZf3wR6Ptp0PyuFytkzu6QfE584Sbbdf/D3C
         yEeUylkvPlmS2sqFDsYOJ6hojpwGhB/SwDLTgTptnW6SPofVq6cI8TYWq0TFz3/Gf5KZ
         Dmh4JNcd33JvDQL7r5MsR4qfWI/O+roq5EeK93V+zBhhxZhgcoBPokBVtbsie8dhqURP
         6rgFDIsdc0JuIGcv+vBuYng3/8q75nmwIVr85qIvJArIFkCh6iZzr+70xHsWDLyqlg/e
         KsvIrL37fUeH9X3hcGFQcN7V8aimc7HVOeNG6PF5EqdnJg3zvHFXVqOgQdJIaPrr6Ptl
         Up3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tCv2FQBw3uAaqPVc/dzQiuHcwn8UohPz3qZnrpSfyuQ=;
        b=h6GHoAtzl0Qi7M0NWJ8VhfhhOYbcK1e+eRAM3YHt+WG8VGTWiEPEMdel/Z8CicWbiI
         OREoOg+BAI8GZfGVVKBe0V/kvPLOTsj8BHHeauJUSrHfUuS6eN/GuS1oySB5kna89W4M
         zfb+heArazNu+c+8jUHhXDSC74IjMTL04DZWMDi3GZDZuR+fbHqTaXDAO5bHRk+0m8vP
         x3LMRPWeLcDrjxzba6EenfqX/FbLukSbJ68+rtvIkiVtxxhghGesktO4DGXnhI5WHX+G
         JWCRuK4jq9v9wZx/HDcPhdW618CVYpeW6ijLWZmE7ENoZQ35Ib/UVwkEDSnTFdVWJvIU
         X2ZA==
X-Gm-Message-State: APjAAAVpLi0RYTFF86wEJd+oB/vC9CpBkO9a3LrQRH2SR4Ze2KJSYZ8T
        CdNf850RmwLiL25lCaifeV1yEye4OxTHytzTWImL/g==
X-Google-Smtp-Source: APXvYqzejJzlhvFyHrEWCARW40GL40VL1ngc5hPC/CkFTIvPmZvq8BBGIVD/77UhBUvFLaBGC0UJsY82ebD4LRLlsDI=
X-Received: by 2002:a05:6830:1b70:: with SMTP id d16mr13052039ote.71.1573581328478;
 Tue, 12 Nov 2019 09:55:28 -0800 (PST)
MIME-Version: 1.0
References: <20191004114330.104746-1-Jonathan.Cameron@huawei.com> <20191004114330.104746-2-Jonathan.Cameron@huawei.com>
In-Reply-To: <20191004114330.104746-2-Jonathan.Cameron@huawei.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 12 Nov 2019 09:55:17 -0800
Message-ID: <CAPcyv4jZG-5s6NsS-_-oNG45y0Qb1mVD_s8cCGqLYtzvHqEo+Q@mail.gmail.com>
Subject: Re: [PATCH V5 1/4] ACPI: Support Generic Initiator only domains
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Linux MM <linux-mm@kvack.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        X86 ML <x86@kernel.org>, Keith Busch <keith.busch@intel.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Linuxarm <linuxarm@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tao Xu <tao3.xu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

[ add Tao Xu ]

On Fri, Oct 4, 2019 at 4:45 AM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> Generic Initiators are a new ACPI concept that allows for the
> description of proximity domains that contain a device which
> performs memory access (such as a network card) but neither
> host CPU nor Memory.
>
> This patch has the parsing code and provides the infrastructure
> for an architecture to associate these new domains with their
> nearest memory processing node.

Thanks for this Jonathan. May I ask how this was tested? Tao has been
working on qemu support for HMAT [1]. I have not checked if it already
supports generic initiator entries, but it would be helpful to include
an example of how the kernel sees these configurations in practice.

[1]: http://patchwork.ozlabs.org/cover/1096737/
