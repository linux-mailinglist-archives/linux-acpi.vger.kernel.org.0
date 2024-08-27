Return-Path: <linux-acpi+bounces-7873-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA9A3960DAD
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Aug 2024 16:33:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90432283CF5
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Aug 2024 14:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 177901BD000;
	Tue, 27 Aug 2024 14:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="cg5iT+RO"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4960E1C463D
	for <linux-acpi@vger.kernel.org>; Tue, 27 Aug 2024 14:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724769210; cv=none; b=uTZSP7ca0fdGvxoSULPhL8fwzMLYV9GOomj44ZPrsiNQYL3FPW39/yUFms8wVZaefzzIYoQAp1gX2DGD/3RSQJrys11zto5haHU9/8l3XJ9Jxcd0eU4IxKxVyYhe3LSU5qlMEpLL4rNCeD78T9206EP1ukkIrrKIN/EgfjbLOuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724769210; c=relaxed/simple;
	bh=XgSSzQjTyWSgw6pwE8wq/DXxuhPA18VKKPNiNNYbWN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NOoxbOeKR2npXVGyJz+NfuoP84RcUg+VspiifnNy5MuUVoezk3pU44ofVgQD45rJnuPm0o5PpbYP8HCGx3edWnzcf3TRN8fMYlxm7JhGU4fQMQfL3/7uP2z4wWY2nUCGM8PNPp5PiGNtzPiuLHAmdI3+sKvhYNIys+im5/XDOvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=cg5iT+RO; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7a1d42da3f7so351451385a.2
        for <linux-acpi@vger.kernel.org>; Tue, 27 Aug 2024 07:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1724769207; x=1725374007; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+Dq5eF/XsL5U484uJ6bc88SWqR2YGU4Cny8CFhxIKzo=;
        b=cg5iT+ROqwZTWd3jj6nr/cj7XoQrm+FCI99f7is37mBUkXZAGokch6NmA8fkZ9LgVQ
         H6N65dnBhiiPYc0Sosdjfcux2EiaKC+8n5Ucwj3lVQNeFlpt2WQxT33HANMTkVbGgfyb
         W56OwECzJEoGrLzRij4Bm3yF6pTa/slo3L4h8UwoQJLXACT/OECpjgEz+WU48nff/GPh
         L5CZGA+kBMb1pwzj911oeRFWw54Vx3jq8sWdqi2+pQwIRYxN1bE5zXY3qQMKqiIk+QxV
         5lXHisx+YJWzcXK/CDGkPCUxIJbB+nTBryvpAWWW9uUzrMpaNPJgvGmiEGvD+DGuQTdq
         90sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724769207; x=1725374007;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Dq5eF/XsL5U484uJ6bc88SWqR2YGU4Cny8CFhxIKzo=;
        b=nk9rXVsr/pYWgLfJcUXbX0vceWmAWTqMvGTuDRiYt2kB0Pf9ngtVrBGFI9kWkkWzx4
         f1FtAYXp7xcC5t0hsLaYSHpfceSYFVxFT/8xvIKkfgC4kMhdHw3iveOo7vdk/ZqOpINK
         8pdovqXzmPY8XW0LN4szaDWu5dAGE3nXsPKtMfP+FfD2hTtoCEf+YNsJ9LsiwsMoiht1
         L4J3SEAqOeUNsO0uvrHaNthvKT0zi5zWsDetktKjJW7mnSC3imtjtzH/apKo16UpvR8z
         aRWyjExObg2oLWUazCrQolRfENyGM8GI9k6Rafxb2TRu68C/vttOIBYfp1DzWKJTRMm2
         qUqw==
X-Forwarded-Encrypted: i=1; AJvYcCVCHBVRccZGIC/Jy/1QKQHiD0EqOO/mL5POIAsPC2aRdpVM7m/l9HbHQUd5VPbVPZfZoZSdBqlNBvrv@vger.kernel.org
X-Gm-Message-State: AOJu0Yxa5XI9XlsiVjgx3aiHvOg1/1t6dWchth8D0TTsc8OAgsDlJVAB
	I3YjUQLUMc0tKHEiH8cxN4Dyj4WJ02WQ98vv+X2tNp2AKzEpE6Cvbz5Zxu2ZOOU=
X-Google-Smtp-Source: AGHT+IGtIv7TpBgdDKjZNm9QnhlOd66rvRaYjffVV4m+LJZAP1dws1Vh+HS6qGaGUoaINi87yCl2EQ==
X-Received: by 2002:a05:620a:1906:b0:7a3:5fa3:328 with SMTP id af79cd13be357-7a6897acc71mr1674517285a.54.1724769207016;
        Tue, 27 Aug 2024 07:33:27 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a67f3bb523sm555884785a.95.2024.08.27.07.33.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 07:33:26 -0700 (PDT)
Date: Tue, 27 Aug 2024 10:33:12 -0400
From: Gregory Price <gourry@gourry.net>
To: "Huang, Ying" <ying.huang@intel.com>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, dave.jiang@intel.com,
	Jonathan.Cameron@huawei.com, horenchuang@bytedance.com,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	dan.j.williams@intel.com, lenb@kernel.org,
	"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: Re: [PATCH] acpi/hmat,mm/memtier: always register hmat adist
 calculation callback
Message-ID: <Zs3jqGe8IXHT499B@PC2K9PVX.TheFacebook.com>
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
> >
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

Worth noting:  This feature was removed
https://lore.kernel.org/all/20240620073205.1543145-1-ardb+git@google.com/

So I cannot even use this to manage it.

~Gregory

