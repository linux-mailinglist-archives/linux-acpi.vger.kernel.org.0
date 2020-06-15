Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6952C1F9FE0
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Jun 2020 21:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731282AbgFOTGZ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 15 Jun 2020 15:06:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731179AbgFOTGY (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 15 Jun 2020 15:06:24 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8085EC05BD43
        for <linux-acpi@vger.kernel.org>; Mon, 15 Jun 2020 12:06:24 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id e12so12338938eds.2
        for <linux-acpi@vger.kernel.org>; Mon, 15 Jun 2020 12:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=olEteVHhdq8yEDgr22qHHqiXrLTHF0iSZEQd5+cZ3i4=;
        b=HSNkMcTTIJYSJKd5fm1hFo5NcqHjRoxIw9VgW1AhFtGY9q9s3jG/lafai0QvhBZr08
         2Y4ZLVLUtytxhUfEPHb1eZmuRg8e9yZxh8SLuY2aN/KaQkJsB9yjK0JgsWhHJ7II1hOi
         MbzutdQ2EmUCxu4XGefggHJztuN9VKRrf2vkgbC6TXvw0w6wsNhlivnabF/nAfsh/YkD
         Yp3x3MpBVO9oeDsfB3ByuiFpM6BwvmmqayHySEmWh1mgxM3adyKmDPL7RWzKcQgR2Fny
         1KEucQJszZ9hZW4wIurej5IV62ilDBRBy9Y6DhsgZBPlnmLs5K7sd+enkrlBA9fq7Cel
         A7bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=olEteVHhdq8yEDgr22qHHqiXrLTHF0iSZEQd5+cZ3i4=;
        b=RDZvYU0252RAkSnoECcbX5LGZyQoHrXJn0ZDPN0Z6udeguwJRljxhqkoRNsUFvwmvd
         x7eniKRkJ8E/IXUAN3eMo8PQCNT2d+Z0HyMeFQs6jhNG3vx4iVhNSaQJbFHa3DAqqo1l
         MSXLv6NY8y5UEOYI+G/zPzHFNsBtO2BfiRMFJg4o8/GuiwkqHyGEDeez4PKI5GN8SZrp
         dm1w3Pxf+zxuDSubF4Y6aQAyaqtyJ4en2VmPlvgoakEYGAbewnf2AtvDf3ZLz5BE4g9v
         FzdQmct1U8i+DlePIY2kScqjTTike73ro1HWCnUZE3cAA1gxoeSaDJ+yVVjiw159Xiv2
         YJEw==
X-Gm-Message-State: AOAM533XmiEyabzYHOTKz21vN9VYiL0rTLb2X5IFZd2zXjmQZNzp2qMB
        tCXWzF6H0JodVm3WXrJNoRC2rIV7/lEXP3Mdb9WBeA==
X-Google-Smtp-Source: ABdhPJxzUL4eHu5m5GntRVMoggAuJPY06Z4cx3u9jUOhbsuFvVxxME5LmBO1gfqVV0ymEVBSdTRsALwmBpbSSrtyiis=
X-Received: by 2002:aa7:c944:: with SMTP id h4mr24735245edt.383.1592247983077;
 Mon, 15 Jun 2020 12:06:23 -0700 (PDT)
MIME-Version: 1.0
References: <158889473309.2292982.18007035454673387731.stgit@dwillia2-desk3.amr.corp.intel.com>
 <BYAPR11MB30963CB784B940A5CD58C4FAF0810@BYAPR11MB3096.namprd11.prod.outlook.com>
 <CAJZ5v0h0ax4N-Tk+MfAeAyJ_tDYPW5vseqUU49UShBKZ4+F6Bw@mail.gmail.com> <34641620.ChEHEh4gq6@kreacher>
In-Reply-To: <34641620.ChEHEh4gq6@kreacher>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 15 Jun 2020 12:06:11 -0700
Message-ID: <CAPcyv4iA+21rrwfZ9SdV903TiTo9sA7KfrKVQfLOO-612uanpQ@mail.gmail.com>
Subject: Re: [RFT][PATCH 2/3] ACPICA: Remove unused memory mappings on
 interpreter exit
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     "Kaneda, Erik" <erik.kaneda@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        James Morse <james.morse@arm.com>,
        Myron Stowe <myron.stowe@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "Moore, Robert" <robert.moore@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sat, Jun 13, 2020 at 12:29 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
[,,]
> > While I agree that this is still somewhat suboptimal, improving this
> > would require more changes in the OSL code.
>
> After writing the above I started to think about the extra changes needed
> to improve that and I realized that it would take making the OS layer
> support deferred memory unmapping, such that the unused mappings would be
> queued up for later removal and then released in one go at a suitable time.
>
> However, that would be sufficient to address the issue addressed by this
> series, because the deferred unmapping could be used in
> acpi_ev_system_memory_region_setup() right away and that would be a much
> simpler change than the one made in patch [1/3].
>
> So I went ahead and implemented this and the result is there in the
> acpica-osl branch in my tree, but it hasn't been built yet, so caveat
> emptor.  Anyway, please feel free to have a look at it still.

I'll have a look. However, I was just about to build a test kernel for
the original reporter of this problem with this patch set. Do you want
test feedback on that branch, or this set as is?
