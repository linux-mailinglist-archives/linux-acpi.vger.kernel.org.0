Return-Path: <linux-acpi+bounces-8611-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7D79995257
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Oct 2024 16:49:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA4C3287F78
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Oct 2024 14:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 718101E00A3;
	Tue,  8 Oct 2024 14:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="ZGBtJDa7"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF221E0089
	for <linux-acpi@vger.kernel.org>; Tue,  8 Oct 2024 14:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728398960; cv=none; b=GIG3s9Ui1AuHcfWmwWxLNxVvRTIPTHbX6yiBEoKOo/V0qc11j3W1hcyl+c3gFgzf+eFyIMSu3UQS5+EtZYUqnSt3wpGUE/4oEQHO/xKj9DSgmn5li5+PBWeq91EYRnS/yiaVr5fahKF5QSkd8VV3f9cZb1wgv03d3L8c293C6XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728398960; c=relaxed/simple;
	bh=qfU8C3TAPpSJwHJTPIgiDIgrnm35EvTKgGk+6mYnWkg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CDEBCiRZda+qS7/f6SO769f9R5ITG9JU0cjieplujHFlbumztcmNGEo+aV0WEsArkqtgx6sNmo1Dd43q0sf3t0VLz+kcNuJkw27Sy8sB73BQLkeH7XUVuz6vO4HHKzRZuZMMTprBevNAqonr9LLGzGFLF3sfs+v3KRROBOgcwMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=ZGBtJDa7; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7a9ad8a7c63so566889185a.3
        for <linux-acpi@vger.kernel.org>; Tue, 08 Oct 2024 07:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1728398957; x=1729003757; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sJFDONM1BJH1/Fon/2cRmbbze18YgFQzcNOLNf5fQ30=;
        b=ZGBtJDa7FrRzccHTFFXNE4CH3iBtybCrBuglxHATE/ALaQQlUwyI90MikkDZLON4Zx
         7a9FfKKAjAlvKlOgtNsPcwwt6ZjgfDqGPterJa41mlMXtBdlIGGRd+6IdvT68CHA7rHD
         5p1XuBqUwE6FXTmMGkFtcQgbjN4O7Cv4AIfttJGI9DLKjYRfKWdvJ06CedCF+3a7XTog
         Az2y494vinaWXCAeueFSQeAzIhcyjPObCuXc5u4320WFZ7cFtbmTc64HPFYIVRxI89t1
         1HzmbQi9CqI08DzFFmQkqMGLBDC5QfOZ09sJ7h20KD0NzL7LbVpe96iFXemBFldrqjkM
         72cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728398957; x=1729003757;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sJFDONM1BJH1/Fon/2cRmbbze18YgFQzcNOLNf5fQ30=;
        b=l/bXGMEAROXji2anYRMUkkYNmzB/kOZSRDUMzr3kuFv6s8luCjGUN0s1h4omnPAMMm
         UE636TgqmOeg1hzwAWNvfs8R+mEaFGphpGOTNmWjn5kPqpKHmiCYbSo+TNqOpoZqu7o5
         KvbqrMz5tImTlMusiIf7utaWSvwlOUlscpebkUCgEp939TyOX1q06cHXGU/d9guGIILB
         hpTZnVoUQxwTCOGE/vD7sAXBxJYC42Vad/ygx+bzWleJMsgADLuYWb4cvPw81edIAQ2o
         yQLCO+0EXDrQNp6IQuduNVddpI2xioU+pY9mFM6l9c23tvGWPFCKOIz9QKQF2AKYTa2z
         p0aw==
X-Forwarded-Encrypted: i=1; AJvYcCUEwipgPXr6cdqdFiZuVTuSVlirbDqUUJRIFvIyQgF06hs0oUZzKiwwwLY/S9AdWc7MBDcVLh1tTLxG@vger.kernel.org
X-Gm-Message-State: AOJu0YzXG2uOuNcYlZf1wJrqepr3aTbs0qUOlPdtY0Ppdo1yzCd/WCXQ
	2/XAOUGglYNewvjf+vpP3DqymfOW0ZUBFxPMFAyet/qdGSsuOx+fbLI+Q3vINO8=
X-Google-Smtp-Source: AGHT+IG6OVFWCoKZv69Wir07hN1vPWvg1lLXioIZ8R9wjd/d9XMMbY+LszjT31b7d2ZMcixN54E+Nw==
X-Received: by 2002:a05:620a:1a96:b0:7a9:c0f3:3b71 with SMTP id af79cd13be357-7ae6f43756fmr2795433385a.19.1728398957353;
        Tue, 08 Oct 2024 07:49:17 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ae7562ca6esm355821885a.52.2024.10.08.07.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 07:49:16 -0700 (PDT)
Date: Tue, 8 Oct 2024 10:49:07 -0400
From: Gregory Price <gourry@gourry.net>
To: Ira Weiny <ira.weiny@intel.com>
Cc: linux-cxl@vger.kernel.org, x86@kernel.org, linux-mm@kvack.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
	david@redhat.com, osalvador@suse.de, gregkh@linuxfoundation.org,
	rafael@kernel.org, akpm@linux-foundation.org,
	dan.j.williams@intel.com, Jonathan.Cameron@huawei.com,
	alison.schofield@intel.com, rrichter@amd.com, terry.bowman@amd.com,
	lenb@kernel.org, dave.jiang@intel.com
Subject: Re: [PATCH 0/3] memory,acpi: resize memory blocks based on CFMW
 alignment
Message-ID: <ZwVGY1WzwEakdcCJ@PC2K9PVX.TheFacebook.com>
References: <20241008044355.4325-1-gourry@gourry.net>
 <670543eae94d9_125a7294bd@iweiny-mobl.notmuch>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <670543eae94d9_125a7294bd@iweiny-mobl.notmuch>

On Tue, Oct 08, 2024 at 09:38:35AM -0500, Ira Weiny wrote:
> Gregory Price wrote:
> > When physical address capacity is not aligned to the size of a memory
> > block managed size, the misaligned portion is not mapped - creating
> > an effective loss of capacity.
> > 
> > This appears to be a calculated decision based on the fact that most
> > regions would generally be aligned, and the loss of capacity would be
> > relatively limited. With CXL devices, this is no longer the case.
> > 
> > CXL exposes its memory for management through the ACPI CEDT (CXL Early
> > Detection Table) in a field called the CXL Fixed Memory Window.  Per
> > the CXL specification, this memory must be aligned to at least 256MB.
> > 
> > On X86, memory block capacity increases based on the overall capacity
> > of the machine - eventually reaching a maximum of 2GB per memory block.
> > When a CFMW aligns on 256MB, this causes a loss of at least 2GB of
> > capacity, and in some cases more.
> > 
> > It is also possible for multiple CFMW to be exposed for a single device.
> > This can happen if a reserved region intersects with the target memory
> > location of the memory device. This happens on AMD x86 platforms. 
> 
> I'm not clear why you mention reserved regions here.  IIUC CFMW's can
> overlap to describe different attributes which may be utilized based on
> the devices which are mapped within them.  For this reason, all CFMW's
> must be scanned to find the lowest common denominator even if the HPA
> range has already been evaluated.
> 
> Is that what you are trying to say?
>

On AMD systems, depending on the capacity, it is possible for a single
memory expander to be represented by multiple CFMW.

an example: There are two memory expanders w/ 256GB total capacity

[    0.000000] BIOS-e820: [mem 0x000000c050000000-0x000000fcffffffff] soft reserved
[    0.000000] BIOS-e820: [mem 0x000000fd00000000-0x000000ffffffffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000010000000000-0x000001034fffffff] soft reserved

[0A4h 0164   1]                Subtable Type : 01 [CXL Fixed Memory Window Structure]
[0A5h 0165   1]                     Reserved : 00
[0A6h 0166   2]                       Length : 0028
[0A8h 0168   4]                     Reserved : 00000000
[0ACh 0172   8]          Window base address : 000000C050000000
[0B4h 0180   8]                  Window size : 0000002000000000
[0BCh 0188   1]     Interleave Members (2^n) : 00
[0BDh 0189   1]        Interleave Arithmetic : 00
[0BEh 0190   2]                     Reserved : 0000
[0C0h 0192   4]                  Granularity : 00000000
[0C4h 0196   2]                 Restrictions : 0006
[0C6h 0198   2]                        QtgId : 0001
[0C8h 0200   4]                 First Target : 00000007

[0CCh 0204   1]                Subtable Type : 01 [CXL Fixed Memory Window Structure]
[0CDh 0205   1]                     Reserved : 00
[0CEh 0206   2]                       Length : 0028
[0D0h 0208   4]                     Reserved : 00000000
[0D4h 0212   8]          Window base address : 000000E050000000
[0DCh 0220   8]                  Window size : 0000001CB0000000
[0E4h 0228   1]     Interleave Members (2^n) : 00
[0E5h 0229   1]        Interleave Arithmetic : 00
[0E6h 0230   2]                     Reserved : 0000
[0E8h 0232   4]                  Granularity : 00000000
[0ECh 0236   2]                 Restrictions : 0006
[0EEh 0238   2]                        QtgId : 0002
[0F0h 0240   4]                 First Target : 00000006

[0F4h 0244   1]                Subtable Type : 01 [CXL Fixed Memory Window Structure]
[0F5h 0245   1]                     Reserved : 00
[0F6h 0246   2]                       Length : 0028
[0F8h 0248   4]                     Reserved : 00000000
[0FCh 0252   8]          Window base address : 0000010000000000
[104h 0260   8]                  Window size : 0000000350000000
[10Ch 0268   1]     Interleave Members (2^n) : 00
[10Dh 0269   1]        Interleave Arithmetic : 00
[10Eh 0270   2]                     Reserved : 0000
[110h 0272   4]                  Granularity : 00000000
[114h 0276   2]                 Restrictions : 0006
[116h 0278   2]                        QtgId : 0003
[118h 0280   4]                 First Target : 00000006

Note that there are two soft reserved regions, but 3 CFMWS.  This is
because the first device is contained entirely within the first region,
and the second device is split across the first and the second.

The reserved space at the top of the 1TB memory region is reserved by
the system for something else - similar I imagine to the PCI hole at the
top of 4GB.

The e820 entries are not aligned to 2GB - so you will lose capacity
right off the bat. Then on top of this, when you go to map the windows,
you're met with more bases and lengths not aligned to 2GB which results
in even futher loss of usable capacity.

> > 
> > This patch set detects the alignments of all CFMW in the ACPI CEDT,
> > and changes the memory block size downward to meet the largest common
> > denomenator of the supported memory regions.
> > 
> > To do this, we needed 3 changes:
> >     1) extern memory block management functions for the acpi driver
> >     2) modify x86 to update its cached block size value
> >     3) add code in acpi/numa/srat.c to do the alignment check
> > 
> > Presently this only affects x86, since this is the only architecture
> > that implements set_memory_block_size_order.
> > 
> > Presently this appears to only affect x86, and we only mitigated there
> > since it is the only arch to implement set_memory_block_size_order.
> 
> NIT : duplicate statement
> 
> Ira

