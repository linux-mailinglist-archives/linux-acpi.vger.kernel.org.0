Return-Path: <linux-acpi+bounces-18393-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AB82BC23D0E
	for <lists+linux-acpi@lfdr.de>; Fri, 31 Oct 2025 09:31:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3F9364F5DFD
	for <lists+linux-acpi@lfdr.de>; Fri, 31 Oct 2025 08:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCB082F3C25;
	Fri, 31 Oct 2025 08:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TA+HBQ3k"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5A72EF65B
	for <linux-acpi@vger.kernel.org>; Fri, 31 Oct 2025 08:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761899245; cv=none; b=JxsPqvSZ9uJhciWJ776JuyqdtE6ygZ89W9t8ZZbT5vExlaZ4w/rJZ2Y/Pnh3FIU7WjbCaSrXto7TxiwnOS8BkPoNJo+zTdiKfHBTdWB8LmN3VUJbQKkJFFn5NzvDiPUMX1aj6JOcHlKeSgc/COGpTvl4D8S2Zcga1dSmYeF/tuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761899245; c=relaxed/simple;
	bh=lVQsmI/OgcGtefcLtFfLf1leQyCYm0kn4f7Js5h7gO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YdxpKVxmX+7wa5YaJaWhSg3woQYsEA+A/potGvMCkv6yb6xkuyOZBdtVPwjHknqGV34HZfV/b2VsVBjPv8g/qtSlaj6OoxaWAWXwGLqIf39jRMZ9VkFcUW0gQUF90pKw/V35Wh8+PO4hj5U0eULmeqy9j5hNc4P4BXg98B8rIgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=TA+HBQ3k; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-429bccca1e8so547478f8f.0
        for <linux-acpi@vger.kernel.org>; Fri, 31 Oct 2025 01:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1761899242; x=1762504042; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=i/fYaZtBikFS6oNzHl/Bdj60BD7iQqSjLDzNr7ZdDK4=;
        b=TA+HBQ3kNS+7xiiif6xKFcAkfcAzM88y0Sf58DeYTRQoQGJdQPXMGZyHs6lTbBCxZP
         lbhMmmkg1R1ADgijncgEzu2XrFXDcIInDZbeY5ULZdx8d8NlK2sos//XKSNgSRRAWvvi
         yNb6AyLC+OKnkGfefh2/Ef6qd6S27sBkqjzWP1Jz9k2PMq18ukyoY7Yp/Srt4WOdbsOf
         xQCJ6oJ43kLilMjK2QHuETkDtYl3eu7z0Va2N6JTTiFbd7hiEbYrnqE0x1ckURea6zzL
         e2hu0CpGvSb3luhJ4HFxzuxB1SKaffBjTBbmLFoUg0asMJBQ1IYDH5V2ZsnPsHjNUI+E
         0T/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761899242; x=1762504042;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i/fYaZtBikFS6oNzHl/Bdj60BD7iQqSjLDzNr7ZdDK4=;
        b=FOSInajAAoDf1KGXfwQj5dNwWtrVMgkWaDs9NFZfREJCbMa4/3nlKgEEWuZIhXoCMT
         bwm1WdUM83BIdOq3DbGeSagBzf/RWesv1wrcNup5UH6ZYsaTAHG8FwUW0YpltJaSQji4
         gLVMl3WAFV+hnp47DPLgQuecl3Zy9zwB4OOnTwh1gNYhor/WW1kDk+kXkLGvFngBaWHH
         s9IGgcOzzFVoDGDfTn+ZMiTGPvcHr/8THFjAEQ8+Jj7mnkcS6KQCwql0c457fZ9U0LnY
         etccK4KOhdgB7Y89dymOsC8pNCxe5k8Xh5U0vu1veVfCHIfdgy8S4R6LllQ02bII5KlM
         gozQ==
X-Forwarded-Encrypted: i=1; AJvYcCVRH5AzTiCA8tOIoEa8dxESiy6HH0KizqSA9WqWxghwUuwwLMO/yWwhj51Uge7/JU5VP6ZoS760XaUH@vger.kernel.org
X-Gm-Message-State: AOJu0YwiAhMiYEPEQPu7AxTaurKITxwnEaV97004TxdNl4EqCbPLB0Hr
	X5VBAcIoRNqqd4f789q2QCFWWhfxDNcZCcDAr8qPDAovonBzuJjnluyyRSgIiYgRMf4=
X-Gm-Gg: ASbGncuT5bywdtTSfq2zVKezZWgE9Q8fmnl3lPRONE3Hi9SaWOveiFmMJ3OBFFWRDYh
	OFTAqfWJn+/nXGw/PiVGoYz72FYeEkCwy1B5g3U3QCGQdQioto6HjM4yR8eE4xQ7xC7K1S27w2m
	4rHUyvnvBadCPHzkNtq72tg46tyJvFxdS04CzBDmw2xm2zC+/OsWxkit+nD9WiWZ5RU9UE1MtBM
	WU3d80yJAdqQmq5omaNt0+rV3YftypET2KXlQmBAVdwriypIdp/WPhbP3Q02zYkBjueClw7EO4W
	DalCbY4qynbxyFXPwcOABEgJVdgTU2LFcd6HlQ3zw198w+9Y9MV3y4U1HJjecm0WNkHHKUXsF7a
	uRnXDUJIGWDaoThL3LvBOI1S+zs33go5F5EpfzVVdUVtFjsfRmUgaj3i9oyNtW437zDiW6U+Ozs
	Hpnlj1brq6wyYBHZAeVrBsp0Ij
X-Google-Smtp-Source: AGHT+IFSgi5NgEp0bWNzIHDj0wUEorxSLRV/wRdPuexvpAZjr+shE6+j17OmyoRsqSiC8CijMQFTMA==
X-Received: by 2002:a05:6000:26c5:b0:427:580:99a7 with SMTP id ffacd0b85a97d-429bd6b222dmr2082292f8f.59.1761899241764;
        Fri, 31 Oct 2025 01:27:21 -0700 (PDT)
Received: from localhost (109-81-31-109.rct.o2.cz. [109.81.31.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429c1142e7dsm2242752f8f.17.2025.10.31.01.27.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 01:27:21 -0700 (PDT)
Date: Fri, 31 Oct 2025 09:27:14 +0100
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
Message-ID: <aQRy4rafpvo-W-j6@tiehlicka>
References: <20251026141919.2261-1-ankita@nvidia.com>
 <20251026141919.2261-3-ankita@nvidia.com>
 <20251027172620.d764b8e0eab34abd427d7945@linux-foundation.org>
 <MW4PR12MB7213976611F767842380FB56B0FAA@MW4PR12MB7213.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <MW4PR12MB7213976611F767842380FB56B0FAA@MW4PR12MB7213.namprd12.prod.outlook.com>

On Wed 29-10-25 03:15:08, Ankit Agrawal wrote:
> >> +static void add_to_kill_pfn(struct task_struct *tsk,
> >> +                         struct vm_area_struct *vma,
> >> +                         struct list_head *to_kill,
> >> +                         unsigned long pfn)
> >> +{
> >> +     struct to_kill *tk;
> >> +
> >> +     tk = kmalloc(sizeof(*tk), GFP_ATOMIC);
> >> +     if (!tk)
> >> +             return;
> >
> > This is unfortunate.  GFP_ATOMIC is unreliable and we silently behave
> > as if it worked OK.
> 
> Got it. I'll mark this as a failure case.

why do you need to batch all processes and kill them at once? Can you
just kill one by one?
-- 
Michal Hocko
SUSE Labs

