Return-Path: <linux-acpi+bounces-18474-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19813C2DA80
	for <lists+linux-acpi@lfdr.de>; Mon, 03 Nov 2025 19:22:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78EBF18859E9
	for <lists+linux-acpi@lfdr.de>; Mon,  3 Nov 2025 18:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17C1E289378;
	Mon,  3 Nov 2025 18:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="UZWNhCHI"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com [209.85.218.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437A02877F2
	for <linux-acpi@vger.kernel.org>; Mon,  3 Nov 2025 18:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762194136; cv=none; b=pkN8s3Ic6Gp9zOP4/1UInngcRudwVigSFUqiYKuVaiHJd2sAXCIvgyv27JTqDobAjOHE5CEqWet/Pkg4Bzl1BWqmqb4cCZBwAfX0A4Vxu8ehvfSvoQLPO4/g8ytyCfdYb0pS4+cJ5EixDUJfFfEBRAZrrNmTJF7rnV1eWUcVHOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762194136; c=relaxed/simple;
	bh=hBQwSFa3ls5tXGp6taWMTxAYUVgv5w1YYI79QHPzWyU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gEw+CbckVNiQMcXHv5DnPX+rZK9K+IXaKg2Be18mW6PA8+a0UdDMGGmhXPUAh86ijLUX1XxPk/sW8CvS1MRuhJS3XB7jtuYM/vHg+nbMfIfyz0A6caHPMLPAUAF0lMq5v5TtrBFBefChwjkcQ2Ru8/FLI72sJtWJrYJOLtn6m+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=UZWNhCHI; arc=none smtp.client-ip=209.85.218.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f65.google.com with SMTP id a640c23a62f3a-b3c2c748bc8so603748366b.2
        for <linux-acpi@vger.kernel.org>; Mon, 03 Nov 2025 10:22:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762194131; x=1762798931; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CADywisMv8oKHI4QSeR7YMm7LIR82MPNXUUykN5HtdQ=;
        b=UZWNhCHIJ/gRUyJkjqO9j2Ouw+9KMUIDZ7RU1g+gHLh7t9ogJKmadqG2ksz/6SINjv
         NfNNhN+pg/v8FKFb9RbHvyuzJPbyAiXVFI4O0+TAhq/KXKCBgiJyGv9an0kzjQSniWau
         E3WHw0WSAW2tXTpBj/AJZvw6yfz+NzBATlDmnzGfjJKVCOzGVEIOou/z18OiLGFGGl8k
         aQ79bvM4SvC3OZRtevh+OyGQhsEmpGLz9PEzkgYj+AsHo+xlob/xqJEgJLtfV+fqdQDd
         KRhbYW5RGsCFTIUGYex0VX9KBfqdojf8FLouOmHwynrrCWqUm5pwQ/w8ltayR/Q+61vf
         hP5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762194131; x=1762798931;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CADywisMv8oKHI4QSeR7YMm7LIR82MPNXUUykN5HtdQ=;
        b=O46YiPG4bZ6Xp/iVhuM5+aWMbINEkUi3YYfegwJYNY2mYEMOgiWU2YMlni2ao0DciI
         GbbUwLaDUdSMzMuAS9467ZbiN/dIqOEeuM3S6LCwgYWY0KwgGTCH+xj6/YtUqh6RhQJH
         YIN7sfgLOrsO1pMoodzUlwAyHMfhz+BfStSU22bUSmeqAfz6RlcUWbDivR9CrSkWbeSv
         EOS02BRbd4mDmlUgWBJrKQo0e/RwbqI7nHZpC3y8gv/UBR5TxWziP0PwxRND4QNLbI6O
         sft/zHLvIiynTMWHK2Q2EWDVaTRohsC5QHfN/WEI7TI+g1fJOohRgURwh4Z5sjxT0qIO
         WeUA==
X-Forwarded-Encrypted: i=1; AJvYcCWrUgvCMLsVZB74pYnTFPGETc93pS2jrBK0ored7sX+vbJ9Wm29V6hnjlXjM0W0ndn+d2agLF8kmHyM@vger.kernel.org
X-Gm-Message-State: AOJu0YxilekrvKIHW+8OItZgnV1bH2kVGvnzDU72KlGDv64rH1kqzhbz
	rtsfHJz3g9ERm5p9iwgxnBmsbo6YcW9nhX/66KnanaGHyszpIwatYVHdj+377d9R8kk=
X-Gm-Gg: ASbGncvcI8OaH8dMUq4TM0aep8co++cRJWRSFBjqmdmx39Gf6u9j9In1+QrOyZ2rT5d
	MlylOyKfSBCMjujircV0FruuGL2zQD0pOeEodTAvyfRuDK7hXSlOavPr8JsF8deyFCXH+QmMkof
	IYQDh8glErqnSMdlHQm1lp6f/xY+cpxu9cUwKIjFVGI5HImCmZ3WVZC1Lki9WuYZjqSrmRZzpww
	HRZjKN/29ymdN/LyYDZ74fFtxPx1aagpTR7MViEWZxOr19P3x37hNRO+lHIfV30kpY5rKOhJXP+
	1A7vwg/f9l4qbEQQW6+P4cVqwDwdONexFqq4ykMXY6zdqQRYZ2Ltw9kQ00ioz9GWdFObKJ7KyDT
	HnKy+XG+gQWnZ0UDWOq/QYeArtcQdmZm43umk6hqG/lQRNXYHgG2vKalj452DD0g2ljIIQbZldg
	mwiFXngcF/nzcbUg==
X-Google-Smtp-Source: AGHT+IHNFHN7nALHAQI3py5s3oB3pNSaTHU60CtQtHtaXj2ajzjyABGHYsA7JkTUyfWfWQz+8Ib3/g==
X-Received: by 2002:a17:907:944d:b0:b70:b7c2:abe9 with SMTP id a640c23a62f3a-b70b7c2af64mr561377766b.38.1762194131429;
        Mon, 03 Nov 2025 10:22:11 -0800 (PST)
Received: from localhost (109-81-31-109.rct.o2.cz. [109.81.31.109])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b70bedcec19sm413921266b.7.2025.11.03.10.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 10:22:10 -0800 (PST)
Date: Mon, 3 Nov 2025 19:22:09 +0100
From: Michal Hocko <mhocko@suse.com>
To: Ankit Agrawal <ankita@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Aniket Agashe <aniketa@nvidia.com>,
	Vikram Sethi <vsethi@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
	Matt Ochs <mochs@nvidia.com>,
	Shameer Kolothum <skolothumtho@nvidia.com>,
	"linmiaohe@huawei.com" <linmiaohe@huawei.com>,
	"nao.horiguchi@gmail.com" <nao.horiguchi@gmail.com>,
	"david@redhat.com" <david@redhat.com>,
	"lorenzo.stoakes@oracle.com" <lorenzo.stoakes@oracle.com>,
	"Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>,
	"vbabka@suse.cz" <vbabka@suse.cz>,
	"rppt@kernel.org" <rppt@kernel.org>,
	"surenb@google.com" <surenb@google.com>,
	"tony.luck@intel.com" <tony.luck@intel.com>,
	"bp@alien8.de" <bp@alien8.de>,
	"rafael@kernel.org" <rafael@kernel.org>,
	"guohanjun@huawei.com" <guohanjun@huawei.com>,
	"mchehab@kernel.org" <mchehab@kernel.org>,
	"lenb@kernel.org" <lenb@kernel.org>,
	"kevin.tian@intel.com" <kevin.tian@intel.com>,
	"alex@shazbot.org" <alex@shazbot.org>, Neo Jia <cjia@nvidia.com>,
	Kirti Wankhede <kwankhede@nvidia.com>,
	"Tarun Gupta (SW-GPU)" <targupta@nvidia.com>,
	Zhi Wang <zhiw@nvidia.com>, Dheeraj Nigam <dnigam@nvidia.com>,
	Krishnakant Jaju <kjaju@nvidia.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
	"ira.weiny@intel.com" <ira.weiny@intel.com>,
	"Smita.KoralahalliChannabasappa@amd.com" <Smita.KoralahalliChannabasappa@amd.com>,
	"u.kleine-koenig@baylibre.com" <u.kleine-koenig@baylibre.com>,
	"peterz@infradead.org" <peterz@infradead.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>
Subject: Re: [PATCH v4 2/3] mm: handle poisoning of pfn without struct pages
Message-ID: <aQjy0ZsVq7vhxtr7@tiehlicka>
References: <20251026141919.2261-1-ankita@nvidia.com>
 <20251026141919.2261-3-ankita@nvidia.com>
 <20251027172620.d764b8e0eab34abd427d7945@linux-foundation.org>
 <MW4PR12MB7213976611F767842380FB56B0FAA@MW4PR12MB7213.namprd12.prod.outlook.com>
 <aQRy4rafpvo-W-j6@tiehlicka>
 <SA1PR12MB71998D21DD1852EB074A11ABB0C6A@SA1PR12MB7199.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SA1PR12MB71998D21DD1852EB074A11ABB0C6A@SA1PR12MB7199.namprd12.prod.outlook.com>

On Sun 02-11-25 11:55:56, Ankit Agrawal wrote:
> >> >> +static void add_to_kill_pfn(struct task_struct *tsk,
> >> >> +                         struct vm_area_struct *vma,
> >> >> +                         struct list_head *to_kill,
> >> >> +                         unsigned long pfn)
> >> >> +{
> >> >> +     struct to_kill *tk;
> >> >> +
> >> >> +     tk = kmalloc(sizeof(*tk), GFP_ATOMIC);
> >> >> +     if (!tk)
> >> >> +             return;
> >> >
> >> > This is unfortunate.  GFP_ATOMIC is unreliable and we silently behave
> >> > as if it worked OK.
> >>
> >> Got it. I'll mark this as a failure case.
> >
> > why do you need to batch all processes and kill them at once? Can you
> > just kill one by one?
> 
> Hi Michal, I am trying to replicate what is being done today for non-PFNMAP
> memory failure in __add_to_kill
> (https://github.com/torvalds/linux/blob/master/mm/memory-failure.c#L376).
> For this series, I am inclined to keep it uniform.

Unless there is a very good reason for this code then I would rather not
rely on an atomic allocation. This just makes the behavior hard to
predict
-- 
Michal Hocko
SUSE Labs

