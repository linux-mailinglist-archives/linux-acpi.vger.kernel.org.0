Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F5982A0FD5
	for <lists+linux-acpi@lfdr.de>; Fri, 30 Oct 2020 22:00:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727708AbgJ3VAK (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 30 Oct 2020 17:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727682AbgJ3VAK (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 30 Oct 2020 17:00:10 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7384FC0613CF;
        Fri, 30 Oct 2020 14:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VBYLf1yxEA661qYfjQehRe3VGBolILtsBiiqsthiT1Q=; b=cbpB4pE4DRC3SGf0JrXxClkChN
        TE9K7bEggePKzuTFhoD213l0pUTvRdm6O1W9WO+KGdg9wiVo/YsInb1njtIfDEZirrOwbIWZegoNY
        TK1b7qUbr9LMD4iHlLoFmUIe4jNti6Uy/Y3RvWZ6uiRD5MqrwwGTw1GLyVGhMD84CD5dsIvZWwRSx
        j09LIobkjllTag4sbVjnLm8QLTg49K0Pdiqj09kMQSf5qno6rE7NinRDtGrgB/H1kHQw3ElZKUQj/
        8n+EPsM/cBN8sQPbm4epKaiV7z8cxSTQa1LCnSB4gaAhv6e+sGIVLV5m7OjBFGJeRnzhq5v+6Pyym
        h4iuCdKg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kYbV6-0006Y4-Au; Fri, 30 Oct 2020 20:59:56 +0000
Date:   Fri, 30 Oct 2020 20:59:56 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Vikram Sethi <vsethi@nvidia.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "Natu, Mahesh" <mahesh.natu@intel.com>,
        "Rudoff, Andy" <andy.rudoff@intel.com>,
        Jeff Smith <JSMITH@nvidia.com>,
        Mark Hairgrove <mhairgrove@nvidia.com>,
        "jglisse@redhat.com" <jglisse@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Linux MM <linux-mm@kvack.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Subject: Re: Onlining CXL Type2 device coherent memory
Message-ID: <20201030205956.GO27442@casper.infradead.org>
References: <BL0PR12MB25321C8689BAFDF8678E5C69BD170@BL0PR12MB2532.namprd12.prod.outlook.com>
 <CAPcyv4jWFf0=VoA2EiXPaQphA-5z9JFO8h0Agy0dO0w6nDyorw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4jWFf0=VoA2EiXPaQphA-5z9JFO8h0Agy0dO0w6nDyorw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Oct 30, 2020 at 01:37:18PM -0700, Dan Williams wrote:
> On Wed, Oct 28, 2020 at 4:06 PM Vikram Sethi <vsethi@nvidia.com> wrote:
> > CXL 
> > (HDM) CXL
> > CXL 
> > CXL.cache 
> >
> > BIOS/UEFI HDM EFI 
> > ACPI SRAT/SLIT/HMAT
> > EFI 
> > HDM 
> > HDM 
> 
> BIOS OS 
> CXL 
> BIOS 
> 
> > UEFI 
> > NUMA NUMA HDM,
> > (CDAT) NUMA 
> > HDM, NUMA NUMA
> > CDAT 
> > BIOS 
> 
> NUMA CDAT
> EFI ACPI
> SRAT/HMAT CDAT BIOS 
> OS 
> 
> > NUMA HDM CXL 
> > CDAT, NUMA 
> > BIOS PXM 
> > SRAT 
> 
> CDAT ACPI 
> CDAT 
> NUMA ACPI SRAT
> ACPI NUMA 
> CDAT NUMA BIOS 
> SRAT/HMAT. 
> CXL EFI / ACPI 

i don't know what you're talking about but you must both work for
hardware manufacturers!
