Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F73711822F
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Dec 2019 09:27:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbfLJI12 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 10 Dec 2019 03:27:28 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:41087 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726248AbfLJI12 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 10 Dec 2019 03:27:28 -0500
Received: by mail-oi1-f193.google.com with SMTP id i1so9015244oie.8;
        Tue, 10 Dec 2019 00:27:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BX8/IGebb3UQLoc8g0MqAatjMar/ymE4GzyE+cDdTqE=;
        b=V3yISq+chPoAk5G46RySgKigPauyG4Zz+V0byCVxo1RhU//1uJ2/JJu7CL/Baip4wU
         5xyQa6vNU1S1wU5wEOclUxDJRiB851GAfTUbSKL0lECQpX1WXVMWpheLco6GXDGKt/cM
         cnconTPra/LmljSyup2Cork5J2xbMNdcd3HmfdBeQz+vBUEi3XDcm8PRO5kom5GGfjxP
         0o1cPvnjhqwpqnIzhb1E0Fbcr9VFbtk9grOvUUOF/fgqJJcxsAgMCAaOSbOmSCaaEsmL
         BckGfKHxWM25qoSTVFpcJVo5XTjDDLWBgiLvxB8yAyBkF614+hAanTMYG5D0ZsXXW3FG
         bcgg==
X-Gm-Message-State: APjAAAXIGn0On9hu1d2pymXxV7kc7ztoXCU1redqsLBIzkwjxzRrgbPA
        SdIAwuRVrbUOOQE3BwRwBFRBu5gZDkEW2sesk/Q=
X-Google-Smtp-Source: APXvYqzU6tITS3t6fgzrokkHjgpAwUMcdlINIIqsozcCzH9hIQNEy73SC8+zMkWieMWuUP5o5YSXVVolWYfcR+Toz94=
X-Received: by 2002:a05:6808:b38:: with SMTP id t24mr3038315oij.110.1575966447761;
 Tue, 10 Dec 2019 00:27:27 -0800 (PST)
MIME-Version: 1.0
References: <20191202070348.32148-1-tao3.xu@intel.com> <CAJZ5v0hqjR5EdrxcdkLUpxseFiizqNjtA3nYdDtZiSt85JiywQ@mail.gmail.com>
 <6dbcdaff-feae-68b9-006d-dd8aec032553@intel.com> <CAJZ5v0jYb7XQC7u0rmxF-XVMAsEoOfmD11-FYDvMrZuOuzgyiA@mail.gmail.com>
 <0e4219c3-943a-e416-e5eb-723bed8c9383@intel.com>
In-Reply-To: <0e4219c3-943a-e416-e5eb-723bed8c9383@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 10 Dec 2019 09:27:15 +0100
Message-ID: <CAJZ5v0h6_7AoYW5Syk=BUR656eW11A3GjA7uvmTA6ayByOaqBg@mail.gmail.com>
Subject: Re: [PATCH] ACPI/HMAT: Fix the parsing of Cache Associativity and
 Write Policy
To:     Tao Xu <tao3.xu@intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Dec 10, 2019 at 9:19 AM Tao Xu <tao3.xu@intel.com> wrote:
>
> On 12/10/2019 4:06 PM, Rafael J. Wysocki wrote:
> > On Tue, Dec 10, 2019 at 2:04 AM Tao Xu <tao3.xu@intel.com> wrote:
> >>
> >> On 12/9/2019 6:01 PM, Rafael J. Wysocki wrote:
> >>> On Mon, Dec 2, 2019 at 8:03 AM Tao Xu <tao3.xu@intel.com> wrote:
> >>>>
> >>>> In chapter 5.2.27.5, Table 5-147: Field "Cache Attributes" of
> >>>> ACPI 6.3 spec: 0 is "None", 1 is "Direct Mapped", 2 is "Complex Cache
> >>>> Indexing" for Cache Associativity; 0 is "None", 1 is "Write Back",
> >>>> 2 is "Write Through" for Write Policy.
> >>>
> >>> Well, I'm not sure what the connection between the above statement,
> >>> which is correct AFAICS, and the changes made by the patch is.
> >>>
> >>> Is that the *_OTHER symbol names are confusing or something deeper?
> >>>
> >>
> >> Because in include/acpi/actbl1.h:
> >>
> >> #define ACPI_HMAT_CA_NONE                     (0)
> >>
> >> ACPI_HMAT_CA_NONE is 0, but in include/linux/node.h:
> >>
> >>      enum cache_indexing {
> >>             NODE_CACHE_DIRECT_MAP,
> >>             NODE_CACHE_INDEXED,
> >>             NODE_CACHE_OTHER,
> >>      };
> >> NODE_CACHE_OTHER is 2, and for otner enum:
> >>
> >>            case ACPI_HMAT_CA_DIRECT_MAPPED:
> >>                    tcache->cache_attrs.indexing = NODE_CACHE_DIRECT_MAP;
> >>                    break;
> >>            case ACPI_HMAT_CA_COMPLEX_CACHE_INDEXING:
> >>                    tcache->cache_attrs.indexing = NODE_CACHE_INDEXED;
> >>                    break;
> >> in include/acpi/actbl1.h:
> >>
> >>    #define ACPI_HMAT_CA_DIRECT_MAPPED            (1)
> >>    #define ACPI_HMAT_CA_COMPLEX_CACHE_INDEXING   (2)
> >>
> >> but in include/linux/node.h:
> >>
> >> NODE_CACHE_DIRECT_MAP is 0, NODE_CACHE_INDEXED is 1. This is incorrect.
> >
> > Why is it incorrect?
>
> Sorry I paste the wrong pre-define.
>
> This is the incorrect line:
>
> case ACPI_HMAT_CA_DIRECT_MAPPED:
> tcache->cache_attrs.indexing = NODE_CACHE_DIRECT_MAP;
>
> ACPI_HMAT_CA_DIRECT_MAPPED is 1, NODE_CACHE_DIRECT_MAP is 0. That means
> if HMAT table input 1 for cache_attrs.indexing, kernel store 0 in
> cache_attrs.indexing. But in ACPI 6.3, 0 means "None". So for the whole
> switch codes:

This is a mapping between the ACPI-defined values and the generic ones
defined in the kernel.  There is not rule I know of by which they must
be the same numbers.  Or is there such a rule which I'm missing?

As long as cache_attrs.indexing is used consistently going forward,
the difference between the ACPI-defined numbers and its values
shouldn't matter, should it?

>
>          switch ((attrs & ACPI_HMAT_CACHE_ASSOCIATIVITY) >> 8) {
>          case ACPI_HMAT_CA_DIRECT_MAPPED(1):
>                  tcache->cache_attrs.indexing = NODE_CACHE_DIRECT_MAP(0);
>                  break;
>          case ACPI_HMAT_CA_COMPLEX_CACHE_INDEXING(2):
>                  tcache->cache_attrs.indexing = NODE_CACHE_INDEXED(1);
>                  break;
>          case ACPI_HMAT_CA_NONE(0):
>          default:
>                  tcache->cache_attrs.indexing = NODE_CACHE_OTHER(2);
>                  break;
>          }
