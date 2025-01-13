Return-Path: <linux-acpi+bounces-10578-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0267A0C342
	for <lists+linux-acpi@lfdr.de>; Mon, 13 Jan 2025 22:06:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72AEE7A266A
	for <lists+linux-acpi@lfdr.de>; Mon, 13 Jan 2025 21:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 641421D4618;
	Mon, 13 Jan 2025 21:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="I6jUSbyY"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2EDE1C1753
	for <linux-acpi@vger.kernel.org>; Mon, 13 Jan 2025 21:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736802397; cv=none; b=DKDjV72LjNSQxOe9p1DMmGQD3no08+Js4Q/2ZFUA69FJAXa7R8B+9SkxDuXugJhoOM7ZnIBGlUC5zZa4dllVmnO9K4tcAjyYAhHcRCw3K6EsQvy/1F+LbJ+pGuwJrc1imjbEHalTVyn92HAb4OJNAqYxTE56SXjsme2yRmTwnWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736802397; c=relaxed/simple;
	bh=gu871KrRKdMiRcl28PXlu15LrzNcXpBqKIqiPEVOCS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ggezhe096K4GpTvqA9HCKMHmjE7zk7LB8Cm5/k3+K3ugKzZnoWRtjK2+fG61VdY7RV+PqKqVuZ3QPQEvw/iuDehXZAgv3nU8ACWdQ0zpBRY1/2AQctQJ1A8JDOvOApk6a71EUZx6hUD8Aw7soG0O7bg7inCC3pilRUoqfJeJ0wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=I6jUSbyY; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7be3d681e74so112974185a.0
        for <linux-acpi@vger.kernel.org>; Mon, 13 Jan 2025 13:06:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1736802394; x=1737407194; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fL4j/w8tq5R6XuIWQMpvaEYTyys0cTNStMM/2ZIjtF0=;
        b=I6jUSbyYAI9d2PEieVto927LfIh/XeZ8u+9Esv5VAAJCpvRu+KE8/OPAz7PiiJmPPr
         1k2WOLWVvm5b3h8ZMOFCb6dpzhzY7ev1oFzxdMWcz0DKxZCMEHzxY+nGprB639DinIEG
         nC3YeRkPqDFEljvuWovWa7aDbDSBx87PccwdCRJtDOeSkvMYn139yrkgOQY4kFz1PbNW
         XhvHggkUZ1Iaet/uJpKqDavIyNPeG6/Y3tVVLbQx7HOpsJbzeng2qeGJVEzS9mUuTu03
         za4zP+MS+Klq/J8eRW8newTJduYCLab3nhWDDAbb43mWT5HYzu334iMAuXjhyGg3eVB/
         wojQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736802394; x=1737407194;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fL4j/w8tq5R6XuIWQMpvaEYTyys0cTNStMM/2ZIjtF0=;
        b=nGQ//8dcpd7FlOqXZ1p/fSuHY6/i1iWlaA1U8ciZ7/3Kj6uv7xAuKazQ2IGK59iRWZ
         ngW8XfzwbvtzelRMkumoZjueeyQSxKkrpEL/RtTq/6KA3CO9cGOZcm+1VijHpyPn9Eis
         0lQdLPnozoqFWQlIZ4Kj+y8Ok2pMhUuZvgC4/aok9JAc4336nVi0X/oN2M91M7b9HdHs
         QGGCRcp6C6o5AXaqJJiWgZlWDKzZDwljMRCaf8x1xwXypLwI1ZuFqBf6kb/7cohM7pER
         NZP8khvCrUccbL1u+J/0bctyQqN+HTSydyBlnYlsiwMtUPeWnX7/XCNIB4A9rx+3xJiN
         1yaA==
X-Forwarded-Encrypted: i=1; AJvYcCV4Gil12wU3vKafgwIJWH87YDzWfZpazAuN+fE5nAJYXAMUhvDVHTjW/YziCKOCYwx2l2ZW2IZq35WJ@vger.kernel.org
X-Gm-Message-State: AOJu0YyA3mtdP3i/PDnkIiKmhOmKSGIg1RSZDKteSR/vwh0DpML6spGW
	ToGKJ/Nf6flcC79V7oo8WF390hobCD8OyaRBd1+STGOPcqnNC7zWU0ReA2f3taw=
X-Gm-Gg: ASbGncvoNZtqnMybjqRp+LHa2fQcbUrR48tFXFya237Lga60vLg3XY8FPvZG8fQljrZ
	v5AVyJg/NGdPgdTq8FgDZ5SRW3XcfDTPvsumH9A2EVV2X+tA/PvZpUIzmngf44gAZ+aqNz5mVwO
	bT6TucrFNbb+KpjZ7xIKZrqlCbQF6f4YS8s2sv9SGjtSMFn/35ZLz+mVEU8IVkF6ZAxqreQ0qWQ
	z/p/MaFdncqHDaBhguAh8ym2dTRQGKLRD8M/HbKS+sP6BC9VsCq/G1nwKttOZ/BU04r4qg1kcz1
	WKWCyI4KGHoe3pQKRW/HYJcLtUrpjRmvhX/02rI=
X-Google-Smtp-Source: AGHT+IFvDKtyW7pef1s60emcEMo90F4I6tm7a6BiLDHui2qCMT1+1I2lQj7uSal1dcn+B7K4i/d7Dg==
X-Received: by 2002:a05:620a:404b:b0:7b6:d65a:d6ea with SMTP id af79cd13be357-7bcd97c3447mr3631054685a.46.1736802394709;
        Mon, 13 Jan 2025 13:06:34 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7bce3516004sm530440085a.101.2025.01.13.13.06.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 13:06:34 -0800 (PST)
Date: Mon, 13 Jan 2025 16:06:31 -0500
From: Gregory Price <gourry@gourry.net>
To: Ira Weiny <ira.weiny@intel.com>
Cc: linux-mm@kvack.org, linux-acpi@vger.kernel.org, kernel-team@meta.com,
	x86@kernel.org, linux-kernel@vger.kernel.org,
	dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
	rafael@kernel.org, lenb@kernel.org, david@redhat.com,
	osalvador@suse.de, gregkh@linuxfoundation.org,
	akpm@linux-foundation.org, dan.j.williams@intel.com,
	Jonathan.Cameron@huawei.com, alison.schofield@intel.com,
	rrichter@amd.com, rppt@kernel.org, bfaccini@nvidia.com,
	haibo1.xu@intel.com, dave.jiang@intel.com,
	Fan Ni <fan.ni@samsung.com>
Subject: Re: [RESEND v7 3/3] acpi,srat: give memory block size advice based
 on CFMWS alignment
Message-ID: <Z4WAV_xvz2ltbo4H@gourry-fedora-PF4VCD3F>
References: <20250113174439.1965168-1-gourry@gourry.net>
 <20250113174439.1965168-4-gourry@gourry.net>
 <67857eaa6e284_1863f329487@iweiny-mobl.notmuch>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67857eaa6e284_1863f329487@iweiny-mobl.notmuch>

On Mon, Jan 13, 2025 at 02:59:22PM -0600, Ira Weiny wrote:
> Gregory Price wrote:
> > +	/* Align memblock size to CFMW regions if possible */
> > +	align = 1UL << __ffs(start | end);
> > +	if (align >= SZ_256M) {
> > +		if (memory_block_advise_max_size(align) < 0)
> > +			pr_warn("CFMWS: memblock size advise failed\n");
> 
> I wonder if it would be good to print the return value here so the user
> knows why this failed?
> 

As someone who is often annoyed by this exact pattern, I am apparently
just as guilty at producing it *facepalm*

I'll pick this up and push it tomorrow.

> But either way.
> 
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> 
> > +	} else {
> > +		pr_err("CFMWS: [BIOS BUG] base/size alignment violates spec\n");
> > +	}
> > +
> >  	/*
> >  	 * The SRAT may have already described NUMA details for all,
> >  	 * or a portion of, this CFMWS HPA range. Extend the memblks
> > -- 
> > 2.47.1
> > 
> > 
> 
> 

