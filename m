Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AAA418995F
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Aug 2019 11:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727235AbfHLJGX (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 12 Aug 2019 05:06:23 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:34268 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727233AbfHLJGX (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 12 Aug 2019 05:06:23 -0400
Received: by mail-ot1-f68.google.com with SMTP id n5so156286747otk.1
        for <linux-acpi@vger.kernel.org>; Mon, 12 Aug 2019 02:06:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x19ChHEK+QrPCdfn+G+WLWoNlUCMAyNSIQtu2ElbpEA=;
        b=NbS/ISphla+JEdzxSPk/R1XBRPgBEUy8iJz/Q5vd8i9bpKssHItO55tH3zd4Y1GHy3
         sp62jQ1ClUaVacvHMHZPtGYLPWX/8PulpjDV3U+l90HKegk6KncTFz627LE1lHJ0TZDP
         GsHe/79MFmTAV6qOeb9tRxiMp0cLBiMgIiMMAZYSPhOb5cOAOGa8TG3MUi/TY3qR/pc0
         MGpzZYSv1uZM/Kq7IJBXPPcfDcPDgAZTmlY9ZXN22CeS0pUFoU538czHXCARuMybtXxj
         zIKB8SRL7Lhf3jksbmNlZ/9Z/bFjs+bLHZBdswfbuxiVBnaHWUDiHVIzUdy7jQTH0JMs
         34JA==
X-Gm-Message-State: APjAAAWbwknbz0cLl+st6eQ7gJIP3o5QiOIBteTnFjK70DEVWrBhnZWg
        FVC4I++29WmTrPuJvOR5T68nnDHh1QXehn5aiLsLXg==
X-Google-Smtp-Source: APXvYqzTPadKV6Ij0+vOMMpDmj6fU7T+0JhiwrApaCxWOX83Y7pnLXk0S1OfrsJijSklWmlrPJix60RQ5g1xEIcm0Cg=
X-Received: by 2002:a9d:12d1:: with SMTP id g75mr2750867otg.189.1565600782477;
 Mon, 12 Aug 2019 02:06:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190808204007.30110-1-jeremy.linton@arm.com> <20190808204007.30110-2-jeremy.linton@arm.com>
 <20190808222518.5q4fhd2tvs4lb6aw@rric.localdomain>
In-Reply-To: <20190808222518.5q4fhd2tvs4lb6aw@rric.localdomain>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 12 Aug 2019 11:06:07 +0200
Message-ID: <CAJZ5v0imn0X=M38LJcwe76gfLafWGU+MgyGd=NuKAeDtNZ+1DQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] ACPI/PPTT: Add support for ACPI 6.3 thread flag
To:     Robert Richter <rrichter@marvell.com>
Cc:     Jeremy Linton <jeremy.linton@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "rric@kernel.org" <rric@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Aug 9, 2019 at 12:25 AM Robert Richter <rrichter@marvell.com> wrote:
>
> On 08.08.19 15:40:06, Jeremy Linton wrote:
> > ACPI 6.3 adds a flag to the CPU node to indicate whether
> > the given PE is a thread. Add a function to return that
> > information for a given linux logical CPU.
> >
> > Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> > Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
> > ---
> >  drivers/acpi/pptt.c  | 53 +++++++++++++++++++++++++++++++++++++++++++-
> >  include/linux/acpi.h |  5 +++++
> >  2 files changed, 57 insertions(+), 1 deletion(-)
>
> Reviewed-by: Robert Richter <rrichter@marvell.com>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

and please push it through ARM64 along with the second patch.
