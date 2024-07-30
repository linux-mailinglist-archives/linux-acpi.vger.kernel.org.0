Return-Path: <linux-acpi+bounces-7160-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C517942712
	for <lists+linux-acpi@lfdr.de>; Wed, 31 Jul 2024 08:39:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD9711C21421
	for <lists+linux-acpi@lfdr.de>; Wed, 31 Jul 2024 06:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45C6216DC07;
	Wed, 31 Jul 2024 06:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="dVA1f7z6"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707AB16D30E
	for <linux-acpi@vger.kernel.org>; Wed, 31 Jul 2024 06:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722407917; cv=none; b=sAMopAIWDZ+u6gxJg6XMc47tzmc3mowE/TjAVOPuaq1QpSZIAaulfCjiGzhauIIDMNVapG6HBc10nxDLacQ71aN913CfJc16l0ugXt3tFBbyqK23P1BZReRph745t67g+Xt5mX6EbpHOki/IRaihmDwBeKnuWjI8tgwJQDkqUL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722407917; c=relaxed/simple;
	bh=Zq30BI6ooS+3bTsboodCyEoyEOT0yb2rPqn2M0g/e6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g9LEVqU/JtS2Cq/b1/06ISlp21YjtjQx+hfI4de4g2Wq+8SZsarkWePqwokGUXcQQBaF/F8QMN1NGQK0R/2dSQ54c4lmwqP5CbypPZwuNjuszx8anXOqaG8Z9q5kYJkYF3gXE1Oi14RJbmYrnq2VemWOMV6mQ3z3u6Es5pYMBmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=dVA1f7z6; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7a1e31bbec1so271746885a.1
        for <linux-acpi@vger.kernel.org>; Tue, 30 Jul 2024 23:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1722407914; x=1723012714; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iah49N2YpJoLvB1OkYWrt6kJLlPNBil8tRCIq4onM8c=;
        b=dVA1f7z6EpZvVR7+YYTNkyxSoKSanXaSWLEIDjEhEaiJT1RQ0AFB6cMJ2HSC31Dxc4
         qR8fmVcdjinu3lE7vxMWClMOFpHeqowkGjHUfsCxYGtkBdZWaryv2n8HFaVwvvDcbIqd
         1AArdZQuXHVjS+JDrw1iPAbLj3aaMzeBfU8mB6oi6mctGPUtgO51j/7mqpl3U+GId3LM
         b1aMvOvvoz5QyXDia1CETD2qx0wI/C+T8HnucVZCELbyWQ/xnqamOkPnMRK6i3An4SHN
         ESWE+lvcda40q313oGBc4TQf7v0uvWdt2vQHGeT7TObZ0yPCtNnNhayjxseNMlZ7nYgC
         A9vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722407914; x=1723012714;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iah49N2YpJoLvB1OkYWrt6kJLlPNBil8tRCIq4onM8c=;
        b=RCQRYIf9PgEmheecPE1DleaFK4CeBK8yeT1ROffM/sTUUekDtFKbNUG1JDjFAtzJrl
         hGuhcQuV78kkO+Zss9lckMrLaM3zpawXxfLS85IlmeCjz8LUT6Ws3GwLOMjz/J6jL4kM
         YgiiNMfWnFkTK3AkCvaGmwqMLxsUoN6uYDNAvCXdnDnmt0r7eBH0aSufuZGbnKsmVRkR
         E9isfb3EPedduoTdF+tTrYA7DloVracAzfVaJQQmhJb6Y65028ZmbcX0NDlhua/i9jrx
         s1kDJUl2abCnxwZ29B1cR6eBbxub1nRESJcYWl+2rqvjfJaa3F/ss2XMMs4MAabeDpxJ
         xHQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUuSW2XJFzknQ/GQglXUqtzaMPwVT/URyQxTfkSgGBXvsbyhyCzpnZiiKQvFmsughmo+0QPtu0zcP+lj6ZUcjgh+FpUBgVxaLozFg==
X-Gm-Message-State: AOJu0YxadDAElGpB9r0t07MlBzUCMhIvHGbm4e3Lkc720A+9suI/bGoT
	yDUAFZpDdcw9MVxc15RFCyotgAlWOkqFLhpSv2Pc4Fdea9y6wqZMnNyrsLTXEZg=
X-Google-Smtp-Source: AGHT+IFIqBKAGa+6ov0v12YBmIbiEzdWKjZhz5dVIHwK9CTB6/yjtbXp/O+lkF8ZkzynVFyaT3LoKg==
X-Received: by 2002:a05:620a:400f:b0:79f:329:6790 with SMTP id af79cd13be357-7a1e52f6aa3mr1659029185a.66.1722407914197;
        Tue, 30 Jul 2024 23:38:34 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a1d7395188sm713919985a.3.2024.07.30.23.38.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 23:38:33 -0700 (PDT)
Date: Tue, 30 Jul 2024 15:58:10 -0400
From: Gregory Price <gourry@gourry.net>
To: "Huang, Ying" <ying.huang@intel.com>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, dave.jiang@intel.com,
	Jonathan.Cameron@huawei.com, horenchuang@bytedance.com,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	dan.j.williams@intel.com, lenb@kernel.org,
	"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: Re: [PATCH] acpi/hmat,mm/memtier: always register hmat adist
 calculation callback
Message-ID: <ZqlF0hn6Jh4Ybl-p@PC2K9PVX.TheFacebook.com>
References: <20240726215548.10653-1-gourry@gourry.net>
 <87ttg91046.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <ZqelvPwM2MIG26wY@PC2K9PVX.TheFacebook.com>
 <877cd3u1go.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <ZqhbePA9Egcxyx7o@PC2K9PVX.TheFacebook.com>
 <87cymupd7r.fsf@yhuang6-desk2.ccr.corp.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87cymupd7r.fsf@yhuang6-desk2.ccr.corp.intel.com>

On Wed, Jul 31, 2024 at 09:22:32AM +0800, Huang, Ying wrote:
> Gregory Price <gourry@gourry.net> writes:
> 
> > This presumes driver configured devices, which is not always the case.
> >
> > kmem.c will set MEMTIER_DEFAULT_DAX_ADISTANCE
> >
> > but if BIOS/EFI has set up the node instead, you get the default of
> > MEMTIER_ADISTANCE_DRAM if HMAT is not present or otherwise not sane.
> 
> "efi_fake_mem=" kernel parameter can be used to add "EFI_MEMORY_SP" flag
> to the memory range, so that kmem.c can manage it.
> 

In this case, the system is configured explicitly so that kmem does not
manage it. In fact, some systems still cannot be managed with
EFI_MEMORY_SP due to hpa!=spa issues that the driver cannot manage.

> > Not everyone is going to have the ability to get a platform vendor to
> > fix a BIOS bug, and I've seen this in production.
> 
> So, some vendor build a machine with broken/missing HMAT/CDAT and wants
> users to use CXL memory devices in it?  Have the vendor tested whether
> CXL memory devices work?
>

As I mentioned, the broken aspect is being fixed, however there are
existing production hardware which do not have HMAT entries.

> > But the first step here would be creating two modes.  HMAT-is-sane and
> > CPU/Non-CPU seems reasonable to me but open to opinions.
> 
> IMHO, we should reduce user configurable knobs unless we can prove it
> is really necessary.
>

That's fair and valid.

But I think a feature that worked in 5.x should work in 6.x, and right
now the change in node placement breaks hardware that worked with 5.x
which happened to have broken or missing HMAT.

~Gregory

