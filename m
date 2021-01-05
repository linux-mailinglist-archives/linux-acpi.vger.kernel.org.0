Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82BCF2EB50B
	for <lists+linux-acpi@lfdr.de>; Tue,  5 Jan 2021 22:52:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727481AbhAEVwJ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 5 Jan 2021 16:52:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725792AbhAEVwJ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 5 Jan 2021 16:52:09 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C384C061574
        for <linux-acpi@vger.kernel.org>; Tue,  5 Jan 2021 13:51:29 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id x16so2487054ejj.7
        for <linux-acpi@vger.kernel.org>; Tue, 05 Jan 2021 13:51:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=azp5R5sIE5akbR86AUgMTb7YlLtMSqlVoZhjPN7aS+Y=;
        b=cMncgAy6pqzxztVl5zeqBEgkiWWCLXEErKCEI6UQIaRXZcyG2cz9MQvSJrclBYIOxn
         2YPqPfCcc6iHayGMNjfpXQOmYSRuDcj/UGTDfYoaB71KOVEq+7uJ+qNGmbfq2RPd51lX
         aCz0Jm5SeMLydFqfwz50JnLiiSB6lnJQsmaexF+qcYDT/1ZAJlFQDeMFQlfTtIsiNVUG
         CvPGs26j1gRvSDfItMJ42fcL6bmPq+wLIYeSuzmXkilJ64+2VfPo0rt7DTRiPUUWo2Sw
         t9ck3g6Xbryu+fFBxzsgmWNQrsCJcBcPTPHYtKdyer81Oo3piddVUeL6GEzgnKSvUQ1P
         Fqaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=azp5R5sIE5akbR86AUgMTb7YlLtMSqlVoZhjPN7aS+Y=;
        b=NmlUMRHhKlJKj7C6xL8EzVv3kL2S5UXxSOnylkBQSwc7sXEpiB0LMFjiXCZA4dgFJk
         UvBe//becWzwDeGnwtQHf1+guVV+6GBKVb9a5vzrWPtIHU8An/myAboSdDpKvRa5py41
         UGXdN4w1vurq7tNkSWBL6xfQ8n2bZvNkbyvo8CEkuLaV3oH3WYmUiZTFJuwgb0GQuKjz
         g7jdxQHk6og+5ZosLdZa8EbL0ylppZezsw/aib6EBQz0RuQvte4AC0fcyAbUW8o6NYcy
         HZ8Q4IbMJJ/gx6ToLZ1wuDr7nnqxbmRT5an53Faef4yqmxbs/juXu2nmWuaQ3GNTxzhR
         4KcQ==
X-Gm-Message-State: AOAM533otwB0unJ3T+5C9t4VOQaJ/gqEyk/1xCwV9yZ5VmfoYSOWv7IF
        5UdSW+YFNkDcNzkyZTSd1J7m1iY54suyLQWbi1ScK+SX4ks=
X-Google-Smtp-Source: ABdhPJx8QYz7csacame+QxQgcDO5RpmJDEOdfNCEf8pC9F7z4ASIVRi3CHLdkUBGbdfW8UJt1nJ5RoEtMuMwUCIDiwg=
X-Received: by 2002:a17:906:a29a:: with SMTP id i26mr914983ejz.45.1609883487897;
 Tue, 05 Jan 2021 13:51:27 -0800 (PST)
MIME-Version: 1.0
References: <160988059854.2071197.11821323682102566548.stgit@dwillia2-desk3.amr.corp.intel.com>
 <3c31c3328f569f15f03de9eb8d1b6a9ae4862893.camel@intel.com>
In-Reply-To: <3c31c3328f569f15f03de9eb8d1b6a9ae4862893.camel@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 5 Jan 2021 13:51:16 -0800
Message-ID: <CAPcyv4jc3t8Vdes6Mu=HG=ro_Gg3nVck=_tWMPiOEPBm3M1qiw@mail.gmail.com>
Subject: Re: [PATCH] ACPI: NFIT: Fix flexible_array.cocci warnings
To:     "Verma, Vishal L" <vishal.l.verma@intel.com>
Cc:     "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "efremov@linux.com" <efremov@linux.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        lkp <lkp@intel.com>,
        "julia.lawall@inria.fr" <julia.lawall@inria.fr>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Jan 5, 2021 at 1:28 PM Verma, Vishal L <vishal.l.verma@intel.com> wrote:
>
> On Tue, 2021-01-05 at 13:03 -0800, Dan Williams wrote:
> > Julia and 0day report:
> >
> >     Zero-length and one-element arrays are deprecated, see
> >     Documentation/process/deprecated.rst
> >     Flexible-array members should be used instead.
> >
> > However, a straight conversion to flexible arrays yields:
> >
> >     drivers/acpi/nfit/core.c:2276:4: error: flexible array member in a struct with no named members
> >     drivers/acpi/nfit/core.c:2287:4: error: flexible array member in a struct with no named members
> >
> > Instead, just use plain arrays not embedded a flexible arrays.
>
> This reads a bit awkwardly, maybe:
>
>   "Just use plain arrays instead of embedded flexible arrays."

yeah, umm, I left that extra "a" in there as a test... you passed! :)

>
> Other than that, the patch looks looks good:
> Reviewed-by: Vishal Verma <vishal.l.verma@intel.com>

Thanks.
