Return-Path: <linux-acpi+bounces-18487-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E5CFC308B3
	for <lists+linux-acpi@lfdr.de>; Tue, 04 Nov 2025 11:37:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A1C984E7A6A
	for <lists+linux-acpi@lfdr.de>; Tue,  4 Nov 2025 10:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0B782D6E53;
	Tue,  4 Nov 2025 10:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="O+WnJ9Ah"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199502BF3DB
	for <linux-acpi@vger.kernel.org>; Tue,  4 Nov 2025 10:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762252647; cv=none; b=A2PMPoARK/r4+TwAJoRDIkw2cWSMTyTIi8YaiZt6fmg+QLLpGMw//w0phuyuGDRguZBzl25UzOrvIB+DCoujxO2rbX6tc9Tm7XFvCOYna9bNQHhHOaI57b+eZQDdisI9io/8LXltIod8xY5YFAGkCg6t0vG3doYI55H9RwpUETM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762252647; c=relaxed/simple;
	bh=v8zG2e4TYh8HI28N1gaia3u1IQr0AA8J+GRTSgdfhoE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cPeZAxcZkgooNBzhuwzPMjWWNjtr9CkY+jmr7jH3b2OA0moiba9uezARclwOSp38xZt5jzxP8EUW6XtW9tHPsZt763pzqsu0fiRyLFbqW+B1XOdk8y9pe7VHAzAKWUXpeYgqYSxO3bqp4V/EnHoGDYduO0LoMOSZI1uyJmZXaPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=O+WnJ9Ah; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-47758595eecso1859495e9.0
        for <linux-acpi@vger.kernel.org>; Tue, 04 Nov 2025 02:37:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762252643; x=1762857443; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+Ne4ZDSlj913IS0afaCeah9/sHQf3Ytf7YNZFUi1jMY=;
        b=O+WnJ9Ah2VyHBrkKQlkZBmZ1Qre3JWPRNTix2PP2ii8vPWhScYQSmtVfTcLkCQOip2
         PSBRr6b2d997dBR9BswZ9xNtmlWB3ketx8y54bEKb/iu+kCtP1Vd2ta9u52Hq6z6ughD
         1B3yWUMwhbeiV5pA82MhkvOfkDWLKTDcq5GeH7YTJeSSh+v7UC2VDX4PS0DOQ/lc0/8i
         VI3GHV4tfPPSbHQU01cFGypkgSl9UmweoznFO7xnzhKx+SSA3PnnyBqyIh2M1VFB2y4B
         sh7BfPQLX/uy9qtrTpdW7yhRSp2jeQNwTCcmLoxQoihKN9+o3yzrAQpDiLtXgjkcz4md
         t++A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762252643; x=1762857443;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Ne4ZDSlj913IS0afaCeah9/sHQf3Ytf7YNZFUi1jMY=;
        b=U8mrVfFNKx7JciSGyUy3tg0waKs48X2FdY6je3aJ+6eGwdvfC0/p+kg1LtLya9w7pl
         BqdpdgykEFYIfUgXm2KVrUriUCMRBbjackSq34ufI5ICM9M6ll/lIZqkOyKvaKnLfGWR
         4cY3xK3PZ0P8NbYeku/Mxv2a4QuStAB7myomt4/mUlQeA3f72taYZ+OoerjFsoxH56Pa
         wbrroE6LwTSn70laZpdGnH9O94NoKj/rAUxmOEtwF+oozwBP4fBTmSeujOxVR3tClKGd
         AYztKTN0SxllNE0GQi9tVGE1oc2AoQ4GBMbLrWp8sIFGDOVWRJZII3jH3QK1nk92W6R6
         V2iw==
X-Forwarded-Encrypted: i=1; AJvYcCWa+8eQjvfjYJqtDbZkZUzAb+wrGWNSvUWWTRHy54a3q2y3lj1BeBrWPtn53onz4lNvn5S4ablPJJCp@vger.kernel.org
X-Gm-Message-State: AOJu0YxJA0p3ic9wzF/WCTwGcKoTJn83YqshAK7JDHaLdzCWc5BaBWKi
	asjoW3uikhhT7LCwNRSFachIXqH3x2lDrmbHjLDFVKs45R1bjK3ENTq611uXhullgF0=
X-Gm-Gg: ASbGncvIqAQHupmvGlxwKGfmnXakkkNurNaSb7dmvdkBtbk9JJMI25LA+mgF/MN9XtL
	aayNC7iu+XP20+As6gFoNAgSUN7YHiNdh5dva8rktHq6hw823zUXDjvOSlRCD52KP16eXvXyU9g
	oPIJswPTw1KcoVodlE5vOAzdad21OcbFLz/1+XT1P2cFn/1MnhxvGWXV/suWDsUV4B8D24GEPos
	7IK2P1V/jTXcfz+BLpCF4XgHpizBZ3+vKthlU9PUTaX4D+3j6DcjGi1W8OlrD58b6lH32nZILcJ
	cs9CZe0l2Droe0ezvjBmBb/AV5FYUQVSbucgGvupV9LIMBUvP4IcNqoUJKJ7hoqH4cit0Xr6c8j
	RSyHWo4htt+lnOGpg8C5ZSfmXYp0gLM/10/Dt8lPvJ1Lpu8rIdcuCKp7hKDVpClaHJueE8ishH9
	0aN8pRNBeR
X-Google-Smtp-Source: AGHT+IFf1wOTlsdo8GWYHh8jAMEFl3Fd6ZMSKUjEHUzMaQyfhIP4OVI40+a/WDrXsXYVLl3vLVN/Zg==
X-Received: by 2002:a05:600d:4390:b0:477:333a:f71f with SMTP id 5b1f17b1804b1-477333af9f8mr83874795e9.17.1762252643284;
        Tue, 04 Nov 2025 02:37:23 -0800 (PST)
Received: from localhost (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429dc1f5be4sm3680221f8f.31.2025.11.04.02.37.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 02:37:22 -0800 (PST)
Date: Tue, 4 Nov 2025 11:37:22 +0100
From: Michal Hocko <mhocko@suse.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Ankit Agrawal <ankita@nvidia.com>, Aniket Agashe <aniketa@nvidia.com>,
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
Message-ID: <aQnXYsPR7zkV_ram@tiehlicka>
References: <20251026141919.2261-1-ankita@nvidia.com>
 <20251026141919.2261-3-ankita@nvidia.com>
 <20251027172620.d764b8e0eab34abd427d7945@linux-foundation.org>
 <MW4PR12MB7213976611F767842380FB56B0FAA@MW4PR12MB7213.namprd12.prod.outlook.com>
 <aQRy4rafpvo-W-j6@tiehlicka>
 <SA1PR12MB71998D21DD1852EB074A11ABB0C6A@SA1PR12MB7199.namprd12.prod.outlook.com>
 <aQjy0ZsVq7vhxtr7@tiehlicka>
 <20251103185226.fea151c58ce7077b11b106aa@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251103185226.fea151c58ce7077b11b106aa@linux-foundation.org>

On Mon 03-11-25 18:52:26, Andrew Morton wrote:
> On Mon, 3 Nov 2025 19:22:09 +0100 Michal Hocko <mhocko@suse.com> wrote:
> 
> > > Hi Michal, I am trying to replicate what is being done today for non-PFNMAP
> > > memory failure in __add_to_kill
> > > (https://github.com/torvalds/linux/blob/master/mm/memory-failure.c#L376).
> > > For this series, I am inclined to keep it uniform.
> > 
> > Unless there is a very good reason for this code then I would rather not
> > rely on an atomic allocation. This just makes the behavior hard to
> > predict
> 
> I don't think this was addressed in the v5 series.
> 
> Yes please, anything we can do to avoid GFP_ATOMIC makes the kernel
> more reliable.

This could be done on top of the series because as such this is not a
blocker but it would be really great if we can stop copying a bad code
and rather get rid of it also in other poisoning code.

-- 
Michal Hocko
SUSE Labs

